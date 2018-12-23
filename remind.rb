#! /usr/bin/env ruby

require "time"

def print_s(s)
  h = s / (60 * 60)
  s = s % (60 * 60)
  m = s / 60
  s = s % 60
  hh = ""
  mm = ""
  ss = ""
  hh = "#{h} h" if h > 0
  mm = "#{m} min" if m > 0
  ss = "#{s} s" if s > 0
  [hh, mm, ss].join(" ").sub(/ +/, ' ').sub(/^ */, '').sub(/ *$/, '')
end

def print_time(s)
  (Time.now() + s).strftime("%H:%M")
end

def from_hm(h, m)
  t = Time.now
  m = 0 if m.nil?
  tt = Time.local(t.year, t.month, t.day, h, m)
  tt += 60 * 60 * 24 if tt < t
  (tt - t).ceil
end

def from_m(m)
  t = Time.now
  tt = Time.local(t.year, t.month, t.day, t.hour, m)
  tt += 60 * 60 if tt < t
  (tt - t).ceil
end

def parse_as_time(s)
  case s
  when /^([0-9]+)m?$/
    Integer($1) * 60
  when /^([0-9]+)s$/
    Integer($1)
  when /^([0-9]+)h$/
    Integer($1) * 60 * 60
  when /^([0-9]+)h([0-9]+)m?$/
    Integer($1) * 60 * 60 + Integer($2) * 60
  when /^([0-9]+)m([0-9]+)s?$/
    Integer($1) * 60 + Integer($2)
  when /^([0-9]+)h([0-9]+)m([0-9]+)s?$/
    Integer($1) * 60 * 60 + Integer($2) * 60 + Integer($3)
  when /^((?:[01][0-9])|(?:2[0-3])):$/
    from_hm(Integer($1), nil)
  when /^:([0-5][0-9])$/
    from_m(Integer($1))
  when /^((?:0?[0-9])|(?:1[0-9])|(?:2[0-3])):([0-5][0-9])$/
    from_hm(Integer($1), Integer($2))
  else
    nil
  end
end

def get_reminder(args)
  if args.empty?
    [nil, nil]
  else
    x = parse_as_time(args.first)
    if x.nil?
      y = parse_as_time(args.last)
      if y.nil?
        [nil, nil]
      else
        [y, args[0..args.count-2].join(" ")]
      end
    else
      [x, args[1..args.count-1].join(" ")]
    end
  end
end

def set_reminder(s, text)
  t = (Time.now() + s).strftime("%d/%m/%Y %H:%M")
  cmd =
    "osascript -e \"set theDate to date \\\"#{t}\\\"\" " +
    "-e \"tell application \\\"Reminders\\\"\" " +
    "-e \"tell list \\\"Reminders\\\"\" -e \"make new reminder with " +
    " properties {name:\\\"#{text}\\\" as string, remind me date:theDate}\" " +
    "-e \"end tell\" -e \"end tell\" "
  `#{cmd}`
  puts(
    "Reminding \"#{text}\" in #{print_s(s)}, at #{print_time(s)}.")
end

def main
  s, text = get_reminder(ARGV)
  if s.nil?
    puts("Could not parse reminder.")
  else
    set_reminder(s, text)
  end
end

if __FILE__ == $0
  main
end
