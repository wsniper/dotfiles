#!/usr/bin/env python
# coding: utf-8

vimrc ='vimrc'
doc = 'vimrc-document.md'

def write(line, history=[]):
    if line.startswith('Plugin'):
        line = '\n\t\t%s\n' % line
    #if not is_code(line):
        #line = line.replace('<', '&lt;').replace('>', '&gt;')
    line = line.replace('\t', ' '*4)
    history.append(line)
    f.write(line)


def is_code(line):
    fetures = ['\t', ' '*4, '`', ]
    for fet in fetures:
        if fet in line:
            return True
    return False


with open(vimrc, 'r') as input:
    with open(doc, 'w') as output:
        global f
        f = output
        for line in input:
            line = line.lstrip()
            if line[:2] == '" ':
                line = line[2:]
                if 'End' in line:
                    continue

                if not line.strip():
                    write('\n')
                elif '===' in line:
                    line = line.replace('=', '').lstrip()
                    if len(line) > 1:
                        line = '\n### %s\n' % line
                    else:
                        continue
                    write(line)
                else:
                    line = line.strip()
                    # remove comment
                    if line.startswith('//'):
                        continue
                    if line.startswith('Plugin'):
                        line = '- `%s`\n' % line
                    elif line[0] == '|':
                        line = '- `%s`\n' % line
                    else:
                        line = '- `%s`\n' % line
                    write(line)
            elif line.startswith('Plugin'):
                write(line)
