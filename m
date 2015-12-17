From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] virtio_ring: use smp_store_mb
Date: Thu, 17 Dec 2015 15:02:12 +0100
Message-ID: <20151217140212.GB6344__28721.431134227$1450360963$gmane$org@twins.programming.kicks-ass.net>
References: <1450347932-16325-1-git-send-email-mst@redhat.com>
	<20151217112222.GC6375@twins.programming.kicks-ass.net>
	<20151217151705-mutt-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20151217151705-mutt-send-email-mst@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Dec 17, 2015 at 03:26:29PM +0200, Michael S. Tsirkin wrote:
> > Note that virtio_mb() is weirdly inconsistent with virtio_[rw]mb() in
> > that they use dma_* ops for weak_barriers, while virtio_mb() uses
> > smp_mb().
> 
> It's a hack really. I think I'll clean it up a bit to
> make it more consistent.
> 
> To simplify things, you may consider things before
> the optimization brought in by
> 	commit 9e1a27ea42691429e31f158cce6fc61bc79bb2e9
> 	Author: Alexander Duyck <alexander.h.duyck@redhat.com>
> 	Date:   Mon Apr 13 21:03:49 2015 +0930
> 
> 	    virtio_ring: Update weak barriers to use dma_wmb/rmb

That commit doesn't make any sense. dma_*mb() explicitly does _NOT_
cover the smp_*mb() part.

Again, look at the ARM definitions, the smp_*mb() primitives use the
inner coherence stuff, while the dma_*mb() primitives use the outer
coherent stuff.

the *mb() primitives cover both.
