From: Dongli Zhang <dongli.zhang@oracle.com>
Subject: Re: [PATCH 1/1] virtio_blk: replace 0 by HCTX_TYPE_DEFAULT to index
	blk_mq_tag_set->map
Date: Mon, 8 Apr 2019 22:00:45 +0800
Message-ID: <630416d0-7eb0-656b-b780-74a84e2f7dc2@oracle.com>
References: <1552354316-20204-1-git-send-email-dongli.zhang@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1552354316-20204-1-git-send-email-dongli.zhang@oracle.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: virtualization@lists.linux-foundation.org, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: axboe@kernel.dk, mst@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

ping?

The similar patchset has been queued by linux-scsi 5.2/scsi-queue.

virtio-blk is the last place where HCTX_TYPE_DEFAULT is hardcoded.

It would be more friendly to cscope if the hardcoding is avoided.

Thank you very much!

Dongli Zhang

On 03/12/2019 09:31 AM, Dongli Zhang wrote:
> Use HCTX_TYPE_DEFAULT instead of 0 to avoid hardcoding.
> 
> Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
> ---
> This is the only place to cleanup under drivers/block/*. Another patch set
> is sent to scsi and then all of below are cleaned up:
> - block/*
> - drivers/*
> 
>  drivers/block/virtio_blk.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index 4bc083b..bed6035 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -691,7 +691,8 @@ static int virtblk_map_queues(struct blk_mq_tag_set *set)
>  {
>  	struct virtio_blk *vblk = set->driver_data;
>  
> -	return blk_mq_virtio_map_queues(&set->map[0], vblk->vdev, 0);
> +	return blk_mq_virtio_map_queues(&set->map[HCTX_TYPE_DEFAULT],
> +					vblk->vdev, 0);
>  }
>  
>  #ifdef CONFIG_VIRTIO_BLK_SCSI
> 
