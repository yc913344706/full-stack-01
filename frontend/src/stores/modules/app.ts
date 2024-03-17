declare type LayoutType = 'classic' | 'topLeft' | 'top' | 'cutMenu';
declare const componentSizes: readonly ['', 'default', 'small', 'large'];
declare type ComponentSize = (typeof componentSizes)[number];
declare const componentSizeMap: {
    readonly large: 40;
    readonly default: 32;
    readonly small: 24;
};
declare interface ThemeTypes {
    elColorPrimary: string;
    leftMenuBorderColor: string;
    elContainerBgColor: string;
    elMainBgColor: string;
    leftMenuBgColor: string;
    leftMenuBgLightColor: string;
    leftMenuBgActiveColor: string;
    leftMenuCollapseBgActiveColor: string;
    leftMenuTextColor: string;
    leftMenuTextActiveColor: string;
    logoTitleTextColor: string;
    logoBorderColor: string;
    topHeaderBgColor: string;
    topHeaderTextColor: string;
    topHeaderHoverColor: string;
    topToolBorderColor: string;
}

interface MenuState {
    collapse: boolean;
    uniqueOpened: boolean;
    fixedMenu: boolean;
    topHeightN: number;
    defaultActivateKey: string;
    activateKeyPath: string[];
}

interface AppState {
    breadcrumb: Ref<boolean>;
    menuState: Ref<MenuState>;
    breadcrumbIcon: Ref<boolean>;
    hamburger: Ref<boolean>;
    screenfull: Ref<boolean>;
    size: Ref<boolean>;
    locale: Ref<boolean>;
    tagsView: Ref<boolean>;
    logo: Ref<boolean>;
    fixedHeader: Ref<boolean>;
    greyMode: Ref<boolean>;
    pageLoading: Ref<boolean>;
    layout: Ref<LayoutType>;
    title: Ref<string>;
    isDark: Ref<boolean>;
    currentSize: Ref<ComponentSize>;
    sizeMap: Ref<ComponentSize[]>;
    mobile: Ref<boolean>;
    footer: Ref<boolean>;
    theme: Ref<ThemeTypes>;
    tagsViewIcon: Ref<boolean>;
    dynamicRouter: Ref<boolean>;
    serverDynamicRouter: Ref<boolean>;
}

import { defineStore } from 'pinia';
import { Ref, ref } from 'vue';

export const useAppStore = defineStore(
    'app',
    (): AppState => {
        return {
            title: ref(import.meta.env.VITE_APP_TITLE), // 标题
            sizeMap: ref(['default', 'large', 'small']),
            mobile: ref(false), // 是否是移动端
            pageLoading: ref(false), // 路由跳转loading
            breadcrumb: ref(true), // 面包屑
            breadcrumbIcon: ref(true), // 面包屑图标
            menuState: ref({
                // 菜单状态
                collapse: true, // 折叠菜单
                uniqueOpened: false, // 是否只保持一个子菜单的展开
                fixedMenu: false, // 是否固定菜单
                topHeightN: 0, // 顶部菜单尺寸系数: https://antdv.com/components/layout-cn
                defaultActivateKey: '1-1',
                activateKeyPath: ['1', '1-1'],
            }),
            hamburger: ref(true), // 折叠图标
            screenfull: ref(true), // 全屏图标
            size: ref(true), // 尺寸图标
            locale: ref(true), // 多语言图标
            tagsView: ref(true), // 标签页
            tagsViewIcon: ref(true), // 是否显示标签图标
            logo: ref(true), // logo
            fixedHeader: ref(true), // 固定toolheader
            footer: ref(true), // 显示页脚
            greyMode: ref(false), // 是否开始灰色模式，用于特殊悼念日
            dynamicRouter: ref(true), // 是否动态路由
            serverDynamicRouter: ref(true), // 是否服务端渲染动态路由

            layout: ref('classic'), // layout布局
            isDark: ref(true), // 是否是暗黑模式
            currentSize: ref('default'), // 组件尺寸
            theme: ref({
                // 主题色
                elColorPrimary: '#409eff',
                // el-container的背景色
                elContainerBgColor: '#f5f7f9',
                // el-main的背景色
                elMainBgColor: '#fff',
                // 左侧菜单边框颜色
                leftMenuBorderColor: 'inherit',
                // 左侧菜单背景颜色
                leftMenuBgColor: '#001529',
                // 左侧菜单浅色背景颜色
                leftMenuBgLightColor: '#0f2438',
                // 左侧菜单选中背景颜色
                // leftMenuBgActiveColor: '#ecf5ff',
                leftMenuBgActiveColor: 'var(--el-color-primary)',
                // 左侧菜单收起选中背景颜色
                leftMenuCollapseBgActiveColor: 'var(--el-color-primary)',
                // 左侧菜单字体颜色
                leftMenuTextColor: '#bfcbd9',
                // 左侧菜单选中字体颜色
                leftMenuTextActiveColor: '#fff',
                // logo字体颜色
                logoTitleTextColor: '#fff',
                // logo边框颜色
                logoBorderColor: 'inherit',
                // 头部背景颜色
                topHeaderBgColor: '#576772',
                // 头部字体颜色
                topHeaderTextColor: 'inherit',
                // 头部悬停颜色
                topHeaderHoverColor: '#f6f6f6',
                // 头部边框颜色
                topToolBorderColor: '#eee',
            }),
        };
    },
    {
        //持久化存储到 localStorage 中
        // npm i pinia-plugin-persistedstate
        persist: true,
    }
);
