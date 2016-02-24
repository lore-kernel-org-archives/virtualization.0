From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] virtio_blk: VIRTIO_BLK_F_WCE->VIRTIO_BLK_F_FLUSH
Date: Wed, 24 Feb 2016 16:16:51 +0100
Message-ID: <56CDC963.9030706@redhat.com>
References: <1456326631-8478-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1456326631-8478-1-git-send-email-mst@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org



On 24/02/2016 16:11, Michael S. Tsirkin wrote:
> Latest virtio spec says the feature bit name is VIRTIO_BLK_F_FLUSH,
> VIRTIO_BLK_F_WCE is the legacy name.  virtio blk header says exactly the
> reverse - fix that and update driver code to match.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
> I'm inclined to merge it for the current kernel -
> safe and avoids confusion.

Since you are at it, also change this:

> +#define VIRTIO_BLK_F_FLUSH	9	/* Writeback mode enabled after reset */

to /* Flush command supported */

>  #define VIRTIO_BLK_F_CONFIG_WCE	11	/* Writeback mode available in config */
>  #ifndef __KERNEL__
> -/* Old (deprecated) name for VIRTIO_BLK_F_WCE. */
> -#define VIRTIO_BLK_F_FLUSH VIRTIO_BLK_F_WCE
> +/* Old (deprecated) name for VIRTIO_BLK_F_FLUSH. */
> +#define VIRTIO_BLK_F_WCE VIRTIO_BLK_F_FLUSH
>  #endif
>  #endif /* !VIRTIO_BLK_NO_LEGACY */
>  
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index 6ca3549..dbaebb0 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -478,7 +478,7 @@ static int virtblk_get_cache_mode(struct virtio_device *vdev)
>  				   struct virtio_blk_config, wce,
>  				   &writeback);

and add a comment here:

/*
 * If WCE is not configurable and flush is not available,
 * assume no writeback cache is in use.
 */

>  	if (err)
> -		writeback = virtio_has_feature(vdev, VIRTIO_BLK_F_WCE);
> +		writeback = virtio_has_feature(vdev, VIRTIO_BLK_F_FLUSH);
>  
>  	return writeback;
>  }
> @@ -833,14 +833,14 @@ static const struct virtio_device_id id_table[] = {
>  static unsigned int features_legacy[] = {
>  	VIRTIO_BLK_F_SEG_MAX, VIRTIO_BLK_F_SIZE_MAX, VIRTIO_BLK_F_GEOMETRY,
>  	VIRTIO_BLK_F_RO, VIRTIO_BLK_F_BLK_SIZE, VIRTIO_BLK_F_SCSI,
> -	VIRTIO_BLK_F_WCE, VIRTIO_BLK_F_TOPOLOGY, VIRTIO_BLK_F_CONFIG_WCE,
> +	VIRTIO_BLK_F_FLUSH, VIRTIO_BLK_F_TOPOLOGY, VIRTIO_BLK_F_CONFIG_WCE,
>  	VIRTIO_BLK_F_MQ,
>  }
>  ;
>  static unsigned int features[] = {
>  	VIRTIO_BLK_F_SEG_MAX, VIRTIO_BLK_F_SIZE_MAX, VIRTIO_BLK_F_GEOMETRY,
>  	VIRTIO_BLK_F_RO, VIRTIO_BLK_F_BLK_SIZE,
> -	VIRTIO_BLK_F_WCE, VIRTIO_BLK_F_TOPOLOGY, VIRTIO_BLK_F_CONFIG_WCE,
> +	VIRTIO_BLK_F_FLUSH, VIRTIO_BLK_F_TOPOLOGY, VIRTIO_BLK_F_CONFIG_WCE,
>  	VIRTIO_BLK_F_MQ,
>  };
>  
> 
