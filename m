Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A69EC433F5
	for <virtualization@archiver.kernel.org>; Wed, 16 Mar 2022 12:42:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A0568842E4;
	Wed, 16 Mar 2022 12:42:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LDYDpkzMGrty; Wed, 16 Mar 2022 12:41:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id D9960842B9;
	Wed, 16 Mar 2022 12:41:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AC79FC0012;
	Wed, 16 Mar 2022 12:41:58 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 86820C000B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Mar 2022 12:41:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 731BE408BC
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Mar 2022 12:41:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wo6XQ2L8PYJt
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Mar 2022 12:41:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp2.osuosl.org (Postfix) with ESMTP id D79E640521
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Mar 2022 12:41:55 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B57231476;
 Wed, 16 Mar 2022 05:41:54 -0700 (PDT)
Received: from [10.57.42.204] (unknown [10.57.42.204])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 046133F85F;
 Wed, 16 Mar 2022 05:41:50 -0700 (PDT)
Message-ID: <f2fed903-c61b-8040-ddfd-25a7bf0a625a@arm.com>
Date: Wed, 16 Mar 2022 12:41:46 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH v2 4/8] drm/virtio: Improve DMA API usage for shmem BOs
Content-Language: en-GB
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 David Airlie <airlied@linux.ie>, Gerd Hoffmann <kraxel@redhat.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu
 <olvaffe@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Gert Wollny <gert.wollny@collabora.com>,
 Tomeu Vizoso <tomeu.vizoso@collabora.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>,
 Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>
References: <20220314224253.236359-1-dmitry.osipenko@collabora.com>
 <20220314224253.236359-5-dmitry.osipenko@collabora.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20220314224253.236359-5-dmitry.osipenko@collabora.com>
Cc: Gustavo Padovan <gustavo.padovan@collabora.com>,
 Dmitry Osipenko <digetx@gmail.com>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On 2022-03-14 22:42, Dmitry Osipenko wrote:
