From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v3 0/3] virtio DMA API core stuff
Date: Thu, 19 Nov 2015 15:45:44 +0200
Message-ID: <20151119153821-mutt-send-email-mst__34898.7572979697$1447940829$gmane$org@redhat.com>
References: <cover.1446014204.git.luto@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <cover.1446014204.git.luto@kernel.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Andy Lutomirski <luto@kernel.org>
Cc: linux-s390 <linux-s390@vger.kernel.org>, Joerg Roedel <jroedel@suse.de>, KVM <kvm@vger.kernel.org>, benh@kernel.crashing.org, Sebastian Ott <sebott@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Christian Borntraeger <borntraeger@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, dwmw2@infradead.org, Christoph Hellwig <hch@lst.de>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Oct 27, 2015 at 11:38:57PM -0700, Andy Lutomirski wrote:
> This switches virtio to use the DMA API unconditionally.  I'm sure
> it breaks things, but it seems to work on x86 using virtio-pci, with
> and without Xen, and using both the modern 1.0 variant and the
> legacy variant.

So thinking hard about it, I don't see any real drawbacks to making this
conditional on a new feature bit, that Xen can then set.

As a bonus, host can distinguish between old and new guests using the
feature bit, even though making driver *control* whether IOMMU is
bypassed makes userspace drivers unsafe, so might not be a good idea.

A tiny bit more code but not by much, and we clearly won't
be breaking anything that's not already broken,
and we will be able to drop the extra code later
if we think it's a good idea.

I'll run this by the virtio TC on OASIS next week so we
can reserve a feature bit.

> Changes from v2:
>  - Fix really embarrassing bug.  This version actually works.
> 
> Changes from v1:
>  - Fix an endian conversion error causing a BUG to hit.
>  - Fix a DMA ordering issue (swiotlb=force works now).
>  - Minor cleanups.
> 
> Andy Lutomirski (3):
>   virtio_net: Stop doing DMA from the stack
>   virtio_ring: Support DMA APIs
>   virtio_pci: Use the DMA API
> 
>  drivers/net/virtio_net.c           |  53 +++++++----
>  drivers/virtio/Kconfig             |   2 +-
>  drivers/virtio/virtio_pci_common.h |   3 +-
>  drivers/virtio/virtio_pci_legacy.c |  19 +++-
>  drivers/virtio/virtio_pci_modern.c |  34 +++++--
>  drivers/virtio/virtio_ring.c       | 187 ++++++++++++++++++++++++++++++-------
>  tools/virtio/linux/dma-mapping.h   |  17 ++++
>  7 files changed, 246 insertions(+), 69 deletions(-)
>  create mode 100644 tools/virtio/linux/dma-mapping.h
> 
> -- 
> 2.4.3
