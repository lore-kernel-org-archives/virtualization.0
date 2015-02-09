From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] virtio: Avoid possible kernel panic if DEBUG is enabled.
Date: Mon, 09 Feb 2015 10:32:46 +1030
Message-ID: <878ug83qah.fsf@rustcorp.com.au>
References: <201502062105.FDF56296.JSVQHFOOFFOtML@I-love.SAKURA.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <201502062105.FDF56296.JSVQHFOOFFOtML@I-love.SAKURA.ne.jp>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>, mst@redhat.com
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp> writes:

>>From 11fd997d724f520ca628615e7ffbfd7901c40b62 Mon Sep 17 00:00:00 2001
> From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Date: Fri, 6 Feb 2015 13:28:38 +0900
> Subject: [PATCH] virtio: Avoid possible kernel panic if DEBUG is enabled.
>
> The virtqueue_add() calls START_USE() upon entry. The virtqueue_kick() is
> called if vq->num_added == (1 << 16) - 1 before calling END_USE().
> The virtqueue_kick_prepare() called via virtqueue_kick() calls START_USE()
> upon entry, and will call panic() if DEBUG is enabled.
> Move this virtqueue_kick() call to after END_USE() call.

Thanks, applied.

Cheers,
Rusty.

>
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> ---
>  drivers/virtio/virtio_ring.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 00ec6b3..596735b 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -245,14 +245,14 @@ static inline int virtqueue_add(struct virtqueue *_vq,
>  	vq->vring.avail->idx = cpu_to_virtio16(_vq->vdev, virtio16_to_cpu(_vq->vdev, vq->vring.avail->idx) + 1);
>  	vq->num_added++;
>  
> +	pr_debug("Added buffer head %i to %p\n", head, vq);
> +	END_USE(vq);
> +
>  	/* This is very unlikely, but theoretically possible.  Kick
>  	 * just in case. */
>  	if (unlikely(vq->num_added == (1 << 16) - 1))
>  		virtqueue_kick(_vq);
>  
> -	pr_debug("Added buffer head %i to %p\n", head, vq);
> -	END_USE(vq);
> -
>  	return 0;
>  }
>  
> -- 
> 1.8.3.1
