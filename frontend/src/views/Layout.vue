<script setup lang="ts">
import { ref } from 'vue';

// pinia
import { useAppStore } from '@/stores/modules/app';
const appStore = useAppStore();

// pinia -- 一堆color
const _leftMenuBgColor = appStore.theme.leftMenuBgColor;
const _leftMenuTextColor = appStore.theme.leftMenuTextColor;
const _leftMenuTextActiveColor = appStore.theme.leftMenuTextActiveColor;
const _topHeaderBgColor = appStore.theme.topHeaderBgColor;
const _logoTitleTextColor = appStore.theme.logoTitleTextColor;
const _elContainerBgColor = appStore.theme.elContainerBgColor;
const _elMainBgColor = appStore.theme.elMainBgColor;

// pinia -- 顶部导航栏高度
// https://antdv.com/components/layout-cn
const _topHeight = `${64 + 8 * appStore.menuState.topHeightN}px`;
const _leftWidthNotCollapsed = `${200 + 8 * appStore.menuState.topHeightN}px`;
const _leftWidthCollapsed = `${64 + 8 * appStore.menuState.topHeightN}px`;
const _leftWidth = ref(_leftWidthNotCollapsed);
_leftWidth.value = appStore.menuState.collapse ? _leftWidthCollapsed : _leftWidthNotCollapsed;
// console.log('top height: ', _topHeight);

// 收起、折叠菜单
const handleOpen = (key: string, keyPath: string[]) => {
    console.log('menu open: ', key, keyPath);
};
const handleClose = (key: string, keyPath: string[]) => {
    console.log('menu close: ', key, keyPath);
};
const handleSelect = (key: string, keyPath: string[], item: {}, routeResult: any) => {
    console.log('menu select: ', key, keyPath, item, routeResult);
    appStore.menuState.defaultActivateKey = key;
    appStore.menuState.activateKeyPath = keyPath;
};

// 切换菜单的折叠状态
const toggleMenu = () => {
    appStore.menuState.collapse = !appStore.menuState.collapse;
    _leftWidth.value = appStore.menuState.collapse ? _leftWidthCollapsed : _leftWidthNotCollapsed;
};

const propsSideMenuList = ref([
    {
        index: '1',
        title: 'one',
        icon: 'ChatDotRound',
        // icon: 'icon-edit',
        // icon: 'el-icon-edit',
        children: [
            {
                index: '1-1',
                title: 'one-one',
            },

            {
                index: '1-2',
                title: 'one-two',
                children: [
                    {
                        index: '1-2-1',
                        title: 'one-two-one',
                    },

                    {
                        index: '1-2-2',
                        title: 'one-two-two',
                    },
                ],
            },
        ],
    },
    {
        index: '2',
        title: 'two',
        icon: 'Connection',
    },
]);
import MenuList from './menu/MenuList.vue';
</script>

<template>
    <el-container class="my-app">
        <el-aside>
            <div class="logo">
                <div class="logo-real">
                    <el-icon :size="30" :color="appStore.theme.logoTitleTextColor"><HomeFilled /></el-icon>
                    <p v-show="!appStore.menuState.collapse">YcLey</p>
                </div>
            </div>
            <!-- 菜单 -->
            <el-menu
                :default-active="appStore.menuState.defaultActivateKey"
                :collapse="appStore.menuState.collapse"
                @open="handleOpen"
                @close="handleClose"
                @select="handleSelect"
                :background-color="_leftMenuBgColor"
                :text-color="_leftMenuTextColor"
                :active-text-color="_leftMenuTextActiveColor"
                :unique-opened="appStore.menuState.uniqueOpened"
                :router="false"
            >
                <!-- MenuList循环：https://juejin.cn/post/7064857526776365070 -->
                <!-- 父子通讯：https://juejin.cn/post/7111686386645729317 -->
                <MenuList :menuList="propsSideMenuList"></MenuList>
            </el-menu>
        </el-aside>
        <el-container>
            <el-header>
                <div class="left">
                    <el-icon :size="25" :color="_leftMenuTextActiveColor" @click="toggleMenu">
                        <span v-if="appStore.menuState.collapse"><Expand /></span>
                        <span v-else><Fold /></span>
                    </el-icon>
                </div>
                <div class="right">
                    <el-dropdown>
                        <span class="el-dropdown-link">
                            <el-icon><UserFilled /></el-icon>YcLey
                        </span>
                        <template #dropdown>
                            <el-dropdown-menu>
                                <el-dropdown-item>退出登录</el-dropdown-item>
                            </el-dropdown-menu>
                        </template>
                    </el-dropdown>
                </div>

                <!-- <el-menu
                    :default-active="appStore.menuState.defaultActivateKey"
                    mode="horizontal"
                    :ellipsis="false"
                    @open="handleOpen"
                    @close="handleClose"
                    @select="handleSelect"
                    :background-color="_leftMenuBgColor"
                    :text-color="_leftMenuTextColor"
                    :active-text-color="_leftMenuTextActiveColor"
                    :unique-opened="appStore.menuState.uniqueOpened"
                >
                    <el-sub-menu index="top-1">
                        <template #title>
                            <el-icon><UserFilled /></el-icon>YcLey
                        </template>
                        <el-menu-item index="top-1-1">退出登录</el-menu-item>
                    </el-sub-menu>
                </el-menu> -->
            </el-header>
            <el-main><RouterView></RouterView></el-main>
            <!-- <el-footer>Footer</el-footer> -->
        </el-container>
    </el-container>
</template>

<style lang="scss">
.my-app {
    height: 100vh;
    background-color: v-bind(_elContainerBgColor);
    .el-aside {
        background-color: v-bind(_leftMenuBgColor);
        width: v-bind(_leftWidth);
        .logo {
            height: v-bind(_topHeight);

            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0;
            .logo-real {
                padding: 5px 5px;
                background-color: v-bind(_topHeaderBgColor);
                color: v-bind(_logoTitleTextColor);

                display: flex;
                flex-direction: row;
                align-items: center;
                justify-content: center;

                * {
                    margin: 0 5px;
                    pointer-events: none;
                }
                p {
                    font-size: 1.5rem;
                }
            }
        }
        .logo:hover {
            * {
                color: var(--el-color-primary);
            }
        }
        .el-menu {
            width: v-bind(_leftWidth);
            border: 0;
        }

        .el-menu--collapse .el-sub-menu__icon-arrow {
            display: none;
        }
    }
    .el-header {
        background-color: v-bind(_leftMenuBgColor);
        display: flex;
        align-items: center;
        justify-content: space-between;
        height: v-bind(_topHeight);

        .left {
            .el-icon:hover {
                color: var(--el-color-primary);
            }
        }

        .right {
            .el-dropdown {
                .el-icon {
                    margin: 0 5px;
                }
            }
            .el-dropdown-link:focus {
                outline: none;
            }
            .el-dropdown:hover {
                color: var(--el-color-primary);
            }
        }
    }
    .el-main {
        margin: 1rem;
        // margin: 14px 14px 0px 14px;
        background-color: v-bind(_elMainBgColor);
        border-radius: 4px;
        padding: 0;
        overflow: hidden;
    }
    .el-footer {
        margin: 14px;
        // margin: 0px 14px 14px 14px;
        background-color: v-bind(_elMainBgColor);
        border-radius: 4px;
    }
}
</style>
