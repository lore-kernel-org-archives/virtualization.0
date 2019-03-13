From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [RFC PATCH V2 0/5] vhost: accelerate metadata access through
	vmap()
Date: Wed, 13 Mar 2019 09:05:29 -0700
Message-ID: <20190313160529.GB15134__20662.2717365221$1552493142$gmane$org@infradead.org>
References: <56374231-7ba7-0227-8d6d-4d968d71b4d6@redhat.com>
	<20190311095405-mutt-send-email-mst@kernel.org>
	<20190311.111413.1140896328197448401.davem@davemloft.net>
	<6b6dcc4a-2f08-ba67-0423-35787f3b966c@redhat.com>
	<20190311235140-mutt-send-email-mst@kernel.org>
	<76c353ed-d6de-99a9-76f9-f258074c1462@redhat.com>
	<20190312075033-mutt-send-email-mst@kernel.org>
	<1552405610.3083.17.camel@HansenPartnership.com>
	<20190312200450.GA25147@redhat.com>
	<1552424017.14432.11.camel@HansenPartnership.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1552424017.14432.11.camel@HansenPartnership.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>, linux-parisc@vger.kernel.org, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, hch@infradead.org, linux-mm@kvack.org, David Miller <davem@davemloft.net>, linux-arm-kernel@lists.infradead.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Mar 12, 2019 at 01:53:37PM -0700, James Bottomley wrote:
> I've got to say: optimize what?  What code do we ever have in the
> kernel that kmap's a page and then doesn't do anything with it? You can
> guarantee that on kunmap the page is either referenced (needs
> invalidating) or updated (needs flushing). The in-kernel use of kmap is
> always
> 
> kmap
> do something with the mapped page
> kunmap
> 
> In a very short interval.  It seems just a simplification to make
> kunmap do the flush if needed rather than try to have the users
> remember.  The thing which makes this really simple is that on most
> architectures flush and invalidate is the same operation.  If you
> really want to optimize you can use the referenced and dirty bits on
> the kmapped pte to tell you what operation to do, but if your flush is
> your invalidate, you simply assume the data needs flushing on kunmap
> without checking anything.

I agree that this would be a good way to simplify the API.   Now
we'd just need volunteers to implement this for all architectures
that need cache flushing and then remove the explicit flushing in
the callers..

> > Which means after we fix vhost to add the flush_dcache_page after
> > kunmap, Parisc will get a double hit (but it also means Parisc was
> > the only one of those archs needed explicit cache flushes, where
> > vhost worked correctly so far.. so it kinds of proofs your point of
> > giving up being the safe choice).
> 
> What double hit?  If there's no cache to flush then cache flush is a
> no-op.  It's also a highly piplineable no-op because the CPU has the L1
> cache within easy reach.  The only event when flush takes a large
> amount time is if we actually have dirty data to write back to main
> memory.

I've heard people complaining that on some microarchitectures even
no-op cache flushes are relatively expensive.  Don't ask me why,
but if we can easily avoid double flushes we should do that.
