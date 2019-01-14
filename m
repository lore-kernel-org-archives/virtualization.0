From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 0/3] Fix virtio-blk issue with SWIOTLB
Date: Mon, 14 Jan 2019 21:22:23 +0100
Message-ID: <20190114202223.GB10781__3548.00523859939$1547693523$gmane$org@lst.de>
References: <20190110134433.15672-1-joro@8bytes.org>
	<5ae1341e-62ec-0478-552b-259eabf9fb17@redhat.com>
	<20190111091502.GC5825@8bytes.org>
	<38bcbd46-674c-348a-cbd6-66bd431e986a@redhat.com>
	<20190114095002.GA29874@lst.de>
	<ac6d83d8-02de-dbdf-e309-3a1115642d50@redhat.com>
	<20190114131114-mutt-send-email-mst@kernel.org>
	<cb290df3-4e17-a403-6d69-cf5a8a41c987@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <cb290df3-4e17-a403-6d69-cf5a8a41c987@arm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Robin Murphy <robin.murphy@arm.com>
Cc: Jens Axboe <axboe@kernel.dk>, brijesh.singh@amd.com, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, jon.grimm@amd.com, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, virtualization@lists.linux-foundation.org, linux-block@vger.kernel.org, jfehlig@suse.com, "Michael S. Tsirkin" <mst@redhat.com>, Christoph Hellwig <hch@lst.de>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Jan 14, 2019 at 07:12:08PM +0000, Robin Murphy wrote:
> Now, in theory, yes, the real issue at hand is not unique to virtio-blk nor 
> SEV - any driver whose device has a sufficiently large DMA segment size and 
> who manages to get sufficient physically-contiguous memory could 
> technically generate a scatterlist segment longer than SWIOTLB can handle. 
> However, in practice that basically never happens, not least because very 
> few drivers ever override the default 64K DMA segment limit. AFAICS nothing 
> in drivers/virtio is calling dma_set_max_seg_size() or otherwise assigning 
> any dma_parms to replace the defaults either, so the really interesting 
> question here is how are these apparently-out-of-spec 256K segments getting 
> generated at all?

drivers/block/virtio_blk.c:virtblk_probe():

	/* Host can optionally specify maximum segment size and number of
         * segments. */
	err = virtio_cread_feature(vdev, VIRTIO_BLK_F_SIZE_MAX,
				   struct virtio_blk_config, size_max, &v);
        if (!err)
		blk_queue_max_segment_size(q, v);
	else
		blk_queue_max_segment_size(q, -1U);

So it really is virtio_blk that is special here.  The host could
set VIRTIO_BLK_F_SIZE_MAX to paper over the problem, but I really
think we need a dma_max_segment_size API that is wired up through
the dma_map_ops to sort this out for real.
