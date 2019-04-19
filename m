From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v2 1/4] mm/balloon_compaction: list interfaces
Date: Fri, 19 Apr 2019 18:07:26 -0400
Message-ID: <20190419174452-mutt-send-email-mst__15128.8188806333$1555711686$gmane$org@kernel.org>
References: <20190328010718.2248-1-namit@vmware.com>
	<20190328010718.2248-2-namit@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190328010718.2248-2-namit@vmware.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Nadav Amit <namit@vmware.com>
Cc: Arnd Bergmann <arnd@arndb.de>, "VMware, Inc." <pv-drivers@vmware.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, Julien Freche <jfreche@vmware.com>, Nadav Amit <nadav.amit@gmail.com>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Mar 28, 2019 at 01:07:15AM +0000, Nadav Amit wrote:
> Introduce interfaces for ballooning enqueueing and dequeueing of a list
> of pages. These interfaces reduce the overhead of storing and restoring
> IRQs by batching the operations. In addition they do not panic if the
> list of pages is empty.
> 
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: linux-mm@kvack.org
> Cc: virtualization@lists.linux-foundation.org
> Reviewed-by: Xavier Deguillard <xdeguillard@vmware.com>
> Signed-off-by: Nadav Amit <namit@vmware.com>
> ---
>  include/linux/balloon_compaction.h |   4 +
>  mm/balloon_compaction.c            | 145 +++++++++++++++++++++--------
>  2 files changed, 111 insertions(+), 38 deletions(-)
> 
> diff --git a/include/linux/balloon_compaction.h b/include/linux/balloon_compaction.h
> index f111c780ef1d..1da79edadb69 100644
> --- a/include/linux/balloon_compaction.h
> +++ b/include/linux/balloon_compaction.h
> @@ -64,6 +64,10 @@ extern struct page *balloon_page_alloc(void);
>  extern void balloon_page_enqueue(struct balloon_dev_info *b_dev_info,
>  				 struct page *page);
>  extern struct page *balloon_page_dequeue(struct balloon_dev_info *b_dev_info);
> +extern size_t balloon_page_list_enqueue(struct balloon_dev_info *b_dev_info,
> +				      struct list_head *pages);
> +extern size_t balloon_page_list_dequeue(struct balloon_dev_info *b_dev_info,
> +				     struct list_head *pages, int n_req_pages);
>  

Why size_t I wonder? It can never be > n_req_pages which is int.
Callers also seem to assume int.

