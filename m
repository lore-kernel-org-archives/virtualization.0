From: Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v3 01/16] mm: use put_page to free page instead of
	putback_lru_page
Date: Fri, 1 Apr 2016 14:58:21 +0200
Message-ID: <56FE706D.7080507@suse.cz>
References: <1459321935-3655-1-git-send-email-minchan@kernel.org>
	<1459321935-3655-2-git-send-email-minchan@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1459321935-3655-2-git-send-email-minchan@kernel.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Minchan Kim <minchan@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: Rik van Riel <riel@redhat.com>, YiPing Xu <xuyiping@hisilicon.com>, aquini@redhat.com, rknize@motorola.com, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Chan Gyun Jeong <chan.jeong@lge.com>, Hugh Dickins <hughd@google.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, bfields@fieldses.org, linux-mm@kvack.org, Gioh Kim <gi-oh.kim@profitbricks.com>, Mel Gorman <mgorman@suse.de>, Sangseok Lee <sangseok.lee@lge.com>, jlayton@poochiereds.net, Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>, koct9i@gmail.com, Al Viro <viro@ZenIV.linux.org.uk>
List-Id: virtualization@lists.linuxfoundation.org

On 03/30/2016 09:12 AM, Minchan Kim wrote:
> Procedure of page migration is as follows:
>
> First of all, it should isolate a page from LRU and try to
> migrate the page. If it is successful, it releases the page
> for freeing. Otherwise, it should put the page back to LRU
> list.
>
> For LRU pages, we have used putback_lru_page for both freeing
> and putback to LRU list. It's okay because put_page is aware of
> LRU list so if it releases last refcount of the page, it removes
> the page from LRU list. However, It makes unnecessary operations
> (e.g., lru_cache_add, pagevec and flags operations. It would be
> not significant but no worth to do) and harder to support new
> non-lru page migration because put_page isn't aware of non-lru
> page's data structure.
>
> To solve the problem, we can add new hook in put_page with
> PageMovable flags check but it can increase overhead in
> hot path and needs new locking scheme to stabilize the flag check
> with put_page.
>
> So, this patch cleans it up to divide two semantic(ie, put and putback).
> If migration is successful, use put_page instead of putback_lru_page and
> use putback_lru_page only on failure. That makes code more readable
> and doesn't add overhead in put_page.
>
> Comment from Vlastimil
> "Yeah, and compaction (perhaps also other migration users) has to drain
> the lru pvec... Getting rid of this stuff is worth even by itself."
>
> Cc: Mel Gorman <mgorman@suse.de>
> Cc: Hugh Dickins <hughd@google.com>
> Cc: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> Signed-off-by: Minchan Kim <minchan@kernel.org>

[...]

> @@ -974,28 +986,28 @@ static ICE_noinline int unmap_and_move(new_page_t get_new_page,
>   		list_del(&page->lru);
>   		dec_zone_page_state(page, NR_ISOLATED_ANON +
>   				page_is_file_cache(page));
> -		/* Soft-offlined page shouldn't go through lru cache list */
> +	}
> +
> +	/*
> +	 * If migration is successful, drop the reference grabbed during
> +	 * isolation. Otherwise, restore the page to LRU list unless we
> +	 * want to retry.
> +	 */
> +	if (rc == MIGRATEPAGE_SUCCESS) {
> +		put_page(page);
>   		if (reason == MR_MEMORY_FAILURE) {
> -			put_page(page);
>   			if (!test_set_page_hwpoison(page))
>   				num_poisoned_pages_inc();
> -		} else
> +		}

Hmm, I didn't notice it previously, or it's due to rebasing, but it seems that 
you restricted the memory failure handling (i.e. setting hwpoison) to 
MIGRATE_SUCCESS, while previously it was done for all non-EAGAIN results. I 
think that goes against the intention of hwpoison, which is IIRC to catch and 
kill the poor process that still uses the page?

Also (but not your fault) the put_page() preceding test_set_page_hwpoison(page)) 
IMHO deserves a comment saying which pin we are releasing and which one we still 
have (hopefully? if I read description of da1b13ccfbebe right) otherwise it 
looks like doing something with a page that we just potentially freed.

> +	} else {
> +		if (rc != -EAGAIN)
>   			putback_lru_page(page);
> +		if (put_new_page)
> +			put_new_page(newpage, private);
> +		else
> +			put_page(newpage);
>   	}
>
> -	/*
> -	 * If migration was not successful and there's a freeing callback, use
> -	 * it.  Otherwise, putback_lru_page() will drop the reference grabbed
> -	 * during isolation.
> -	 */
> -	if (put_new_page)
> -		put_new_page(newpage, private);
> -	else if (unlikely(__is_movable_balloon_page(newpage))) {
> -		/* drop our reference, page already in the balloon */
> -		put_page(newpage);
> -	} else
> -		putback_lru_page(newpage);
> -
>   	if (result) {
>   		if (rc)
>   			*result = rc;
>
