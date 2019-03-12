From: Andrea Arcangeli <aarcange@redhat.com>
Subject: Re: [RFC PATCH V2 0/5] vhost: accelerate metadata access through
	vmap()
Date: Tue, 12 Mar 2019 17:53:21 -0400
Message-ID: <20190312215321.GC25147__35279.457683076$1552427618$gmane$org@redhat.com>
References: <20190311.111413.1140896328197448401.davem@davemloft.net>
	<6b6dcc4a-2f08-ba67-0423-35787f3b966c@redhat.com>
	<20190311235140-mutt-send-email-mst@kernel.org>
	<76c353ed-d6de-99a9-76f9-f258074c1462@redhat.com>
	<20190312075033-mutt-send-email-mst@kernel.org>
	<1552405610.3083.17.camel@HansenPartnership.com>
	<20190312200450.GA25147@redhat.com>
	<1552424017.14432.11.camel@HansenPartnership.com>
	<20190312211117.GB25147@redhat.com>
	<1552425555.14432.14.camel@HansenPartnership.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1552425555.14432.14.camel@HansenPartnership.com>
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
Cc: linux-parisc@vger.kernel.org, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, hch@infradead.org, linux-mm@kvack.org, David Miller <davem@davemloft.net>, linux-arm-kernel@lists.infradead.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Mar 12, 2019 at 02:19:15PM -0700, James Bottomley wrote:
> I mean in the sequence
> 
> flush_dcache_page(page);
> flush_dcache_page(page);
> 
> The first flush_dcache_page did all the work and the second it a
> tightly pipelined no-op.  That's what I mean by there not really being
> a double hit.

Ok I wasn't sure it was clear there was a double (profiling) hit on
that function.

void flush_kernel_dcache_page_addr(void *addr)
{
	unsigned long flags;

	flush_kernel_dcache_page_asm(addr);
	purge_tlb_start(flags);
	pdtlb_kernel(addr);
	purge_tlb_end(flags);
}

#define purge_tlb_start(flags)	spin_lock_irqsave(&pa_tlb_lock, flags)
#define purge_tlb_end(flags)	spin_unlock_irqrestore(&pa_tlb_lock, flags)

You got a system-wide spinlock in there that won't just go away the
second time. So it's a bit more than a tightly pipelined "noop".

Your logic of adding the flush on kunmap makes sense, all I'm saying
is that it's sacrificing some performance for safety. You asked
"optimized what", I meant to optimize away all the above quoted code
that will end running twice for each vhost set_bit when it should run
just once like in other archs. And it clearly paid off until now
(until now it run just once and it was the only safe one).

Before we can leverage your idea to flush the dcache on kunmap in
common code without having to sacrifice performance in arch code, we'd
need to change all other archs to add the cache flushes on kunmap too,
and then remove the cache flushes from the other places like copy_page
or we'd waste CPU. Then you'd have the best of both words, no double
flush and kunmap would be enough.

Thanks,
Andrea
