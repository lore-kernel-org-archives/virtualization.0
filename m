Received: from www3579.sakura.ne.jp (www3579.sakura.ne.jp [49.212.243.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF7B4973BF
	for <virtualization@lists.linux.dev>; Fri, 18 Sep 2026 12:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.212.243.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789733546; cv=none; b=WQAs68s2zWUKoXRdt3IV5tR0uK4oX8mFnocfLmi8ciuCYJacP/KH+mDp2iQKgZKLgXvUZqJotjtdQq75QU/nlKJn5Qh1zlmB3Lc7vnbgq8XAQ7o/Y2/RnWZW5dV+A/kqKupokfc/ha3PciWGrOq4MeNi+1wpnRT/0ZurhxY2bTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789733546; c=relaxed/simple;
	bh=TdiLMOTdn65x8zfrZgCJK+E9kr5MGZzQAPPBGunaXxM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZIVBKCP9iscIYR6p3l+wrurFTt1Lf7yBrB+HMiT01mu45b78DY4Le8L2mrdpA0KHD8o5NnGSVu7TPce6nfM4WExK0q8Cz4JM2luQVqnkCSOcgl3osPQiMJz3JcY5Tm/UFVa+3mxuE3xvPpOI8v2xmQs+EUjTfBddKHFdmb7/AbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rsg.ci.i.u-tokyo.ac.jp; spf=pass smtp.mailfrom=rsg.ci.i.u-tokyo.ac.jp; dkim=pass (2048-bit key) header.d=rsg.ci.i.u-tokyo.ac.jp header.i=@rsg.ci.i.u-tokyo.ac.jp header.b=gdwBrRdX; arc=none smtp.client-ip=49.212.243.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rsg.ci.i.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rsg.ci.i.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rsg.ci.i.u-tokyo.ac.jp header.i=@rsg.ci.i.u-tokyo.ac.jp header.b="gdwBrRdX"
Received: from [133.11.54.183] (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
	(authenticated bits=0)
	by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 68ICC4oI045599
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Fri, 18 Sep 2026 21:12:04 +0900 (JST)
	(envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=O45OBg23J/3oHx2lRf9Yr5ZgoFt2a7CrhzAaB/z4DUY=;
        c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
        h=From:Message-ID:To:Subject:Date;
        s=rs20250326; t=1789733524; v=1;
        b=gdwBrRdXb4kOUDph0TGZ2TULlcnxCtlxvATeO1mntbAb9m/6wPYiVGLYLBWWP4LM
         WwpYgHFOeU/zSWR+or1xdde0JQen1RkAIuq+qX23uT6mapPJEaPFqcHRxaBhZcEi
         NvrFRao73Y2JuIWMsauB1Z3KPJbBuAAGClMHCSwFhM5EqJUkgQpWbbryU1fOLjG2
         z8E2bTh0PkaH8ezj5DDAfulRVs7dyP80fRs1Uzz5E5bLy/llriPzWKjige03k6Iq
         klbMcYoITiKdAH1HS1rJxy1qBj6JknfUqoS9KXVqiDI9eOEF5sEsStseMtKOuLYe
         z6SK2nyXabwKywnYw9ZNpg==
Message-ID: <a08fc58b-c67a-4a96-a967-7280c8f9e965@rsg.ci.i.u-tokyo.ac.jp>
Date: Fri, 18 Sep 2026 21:12:03 +0900
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 2/4] drm/virtgpu api: add blob userptr resource
To: Honglei Huang <honghuan@amd.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        David Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Cc: Gurchetan Singh <gurchetansingh@chromium.org>,
        Chia-I Wu <olvaffe@gmail.com>, Ray Huang <Ray.Huang@amd.com>,
        dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20260918095940.2253018-1-honghuan@amd.com>
 <20260918095940.2253018-3-honghuan@amd.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260918095940.2253018-3-honghuan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2026/09/18 18:59, Honglei Huang wrote:
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
>   include/uapi/drm/virtgpu_drm.h  | 13 +++++++++++++
>   include/uapi/linux/virtio_gpu.h |  6 ++++++
>   2 files changed, 19 insertions(+)
> 
> diff --git a/include/uapi/drm/virtgpu_drm.h b/include/uapi/drm/virtgpu_drm.h
> index 95587e12ae..80f73b3276 100644
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
> @@ -186,6 +188,10 @@ struct drm_virtgpu_resource_create_blob {
>   #define VIRTGPU_BLOB_FLAG_USE_MAPPABLE     0x0001
>   #define VIRTGPU_BLOB_FLAG_USE_SHAREABLE    0x0002
>   #define VIRTGPU_BLOB_FLAG_USE_CROSS_DEVICE 0x0004
> +/* Wire flag: device MUST NOT write. Guest pins without FOLL_WRITE.
> + * Rejected unless VIRTGPU_PARAM_BLOB_READONLY is 1.
> + */

According to Documentation/process/coding-style.rst, the preferred style 
for long (multi-line) comments is:

	/*
	 * This is the preferred style for multi-line
	 * comments in the Linux kernel source code.
	 * Please use it consistently.
	 *
	 * Description:  A column of asterisks on the left side,
	 * with beginning and ending almost-blank lines.
	 */

So please avoid putting text on the same line as the opening /*.

Furthermore, because this is a UAPI header (defining the interface 
between userspace and the kernel, rather than the guest and the host), 
it should use terminology appropriate for userspace. Kernel-internal 
implementation details like FOLL_WRITE and terms like "guest" shouldn't 
be mentioned here.

That being said, I don't think this comment is necessary in the first 
place. Anyone who needs to know the exact behavior will look at the 
virtio specification. I recommend just dropping the comment entirely.

> +#define VIRTGPU_BLOB_FLAG_USE_READONLY     0x0008
>   	/* zero is invalid blob_mem */
>   	__u32 blob_mem;
>   	__u32 blob_flags;
> @@ -205,6 +211,13 @@ struct drm_virtgpu_resource_create_blob {
>   #define DRM_VIRTGPU_BLOB_FLAG_HINT_DEFER_MAPPING        0x0001
>   	__u32 blob_hints;
>   	__u32 pad2;
> +
> +	/*
> +	 * Guest VA to pin as blob backing. Non-zero selects the userptr
> +	 * path and is valid only with VIRTGPU_BLOB_MEM_GUEST. Must be 0
> +	 * otherwise. Probe VIRTGPU_PARAM_USERPTR before using this field.
> +	 */

This comment is useful since it discusses UAPI specifics. However, 
please avoid the term "Guest VA". Since guest userspace has no concept 
of a "host" or "PA" (physical address), simply saying "address" is 
sufficient and more concise.

Regards,
Akihiko Odaki

> +	__u64 userptr;
>   };
>   
>   #define VIRTGPU_CONTEXT_PARAM_CAPSET_ID       0x0001
> diff --git a/include/uapi/linux/virtio_gpu.h b/include/uapi/linux/virtio_gpu.h
> index 3d4dfadc9d..33f5332e59 100644
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
> @@ -415,6 +419,8 @@ struct virtio_gpu_resource_create_blob {
>   #define VIRTIO_GPU_BLOB_FLAG_USE_MAPPABLE     0x0001
>   #define VIRTIO_GPU_BLOB_FLAG_USE_SHAREABLE    0x0002
>   #define VIRTIO_GPU_BLOB_FLAG_USE_CROSS_DEVICE 0x0004
> +/* Device MUST NOT write. Driver may pin read-only guest pages. */
> +#define VIRTIO_GPU_BLOB_FLAG_USE_READONLY     0x0008
>   	/* zero is invalid blob mem */
>   	__le32 blob_mem;
>   	__le32 blob_flags;

