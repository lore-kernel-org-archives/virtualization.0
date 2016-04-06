From: Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v3 01/16] mm: use put_page to free page instead of
	putback_lru_page
Date: Wed, 6 Apr 2016 09:57:28 +0200
Message-ID: <5704C168.1060803__15341.2676453174$1459929475$gmane$org@suse.cz>
References: <1459321935-3655-1-git-send-email-minchan@kernel.org>
	<1459321935-3655-2-git-send-email-minchan@kernel.org>
	<56FE706D.7080507@suse.cz> <20160404013917.GC6543@bbox>
	<20160404044458.GA20250@hori1.linux.bs1.fc.nec.co.jp>
	<57027E47.7070909@suse.cz>
	<20160405015402.GA30962@hori1.linux.bs1.fc.nec.co.jp>
	<57037562.3040203@suse.cz>
	<20160406005403.GA29576@hori1.linux.bs1.fc.nec.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20160406005403.GA29576@hori1.linux.bs1.fc.nec.co.jp>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
Cc: Rik van Riel <riel@redhat.com>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, YiPing Xu <xuyiping@hisilicon.com>, "aquini@redhat.com" <aquini@redhat.com>, "rknize@motorola.com" <rknize@motorola.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>, Chan Gyun Jeong <chan.jeong@lge.com>, Hugh Dickins <hughd@google.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "bfields@fieldses.org" <bfields@fieldses.org>, Minchan Kim <minchan@kernel.org>, Gioh Kim <gi-oh.kim@profitbricks.com>, Mel Gorman <mgorman@suse.de>, Sangseok Lee <sangseok.lee@lge.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>, Andrew Morton <akpm@linux-foundation.org>, "jlayton@poochiereds.net" <jlayton@poochiereds.net>, "koct9i@gmail.com" <koct9i@gmail.com>, Al Viro <viro@ZenIV.linux.org.uk>
List-Id: virtualization@lists.linuxfoundation.org

On 04/06/2016 02:54 AM, Naoya Horiguchi wrote:
> On Tue, Apr 05, 2016 at 10:20:50AM +0200, Vlastimil Babka wrote:
>>
>> So you agree that this race is a bug? It may turn a soft-offline attempt
>> into a killed process. In that case we should fix it the same as we are
>> fixing the failed migration case.
> 
> I agree, it's a bug, although rare and non-critical.
> 
>> Maybe it will be just enough to switch
>> the test_set_page_hwpoison() and put_page() calls?
> 
> Unfortunately that restores the other race with unpoison (described below.)
> Sorry for my bad/unclear statements, these races seems exclusive and a compatible
> solution is not found, so I prioritized fixing the latter one by comparing
> severity (the latter causes kernel crash,) which led to the current code.

Ah, I see. However unpoison is a functionality just for stress-testing,
and not expected to be used in production, right? So it's somewhat
unfortunate trade-off with danger of soft-offlining killing an unrelated
process.

>>> And another practical thing is the race with unpoison_memory() as described
>>> in commit da1b13ccfbebe. unpoison_memory() properly works only for properly
>>> poisoned pages, so doing unpoison for in-use hwpoisoned pages is fragile.
>>> That's why I'd like to avoid setting PageHWPoison for in-use pages if possible.
>>>
>>>> (Also, which part prevents pages with PageHWPoison to be allocated
>>>> again, anyway? I can't find it and test_set_page_hwpoison() doesn't
>>>> remove from buddy freelists).
>>>
>>> check_new_page() in mm/page_alloc.c should prevent reallocation of PageHWPoison.
>>> As you pointed out, memory error handler doens't remove it from buddy freelists.
>>
>> Oh, I see. It's using __PG_HWPOISON wrapper, so I didn't notice it when
>> searching. In any case that results in a bad_page() warning, right? Is
>> it desirable for a soft-offlined page?
> 
> That's right, and the bad_page warning might be too strong for soft offlining.
> We can't tell which of memory_failure/soft_offline_page a PageHWPoison came
> from, but users can find other lines in dmesg which should tell that.
> And memory error events can hit buddy pages directly, in that case we still
> need the check in check_new_page().

Ah, ok.

>> If we didn't free poisoned pages
>> to buddy system, they wouldn't trigger this warning.
> 
> Actually, we didn't free at commit add05cecef80 ("mm: soft-offline: don't free
> target page in successful page migration"), but that's was reverted in
> commit f4c18e6f7b5b ("mm: check __PG_HWPOISON separately from PAGE_FLAGS_CHECK_AT_*").
> Now I start thinking the revert was a bad decision, so I'll dig this problem again.

Good.

>>> BTW, it might be a bit off-topic, but recently I felt that check_new_page()
>>> might be improvable, because when check_new_page() returns 1, the whole buddy
>>> block (not only the bad page) seems to be leaked from buddy freelist.
>>> For example, if thp (order 9) is requested, and PageHWPoison (or any other
>>> types of bad pages) is found in an order 9 block, all 512 page are discarded.
>>> Unpoison can't bring it back to buddy.
>>> So, some code to split buddy block including bad page (and recovering code from
>>> unpoison) might be helpful, although that's another story ...
>>
>> Hm sounds like another argument for not freeing the page to buddy lists
>> in the first place. Maybe a hook in free_pages_check()?
> 
> Sounds a good idea. I'll try it, too.

So what I think could hopefully work is to replace the put_page() after
migration with a hwpoison-specific construct that does something like:

if (put_page_testzero(page))
     if (test_set_page_hwpoison()) ...
     __put_page()

With some more thought about what other parts of put_page() apply - how
to handle compound pages and zone-device pages.

That should hopefully be the safest course. When put_page_testzero()
succeeds, there should be no other (current of near-future) users of the
page, and we can still do whatever we need before releasing to
__put_page(). I.e. set the HWPoison flag, and maybe combine this with
modification to free_pages_check() to divert it from becoming a buddy page.

It should be even safer than the current "put_page();
test_set_page_hwpoison();" approach in that we are currently not
guaranteed that the put_page() is indeed releasing the last pin, but we
set HWPoison in any case. Although we have just migrated the page away,
there might be a pfn scanner holding its pin and checking the page.
Hopefully no such scanner has a path that would break on HWPoison flag,
but I don't know. By not setting the HWpoison when we don't succeed
put_page_testzero(), we are safer. It's true the page might stay
unpoisoned due to a temporary pin, but the process data was migrated
away which is the important part, and userspace can retry anyway?
