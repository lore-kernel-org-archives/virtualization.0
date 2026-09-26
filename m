Received: from www3579.sakura.ne.jp (www3579.sakura.ne.jp [49.212.243.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44FB63EA97A
	for <virtualization@lists.linux.dev>; Sat, 26 Sep 2026 11:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.212.243.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790422458; cv=none; b=H65tGF76Zb/NJs5ydZGt/XQ5VnT1sPRAYQR07OgXOjHwmet9zLI/qtfQgF2wPjaUhElgUU5ztBgmFC6aKnj1sNNPWt3xIXr0iIu+yr3L9uU4cZd08/p3doXAp/kVgvSkAn4ljKr3lIkl/rYxA36g1qHsCwH90k0K4CT+/YdhBBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790422458; c=relaxed/simple;
	bh=+2318fLIEKRdAaDfMt/VkSOcSIvOsWP1QsAVllACjwY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GMkH6qZxIBbS100FwgiMrerYxviZMMQ2XrT0z8dwe+re5jAOy75lCrKxAPCufF3qzvesrr2JOrihsd4ZE8sl5lkNLReLk5OPqvURBanDJ5ZLj5+KC45e7edulfyIfrVCWNd4e/06c4tRHB8sZYARRNrdOvom/sA4z/vQYPqBKrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rsg.ci.i.u-tokyo.ac.jp; spf=pass smtp.mailfrom=rsg.ci.i.u-tokyo.ac.jp; dkim=pass (2048-bit key) header.d=rsg.ci.i.u-tokyo.ac.jp header.i=@rsg.ci.i.u-tokyo.ac.jp header.b=La/KELX3; arc=none smtp.client-ip=49.212.243.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rsg.ci.i.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rsg.ci.i.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rsg.ci.i.u-tokyo.ac.jp header.i=@rsg.ci.i.u-tokyo.ac.jp header.b="La/KELX3"
Received: from [133.11.54.183] (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
	(authenticated bits=0)
	by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 68QBXqon036661
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Sat, 26 Sep 2026 20:33:52 +0900 (JST)
	(envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=QMZDCy3tPxqguplaGG3KPkMSeAQYvGfIE4Fox8IiofM=;
        c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
        h=From:Message-ID:To:Subject:Date;
        s=rs20250326; t=1790422432; v=1;
        b=La/KELX30GXSEmk9g/85VhHIYysbSmMTcZYdZtk7AnLTnQxJnVvYX2J/RNgaIcff
         vdzWK+7jGNeozbZR5RzEQvkJHRsOwLuOXt0ShKcitTDL1vagYtVZyJcn+xrNG8H4
         zwXvpRVMQuRZcC7lzwVgMNMejWjbWQFRKrufr7ExLGroGwCzAx9L2gAE0wotgIwS
         v+IuRhmuhOQkOAFtoKFlJgWn5lzFhCbexo0LBeOL4D/fUnqYk4nU0J75ilRRz7ao
         e9l3uPaGYPwYkGjTm6/SAP8BZwKR/xamb0exzTqpCEVvs7f8ygLq0kerbY8x4slI
         u2AG7ISVuw0M/hufyzCCtQ==
Message-ID: <fd17a38e-a827-41a5-a46e-db2135bb9257@rsg.ci.i.u-tokyo.ac.jp>
Date: Sat, 26 Sep 2026 20:33:51 +0900
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v9 3/4] drm/virtio: implement userptr resource support
To: Honglei Huang <honghuan@amd.com>, dmitry.osipenko@collabora.com,
        airlied@redhat.com, kraxel@redhat.com
Cc: gurchetansingh@chromium.org, olvaffe@gmail.com, Ray.Huang@amd.com,
        dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20260924095556.1326164-1-honghuan@amd.com>
 <20260924095556.1326164-4-honghuan@amd.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260924095556.1326164-4-honghuan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2026/09/24 18:55, Honglei Huang wrote:
> Add userptr blob objects so the guest kernel can pin an existing
> userspace mapping and advertise it as CREATE_BLOB backing entries.
> 
> - New virtio_gpu_object_userptr type for userptr resources
> - Pin pages with pin_user_pages_fast() and FOLL_LONGTERM
> - Omit FOLL_WRITE when VIRTGPU_BLOB_FLAG_USE_READONLY is set
> - Charge FOLL_LONGTERM pins against RLIMIT_MEMLOCK
> - DMA-map the scatterlist only when virtio_gpu_use_dma_api() is
>    required; use DMA_TO_DEVICE for USE_READONLY blobs
> - Mark writable pages dirty when unpinning
> - Keep pages pinned until RESOURCE_UNREF is queued; drop them from
>    cleanup_object() on the unref response or on create failure
> - Clear userptr->pages on pin failure to avoid double-free on cleanup
> - Reject unaligned or overflowing userptr ranges at create time
> - Disallow PRIME export of userptr objects
> - Save CREATE_BLOB params and restore userptr resources after
>    hibernation without using the shmem restore path
> 
> The hibernation restore path maps with the same attrs and direction
> used at create time, as documented next to the call. Like shmem
> blobs, the DMA API can still bounce through a buffer there. This
> design only avoids a second guest side shmem allocation and memcpy,
> nothing more.

I don't see the restore path is documented though this says "documented 
next to the call".

> 
> Signed-off-by: Honglei Huang <honghuan@amd.com>
> ---
>   drivers/gpu/drm/virtio/Makefile          |   3 +-
>   drivers/gpu/drm/virtio/virtgpu_drv.h     |  41 +++
>   drivers/gpu/drm/virtio/virtgpu_object.c  |  22 ++
>   drivers/gpu/drm/virtio/virtgpu_userptr.c | 348 +++++++++++++++++++++++
>   4 files changed, 413 insertions(+), 1 deletion(-)
>   create mode 100644 drivers/gpu/drm/virtio/virtgpu_userptr.c
> 
> diff --git a/drivers/gpu/drm/virtio/Makefile b/drivers/gpu/drm/virtio/Makefile
> index d2e1788a82..fe7332a621 100644
> --- a/drivers/gpu/drm/virtio/Makefile
> +++ b/drivers/gpu/drm/virtio/Makefile
> @@ -6,6 +6,7 @@
>   virtio-gpu-y := virtgpu_drv.o virtgpu_kms.o virtgpu_gem.o virtgpu_vram.o \
>   	virtgpu_display.o virtgpu_vq.o \
>   	virtgpu_fence.o virtgpu_object.o virtgpu_debugfs.o virtgpu_plane.o \
> -	virtgpu_ioctl.o virtgpu_prime.o virtgpu_trace_points.o virtgpu_submit.o
> +	virtgpu_ioctl.o virtgpu_prime.o virtgpu_trace_points.o virtgpu_submit.o \
> +	virtgpu_userptr.o
>   
>   obj-$(CONFIG_DRM_VIRTIO_GPU) += virtio-gpu.o
> diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/virtgpu_drv.h
> index 9df4c71173..b58e5afe8f 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_drv.h
> +++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
> @@ -105,6 +105,7 @@ struct virtio_gpu_object_params {
>   	uint32_t blob_flags;
>   	uint64_t blob_id;
>   	uint32_t blob_hints;
> +	uint64_t userptr;
>   };
>   
>   struct virtio_gpu_object {
> @@ -138,12 +139,41 @@ struct virtio_gpu_object_vram {
>   	struct drm_mm_node vram_node;
>   };
>   
> +struct virtio_gpu_object_userptr;
> +
> +struct virtio_gpu_object_userptr_ops {
> +	int (*get_pages)(struct virtio_gpu_object_userptr *userptr);
> +	void (*put_pages)(struct virtio_gpu_object_userptr *userptr);
> +};
> +
> +struct virtio_gpu_object_userptr {
> +	struct virtio_gpu_object base;
> +	const struct virtio_gpu_object_userptr_ops *ops;
> +	struct mutex lock;
> +
> +	uint64_t start;
> +	uint32_t npages;
> +	uint32_t bo_handle;
> +	uint32_t flags;
> +
> +	struct virtio_gpu_device *vgdev;
> +	struct drm_file *file;
> +	struct page **pages;
> +	struct sg_table *sgt;
> +	bool dma_mapped;
> +	enum dma_data_direction dma_dir;
> +	struct mm_struct *mm;
> +};
> +
>   #define to_virtio_gpu_shmem(virtio_gpu_object) \
>   	container_of((virtio_gpu_object), struct virtio_gpu_object_shmem, base)
>   
>   #define to_virtio_gpu_vram(virtio_gpu_object) \
>   	container_of((virtio_gpu_object), struct virtio_gpu_object_vram, base)
>   
> +#define to_virtio_gpu_userptr(virtio_gpu_object) \
> +	container_of((virtio_gpu_object), struct virtio_gpu_object_userptr, base)
> +
>   struct virtio_gpu_object_array {
>   	struct ww_acquire_ctx ticket;
>   	struct list_head next;
> @@ -284,6 +314,7 @@ struct virtio_gpu_device {
>   	bool has_host_visible;
>   	bool has_context_init;
>   	bool has_blob_alignment;
> +	bool has_blob_readonly;
>   	bool hibernated;
>   	struct virtio_shm_region host_visible_region;
>   	struct drm_mm host_visible_mm;
> @@ -562,4 +593,14 @@ void virtio_gpu_vram_map_deferred(struct virtio_gpu_object_vram *vram);
>   int virtio_gpu_execbuffer_ioctl(struct drm_device *dev, void *data,
>   				struct drm_file *file);
>   
> +/* virtgpu_userptr.c */
> +int virtio_gpu_userptr_create(struct virtio_gpu_device *vgdev,
> +			      struct drm_file *file,
> +			      struct virtio_gpu_object_params *params,
> +			      struct virtio_gpu_object **bo_ptr);
> +bool virtio_gpu_is_userptr(struct virtio_gpu_object *bo);
> +int virtio_gpu_userptr_restore(struct virtio_gpu_device *vgdev,
> +			       struct virtio_gpu_object *bo,
> +			       struct virtio_gpu_mem_entry **ents,
> +			       unsigned int *nents);
>   #endif
> diff --git a/drivers/gpu/drm/virtio/virtgpu_object.c b/drivers/gpu/drm/virtio/virtgpu_object.c
> index 49899485be..ab21494b1c 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_object.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_object.c
> @@ -91,6 +91,16 @@ void virtio_gpu_cleanup_object(struct virtio_gpu_object *bo)
>   		drm_gem_free_mmap_offset(&vram->base.base.base);
>   		drm_gem_object_release(&vram->base.base.base);
>   		kfree(vram);
> +	} else if (virtio_gpu_is_userptr(bo)) {
> +		struct virtio_gpu_object_userptr *userptr =
> +			to_virtio_gpu_userptr(bo);
> +
> +		mutex_lock(&userptr->lock);
> +		userptr->ops->put_pages(userptr);
> +		mutex_unlock(&userptr->lock);
> +		mutex_destroy(&userptr->lock);
> +		drm_gem_object_release(&userptr->base.base.base);
> +		kfree(userptr);
>   	} else {
>   		drm_gem_object_release(&bo->base.base);
>   		kfree(bo);
> @@ -316,6 +326,18 @@ int virtio_gpu_object_restore_all(struct virtio_gpu_device *vgdev)
>   			continue;
>   		}
>   
> +		if (virtio_gpu_is_userptr(bo)) {
> +			ret = virtio_gpu_userptr_restore(vgdev, bo, &ents,
> +							 &nents);
> +			if (ret)
> +				break;
> +
> +			virtio_gpu_cmd_resource_create_blob(vgdev, bo,
> +							    &bo->params,
> +							    ents, nents);
> +			continue;
> +		}
> +
>   		if (bo->params.blob || bo->attached) {
>   			ret = virtio_gpu_object_shmem_init(vgdev, bo, &ents,
>   							   &nents);
> diff --git a/drivers/gpu/drm/virtio/virtgpu_userptr.c b/drivers/gpu/drm/virtio/virtgpu_userptr.c
> new file mode 100644
> index 0000000000..4fb367d0d6
> --- /dev/null
> +++ b/drivers/gpu/drm/virtio/virtgpu_userptr.c
> @@ -0,0 +1,348 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <linux/dma-mapping.h>
> +#include <linux/limits.h>
> +#include <linux/mm.h>
> +#include <linux/overflow.h>
> +#include <linux/pid.h>
> +#include <linux/sched/mm.h>
> +#include <linux/sched/signal.h>
> +#include <linux/vmalloc.h>
> +
> +#include "virtgpu_drv.h"
> +#include <drm/drm_gem.h>
> +
> +static void virtio_gpu_userptr_free(struct drm_gem_object *obj)
> +{
> +	struct virtio_gpu_object *bo = gem_to_virtio_gpu_obj(obj);
> +	struct virtio_gpu_device *vgdev = obj->dev->dev_private;
> +
> +	/*
> +	 * Pages stay pinned until RESOURCE_UNREF finishes. Its callback
> +	 * calls virtio_gpu_cleanup_object to drop them.
> +	 */
> +	if (bo->created) {
> +		virtio_gpu_remove_from_restore_list(bo);
> +		virtio_gpu_cmd_unref_resource(vgdev, bo, false);
> +		virtio_gpu_notify(vgdev);
> +		return;
> +	}
> +
> +	virtio_gpu_cleanup_object(bo);
> +}
> +
> +static struct dma_buf *
> +virtio_gpu_userptr_prime_export(struct drm_gem_object *obj, int flags)
> +{
> +	return ERR_PTR(-EINVAL);
> +}
> +
> +static const struct drm_gem_object_funcs virtio_gpu_userptr_funcs = {
> +	.open = virtio_gpu_gem_object_open,
> +	.close = virtio_gpu_gem_object_close,
> +	.free = virtio_gpu_userptr_free,
> +	.export = virtio_gpu_userptr_prime_export,
> +};
> +
> +bool virtio_gpu_is_userptr(struct virtio_gpu_object *bo)
> +{
> +	return bo->base.base.funcs == &virtio_gpu_userptr_funcs;
> +}
> +
> +static int
> +virtio_gpu_userptr_get_pages(struct virtio_gpu_object_userptr *userptr)
> +{
> +	unsigned int flag = FOLL_LONGTERM;
> +	unsigned int num_pages, pinned = 0;
> +	int ret = 0;
> +
> +	if (userptr->pages)
> +		return 0;
> +
> +	userptr->pages = kvmalloc_array(userptr->npages, sizeof(struct page *),
> +					GFP_KERNEL);
> +	if (!userptr->pages)
> +		return -ENOMEM;
> +
> +	if (!(userptr->flags & VIRTGPU_BLOB_FLAG_USE_READONLY))
> +		flag |= FOLL_WRITE;
> +
> +	do {
> +		num_pages = userptr->npages - pinned;
> +
> +		ret = pin_user_pages_fast(userptr->start + pinned * PAGE_SIZE,
> +					  num_pages, flag,
> +					  userptr->pages + pinned);
> +
> +		if (ret < 0) {
> +			if (pinned)
> +				unpin_user_pages(userptr->pages, pinned);
> +			kvfree(userptr->pages);
> +			userptr->pages = NULL;
> +			return ret;
> +		}
> +
> +		pinned += ret;
> +
> +	} while (pinned < userptr->npages);
> +
> +	return 0;
> +}
> +
> +static void
> +virtio_gpu_userptr_unaccount(struct virtio_gpu_object_userptr *userptr)
> +{
> +	if (!userptr->mm)
> +		return;
> +
> +	atomic64_sub(userptr->npages, &userptr->mm->pinned_vm);
> +	mmdrop(userptr->mm);
> +	userptr->mm = NULL;
> +}
> +
> +static void
> +virtio_gpu_userptr_put_pages(struct virtio_gpu_object_userptr *userptr)
> +{
> +	struct drm_device *dev = userptr->base.base.base.dev;
> +
> +	if (userptr->sgt) {
> +		if (userptr->dma_mapped)
> +			dma_unmap_sgtable(drm_dev_dma_dev(dev), userptr->sgt,
> +					  userptr->dma_dir, 0);
> +		userptr->dma_mapped = false;
> +		sg_free_table(userptr->sgt);
> +		kfree(userptr->sgt);
> +		userptr->sgt = NULL;
> +	}
> +
> +	if (userptr->pages) {
> +		bool dirty = !(userptr->flags & VIRTGPU_BLOB_FLAG_USE_READONLY);
> +
> +		unpin_user_pages_dirty_lock(userptr->pages, userptr->npages,
> +					    dirty);
> +		kvfree(userptr->pages);
> +		userptr->pages = NULL;
> +	}
> +
> +	virtio_gpu_userptr_unaccount(userptr);
> +}
> +
> +static int
> +virtio_gpu_userptr_get_entries(struct virtio_gpu_device *vgdev,
> +			       struct virtio_gpu_object_userptr *userptr,
> +			       struct virtio_gpu_mem_entry **ents,
> +			       unsigned int *nents)
> +{
> +	bool use_dma_api = virtio_gpu_use_dma_api(vgdev->vdev);
> +	struct scatterlist *sg;
> +	unsigned int count;
> +	int si;
> +
> +	count = use_dma_api ? userptr->sgt->nents : userptr->sgt->orig_nents;
> +	if (!count)
> +		return -EINVAL;
> +
> +	*ents = kvmalloc_array(count, sizeof(**ents), GFP_KERNEL);
> +	if (!*ents)
> +		return -ENOMEM;
> +
> +	if (use_dma_api) {
> +		for_each_sgtable_dma_sg(userptr->sgt, sg, si) {
> +			(*ents)[si].addr = cpu_to_le64(sg_dma_address(sg));
> +			(*ents)[si].length = cpu_to_le32(sg_dma_len(sg));
> +			(*ents)[si].padding = 0;
> +		}
> +	} else {
> +		for_each_sgtable_sg(userptr->sgt, sg, si) {
> +			(*ents)[si].addr = cpu_to_le64(sg_phys(sg));
> +			(*ents)[si].length = cpu_to_le32(sg->length);
> +			(*ents)[si].padding = 0;
> +		}
> +	}
> +
> +	*nents = count;
> +	return 0;
> +}
> +
> +int virtio_gpu_userptr_restore(struct virtio_gpu_device *vgdev,
> +			       struct virtio_gpu_object *bo,
> +			       struct virtio_gpu_mem_entry **ents,
> +			       unsigned int *nents)
> +{
> +	struct virtio_gpu_object_userptr *userptr = to_virtio_gpu_userptr(bo);
> +	int ret;
> +
> +	mutex_lock(&userptr->lock);
> +	if (!userptr->sgt || !userptr->pages) {
> +		mutex_unlock(&userptr->lock);
> +		return -EINVAL;
> +	}
> +
> +	if (userptr->dma_mapped) {
> +		struct device *dev = drm_dev_dma_dev(vgdev->ddev);
> +
> +		dma_unmap_sgtable(dev, userptr->sgt, userptr->dma_dir, 0);
> +		userptr->dma_mapped = false;
> +
> +		ret = dma_map_sgtable(dev, userptr->sgt, userptr->dma_dir, 0);
> +		if (ret) {
> +			mutex_unlock(&userptr->lock);
> +			return ret;
> +		}
> +		userptr->dma_mapped = true;
> +	}
> +
> +	ret = virtio_gpu_userptr_get_entries(vgdev, userptr, ents, nents);
> +	mutex_unlock(&userptr->lock);
> +	return ret;
> +}
> +
> +static int
> +virtio_gpu_userptr_init(struct drm_device *dev, struct drm_file *file,
> +			struct virtio_gpu_object_userptr *userptr,
> +			struct virtio_gpu_object_params *params,
> +			const struct virtio_gpu_object_userptr_ops *ops)
> +{
> +	struct drm_gem_object *obj;
> +	int ret;
> +
> +	userptr->start = params->userptr;
> +	userptr->npages = params->size >> PAGE_SHIFT;
> +	userptr->flags = params->blob_flags;
> +
> +	mutex_init(&userptr->lock);
> +	userptr->vgdev = dev->dev_private;
> +	userptr->file = file;
> +	userptr->ops = ops;
> +
> +	/*
> +	 * Get the resource id before GEM init, so a failed call here
> +	 * just needs a plain kfree and no special id zero check in the
> +	 * shared resource_id_put helper.
> +	 */
> +	ret = virtio_gpu_resource_id_get(userptr->vgdev,
> +					 &userptr->base.hw_res_handle);
> +	if (ret) {
> +		mutex_destroy(&userptr->lock);
> +		return ret;
> +	}
> +
> +	obj = &userptr->base.base.base;
> +	obj->funcs = &virtio_gpu_userptr_funcs;
> +
> +	drm_gem_private_object_init(dev, obj, params->size);
> +	INIT_LIST_HEAD(&userptr->base.restore_node);
> +
> +	return 0;
> +}
> +
> +static const struct virtio_gpu_object_userptr_ops virtio_gpu_userptr_ops = {
> +	.get_pages = virtio_gpu_userptr_get_pages,
> +	.put_pages = virtio_gpu_userptr_put_pages,
> +};
> +
> +int virtio_gpu_userptr_create(struct virtio_gpu_device *vgdev,
> +			      struct drm_file *file,
> +			      struct virtio_gpu_object_params *params,
> +			      struct virtio_gpu_object **bo_ptr)
> +{
> +	struct virtio_gpu_object_userptr *userptr;
> +	struct virtio_gpu_mem_entry *ents = NULL;
> +	struct sg_table *sgt;
> +	struct mm_struct *mm;
> +	unsigned long lock_limit;
> +	unsigned long start;
> +	unsigned long end;
> +	s64 new_pinned;
> +	unsigned int nents;
> +	int ret;
> +
> +	*bo_ptr = NULL;
> +
> +	if (!params->size || !IS_ALIGNED(params->size, PAGE_SIZE) ||
> +	    params->userptr != (unsigned long)params->userptr)
> +		return -EINVAL;
> +
> +	start = params->userptr;
> +	if (!IS_ALIGNED(start, PAGE_SIZE) ||
> +	    check_add_overflow(start, (unsigned long)params->size, &end))
> +		return -EINVAL;
> +
> +	if (!can_do_mlock())
> +		return -EPERM;
> +
> +	if (params->size >> PAGE_SHIFT > INT_MAX)
> +		return -E2BIG;
> +
> +	if (!access_ok((void __user *)start, params->size))
> +		return -EFAULT;
> +
> +	userptr = kzalloc_obj(*userptr);
> +	if (!userptr)
> +		return -ENOMEM;
> +
> +	ret = virtio_gpu_userptr_init(vgdev->ddev, file, userptr, params,
> +				      &virtio_gpu_userptr_ops);
> +	if (ret) {
> +		kfree(userptr);
> +		return ret;
> +	}
> +
> +	mm = current->mm;
> +	mmgrab(mm);
> +	lock_limit = rlimit(RLIMIT_MEMLOCK) >> PAGE_SHIFT;
> +	new_pinned = atomic64_add_return(userptr->npages, &mm->pinned_vm);
> +	if (new_pinned < 0 ||
> +	    (new_pinned > lock_limit && !capable(CAP_IPC_LOCK))) {
> +		atomic64_sub(userptr->npages, &mm->pinned_vm);
> +		mmdrop(mm);
> +		ret = new_pinned < 0 ? -EOVERFLOW : -ENOMEM;
> +		goto err_cleanup;
> +	}
> +	userptr->mm = mm;
> +
> +	mutex_lock(&userptr->lock);
> +	ret = userptr->ops->get_pages(userptr);
> +	mutex_unlock(&userptr->lock);
> +	if (ret)
> +		goto err_cleanup;
> +
> +	sgt = drm_prime_pages_to_sg(vgdev->ddev, userptr->pages,
> +				    userptr->npages);
> +	if (IS_ERR(sgt)) {
> +		ret = PTR_ERR(sgt);
> +		goto err_cleanup;
> +	}
> +
> +	userptr->sgt = sgt;
> +
> +	if (virtio_gpu_use_dma_api(vgdev->vdev)) {
> +		enum dma_data_direction dir =
> +			(userptr->flags & VIRTGPU_BLOB_FLAG_USE_READONLY) ?
> +			DMA_TO_DEVICE : DMA_BIDIRECTIONAL;
> +
> +		ret = dma_map_sgtable(drm_dev_dma_dev(vgdev->ddev), sgt,
> +				      dir, 0);

I checked the ROCm code and documentation, and I do not see how this 
mapping satisfies the HIP coherence contract when bounce buffers or 
explicit DMA cache maintenance are required.

HIP distinguishes two coherence models:

 > Coarse-grained coherence: The memory is considered up-to-date only
 > after synchronization performed using hipDeviceSynchronize(),
 > hipStreamSynchronize(), or any blocking operation that acts on the
 > null stream such as hipMemcpy(). To avoid the cache from being
 > accessed by a part of the system while simultaneously being written by
 > another, the memory is made visible only after the caches have been
 > flushed.
 >
 > Fine-grained coherence: The memory is coherent even while being
 > modified by a part of the system. Fine-grained coherence ensures that
 > up-to-date data is visible to others regardless of kernel boundaries.
 > This can be useful if both host and device operate on the same data.

https://rocm.docs.amd.com/projects/HIP/en/docs-10.0.0/how-to/hip_runtime_api/memory_management/coherence_control.html

Fine-grained access requires coherence throughout execution; copying
between the original pages and a bounce buffer only at kernel boundaries
would not suffice. Coarse-grained access could support such copies, but
they must occur at the required synchronization points. I found no code
that synchronizes this DMA mapping at those points.

Regards,
Akihiko Odaki

> +		if (ret)
> +			goto err_cleanup;
> +
> +		userptr->dma_dir = dir;
> +		userptr->dma_mapped = true;
> +	}
> +
> +	ret = virtio_gpu_userptr_get_entries(vgdev, userptr, &ents, &nents);
> +	if (ret)
> +		goto err_cleanup;
> +
> +	virtio_gpu_cmd_resource_create_blob(vgdev, &userptr->base, params, ents,
> +					    nents);
> +
> +	userptr->base.params = *params;
> +	virtio_gpu_add_object_to_restore_list(vgdev, &userptr->base);
> +
> +	*bo_ptr = &userptr->base;
> +	return 0;
> +
> +err_cleanup:
> +	virtio_gpu_cleanup_object(&userptr->base);
> +	return ret;
> +}

