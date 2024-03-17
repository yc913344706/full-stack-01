import { createApp } from 'vue';
import App from './App.vue';

const app = createApp(App);

// router
import { setupRouter } from '@/router';
setupRouter(app);

// element plus
import ElementPlus from 'element-plus';
import 'element-plus/dist/index.css';
app.use(ElementPlus);
// element plus icon
import * as ElementPlusIconsVue from '@element-plus/icons-vue';
for (const [key, component] of Object.entries(ElementPlusIconsVue)) {
    app.component(key, component);
}

// pinia
import { createPinia } from 'pinia';
import piniaPluginPersistedstate from 'pinia-plugin-persistedstate';
const pinia = createPinia();
pinia.use(piniaPluginPersistedstate);
app.use(pinia); //将Pinia实例注册到Vue应用中

app.mount('#app');
