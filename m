From: Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH] gpu: drm: qxl: Fix possible null-pointer dereferences in
	qxl_crtc_atomic_flush()
Date: Thu, 25 Jul 2019 14:03:59 +0200
Message-ID: <20190725120359.GB15868__5677.97390265099$1564056256$gmane$org@phenom.ffwll.local>
References: <20190725102127.16086-1-baijiaju1990@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190725102127.16086-1-baijiaju1990@gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jia-Ju Bai <baijiaju1990@gmail.com>
Cc: airlied@linux.ie, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org, daniel@ffwll.ch, spice-devel@lists.freedesktop.org, airlied@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Jul 25, 2019 at 06:21:27PM +0800, Jia-Ju Bai wrote:
> In qxl_crtc_atomic_flush(), there is an if statement on line 376 to
> check whether crtc->state is NULL:
>     if (crtc->state && crtc->state->event)
> 
> When crtc->state is NULL and qxl_crtc_update_monitors_config() is call, 
> qxl_crtc_update_monitors_config() uses crtc->state on line 326:
>     if (crtc->state->active)
> and on line 358:
>     DRM_DEBUG_KMS(..., crtc->state->active, ...);
> 
> Thus, possible null-pointer dereferences may occur.
> 
> To fix these bugs, crtc->state is checked before calling
> qxl_crtc_update_monitors_config().
> 
> These bugs are found by a static analysis tool STCheck written by us.
> 
> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>

crtc->state should never be NULL in this function, ever. Imo correct fix
is to remove that other NULL check (since obviously it would blow up,
hence it's dead code).

Atomic kms drivers use drm_mode_config_reset() to make sure the various
->state pointers are always set and valid.
-Daniel

> ---
>  drivers/gpu/drm/qxl/qxl_display.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/qxl/qxl_display.c b/drivers/gpu/drm/qxl/qxl_display.c
> index 8b319ebbb0fb..fae18ef1ba59 100644
> --- a/drivers/gpu/drm/qxl/qxl_display.c
> +++ b/drivers/gpu/drm/qxl/qxl_display.c
> @@ -382,7 +382,8 @@ static void qxl_crtc_atomic_flush(struct drm_crtc *crtc,
>  		spin_unlock_irqrestore(&dev->event_lock, flags);
>  	}
>  
> -	qxl_crtc_update_monitors_config(crtc, "flush");
> +	if (crtc->state)
> +		qxl_crtc_update_monitors_config(crtc, "flush");
>  }
>  
>  static void qxl_crtc_destroy(struct drm_crtc *crtc)
> -- 
> 2.17.0
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
