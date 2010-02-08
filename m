From: Adam Litke <agl@us.ibm.com>
Subject: Re: [PATCH] virtio: fix balloon without VIRTIO_BALLOON_F_STATS_VQ
Date: Mon, 08 Feb 2010 07:33:45 -0600
Message-ID: <1265636025.3457.0.camel@aglitke>
References: <201002082102.42331.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <201002082102.42331.rusty@rustcorp.com.au>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Mon, 2010-02-08 at 21:02 +1030, Rusty Russell wrote:
> need_stats_update should be zero-initialized.

Yes indeed.
Acked-by: Adam Litke <agl@us.ibm.com>

> Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
> Cc: Adam Litke <agl@us.ibm.com>
> 
> diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
> --- a/drivers/virtio/virtio_balloon.c
> +++ b/drivers/virtio/virtio_balloon.c
> @@ -292,6 +292,7 @@ static int virtballoon_probe(struct virt
>  	vb->num_pages = 0;
>  	init_waitqueue_head(&vb->config_change);
>  	vb->vdev = vdev;
> +	vb->need_stats_update = 0;
> 
>  	/* We expect two virtqueues: inflate and deflate,
>  	 * and optionally stat. */


-- 
Thanks,
Adam
