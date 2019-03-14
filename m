From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [RFC PATCH V2 0/5] vhost: accelerate metadata access through
	vmap()
Date: Thu, 14 Mar 2019 06:42:21 -0400
Message-ID: <20190314064004-mutt-send-email-mst__39379.589683243$1552560160$gmane$org@kernel.org>
References: <20190311.111413.1140896328197448401.davem@davemloft.net>
	<6b6dcc4a-2f08-ba67-0423-35787f3b966c@redhat.com>
	<20190311235140-mutt-send-email-mst@kernel.org>
	<76c353ed-d6de-99a9-76f9-f258074c1462@redhat.com>
	<20190312075033-mutt-send-email-mst@kernel.org>
	<1552405610.3083.17.camel@HansenPartnership.com>
	<20190312200450.GA25147@redhat.com>
	<1552424017.14432.11.camel@HansenPartnership.com>
	<20190313160529.GB15134@infradead.org>
	<1552495028.3022.37.camel@HansenPartnership.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1552495028.3022.37.camel@HansenPartnership.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>, linux-parisc@vger.kernel.org, kvm@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Christoph Hellwig <hch@infradead.org>, linux-mm@kvack.org, David Miller <davem@davemloft.net>, linux-arm-kernel@lists.infradead.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Mar 13, 2019 at 09:37:08AM -0700, James Bottomley wrote:
> On Wed, 2019-03-13 at 09:05 -0700, Christoph Hellwig wrote:
> > On Tue, Mar 12, 2019 at 01:53:37PM -0700, James Bottomley wrote:
> > > I've got to say: optimize what?  What code do we ever have in the
> > > kernel that kmap's a page and then doesn't do anything with it? You
> > > can
> > > guarantee that on kunmap the page is either referenced (needs
> > > invalidating) or updated (needs flushing). The in-kernel use of
> > > kmap is
> > > always
> > > 
> > > kmap
> > > do something with the mapped page
> > > kunmap
> > > 
> > > In a very short interval.  It seems just a simplification to make
> > > kunmap do the flush if needed rather than try to have the users
> > > remember.  The thing which makes this really simple is that on most
> > > architectures flush and invalidate is the same operation.  If you
> > > really want to optimize you can use the referenced and dirty bits
> > > on the kmapped pte to tell you what operation to do, but if your
> > > flush is your invalidate, you simply assume the data needs flushing
> > > on kunmap without checking anything.
> > 
> > I agree that this would be a good way to simplify the API.   Now
> > we'd just need volunteers to implement this for all architectures
> > that need cache flushing and then remove the explicit flushing in
> > the callers..
> 
> Well, it's already done on parisc ...  I can help with this if we agree
> it's the best way forward.  It's really only architectures that
> implement flush_dcache_page that would need modifying.
> 
> It may also improve performance because some kmap/use/flush/kunmap
> sequences have flush_dcache_page() instead of
> flush_kernel_dcache_page() and the former is hugely expensive and
> usually unnecessary because GUP already flushed all the user aliases.
> 
> In the interests of full disclosure the reason we do it for parisc is
> because our later machines have problems even with clean aliases.  So
> on most VIPT systems, doing kmap/read/kunmap creates a fairly harmless
> clean alias.  Technically it should be invalidated, because if you
> remap the same page to the same colour you get cached stale data, but
> in practice the data is expired from the cache long before that
> happens, so the problem is almost never seen if the flush is forgotten.
>  Our problem is on the P9xxx processor: they have a L1/L2 VIPT L3 PIPT
> cache.  As the L1/L2 caches expire clean data, they place the expiring
> contents into L3, but because L3 is PIPT, the stale alias suddenly
> becomes the default for any read of they physical page because any
> update which dirtied the cache line often gets written to main memory
> and placed into the L3 as clean *before* the clean alias in L1/L2 gets
> expired, so the older clean alias replaces it.
> 
> Our only recourse is to kill all aliases with prejudice before the
> kernel loses ownership.
> 
> > > > Which means after we fix vhost to add the flush_dcache_page after
> > > > kunmap, Parisc will get a double hit (but it also means Parisc
> > > > was the only one of those archs needed explicit cache flushes,
> > > > where vhost worked correctly so far.. so it kinds of proofs your
> > > > point of giving up being the safe choice).
> > > 
> > > What double hit?  If there's no cache to flush then cache flush is
> > > a no-op.  It's also a highly piplineable no-op because the CPU has
> > > the L1 cache within easy reach.  The only event when flush takes a
> > > large amount time is if we actually have dirty data to write back
> > > to main memory.
> > 
> > I've heard people complaining that on some microarchitectures even
> > no-op cache flushes are relatively expensive.  Don't ask me why,
> > but if we can easily avoid double flushes we should do that.
> 
> It's still not entirely free for us.  Our internal cache line is around
> 32 bytes (some have 16 and some have 64) but that means we need 128
> flushes for a page ... we definitely can't pipeline them all.  So I
> agree duplicate flush elimination would be a small improvement.
> 
> James

I suspect we'll keep the copyXuser path around for 32 bit anyway -
right Jason?
So we can also keep using that on parisc...

-- 
MST
