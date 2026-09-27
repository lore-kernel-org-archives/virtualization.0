Received: from www3579.sakura.ne.jp (www3579.sakura.ne.jp [49.212.243.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 496C21E9B37
	for <virtualization@lists.linux.dev>; Sun, 27 Sep 2026 01:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.212.243.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790471079; cv=none; b=Tk8URhocdHMA/jrBDqdoWpygkWVHhGd1m9hpuSvTZVOPbmHwsfknIcpHmwQdvPp4e69rwklFum6qvVwbePAp6XTDTeyjOWS43ZaWViPi4RzKwFzSbA2pC6vz1/jJMtAvP3Vmbeh9hT+mShAXfNjNGiRhs2iEBPhrOt/lFJYfeM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790471079; c=relaxed/simple;
	bh=vyonlww27nd+448wt9qP8foNfWYDEX6H7rEhX/94mF0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hkGUzAX83EvRBq8MIY53+y66l6uR1pxcZOqnbGt0jsOb7ZVFYYPLo2ysiHObEaW7zQyiusI2bZqdZiDtGIXu/wJPIuuJ9zhv6hAeIwih76hteGAjlrs+zXL+Z0qHg89wuowM7zrxe8wFLQC0lihINuwBYdPSDwSO9eRMFAjhR60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rsg.ci.i.u-tokyo.ac.jp; spf=pass smtp.mailfrom=rsg.ci.i.u-tokyo.ac.jp; dkim=pass (2048-bit key) header.d=rsg.ci.i.u-tokyo.ac.jp header.i=@rsg.ci.i.u-tokyo.ac.jp header.b=YEOIrGIT; arc=none smtp.client-ip=49.212.243.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rsg.ci.i.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rsg.ci.i.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rsg.ci.i.u-tokyo.ac.jp header.i=@rsg.ci.i.u-tokyo.ac.jp header.b="YEOIrGIT"
Received: from [192.168.10.153] (p865013-ipoe.ipoe.ocn.ne.jp [153.242.222.12])
	(authenticated bits=0)
	by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 68R14B7G059851
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Sun, 27 Sep 2026 10:04:11 +0900 (JST)
	(envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=j9w0REUefCOyn/q9h5nw6t2GYkHFhe/4JUNcRaBJ3ls=;
        c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
        h=From:Message-ID:To:Subject:Date;
        s=rs20250326; t=1790471051; v=1;
        b=YEOIrGITN814dVoh8ELZYeibUAW/GbzKPm4z47VTZqNMlKKiY95jCfzAzE+q7hF8
         iJwqg53LOLXUgElRtk1Vumhe9pq+Umaxlq//Xb/IaLz2f71i02FNAXu4NB4Xg5K1
         quJ4ik9W6q518wDvbSX69acii7WdEVtW4rxpD3MSaTLBFqFLJmFSNMjzR9qEjKOm
         GcH/dn5Uv4hHxCK70uGgOI8MyzvapSNEqr8IDmbvM/REtL9wIcbgMHRM7Y0jegBR
         TcSBLbesnW/n4Fa7pmijBu3CqQxVgxkJ68JADrR9xfsFjzhVWmJGWwhxG1fsNvay
         SahpQXVZnbMdM+gCqtn3Ag==
Message-ID: <88d78717-d935-4c7f-a123-c6ddff761e97@rsg.ci.i.u-tokyo.ac.jp>
Date: Sun, 27 Sep 2026 10:04:10 +0900
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v9 4/4] drm/virtio: wire blob ioctl creation to
 userptr objects
To: Honglei Huang <honghuan@amd.com>, dmitry.osipenko@collabora.com,
        airlied@redhat.com, kraxel@redhat.com
Cc: gurchetansingh@chromium.org, olvaffe@gmail.com, Ray.Huang@amd.com,
        dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20260924095556.1326164-1-honghuan@amd.com>
 <20260924095556.1326164-5-honghuan@amd.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260924095556.1326164-5-honghuan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2026/09/24 18:55, Honglei Huang wrote:
> Integrate userptr into the blob resource creation ioctl.
> 
> - A non-zero userptr selects virtio_gpu_userptr_create()
> - Reject userptr unless blob_mem is VIRTGPU_BLOB_MEM_GUEST
> - Reject VIRTGPU_BLOB_FLAG_USE_READONLY unless the device
>    advertised VIRTIO_GPU_F_BLOB_READONLY
> - Advertise VIRTGPU_PARAM_USERPTR and VIRTGPU_PARAM_BLOB_READONLY
> - Add VIRTIO_GPU_F_BLOB_READONLY to the driver's features[] array
> 
> virtio_has_feature() routes device-specific feature bits through
> virtio_check_driver_offered_feature(), which calls BUG() when the
> driver queries a bit it never declared in features[]. The
> VIRTIO_GPU_F_BLOB_READONLY probe added to virtio_gpu_init() hit
> exactly that: every probe crashed regardless of host support because
> the bit was missing from features[]. Registering it there fixes the
> crash.
> 
> Signed-off-by: Honglei Huang <honghuan@amd.com>
> ---
>   drivers/gpu/drm/virtio/virtgpu_debugfs.c |  1 +
>   drivers/gpu/drm/virtio/virtgpu_drv.c     |  1 +
>   drivers/gpu/drm/virtio/virtgpu_ioctl.c   | 35 ++++++++++++++++++++----
>   drivers/gpu/drm/virtio/virtgpu_kms.c     |  8 ++++--
>   4 files changed, 38 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/virtio/virtgpu_debugfs.c b/drivers/gpu/drm/virtio/virtgpu_debugfs.c
> index 3a68a16b58..b8b9b40584 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_debugfs.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_debugfs.c
> @@ -55,6 +55,7 @@ static int virtio_gpu_features(struct seq_file *m, void *data)
>   			    vgdev->has_resource_assign_uuid);
>   
>   	virtio_gpu_add_bool(m, "blob resources", vgdev->has_resource_blob);
> +	virtio_gpu_add_bool(m, "blob readonly", vgdev->has_blob_readonly);
>   	virtio_gpu_add_bool(m, "context init", vgdev->has_context_init);
>   	virtio_gpu_add_int(m, "cap sets", vgdev->num_capsets);
>   	virtio_gpu_add_int(m, "scanouts", vgdev->num_scanouts);
> diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.c b/drivers/gpu/drm/virtio/virtgpu_drv.c
> index 2aaa7cb080..f1edd20c37 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_drv.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_drv.c
> @@ -182,6 +182,7 @@ static unsigned int features[] = {
>   	VIRTIO_GPU_F_RESOURCE_BLOB,
>   	VIRTIO_GPU_F_CONTEXT_INIT,
>   	VIRTIO_GPU_F_BLOB_ALIGNMENT,
> +	VIRTIO_GPU_F_BLOB_READONLY,
>   };
>   
>   #ifdef CONFIG_PM_SLEEP
> diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> index 3d8e4ccdb7..3dc058e50e 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> @@ -36,7 +36,10 @@
>   
>   #define VIRTGPU_BLOB_FLAG_USE_MASK (VIRTGPU_BLOB_FLAG_USE_MAPPABLE | \
>   				    VIRTGPU_BLOB_FLAG_USE_SHAREABLE | \
> -				    VIRTGPU_BLOB_FLAG_USE_CROSS_DEVICE)
> +				    VIRTGPU_BLOB_FLAG_USE_CROSS_DEVICE | \
> +				    VIRTGPU_BLOB_FLAG_USE_READONLY)
> +
> +#define VIRTGPU_BLOB_HINT_MASK DRM_VIRTGPU_BLOB_FLAG_HINT_DEFER_MAPPING
>   
>   /* Must be called with &virtio_gpu_fpriv.struct_mutex held. */
>   static void virtio_gpu_create_context_locked(struct virtio_gpu_device *vgdev,
> @@ -122,6 +125,12 @@ static int virtio_gpu_getparam_ioctl(struct drm_device *dev, void *data,
>   			return -ENOENT;
>   		value = vgdev->blob_alignment;
>   		break;
> +	case VIRTGPU_PARAM_USERPTR:
> +		value = 1;
> +		break;
> +	case VIRTGPU_PARAM_BLOB_READONLY:
> +		value = vgdev->has_blob_readonly ? 1 : 0;
> +		break;
>   	default:
>   		return -EINVAL;
>   	}
> @@ -453,11 +462,23 @@ static int verify_blob(struct virtio_gpu_device *vgdev,
>   	if (rc_blob->blob_flags & ~VIRTGPU_BLOB_FLAG_USE_MASK)
>   		return -EINVAL;
>   
> +	if (rc_blob->blob_hints & ~VIRTGPU_BLOB_HINT_MASK)
> +		return -EINVAL;
> +
>   	if (rc_blob->blob_flags & VIRTGPU_BLOB_FLAG_USE_CROSS_DEVICE) {
>   		if (!vgdev->has_resource_assign_uuid)
>   			return -EINVAL;
>   	}
>   
> +	if (rc_blob->blob_flags & VIRTGPU_BLOB_FLAG_USE_READONLY) {
> +		if (!vgdev->has_blob_readonly)
> +			return -EINVAL;
> +	}
> +
> +	if (rc_blob->userptr &&
> +	    rc_blob->blob_mem != VIRTGPU_BLOB_MEM_GUEST)
> +		return -EINVAL;
> +
>   	switch (rc_blob->blob_mem) {
>   	case VIRTGPU_BLOB_MEM_GUEST:
>   		*guest_blob = true;
> @@ -495,6 +516,7 @@ static int verify_blob(struct virtio_gpu_device *vgdev,
>   	params->blob = true;
>   	params->blob_flags = rc_blob->blob_flags;
>   	params->blob_hints = rc_blob->blob_hints;
> +	params->userptr = rc_blob->userptr;
>   
>   	if (vgdev->has_blob_alignment &&
>   	    !IS_ALIGNED(params->size, vgdev->blob_alignment))
> @@ -518,9 +540,10 @@ static int virtio_gpu_resource_create_blob_ioctl(struct drm_device *dev,
>   	struct virtio_gpu_fpriv *vfpriv = file->driver_priv;
>   	struct drm_virtgpu_resource_create_blob *rc_blob = data;
>   
> -	if (verify_blob(vgdev, vfpriv, &params, rc_blob,
> -			&guest_blob, &host3d_blob))
> -		return -EINVAL;
> +	ret = verify_blob(vgdev, vfpriv, &params, rc_blob,
> +			  &guest_blob, &host3d_blob);
> +	if (ret)
> +		return ret;
>   
>   	if (vgdev->has_virgl_3d)
>   		virtio_gpu_create_context(dev, file);
> @@ -538,7 +561,9 @@ static int virtio_gpu_resource_create_blob_ioctl(struct drm_device *dev,
>   				      vfpriv->ctx_id, NULL, NULL);
>   	}
>   
> -	if (guest_blob)
> +	if (guest_blob && params.userptr)
> +		ret = virtio_gpu_userptr_create(vgdev, file, &params, &bo);

After userptr creation has pinned pages, charged pinned_vm, queued 
resource creation, and registered the object for restore, the 
[handle-creation failure path calls drm_gem_object_release() directly. 
The UUID-assignment failure path does likewise.

That function releases GEM internals; it does not invoke the object’s 
.free callback. The userptr pages, DMA mapping, memlock charge, and host 
resource therefore remain unreleased, with no userspace handle available 
to close them.

These error paths predate the series, but this patch routes long-term 
userptr pins through them.

Regards,
Akihiko Odaki

> +	else if (guest_blob)
>   		ret = virtio_gpu_object_create(vgdev, &params, &bo, NULL);
>   	else if (!guest_blob && host3d_blob)
>   		ret = virtio_gpu_vram_create(vgdev, &params, &bo);
> diff --git a/drivers/gpu/drm/virtio/virtgpu_kms.c b/drivers/gpu/drm/virtio/virtgpu_kms.c
> index 1d4d3bf46a..06c2bded49 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_kms.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_kms.c
> @@ -249,15 +249,19 @@ int virtio_gpu_init(struct virtio_device *vdev, struct drm_device *dev)
>   		vgdev->blob_alignment = blob_alignment;
>   	}
>   
> +	if (virtio_has_feature(vgdev->vdev, VIRTIO_GPU_F_BLOB_READONLY))
> +		vgdev->has_blob_readonly = true;
> +
>   	DRM_INFO("features: %cvirgl %cedid %cresource_blob %chost_visible",
>   		 vgdev->has_virgl_3d    ? '+' : '-',
>   		 vgdev->has_edid        ? '+' : '-',
>   		 vgdev->has_resource_blob ? '+' : '-',
>   		 vgdev->has_host_visible ? '+' : '-');
>   
> -	DRM_INFO("features: %ccontext_init %cblob_alignment\n",
> +	DRM_INFO("features: %ccontext_init %cblob_alignment %cblob_readonly\n",
>   		 vgdev->has_context_init ? '+' : '-',
> -		 vgdev->has_blob_alignment ? '+' : '-');
> +		 vgdev->has_blob_alignment ? '+' : '-',
> +		 vgdev->has_blob_readonly ? '+' : '-');
>   
>   	ret = virtio_gpu_find_vqs(vgdev);
>   	if (ret) {

