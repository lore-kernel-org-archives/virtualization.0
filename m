From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] virtio_blk: merge S/G list entries by default
Date: Sun, 7 Sep 2014 14:41:53 +0300
Message-ID: <20140907114153.GB26569@redhat.com>
References: <1410044994-14943-1-git-send-email-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1410044994-14943-1-git-send-email-hch@lst.de>
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
Cc: Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Sat, Sep 06, 2014 at 04:09:54PM -0700, Christoph Hellwig wrote:
> Most virtio setups have a fairly limited number of ring entries available.

Seems a bit vague: QEMU at least has pretty large queues.
Which hypervisor do you have in mind?
This could be a gain everywhere if you manage to make descriptors
completely linear, so they fit in a single s/g.
ATM __virtblk_add_req always adds an s/g for the header:
is there a chance linux can pre-allocate a bit of memory
in front of the buffer to stick the header in?

> Enable S/G entry merging by default to fit into less of them.  This restores
> the behavior at time of the virtio-blk blk-mq conversion, which was changed
> by commit "block: add queue flag for disabling SG merging" which made the
> behavior optional, but didn't update the existing drivers to keep their
> previous behavior.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

OK so this is an optimization patch right?
What kind of performance gain is observed with it?

> ---
>  drivers/block/virtio_blk.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index 0a58140..311b857 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -634,7 +634,7 @@ static int virtblk_probe(struct virtio_device *vdev)
>  	vblk->tag_set.ops = &virtio_mq_ops;
>  	vblk->tag_set.queue_depth = virtblk_queue_depth;
>  	vblk->tag_set.numa_node = NUMA_NO_NODE;
> -	vblk->tag_set.flags = BLK_MQ_F_SHOULD_MERGE;
> +	vblk->tag_set.flags = BLK_MQ_F_SHOULD_MERGE | BLK_MQ_F_SG_MERGE;
>  	vblk->tag_set.cmd_size =
>  		sizeof(struct virtblk_req) +
>  		sizeof(struct scatterlist) * sg_elems;
> -- 
> 1.9.1
