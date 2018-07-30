From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [RFC 0/4] Virtio uses DMA API for all devices
Date: Mon, 30 Jul 2018 04:18:02 -0700
Message-ID: <20180730111802.GA9830@infradead.org>
References: <20180720035941.6844-1-khandual@linux.vnet.ibm.com>
	<20180727095804.GA25592@arm.com>
	<20180730093414.GD26245@infradead.org>
	<20180730125100-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20180730125100-mutt-send-email-mst@kernel.org>
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
Cc: robh@kernel.org, srikar@linux.vnet.ibm.com, benh@kernel.crashing.org, Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org, linuxram@us.ibm.com, virtualization@lists.linux-foundation.org, Christoph Hellwig <hch@infradead.org>, paulus@samba.org, marc.zyngier@arm.com, mpe@ellerman.id.au, joe@perches.com, robin.murphy@arm.com, david@gibson.dropbear.id.au, linuxppc-dev@lists.ozlabs.org, elfring@users.sourceforge.net, haren@linux.vnet.ibm.com, Anshuman Khandual <khandual@linux.vnet.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Jul 30, 2018 at 01:28:03PM +0300, Michael S. Tsirkin wrote:
> Let me reply to the "crappy" part first:
> So virtio devices can run on another CPU or on a PCI bus. Configuration
> can happen over mupltiple transports.  There is a discovery protocol to
> figure out where it is. It has some warts but any real system has warts.
> 
> So IMHO virtio running on another CPU isn't "legacy virtual crappy
> virtio". virtio devices that actually sit on a PCI bus aren't "sane"
> simply because the DMA is more convoluted on some architectures.

All of what you said would be true if virtio didn't claim to be
a PCI device.  Once it claims to be a PCI device and we also see
real hardware written to the interface I stand to all what I said
above.

> With this out of my system:
> I agree these approaches are hacky. I think it is generally better to
> have virtio feature negotiation tell you whether device runs on a CPU or
> not rather than rely on platform specific ways for this. To this end
> there was a recent proposal to rename VIRTIO_F_IO_BARRIER to
> VIRTIO_F_REAL_DEVICE.  It got stuck since "real" sounds vague to people,
> e.g.  what if it's a VF - is that real or not? But I can see something
> like e.g. VIRTIO_F_PLATFORM_DMA gaining support.
> 
> We would then rename virtio_has_iommu_quirk to virtio_has_dma_quirk
> and test VIRTIO_F_PLATFORM_DMA in addition to the IOMMU thing.

I don't really care about the exact naming, and indeed a device that
sets the flag doesn't have to be a 'real' device - it just has to act
like one.  I explained all the issues that this means (at least relating
to DMA) in one of the previous threads.

The important bit is that we can specify exact behavior for both
devices that sets the "I'm real!" flag and that ones that don't exactly
in the spec.  And that very much excludes arch-specific (or
Xen-specific) overrides.
