#!/usr/bin/python3
"""
-------------------------------------------------
   File Name：     discovery_process
   Description :
   Author :       thsheep
   date：          2019/2/19
-------------------------------------------------
   Change Activity:
                   2019/2/19:
-------------------------------------------------
"""
__author__ = 'thsheep'

import psutil
from copy import copy
from pprint import pprint


def return_process_top10():
    return_dict = {}
    for process in psutil.process_iter(attrs=['name', 'memory_percent']):
        name = process.info['name']
        memory_percent = round(process.info['memory_percent'], 2) if process.info['memory_percent'] else None
        if name in return_dict and memory_percent:
            return_dict[name] += memory_percent
        elif memory_percent:
            return_dict[name] = memory_percent
    else:
        temp_list = sorted(return_dict.items(), key=lambda item: item[1], reverse=True)
        data = []
        for temp in temp_list[:9]:
            data.append(copy({"{#PROCESS_NAME}": temp[0]}))
        return {"data": data}


if __name__ == '__main__':
    pprint(return_process_top10())