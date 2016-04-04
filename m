From: Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v3 01/16] mm: use put_page to free page instead of
	putback_lru_page
Date: Mon, 4 Apr 2016 16:46:31 +0200
Message-ID: <57027E47.7070909@suse.cz>
References: <1459321935-3655-1-git-send-email-minchan@kernel.org>
	<1459321935-3655-2-git-send-email-minchan@kernel.org>
	<56FE706D.7080507@suse.cz> <20160404013917.GC6543@bbox>
	<20160404044458.GA20250@hori1.linux.bs1.fc.nec.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20160404044458.GA20250@hori1.linux.bs1.fc.nec.co.jp>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>, Minchan Kim <minchan@kernel.org>
Cc: "jlayton@poochiereds.net" <jlayton@poochiereds.net>, Rik van Riel <riel@redhat.com>, YiPing Xu <xuyiping@hisilicon.com>, "aquini@redhat.com" <aquini@redhat.com>, "rknize@motorola.com" <rknize@motorola.com>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Chan Gyun Jeong <chan.jeong@lge.com>, Hugh Dickins <hughd@google.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "bfields@fieldses.org" <bfields@fieldses.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, Gioh Kim <gi-oh.kim@profitbricks.com>, Mel Gorman <mgorman@suse.de>, Sangseok Lee <sangseok.lee@lge.com>, Andrew Morton <akpm@linux-foundation.org>, Joonsoo Kim <iamjoonsoo.kim@lge.com>, "koct9i@gmail.com" <koct9i@gmail.com>, Al Viro <viro@ZenIV.linux.org.uk>
List-Id: virtualization@lists.linuxfoundation.org

On 04/04/2016 06:45 AM, Naoya Horiguchi wrote:
> On Mon, Apr 04, 2016 at 10:39:17AM +0900, Minchan Kim wrote:
>> Thanks for catching it, Vlastimil.
>> It was my mistake. But in this chance, I looked over hwpoison code and
>> I saw other places which increases num_poisoned_pages are successful
>> migration, already freed page and successful invalidated page.
>> IOW, they are already successful isolated page so I guess it should
>> increase the count when only successful migration is done?
> 
> Yes, that's right. When exiting with migration's failure, we shouldn't call
> test_set_page_hwpoison or num_poisoned_pages_inc, so current code checking
> (rc != -EAGAIN) is simply incorrect. Your change fixes the bug in memory
> error handling. Great!

Ah, I see, soft onlining works differently than I thought.

>> And when I read memory_failure, it bails out without killing if it
>> encounters HWPoisoned page so I think it's not for catching and
>> kill the poor proces.
>>
>>>
>>> Also (but not your fault) the put_page() preceding
>>> test_set_page_hwpoison(page)) IMHO deserves a comment saying which
>>> pin we are releasing and which one we still have (hopefully? if I
>>> read description of da1b13ccfbebe right) otherwise it looks like
>>> doing something with a page that we just potentially freed.
>>
>> Yes, while I read the code, I had same question. I think the releasing
>> refcount is for get_any_page.
> 
> As the other callers of page migration do, soft_offline_page expects the
> migration source page to be freed at this put_page() (no pin remains.)
> The refcount released here is from isolate_lru_page() in __soft_offline_page().
> (the pin by get_any_page is released by put_hwpoison_page just after it.)
> 
> .. yes, doing something just after freeing page looks weird, but that's
> how PageHWPoison flag works. IOW, many other page flags are maintained
> only during one "allocate-free" life span, but PageHWPoison still does
> its job beyond it.

But what prevents the page from being allocated again between put_page()
and test_set_page_hwpoison()? In that case we would be marking page
poisoned while still in use, which is the same as marking it while still
in use after a failed migration?

(Also, which part prevents pages with PageHWPoison to be allocated
again, anyway? I can't find it and test_set_page_hwpoison() doesn't
remove from buddy freelists).

Thanks.

> As for commenting, this put_page() is called in any MIGRATEPAGE_SUCCESS
> case (regardless of callers), so what we can say here is "we free the
> source page here, bypassing LRU list" or something?
> 
> Thanks,
> Naoya Horiguchi
> 
