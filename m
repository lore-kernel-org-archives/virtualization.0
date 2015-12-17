From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] virtio_ring: use smp_store_mb
Date: Thu, 17 Dec 2015 16:09:17 +0100
Message-ID: <20151217150917.GP6373__17658.8839306079$1450364995$gmane$org@twins.programming.kicks-ass.net>
References: <1450347932-16325-1-git-send-email-mst@redhat.com>
	<20151217112222.GC6375@twins.programming.kicks-ass.net>
	<20151217151705-mutt-send-email-mst@redhat.com>
	<20151217140212.GB6344@twins.programming.kicks-ass.net>
	<20151217163412-mutt-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20151217163412-mutt-send-email-mst@redhat.com>
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
Cc: Will Deacon <will.deacon@arm.com>, qemu-devel@nongnu.org, Alexander Duyck <alexander.duyck@gmail.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Dec 17, 2015 at 04:34:57PM +0200, Michael S. Tsirkin wrote:
> On Thu, Dec 17, 2015 at 03:02:12PM +0100, Peter Zijlstra wrote:

> > > 	commit 9e1a27ea42691429e31f158cce6fc61bc79bb2e9
> > > 	Author: Alexander Duyck <alexander.h.duyck@redhat.com>
> > > 	Date:   Mon Apr 13 21:03:49 2015 +0930
> > > 
> > > 	    virtio_ring: Update weak barriers to use dma_wmb/rmb
> > 
> > That commit doesn't make any sense. dma_*mb() explicitly does _NOT_
> > cover the smp_*mb() part.
> > 
> > Again, look at the ARM definitions, the smp_*mb() primitives use the
> > inner coherence stuff, while the dma_*mb() primitives use the outer
> > coherent stuff.
> 
> Does outer coherent imply inner coherent?
> 
> > the *mb() primitives cover both.

I do not think so, but lets add Will, he dreams this stuff.
