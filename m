From: Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH v7 00/12] Support non-lru page migration
Date: Thu, 2 Jun 2016 00:40:11 +0200
Message-ID: <20160601224011.GC7231@phenom.ffwll.local>
References: <1464736881-24886-1-git-send-email-minchan@kernel.org>
	<20160601144151.c9e5c560be29cae9a3ff1f1e@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20160601144151.c9e5c560be29cae9a3ff1f1e@linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Rik van Riel <riel@redhat.com>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Rafael Aquini <aquini@redhat.com>, linux-mm@kvack.org, Chan Gyun Jeong <chan.jeong@lge.com>, Jonathan Corbet <corbet@lwn.net>, Hugh Dickins <hughd@google.com>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org, John Einar Reitan <john.reitan@foss.arm.com>, Minchan Kim <minchan@kernel.org>, Chulmin Kim <cmlaika.kim@samsung.com>, Gioh Kim <gi-oh.kim@profitbricks.com>, Konstantin Khlebnikov <koct9i@gmail.com>, Sangseok Lee <sangseok.lee@lge.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>, Kyeongdon Kim <kyeongdon.kim@lge.com>, Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>, Vlastimil Babka <vbabka@suse.cz>, Mel Gorman <mgorman@suse.de>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Jun 01, 2016 at 02:41:51PM -0700, Andrew Morton wrote:
> On Wed,  1 Jun 2016 08:21:09 +0900 Minchan Kim <minchan@kernel.org> wrote:
> 
> > Recently, I got many reports about perfermance degradation in embedded
> > system(Android mobile phone, webOS TV and so on) and easy fork fail.
> > 
> > The problem was fragmentation caused by zram and GPU driver mainly.
> > With memory pressure, their pages were spread out all of pageblock and
> > it cannot be migrated with current compaction algorithm which supports
> > only LRU pages. In the end, compaction cannot work well so reclaimer
> > shrinks all of working set pages. It made system very slow and even to
> > fail to fork easily which requires order-[2 or 3] allocations.
> > 
> > Other pain point is that they cannot use CMA memory space so when OOM
> > kill happens, I can see many free pages in CMA area, which is not
> > memory efficient. In our product which has big CMA memory, it reclaims
> > zones too exccessively to allocate GPU and zram page although there are
> > lots of free space in CMA so system becomes very slow easily.
> 
> But this isn't presently implemented for GPU drivers or for CMA, yes?
> 
> What's the story there?

Broken (out-of-tree) drivers that don't allocate their gpu stuff
correctly.  There's piles of drivers that get_user_page all over the place
but then fail to timely get off these pages again. The fix is to get off
those pages again (either by unpinning timely, or registering an
mmu_notifier if the driver wants to keep the pages pinned indefinitely, as
a caching optimization).

At least that's my guess, and iirc it was confirmed first time around this
series showed up.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