> DRM API requires the DRM's driver to be backed with the device that can
> be used for generic DMA operations. The VirtIO-GPU device can't perform
> DMA operations if it uses PCI transport because PCI device driver creates
> a virtual VirtIO-GPU device that isn't associated with the PCI. Use PCI's
> GPU device for the DRM's device instead of the VirtIO-GPU device and drop
> DMA-related hacks from the VirtIO-GPU driver.
> 
> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> ---
>   drivers/gpu/drm/virtio/virtgpu_drv.c    | 22 +++++++---
>   drivers/gpu/drm/virtio/virtgpu_drv.h    |  5 +--
>   drivers/gpu/drm/virtio/virtgpu_kms.c    |  7 ++--
>   drivers/gpu/drm/virtio/virtgpu_object.c | 56 +++++--------------------
>   drivers/gpu/drm/virtio/virtgpu_vq.c     | 13 +++---
>   5 files changed, 37 insertions(+), 66 deletions(-)
> 
> diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.c b/drivers/gpu/drm/virtio/virtgpu_drv.c
> index 5f25a8d15464..8449dad3e65c 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_drv.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_drv.c
> @@ -46,9 +46,9 @@ static int virtio_gpu_modeset = -1;
>   MODULE_PARM_DESC(modeset, "Disable/Enable modesetting");
>   module_param_named(modeset, virtio_gpu_modeset, int, 0400);
>   
> -static int virtio_gpu_pci_quirk(struct drm_device *dev, struct virtio_device *vdev)
> +static int virtio_gpu_pci_quirk(struct drm_device *dev)
>   {
> -	struct pci_dev *pdev = to_pci_dev(vdev->dev.parent);
> +	struct pci_dev *pdev = to_pci_dev(dev->dev);
>   	const char *pname = dev_name(&pdev->dev);
>   	bool vga = (pdev->class >> 8) == PCI_CLASS_DISPLAY_VGA;
>   	char unique[20];
> @@ -101,6 +101,7 @@ static int virtio_gpu_pci_quirk(struct drm_device *dev, struct virtio_device *vd
>   static int virtio_gpu_probe(struct virtio_device *vdev)
>   {
>   	struct drm_device *dev;
> +	struct device *dma_dev;
>   	int ret;
>   
>   	if (drm_firmware_drivers_only() && virtio_gpu_modeset == -1)
> @@ -109,18 +110,29 @@ static int virtio_gpu_probe(struct virtio_device *vdev)
>   	if (virtio_gpu_modeset == 0)
>   		return -EINVAL;
>   
> -	dev = drm_dev_alloc(&driver, &vdev->dev);
> +	/*
> +	 * If GPU's parent is a PCI device, then we will use this PCI device
> +	 * for the DRM's driver device because GPU won't have PCI's IOMMU DMA
> +	 * ops in this case since GPU device is sitting on a separate (from PCI)
> +	 * virtio-bus.
> +	 */
> +	if (!strcmp(vdev->dev.parent->bus->name, "pci"))

Nit: dev_is_pci() ?

However, what about other VirtIO transports? Wouldn't virtio-mmio with 
F_ACCESS_PLATFORM be in a similar situation?

Robin.

> +		dma_dev = vdev->dev.parent;
> +	else
> +		dma_dev = &vdev->dev;
> +
> +	dev = drm_dev_alloc(&driver, dma_dev);
>   	if (IS_ERR(dev))
>   		return PTR_ERR(dev);
>   	vdev->priv = dev;
>   
>   	if (!strcmp(vdev->dev.parent->bus->name, "pci")) {
> -		ret = virtio_gpu_pci_quirk(dev, vdev);
> +		ret = virtio_gpu_pci_quirk(dev);
>   		if (ret)
>   			goto err_free;
>   	}
>   
> -	ret = virtio_gpu_init(dev);
> +	ret = virtio_gpu_init(vdev, dev);
>   	if (ret)
>   		goto err_free;
>   
> diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/virtgpu_drv.h
> index 0a194aaad419..b2d93cb12ebf 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_drv.h
> +++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
> @@ -100,8 +100,6 @@ struct virtio_gpu_object {
>   
>   struct virtio_gpu_object_shmem {
>   	struct virtio_gpu_object base;
> -	struct sg_table *pages;
> -	uint32_t mapped;
>   };
>   
>   struct virtio_gpu_object_vram {
> @@ -214,7 +212,6 @@ struct virtio_gpu_drv_cap_cache {
>   };
>   
>   struct virtio_gpu_device {
> -	struct device *dev;
>   	struct drm_device *ddev;
>   
>   	struct virtio_device *vdev;
> @@ -282,7 +279,7 @@ extern struct drm_ioctl_desc virtio_gpu_ioctls[DRM_VIRTIO_NUM_IOCTLS];
>   void virtio_gpu_create_context(struct drm_device *dev, struct drm_file *file);
>   
>   /* virtgpu_kms.c */
> -int virtio_gpu_init(struct drm_device *dev);
> +int virtio_gpu_init(struct virtio_device *vdev, struct drm_device *dev);
>   void virtio_gpu_deinit(struct drm_device *dev);
>   void virtio_gpu_release(struct drm_device *dev);
>   int virtio_gpu_driver_open(struct drm_device *dev, struct drm_file *file);
> diff --git a/drivers/gpu/drm/virtio/virtgpu_kms.c b/drivers/gpu/drm/virtio/virtgpu_kms.c
> index 3313b92db531..0d1e3eb61bee 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_kms.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_kms.c
> @@ -110,7 +110,7 @@ static void virtio_gpu_get_capsets(struct virtio_gpu_device *vgdev,
>   	vgdev->num_capsets = num_capsets;
>   }
>   
> -int virtio_gpu_init(struct drm_device *dev)
> +int virtio_gpu_init(struct virtio_device *vdev, struct drm_device *dev)
>   {
>   	static vq_callback_t *callbacks[] = {
>   		virtio_gpu_ctrl_ack, virtio_gpu_cursor_ack
> @@ -123,7 +123,7 @@ int virtio_gpu_init(struct drm_device *dev)
>   	u32 num_scanouts, num_capsets;
>   	int ret = 0;
>   
> -	if (!virtio_has_feature(dev_to_virtio(dev->dev), VIRTIO_F_VERSION_1))
> +	if (!virtio_has_feature(vdev, VIRTIO_F_VERSION_1))
>   		return -ENODEV;
>   
>   	vgdev = kzalloc(sizeof(struct virtio_gpu_device), GFP_KERNEL);
> @@ -132,8 +132,7 @@ int virtio_gpu_init(struct drm_device *dev)
>   
>   	vgdev->ddev = dev;
>   	dev->dev_private = vgdev;
> -	vgdev->vdev = dev_to_virtio(dev->dev);
> -	vgdev->dev = dev->dev;
> +	vgdev->vdev = vdev;
>   
>   	spin_lock_init(&vgdev->display_info_lock);
>   	spin_lock_init(&vgdev->resource_export_lock);
> diff --git a/drivers/gpu/drm/virtio/virtgpu_object.c b/drivers/gpu/drm/virtio/virtgpu_object.c
> index 0b8cbb87f8d8..1964c0d8b51f 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_object.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_object.c
> @@ -67,21 +67,6 @@ void virtio_gpu_cleanup_object(struct virtio_gpu_object *bo)
>   
>   	virtio_gpu_resource_id_put(vgdev, bo->hw_res_handle);
>   	if (virtio_gpu_is_shmem(bo)) {
> -		struct virtio_gpu_object_shmem *shmem = to_virtio_gpu_shmem(bo);
> -
> -		if (shmem->pages) {
> -			if (shmem->mapped) {
> -				dma_unmap_sgtable(vgdev->vdev->dev.parent,
> -					     shmem->pages, DMA_TO_DEVICE, 0);
> -				shmem->mapped = 0;
> -			}
> -
> -			sg_free_table(shmem->pages);
> -			kfree(shmem->pages);
> -			shmem->pages = NULL;
> -			drm_gem_shmem_unpin(&bo->base);
> -		}
> -
>   		drm_gem_shmem_free(&bo->base);
>   	} else if (virtio_gpu_is_vram(bo)) {
>   		struct virtio_gpu_object_vram *vram = to_virtio_gpu_vram(bo);
> @@ -153,37 +138,18 @@ static int virtio_gpu_object_shmem_init(struct virtio_gpu_device *vgdev,
>   					unsigned int *nents)
>   {
>   	bool use_dma_api = !virtio_has_dma_quirk(vgdev->vdev);
> -	struct virtio_gpu_object_shmem *shmem = to_virtio_gpu_shmem(bo);
>   	struct scatterlist *sg;
> -	int si, ret;
> +	struct sg_table *pages;
> +	int si;
>   
> -	ret = drm_gem_shmem_pin(&bo->base);
> -	if (ret < 0)
> -		return -EINVAL;
> -
> -	/*
> -	 * virtio_gpu uses drm_gem_shmem_get_sg_table instead of
> -	 * drm_gem_shmem_get_pages_sgt because virtio has it's own set of
> -	 * dma-ops. This is discouraged for other drivers, but should be fine
> -	 * since virtio_gpu doesn't support dma-buf import from other devices.
> -	 */
> -	shmem->pages = drm_gem_shmem_get_sg_table(&bo->base);
> -	ret = PTR_ERR(shmem->pages);
> -	if (ret) {
> -		drm_gem_shmem_unpin(&bo->base);
> -		shmem->pages = NULL;
> -		return ret;
> -	}
> +	pages = drm_gem_shmem_get_pages_sgt(&bo->base);
> +	if (IS_ERR(pages))
> +		return PTR_ERR(pages);
>   
> -	if (use_dma_api) {
> -		ret = dma_map_sgtable(vgdev->vdev->dev.parent,
> -				      shmem->pages, DMA_TO_DEVICE, 0);
> -		if (ret)
> -			return ret;
> -		*nents = shmem->mapped = shmem->pages->nents;
> -	} else {
> -		*nents = shmem->pages->orig_nents;
> -	}
> +	if (use_dma_api)
> +		*nents = pages->nents;
> +	else
> +		*nents = pages->orig_nents;
>   
>   	*ents = kvmalloc_array(*nents,
>   			       sizeof(struct virtio_gpu_mem_entry),
> @@ -194,13 +160,13 @@ static int virtio_gpu_object_shmem_init(struct virtio_gpu_device *vgdev,
>   	}
>   
>   	if (use_dma_api) {
> -		for_each_sgtable_dma_sg(shmem->pages, sg, si) {
> +		for_each_sgtable_dma_sg(pages, sg, si) {
>   			(*ents)[si].addr = cpu_to_le64(sg_dma_address(sg));
>   			(*ents)[si].length = cpu_to_le32(sg_dma_len(sg));
>   			(*ents)[si].padding = 0;
>   		}
>   	} else {
> -		for_each_sgtable_sg(shmem->pages, sg, si) {
> +		for_each_sgtable_sg(pages, sg, si) {
>   			(*ents)[si].addr = cpu_to_le64(sg_phys(sg));
>   			(*ents)[si].length = cpu_to_le32(sg->length);
>   			(*ents)[si].padding = 0;
> diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio/virtgpu_vq.c
> index 2edf31806b74..06566e44307d 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_vq.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
> @@ -593,11 +593,10 @@ void virtio_gpu_cmd_transfer_to_host_2d(struct virtio_gpu_device *vgdev,
>   	struct virtio_gpu_transfer_to_host_2d *cmd_p;
>   	struct virtio_gpu_vbuffer *vbuf;
>   	bool use_dma_api = !virtio_has_dma_quirk(vgdev->vdev);
> -	struct virtio_gpu_object_shmem *shmem = to_virtio_gpu_shmem(bo);
>   
>   	if (virtio_gpu_is_shmem(bo) && use_dma_api)
> -		dma_sync_sgtable_for_device(vgdev->vdev->dev.parent,
> -					    shmem->pages, DMA_TO_DEVICE);
> +		dma_sync_sgtable_for_device(&vgdev->vdev->dev,
> +					    bo->base.sgt, DMA_TO_DEVICE);
>   
>   	cmd_p = virtio_gpu_alloc_cmd(vgdev, &vbuf, sizeof(*cmd_p));
>   	memset(cmd_p, 0, sizeof(*cmd_p));
> @@ -1017,11 +1016,9 @@ void virtio_gpu_cmd_transfer_to_host_3d(struct virtio_gpu_device *vgdev,
>   	struct virtio_gpu_vbuffer *vbuf;
>   	bool use_dma_api = !virtio_has_dma_quirk(vgdev->vdev);
>   
> -	if (virtio_gpu_is_shmem(bo) && use_dma_api) {
> -		struct virtio_gpu_object_shmem *shmem = to_virtio_gpu_shmem(bo);
> -		dma_sync_sgtable_for_device(vgdev->vdev->dev.parent,
> -					    shmem->pages, DMA_TO_DEVICE);
> -	}
> +	if (virtio_gpu_is_shmem(bo) && use_dma_api)
> +		dma_sync_sgtable_for_device(&vgdev->vdev->dev,
> +					    bo->base.sgt, DMA_TO_DEVICE);
>   
>   	cmd_p = virtio_gpu_alloc_cmd(vgdev, &vbuf, sizeof(*cmd_p));
>   	memset(cmd_p, 0, sizeof(*cmd_p));
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
