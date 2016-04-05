From: Gustavo Padovan <gustavo@padovan.org>
Subject: Re: [PATCH v2] drm/virtio: send vblank event after crtc updates
Date: Tue, 5 Apr 2016 11:21:15 -0700
Message-ID: <20160405182115.GB24204__4154.49854122034$1459880504$gmane$org@joana>
References: <1458588187-26002-2-git-send-email-gustavo@padovan.org>
	<1458677872-6024-1-git-send-email-gustavo@padovan.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1458677872-6024-1-git-send-email-gustavo@padovan.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: David Airlie <airlied@linux.ie>, Gustavo Padovan <gustavo.padovan@collabora.co.uk>, open list <linux-kernel@vger.kernel.org>, "open list:VIRTIO GPU DRIVER" <dri-devel@lists.freedesktop.org>, "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Hi,

Any comment on this?

	Gustavo

2016-03-22 Gustavo Padovan <gustavo@padovan.org>:

> From: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
> 
> virtio_gpu was failing to send vblank events when using the atomic IOCTL
> with the DRM_MODE_PAGE_FLIP_EVENT flag set. This patch fixes each and
> enables atomic pageflips updates.
> 
> Signed-off-by: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
> ---
>  drivers/gpu/drm/virtio/virtgpu_display.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/gpu/drm/virtio/virtgpu_display.c b/drivers/gpu/drm/virtio/virtgpu_display.c
> index b70bb8b..4f372e0 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_display.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_display.c
> @@ -274,12 +274,24 @@ static int virtio_gpu_crtc_atomic_check(struct drm_crtc *crtc,
>  	return 0;
>  }
>  
> +static void virtio_gpu_crtc_atomic_flush(struct drm_crtc *crtc,
> +					 struct drm_crtc_state *old_state)
> +{
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&crtc->dev->event_lock, flags);
> +	if (crtc->state->event)
> +		drm_crtc_send_vblank_event(crtc, crtc->state->event);
> +	spin_unlock_irqrestore(&crtc->dev->event_lock, flags);
> +}
> +
>  static const struct drm_crtc_helper_funcs virtio_gpu_crtc_helper_funcs = {
>  	.enable        = virtio_gpu_crtc_enable,
>  	.disable       = virtio_gpu_crtc_disable,
>  	.mode_fixup    = virtio_gpu_crtc_mode_fixup,
>  	.mode_set_nofb = virtio_gpu_crtc_mode_set_nofb,
>  	.atomic_check  = virtio_gpu_crtc_atomic_check,
> +	.atomic_flush  = virtio_gpu_crtc_atomic_flush,
>  };
>  
>  static void virtio_gpu_enc_mode_set(struct drm_encoder *encoder,
> -- 
> 2.5.0
> 

	Gustavo
