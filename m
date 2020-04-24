From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH 26/59] drm/qxl: Use devm_drm_dev_alloc
Date: Fri, 24 Apr 2020 17:09:11 +0200
Message-ID: <20200424150911.GB20856@ravnborg.org>
References: <20200415074034.175360-1-daniel.vetter@ffwll.ch>
 <20200415074034.175360-27-daniel.vetter@ffwll.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
Content-Disposition: inline
In-Reply-To: <20200415074034.175360-27-daniel.vetter@ffwll.ch>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: intel-gfx-bounces@lists.freedesktop.org
Sender: "Intel-gfx" <intel-gfx-bounces@lists.freedesktop.org>
To: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Dave Airlie <airlied@redhat.com>, Intel Graphics Development <intel-gfx@lists.freedesktop.org>, DRI Development <dri-devel@lists.freedesktop.org>, virtualization@lists.linux-foundation.org, Gerd Hoffmann <kraxel@redhat.com>, spice-devel@lists.freedesktop.org, Daniel Vetter <daniel.vetter@intel.com>
List-Id: virtualization@lists.linuxfoundation.org

Hi Daniel

On Wed, Apr 15, 2020 at 09:40:01AM +0200, Daniel Vetter wrote:
> Also need to remove the drm_dev_put from the remove hook.
> 
> Acked-by: Gerd Hoffmann <kraxel@redhat.com>
> Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> Cc: Dave Airlie <airlied@redhat.com>
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Cc: virtualization@lists.linux-foundation.org
> Cc: spice-devel@lists.freedesktop.org
> ---
>  drivers/gpu/drm/qxl/qxl_drv.c | 15 ++++++++-------
>  drivers/gpu/drm/qxl/qxl_drv.h |  3 +--
>  drivers/gpu/drm/qxl/qxl_kms.c | 12 +-----------
>  3 files changed, 10 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/gpu/drm/qxl/qxl_drv.c b/drivers/gpu/drm/qxl/qxl_drv.c
> index 09102e2efabc..6b4ae4c5fb76 100644
> --- a/drivers/gpu/drm/qxl/qxl_drv.c
> +++ b/drivers/gpu/drm/qxl/qxl_drv.c
> @@ -81,13 +81,16 @@ qxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>  		return -EINVAL; /* TODO: ENODEV ? */
>  	}
>  
> -	qdev = kzalloc(sizeof(struct qxl_device), GFP_KERNEL);
> -	if (!qdev)
> +	qdev = devm_drm_dev_alloc(&pdev->dev, &qxl_driver,
> +				  struct qxl_device, ddev);
> +	if (IS_ERR(qdev)) {
> +		pr_err("Unable to init drm dev");
>  		return -ENOMEM;
> +	}

The other patches do not add any error message when devm_drm_dev_alloc()
fails and driver core will log that driver init failed.

So the pr_err() above should be dropped.
I know it comes from qxl_device_init() but that does not make it a good
idea.

With this fixed:
Acked-by: Sam Ravnborg <sam@ravnborg.org>

>  
>  	ret = pci_enable_device(pdev);
>  	if (ret)
> -		goto free_dev;
> +		return ret;
>  
>  	ret = drm_fb_helper_remove_conflicting_pci_framebuffers(pdev, "qxl");
>  	if (ret)
> @@ -101,7 +104,7 @@ qxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>  		}
>  	}
>  
> -	ret = qxl_device_init(qdev, &qxl_driver, pdev);
> +	ret = qxl_device_init(qdev, pdev);
>  	if (ret)
>  		goto put_vga;
>  
> @@ -128,8 +131,7 @@ qxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>  		vga_put(pdev, VGA_RSRC_LEGACY_IO);
>  disable_pci:
>  	pci_disable_device(pdev);
> -free_dev:
> -	kfree(qdev);
> +
>  	return ret;
>  }
>  
> @@ -155,7 +157,6 @@ qxl_pci_remove(struct pci_dev *pdev)
>  	drm_atomic_helper_shutdown(dev);
>  	if (is_vga(pdev))
>  		vga_put(pdev, VGA_RSRC_LEGACY_IO);
> -	drm_dev_put(dev);
>  }
>  
>  DEFINE_DRM_GEM_FOPS(qxl_fops);
> diff --git a/drivers/gpu/drm/qxl/qxl_drv.h b/drivers/gpu/drm/qxl/qxl_drv.h
> index 435126facc9b..86ac191d9205 100644
> --- a/drivers/gpu/drm/qxl/qxl_drv.h
> +++ b/drivers/gpu/drm/qxl/qxl_drv.h
> @@ -276,8 +276,7 @@ struct qxl_device {
>  extern const struct drm_ioctl_desc qxl_ioctls[];
>  extern int qxl_max_ioctl;
>  
> -int qxl_device_init(struct qxl_device *qdev, struct drm_driver *drv,
> -		    struct pci_dev *pdev);
> +int qxl_device_init(struct qxl_device *qdev, struct pci_dev *pdev);
>  void qxl_device_fini(struct qxl_device *qdev);
>  
>  int qxl_modeset_init(struct qxl_device *qdev);
> diff --git a/drivers/gpu/drm/qxl/qxl_kms.c b/drivers/gpu/drm/qxl/qxl_kms.c
> index 9eed1a375f24..91a34dd835d7 100644
> --- a/drivers/gpu/drm/qxl/qxl_kms.c
> +++ b/drivers/gpu/drm/qxl/qxl_kms.c
> @@ -108,21 +108,13 @@ static void qxl_gc_work(struct work_struct *work)
>  }
>  
>  int qxl_device_init(struct qxl_device *qdev,
> -		    struct drm_driver *drv,
>  		    struct pci_dev *pdev)
>  {
>  	int r, sb;
>  
> -	r = drm_dev_init(&qdev->ddev, drv, &pdev->dev);
> -	if (r) {
> -		pr_err("Unable to init drm dev");
> -		goto error;
> -	}
> -
>  	qdev->ddev.pdev = pdev;
>  	pci_set_drvdata(pdev, &qdev->ddev);
>  	qdev->ddev.dev_private = qdev;
> -	drmm_add_final_kfree(&qdev->ddev, qdev);
>  
>  	mutex_init(&qdev->gem.mutex);
>  	mutex_init(&qdev->update_area_mutex);
> @@ -138,8 +130,7 @@ int qxl_device_init(struct qxl_device *qdev,
>  	qdev->vram_mapping = io_mapping_create_wc(qdev->vram_base, pci_resource_len(pdev, 0));
>  	if (!qdev->vram_mapping) {
>  		pr_err("Unable to create vram_mapping");
> -		r = -ENOMEM;
> -		goto error;
> +		return -ENOMEM;
>  	}
>  
>  	if (pci_resource_len(pdev, 4) > 0) {
> @@ -293,7 +284,6 @@ int qxl_device_init(struct qxl_device *qdev,
>  	io_mapping_free(qdev->surface_mapping);
>  vram_mapping_free:
>  	io_mapping_free(qdev->vram_mapping);
> -error:
>  	return r;
>  }
>  
> -- 
> 2.25.1
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
