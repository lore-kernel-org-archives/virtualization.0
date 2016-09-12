From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH] virtio_pci: Limit DMA mask to 44 bits for legacy virtio
	devices
Date: Mon, 12 Sep 2016 16:57:27 +0100
Message-ID: <20160912155727.GD4792@arm.com>
References: <1473682241-21984-1-git-send-email-will.deacon@arm.com>
	<20160912182203-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20160912182203-mutt-send-email-mst@kernel.org>
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
Cc: Andy Lutomirski <luto@kernel.org>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Sep 12, 2016 at 06:33:43PM +0300, Michael S. Tsirkin wrote:
> On Mon, Sep 12, 2016 at 01:10:41PM +0100, Will Deacon wrote:
> > Legacy virtio defines the virtqueue base using a 32-bit PFN field, with
> > a read-only register indicating a fixed page size of 4k.
> > 
> > This can cause problems for DMA allocators that allocate top down from
> > the DMA mask, which is set to 64 bits. In this case, the addresses are
> > silently truncated to 44-bit, leading to IOMMU faults, failure to read
> > from the queue or data corruption.
> > 
> > This patch restricts the DMA mask for legacy PCI virtio devices to
> > 44 bits, which matches the specification.
> > 
> > Cc: Andy Lutomirski <luto@kernel.org>
> > Cc: Michael S. Tsirkin <mst@redhat.com>
> > Signed-off-by: Will Deacon <will.deacon@arm.com>
> 
> Hmm - IIUC it's actually only the case for the virtio rings
> themselves. The buffer addresses put in the rings are full 64 bit ones.

I think that's right, yes.

> It so happens that virtio doesn't use coherent allocs except
> for the rings.
> So I'm inclined to say the coherent mask should be set to 44,
> with a comment explaning that this is for the rings.

I can certainly add that in v2, along with your suggestion to use
32 + VIRTIO_PCI_QUEUE_ADDR_SHIFT instead of the 44.

> In case we start using coherent allocations in virtio,
> it might be cleaner to relax the mask after allocating
> the rings, but I'm not sure that's allowed by the DMA API.
> thoughts?

Hmm, that *might* work, but I could certainly imagine some DMA
implementations going wrong if they assume the mask is fixed.

Will
