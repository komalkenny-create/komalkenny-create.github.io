# -*- coding: utf-8 -*-
"""
批量更新 chinakomal-website 联系信息
"""

import os
import re
from pathlib import Path

# 网站根目录
WEB_DIR = Path(r"C:\Users\komal\Desktop\07_项目网站\chinakomal-website-new")

# 新的联系信息
NEW_EMAIL = "kenny@chinakomal.com"
NEW_WECHAT_PHONE = "+86 177 7787 8139"
NEW_WHATSAPP = "+86 18600109655"
NEW_ADDRESS = "NO.1 Huoxing 3rd Street, Economic development zone, Tongzhou District, Beijing, China"

def update_file(filepath):
    """更新单个文件的联系信息"""
    try:
        with open(filepath, 'r', encoding='utf-8') as f:
            content = f.read()
        
        original = content
        
        # 1. 更新顶部栏的电话号码 (带空格的前缀)
        # 匹配: <span> +86 177 7787 8139</span>
        content = re.sub(
            r'<span>\s*\+86 177 7787 8139</span>',
            f'<span> WeChat/Cell: {NEW_WECHAT_PHONE}</span>',
            content
        )
        
        # 2. 更新底部 footer 中的电话号码
        # 匹配: <p> +86 177 7787 8139</p>
        content = re.sub(
            r'<p>\s*\+86 177 7787 8139</p>',
            f'<p> WeChat/Cell: {NEW_WECHAT_PHONE}</p>\n                <p> Whatsapp: {NEW_WHATSAPP}</p>',
            content
        )
        
        # 3. 更新旧地址为新地址
        # 匹配各种格式的地址
        content = re.sub(
            r'No\. xxx, xxx Road, Chaoyang District, Beijing, China',
            NEW_ADDRESS,
            content
        )
        content = re.sub(
            r'Location: Beijing, China',
            f'Location: {NEW_ADDRESS}',
            content
        )
        
        # 4. 更新 footer-section 中的地址
        content = re.sub(
            r'<p>Location: Beijing, China</p>',
            f'<p>Location: {NEW_ADDRESS}</p>',
            content
        )
        
        if content != original:
            with open(filepath, 'w', encoding='utf-8') as f:
                f.write(content)
            return True
        return False
        
    except Exception as e:
        print(f"  错误 {filepath}: {e}")
        return False

def main():
    print("=" * 60)
    print("开始批量更新联系信息...")
    print("=" * 60)
    
    updated_count = 0
    total_files = 0
    
    for html_file in WEB_DIR.glob("*.html"):
        total_files += 1
        if update_file(html_file):
            print(f"✓ 已更新: {html_file.name}")
            updated_count += 1
    
    print("=" * 60)
    print(f"更新完成！共更新 {updated_count}/{total_files} 个文件")
    print("=" * 60)

if __name__ == "__main__":
    main()
