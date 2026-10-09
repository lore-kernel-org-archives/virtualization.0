Received: from sender6-op-o11.zoho.com (sender6-op-o11.zoho.com [165.173.180.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF524F7CDE
	for <virtualization@lists.linux.dev>; Fri,  9 Oct 2026 18:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=165.173.180.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791570072; cv=pass; b=RBPcveAYU3xJQi0Job2ECFAZQpZciRIwc5H0UO9CuoY4i7XlO5JE2bI7kN+7KMX/c856pBW13RVgyBxmLWENSdjrOCzwhwblW4mBl6D3LpvAd5xSPlhSRDVgVJfZHuC0BvyVSyrvqcnOPZBJoF5pftRG43dXZDMarCb63yRdkMw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791570072; c=relaxed/simple;
	bh=MUU0tB8Jx26FgL2iHifAoAbt9InUmyA35GG1/krvv6w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cH3LdpRCL+tBMheKvYcHfdpIhI/g1FUaMn/q7qAcowg2x2b1VEF9LnBH64f2o/wVNmorejU4EVIryulh+0xNscK1+lEZn0UtE/J3WCiTF1WF3I70BFxwsj61n93lZ/CNOk9xumX3vc4U6xsn2oykjVfXEa36y6sYKZemEXEVhhU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b=USHIOoUT; arc=pass smtp.client-ip=165.173.180.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b="USHIOoUT"
ARC-Seal: i=1; a=rsa-sha256; t=1791570060; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=KBYTk6KGAgv64y/RlqmYBaafAarOghrZ/p+nrf+rm5mnS5UmXoGDE9JJtUD34puIDHKl4vVUAfiaRsdoqBaQR+oNCjyVwC2vszeiGWOLeKYwkEWCUknzGuY57pNrLNE1IqPbRxt6/WNx/PypIO3Du9zl3eFsC4ohdCtC6pnKncI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1791570060; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=vi4rrk3WrmUY5r1YhsxpU4hwE715rgi/SUSO86tmsSo=; 
	b=Kw8qz4UeFvj5ti1hmA+x8umNll9pMjV4oPfxqaA/kyhyFy3MXzpLfRUG8NEi09pzTpRQGyjW0Xo9aMJnZw6AmBg7K/LKaxk3d0YhV6pTK4T68isAFGVOyC84WOi+FvsYlJuHRxu3D4oZKedQ0fms2ak6HiHSFh/7bT6KV3H/lH8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
	dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1791570060;
	s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=vi4rrk3WrmUY5r1YhsxpU4hwE715rgi/SUSO86tmsSo=;
	b=USHIOoUTphmj7cybVBQX7dvz4BYsv8+kFE/ALFcZMsFawe7u4f3htgSCGBzgdAML
	yJS//mgDaLc8NZF049y6FCbzqNKo4YD6+oj0utavelO8rK9isVEV3i6Cxs0SEsv/jRU
	WVRWxSx5el9NfruQHExhIh/cyPEliwc9BwDx6gaM=
Received: by smtp.zohomail.com with SMTPS id 1791570058457835.3461836118272;
	Fri, 9 Oct 2026 11:20:58 -0700 (PDT)
Message-ID: <8eb83031-432b-43be-b45c-71d28ebe0c2a@collabora.com>
Date: Fri, 9 Oct 2026 21:20:53 +0300
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/virtio: add overlay plane format support
To: "Baorui.Liu" <baorliu@amd.com>, dri-devel@lists.freedesktop.org
Cc: virtualization@lists.linux.dev, airlied@redhat.com, kraxel@redhat.com,
 gurchetansingh@chromium.org, olvaffe@gmail.com, lili.gong@amd.com,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Simona Vetter <simona@ffwll.ch>, linux-kernel@vger.kernel.org
References: <20260924142242.676-1-baorliu@amd.com>
Content-Language: en-US
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <20260924142242.676-1-baorliu@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

24.09.2026 17:22, Baorui.Liu пишет:
> From: Sophia Gong <lili.gong@amd.com>
> 
> Advertise additional pixel formats for virtio-gpu overlay planes so a
> userspace compositor can use KMS overlay composition instead of
> falling back to GPU composition.
> 
> Handle DRM_PLANE_TYPE_OVERLAY in virtio_gpu_plane_init() with a
> dedicated format list, and reuse the primary plane update path for
> overlay scanout.
> 
> Signed-off-by: Sophia Gong <lili.gong@amd.com>
> Signed-off-by: Baorui.Liu <baorliu@amd.com>
> ---
>  drivers/gpu/drm/virtio/virtgpu_plane.c | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 
> diff --git a/drivers/gpu/drm/virtio/virtgpu_plane.c b/drivers/gpu/drm/virtio/virtgpu_plane.c
> index 29e4b458ae57..23ca880692f1 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_plane.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_plane.c
> @@ -41,6 +41,21 @@ static const uint32_t virtio_gpu_cursor_formats[] = {
>  	DRM_FORMAT_HOST_ARGB8888,
>  };
>  
> +static const uint32_t virtio_gpu_overlay_formats[] = {
> +	DRM_FORMAT_XRGB8888,
> +	DRM_FORMAT_ARGB8888,
> +	DRM_FORMAT_BGRX8888,
> +	DRM_FORMAT_BGRA8888,
> +	DRM_FORMAT_RGBX8888,
> +	DRM_FORMAT_RGBA8888,
> +	DRM_FORMAT_XBGR8888,
> +	DRM_FORMAT_ABGR8888,
> +	DRM_FORMAT_XRGB2101010,
> +	DRM_FORMAT_BGRX1010102,
> +	DRM_FORMAT_NV12,
> +	DRM_FORMAT_P010,
> +};
> +
>  uint32_t virtio_gpu_translate_format(uint32_t drm_fourcc)
>  {
>  	uint32_t format;
> @@ -572,6 +587,13 @@ static const struct drm_plane_helper_funcs virtio_gpu_cursor_helper_funcs = {
>  	.atomic_update		= virtio_gpu_cursor_plane_update,
>  };
>  
> +static const struct drm_plane_helper_funcs virtio_gpu_overlay_helper_funcs = {
> +	.prepare_fb		= virtio_gpu_plane_prepare_fb,
> +	.cleanup_fb		= virtio_gpu_plane_cleanup_fb,
> +	.atomic_check		= virtio_gpu_plane_atomic_check,
> +	.atomic_update		= virtio_gpu_primary_plane_update,
> +};
> +
>  struct drm_plane *virtio_gpu_plane_init(struct virtio_gpu_device *vgdev,
>  					enum drm_plane_type type,
>  					int index)
> @@ -586,6 +608,10 @@ struct drm_plane *virtio_gpu_plane_init(struct virtio_gpu_device *vgdev,
>  		formats = virtio_gpu_cursor_formats;
>  		nformats = ARRAY_SIZE(virtio_gpu_cursor_formats);
>  		funcs = &virtio_gpu_cursor_helper_funcs;
> +	} else if (type == DRM_PLANE_TYPE_OVERLAY) {
> +		formats = virtio_gpu_overlay_formats;
> +		nformats = ARRAY_SIZE(virtio_gpu_overlay_formats);
> +		funcs = &virtio_gpu_overlay_helper_funcs;
>  	} else {
>  		formats = virtio_gpu_formats;
>  		nformats = ARRAY_SIZE(virtio_gpu_formats);

This won't work on its own without actually creating overlay planes and
having host supporting overlays based on virtio-gpu specification
defining how overlays are defined in protocol and work.

Upstreaming such feature will require you to provide spec, full guest
and host implementations of overlays.

-- 
Best regards,
Dmitry
