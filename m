From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: Re: [PATCH v7 00/12] Support non-lru page migration
Date: Thu, 16 Jun 2016 17:42:11 +0900
Message-ID: <20160616084211.GA432__40299.7999838137$1466066553$gmane$org@swordfish>
References: <1464736881-24886-1-git-send-email-minchan@kernel.org>
	<20160615075909.GA425@swordfish> <20160615231248.GI17127@bbox>
	<20160616024827.GA497@swordfish> <20160616025800.GO17127@bbox>
	<20160616042343.GA516@swordfish> <20160616044710.GP17127@bbox>
	<20160616052209.GB516@swordfish> <20160616064753.GR17127@bbox>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20160616064753.GR17127@bbox>
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
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, Chulmin Kim <cmlaika.kim@samsung.com>, Sangseok Lee <sangseok.lee@lge.com>, Konstantin Khlebnikov <koct9i@gmail.com>, Rafael Aquini <aquini@redhat.com>, Jonathan Corbet <corbet@lwn.net>, Hugh Dickins <hughd@google.com>, Gioh Kim <gi-oh.kim@profitbricks.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>, Mel Gorman <mgorman@suse.de>, Rik van Riel <riel@redhat.com>, Vlastimil Babka <vbabka@suse.cz>, Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>, Chan Gyun Jeong <chan.jeong@lge.com>, linux-kernel@vger.kernel.org, John Einar Reitan <john.reitan@foss.arm.com>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Kyeongdon Kim <kyeongdon.kim@lge.com>
List-Id: virtualization@lists.linuxfoundation.org

On (06/16/16 15:47), Minchan Kim wrote:
> > [..]
> > > > this is what I'm getting with the [zsmalloc: keep first object offset in struct page]
> > > > applied:  "count:0 mapcount:-127". which may be not related to zsmalloc at this point.
> > > > 
> > > > kernel: BUG: Bad page state in process khugepaged  pfn:101db8
> > > > kernel: page:ffffea0004076e00 count:0 mapcount:-127 mapping:          (null) index:0x1
> > > 
> > > Hm, it seems double free.
> > > 
> > > It doen't happen if you disable zram? IOW, it seems to be related
> > > zsmalloc migration?
> > 
> > need to test more, can't confidently answer now.
> > 
> > > How easy can you reprodcue it? Could you bisect it?
> > 
> > it takes some (um.. random) time to trigger the bug.
> > I'll try to come up with more details.
> 
> Could you revert [1] and retest?
> 
> [1] mm/compaction: split freepages without holding the zone lock

ok, so this is not related to zsmalloc. finally manged to reproduce
it. will fork a separate thread.

	-ss
