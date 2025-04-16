Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72E1922D4E2
	for <virtualization@lists.linux.dev>; Wed, 16 Apr 2025 06:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744785906; cv=pass; b=nsVzpADGKLH2rW4ULw8YD54Z6+qMVJkGXCcvUNX5dPpsqX1gTslBHpCOpuJqfmJmSoIFtg8rhBbLDq782zDQ679+kPBVU6U2rDP93u1fRoRLA697JsmFPFoc6qh4iQKhY8jvGLxuSVlVwMHTGxWAdnnhHlGTxxvSb8OrM4RgfTA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744785906; c=relaxed/simple;
	bh=hXu8SrTCPgtZHEjQCpJ0Mzl9iZBltCRjssE0LtaPN58=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CLFDNlesRg9xMpNSARGRS9uTA1kfzvAL7MWFLsOWo7HpnJLk9fvNw5w0BWMxkQweSmwi96In645Bfi08aSz3ohmnnMMtBP/d+v9WJTxW+pm8opPG4BkPUXT8zRMZfJ6/4tTonw3O9BGc5fAKoKvWB4mPWC3CSBFsiyqbbH9KDIs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b=BSITgQOc; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b="BSITgQOc"
ARC-Seal: i=1; a=rsa-sha256; t=1744785896; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Y3eiYJ6e8CgDbGLWRWvY3Dk5F8nrgnFh39kUZ2kV7SgwkMY7ohmJY+QUNQr5gNzOrTfoM5ibf+y6t9l6S7u4HodwlK3FEIUvFNLbTUbKq80Za8EWzw0iDJYOyklPxb34N7IlCzgS+G+HbClWtJA9WRQxaHwoCrUZPsabJ9IiAek=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1744785896; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=9/nvMzXrROYeNn4+PCWslifty45CG46gd92CWnrTo3k=; 
	b=YIbsTbuW0ZGA0zvqLbu22Hnir+mIo7Rs/E6/3yA5bCBeNuWKewEyvRFFahzw6xWx/KU+roI8kTIC0OkyJ9dOhgq6oAfxHANFoG2Zedr1pFalokAoTM9dr2B6LJNuYG/wb+0kHUYNp7/GojlU7jYVoH1RmeME8nsctdTRZxsMpaI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
	dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1744785896;
	s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=9/nvMzXrROYeNn4+PCWslifty45CG46gd92CWnrTo3k=;
	b=BSITgQOcWomUuQpCD/SRhpGD3RbmSANlIS7Bu7+4Xjp4pgy9EqW/dbQb/q9W7u4y
	ZvhGWz7SmBI/EN40zDUZR2qjNtezbtE/XgXWZh17BVgLB51/JsQINReYveTpKsdXmH9
	2sUqE00RIvkoE/CRN0x/S0uPdNrb0LaiO974t7eo=
Received: by mx.zohomail.com with SMTPS id 1744785895561587.3497358810888;
	Tue, 15 Apr 2025 23:44:55 -0700 (PDT)
Message-ID: <103b62c9-18e2-43b9-866a-4dace75df422@collabora.com>
Date: Wed, 16 Apr 2025 09:44:52 +0300
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 17/19] drm/virtio: Pass along the format info from
 .fb_create() to drm_helper_mode_fill_fb_struct()
To: Ville Syrjala <ville.syrjala@linux.intel.com>,
 dri-devel@lists.freedesktop.org
Cc: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 David Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu
 <olvaffe@gmail.com>, virtualization@lists.linux.dev
References: <20250410163218.15130-1-ville.syrjala@linux.intel.com>
 <20250410163218.15130-18-ville.syrjala@linux.intel.com>
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Content-Language: en-US
In-Reply-To: <20250410163218.15130-18-ville.syrjala@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

On 4/10/25 19:32, Ville Syrjala wrote:
> From: Ville Syrjälä <ville.syrjala@linux.intel.com>
> 
> Plumb the format info from .fb_create() all the way to
> drm_helper_mode_fill_fb_struct() to avoid the redundant
> lookup.
> 
> Cc: David Airlie <airlied@redhat.com>
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> Cc: Gurchetan Singh <gurchetansingh@chromium.org>
> Cc: Chia-I Wu <olvaffe@gmail.com>
> Cc: virtualization@lists.linux.dev
> Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
> ---
>  drivers/gpu/drm/virtio/virtgpu_display.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/virtio/virtgpu_display.c b/drivers/gpu/drm/virtio/virtgpu_display.c
> index 93763b91bab5..e5805ca646c7 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_display.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_display.c
> @@ -66,6 +66,7 @@ static const struct drm_framebuffer_funcs virtio_gpu_fb_funcs = {
>  static int
>  virtio_gpu_framebuffer_init(struct drm_device *dev,
>  			    struct virtio_gpu_framebuffer *vgfb,
> +			    const struct drm_format_info *info,
>  			    const struct drm_mode_fb_cmd2 *mode_cmd,
>  			    struct drm_gem_object *obj)
>  {
> @@ -73,7 +74,7 @@ virtio_gpu_framebuffer_init(struct drm_device *dev,
>  
>  	vgfb->base.obj[0] = obj;
>  
> -	drm_helper_mode_fill_fb_struct(dev, &vgfb->base, NULL, mode_cmd);
> +	drm_helper_mode_fill_fb_struct(dev, &vgfb->base, info, mode_cmd);
>  
>  	ret = drm_framebuffer_init(dev, &vgfb->base, &virtio_gpu_fb_funcs);
>  	if (ret) {
> @@ -315,7 +316,7 @@ virtio_gpu_user_framebuffer_create(struct drm_device *dev,
>  		return ERR_PTR(-ENOMEM);
>  	}
>  
> -	ret = virtio_gpu_framebuffer_init(dev, virtio_gpu_fb, mode_cmd, obj);
> +	ret = virtio_gpu_framebuffer_init(dev, virtio_gpu_fb, info, mode_cmd, obj);
>  	if (ret) {
>  		kfree(virtio_gpu_fb);
>  		drm_gem_object_put(obj);

Acked-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>

-- 
Best regards,
Dmitry
