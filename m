Received: from www3579.sakura.ne.jp (www3579.sakura.ne.jp [49.212.243.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F98C3DB964
	for <virtualization@lists.linux.dev>; Sat, 19 Sep 2026 09:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.212.243.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789808407; cv=none; b=W1NYtXVhkbNNpc8NN9qZJH/YqP2pkBuRQsKFtXIKcpxXH7hfkh76Rd+sk31+MCZPYvYEtbQGxZB//i6rYNUjmkTG+WwJqyb4QqdLabGEra34YCj9pcShcQKNQ6i4be91nv8p677GAHFbjbEvsNpK0cJ0tVVDLPQu0zylCw2QaqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789808407; c=relaxed/simple;
	bh=tKd5K49rwX7FayXfxGLPw8XUVJvnxU/qyBaybF8KVr4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Uo38m8O4lpDgMs2IUVATjsr68L1pOdMqnvXHlC+yFur0Js++5t2inmOnOMAs17rAiNNqccPJD1zWHxNAM2uD4DiI4C+YRY23pVTEG5WUJwHQFcEQFnz+TVCpcy1PjGm63VdZgwXx6LivI3HvLPKuZBdvhD5hFH++g6lzrVWLHM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rsg.ci.i.u-tokyo.ac.jp; spf=pass smtp.mailfrom=rsg.ci.i.u-tokyo.ac.jp; dkim=pass (2048-bit key) header.d=rsg.ci.i.u-tokyo.ac.jp header.i=@rsg.ci.i.u-tokyo.ac.jp header.b=A4Sd6wmO; arc=none smtp.client-ip=49.212.243.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rsg.ci.i.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rsg.ci.i.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rsg.ci.i.u-tokyo.ac.jp header.i=@rsg.ci.i.u-tokyo.ac.jp header.b="A4Sd6wmO"
Received: from [133.11.54.183] (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
	(authenticated bits=0)
	by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 68J8xhTb003017
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Sat, 19 Sep 2026 17:59:43 +0900 (JST)
	(envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=ZjDNyoXTugMbT1WGTAGCHeUGgyeXfuKYMY7FdVMbLLo=;
        c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
        h=From:Message-ID:To:Subject:Date;
        s=rs20250326; t=1789808383; v=1;
        b=A4Sd6wmOX5Fud11Z3dN2bFVARlOhV+zIlbsUEWz86DwP556XtkL7j4EnPEL4q0uk
         wNRhGnbyNdMyxUXtlLFvFp3yHDuVtJilGsNETEg6P5r/tZMiq+Fe309ux00nx9u3
         LHKRK1R5w29DMElzdVA0W0S1HfgjdrU8T+KKYEotUff6x4+rHc2ioOWX488QzwbS
         LnrI5qeBLj8oRrBFCyZ3tqU/sGk6ODoCRvlRAXUsnju+CuwbWM9zdbxUUx7luv0i
         Sg2mAtWTXJZAr33H8z8F/C1+4hzW6H9RP06qXH0j8gDPPuZBUP8Ax/a5krRjhdQN
         2Qp/rxUda0g0tpesVp8ELQ==
Message-ID: <30ce57b1-21ab-4fb3-9e6c-75d061807b17@rsg.ci.i.u-tokyo.ac.jp>
Date: Sat, 19 Sep 2026 17:59:42 +0900
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 3/4] drm/virtio: implement userptr support for
 zero-copy memory access
To: Honglei Huang <honghuan@amd.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        David Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Cc: Gurchetan Singh <gurchetansingh@chromium.org>,
        Chia-I Wu <olvaffe@gmail.com>, Ray Huang <Ray.Huang@amd.com>,
        dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20260918095940.2253018-1-honghuan@amd.com>
 <20260918095940.2253018-4-honghuan@amd.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260918095940.2253018-4-honghuan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2026/09/18 18:59, Honglei Huang wrote:
> Add userptr blob objects so the guest kernel can pin an existing
> userspace mapping and advertise it as CREATE_BLOB backing entries.
> 
> - New virtio_gpu_object_userptr type for userptr resources
> - Pin pages with pin_user_pages_fast() and FOLL_LONGTERM
> - Omit FOLL_WRITE when VIRTGPU_BLOB_FLAG_USE_READONLY is set
> - Charge FOLL_LONGTERM pins against RLIMIT_MEMLOCK
> - DMA-map the scatterlist only when virtio_gpu_use_dma_api() is
>    required; use DMA_TO_DEVICE for USE_READONLY blobs
> - Sync userptr SG for the device on TRANSFER_TO_HOST
> - Mark writable pages dirty when unpinning
> - Keep pages pinned until RESOURCE_UNREF is queued; drop them from
>    cleanup_object() on the unref response or on create failure
> - Clear userptr->pages on pin failure to avoid double-free on cleanup
> - Reject unaligned or overflowing userptr ranges at create time
> - Disallow PRIME export of userptr objects
> - Save CREATE_BLOB params and restore userptr resources after
>    hibernation without using the shmem restore path
> 
> Signed-off-by: Honglei Huang <honghuan@amd.com>
> ---
>   drivers/gpu/drm/virtio/Makefile          |   3 +-
>   drivers/gpu/drm/virtio/virtgpu_drv.h     |  43 +++
>   drivers/gpu/drm/virtio/virtgpu_object.c  |  22 ++
>   drivers/gpu/drm/virtio/virtgpu_userptr.c | 365 +++++++++++++++++++++++
>   drivers/gpu/drm/virtio/virtgpu_vq.c      |  33 +-
>   5 files changed, 456 insertions(+), 10 deletions(-)
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
> index 9df4c71173..e0941cc187 100644
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
> @@ -138,12 +139,42 @@ struct virtio_gpu_object_vram {
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
> +	/* Protects pages and sgt. */
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
> @@ -284,6 +315,7 @@ struct virtio_gpu_device {
>   	bool has_host_visible;
>   	bool has_context_init;
>   	bool has_blob_alignment;
> +	bool has_blob_readonly;
>   	bool hibernated;
>   	struct virtio_shm_region host_visible_region;
>   	struct drm_mm host_visible_mm;
> @@ -562,4 +594,15 @@ void virtio_gpu_vram_map_deferred(struct virtio_gpu_object_vram *vram);
>   int virtio_gpu_execbuffer_ioctl(struct drm_device *dev, void *data,
>   				struct drm_file *file);
>   
> +/* virtgpu_userptr.c */
> +int virtio_gpu_userptr_create(struct virtio_gpu_device *vgdev,
> +			      struct drm_file *file,
> +			      struct virtio_gpu_object_params *params,
> +			      struct virtio_gpu_object **bo_ptr);
> +bool virtio_gpu_is_userptr(struct virtio_gpu_object *bo);
> +void virtio_gpu_userptr_dma_sync_for_device(struct virtio_gpu_object *bo);
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
> index 0000000000..ccfd96844e
> --- /dev/null
> +++ b/drivers/gpu/drm/virtio/virtgpu_userptr.c
> @@ -0,0 +1,365 @@
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
> +	 * Keep pages pinned until RESOURCE_UNREF completes. The response
> +	 * callback calls virtio_gpu_cleanup_object(), which drops them.
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
> +void virtio_gpu_userptr_dma_sync_for_device(struct virtio_gpu_object *bo)
> +{
> +	struct virtio_gpu_object_userptr *userptr = to_virtio_gpu_userptr(bo);
> +	struct device *dev;
> +
> +	if (!userptr->dma_mapped)
> +		return;
> +
> +	dev = drm_dev_dma_dev(userptr->base.base.base.dev);
> +	dma_sync_sgtable_for_device(dev, userptr->sgt, DMA_TO_DEVICE);
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
> +		ret = dma_map_sgtable(dev, userptr->sgt, userptr->dma_dir, 0);

This maps with attributes 0, allowing bounce buffers instead of
"zero-copy memory access". It is also unclear what coherence guarantee 
the UAPI is intended to provide.

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
> +	 * Allocate the resource id before GEM init so a failure here can
> +	 * unwind with a plain kfree and does not need a special id=0 guard
> +	 * in the shared resource_id_put helper.
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
> +	/*
> +	 * Match shmem blobs: only DMA-map when the virtio DMA API is in
> +	 * use. Mapping unconditionally can create SWIOTLB bounce buffers
> +	 * that get copied back over guest pages on unmap even though the
> +	 * host was given sg_phys() addresses.
> +	 */
> +	if (virtio_gpu_use_dma_api(vgdev->vdev)) {
> +		enum dma_data_direction dir =
> +			(userptr->flags & VIRTGPU_BLOB_FLAG_USE_READONLY) ?
> +			DMA_TO_DEVICE : DMA_BIDIRECTIONAL;
> +
> +		ret = dma_map_sgtable(drm_dev_dma_dev(vgdev->ddev), sgt,
> +				      dir, 0);
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
> diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio/virtgpu_vq.c
> index c02c03c10d..dcbd7bb7a6 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_vq.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
> @@ -781,9 +781,14 @@ int virtio_gpu_panic_cmd_transfer_to_host_2d(struct virtio_gpu_device *vgdev,
>   	struct virtio_gpu_vbuffer *vbuf;
>   	bool use_dma_api = virtio_gpu_use_dma_api(vgdev->vdev);
>   
> -	if (virtio_gpu_is_shmem(bo) && use_dma_api)
> -		dma_sync_sgtable_for_device(vgdev->vdev->dev.parent,
> -					    bo->base.sgt, DMA_TO_DEVICE);
> +	if (use_dma_api) {
> +		if (virtio_gpu_is_shmem(bo))
> +			dma_sync_sgtable_for_device(vgdev->vdev->dev.parent,
> +						    bo->base.sgt,
> +						    DMA_TO_DEVICE);
> +		else if (virtio_gpu_is_userptr(bo))
> +			virtio_gpu_userptr_dma_sync_for_device(bo);
> +	}
>   
>   	cmd_p = virtio_gpu_panic_alloc_cmd_resp(vgdev, &vbuf, sizeof(*cmd_p));
>   	memset(cmd_p, 0, sizeof(*cmd_p));
> @@ -812,9 +817,14 @@ void virtio_gpu_cmd_transfer_to_host_2d(struct virtio_gpu_device *vgdev,
>   	struct virtio_gpu_vbuffer *vbuf;
>   	bool use_dma_api = virtio_gpu_use_dma_api(vgdev->vdev);
>   
> -	if (virtio_gpu_is_shmem(bo) && use_dma_api)
> -		dma_sync_sgtable_for_device(vgdev->vdev->dev.parent,
> -					    bo->base.sgt, DMA_TO_DEVICE);
> +	if (use_dma_api) {
> +		if (virtio_gpu_is_shmem(bo))
> +			dma_sync_sgtable_for_device(vgdev->vdev->dev.parent,
> +						    bo->base.sgt,
> +						    DMA_TO_DEVICE);
> +		else if (virtio_gpu_is_userptr(bo))
> +			virtio_gpu_userptr_dma_sync_for_device(bo);
> +	}
>   
>   	cmd_p = virtio_gpu_alloc_cmd(vgdev, &vbuf, sizeof(*cmd_p));
>   	memset(cmd_p, 0, sizeof(*cmd_p));
> @@ -1245,9 +1255,14 @@ void virtio_gpu_cmd_transfer_to_host_3d(struct virtio_gpu_device *vgdev,
>   	struct virtio_gpu_vbuffer *vbuf;
>   	bool use_dma_api = virtio_gpu_use_dma_api(vgdev->vdev);
>   
> -	if (virtio_gpu_is_shmem(bo) && use_dma_api)
> -		dma_sync_sgtable_for_device(vgdev->vdev->dev.parent,
> -					    bo->base.sgt, DMA_TO_DEVICE);
> +	if (use_dma_api) {
> +		if (virtio_gpu_is_shmem(bo))
> +			dma_sync_sgtable_for_device(vgdev->vdev->dev.parent,
> +						    bo->base.sgt,
> +						    DMA_TO_DEVICE);
> +		else if (virtio_gpu_is_userptr(bo))
> +			virtio_gpu_userptr_dma_sync_for_device(bo);

This code is ineffective since the transfer ioctl rejects 
VIRTGPU_BLOB_MEM_GUEST.

Regards,
Akihiko Odaki
