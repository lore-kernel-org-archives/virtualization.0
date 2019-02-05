From: Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH] drm/cirrus: add plane setup
Date: Tue, 5 Feb 2019 10:00:04 +0100
Message-ID: <20190205090004.GZ3271__43533.4649098635$1549381194$gmane$org@phenom.ffwll.local>
References: <20190204110131.21467-1-kraxel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190204110131.21467-1-kraxel@redhat.com>
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
Cc: David Airlie <airlied@linux.ie>, open list <linux-kernel@vger.kernel.org>, dri-devel@lists.freedesktop.org, "open list:DRM DRIVER FOR QEMU'S CIRRUS DEVICE" <virtualization@lists.linux-foundation.org>, Daniel Vetter <daniel@ffwll.ch>, Dave Airlie <airlied@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Feb 04, 2019 at 12:01:31PM +0100, Gerd Hoffmann wrote:
> Commit "f4bd542bca drm/fb-helper: Scale back depth to supported maximum"
> uncovered a bug in the cirrus driver.  It must create its own primary
> plane, using the correct format list, depending on the bpp module
> parameter, so it is consistent with mode_config->preferred_depth.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  drivers/gpu/drm/cirrus/cirrus_mode.c | 67 +++++++++++++++++++++++++++++++++++-
>  1 file changed, 66 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/cirrus/cirrus_mode.c b/drivers/gpu/drm/cirrus/cirrus_mode.c
> index a830e70fc0..2e966a22c5 100644
> --- a/drivers/gpu/drm/cirrus/cirrus_mode.c
> +++ b/drivers/gpu/drm/cirrus/cirrus_mode.c
> @@ -360,10 +360,67 @@ static const struct drm_crtc_helper_funcs cirrus_helper_funcs = {
>  };
>  
>  /* CRTC setup */
> +static const uint32_t cirrus_formats_16[] = {
> +	DRM_FORMAT_RGB565,
> +};
> +
> +static const uint32_t cirrus_formats_24[] = {
> +	DRM_FORMAT_RGB888,
> +};
> +
> +static const uint32_t cirrus_formats_32[] = {
> +	DRM_FORMAT_XRGB8888,
> +	DRM_FORMAT_ARGB8888,
> +};

I'd include the lower-res formats too here, without those you limit
userspace that looks at this stuff to only these formats. Not that this is
really important for cirrus ... So 24bits would include 16, and 32 would
include 24 and 16. With that:

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

> +
> +static struct drm_plane *cirrus_primary_plane(struct drm_device *dev)
> +{
> +	const uint32_t *formats;
> +	uint32_t nformats;
> +	struct drm_plane *primary;
> +	int ret;
> +
> +	switch (cirrus_bpp) {
> +	case 16:
> +		formats = cirrus_formats_16;
> +		nformats = ARRAY_SIZE(cirrus_formats_16);
> +		break;
> +	case 24:
> +		formats = cirrus_formats_24;
> +		nformats = ARRAY_SIZE(cirrus_formats_24);
> +		break;
> +	case 32:
> +		formats = cirrus_formats_32;
> +		nformats = ARRAY_SIZE(cirrus_formats_32);
> +		break;
> +	default:
> +		return NULL;
> +	}
> +
> +	primary = kzalloc(sizeof(*primary), GFP_KERNEL);
> +	if (primary == NULL) {
> +		DRM_DEBUG_KMS("Failed to allocate primary plane\n");
> +		return NULL;
> +	}
> +
> +	ret = drm_universal_plane_init(dev, primary, 0,
> +				       &drm_primary_helper_funcs,
> +				       formats, nformats,
> +				       NULL,
> +				       DRM_PLANE_TYPE_PRIMARY, NULL);
> +	if (ret) {
> +		kfree(primary);
> +		primary = NULL;
> +	}
> +
> +	return primary;
> +}
> +
>  static void cirrus_crtc_init(struct drm_device *dev)
>  {
>  	struct cirrus_device *cdev = dev->dev_private;
>  	struct cirrus_crtc *cirrus_crtc;
> +	struct drm_plane *primary;
>  
>  	cirrus_crtc = kzalloc(sizeof(struct cirrus_crtc) +
>  			      (CIRRUSFB_CONN_LIMIT * sizeof(struct drm_connector *)),
> @@ -372,7 +429,15 @@ static void cirrus_crtc_init(struct drm_device *dev)
>  	if (cirrus_crtc == NULL)
>  		return;
>  
> -	drm_crtc_init(dev, &cirrus_crtc->base, &cirrus_crtc_funcs);
> +	primary = cirrus_primary_plane(dev);
> +	if (primary == NULL) {
> +		kfree(cirrus_crtc);
> +		return;
> +	}
> +
> +	drm_crtc_init_with_planes(dev, &cirrus_crtc->base,
> +				  primary, NULL,
> +				  &cirrus_crtc_funcs, NULL);
>  
>  	drm_mode_crtc_set_gamma_size(&cirrus_crtc->base, CIRRUS_LUT_SIZE);
>  	cdev->mode_info.crtc = cirrus_crtc;
> -- 
> 2.9.3
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
