/**
 * 要素の詳細画面へ遷移(Enterキーでの遷移)
 */
export function handleEnterKeypressListItem(event, target, url) {
    if (event.key === "Enter") {
      handleClick(event, target, url)
    }
  }
  /**
   * 要素の詳細画面へ遷移
   */
  export function handleClickListItem(event, target, url) {
    // 文字列選択動作でなければクリック処理発火
    let selection = String(document.getSelection());
    if (!selection || selection.length === 0) {
      window.location = url;
    }
  }
  /**
   * 削除ボタンを押下した際に、 tr のクリックイベントが発火しないようにする
   */
  export function handleDeleteListItem(event, target) {
    event.stopPropagation();
  }
  /**
   * form 内の submit, reset 以外の入力欄を空にする
   */
  export function clear_form(event) {
    event.preventDefault(false);
    // input, select のクリア
    event.currentTarget.form.querySelectorAll('input:not([type=submit]):not([type=reset]):not([type=hidden]), select').forEach((e) => {
      e.value = '';
    });
    // TomSelect の表示要素クリア
    event.currentTarget.form.querySelectorAll('.tomselected').forEach((e) => {
      e.tomselect.clear();
    });
  }
  
  /* turbo frame を利用した検索をすると、クエリ文字列がアドレスバーに反映されないため自分で反映させる */
  window.addEventListener('load', function() {
    const turboFrame = document.getElementById('list');
    if (turboFrame) {
      turboFrame.addEventListener('turbo:frame-load', (event) => {
        const url = new URL(event.currentTarget.src);
        window.history.pushState({ path: url.toString() }, '', url.toString());
  
        // pagy の 1 ページごとの表示件数フィールドの幅を 3 桁に固定する
        // turboFrame ロード時の更新
        changePagyItemsSelectorWidth();
      });
    }
  
    // pagy の 1 ページごとの表示件数フィールドの幅を 3 桁に固定する
    // ページロード時の更新
    changePagyItemsSelectorWidth();
  });
  
  /* pagy_items_selector_js の幅を 3 桁に固定する */
  function changePagyItemsSelectorWidth() {
    const pagyItemsSelector = document.getElementById('pagy-limit-selector')?.querySelector('input');
    if (pagyItemsSelector) {
      // 表示を 3 桁に固定
      pagyItemsSelector.style.width = '3em';
      // search_form_for では、クエリパラメーターが `<form の name 属性>[<パラメーター名>]` になっているが、
      // これだと pagy のページングに使えないため、 `<パラメーター名>` の形式に無理やり変更
      document.getElementById('f-limit').name = 'limit';
      pagyItemsSelector.addEventListener('change', (event) => {
        handleOnChangePagyItemsSelectorJs(event.currentTarget);
      });
    }
  }
  
  /* pagy_items_selector_js で生成された input 要素から数値を取得し、 1 ページごとの要素数を更新する */
  export function updateItemPerPage(event) {
    event.preventDefault(false);
  
    const pagyItemsSelector = document.getElementById('pagy-limit-selector');
    const itemPerPage = pagyItemsSelector.querySelector('input').value;
  
    // 現在の URL を取得
    const url = new URL(window.location);
  
    // url から現在のクエリ文字列を取得
    const params = new URLSearchParams(url.search);
  
    // pagy_items_selector_js で指定された値に上書き
    params.set('limit', itemPerPage);
  
    // 新 URL の作成
    const newUrl = url.origin + url.pathname + '?' + params.toString()
  
    // Turbo Frames のフレームを取得
    const turboFrame = document.getElementById('list');
    turboFrame.src = newUrl;
  };
  
  /* pagy_items_selector_js で生成された input 要素が更新されたら、 form の hidden 要素に反映する */
  export function handleOnChangePagyItemsSelectorJs(currentTarget) {
    const itemPerPage = currentTarget.value;
  
    // itemPerPage を隠しフォームに反映
    const hiddenFormForItemPerPage = document.getElementById('f-limit');
    hiddenFormForItemPerPage.value = itemPerPage;
  };
  