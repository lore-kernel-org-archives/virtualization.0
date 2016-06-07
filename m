From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH RESEND 06/14] drm/virtio: use drm_crtc_send_vblank_event()
Date: Tue, 07 Jun 2016 10:39:15 +0200
Message-ID: <1465288755.14901.4.camel__28176.6481152319$1465288773$gmane$org@redhat.com>
References: <1465224105-21485-1-git-send-email-gustavo@padovan.org>
	<1465224105-21485-6-git-send-email-gustavo@padovan.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1465224105-21485-6-git-send-email-gustavo@padovan.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Gustavo Padovan <gustavo@padovan.org>
Cc: David Airlie <airlied@linux.ie>, Gustavo Padovan <gustavo.padovan@collabora.co.uk>, open list <linux-kernel@vger.kernel.org>, dri-devel@lists.freedesktop.org, "open
	list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Mo, 2016-06-06 at 11:41 -0300, Gustavo Padovan wrote:
> From: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
> 
> Replace the legacy drm_send_vblank_event() with the new helper function.
> 
> Signed-off-by: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
> ---
>  drivers/gpu/drm/virtio/virtgpu_display.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/virtio/virtgpu_display.c b/drivers/gpu/drm/virtio/virtgpu_display.c
> index d4305da..ba5e11b 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_display.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_display.c
> @@ -156,7 +156,7 @@ static int virtio_gpu_page_flip(struct drm_crtc *crtc,
>  
>  	if (event) {
>  		spin_lock_irqsave(&crtc->dev->event_lock, irqflags);
> -		drm_send_vblank_event(crtc->dev, -1, event);
> +		drm_crtc_send_vblank_event(crtc, event);
>  		spin_unlock_irqrestore(&crtc->dev->event_lock, irqflags);
>  	}

Daniel Vetter has a series in flight which drops the whole
virtio_gpu_page_flip function in favor of drm_atomic_helper_page_flip.

https://lists.freedesktop.org/archives/dri-devel/2016-May/108699.html

cheers,
  Gerd
