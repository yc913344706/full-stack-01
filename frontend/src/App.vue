<script setup lang="ts">
// 使用环境配置文件里面的变量
// console.log(import.meta.env.VITE_APP_TITLE);

// import { useAppStore } from '@/stores/modules/app';
// const appStore = useAppStore();
// console.log('isDark from pinia: ', appStore.isDark);

// appStore.isDark = !appStore.isDark;
// console.log('isDark from pinia after change: ', appStore.isDark);

/** 更换主题色：
 * - https://blog.csdn.net/weixin_54218079/article/details/124613463
 * - https://www.jianshu.com/p/2527a4bdffe9
 * - https://blog.csdn.net/weixin_57208584/article/details/126575927
 *  */
// import { onMounted } from 'vue';

// onMounted(() => {
//     document.body.style.setProperty('--el-color-primary', '#56AB2F');
//     document.body.style.setProperty('--el-color-primary-light-9', '#F5FBF0');
//     document.body.style.setProperty('--el-color-primary-light-3', '#95d475');
// });
</script>

<template>
    <RouterView></RouterView>
</template>

<!-- 模板设置
    vim ~/.vscode/extensions/sdras.vue-vscode-snippets-3.1.1/snippets/vue.json
-->
<style lang="scss"></style>
