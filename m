From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 2/2] virtio/virtio_ring: Fix the dma_max_mapping_size call
Date: Tue, 23 Jul 2019 11:47:27 -0400
Message-ID: <20190723114504-mutt-send-email-mst__35356.7919389874$1563896872$gmane$org@kernel.org>
References: <20190722145509.1284-1-eric.auger@redhat.com>
	<20190722145509.1284-3-eric.auger@redhat.com>
	<20190722112704-mutt-send-email-mst@kernel.org>
	<20190723153830.GD720@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190723153830.GD720@lst.de>
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
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Eric Auger <eric.auger@redhat.com>, iommu@lists.linux-foundation.org, eric.auger.pro@gmail.com, robin.murphy@arm.com, m.szyprowski@samsung.com
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Jul 23, 2019 at 05:38:30PM +0200, Christoph Hellwig wrote:
> On Mon, Jul 22, 2019 at 11:33:35AM -0400, Michael S. Tsirkin wrote:
> > On Mon, Jul 22, 2019 at 04:55:09PM +0200, Eric Auger wrote:
> > > Do not call dma_max_mapping_size for devices that have no DMA
> > > mask set, otherwise we can hit a NULL pointer dereference.
> > > 
> > > This occurs when a virtio-blk-pci device is protected with
> > > a virtual IOMMU.
> > > 
> > > Fixes: e6d6dd6c875e ("virtio: Introduce virtio_max_dma_size()")
> > > Signed-off-by: Eric Auger <eric.auger@redhat.com>
> > > Suggested-by: Christoph Hellwig <hch@lst.de>
> > 
> > Christoph, I wonder why did you suggest this?
> > The connection between dma_mask and dma_max_mapping_size
> > is far from obvious.  The documentation doesn't exist.
> > Do we really have to teach all users about this hack?
> > Why not just make dma_max_mapping_size DTRT?
> 
> Because we should not call into dma API functions for devices that
> are not DMA capable.

I'd rather call is_device_dma_capable then, better than poking
at DMA internals.

-- 
MST
