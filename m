From: Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v3 02/16] mm/compaction: support non-lru movable page
	migration
Date: Mon, 4 Apr 2016 15:24:34 +0200
Message-ID: <57026B12.6060000__32076.3888689273$1459776302$gmane$org@suse.cz>
References: <1459321935-3655-1-git-send-email-minchan@kernel.org>
	<1459321935-3655-3-git-send-email-minchan@kernel.org>
	<56FEE82A.30602@suse.cz> <20160404051225.GA6838@bbox>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20160404051225.GA6838@bbox>
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
Cc: jlayton@poochiereds.net, Rik van Riel <riel@redhat.com>, YiPing Xu <xuyiping@hisilicon.com>, aquini@redhat.com, rknize@motorola.com, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Chan Gyun Jeong <chan.jeong@lge.com>, Hugh Dickins <hughd@google.com>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org, bfields@fieldses.org, linux-mm@kvack.org, Gioh Kim <gurugio@hanmail.net>, Gioh Kim <gi-oh.kim@profitbricks.com>, Mel Gorman <mgorman@suse.de>, Sangseok Lee <sangseok.lee@lge.com>, Andrew Morton <akpm@linux-foundation.org>, Joonsoo Kim <iamjoonsoo.kim@lge.com>, koct9i@gmail.com, Al Viro <viro@ZenIV.linux.org.uk>
List-Id: virtualization@lists.linuxfoundation.org

On 04/04/2016 07:12 AM, Minchan Kim wrote:
> On Fri, Apr 01, 2016 at 11:29:14PM +0200, Vlastimil Babka wrote:
>> Might have been better as a separate migration patch and then a
>> compaction patch. It's prefixed mm/compaction, but most changed are
>> in mm/migrate.c
>
> Indeed. The title is rather misleading but not sure it's a good idea
> to separate compaction and migration part.

Guess it's better to see the new functions together with its user after 
all, OK.

> I will just resend to change the tile from "mm/compaction" to
> "mm/migration".

OK!

>> Also I'm a bit uncomfortable how isolate_movable_page() blindly expects that
>> page->mapping->a_ops->isolate_page exists for PageMovable() pages.
>> What if it's a false positive on a PG_reclaim page? Can we rely on
>> PG_reclaim always (and without races) implying PageLRU() so that we
>> don't even attempt isolate_movable_page()?
>
> For now, we shouldn't have such a false positive because PageMovable
> checks page->_mapcount == PAGE_MOVABLE_MAPCOUNT_VALUE as well as PG_movable
> under PG_lock.
>
> But I read your question about user-mapped drvier pages so we cannot
> use _mapcount anymore so I will find another thing. A option is this.
>
> static inline int PageMovable(struct page *page)
> {
>          int ret = 0;
>          struct address_space *mapping;
>          struct address_space_operations *a_op;
>
>          if (!test_bit(PG_movable, &(page->flags))
>                  goto out;
>
>          mapping = page->mapping;
>          if (!mapping)
>                  goto out;
>
>          a_op = mapping->a_op;
>          if (!aop)
>                  goto out;
>          if (a_op->isolate_page)
>                  ret = 1;
> out:
>          return ret;
>
> }
>
> It works under PG_lock but with this, we need trylock_page to peek
> whether it's movable non-lru or not for scanning pfn.

Hm I hoped that with READ_ONCE() we could do the peek safely without 
trylock_page, if we use it only as a heuristic. But I guess it would 
require at least RCU-level protection of the 
page->mapping->a_op->isolate_page chain.

> For avoiding that, we need another function to peek which just checks
> PG_movable bit instead of all things.
>
>
> /*
>   * If @page_locked is false, we cannot guarantee page->mapping's stability
>   * so just the function checks with PG_movable which could be false positive
>   * so caller should check it again under PG_lock to check a_ops->isolate_page.
>   */
> static inline int PageMovable(struct page *page, bool page_locked)
> {
>          int ret = 0;
>          struct address_space *mapping;
>          struct address_space_operations *a_op;
>
>          if (!test_bit(PG_movable, &(page->flags))
>                  goto out;
>
>          if (!page_locked) {
>                  ret = 1;
>                  goto out;
>          }
>
>          mapping = page->mapping;
>          if (!mapping)
>                  goto out;
>
>          a_op = mapping->a_op;
>          if (!aop)
>                  goto out;
>          if (a_op->isolate_page)
>                  ret = 1;
> out:
>          return ret;
> }

I wouldn't put everything into single function, but create something 
like __PageMovable() just for the unlocked peek. Unlike the 
zone->lru_lock, we don't keep page_lock() across iterations in 
isolate_migratepages_block(), as obviously each page has different lock.
So the page_locked parameter would be always passed as constant, and at 
that point it's better to have separate functions.

So I guess the question is how many false positives from overlap with 
PG_reclaim the scanner will hit if we give up on 
PAGE_MOVABLE_MAPCOUNT_VALUE, as that will increase number of page locks 
just to realize that it's not actual PageMovable() page...

> Thanks for detail review, Vlastimil!
> I will resend new versions after vacation in this week.

You're welcome, great!
