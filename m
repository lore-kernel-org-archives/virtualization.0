Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.11
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795785570;
	b=DdIWM6xtUvcw9MjRcc4fWSLTi2Hq+vG1mVviXOkTuIIz2R4CO2k7X8W0k4jf64zILDPH
	 GjxSXPCwu+nJ2pdnaIauta1NriBhIoGifI0/ImO7htAFk6Up0+llHh8SjWU2Nvux4fheK
	 Tu52A5KPST4779rRtnxyE4X0GYlL4HePlg6qO3qUi9VZGYsrnNZboQJwfCXWGOAAmK8zd
	 GQ56n/bweij81jBssR9mmx5LopnKDaMKlCp+D1dl3ZOK0MdUvOcZg6TKZMwWPNyXAAdgm
	 QClFD8EVDri8zkz5WWJGbbcD4FSkIBRyoLIUIsBBH4QlKcOLui6o7qlIGSB9SPFnARA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795785570;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ZohoMailClient;
	bh=SY2tTRtiqzTHvXGQ5QTsdsPt0UxHnzMGtbeuKwj2TvA=;
	b=CJOEBYReJ7KiyK3ejXa/1IC1ErnzRiIeY8eTRlgM+O0+hrrbUlTMky8mzsVdmK0vRlB7
	 7cOAA9yvMs1UuIjQ8cM3ylItNHBXgSkf9y2WOUjd5fQCarvQNvfjnCU/XtBUP5h7XxJle
	 Fm70n8BwYZDNPgLs+sbrOxZPCGSgcWtnj70kcmrRtHEnMTQjPlnZ/8pENyD45dP/0oKha
	 Nk/KTLlM7hsaZboy+vM8VcGiMfLT5DWWcorDB6ML35Nw4MXMF86qB7zhhuAnsBcteiAXv
	 lVXnUu0u+vDECNjlQyQPXQs0KVd86ETX5xNMtSKIYHu9syLx8OwwETEzv/RM5V0AsNQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=fjbmhK+G;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.11
