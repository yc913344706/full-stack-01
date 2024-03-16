import type { App } from 'vue';

import { createRouter, createWebHistory } from 'vue-router';

export const setupRouter = (app: App<Element>) => {
    app.use(
        createRouter({
            // 路由器的工作模式
            history: createWebHistory(),
            routes: [
                {
                    name: 'layout',
                    path: '/',
                    component: () => import('@/views/Layout.vue'),
                    children: [
                        {
                            name: 'home',
                            path: '/',
                            component: () => import('@/views/Home.vue'),
                        },
                    ],
                },
            ],
        })
    );
};
