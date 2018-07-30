From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [RFC 0/4] Virtio uses DMA API for all devices
Date: Mon, 30 Jul 2018 13:28:03 +0300
Message-ID: <20180730125100-mutt-send-email-mst@kernel.org>
References: <20180720035941.6844-1-khandual@linux.vnet.ibm.com>
	<20180727095804.GA25592@arm.com>
	<20180730093414.GD26245@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20180730093414.GD26245@infradead.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Christoph Hellwig <hch@infradead.org>
Cc: robh@kernel.org, srikar@linux.vnet.ibm.com, benh@kernel.crashing.org, Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org, linuxram@us.ibm.com, virtualization@lists.linux-foundation.org, paulus@samba.org, marc.zyngier@arm.com, mpe@ellerman.id.au, joe@perches.com, robin.murphy@arm.com, david@gibson.dropbear.id.au, linuxppc-dev@lists.ozlabs.org, elfring@users.sourceforge.net, haren@linux.vnet.ibm.com, Anshuman Khandual <khandual@linux.vnet.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Jul 30, 2018 at 02:34:14AM -0700, Christoph Hellwig wrote:
> We really need to distinguish between legacy virtual crappy
> virtio (and that includes v1) that totally ignores the bus it pretends
> to be on, and sane virtio (to be defined) that sit on a real (or
> properly emulated including iommu and details for dma mapping) bus.

Let me reply to the "crappy" part first:
So virtio devices can run on another CPU or on a PCI bus. Configuration
can happen over mupltiple transports.  There is a discovery protocol to
figure out where it is. It has some warts but any real system has warts.

So IMHO virtio running on another CPU isn't "legacy virtual crappy
virtio". virtio devices that actually sit on a PCI bus aren't "sane"
simply because the DMA is more convoluted on some architectures.

Performance impact of the optimizations possible when you know
your "device" is in fact just another CPU has been measured,
it is real, so we aren't interested in adding all that overhead back
just so we can use DMA API. The "correct then fast" mantra doesn't
apply to something that is as widely deployed as virtio.

And I can accept an argument that maybe the DMA API isn't designed to
support such virtual DMA. Whether it should I don't know.

With this out of my system:
I agree these approaches are hacky. I think it is generally better to
have virtio feature negotiation tell you whether device runs on a CPU or
not rather than rely on platform specific ways for this. To this end
there was a recent proposal to rename VIRTIO_F_IO_BARRIER to
VIRTIO_F_REAL_DEVICE.  It got stuck since "real" sounds vague to people,
e.g.  what if it's a VF - is that real or not? But I can see something
like e.g. VIRTIO_F_PLATFORM_DMA gaining support.

We would then rename virtio_has_iommu_quirk to virtio_has_dma_quirk
and test VIRTIO_F_PLATFORM_DMA in addition to the IOMMU thing.

-- 
MST
