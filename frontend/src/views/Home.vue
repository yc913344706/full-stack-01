<script setup lang="ts"></script>

<template>
    <div class="homeDiv">
        <p>YcLey</p>
        <div style="width: 100%; height: 3px; background: black"></div>
        <p>欢迎您！</p>
    </div>
</template>

<style scoped>
/**
 * 字体：
 * - 谷歌字体：https://fonts.google.com/?subset=chinese-simplified&noto.script=Hans
 * - 字体使用：https://www.zhihu.com/question/555791781/answer/3371514307
 */
@font-face {
    font-family: 'LongCang'; /* 自定义字体的名字 */
    src: url('@/assets/fonts/Long_Cang/LongCang-Regular.ttf') format('truetype'); /* 字体文件的路径和格式 */
}

@font-face {
    font-family: 'MaShanZheng'; /* 自定义字体的名字 */
    src: url('@/assets/fonts/Ma_Shan_Zheng/MaShanZheng-Regular.ttf') format('truetype'); /* 字体文件的路径和格式 */
}
.homeDiv {
    /* margin: 14px; */
    height: 100%;
    /* https://color.oulu.me/deta3.html */
    background: linear-gradient(to bottom, #d5dee7 0%, #e8ebf2 50%, #e2e7ed 100%),
        linear-gradient(to bottom, rgba(0, 0, 0, 0.02) 50%, rgba(255, 255, 255, 0.02) 61%, rgba(0, 0, 0, 0.02) 73%),
        linear-gradient(33deg, rgba(255, 255, 255, 0.2) 0%, rgba(0, 0, 0, 0.2) 100%);
    background-blend-mode: normal, color-burn;
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
    p {
        display: block;
        margin: 30px 0px;
        font-family: 'LongCang', cursive;
        /* font-family: 'MaShanZheng', cursive; */
        font-weight: 400;
        font-style: normal;
        /**
         * 关于固定字体大小
         * - https://blog.csdn.net/qq_48652579/article/details/131317361
         */
        font-size: 4rem;
    }
}
</style>