Received: from sender6-op-o11.zoho.com (sender6-op-o11.zoho.com [165.173.180.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADD42606A31C
	for <virtualization@lists.linux.dev>; Fri, 27 Nov 2026 13:19:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ADD42606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=fjbmhK+G
ARC-Seal: i=1; a=rsa-sha256; t=1795785553; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=ExGPjq9IDnRlB6hWxXSGQX7ogKjPd23U9QB0EvvQKYI2wamK7QK8W7uDMaTyWkBaiBSvsUC0Rg25zqIklTzuCRmhy666D5dZHgfJDBw+T8K2eKtwg8tUsp2RYvKmuFnNbY5r3swJ5p2iq7nNgNaB1p3yFnrOAARLSQDeJCdF1Y4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1795785553; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=SY2tTRtiqzTHvXGQ5QTsdsPt0UxHnzMGtbeuKwj2TvA=; 
	b=N9pMmMqyqGSbC11VrwobCh0Ufuih+GCofny6P2f+NB29EO70v3+ZCkdif7phU75wi067sBAUJGaA+5bjYE2EFG63S15S6imY0OzavzhQp8/glPs/eyzNXC2N1TyYXqPZfcYgpIdhwXHy0eLMRmlWyn03qvGaEdJX//oxxk1nESw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
	dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: a=rsa-sha256; b=fjbmhK+GqS73MX/08cVjaAwQ7iL3tx9bfClgvoIpt47AfwApP5c9hSD79eOQULd+Wuamcm31HrgzZ6Nx2dIG6Yb5LvYIJxjENVRmCc6sBxvT9gX78UGb4NSuGSnMOf42U+co0QeWMIaBR2x59x5DJ8JmOGF7cdlt0Z44kvBVLZc=; c=relaxed/relaxed; s=zohomail; d=collabora.com; v=1; bh=SY2tTRtiqzTHvXGQ5QTsdsPt0UxHnzMGtbeuKwj2TvA=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1795785550255124.78204008607634;
	Fri, 27 Nov 2026 05:19:10 -0800 (PST)
Message-ID: <f90f752c-d9f8-4280-bed1-1059c075e42d@collabora.com>
Date: Fri, 27 Nov 2026 16:19:05 +0300
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
Subject: Re: [RFC PATCH v10 1/4] drm/virtio: add VIRTIO_GPU_CAPSET_ROCM
 capability
To: Honglei Huang <honghuan@amd.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 David Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Cc: Gurchetan Singh <gurchetansingh@chromium.org>,
 Chia-I Wu <olvaffe@gmail.com>, Ray Huang <Ray.Huang@amd.com>,
 dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20261106082625.812860-1-honghuan@amd.com>
 <20261106082625.812860-2-honghuan@amd.com>
Content-Language: en-US
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <20261106082625.812860-2-honghuan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

On 11/6/26 11:26, Honglei Huang wrote:
> Add a new GPU capability set VIRTIO_GPU_CAPSET_ROCM to support ROCm
> compute workloads in virtualized environments.
> 
> ROCm (Radeon Open Compute) is AMD's open-source software platform for
> GPU compute and HPC workloads.
> 
> ID 7 is already used by the OpenCL capset (VIRCL), and gfxstream's
> rutabaga_gfx has already claimed IDs 7-9 ahead of any spec or kernel
> header update, so ROCm uses ID 10 to avoid a further collision. A
> matching virtio-gpu specification change is in progress to register this
> assignment.
> 
> Also add the matching VIRTGPU_DRM_CAPSET_ROCM alias in virtgpu_drm.h for
> consistency with the other capability sets exposed through
> DRM_IOCTL_VIRTGPU_GET_CAPS.
> 
> Signed-off-by: Honglei Huang <honghuan@amd.com>
> ---
>   include/uapi/drm/virtgpu_drm.h  | 1 +
>   include/uapi/linux/virtio_gpu.h | 1 +
>   2 files changed, 2 insertions(+)
> 
> diff --git a/include/uapi/drm/virtgpu_drm.h b/include/uapi/drm/virtgpu_drm.h
> index 95587e12ae..9b886e9772 100644
> --- a/include/uapi/drm/virtgpu_drm.h
> +++ b/include/uapi/drm/virtgpu_drm.h
> @@ -170,6 +170,7 @@ struct drm_virtgpu_3d_wait {
>   #define VIRTGPU_DRM_CAPSET_VENUS 4
>   #define VIRTGPU_DRM_CAPSET_CROSS_DOMAIN 5
>   #define VIRTGPU_DRM_CAPSET_DRM 6
> +#define VIRTGPU_DRM_CAPSET_ROCM 10
>   struct drm_virtgpu_get_caps {
>   	__u32 cap_set_id;
>   	__u32 cap_set_ver;
> diff --git a/include/uapi/linux/virtio_gpu.h b/include/uapi/linux/virtio_gpu.h
> index 4f530d9005..e22049835e 100644
> --- a/include/uapi/linux/virtio_gpu.h
> +++ b/include/uapi/linux/virtio_gpu.h
> @@ -321,6 +321,7 @@ struct virtio_gpu_cmd_submit {
>   #define VIRTIO_GPU_CAPSET_VENUS 4
>   #define VIRTIO_GPU_CAPSET_CROSS_DOMAIN 5
>   #define VIRTIO_GPU_CAPSET_DRM 6
> +#define VIRTIO_GPU_CAPSET_ROCM 10
>   
>   /* VIRTIO_GPU_CMD_GET_CAPSET_INFO */
>   struct virtio_gpu_get_capset_info {

Could you please give a link to the spec change discussion? Please send 
it to virtio-comment ML if haven't been done yet.

-- 
Best regards,
Dmitry
