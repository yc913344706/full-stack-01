import json

from django.core.paginator import Paginator
from django.http import QueryDict, JsonResponse, HttpResponse
from django.urls import resolve
from schema import Schema, Use

from lib.log import color_logger


def pub_get_request_body(request):
    content_type = request.headers.get("Content-Type")
    request_data = None
    try:
        if request.method == "GET":
            request_data = request.GET
        else:
            content_type_list = content_type.split(";")
            if "application/json" in content_type_list:
                try:
                    request_data = json.loads(request.body.decode())
                except Exception as e:
                    raise Exception(f"json解析请求body异常：{type(e)}: {e.args}")
            elif request.method == 'POST':
                try:
                    request_data = json.loads(request.body.decode())
                except Exception:
                    request_data = request.POST
            else:
                request_data = QueryDict(request.body)
    except Exception as e:
        color_logger.error(f'所有请求预处理报错：{type(e)}: {e.args}')

    if isinstance(request_data, QueryDict):
        x_copy = QueryDict('', mutable=True)
        x_copy.update(request_data)
        request_data = x_copy

    for k, v in request_data.items():
        if v is None:
            continue

        if type(v) != str:
            continue

        request_data[k] = v.strip()

        # if len(v) == 0:
        #     request_data[k] = None
        #     continue

        # try:
        #     v = int(v)
        #     request_data[k] = v
        # except Exception as e:
        #     color_logger.debug(f'预处理requests错误。{type(e)}{e.args}')
        #     pass

    return request_data


def pub_value_bool_check(param, default_value=True):
    """
    true/false => True/False
    """
    if param is None:
        return False

    if isinstance(param, str):
        if param == "null":
            return None
        try:
            a = float(param)
            return bool(a)
        except Exception:
            pass

    if isinstance(param, float):
        return bool(param)

    if isinstance(param, bool):
        return param

    if str(param) in ['False', 'false']:
        return False

    if str(param) in ['True', 'true']:
        return True

    if default_value is not None:
        return default_value

    else:
        raise Exception(f"无法识别该 bool 类型值: {param}")


def pub_success_response(data=None):
    res_dict = {
        'res': 200, 'msg': 'success', 'result': '' if data is None else data
    }

    return JsonResponse(res_dict)


def pub_int_check(status, error_msg=None):
    """int类型检查"""
    error_msg = '参数类型异常，不支持非int类型!' if not error_msg else error_msg
    int_check = Schema(Use(int), error=error_msg)
    return int_check.validate(status)


def pub_str_check(value, value_name):
    """int类型检查"""
    assert value is not None, f"{value_name} 为空"
    value = str(value)
    assert len(value) > 0, f'{value_name} 长度应大于0'
    return value


def pub_error_response(res_code, data=None, status_code=200, msg="failed"):
    res_dict = {
        'res': res_code,
        'msg': msg,
        'result': '' if data is None else data
    }

    return JsonResponse(res_dict,
                        status=status_code)


def pub_paging_tool(pid, msg_obj: object, page_size=20):
    """查询分页"""

    def _get_page_list(all_page, thi_pid, list_num=5):
        if all_page <= list_num:
            return [i for i in range(1, all_page + 1)]
        list_mid_page = str(round(list_num / 2, 1))
        list_mid_page = int(list_mid_page[0]) + 1
        if all_page - thi_pid <= list_mid_page:
            return [i for i in range(all_page - list_num + 1, all_page + 1)]
        else:
            start_num = thi_pid - list_mid_page
            if start_num < 1:
                start_num = 1
            end_num = start_num + list_num

            return [i for i in range(start_num, end_num)]
    msg_obj = Paginator(msg_obj, page_size)
    all_num = msg_obj.count  # 数据总量
    num_pages = msg_obj.num_pages  # 分页总数
    if pid > num_pages:
        pid = num_pages
    msg_obj = msg_obj.page(pid)
    page_list = _get_page_list(num_pages, pid)
    is_next = msg_obj.has_next()
    next_page = pid
    if is_next:
        next_page = msg_obj.next_page_number()
    # 返回下一页布尔值,下一页页码,当前显示页码列表,数据总量,分页后数据
    return is_next, next_page, page_list, all_num, msg_obj



