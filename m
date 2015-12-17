From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH] virtio_ring: use smp_store_mb
Date: Thu, 17 Dec 2015 15:52:24 +0000
Message-ID: <20151217155224.GA24108__24871.2756591432$1450367574$gmane$org@arm.com>
References: <1450347932-16325-1-git-send-email-mst@redhat.com>
	<20151217112222.GC6375@twins.programming.kicks-ass.net>
	<20151217151705-mutt-send-email-mst@redhat.com>
	<20151217140212.GB6344@twins.programming.kicks-ass.net>
	<20151217163412-mutt-send-email-mst@redhat.com>
	<20151217150917.GP6373@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20151217150917.GP6373@twins.programming.kicks-ass.net>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, Alexander Duyck <alexander.duyck@gmail.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Dec 17, 2015 at 04:09:17PM +0100, Peter Zijlstra wrote:
> On Thu, Dec 17, 2015 at 04:34:57PM +0200, Michael S. Tsirkin wrote:
> > On Thu, Dec 17, 2015 at 03:02:12PM +0100, Peter Zijlstra wrote:
> 
> > > > 	commit 9e1a27ea42691429e31f158cce6fc61bc79bb2e9
> > > > 	Author: Alexander Duyck <alexander.h.duyck@redhat.com>
> > > > 	Date:   Mon Apr 13 21:03:49 2015 +0930
> > > > 
> > > > 	    virtio_ring: Update weak barriers to use dma_wmb/rmb
> > > 
> > > That commit doesn't make any sense. dma_*mb() explicitly does _NOT_
> > > cover the smp_*mb() part.
> > > 
> > > Again, look at the ARM definitions, the smp_*mb() primitives use the
> > > inner coherence stuff, while the dma_*mb() primitives use the outer
> > > coherent stuff.
> > 
> > Does outer coherent imply inner coherent?
> > 
> > > the *mb() primitives cover both.
> 
> I do not think so, but lets add Will, he dreams this stuff.

Right, and I don't sleep well these days.

Anyway, the outer-shareable domain (osh) is a superset of the
inner-shareable domain (ish). The inner-shareable domain contains the
CPUs and any peripherals that you and I would call "cache coherent". The
outer-shareable domain extends this to cover a strange set of "less cache
coherent" devices, which we would just call "not cache coherent" for the
purposes of Linux. Normal, non-cacheable memory (i.e. the memory type we
use for non-coherent DMA buffers) is outer-shareable.

Since the barrier macros don't know if the device is coherent or not, we
use the stronger semantics of outer-shareable.

I've not been following the thread, but I reckon we could add dma_mb()
(as dmb(osh) on arm), then use that to build dma_load_acquire and
dma_store_release accessors. On arm64, we could probably use the
acquire/release instructions directly, since they inherit the shareability
domain of the address (which has the nice property of being inner-shareable
for coherent devices).

The massive pain with adding new accessors is defining the semantics.
memory-barriers.txt is already lacking for the CPU side, and we're
struggling to express the kind of transitivity guarantees we provide
today, let alone with new primitives :(

Will
