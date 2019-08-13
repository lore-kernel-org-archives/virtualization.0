From: Ram Pai <linuxram@us.ibm.com>
Subject: RE: [RFC PATCH] virtio_ring: Use DMA API if guest memory is encrypted
Date: Tue, 13 Aug 2019 08:45:37 -0700
Message-ID: <20190813154537.GE5964@ram.ibm.com>
References: <87zhrj8kcp.fsf@morokweng.localdomain>
	<20190810143038-mutt-send-email-mst@kernel.org>
	<20190810220702.GA5964@ram.ibm.com> <20190811055607.GA12488@lst.de>
	<20190812095156.GD3947@umbus.fritz.box>
	<20190813132617.GA6426@lst.de>
	<20190813142439.GO3947@umbus.fritz.box>
Reply-To: Ram Pai <linuxram@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190813142439.GO3947@umbus.fritz.box>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: David Gibson <david@gibson.dropbear.id.au>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Alexey Kardashevskiy <aik@linux.ibm.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Paul Mackerras <paulus@ozlabs.org>, iommu@lists.linux-foundation.org, linuxppc-devel@lists.ozlabs.org, Christoph Hellwig <hch@lst.de>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Aug 14, 2019 at 12:24:39AM +1000, David Gibson wrote:
> On Tue, Aug 13, 2019 at 03:26:17PM +0200, Christoph Hellwig wrote:
> > On Mon, Aug 12, 2019 at 07:51:56PM +1000, David Gibson wrote:
> > > AFAICT we already kind of abuse this for the VIRTIO_F_IOMMU_PLATFORM,
> > > because to handle for cases where it *is* a device limitation, we
> > > assume that if the hypervisor presents VIRTIO_F_IOMMU_PLATFORM then
> > > the guest *must* select it.
> > > 
> > > What we actually need here is for the hypervisor to present
> > > VIRTIO_F_IOMMU_PLATFORM as available, but not required.  Then we need
> > > a way for the platform core code to communicate to the virtio driver
> > > that *it* requires the IOMMU to be used, so that the driver can select
> > > or not the feature bit on that basis.
> > 
> > I agree with the above, but that just brings us back to the original
> > issue - the whole bypass of the DMA OPS should be an option that the
> > device can offer, not the other way around.  And we really need to
> > fix that root cause instead of doctoring around it.
> 
> I'm not exactly sure what you mean by "device" in this context.  Do
> you mean the hypervisor (qemu) side implementation?
> 
> You're right that this was the wrong way around to begin with, but as
> well as being hard to change now, I don't see how it really addresses
> the current problem.  The device could default to IOMMU and allow
> bypass, but the driver would still need to get information from the
> platform to know that it *can't* accept that option in the case of a
> secure VM.  Reversed sense, but the same basic problem.
> 
> The hypervisor does not, and can not be aware of the secure VM
> restrictions - only the guest side platform code knows that.

This statement is almost entirely right. I will rephrase it to make it
entirely right.   

The hypervisor does not, and can not be aware of the secure VM
requirement that it needs to do some special processing that has nothing
to do with DMA address translation - only the guest side platform code
know that.

BTW: I do not consider 'bounce buffering' as 'DMA address translation'.
DMA address translation, translates CPU address to DMA address.  Bounce
buffering moves the data from one buffer at a given CPU address to
another buffer at a different CPU address.  Unfortunately the current
DMA ops conflates the two.  The need to do 'DMA address translation' 
is something the device can enforce.  But the need to do bounce
buffering, is something that the device should not be aware and should be
entirely a decision made locally by the kernel/driver in the secure VM.

RP

> 
> -- 
> David Gibson			| I'll have my music baroque, and my code
> david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
> 				| _way_ _around_!
> http://www.ozlabs.org/~dgibson



-- 
Ram Pai
