Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com [136.143.188.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D1B54746C4
	for <virtualization@lists.linux.dev>; Fri, 14 Aug 2026 13:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786714961; cv=pass; b=PO+dTqETb6jR3EZ6lD+HaFScdpyX9pvt81Ev9AEdIBUuzj5eL1ochTEH/VCLxyaLndZzOSCiCxnb/Nf1AUBqXxr64xBi+/ZAX5fxPoZ3zh4FlmTL9Uc+odWrPpWgBh9yxwjregme4srvcoupjHbbXHoRxysF1/SYwbGiRyYYcZA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786714961; c=relaxed/simple;
	bh=J0vfmTpZ9t0ptMjSaKmesUe6jhOS/Uw5ltdu//JLO5E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PT8vtlkbLbSI/jgF3AidiCaXqVtrd0aI/H1Kc4bjnethnI5RmXM9fuZ5SRR2QGsqb9mGRQQE9K+zEQh/8lJCMiHSMZXwlAYFztmUek3dcI7xqWJLAz8tV0Nn5EjsjsFa4YWpHf/IVTmBDclv8wkI52T/4uaXvnWb2ttNkxHLZ3k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b=B2LWThud; arc=pass smtp.client-ip=136.143.188.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b="B2LWThud"
ARC-Seal: i=1; a=rsa-sha256; t=1786714945; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=gs948kVe1M/KYUcEEoeAyJ94VqNfqYJNz04UaJAYPUpDw+GPAdOb7QlxYPh1ERA3DSAVohW6dOrCuiX/c0TZ9OBO515Djs3ZZUWSakicdCXfJe/duTiRHUme1uBLX1a39oyDHfhf/8bcEBlmIHAuatNrqNYB7yj/mZLJSL+pJmY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1786714945; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=DQ43/x6sozGXuHfSJ4qayePUm8aQCZckR2BfRgZ1FGM=; 
	b=LYwgneKT4izMe1OgPjB9TaDOxPqj/CixAODkNcYFbfegHaogvKBumdwql0IkYN9fGIBvyWL2VcRQRMMkXEAVXwh7DGAy8EHmG+Yp44dTKjRaS5DE7us61CNYG6aBTeABuvetuUhw/TxtugswcsCr3e6jhHtT2l8vNWf2VFn9XLE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
	dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1786714944;
	s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=DQ43/x6sozGXuHfSJ4qayePUm8aQCZckR2BfRgZ1FGM=;
	b=B2LWThud/x67ZM8O5791MiKs5/vCuFZJhNy6FrShQiJODtxQ9ti2n6Upzpm+w86/
	JJP4fkzoatW9FapYzij9oe0j9krU7ttjd5+65MwIvXmiiuBAMi9frmHtL4NRgF4ueF4
	n5AJSjIOO0y8N+9K3gNPcL/cGqYcOWJpkK/EXY/Q=
Received: by mx.zohomail.com with SMTPS id 1786714943873790.0739716313591;
	Fri, 14 Aug 2026 06:42:23 -0700 (PDT)
Message-ID: <bfef9236-90f5-4795-be3a-5d522c1de05a@collabora.com>
Date: Fri, 14 Aug 2026 16:42:18 +0300
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/virtio: Fix a NULL vs ERR_PTR() bug in
 virtio_gpu_user_framebuffer_create()
To: Dan Carpenter <error27@gmail.com>, Dave Airlie <airlied@gmail.com>
Cc: David Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu
 <olvaffe@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Simona Vetter <simona@ffwll.ch>, "Michael S. Tsirkin" <mst@redhat.com>,
 dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <an1tWfHIHwtXd9SO@stanley.mountain>
Content-Language: en-US
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <an1tWfHIHwtXd9SO@stanley.mountain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

On 8/13/26 10:08, Dan Carpenter wrote:
> Smatch complains that returning a NULL here will lead to a NULL pointer
> dereference in drm_mode_addfb2().  Return an error pointer instead.
> 
> Fixes: dc5698e80cf7 ("Add virtio gpu driver.")
> Signed-off-by: Dan Carpenter <error27@gmail.com>
> ---
> This code is obviously over a decade old.  I think this patch is correct.
> None of the other implementations return NULL, but I haven't tested it.
> ---
>  drivers/gpu/drm/virtio/virtgpu_display.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/virtio/virtgpu_display.c b/drivers/gpu/drm/virtio/virtgpu_display.c
> index 44ffffec550f..85ea252c658e 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_display.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_display.c
> @@ -344,7 +344,7 @@ virtio_gpu_user_framebuffer_create(struct drm_device *dev,
>  	if (ret) {
>  		kfree(virtio_gpu_fb);
>  		drm_gem_object_put(obj);
> -		return NULL;
> +		return ERR_PTR(ret);
>  	}
>  
>  	return &virtio_gpu_fb->base;

Applied to drm-misc-fixes, thanks!

-- 
Best regards,
Dmitry
