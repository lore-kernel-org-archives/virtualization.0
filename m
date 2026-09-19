Received: from www3579.sakura.ne.jp (www3579.sakura.ne.jp [49.212.243.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF2049620
	for <virtualization@lists.linux.dev>; Sat, 19 Sep 2026 14:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.212.243.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789828165; cv=none; b=RAI4DVXPLu6d/ZM0oq908Gsqba+FW+DgaAiyMixgNZuOe7Fu3Rk9BMm/kam5r6IdgZkGhzvadvti7N3cFaA1EQCCd5xz1ClnEkJjQwalMQNXhSI2/txNEsSy6IDENSJPdl165TigO4GGLG+aSvxirbJ5yW8eF/zkE5qqo9wnzu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789828165; c=relaxed/simple;
	bh=hQRhkBGmGktIxUUJEyUJ4Zv6JaF11MMaCAcPxJobxr4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g6WODpKylQDht9vSPNBbnTdJ3A8BBER1E1ByArbQWjUwGppdJM1wqYX8pYlv33eZJbdZSTgy6V+yz6I7RwjUmJ3YCqWE80kQnrhiv6KNff5zg1dqrISK6NDvJwakJX0besiyPHN/BsTvtcNxOHdGNjmnV9cp0Rpw25dYy8leZTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rsg.ci.i.u-tokyo.ac.jp; spf=pass smtp.mailfrom=rsg.ci.i.u-tokyo.ac.jp; dkim=pass (2048-bit key) header.d=rsg.ci.i.u-tokyo.ac.jp header.i=@rsg.ci.i.u-tokyo.ac.jp header.b=o6Evv39P; arc=none smtp.client-ip=49.212.243.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rsg.ci.i.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rsg.ci.i.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rsg.ci.i.u-tokyo.ac.jp header.i=@rsg.ci.i.u-tokyo.ac.jp header.b="o6Evv39P"
Received: from [192.168.10.153] (p865013-ipoe.ipoe.ocn.ne.jp [153.242.222.12])
	(authenticated bits=0)
	by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 68JESqEn008559
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Sat, 19 Sep 2026 23:28:52 +0900 (JST)
	(envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=jbBOxntz1gap3DyeUtvQ2VqD1OURsam0hBbMelddT+Q=;
        c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
        h=From:Message-ID:To:Subject:Date;
        s=rs20250326; t=1789828133; v=1;
        b=o6Evv39Pm1wuA8ehhGqkg45czcDO2esAcILWiIBFsZiUsV8y3VrSdeRCmi8PhnnA
         5AO8r0CA/cMKx0vaZp9YJE/C20Whyiw4z85g+nLCvquaqVdTC1jqexnZ88ocxqvT
         GTipS7gmQvGakJQdKt0I3IWrObsVZQ4k5Sfx/eY4K0JxU/ZNGK1xqP4YNDRqrgin
         +JeQC+MD/78XBHVlydOrUiatzQxgbkOiZ6kdXC2pZE/vIUu/vdAmexGiLfw2O1lP
         JIN3n00+AJbNivN8nVWaK8nT/kVKQxqztVb5x0zA3PLNjlz+CLW+8pPVBEef2dB4
         UrPw5zr+txpdpIMBdaf/HQ==
Message-ID: <73afcd33-14a0-4c26-8cfd-1737e46463c9@rsg.ci.i.u-tokyo.ac.jp>
Date: Sat, 19 Sep 2026 23:28:52 +0900
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 4/4] drm/virtio: wire blob ioctl creation to userptr
 objects
To: Honglei Huang <honghuan@amd.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        David Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Cc: Gurchetan Singh <gurchetansingh@chromium.org>,
        Chia-I Wu <olvaffe@gmail.com>, Ray Huang <Ray.Huang@amd.com>,
        dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20260918095940.2253018-1-honghuan@amd.com>
 <20260918095940.2253018-5-honghuan@amd.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260918095940.2253018-5-honghuan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2026/09/18 18:59, Honglei Huang wrote:
> Integrate userptr into the blob resource creation ioctl.
> 
> - A non-zero userptr selects virtio_gpu_userptr_create()
> - Reject userptr unless blob_mem is VIRTGPU_BLOB_MEM_GUEST
> - Reject VIRTGPU_BLOB_FLAG_USE_READONLY unless the device
>    advertised VIRTIO_GPU_F_BLOB_READONLY
> - Advertise VIRTGPU_PARAM_USERPTR and VIRTGPU_PARAM_BLOB_READONLY
> 
> Signed-off-by: Honglei Huang <honghuan@amd.com>
> ---
>   drivers/gpu/drm/virtio/virtgpu_debugfs.c |  1 +
>   drivers/gpu/drm/virtio/virtgpu_ioctl.c   | 35 ++++++++++++++++++++----
>   drivers/gpu/drm/virtio/virtgpu_kms.c     |  8 ++++--
>   3 files changed, 37 insertions(+), 7 deletions(-)
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

This hits BUG(). It queries queries VIRTIO_GPU_F_BLOB_READONLY, but the 
feature is absent from the driver’s features[]. virtio_has_feature() 
validates device-specific queries through 
virtio_check_driver_offered_feature(), which executes BUG() for an 
unregistered feature. This affects ordinary probe regardless of host 
support.

Please add the feature to the array and ensure that the patch is 
properly tested before submission.

Regards,
Akihiko Odaki

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

