from optparse import OptionParser, OptionGroup
import json
import time

parser = OptionParser()

group = OptionGroup(parser, "",
                    "")

parser.add_option_group(group)

group = OptionGroup(parser, "semgrep scan check",
                    "check semgrep"
                    )
group.add_option("--file",
                 help="input scanner output file path",
                 action="store")

group.add_option("-r", "--high",
                 help="Numbers of issue",
                 action="store")

group.add_option("-m", "--medium",
                 help="Numbers of issue",
                 action="store")

(args, _) = parser.parse_args()

with open(args.file) as f:
  data = json.load(f)

result = data['results']
count = []
for r in result:
  d = r['extra']['severity']
  count.append(d)

total_vuln = len(count)

if int(total_vuln) >= int(args.high):
  fail = "FAILURE"
  print("Coz total high Vulnerability", total_vuln)
elif int(total_vuln) >= int(args.medium):
  fail = "FAILURE"
  print("Coz total Medium Vulnerability", total_vuln)
else:
  fail = "SUCCESS"
  print("Test Passed")
print(fail)