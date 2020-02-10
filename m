From: Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH v2] drm/bochs: add drm_driver.release callback.
Date: Mon, 10 Feb 2020 15:55:36 +0100
Message-ID: <20200210145536.GR43062@phenom.ffwll.local>
References: <20200210093801.4773-1-kraxel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200210093801.4773-1-kraxel@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: dri-devel@lists.freedesktop.org, daniel@ffwll.ch, David Airlie <airlied@linux.ie>, "open list:DRM DRIVER FOR BOCHS VIRTUAL GPU" <virtualization@lists.linux-foundation.org>, open list <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Feb 10, 2020 at 10:38:01AM +0100, Gerd Hoffmann wrote:
> Call drm_dev_unregister() first in bochs_pci_remove().  Hook
> bochs_unload() into the new .release callback, to make sure cleanup
> is done when all users are gone.
> 
> Add ready bool to state struct and move bochs_hw_fini() call from
> bochs_unload() to bochs_pci_remove() to make sure hardware is not
> touched after bochs_pci_remove returns.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  drivers/gpu/drm/bochs/bochs.h     |  1 +
>  drivers/gpu/drm/bochs/bochs_drv.c |  6 +++---
>  drivers/gpu/drm/bochs/bochs_hw.c  | 14 ++++++++++++++
>  3 files changed, 18 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bochs/bochs.h b/drivers/gpu/drm/bochs/bochs.h
> index 917767173ee6..f6bce8669274 100644
> --- a/drivers/gpu/drm/bochs/bochs.h
> +++ b/drivers/gpu/drm/bochs/bochs.h
> @@ -57,6 +57,7 @@ struct bochs_device {
>  	unsigned long  fb_base;
>  	unsigned long  fb_size;
>  	unsigned long  qext_size;
> +	bool           ready;
>  
>  	/* mode */
>  	u16 xres;
> diff --git a/drivers/gpu/drm/bochs/bochs_drv.c b/drivers/gpu/drm/bochs/bochs_drv.c
> index 10460878414e..60b5492739ef 100644
> --- a/drivers/gpu/drm/bochs/bochs_drv.c
> +++ b/drivers/gpu/drm/bochs/bochs_drv.c
> @@ -23,7 +23,6 @@ static void bochs_unload(struct drm_device *dev)
>  
>  	bochs_kms_fini(bochs);
>  	bochs_mm_fini(bochs);
> -	bochs_hw_fini(dev);
>  	kfree(bochs);
>  	dev->dev_private = NULL;
>  }
> @@ -69,6 +68,7 @@ static struct drm_driver bochs_driver = {
>  	.major			= 1,
>  	.minor			= 0,
>  	DRM_GEM_VRAM_DRIVER,
> +	.release                = bochs_unload,
>  };
>  
>  /* ---------------------------------------------------------------------- */
> @@ -148,9 +148,9 @@ static void bochs_pci_remove(struct pci_dev *pdev)
>  {
>  	struct drm_device *dev = pci_get_drvdata(pdev);
>  
> -	drm_atomic_helper_shutdown(dev);
>  	drm_dev_unregister(dev);
> -	bochs_unload(dev);
> +	drm_atomic_helper_shutdown(dev);
> +	bochs_hw_fini(dev);
>  	drm_dev_put(dev);
>  }
>  
> diff --git a/drivers/gpu/drm/bochs/bochs_hw.c b/drivers/gpu/drm/bochs/bochs_hw.c
> index b615b7dfdd9d..48c1a6a8b026 100644
> --- a/drivers/gpu/drm/bochs/bochs_hw.c
> +++ b/drivers/gpu/drm/bochs/bochs_hw.c
> @@ -168,6 +168,7 @@ int bochs_hw_init(struct drm_device *dev)
>  	}
>  	bochs->fb_base = addr;
>  	bochs->fb_size = size;
> +	bochs->ready = true;
>  
>  	DRM_INFO("Found bochs VGA, ID 0x%x.\n", id);
>  	DRM_INFO("Framebuffer size %ld kB @ 0x%lx, %s @ 0x%lx.\n",
> @@ -194,6 +195,10 @@ void bochs_hw_fini(struct drm_device *dev)
>  {
>  	struct bochs_device *bochs = dev->dev_private;
>  
> +	bochs->ready = false;
> +
> +	/* TODO: shot down existing vram mappings */

Aside: I'm mildly hopefull that we could do this with a generic helper,
both punching out all current ptes and replacing them with something
dummy. Since replacing them with nothing and refusing to fault stuff is
probably not going to work out well - userspace will crash&burn too much.

> +
>  	if (bochs->mmio)
>  		iounmap(bochs->mmio);
>  	if (bochs->ioports)
> @@ -207,6 +212,9 @@ void bochs_hw_fini(struct drm_device *dev)
>  void bochs_hw_setmode(struct bochs_device *bochs,
>  		      struct drm_display_mode *mode)
>  {
> +	if (!bochs->ready)
> +		return;

drm_dev_enter/exit is the primitive you're looking for I think. Don't hand
roll your own racy version of this. btw changelog in the patch missing.
Personally I'd split out the drm_dev_enter/exit in a 2nd patch, but up to
you.

The remove/release split looks correct to me now.
-Daniel


> +
>  	bochs->xres = mode->hdisplay;
>  	bochs->yres = mode->vdisplay;
>  	bochs->bpp = 32;
> @@ -237,6 +245,9 @@ void bochs_hw_setmode(struct bochs_device *bochs,
>  void bochs_hw_setformat(struct bochs_device *bochs,
>  			const struct drm_format_info *format)
>  {
> +	if (!bochs->ready)
> +		return;
> +
>  	DRM_DEBUG_DRIVER("format %c%c%c%c\n",
>  			 (format->format >>  0) & 0xff,
>  			 (format->format >>  8) & 0xff,
> @@ -264,6 +275,9 @@ void bochs_hw_setbase(struct bochs_device *bochs,
>  	unsigned long offset;
>  	unsigned int vx, vy, vwidth;
>  
> +	if (!bochs->ready)
> +		return;
> +
>  	bochs->stride = stride;
>  	offset = (unsigned long)addr +
>  		y * bochs->stride +
> -- 
> 2.18.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
