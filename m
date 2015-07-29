From: Mel Gorman <mgorman@techsingularity.net>
Subject: Re: [PATCH 0/4] enable migration of driver pages
Date: Wed, 29 Jul 2015 11:49:45 +0100
Message-ID: <20150729104945.GA30872__49672.108263667$1438620826$gmane$org@techsingularity.net>
References: <1436776519-17337-1-git-send-email-gioh.kim@lge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1436776519-17337-1-git-send-email-gioh.kim@lge.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Gioh Kim <gioh.kim@lge.com>
Cc: aquini@redhat.com, mst@redhat.com, linux-api@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org, bfields@fieldses.org, minchan@kernel.org, Gioh Kim <gurugio@hanmail.net>, linux-mm@kvack.org, viro@zeniv.linux.org.uk, akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org, jlayton@poochiereds.net, koct9i@gmail.com, iamjoonsoo.kim@lge.com, vbabka@suse.cz
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Jul 13, 2015 at 05:35:15PM +0900, Gioh Kim wrote:
> My ARM-based platform occured severe fragmentation problem after long-term
> (several days) test. Sometimes even order-3 page allocation failed. It has
> memory size 512MB ~ 1024MB. 30% ~ 40% memory is consumed for graphic processing
> and 20~30 memory is reserved for zram.
> 

The primary motivation of this series is to reduce fragmentation by allowing
more kernel pages to be moved. Conceptually that is a worthwhile goal but
there should be at least one major in-kernel user and while balloon
pages were a good starting point, I think we really need to see what the
zram changes look like at the same time.

> I found that many pages of GPU driver and zram are non-movable pages. So I
> reported Minchan Kim, the maintainer of zram, and he made the internal 
> compaction logic of zram. And I made the internal compaction of GPU driver.
> 

I am not familiar with the internals of zram but I took a look at what
it merged.  At a glance the compaction it implements and what you need are
are different in important respects. The core ability to move a zsmalloc
object is useful but the motivation of zram compaction appears to be
reducing the memory footprint. You need to reduce fragmentation which is
not the same. You could be faced with a situation where a full page in an
awkward place. Then there are three choices I can think of quickly and
probably more

1. You can move the whole page to another whole page and update all the
   references. This would play nicely with how compactions migrate and
   free scanner operates. However, you need free memory to move it

2. You could try moving the full page into other zsmalloc pages so that
   memory usage is also potentially reduced. This would work better with
   what Minchan intended but then there is the problem of discovery.
   Potentially it means though that another address space callback is
   required to nominate a target migration page

3. Hybrid approach. First trigger the zsmalloc compaction as it
   currently exists, then kick of compaction and move whole pages
   regardless of their content. The downside here is that it's expensive
   and potentially copies data multiple times but it's going to be
   easier to implement than 2.

1 would be the logical starting point, 3 is probably most effective even
if it's expensive and 2 is probably the best overall if the search costs
can be controlled.

This is a lot more complex than what balloon requires which is why I
would like to see it pinned down before new address_space operations are
created. Once they are created and drivers start using them then we lose
a lot of flexibilty and fixing the design becomes a lot harder.

With that in mind, I'll still read the rest of the series.

-- 
Mel Gorman
SUSE Labs
