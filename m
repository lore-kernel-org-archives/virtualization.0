From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 2/2] virtio/virtio_ring: Fix the dma_max_mapping_size call
Date: Wed, 24 Jul 2019 18:10:53 -0400
Message-ID: <20190723114750-mutt-send-email-mst__5866.15608060441$1564006271$gmane$org@kernel.org>
References: <20190722145509.1284-1-eric.auger@redhat.com>
	<20190722145509.1284-3-eric.auger@redhat.com>
	<e4a288f2-a93a-5ce4-32da-f5434302551f@arm.com>
	<20190723153851.GE720@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190723153851.GE720@lst.de>
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
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Eric Auger <eric.auger@redhat.com>, iommu@lists.linux-foundation.org, eric.auger.pro@gmail.com, Robin Murphy <robin.murphy@arm.com>, m.szyprowski@samsung.com
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Jul 23, 2019 at 05:38:51PM +0200, Christoph Hellwig wrote:
> On Mon, Jul 22, 2019 at 04:36:09PM +0100, Robin Murphy wrote:
> >> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> >> index c8be1c4f5b55..37c143971211 100644
> >> --- a/drivers/virtio/virtio_ring.c
> >> +++ b/drivers/virtio/virtio_ring.c
> >> @@ -262,7 +262,7 @@ size_t virtio_max_dma_size(struct virtio_device *vdev)
> >>   {
> >>   	size_t max_segment_size = SIZE_MAX;
> >>   -	if (vring_use_dma_api(vdev))
> >> +	if (vring_use_dma_api(vdev) && vdev->dev.dma_mask)
> >
> > Hmm, might it make sense to roll that check up into vring_use_dma_api() 
> > itself? After all, if the device has no mask then it's likely that other 
> > DMA API ops wouldn't really work as expected either.
> 
> Makes sense to me.

Christoph - would a documented API wrapping dma_mask make sense?
With the documentation explaining how users must
desist from using DMA APIs if that returns false ...


-- 
MST
