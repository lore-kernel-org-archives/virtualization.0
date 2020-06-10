From: Eugenio =?ISO-8859-1?Q?P=E9rez?= <eperezma@redhat.com>
Subject: Re: [PATCH RFC v7 02/14] fixup! vhost: option to fetch descriptors
 through an independent struct
Date: Wed, 10 Jun 2020 16:00:01 +0200
Message-ID: <313ad30e073974d71ac4c2fc3bc75db690ec8c72.camel@redhat.com>
References: <20200610113515.1497099-1-mst@redhat.com>
         <20200610113515.1497099-3-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20200610113515.1497099-3-mst@redhat.com>
Sender: kvm-owner@vger.kernel.org
To: "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, Jason Wang <jasowang@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, 2020-06-10 at 07:35 -0400, Michael S. Tsirkin wrote:
> ---
>  drivers/vhost/vhost.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index 180b7b58c76b..11433d709651 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -2614,7 +2614,7 @@ int vhost_get_vq_desc_batch(struct vhost_virtqueue *vq,
>  err_fetch:
>  	vq->ndescs = 0;
>  
> -	return ret;
> +	return ret ? ret : vq->num;
>  }
>  EXPORT_SYMBOL_GPL(vhost_get_vq_desc_batch);
>  

I'm able to lock the vhost_get_vq_desc running virtio_test with no arguments against this patch. It does not happen if
it returns vq->num early, appended below.

Let me know if you prefer your conditional at the end of the function and I will investigate the cause.

Thanks!

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 28f324fd77df..4d198994e7be 100644
@@ -2350,7 +2345,9 @@ int vhost_get_vq_desc(struct vhost_virtqueue *vq,
 	int ret = fetch_descs(vq);
 	int i;
 
-	if (ret <= 0)
+	if (ret == 0)
+		return vq->num;
+	else if (ret < 0)
 		goto err;
 
 	/* Now convert to IOV */
