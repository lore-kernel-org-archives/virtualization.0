From: =?UTF-8?B?546L6YeR5rWm?= <jinpuwang@gmail.com>
Subject: Re: [PATCH] virtio_blk: avoid DMA to stack for the sense buffer
Date: Wed, 4 Jan 2017 16:47:03 +0100
Message-ID: <CAD9gYJKe5wbQkMGvVhZ0MUbLAAFumubk+k-nVhMDiha9FEQNTg__21377.3938514807$1483728417$gmane$org@mail.gmail.com>
References: <1483507505-26797-1-git-send-email-hch@lst.de>
	<1483507505-26797-2-git-send-email-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1483507505-26797-2-git-send-email-hch@lst.de>
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
Cc: Jens Axboe <axboe@kernel.dk>, mst@redhat.com, LKML <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org, linux-block@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

Hi Christoph,

2017-01-04 6:25 GMT+01:00 Christoph Hellwig <hch@lst.de>:
> Most users of BLOCK_PC requests allocate the sense buffer on the stack,
> so to avoid DMA to the stack copy them to a field in the heap allocated
> virtblk_req structure.  Without that any attempt at SCSI passthrough I/O,
> including the SG_IO ioctl from userspace will crash the kernel.  Note that
> this includes running tools like hdparm even when the host does not have
> SCSI passthrough enabled.

This sounds scary.
Could you share how to reproduce it, this should go into stable if
it's the case.

Thanks,
Jinpu

>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/block/virtio_blk.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index 5545a67..3c3b8f6 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -56,6 +56,7 @@ struct virtblk_req {
>         struct virtio_blk_outhdr out_hdr;
>         struct virtio_scsi_inhdr in_hdr;
>         u8 status;
> +       u8 sense[SCSI_SENSE_BUFFERSIZE];
>         struct scatterlist sg[];
>  };
>
> @@ -102,7 +103,8 @@ static int __virtblk_add_req(struct virtqueue *vq,
>         }
>
>         if (type == cpu_to_virtio32(vq->vdev, VIRTIO_BLK_T_SCSI_CMD)) {
> -               sg_init_one(&sense, vbr->req->sense, SCSI_SENSE_BUFFERSIZE);
> +               memcpy(vbr->sense, vbr->req->sense, SCSI_SENSE_BUFFERSIZE);
> +               sg_init_one(&sense, vbr->sense, SCSI_SENSE_BUFFERSIZE);
>                 sgs[num_out + num_in++] = &sense;
>                 sg_init_one(&inhdr, &vbr->in_hdr, sizeof(vbr->in_hdr));
>                 sgs[num_out + num_in++] = &inhdr;
> --
> 2.1.4
>
