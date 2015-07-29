From: Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH 0/4] enable migration of driver pages
Date: Wed, 29 Jul 2015 12:55:54 +0200
Message-ID: <20150729105554.GU16722__32654.5216994875$1438167379$gmane$org@phenom.ffwll.local>
References: <1436776519-17337-1-git-send-email-gioh.kim@lge.com>
	<20150729104945.GA30872@techsingularity.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20150729104945.GA30872@techsingularity.net>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Mel Gorman <mgorman@techsingularity.net>
Cc: aquini@redhat.com, mst@redhat.com, linux-api@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org, bfields@fieldses.org, minchan@kernel.org, Gioh Kim <gurugio@hanmail.net>, linux-mm@kvack.org, viro@zeniv.linux.org.uk, akpm@linux-foundation.org, Gioh Kim <gioh.kim@lge.com>, linux-fsdevel@vger.kernel.org, jlayton@poochiereds.net, koct9i@gmail.com, iamjoonsoo.kim@lge.com, vbabka@suse.cz
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Jul 29, 2015 at 11:49:45AM +0100, Mel Gorman wrote:
> On Mon, Jul 13, 2015 at 05:35:15PM +0900, Gioh Kim wrote:
> > My ARM-based platform occured severe fragmentation problem after long-term
> > (several days) test. Sometimes even order-3 page allocation failed. It has
> > memory size 512MB ~ 1024MB. 30% ~ 40% memory is consumed for graphic processing
> > and 20~30 memory is reserved for zram.
> > 
> 
> The primary motivation of this series is to reduce fragmentation by allowing
> more kernel pages to be moved. Conceptually that is a worthwhile goal but
> there should be at least one major in-kernel user and while balloon
> pages were a good starting point, I think we really need to see what the
> zram changes look like at the same time.

I think gpu drivers really would be the perfect candidate for compacting
kernel page allocations. And this also seems the primary motivation for
this patch series, so I think that's really what we should use to judge
these patches.

Of course then there's the seemingly eternal chicken/egg problem of
upstream gpu drivers for SoCs :(
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
