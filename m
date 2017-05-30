From: Neil Armstrong <narmstrong@baylibre.com>
Subject: Re: [PATCH 02/37] drm: Remove drm_device->virtdev
Date: Tue, 30 May 2017 09:33:58 +0200
Message-ID: <aa02cbd4-9d81-c643-1d2f-69338980ec3f__46792.8785052665$1497319606$gmane$org@baylibre.com>
References: <20170524145212.27837-1-daniel.vetter@ffwll.ch>
	<20170524145212.27837-3-daniel.vetter@ffwll.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20170524145212.27837-3-daniel.vetter@ffwll.ch>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Daniel Vetter <daniel.vetter@ffwll.ch>, DRI Development <dri-devel@lists.freedesktop.org>
Cc: Daniel Vetter <daniel.vetter@intel.com>, Intel Graphics Development <intel-gfx@lists.freedesktop.org>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On 05/24/2017 04:51 PM, Daniel Vetter wrote:
> This is a leftover from the drm_bus days, where we've had a
> bus-specific device type for every bus type in drm_device. Except for
> pci (which we can't remove because dri1 drivers) this is all gone. And
> the virt driver also doesn't really need it, dev_to_virtio works
> perfectly fine.
> 
> Cc: David Airlie <airlied@linux.ie>
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Cc: virtualization@lists.linux-foundation.org
> Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> ---
>  drivers/gpu/drm/virtio/virtgpu_drm_bus.c | 1 -
>  drivers/gpu/drm/virtio/virtgpu_kms.c     | 4 ++--
>  include/drm/drmP.h                       | 2 --
>  3 files changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/virtio/virtgpu_drm_bus.c b/drivers/gpu/drm/virtio/virtgpu_drm_bus.c
> index 43e1d5916c6c..7df8d0c9026a 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_drm_bus.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_drm_bus.c
> @@ -56,7 +56,6 @@ int drm_virtio_init(struct drm_driver *driver, struct virtio_device *vdev)
>  	dev = drm_dev_alloc(driver, &vdev->dev);
>  	if (IS_ERR(dev))
>  		return PTR_ERR(dev);
> -	dev->virtdev = vdev;
>  	vdev->priv = dev;
>  
>  	if (strcmp(vdev->dev.parent->bus->name, "pci") == 0) {
> diff --git a/drivers/gpu/drm/virtio/virtgpu_kms.c b/drivers/gpu/drm/virtio/virtgpu_kms.c
> index 1e1c90b30d4a..6400506a06b0 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_kms.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_kms.c
> @@ -138,7 +138,7 @@ int virtio_gpu_driver_load(struct drm_device *dev, unsigned long flags)
>  	u32 num_scanouts, num_capsets;
>  	int ret;
>  
> -	if (!virtio_has_feature(dev->virtdev, VIRTIO_F_VERSION_1))
> +	if (!virtio_has_feature(dev_to_virtio(dev->dev), VIRTIO_F_VERSION_1))
>  		return -ENODEV;
>  
>  	vgdev = kzalloc(sizeof(struct virtio_gpu_device), GFP_KERNEL);
> @@ -147,7 +147,7 @@ int virtio_gpu_driver_load(struct drm_device *dev, unsigned long flags)
>  
>  	vgdev->ddev = dev;
>  	dev->dev_private = vgdev;
> -	vgdev->vdev = dev->virtdev;
> +	vgdev->vdev = dev_to_virtio(dev->dev);
>  	vgdev->dev = dev->dev;
>  
>  	spin_lock_init(&vgdev->display_info_lock);
> diff --git a/include/drm/drmP.h b/include/drm/drmP.h
> index 575b29b47811..c363f2fdff31 100644
> --- a/include/drm/drmP.h
> +++ b/include/drm/drmP.h
> @@ -412,8 +412,6 @@ struct drm_device {
>  	struct pci_controller *hose;
>  #endif
>  
> -	struct virtio_device *virtdev;
> -
>  	struct drm_sg_mem *sg;	/**< Scatter gather memory */
>  	unsigned int num_crtcs;                  /**< Number of CRTCs on this device */
>  
> 

Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
