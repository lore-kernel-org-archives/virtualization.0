From: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
Subject: Re: [PATCH v3 01/16] mm: use put_page to free page instead of
	putback_lru_page
Date: Wed, 6 Apr 2016 00:54:04 +0000
Message-ID: <20160406005403.GA29576@hori1.linux.bs1.fc.nec.co.jp>
References: <1459321935-3655-1-git-send-email-minchan@kernel.org>
	<1459321935-3655-2-git-send-email-minchan@kernel.org>
	<56FE706D.7080507@suse.cz> <20160404013917.GC6543@bbox>
	<20160404044458.GA20250@hori1.linux.bs1.fc.nec.co.jp>
	<57027E47.7070909@suse.cz>
	<20160405015402.GA30962@hori1.linux.bs1.fc.nec.co.jp>
	<57037562.3040203@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <57037562.3040203@suse.cz>
Content-Language: ja-JP
Content-ID: <B63A2058FEB6714FBB784846F111B38A@gisp.nec.co.jp>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Rik van Riel <riel@redhat.com>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, YiPing Xu <xuyiping@hisilicon.com>, "aquini@redhat.com" <aquini@redhat.com>, "rknize@motorola.com" <rknize@motorola.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>, Chan Gyun Jeong <chan.jeong@lge.com>, Hugh Dickins <hughd@google.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "bfields@fieldses.org" <bfields@fieldses.org>, Minchan Kim <minchan@kernel.org>, Gioh Kim <gi-oh.kim@profitbricks.com>, Mel Gorman <mgorman@suse.de>, Sangseok Lee <sangseok.lee@lge.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>, Andrew Morton <akpm@linux-foundation.org>, "jlayton@poochiereds.net" <jlayton@poochiereds.net>, "koct9i@gmail.com" <koct9i@gmail.com>, Al Viro <viro@ZenIV.linux.org.uk>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Apr 05, 2016 at 10:20:50AM +0200, Vlastimil Babka wrote:
> On 04/05/2016 03:54 AM, Naoya Horiguchi wrote:
> > On Mon, Apr 04, 2016 at 04:46:31PM +0200, Vlastimil Babka wrote:
> >> On 04/04/2016 06:45 AM, Naoya Horiguchi wrote:
> >>> On Mon, Apr 04, 2016 at 10:39:17AM +0900, Minchan Kim wrote:
> > ...
> >>>>>
> >>>>> Also (but not your fault) the put_page() preceding
> >>>>> test_set_page_hwpoison(page)) IMHO deserves a comment saying which
> >>>>> pin we are releasing and which one we still have (hopefully? if I
> >>>>> read description of da1b13ccfbebe right) otherwise it looks like
> >>>>> doing something with a page that we just potentially freed.
> >>>>
> >>>> Yes, while I read the code, I had same question. I think the releasing
> >>>> refcount is for get_any_page.
> >>>
> >>> As the other callers of page migration do, soft_offline_page expects the
> >>> migration source page to be freed at this put_page() (no pin remains.)
> >>> The refcount released here is from isolate_lru_page() in __soft_offline_page().
> >>> (the pin by get_any_page is released by put_hwpoison_page just after it.)
> >>>
> >>> .. yes, doing something just after freeing page looks weird, but that's
> >>> how PageHWPoison flag works. IOW, many other page flags are maintained
> >>> only during one "allocate-free" life span, but PageHWPoison still does
> >>> its job beyond it.
> >>
> >> But what prevents the page from being allocated again between put_page()
> >> and test_set_page_hwpoison()? In that case we would be marking page
> >> poisoned while still in use, which is the same as marking it while still
> >> in use after a failed migration?
> > 
> > Actually nothing prevents that race. But I think that the result of the race
> > is that the error page can be reused for allocation, which results in killing
> > processes at page fault time. Soft offline is kind of mild/precautious thing
> > (for correctable errors that don't require immediate handling), so killing
> > processes looks to me an overkill. And marking hwpoison means that we can no
> > longer do retry from userspace.
> 
> So you agree that this race is a bug? It may turn a soft-offline attempt
> into a killed process. In that case we should fix it the same as we are
> fixing the failed migration case.

I agree, it's a bug, although rare and non-critical.

> Maybe it will be just enough to switch
> the test_set_page_hwpoison() and put_page() calls?

Unfortunately that restores the other race with unpoison (described below.)
Sorry for my bad/unclear statements, these races seems exclusive and a compatible
solution is not found, so I prioritized fixing the latter one by comparing
severity (the latter causes kernel crash,) which led to the current code.

> > And another practical thing is the race with unpoison_memory() as described
> > in commit da1b13ccfbebe. unpoison_memory() properly works only for properly
> > poisoned pages, so doing unpoison for in-use hwpoisoned pages is fragile.
> > That's why I'd like to avoid setting PageHWPoison for in-use pages if possible.
> > 
> >> (Also, which part prevents pages with PageHWPoison to be allocated
> >> again, anyway? I can't find it and test_set_page_hwpoison() doesn't
> >> remove from buddy freelists).
> > 
> > check_new_page() in mm/page_alloc.c should prevent reallocation of PageHWPoison.
> > As you pointed out, memory error handler doens't remove it from buddy freelists.
> 
> Oh, I see. It's using __PG_HWPOISON wrapper, so I didn't notice it when
> searching. In any case that results in a bad_page() warning, right? Is
> it desirable for a soft-offlined page?

That's right, and the bad_page warning might be too strong for soft offlining.
We can't tell which of memory_failure/soft_offline_page a PageHWPoison came
from, but users can find other lines in dmesg which should tell that.
And memory error events can hit buddy pages directly, in that case we still
need the check in check_new_page().

> If we didn't free poisoned pages
> to buddy system, they wouldn't trigger this warning.

Actually, we didn't free at commit add05cecef80 ("mm: soft-offline: don't free
target page in successful page migration"), but that's was reverted in
commit f4c18e6f7b5b ("mm: check __PG_HWPOISON separately from PAGE_FLAGS_CHECK_AT_*").
Now I start thinking the revert was a bad decision, so I'll dig this problem again.

> > BTW, it might be a bit off-topic, but recently I felt that check_new_page()
> > might be improvable, because when check_new_page() returns 1, the whole buddy
> > block (not only the bad page) seems to be leaked from buddy freelist.
> > For example, if thp (order 9) is requested, and PageHWPoison (or any other
> > types of bad pages) is found in an order 9 block, all 512 page are discarded.
> > Unpoison can't bring it back to buddy.
> > So, some code to split buddy block including bad page (and recovering code from
> > unpoison) might be helpful, although that's another story ...
> 
> Hm sounds like another argument for not freeing the page to buddy lists
> in the first place. Maybe a hook in free_pages_check()?

Sounds a good idea. I'll try it, too.

Thanks,
Naoya Horiguchi
