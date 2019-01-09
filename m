From: Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH v2 03/15] drm/bochs: atomic: add
	atomic_flush+atomic_enable callbacks.
Date: Wed, 9 Jan 2019 11:06:17 +0100
Message-ID: <20190109100617.GR21184__49601.7511272386$1547028262$gmane$org@phenom.ffwll.local>
References: <20190108112519.27473-1-kraxel@redhat.com>
	<20190108112519.27473-4-kraxel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190108112519.27473-4-kraxel@redhat.com>
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
Cc: andr2000@gmail.com, open list <linux-kernel@vger.kernel.org>, dri-devel@lists.freedesktop.org, "open list:DRM DRIVER FOR BOCHS VIRTUAL GPU" <virtualization@lists.linux-foundation.org>, David Airlie <airlied@linux.ie>, David Airlie <airlied@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Jan 08, 2019 at 12:25:07PM +0100, Gerd Hoffmann wrote:
> Conversion to atomic modesetting, step one.
> Add atomic crtc helper callbacks.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  drivers/gpu/drm/bochs/bochs_kms.c | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/drivers/gpu/drm/bochs/bochs_kms.c b/drivers/gpu/drm/bochs/bochs_kms.c
> index f7e6d1a9b3..2cbd406b1f 100644
> --- a/drivers/gpu/drm/bochs/bochs_kms.c
> +++ b/drivers/gpu/drm/bochs/bochs_kms.c
> @@ -115,6 +115,29 @@ static int bochs_crtc_page_flip(struct drm_crtc *crtc,
>  	return 0;
>  }
>  
> +static void bochs_crtc_atomic_enable(struct drm_crtc *crtc,
> +				     struct drm_crtc_state *old_crtc_state)
> +{
> +}

A patch to make this optional in the helpers would be neat.
-Daniel

> +
> +static void bochs_crtc_atomic_flush(struct drm_crtc *crtc,
> +				    struct drm_crtc_state *old_crtc_state)
> +{
> +	struct drm_device *dev = crtc->dev;
> +	struct drm_pending_vblank_event *event;
> +
> +	if (crtc->state && crtc->state->event) {
> +		unsigned long irqflags;
> +
> +		spin_lock_irqsave(&dev->event_lock, irqflags);
> +		event = crtc->state->event;
> +		crtc->state->event = NULL;
> +		drm_crtc_send_vblank_event(crtc, event);
> +		spin_unlock_irqrestore(&dev->event_lock, irqflags);
> +	}
> +}
> +
> +
>  /* These provide the minimum set of functions required to handle a CRTC */
>  static const struct drm_crtc_funcs bochs_crtc_funcs = {
>  	.set_config = drm_crtc_helper_set_config,
> @@ -128,6 +151,8 @@ static const struct drm_crtc_helper_funcs bochs_helper_funcs = {
>  	.mode_set_base = bochs_crtc_mode_set_base,
>  	.prepare = bochs_crtc_prepare,
>  	.commit = bochs_crtc_commit,
> +	.atomic_enable = bochs_crtc_atomic_enable,
> +	.atomic_flush = bochs_crtc_atomic_flush,
>  };
>  
>  static const uint32_t bochs_formats[] = {
> -- 
> 2.9.3
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
