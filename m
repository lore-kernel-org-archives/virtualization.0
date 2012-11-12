From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH -next] virtio: balloon: fix missing unlock on error in
	fill_balloon()
Date: Mon, 12 Nov 2012 15:34:53 -0800
Message-ID: <20121112153453.fa3edc3d.akpm@linux-foundation.org>
References: <CAPgLHd80RvvGdTKN3aR7dQ_b1S3_pAkMwmGjewc7zgf=4jafcg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CAPgLHd80RvvGdTKN3aR7dQ_b1S3_pAkMwmGjewc7zgf=4jafcg@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Wei Yongjun <weiyj.lk@gmail.com>
Cc: aquini@redhat.com, mst@redhat.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, yongjun_wei@trendmicro.com.cn
List-Id: virtualization@lists.linuxfoundation.org

On Mon, 12 Nov 2012 21:50:40 +0800
Wei Yongjun <weiyj.lk@gmail.com> wrote:

> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> 
> Add the missing unlock before return from function fill_balloon()
> in the error handling case.
> 
> Introduced by 9864a8(virtio_balloon: introduce migration primitives
> to balloon pages)
> 
> dpatch engine is used to auto generate this patch.
> (https://github.com/weiyj/dpatch)
> 
> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> ---
>  drivers/virtio/virtio_balloon.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
> index f70151b..72e8dcb 100644
> --- a/drivers/virtio/virtio_balloon.c
> +++ b/drivers/virtio/virtio_balloon.c
> @@ -152,8 +152,10 @@ static void fill_balloon(struct virtio_balloon *vb, size_t num)
>  	}
>  
>  	/* Didn't get any?  Oh well. */
> -	if (vb->num_pfns == 0)
> +	if (vb->num_pfns == 0) {
> +		mutex_unlock(&vb->balloon_lock);
>  		return;
> +	}
>  
>  	tell_host(vb, vb->inflate_vq);
>  	mutex_unlock(&vb->balloon_lock);

Well.  Why did this bug occur in the first place?  Because
fill_balloon() has multiple return points and one of those was
overlooked when adding new locking.

This (and the addition of memory leaks) is quite common.  It is part of
the reason why so much kernel code uses goto's to avoid multiple return
points.  A maintainability thing.

And we can fix this shortcoming in fill_balloon() without even needing a
goto:

--- a/drivers/virtio/virtio_balloon.c~virtio_balloon-introduce-migration-primitives-to-balloon-pages-fix-fix
+++ a/drivers/virtio/virtio_balloon.c
@@ -151,13 +151,9 @@ static void fill_balloon(struct virtio_b
 		totalram_pages--;
 	}
 
-	/* Didn't get any?  Oh well. */
-	if (vb->num_pfns == 0) {
-		mutex_unlock(&vb->balloon_lock);
-		return;
-	}
-
-	tell_host(vb, vb->inflate_vq);
+	/* Did we get any? */
+	if (vb->num_pfns != 0)
+		tell_host(vb, vb->inflate_vq);
 	mutex_unlock(&vb->balloon_lock);
 }
 
_
