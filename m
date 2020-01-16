From: Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH v2 4/4] drm/simple-kms: Let DRM core send VBLANK events
 by default
Date: Thu, 16 Jan 2020 07:41:07 +0100
Message-ID: <20200116064107.GB8400@dvetter-linux.ger.corp.intel.com>
References: <20200115125226.13843-1-tzimmermann@suse.de>
 <20200115125226.13843-5-tzimmermann@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20200115125226.13843-5-tzimmermann@suse.de>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: david@lechnology.com, oleksandr_andrushchenko@epam.com, airlied@linux.ie, sam@ravnborg.org, dri-devel@lists.freedesktop.org, maarten.lankhorst@linux.intel.com, mripard@kernel.org, virtualization@lists.linux-foundation.org, hdegoede@redhat.com, noralf@tronnes.org, daniel@ffwll.ch, xen-devel@lists.xenproject.org, emil.velikov@collabora.com, sean@poorly.run, laurent.pinchart@ideasonboard.com
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Jan 15, 2020 at 01:52:26PM +0100, Thomas Zimmermann wrote:
> In drm_atomic_helper_fake_vblank() the DRM core sends out VBLANK events
> if struct drm_crtc_state.no_vblank is enabled in the check() callbacks.
> 
> For drivers that have neither an enable_vblank() callback nor a check()
> callback, the simple-KMS helpers enable VBLANK generation by default. This
> simplifies bochs, udl, several tiny drivers, and drivers based upon MIPI
> DPI helpers. The driver for Xen explicitly disables no_vblank, as it has
> its own logic for sending these events.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>

> diff --git a/drivers/gpu/drm/drm_simple_kms_helper.c b/drivers/gpu/drm/drm_simple_kms_helper.c
> index 15fb516ae2d8..4414c7a5b2ce 100644
> --- a/drivers/gpu/drm/drm_simple_kms_helper.c
> +++ b/drivers/gpu/drm/drm_simple_kms_helper.c
> @@ -146,10 +146,21 @@ static int drm_simple_kms_plane_atomic_check(struct drm_plane *plane,
>  	if (!plane_state->visible)
>  		return 0;
>  
> -	if (!pipe->funcs || !pipe->funcs->check)
> -		return 0;
> -
> -	return pipe->funcs->check(pipe, plane_state, crtc_state);
> +	if (pipe->funcs) {
> +		if (pipe->funcs->check)
> +			return pipe->funcs->check(pipe, plane_state,
> +						  crtc_state);
> +		if (pipe->funcs->enable_vblank)
> +			return 0;
> +	}
> +
> +	/* Drivers without VBLANK support have to fake VBLANK events. As
> +	 * there's no check() callback to enable this, set the no_vblank
> +	 * field by default.
> +	 */

The ->check callback is right above this comment ... I'm confused.

> +	crtc_state->no_vblank = true;

That's kinda not what I meant with handling this automatically. Instead
something like this:


diff --git a/drivers/gpu/drm/drm_atomic_state_helper.c b/drivers/gpu/drm/drm_atomic_state_helper.c
index 7cf3cf936547..23d2f51fc1d4 100644
--- a/drivers/gpu/drm/drm_atomic_state_helper.c
+++ b/drivers/gpu/drm/drm_atomic_state_helper.c
@@ -149,6 +149,11 @@ void __drm_atomic_helper_crtc_duplicate_state(struct drm_crtc *crtc,
 	/* Self refresh should be canceled when a new update is available */
 	state->active = drm_atomic_crtc_effectively_active(state);
 	state->self_refresh_active = false;
+
+	if (drm_dev_has_vblank(crtc->dev))
+		state->no_vblank = true;
+	else
+		state->no_vblank = false;
 }
 EXPORT_SYMBOL(__drm_atomic_helper_crtc_duplicate_state);
 
diff --git a/drivers/gpu/drm/drm_vblank.c b/drivers/gpu/drm/drm_vblank.c
index 1659b13b178c..32cab3d3c872 100644
--- a/drivers/gpu/drm/drm_vblank.c
+++ b/drivers/gpu/drm/drm_vblank.c
@@ -81,6 +81,12 @@
  */
 #define DRM_REDUNDANT_VBLIRQ_THRESH_NS 1000000
 
+/* FIXME roll this out here in this file */
+bool drm_dev_has_vblank(dev)
+{
+	return dev->num_crtcs;
+}
+
 static bool
 drm_get_last_vbltimestamp(struct drm_device *dev, unsigned int pipe,
 			  ktime_t *tvblank, bool in_vblank_irq);


But maybe move the default value to some other/better place in the atomic
helpers, not sure what the best one is.

Plus then in the documentation patch also highlight the link between
crtc_state->no_vblank and drm_dev_has_vblank respectively
drm_device.num_crtcs.

That should plug this issue once for all across the board.

There's still the fun between having the vblank callbacks and the
drm_vblank setup, but that's a much older can of worms ...
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
