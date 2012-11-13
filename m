From: Rafael Aquini <aquini@redhat.com>
Subject: Re: [patch] virtio_balloon: unlock on error in fill_balloon()
Date: Tue, 13 Nov 2012 12:28:22 -0200
Message-ID: <20121113142821.GB1636@optiplex.redhat.com>
References: <20121113074303.GA13198@elgon.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20121113074303.GA13198@elgon.mountain>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: kernel-janitors@vger.kernel.org, virtualization@lists.linux-foundation.org, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Nov 13, 2012 at 10:43:03AM +0300, Dan Carpenter wrote:
> We recently added locking in fill_balloon() but there was one error path
> which was missed.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
> Only needed in linux-next.
> 
> diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
> index f70151b..1c50e98 100644
> --- a/drivers/virtio/virtio_balloon.c
> +++ b/drivers/virtio/virtio_balloon.c
> @@ -153,9 +153,10 @@ static void fill_balloon(struct virtio_balloon *vb, size_t num)
>  
>  	/* Didn't get any?  Oh well. */
>  	if (vb->num_pfns == 0)
> -		return;
> +		goto unlock;
>  
>  	tell_host(vb, vb->inflate_vq);
> +unlock:
>  	mutex_unlock(&vb->balloon_lock);
>  }
>
Thanks for the catch Dan. 

Andrew has already picked a slightly different (and simpler) fix for this one,
though.

---8<---
a/drivers/virtio/virtio_balloon.c~virtio_balloon-introduce-migration-primitives-to-balloon-pages-fix-fix
+++ a/drivers/virtio/virtio_balloon.c
@@ -151,13 +151,9 @@ static void fill_balloon(struct virtio_b
                totalram_pages--;
       	}

-	/* Didn't get any?  Oh well. */
-	if (vb->num_pfns == 0) {
-               mutex_unlock(&vb->balloon_lock);
-               return;
-	}
-
-	tell_host(vb, vb->inflate_vq);
+	/* Did we get any? */
+	if (vb->num_pfns != 0)
+               tell_host(vb, vb->inflate_vq);
        mutex_unlock(&vb->balloon_lock);
 }
---8<---
