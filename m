Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.11
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795785613;
	b=FAe+KPiEPn0osbTlX2SKWnmK1zEie8oTdmwF1ieg+EmoRCvcB86wa8q7xY26bPFj82Fh
	 uY7y4M9uzLRP74UcyyKkKVGKZ/IVW48wdThXalWlXb8N8qiB2nwHzAWLfnTbR8cLqRe2o
	 xuvI1nrYykFsnMdi3eFcxDkj7M7ZzQsmiHh/sO46adJohgREcNzv7R7m4BUbJ8ZSu4/Dp
	 EPw5B4lD6aiGi9p9AA9KwdcmIwdqOsGmoLcQSENjoHbPdLnOSKLgVb190Odvmp68QxteS
	 cl2PgM+jb85Wnl1BrHbvDNWoCuVHc/0m8yWtwXpGYoYliDn2uH+nsuz1GILzg2DmHVQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795785613;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ZohoMailClient;
	bh=t3bmZhMlLLLChKiQYVURV/Tny2pVJcAegEMm5bEYllA=;
	b=DZHM82S+kHdfyX0Z6cJxbH0bWHEbKInogHj/gv2f8r36BGEfaTLOj3Ez+Y6n/g+7KM0v
	 VNTOGQc/is+qA97/UdrfcAL3wDCW/UxPmmJMdrYOBuFwnwQiLI+WkepndTpTvWIxo4A78
	 lV7wLClJM0eD0L2LduSJN4u0VbZQkA7p9tjiyGsm4/DUo0cwzy9o1Rd0k27Dw69PAb2Ow
	 KVsrf5GWGAV29FeuV+/rsZvZ26I/msinu8qazCUfvPSPorwq1N1EoKTePnegD/+prarM+
	 Uh4rNrhUF+dg+5A27b/dOaj1PcWG5ljz3xR7BXAr6SJJHnW3k5D2xkbrwJnvPbLjI5g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=IztbIJC3;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.11
