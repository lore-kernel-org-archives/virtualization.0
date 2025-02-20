Received: from sender3-pp-f112.zoho.com (sender3-pp-f112.zoho.com [136.143.184.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D7A61FDA7B
	for <virtualization@lists.linux.dev>; Thu, 20 Feb 2025 15:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.184.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740064907; cv=pass; b=VXw5bFKF9UREugQqFFKSK+q6oR14sFcCLTrOypSE6Gw/DsOkKJDpP0oYFAZv4jSKCIa3Hbtfw96FWxShICU2vsIwI2evaiEoO/GXayywD0xWE6qkkdrz/AI4C/h3fCN6ivToiPg3erR/NReQgoMA1Z+mrwHHBO2CFQyDHM6S75Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740064907; c=relaxed/simple;
	bh=nHBXACfzX6391NHnyhqYQwBQH4VtPhCVZQMqHaLVhqs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jaIvte+7nZ0Zh/Fn9Tu0GESVU5erz5aG0uq4i7VQzKp+q1Idzbpmrv7eRGBWks5v9xqow8zgzEi1bdicAUK2y6NR+BnELf+mM/ey3hbJSpjDLsTM6EY1KEjZySTetxcBCFyYqLlmfBqMz3KzBEZIK3LeupOGtgUE9tGybU0lfSA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b=QWfsTqOj; arc=pass smtp.client-ip=136.143.184.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b="QWfsTqOj"
ARC-Seal: i=1; a=rsa-sha256; t=1740064895; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=b6eWnL8SnQZwJPGNnruQlcP55f8QOqC+rIENqeLR2w+eKt+wiPvp/zBQrG2qeCSnfpSbAYhJX3jH/z0OdSMAo95Y3GD+f9pwzsqfsUd3riFTgKWc/mea59R5yDOqJzPEs7x/JaH6RbY5FYPY/TGt+HEMNmkR561Xl/JIORWwQOA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1740064895; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=7A3FoIwBwFPfA+8eZ4ZnKPiOE6iy2NmvLxqYGT0Imq8=; 
	b=BuGHiAuUfeUj9Y2o+nRKDB4GseOJEc5zIht89KoZ4z21LnGX+jNjg+PaGOzoUQNboitIRbxZqQi7dfxnAfzcI1g3x4dKzW+9+luTzdtX04YD4Hn2ZmCJFLQ8AG4SZSNGxDUOh0BtbDJmBj/qSHbEk3ZY5pb/iEHMHBNyhRgQ1j0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
	dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1740064895;
	s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=7A3FoIwBwFPfA+8eZ4ZnKPiOE6iy2NmvLxqYGT0Imq8=;
	b=QWfsTqOj/lVD3eEjMKuim5OcWPA5CvbcJ1IJXlhHC82b71An5Pf3ckC32KObEk3B
	GY9HBCcfQFbSoNUgJhpUOVRW/QaQo+oSctITHVceiXqCQSK49qWPMgxP0Ovm902+Gzz
	bsgV5uyW+X4tzeegQKApKGwQnkgBs6X7grO5550g=
Received: by mx.zohomail.com with SMTPS id 1740064892303168.8124420075735;
	Thu, 20 Feb 2025 07:21:32 -0800 (PST)
Message-ID: <90aed75a-f934-4cda-bda9-0c44f2902cfb@collabora.com>
Date: Thu, 20 Feb 2025 18:21:25 +0300
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v3 4/4] drm/virtio: add
 VIRTGPU_PARAM_HOST_SHM_PAGE_SIZE to params
To: Sergio Lopez <slp@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Daniel Verkamp <dverkamp@chromium.org>, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, David Airlie <airlied@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu
 <olvaffe@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Simona Vetter <simona@ffwll.ch>, Rob Clark <robdclark@gmail.com>,
 fnkl.kernel@gmail.com
Cc: virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org
References: <20250220-virtio-shm-page-size-v3-0-874fff6f3979@redhat.com>
 <20250220-virtio-shm-page-size-v3-4-874fff6f3979@redhat.com>
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Content-Language: en-US
In-Reply-To: <20250220-virtio-shm-page-size-v3-4-874fff6f3979@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

On 2/20/25 17:28, Sergio Lopez wrote:
> Add VIRTGPU_PARAM_HOST_SHM_PAGE_SIZE as a param that can be read with
> VIRTGPU_GETPARAM by userspace applications running in the guest to
> obtain the host's page size and find out the right alignment to be used
> in shared memory allocations.
> 
> Signed-off-by: Sergio Lopez <slp@redhat.com>
> ---
>  drivers/gpu/drm/virtio/virtgpu_ioctl.c | 5 +++++
>  include/uapi/drm/virtgpu_drm.h         | 1 +
>  2 files changed, 6 insertions(+)
> 
> diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> index c33c057365f85a2ace536f91655c903036827312..f112b862c2de4d021fb6a54a080f42ad75034227 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> @@ -117,6 +117,11 @@ static int virtio_gpu_getparam_ioctl(struct drm_device *dev, void *data,
>  	case VIRTGPU_PARAM_EXPLICIT_DEBUG_NAME:
>  		value = vgdev->has_context_init ? 1 : 0;
>  		break;
> +	case VIRTGPU_PARAM_HOST_SHM_PAGE_SIZE:
> +		if (!vgdev->has_host_visible)
> +			return -ENOENT;
> +		value = vgdev->host_visible_region.page_size;
> +		break;
>  	default:
>  		return -EINVAL;
>  	}
> diff --git a/include/uapi/drm/virtgpu_drm.h b/include/uapi/drm/virtgpu_drm.h
> index c2ce71987e9bb816d13a300679336cb756f1cbcf..72db6b3339e0dcaf550acbf5ac4381a6e5c2216d 100644
> --- a/include/uapi/drm/virtgpu_drm.h
> +++ b/include/uapi/drm/virtgpu_drm.h
> @@ -98,6 +98,7 @@ struct drm_virtgpu_execbuffer {
>  #define VIRTGPU_PARAM_CONTEXT_INIT 6 /* DRM_VIRTGPU_CONTEXT_INIT */
>  #define VIRTGPU_PARAM_SUPPORTED_CAPSET_IDs 7 /* Bitmask of supported capability set ids */
>  #define VIRTGPU_PARAM_EXPLICIT_DEBUG_NAME 8 /* Ability to set debug name from userspace */
> +#define VIRTGPU_PARAM_HOST_SHM_PAGE_SIZE 9 /* Host SHM page size, with format PAGE_SIZE >> 12 */
>  
>  struct drm_virtgpu_getparam {
>  	__u64 param;
> 

Reviewed-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>

-- 
Best regards,
Dmitry
