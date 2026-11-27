Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.11
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795787165;
	b=HBbYvW13oGyFsmkedGupjSlPZxplGuezPS8mTjIAkV6zRLvFNvLfsJcqQwM1ALZ92lJC
	 bQlYJVDLY1QgIJhhHfgzmfiHYROJK08JjW9tI8MruEK1h4Di/lUclu4jd5ZDjHiQpxui+
	 ufOzattTQCqvt4a2uXIYd/Ro6b0/0q4faj8NyJp6vJ8UiyFDKlSEn9sbKiTAhmePiNU2t
	 SD0+mgcObYxQwZJ/n5wymeOPwEYqevkWH3XJT/Men0VTKe0JfJzuOzg1bKj/6PegSx0Hq
	 pq60PMYIMIaXClABTN/Xlr41PvRKAWjsz/ep1fHzLz709ttksUNFPdOToroohso0Ulg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795787165;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ZohoMailClient;
	bh=728jjslXS0U7w2RI+WsoqD5/WFmEi0hGQnc/ijojtm0=;
	b=1PhMTz82IsDVyz8gFq3Y1atEPzWQLPeW0ZmC9dFE0sl5hOBtc+VX9vqCnYbqYWzSv/+T
	 b6H5Wfc49L/5AfVW90nWMxDqxzPKv0XXxExvghWNk5FfjUPHysVSi5NEkvAmwrONwNrbu
	 V92GTXlyAhfBWRhz0yTZAawBbYQdJkj1gLg4Izvn4YpLL319tFu7ny/xfRwBJe7XUj3to
	 FNpoT/R/LggRfKcaM1CH9W390CI6pEW9APNHj0J53CPfpybzJ5ZRLfYUV0zzcsZJiH6q6
	 /WyVhSNsZvLd6hI9K6dQM+NRnFNbwWDAKbMvUNi5YfTaqz39LGxk3im0XfR+ogltuEw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=Bx4HZ2OY;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.11
Received: from sender5-op-o11.zoho.com (sender5-op-o11.zoho.com [165.173.182.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF1BD606A31C
	for <virtualization@lists.linux.dev>; Fri, 27 Nov 2026 13:46:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CF1BD606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=Bx4HZ2OY
ARC-Seal: i=1; a=rsa-sha256; t=1795787153; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Rz7jq2XyYtiirDzCgkWNKZ0z6e5uFBUJEhJWLrEDSE6BdnKGnSC8DxzG0zD2s7d/aRWWquhxr+SBkJFcKqf4QRT0k3yTLshGwm34mRK7nZ7Nyhx5j4kWIElpv4r4l5TWb6/zKtS08jdpDBWhyhPbisgjO3dAMrXxUBFUu4+kJc4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1795787153; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=728jjslXS0U7w2RI+WsoqD5/WFmEi0hGQnc/ijojtm0=; 
	b=U7aGuVBX55zKRKzOxNO5hlqwS0xMYbVNGiwVFgbE+BFbVDRvKkgyt+EqRxLNCrHR/7/idyo9LQWkv+/Y7hkaMLEXjJKw+qLO/aCPrroXeR6RA9Xh+Vq49wSi+NEzsIXWsQnVN/GelMR2Df8bUSYUzQnnBK0Wxfp61jCplrK0n4U=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
	dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: a=rsa-sha256; b=Bx4HZ2OYBQsjyz4NfuTWQucwu4jqizIVM7JfRZjn0cVqLM1BUy5CFlmxzxszlh7KWaK39uvYlor9Jvd5s/okwYYcA4Ew+aczWrmFFfGZsM8vPuK/oJqJswrRLxDzfYPXKAK75lRsEzm7Iv8DHSprsLRqvBVgFOPQ272NLUhr8QY=; c=relaxed/relaxed; s=zohomail; d=collabora.com; v=1; bh=728jjslXS0U7w2RI+WsoqD5/WFmEi0hGQnc/ijojtm0=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1795787151838696.5437119289173;
	Fri, 27 Nov 2026 05:45:51 -0800 (PST)
Message-ID: <8680b1cf-b997-40c9-a789-b9e8566c93ec@collabora.com>
Date: Fri, 27 Nov 2026 16:45:46 +0300
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v10 3/4] drm/virtio: implement userptr resource
 support
To: Honglei Huang <honghuan@amd.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 David Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Cc: Gurchetan Singh <gurchetansingh@chromium.org>,
 Chia-I Wu <olvaffe@gmail.com>, Ray Huang <Ray.Huang@amd.com>,
 dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20261106082625.812860-1-honghuan@amd.com>
 <20261106082625.812860-4-honghuan@amd.com>
Content-Language: en-US
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <20261106082625.812860-4-honghuan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

On 11/6/26 11:26, Honglei Huang wrote:
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
> Map with DMA_ATTR_REQUIRE_COHERENT at create time, on hibernation
> restore, and on unmap.
> 
> Signed-off-by: Honglei Huang <honghuan@amd.com>
> ---
>   drivers/gpu/drm/virtio/Makefile          |   3 +-
>   drivers/gpu/drm/virtio/virtgpu_drv.h     |  42 +++
>   drivers/gpu/drm/virtio/virtgpu_object.c  |  22 ++
>   drivers/gpu/drm/virtio/virtgpu_userptr.c | 350 +++++++++++++++++++++++
>   4 files changed, 416 insertions(+), 1 deletion(-)
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
> index 9df4c71173..a29429b415 100644
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
> +	/* Protects @pages, @sgt and @dma_mapped. */
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
> @@ -562,4 +594,14 @@ void virtio_gpu_vram_map_deferred(struct virtio_gpu_object_vram *vram);
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
> index 0000000000..b860693255
> --- /dev/null
> +++ b/drivers/gpu/drm/virtio/virtgpu_userptr.c
> @@ -0,0 +1,350 @@
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
> +					  userptr->dma_dir,
> +					  DMA_ATTR_REQUIRE_COHERENT);
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
> +		dma_unmap_sgtable(dev, userptr->sgt, userptr->dma_dir,
> +				  DMA_ATTR_REQUIRE_COHERENT);
> +		userptr->dma_mapped = false;
> +
> +		ret = dma_map_sgtable(dev, userptr->sgt, userptr->dma_dir,
> +				      DMA_ATTR_REQUIRE_COHERENT);
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
> +	if (new_pinned > lock_limit && !capable(CAP_IPC_LOCK)) {
> +		atomic64_sub(userptr->npages, &mm->pinned_vm);
> +		mmdrop(mm);
> +		ret = -ENOMEM;
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
> +				      dir, DMA_ATTR_REQUIRE_COHERENT);
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

Reviewed-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Tested-by: Dmitry Osipenko <dmitry.osipenko@collabora.com> # rocm + 
userptr BO hibernation restore

-- 
Best regards,
Dmitry
