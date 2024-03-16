
interface BackendServerConfig {
    [key:string]: any
}

export const backendServerConfig: BackendServerConfig = {
    dev: {
        baseURL: 'http://127.0.0.1:8000', // 请求基础地址,可根据环境自定义
    },

    useTokenAuthorization: true, // 是否开启 token 认证

    // 软件相关
    url: {
        demo: {
            demoTxt: '/api/v1/demo/demo_txt',
        },
    },

    defaultPageSize: 10,
    allowPageSizes: [10, 50, 100, 1000],
};