>  static inline void balloon_devinfo_init(struct balloon_dev_info *balloon)
>  {


> diff --git a/mm/balloon_compaction.c b/mm/balloon_compaction.c
> index ef858d547e2d..88d5d9a01072 100644
> --- a/mm/balloon_compaction.c
> +++ b/mm/balloon_compaction.c
> @@ -10,6 +10,106 @@
>  #include <linux/export.h>
>  #include <linux/balloon_compaction.h>
>  
> +static int balloon_page_enqueue_one(struct balloon_dev_info *b_dev_info,
> +				     struct page *page)
> +{
> +	/*
> +	 * Block others from accessing the 'page' when we get around to
> +	 * establishing additional references. We should be the only one
> +	 * holding a reference to the 'page' at this point.
> +	 */
> +	if (!trylock_page(page)) {
> +		WARN_ONCE(1, "balloon inflation failed to enqueue page\n");
> +		return -EFAULT;

Looks like all callers bug on a failure. So let's just do it here,
and then make this void?

> +	}
> +	list_del(&page->lru);
> +	balloon_page_insert(b_dev_info, page);
> +	unlock_page(page);
> +	__count_vm_event(BALLOON_INFLATE);
> +	return 0;
> +}
> +
> +/**
> + * balloon_page_list_enqueue() - inserts a list of pages into the balloon page
> + *				 list.
> + * @b_dev_info: balloon device descriptor where we will insert a new page to
> + * @pages: pages to enqueue - allocated using balloon_page_alloc.
> + *
> + * Driver must call it to properly enqueue a balloon pages before definitively
> + * removing it from the guest system.

A bunch of grammar error here. Pls fix for clarify.
Also - document that nothing must lock the pages? More assumptions?
What is "it" in this context? All pages? And what does removing from
guest mean? Really adding to the balloon?

> + *
> + * Return: number of pages that were enqueued.
> + */
> +size_t balloon_page_list_enqueue(struct balloon_dev_info *b_dev_info,
> +			       struct list_head *pages)
> +{
> +	struct page *page, *tmp;
> +	unsigned long flags;
> +	size_t n_pages = 0;
> +
> +	spin_lock_irqsave(&b_dev_info->pages_lock, flags);
> +	list_for_each_entry_safe(page, tmp, pages, lru) {
> +		balloon_page_enqueue_one(b_dev_info, page);

Do we want to do something about an error here?

> +		n_pages++;
> +	}
> +	spin_unlock_irqrestore(&b_dev_info->pages_lock, flags);
> +	return n_pages;
> +}
> +EXPORT_SYMBOL_GPL(balloon_page_list_enqueue);
> +
> +/**
> + * balloon_page_list_dequeue() - removes pages from balloon's page list and
> + *				 returns a list of the pages.
> + * @b_dev_info: balloon device decriptor where we will grab a page from.
> + * @pages: pointer to the list of pages that would be returned to the caller.
> + * @n_req_pages: number of requested pages.
> + *
> + * Driver must call it to properly de-allocate a previous enlisted balloon pages
> + * before definetively releasing it back to the guest system. This function
> + * tries to remove @n_req_pages from the ballooned pages and return it to the
> + * caller in the @pages list.
> + *
> + * Note that this function may fail to dequeue some pages temporarily empty due
> + * to compaction isolated pages.
> + *
> + * Return: number of pages that were added to the @pages list.
> + */
> +size_t balloon_page_list_dequeue(struct balloon_dev_info *b_dev_info,
> +				 struct list_head *pages, int n_req_pages)
> +{
> +	struct page *page, *tmp;
> +	unsigned long flags;
> +	size_t n_pages = 0;
> +
> +	spin_lock_irqsave(&b_dev_info->pages_lock, flags);
> +	list_for_each_entry_safe(page, tmp, &b_dev_info->pages, lru) {
> +		/*
> +		 * Block others from accessing the 'page' while we get around
> +		 * establishing additional references and preparing the 'page'
> +		 * to be released by the balloon driver.
> +		 */
> +		if (!trylock_page(page))
> +			continue;
> +
> +		if (IS_ENABLED(CONFIG_BALLOON_COMPACTION) &&
> +		    PageIsolated(page)) {
> +			/* raced with isolation */
> +			unlock_page(page);
> +			continue;
> +		}
> +		balloon_page_delete(page);
> +		__count_vm_event(BALLOON_DEFLATE);
> +		unlock_page(page);
> +		list_add(&page->lru, pages);
> +		if (++n_pages >= n_req_pages)
> +			break;
> +	}
> +	spin_unlock_irqrestore(&b_dev_info->pages_lock, flags);
> +
> +	return n_pages;
> +}
> +EXPORT_SYMBOL_GPL(balloon_page_list_dequeue);
> +
>  /*
>   * balloon_page_alloc - allocates a new page for insertion into the balloon
>   *			  page list.
> @@ -43,17 +143,9 @@ void balloon_page_enqueue(struct balloon_dev_info *b_dev_info,
>  {
>  	unsigned long flags;
>  
> -	/*
> -	 * Block others from accessing the 'page' when we get around to
> -	 * establishing additional references. We should be the only one
> -	 * holding a reference to the 'page' at this point.
> -	 */
> -	BUG_ON(!trylock_page(page));
>  	spin_lock_irqsave(&b_dev_info->pages_lock, flags);
> -	balloon_page_insert(b_dev_info, page);
> -	__count_vm_event(BALLOON_INFLATE);
> +	balloon_page_enqueue_one(b_dev_info, page);

We used to bug on failure to lock page, now we
silently ignore this error. Why?


>  	spin_unlock_irqrestore(&b_dev_info->pages_lock, flags);
> -	unlock_page(page);
>  }
>  EXPORT_SYMBOL_GPL(balloon_page_enqueue);
>  
> @@ -70,36 +162,13 @@ EXPORT_SYMBOL_GPL(balloon_page_enqueue);
>   */
>  struct page *balloon_page_dequeue(struct balloon_dev_info *b_dev_info)
>  {
> -	struct page *page, *tmp;
>  	unsigned long flags;
> -	bool dequeued_page;
> +	LIST_HEAD(pages);
> +	int n_pages;
>  
> -	dequeued_page = false;
> -	spin_lock_irqsave(&b_dev_info->pages_lock, flags);
> -	list_for_each_entry_safe(page, tmp, &b_dev_info->pages, lru) {
> -		/*
> -		 * Block others from accessing the 'page' while we get around
> -		 * establishing additional references and preparing the 'page'
> -		 * to be released by the balloon driver.
> -		 */
> -		if (trylock_page(page)) {
> -#ifdef CONFIG_BALLOON_COMPACTION
> -			if (PageIsolated(page)) {
> -				/* raced with isolation */
> -				unlock_page(page);
> -				continue;
> -			}
> -#endif
> -			balloon_page_delete(page);
> -			__count_vm_event(BALLOON_DEFLATE);
> -			unlock_page(page);
> -			dequeued_page = true;
> -			break;
> -		}
> -	}
> -	spin_unlock_irqrestore(&b_dev_info->pages_lock, flags);
> +	n_pages = balloon_page_list_dequeue(b_dev_info, &pages, 1);
>  
> -	if (!dequeued_page) {
> +	if (n_pages != 1) {
>  		/*
>  		 * If we are unable to dequeue a balloon page because the page
>  		 * list is empty and there is no isolated pages, then something
> @@ -112,9 +181,9 @@ struct page *balloon_page_dequeue(struct balloon_dev_info *b_dev_info)
>  			     !b_dev_info->isolated_pages))
>  			BUG();
>  		spin_unlock_irqrestore(&b_dev_info->pages_lock, flags);
> -		page = NULL;
> +		return NULL;
>  	}
> -	return page;
> +	return list_first_entry(&pages, struct page, lru);
>  }
>  EXPORT_SYMBOL_GPL(balloon_page_dequeue);
>  
> -- 
> 2.19.1