Received: from sender5-op-o11.zoho.com (sender5-op-o11.zoho.com [165.173.182.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA7C606A31E
	for <virtualization@lists.linux.dev>; Fri, 27 Nov 2026 13:20:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4FA7C606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=IztbIJC3
ARC-Seal: i=1; a=rsa-sha256; t=1795785601; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=PZc+IvajhshC54TAHOFTMmDH2mve+1jfOAsQkwp1C/mRnWLYl+Ef10yP4o8fNhhDff8Ob+w2l0nX13lPkFmsFYttLCZqbC3WTsZetDDui1aMaeqiCFnQLy4/VM8FxGeTQUUj4Cbnm4DZi5a+6v4u/MR4TYRLxctV4CzpNh/ZmgA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1795785601; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=t3bmZhMlLLLChKiQYVURV/Tny2pVJcAegEMm5bEYllA=; 
	b=ICqQyiL2vq0cpK6WNAENZCQ+YBy2NXOZAVfGLbzrjwNr2o6svO/HKeYqVgQEVugno8+eh3JSmBJUXI18S80usLpG8fD3hEp7ptn6Osjc2xKiXczCKVNuvU3qrJcnHdVnwr6H7POjJ3x2DGrVp+qHiXqjJsCVKQ9HKnyDz0dwGQc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
	dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: a=rsa-sha256; b=IztbIJC3g4yrB4jKc/9Up1BLK/zgg6JzSywiNdLaBvhK8OuUHH7hDElgLGYtc7sVBA3zI3EFVeeiMZiZmOjmchaxJLXt4wE2EWlvdax/pqRXxCMSXhOS0M/rmgTly03NCHQLpeMgSKeAW3t4fixWZMIzMYxrbXvt1ax29XgnEyk=; c=relaxed/relaxed; s=zohomail; d=collabora.com; v=1; bh=t3bmZhMlLLLChKiQYVURV/Tny2pVJcAegEMm5bEYllA=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 17957855989751007.5771783185683;
	Fri, 27 Nov 2026 05:19:58 -0800 (PST)
Message-ID: <152ed8fa-c32f-4502-8852-c6a9c6f60872@collabora.com>
Date: Fri, 27 Nov 2026 16:19:54 +0300
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
Subject: Re: [RFC PATCH v10 2/4] drm/virtio: add userptr blob resource to the
 UAPI
To: Honglei Huang <honghuan@amd.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 David Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Cc: Gurchetan Singh <gurchetansingh@chromium.org>,
 Chia-I Wu <olvaffe@gmail.com>, Ray Huang <Ray.Huang@amd.com>,
 dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20261106082625.812860-1-honghuan@amd.com>
 <20261106082625.812860-3-honghuan@amd.com>
Content-Language: en-US
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <20261106082625.812860-3-honghuan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

On 11/6/26 11:26, Honglei Huang wrote:
> Add a userptr address field so userspace can request a blob backed
> by an existing process mapping. A non-zero userptr selects that
> path; probe VIRTGPU_PARAM_USERPTR before using the field.
> 
> GPU-readonly backing is requested with the virtio CREATE_BLOB wire
> flag VIRTIO_GPU_BLOB_FLAG_USE_READONLY (also
> VIRTGPU_BLOB_FLAG_USE_READONLY). The device MUST NOT write such a
> resource. The guest pins without FOLL_WRITE only when the device
> advertised VIRTIO_GPU_F_BLOB_READONLY (VIRTGPU_PARAM_BLOB_READONLY).
> 
> Signed-off-by: Honglei Huang <honghuan@amd.com>
> ---
>   include/uapi/drm/virtgpu_drm.h  | 10 ++++++++++
>   include/uapi/linux/virtio_gpu.h |  5 +++++
>   2 files changed, 15 insertions(+)
> 
> diff --git a/include/uapi/drm/virtgpu_drm.h b/include/uapi/drm/virtgpu_drm.h
> index 9b886e9772..c890c754d8 100644
> --- a/include/uapi/drm/virtgpu_drm.h
> +++ b/include/uapi/drm/virtgpu_drm.h
> @@ -99,6 +99,8 @@ struct drm_virtgpu_execbuffer {
>   #define VIRTGPU_PARAM_SUPPORTED_CAPSET_IDs 7 /* Bitmask of supported capability set ids */
>   #define VIRTGPU_PARAM_EXPLICIT_DEBUG_NAME 8 /* Ability to set debug name from userspace */
>   #define VIRTGPU_PARAM_BLOB_ALIGNMENT 9 /* Device alignment requirements for blobs */
> +#define VIRTGPU_PARAM_USERPTR 10 /* CREATE_BLOB userptr field is supported */
> +#define VIRTGPU_PARAM_BLOB_READONLY 11 /* VIRTGPU_BLOB_FLAG_USE_READONLY is honored */
>   
>   struct drm_virtgpu_getparam {
>   	__u64 param;
> @@ -187,6 +189,7 @@ struct drm_virtgpu_resource_create_blob {
>   #define VIRTGPU_BLOB_FLAG_USE_MAPPABLE     0x0001
>   #define VIRTGPU_BLOB_FLAG_USE_SHAREABLE    0x0002
>   #define VIRTGPU_BLOB_FLAG_USE_CROSS_DEVICE 0x0004
> +#define VIRTGPU_BLOB_FLAG_USE_READONLY     0x0008
>   	/* zero is invalid blob_mem */
>   	__u32 blob_mem;
>   	__u32 blob_flags;
> @@ -206,6 +209,13 @@ struct drm_virtgpu_resource_create_blob {
>   #define DRM_VIRTGPU_BLOB_FLAG_HINT_DEFER_MAPPING        0x0001
>   	__u32 blob_hints;
>   	__u32 pad2;
> +
> +	/*
> +	 * Non-zero selects the userptr path and is valid only with
> +	 * VIRTGPU_BLOB_MEM_GUEST. Must be 0 otherwise. Probe
> +	 * VIRTGPU_PARAM_USERPTR before using this field.
> +	 */
> +	__u64 userptr;
>   };
>   
>   #define VIRTGPU_CONTEXT_PARAM_CAPSET_ID       0x0001
> diff --git a/include/uapi/linux/virtio_gpu.h b/include/uapi/linux/virtio_gpu.h
> index e22049835e..af95374758 100644
> --- a/include/uapi/linux/virtio_gpu.h
> +++ b/include/uapi/linux/virtio_gpu.h
> @@ -72,6 +72,10 @@
>    * must be aligned to that value.
>    */
>   #define VIRTIO_GPU_F_BLOB_ALIGNMENT      5
> +/*
> + * VIRTIO_GPU_BLOB_FLAG_USE_READONLY
> + */
> +#define VIRTIO_GPU_F_BLOB_READONLY       6
>   
>   enum virtio_gpu_ctrl_type {
>   	VIRTIO_GPU_UNDEFINED = 0,
> @@ -415,6 +419,7 @@ struct virtio_gpu_resource_create_blob {
>   #define VIRTIO_GPU_BLOB_FLAG_USE_MAPPABLE     0x0001
>   #define VIRTIO_GPU_BLOB_FLAG_USE_SHAREABLE    0x0002
>   #define VIRTIO_GPU_BLOB_FLAG_USE_CROSS_DEVICE 0x0004
> +#define VIRTIO_GPU_BLOB_FLAG_USE_READONLY     0x0008
>   	/* zero is invalid blob mem */
>   	__le32 blob_mem;
>   	__le32 blob_flags;

Reviewed-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>

-- 
Best regards,
Dmitry
