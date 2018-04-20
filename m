From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH] drm/virtio: fix vq wait_event condition
Date: Fri, 20 Apr 2018 09:22:28 +0200
Message-ID: <20180420072228.uorb3h7snx4io6xs__27422.5768670023$1524208837$gmane$org@sirius.home.kraxel.org>
References: <20180403095904.11152-1-kraxel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20180403095904.11152-1-kraxel@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: dri-devel@lists.freedesktop.org
Cc: David Airlie <airlied@linux.ie>, open list <linux-kernel@vger.kernel.org>, amagloire@blackberry.com, stable@vger.kernel.org, "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Apr 03, 2018 at 11:59:04AM +0200, Gerd Hoffmann wrote:
> Wait until we have enough space in the virt queue to actually queue up
> our request.  Avoids the guest spinning in case we have a non-zero
> amount of free entries but not enough for the request.

Ping airlied, can you please either pick it up or review so I can commit
myself?

thanks,
  Gerd

> Cc: stable@vger.kernel.org
> Reported-by: Alain Magloire <amagloire@blackberry.com>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  drivers/gpu/drm/virtio/virtgpu_vq.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio/virtgpu_vq.c
> index 48e4f1df6e..020070d483 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_vq.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
> @@ -293,7 +293,7 @@ static int virtio_gpu_queue_ctrl_buffer_locked(struct virtio_gpu_device *vgdev,
>  	ret = virtqueue_add_sgs(vq, sgs, outcnt, incnt, vbuf, GFP_ATOMIC);
>  	if (ret == -ENOSPC) {
>  		spin_unlock(&vgdev->ctrlq.qlock);
> -		wait_event(vgdev->ctrlq.ack_queue, vq->num_free);
> +		wait_event(vgdev->ctrlq.ack_queue, vq->num_free >= outcnt + incnt);
>  		spin_lock(&vgdev->ctrlq.qlock);
>  		goto retry;
>  	} else {
> @@ -368,7 +368,7 @@ static int virtio_gpu_queue_cursor(struct virtio_gpu_device *vgdev,
>  	ret = virtqueue_add_sgs(vq, sgs, outcnt, 0, vbuf, GFP_ATOMIC);
>  	if (ret == -ENOSPC) {
>  		spin_unlock(&vgdev->cursorq.qlock);
> -		wait_event(vgdev->cursorq.ack_queue, vq->num_free);
> +		wait_event(vgdev->cursorq.ack_queue, vq->num_free >= outcnt);
>  		spin_lock(&vgdev->cursorq.qlock);
>  		goto retry;
>  	} else {
> -- 
> 2.9.3
> 
