From: Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH] drm/qxl: add drm_driver.release callback.
Date: Fri, 7 Feb 2020 14:44:11 +0100
Message-ID: <20200207134411.GB43062@phenom.ffwll.local>
References: <20200207121405.25895-1-kraxel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200207121405.25895-1-kraxel@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: dri-devel@lists.freedesktop.org, Dave Airlie <airlied@redhat.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, "open list:DRM DRIVER FOR QXL VIRTUAL GPU" <virtualization@lists.linux-foundation.org>, "open list:DRM DRIVER FOR QXL VIRTUAL GPU" <spice-devel@lists.freedesktop.org>, open list <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Feb 07, 2020 at 01:14:05PM +0100, Gerd Hoffmann wrote:
> Move final cleanups to qxl_drm_release() callback.
> Add drm_atomic_helper_shutdown() call to qxl_pci_remove().
> 
> Reorder calls in qxl_device_fini().  Cleaning up gem & ttm
> might trigger qxl commands, so we should do that before
> releaseing command rings.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  drivers/gpu/drm/qxl/qxl_drv.c | 21 ++++++++++++++-------
>  drivers/gpu/drm/qxl/qxl_kms.c |  8 ++++----
>  2 files changed, 18 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/gpu/drm/qxl/qxl_drv.c b/drivers/gpu/drm/qxl/qxl_drv.c
> index 1d601f57a6ba..8044363ba0f2 100644
> --- a/drivers/gpu/drm/qxl/qxl_drv.c
> +++ b/drivers/gpu/drm/qxl/qxl_drv.c
> @@ -34,6 +34,7 @@
>  #include <linux/pci.h>
>  
>  #include <drm/drm.h>
> +#include <drm/drm_atomic_helper.h>
>  #include <drm/drm_drv.h>
>  #include <drm/drm_file.h>
>  #include <drm/drm_modeset_helper.h>
> @@ -132,21 +133,25 @@ qxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>  	return ret;
>  }
>  
> +static void qxl_drm_release(struct drm_device *dev)
> +{
> +	struct qxl_device *qdev = dev->dev_private;
> +
> +	qxl_modeset_fini(qdev);
> +	qxl_device_fini(qdev);

Same here, there's a few iounmap and io_mapping_free which I think should
be in the pci_remove hook.
-Daniel

> +	dev->dev_private = NULL;
> +	kfree(qdev);
> +}
> +
>  static void
>  qxl_pci_remove(struct pci_dev *pdev)
>  {
>  	struct drm_device *dev = pci_get_drvdata(pdev);
> -	struct qxl_device *qdev = dev->dev_private;
>  
>  	drm_dev_unregister(dev);
> -
> -	qxl_modeset_fini(qdev);
> -	qxl_device_fini(qdev);
> +	drm_atomic_helper_shutdown(dev);
>  	if (is_vga(pdev))
>  		vga_put(pdev, VGA_RSRC_LEGACY_IO);
> -
> -	dev->dev_private = NULL;
> -	kfree(qdev);
>  	drm_dev_put(dev);
>  }
>  
> @@ -279,6 +284,8 @@ static struct drm_driver qxl_driver = {
>  	.major = 0,
>  	.minor = 1,
>  	.patchlevel = 0,
> +
> +	.release = qxl_drm_release,
>  };
>  
>  static int __init qxl_init(void)
> diff --git a/drivers/gpu/drm/qxl/qxl_kms.c b/drivers/gpu/drm/qxl/qxl_kms.c
> index bfc1631093e9..70b20ee4741a 100644
> --- a/drivers/gpu/drm/qxl/qxl_kms.c
> +++ b/drivers/gpu/drm/qxl/qxl_kms.c
> @@ -299,12 +299,12 @@ void qxl_device_fini(struct qxl_device *qdev)
>  {
>  	qxl_bo_unref(&qdev->current_release_bo[0]);
>  	qxl_bo_unref(&qdev->current_release_bo[1]);
> -	flush_work(&qdev->gc_work);
> -	qxl_ring_free(qdev->command_ring);
> -	qxl_ring_free(qdev->cursor_ring);
> -	qxl_ring_free(qdev->release_ring);
>  	qxl_gem_fini(qdev);
>  	qxl_bo_fini(qdev);
> +	flush_work(&qdev->gc_work);
> +	qxl_ring_free(qdev->command_ring);
> +	qxl_ring_free(qdev->cursor_ring);
> +	qxl_ring_free(qdev->release_ring);
>  	io_mapping_free(qdev->surface_mapping);
>  	io_mapping_free(qdev->vram_mapping);
>  	iounmap(qdev->ram_header);
> -- 
> 2.18.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
