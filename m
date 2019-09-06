From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [RFC PATCH] virtio_ring: Use DMA API if guest memory is encrypted
Date: Fri, 6 Sep 2019 01:07:53 -0400
Message-ID: <20190906001220-mutt-send-email-mst@kernel.org>
References: <87zhrj8kcp.fsf@morokweng.localdomain>
	<20190810143038-mutt-send-email-mst@kernel.org>
	<20190810220702.GA5964@ram.ibm.com> <20190811055607.GA12488@lst.de>
	<20190811044431-mutt-send-email-mst@kernel.org>
	<20190812121532.GB9405@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190812121532.GB9405@lst.de>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Christoph Hellwig <hch@lst.de>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Alexey Kardashevskiy <aik@linux.ibm.com>, Ram Pai <linuxram@us.ibm.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Paul Mackerras <paulus@ozlabs.org>, iommu@lists.linux-foundation.org, David Gibson <david@gibson.dropbear.id.au>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Aug 12, 2019 at 02:15:32PM +0200, Christoph Hellwig wrote:
> On Sun, Aug 11, 2019 at 04:55:27AM -0400, Michael S. Tsirkin wrote:
> > On Sun, Aug 11, 2019 at 07:56:07AM +0200, Christoph Hellwig wrote:
> > > So we need a flag on the virtio device, exposed by the
> > > hypervisor (or hardware for hw virtio devices) that says:  hey, I'm real,
> > > don't take a shortcut.
> > 
> > The point here is that it's actually still not real. So we would still
> > use a physical address. However Linux decides that it wants extra
> > security by moving all data through the bounce buffer.  The distinction
> > made is that one can actually give device a physical address of the
> > bounce buffer.
> 
> Sure.  The problem is just that you keep piling hacks on top of hacks.
> We need the per-device flag anyway to properly support hardware virtio
> device in all circumstances.  Instead of coming up with another ad-hoc
> hack to force DMA uses implement that one proper bit and reuse it here.

The flag that you mention literally means "I am a real device" so for
example, you can use VFIO with it. And this device isn't a real one,
and you can't use VFIO with it, even though it's part of a power
system which always has an IOMMU.



Or here's another way to put it: we have a broken device that can only
access physical addresses, not DMA addresses. But to enable SEV Linux
requires DMA API.  So we can still make it work if DMA address happens
to be a physical address (not necessarily of the same page).


This is where dma_addr_is_a_phys_addr() is coming from: it tells us this
weird configuration can still work.  What are we going to do for SEV if
dma_addr_is_a_phys_addr does not apply? Fail probe I guess.


So the proposal is really to make things safe and to this end,
to add this in probe:

	if (sev_active() &&
	    !dma_addr_is_a_phys_addr(dev) &&
	    !virtio_has_feature(vdev, VIRTIO_F_IOMMU_PLATFORM))
		return -EINVAL;


the point being to prevent loading driver where it would
corrupt guest memory. Put this way, any objections to adding
dma_addr_is_a_phys_addr to the DMA API?





-- 
MST
