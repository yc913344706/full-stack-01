<script setup lang="ts">
// pinia
import { useAppStore } from '@/stores/modules/app';
const appStore = useAppStore();

// props
interface MenuListModel {
    index: string;
    title: string;
    icon?: string;
    children?: MenuListModel[];
}
const propsVars = defineProps({
    menuList: {
        type: Array<MenuListModel>,
        default: () => [],
    },
    hiddenStr: {
        type: Boolean,
        default: true,
        required: false,
    },
});
console.debug('props vars: ', propsVars);
// console.log('props of menu list: ', menuList);
</script>

<template>
    <!-- 动态菜单：https://juejin.cn/post/7064857526776365070 -->
    <template v-for="menu in menuList" :index="menu.index" :key="menu.index">
        <span v-if="menu.children && menu.children.length">
            <el-sub-menu
                :index="menu.index"
                :class="{ menu_item_is_active: appStore.menuState.collapse && appStore.menuState.activateKeyPath.includes(menu.index) }"
            >
                <template #title>
                    <el-icon v-if="menu.icon">
                        <!-- 动态图标：https://blog.csdn.net/heyNewbie/article/details/123278515 -->
                        <component :is="menu.icon"></component>
                    </el-icon>
                    <span v-if="hiddenStr">
                        <span v-show="!appStore.menuState.collapse">{{ menu.title }}</span>
                    </span>
                    <span v-else>{{ menu.title }}</span>
                </template>
                <MenuList :menuList="menu.children" :hiddenStr="false" />
            </el-sub-menu>
        </span>
        <span v-else>
            <el-menu-item :index="menu.index" :class="{ menu_item_is_active: menu.index === appStore.menuState.defaultActivateKey }">
                <span>
                    <!-- 判断是否有图标并渲染 -->
                    <el-icon v-if="menu.icon">
                        <component :is="menu.icon"></component>
                    </el-icon>
                    <span v-if="hiddenStr">
                        <span v-show="!appStore.menuState.collapse">{{ menu.title }}</span>
                    </span>
                    <span v-else>{{ menu.title }}</span>
                </span>
            </el-menu-item>
        </span>
    </template>
</template>

<style lang="scss"></style>
