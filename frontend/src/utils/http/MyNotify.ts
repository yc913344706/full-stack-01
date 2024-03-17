import { ElMessage } from 'element-plus';

export const notify_user_by_resp = (resp: any, success_str: string, need_success_feedback: boolean | undefined = true): boolean => {
    if (resp.res === 200) {
        if (need_success_feedback) {
            ElMessage({
                message: success_str,
                type: 'success',
            });
        }
        return true;
    } else {
        console.error(resp);
        ElMessage.error(resp.msg);
        return false;
    }
};
