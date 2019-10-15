From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 2/2] virtio_ring: Use DMA API if memory is encrypted
Date: Tue, 15 Oct 2019 09:35:01 +0200
Message-ID: <20191015073501.GA32345__36274.3020335742$1571124926$gmane$org@lst.de>
References: <1570843519-8696-1-git-send-email-linuxram@us.ibm.com>
	<1570843519-8696-2-git-send-email-linuxram@us.ibm.com>
	<1570843519-8696-3-git-send-email-linuxram@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1570843519-8696-3-git-send-email-linuxram@us.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Ram Pai <linuxram@us.ibm.com>
Cc: andmike@us.ibm.com, sukadev@linux.vnet.ibm.com, b.zolnierkie@samsung.com, benh@kernel.crashing.org, aik@linux.ibm.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, paulus@ozlabs.org, iommu@lists.linux-foundation.org, paul.burton@mips.com, mpe@ellerman.id.au, robin.murphy@arm.com, m.szyprowski@samsung.com, linuxppc-dev@lists.ozlabs.org, hch@lst.de, david@gibson.dropbear.id.au
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Oct 11, 2019 at 06:25:19PM -0700, Ram Pai wrote:
> From: Thiago Jung Bauermann <bauerman@linux.ibm.com>
> 
> Normally, virtio enables DMA API with VIRTIO_F_IOMMU_PLATFORM, which must
> be set by both device and guest driver. However, as a hack, when DMA API
> returns physical addresses, guest driver can use the DMA API; even though
> device does not set VIRTIO_F_IOMMU_PLATFORM and just uses physical
> addresses.

Sorry, but this is a complete bullshit hack.  Driver must always use
the DMA API if they do DMA, and if virtio devices use physical addresses
that needs to be returned through the platform firmware interfaces for
the dma setup.  If you don't do that yet (which based on previous
informations you don't), you need to fix it, and we can then quirk
old implementations that already are out in the field.

In other words: we finally need to fix that virtio mess and not pile
hacks on top of hacks.
