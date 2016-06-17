From: Joonsoo Kim <iamjoonsoo.kim@lge.com>
Subject: Re: [PATCH v7 00/12] Support non-lru page migration
Date: Fri, 17 Jun 2016 16:28:48 +0900
Message-ID: <20160617072848.GC810__8113.4834014394$1466148417$gmane$org@js1304-P5Q-DELUXE>
References: <20160615075909.GA425@swordfish> <20160615231248.GI17127@bbox>
	<20160616024827.GA497@swordfish> <20160616025800.GO17127@bbox>
	<20160616042343.GA516@swordfish> <20160616044710.GP17127@bbox>
	<20160616052209.GB516@swordfish> <20160616064753.GR17127@bbox>
	<20160616084211.GA432@swordfish> <20160616100932.GS17127@bbox>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20160616100932.GS17127@bbox>
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
Cc: Rik van Riel <riel@redhat.com>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, Jonathan Corbet <corbet@lwn.net>, Chan Gyun Jeong <chan.jeong@lge.com>, Rafael Aquini <aquini@redhat.com>, Hugh Dickins <hughd@google.com>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org, John Einar Reitan <john.reitan@foss.arm.com>, linux-mm@kvack.org, Chulmin Kim <cmlaika.kim@samsung.com>, Gioh Kim <gi-oh.kim@profitbricks.com>, Konstantin Khlebnikov <koct9i@gmail.com>, Sangseok Lee <sangseok.lee@lge.com>, Andrew Morton <akpm@linux-foundation.org>, Kyeongdon Kim <kyeongdon.kim@lge.com>, Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>, Vlastimil Babka <vbabka@suse.cz>, Mel Gorman <mgorman@suse.de>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Jun 16, 2016 at 07:09:32PM +0900, Minchan Kim wrote:
> On Thu, Jun 16, 2016 at 05:42:11PM +0900, Sergey Senozhatsky wrote:
> > On (06/16/16 15:47), Minchan Kim wrote:
> > > > [..]
> > > > > > this is what I'm getting with the [zsmalloc: keep first object offset in struct page]
> > > > > > applied:  "count:0 mapcount:-127". which may be not related to zsmalloc at this point.
> > > > > > 
> > > > > > kernel: BUG: Bad page state in process khugepaged  pfn:101db8
> > > > > > kernel: page:ffffea0004076e00 count:0 mapcount:-127 mapping:          (null) index:0x1
> > > > > 
> > > > > Hm, it seems double free.
> > > > > 
> > > > > It doen't happen if you disable zram? IOW, it seems to be related
> > > > > zsmalloc migration?
> > > > 
> > > > need to test more, can't confidently answer now.
> > > > 
> > > > > How easy can you reprodcue it? Could you bisect it?
> > > > 
> > > > it takes some (um.. random) time to trigger the bug.
> > > > I'll try to come up with more details.
> > > 
> > > Could you revert [1] and retest?
> > > 
> > > [1] mm/compaction: split freepages without holding the zone lock
> > 
> > ok, so this is not related to zsmalloc. finally manged to reproduce
> > it. will fork a separate thread.
> 
> The reason I mentioned [1] is that it seems to have a bug.
> 
> isolate_freepages_block
>   __isolate_free_page
>     if(!zone_watermark_ok())
>       return 0;
>   list_add_tail(&page->lru, freelist);
> 
> However, the page is not isolated.
> Joonsoo?

Good job!
I will fix it soon.

Thanks.
