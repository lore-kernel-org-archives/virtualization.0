From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [PATCH] tracing/events: Add bounce tracing to swiotbl-xen
Date: Tue, 3 Sep 2013 08:42:38 -0400
Message-ID: <20130903124237.GB9870@konrad-lan.dumpdata.com>
References: <1377208048-8963-1-git-send-email-zoltan.kiss@citrix.com>
	<20130823125533.GC14306@konrad-lan.dumpdata.com>
	<5224D0D6.40908@citrix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <5224D0D6.40908@citrix.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Zoltan Kiss <zoltan.kiss@citrix.com>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, xen-devel@lists.xensource.com, Frederic Weisbecker <fweisbec@gmail.com>, linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, virtualization@lists.linux-foundation.org, Ingo Molnar <mingo@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Sep 02, 2013 at 06:54:30PM +0100, Zoltan Kiss wrote:
> On 23/08/13 13:55, Konrad Rzeszutek Wilk wrote:
> >On Thu, Aug 22, 2013 at 10:47:28PM +0100, Zoltan Kiss wrote:
> >>Ftrace is currently not able to detect when SWIOTLB has to do double buffering
> >>under Xen. You can only see it indirectly in function_graph, when
> >>xen_swiotlb_map_page() doesn't stop after range_straddles_page_boundary(), but
> >>calls spinlock functions, memcpy() and xen_phys_to_bus() as well. This patch
> >>introduces the swiotlb-xen:bounced event, which also prints out the following
> >>informations to help you find out why bouncing happened:
> >>
> >>dev_name: 0000:08:00.0 dma_mask=ffffffffffffffff dev_addr=9149f000 size=32768
> >>swiotlb_force=0
> >>
> >>If (dev_addr + size + 1) > dma_mask, the buffer is out of the device's DMA
> >>range. If swiotlb_force == 1, you should really change the kernel parameters.
> >>Otherwise, the buffer is not contiguous in mfn space.
> >
> >Could this be in the lib/swiotlb.c instead?
> 
> You mean instead of drivers/xen/swiotlb-xen.c ? This is a Xen
> SWIOTLB specific thing, it will hit exactly at the point when double
> buffering becomes sure - under Xen.

Correct. The double buffering code is being run in lib/swiotlb.c not the
xen-swiotlb.c. Hence the question of why not move the tracing in there.

> But I can rename the tracer and call trace_bounced in
> swiotlb_map_page as well, so it can be used for normal SWIOTLB
> bounce tracing as well. Is it OK for you?

Yes. And please (if it adds a benefit) also for unmap/sync which can trigger
the bounce buffer.

Or if it makes sense just for the bounce buffer copying - then just
leave it at that. Thanks.
> 
> Regards,
> 
> Zoli
