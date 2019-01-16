From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 3/3] virtio-blk: Consider dma_max_mapping_size() for
	maximum segment size
Date: Wed, 16 Jan 2019 09:05:40 -0500
Message-ID: <20190116090355-mutt-send-email-mst__28146.1844956086$1547692556$gmane$org@kernel.org>
References: <20190115132257.6426-1-joro@8bytes.org>
	<20190115132257.6426-4-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190115132257.6426-4-joro@8bytes.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Joerg Roedel <joro@8bytes.org>
Cc: Jens Axboe <axboe@kernel.dk>, jroedel@suse.de, brijesh.singh@amd.com, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, jon.grimm@amd.com, jfehlig@suse.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-block@vger.kernel.org, iommu@lists.linux-foundation.org, Christoph Hellwig <hch@lst.de>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Jan 15, 2019 at 02:22:57PM +0100, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel@suse.de>
> 
> Segments can't be larger than the maximum DMA mapping size
> supported on the platform. Take that into account when
> setting the maximum segment size for a block device.
> 
> Signed-off-by: Joerg Roedel <jroedel@suse.de>
> ---
>  drivers/block/virtio_blk.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index b16a887bbd02..6193962a7fec 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -723,7 +723,7 @@ static int virtblk_probe(struct virtio_device *vdev)
>  	struct request_queue *q;
>  	int err, index;
>  
> -	u32 v, blk_size, sg_elems, opt_io_size;
> +	u32 v, blk_size, max_size, sg_elems, opt_io_size;
>  	u16 min_io_size;
>  	u8 physical_block_exp, alignment_offset;
>  
> @@ -826,14 +826,16 @@ static int virtblk_probe(struct virtio_device *vdev)
>  	/* No real sector limit. */
>  	blk_queue_max_hw_sectors(q, -1U);
>  
> +	max_size = dma_max_mapping_size(&vdev->dev);
> +


Should this be limited to ACCESS_PLATFORM?

I see no reason to limit this without as guest can
access any memory.


I'd like a bit of time to consider this point.

>  	/* Host can optionally specify maximum segment size and number of
>  	 * segments. */
>  	err = virtio_cread_feature(vdev, VIRTIO_BLK_F_SIZE_MAX,
>  				   struct virtio_blk_config, size_max, &v);
>  	if (!err)
> -		blk_queue_max_segment_size(q, v);
> -	else
> -		blk_queue_max_segment_size(q, -1U);
> +		max_size = min(max_size, v);
> +
> +	blk_queue_max_segment_size(q, max_size);
>  
>  	/* Host can optionally specify the block size of the device */
>  	err = virtio_cread_feature(vdev, VIRTIO_BLK_F_BLK_SIZE,
> -- 
> 2.17.1
