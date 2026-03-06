import os
import sys

# 1. スクリプトの場所を基準にパスを解決
BASE_DIR = os.path.dirname(os.path.abspath(__file__))
REF_DIR = os.path.join(BASE_DIR, 'mql5_ref')
INPUT_FILE = os.path.join(REF_DIR, 'mql5_full.txt')
OUTPUT_DIR = os.path.join(REF_DIR, 'sections')

# 2. 抽出したい章の定義（PDFのテキスト構造に合わせる）
# PDF抽出結果によって見出しの文言が微妙に異なる場合があるため、
# 柔軟にマッチするように調整しています
SECTIONS = {
    "01_Trade_Functions": "Trade Functions",
    "02_Indicator_Functions": "Indicator Functions",
    "03_Timeseries_Access": "Timeseries and Indicators Access",
    "04_Standard_Library": "Standard Library",
    "05_Custom_Indicators": "Custom Indicators",
    "06_Chart_Operations": "Chart Operations",
    "07_Common_Functions": "Common Functions"
}

def split_ref():
    if not os.path.exists(INPUT_FILE):
        print(f"Error: {INPUT_FILE} が見つかりません。pdftotextを実行しましたか？")
        return

    os.makedirs(OUTPUT_DIR, exist_ok=True)

    with open(INPUT_FILE, 'r', encoding='utf-8') as f:
        content = f.read()

    print(f"Splitting {INPUT_FILE} into sections...")

    # タイトルの位置をすべて検索
    found_positions = []
    for filename, title in SECTIONS.items():
        pos = content.find(title)
        if pos != -1:
            found_positions.append((pos, filename, title))
        else:
            print(f"Warning: '{title}' がテキスト内で見つかりませんでした。")

    # 位置順にソート
    found_positions.sort()

    # 各セクションを切り出して保存
    for i in range(len(found_positions)):
        start_pos, filename, title = found_positions[i]
        
        # 次のセクションの開始位置を終端とする
        if i + 1 < len(found_positions):
            end_pos = found_positions[i+1][0]
        else:
            end_pos = len(content)

        output_path = os.path.join(OUTPUT_DIR, f"{filename}.txt")
        with open(output_path, 'w', encoding='utf-8') as out:
            out.write(content[start_pos:end_pos])
        
        print(f"Saved: {output_path}")

    print("\nDone! Geminiに読み込ませる準備が整いました。")

if __name__ == "__main__":
    split_ref()
    sys.exit(0)