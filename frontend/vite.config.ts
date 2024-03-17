import { defineConfig } from "vite";
import vue from "@vitejs/plugin-vue";

/** src -- @
 * - https://blog.csdn.net/shiqing4387/article/details/131300948
 */
import { resolve } from "path";
import * as process from "process";
function pathResolver(dir: string) {
    return resolve(process.cwd(), ".", dir);
}

// https://vitejs.dev/config/
export default defineConfig({
    plugins: [vue()],

    resolve: {
        alias: [
            //路径别名
            {
                find: "@",
                replacement: pathResolver("src"),
            },
        ],
    },
});
