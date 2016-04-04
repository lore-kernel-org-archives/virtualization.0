From: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
Subject: Re: [PATCH v3 01/16] mm: use put_page to free page instead of
	putback_lru_page
Date: Mon, 4 Apr 2016 04:45:12 +0000
Message-ID: <20160404044458.GA20250__24267.6327274696$1459786662$gmane$org@hori1.linux.bs1.fc.nec.co.jp>
References: <1459321935-3655-1-git-send-email-minchan@kernel.org>
	<1459321935-3655-2-git-send-email-minchan@kernel.org>
	<56FE706D.7080507@suse.cz> <20160404013917.GC6543@bbox>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20160404013917.GC6543@bbox>
Content-Language: ja-JP
Content-ID: <B7F4C185B2AD1244A141B1BF11F5A32D@gisp.nec.co.jp>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Minchan Kim <minchan@kernel.org>
Cc: Rik van Riel <riel@redhat.com>, YiPing Xu <xuyiping@hisilicon.com>, "aquini@redhat.com" <aquini@redhat.com>, "rknize@motorola.com" <rknize@motorola.com>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Chan Gyun Jeong <chan.jeong@lge.com>, Hugh Dickins <hughd@google.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Al Viro <viro@ZenIV.linux.org.uk>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "bfields@fieldses.org" <bfields@fieldses.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, Gioh Kim <gi-oh.kim@profitbricks.com>, "koct9i@gmail.com" <koct9i@gmail.com>, Sangseok Lee <sangseok.lee@lge.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>, Andrew Morton <akpm@linux-foundation.org>, "jlayton@poochiereds.net" <jlayton@poochiereds.net>, Vlastimil Babka <vbabka@suse.cz>, Mel Gorman <mgorman@suse.de>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Apr 04, 2016 at 10:39:17AM +0900, Minchan Kim wrote:
> On Fri, Apr 01, 2016 at 02:58:21PM +0200, Vlastimil Babka wrote:
> > On 03/30/2016 09:12 AM, Minchan Kim wrote:
> > >Procedure of page migration is as follows:
> > >
> > >First of all, it should isolate a page from LRU and try to
> > >migrate the page. If it is successful, it releases the page
> > >for freeing. Otherwise, it should put the page back to LRU
> > >list.
> > >
> > >For LRU pages, we have used putback_lru_page for both freeing
> > >and putback to LRU list. It's okay because put_page is aware of
> > >LRU list so if it releases last refcount of the page, it removes
> > >the page from LRU list. However, It makes unnecessary operations
> > >(e.g., lru_cache_add, pagevec and flags operations. It would be
> > >not significant but no worth to do) and harder to support new
> > >non-lru page migration because put_page isn't aware of non-lru
> > >page's data structure.
> > >
> > >To solve the problem, we can add new hook in put_page with
> > >PageMovable flags check but it can increase overhead in
> > >hot path and needs new locking scheme to stabilize the flag check
> > >with put_page.
> > >
> > >So, this patch cleans it up to divide two semantic(ie, put and putback).
> > >If migration is successful, use put_page instead of putback_lru_page and
> > >use putback_lru_page only on failure. That makes code more readable
> > >and doesn't add overhead in put_page.
> > >
> > >Comment from Vlastimil
> > >"Yeah, and compaction (perhaps also other migration users) has to drain
> > >the lru pvec... Getting rid of this stuff is worth even by itself."
> > >
> > >Cc: Mel Gorman <mgorman@suse.de>
> > >Cc: Hugh Dickins <hughd@google.com>
> > >Cc: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
> > >Acked-by: Vlastimil Babka <vbabka@suse.cz>
> > >Signed-off-by: Minchan Kim <minchan@kernel.org>
> > 
> > [...]
> > 
> > >@@ -974,28 +986,28 @@ static ICE_noinline int unmap_and_move(new_page_t get_new_page,
> > >  		list_del(&page->lru);
> > >  		dec_zone_page_state(page, NR_ISOLATED_ANON +
> > >  				page_is_file_cache(page));
> > >-		/* Soft-offlined page shouldn't go through lru cache list */
> > >+	}
> > >+
> > >+	/*
> > >+	 * If migration is successful, drop the reference grabbed during
> > >+	 * isolation. Otherwise, restore the page to LRU list unless we
> > >+	 * want to retry.
> > >+	 */
> > >+	if (rc == MIGRATEPAGE_SUCCESS) {
> > >+		put_page(page);
> > >  		if (reason == MR_MEMORY_FAILURE) {
> > >-			put_page(page);
> > >  			if (!test_set_page_hwpoison(page))
> > >  				num_poisoned_pages_inc();
> > >-		} else
> > >+		}
> > 
> > Hmm, I didn't notice it previously, or it's due to rebasing, but it
> > seems that you restricted the memory failure handling (i.e. setting
> > hwpoison) to MIGRATE_SUCCESS, while previously it was done for all
> > non-EAGAIN results. I think that goes against the intention of
> > hwpoison, which is IIRC to catch and kill the poor process that
> > still uses the page?
> 
> That's why I Cc'ed Naoya Horiguchi to catch things I might make
> mistake.
> 
> Thanks for catching it, Vlastimil.
> It was my mistake. But in this chance, I looked over hwpoison code and
> I saw other places which increases num_poisoned_pages are successful
> migration, already freed page and successful invalidated page.
> IOW, they are already successful isolated page so I guess it should
> increase the count when only successful migration is done?

Yes, that's right. When exiting with migration's failure, we shouldn't call
test_set_page_hwpoison or num_poisoned_pages_inc, so current code checking
(rc != -EAGAIN) is simply incorrect. Your change fixes the bug in memory
error handling. Great!

> And when I read memory_failure, it bails out without killing if it
> encounters HWPoisoned page so I think it's not for catching and
> kill the poor proces.
>
> > 
> > Also (but not your fault) the put_page() preceding
> > test_set_page_hwpoison(page)) IMHO deserves a comment saying which
> > pin we are releasing and which one we still have (hopefully? if I
> > read description of da1b13ccfbebe right) otherwise it looks like
> > doing something with a page that we just potentially freed.
>
> Yes, while I read the code, I had same question. I think the releasing
> refcount is for get_any_page.

As the other callers of page migration do, soft_offline_page expects the
migration source page to be freed at this put_page() (no pin remains.)
The refcount released here is from isolate_lru_page() in __soft_offline_page().
(the pin by get_any_page is released by put_hwpoison_page just after it.)

.. yes, doing something just after freeing page looks weird, but that's
how PageHWPoison flag works. IOW, many other page flags are maintained
only during one "allocate-free" life span, but PageHWPoison still does
its job beyond it.

As for commenting, this put_page() is called in any MIGRATEPAGE_SUCCESS
case (regardless of callers), so what we can say here is "we free the
source page here, bypassing LRU list" or something?

Thanks,
Naoya Horiguchi
