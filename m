From: Jiri Slaby <jslaby@suse.cz>
Subject: Re: [PATCH] drm: virtio: use kmem_cache
Date: Fri, 10 Mar 2017 19:12:24 +0100
Message-ID: <9a241e38-c263-f50d-120c-17fdda9d2499__22261.1923971728$1489169557$gmane$org@suse.cz>
References: <1488377348-5006-1-git-send-email-kraxel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1488377348-5006-1-git-send-email-kraxel@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Gerd Hoffmann <kraxel@redhat.com>, dri-devel@lists.freedesktop.org
Cc: David Airlie <airlied@linux.ie>, open list <linux-kernel@vger.kernel.org>, "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On 03/01/2017, 03:09 PM, Gerd Hoffmann wrote:
> @@ -128,12 +96,9 @@ void virtio_gpu_free_vbufs(struct virtio_gpu_device *vgdev)
>  {
>  	struct virtio_gpu_vbuffer *vbuf;
>  
> -	spin_lock(&vgdev->free_vbufs_lock);
> -	BUG_ON(list_empty(&vgdev->free_vbufs));
> -	vbuf = list_first_entry(&vgdev->free_vbufs,
> -				struct virtio_gpu_vbuffer, list);
> -	list_del(&vbuf->list);
> -	spin_unlock(&vgdev->free_vbufs_lock);
> +	vbuf = kmem_cache_alloc(vgdev->vbufs, GFP_KERNEL);
> +	if (IS_ERR(vbuf))
> +		return ERR_CAST(vbuf);

AFAICS kmem_cache_alloc returns NULL on error.

>  	memset(vbuf, 0, VBUFFER_SIZE);
>  
>  	BUG_ON(size > MAX_INLINE_CMD_SIZE);
> @@ -208,9 +173,7 @@ static void free_vbuf(struct virtio_gpu_device *vgdev,
>  	if (vbuf->resp_size > MAX_INLINE_RESP_SIZE)
>  		kfree(vbuf->resp_buf);
>  	kfree(vbuf->data_buf);
> -	spin_lock(&vgdev->free_vbufs_lock);
> -	list_add(&vbuf->list, &vgdev->free_vbufs);
> -	spin_unlock(&vgdev->free_vbufs_lock);
> +	kmem_cache_free(vgdev->vbufs, vbuf);
>  }
>  
>  static void reclaim_vbufs(struct virtqueue *vq, struct list_head *reclaim_list)
> 

regards,
-- 
js
suse labs
