Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE6934BA37
	for <virtualization@lists.linux.dev>; Wed,  8 Oct 2025 16:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759942056; cv=pass; b=pvjd7F0cQPot7VNzKSJehsRj00etElNOzAALbO/fZleP4oajM9g2IYBOMxz/IOrcGkhSEuvgcChVhVkv7wsRgeq/ebyHZu2VqYFPB2lsr/k/gGwgA5+vJYF1LqOyFWYcPsbghdYC+vXCp/C6LTJVEoL//9vEgxkwukzIVbtT5N0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759942056; c=relaxed/simple;
	bh=8NqWxmFqUk02RxgmNJic+0K1cP0pcCdsMzferoX15AA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UVETUXF6okouD4Q3REqB7BEG/FkoOtYR1seFjjfLnH8jzJcCivJZJjYRpiLuvPsS1dAi+jLbw4vajuKoo0vE6dEBC8ONCz4vI/P0wRgjmP8Zd2PnNoJOzx2c1c0uF19qp4hRl6SAHaieFAV36v3tPSSSYKP+AdU8sW2wKxZjb1Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b=NFmYHSZk; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b="NFmYHSZk"
ARC-Seal: i=1; a=rsa-sha256; t=1759942041; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Z5CCErlDgBmAxEFsXbfgQngcgx7bfZmxnr4dwcsWQkCd1Lmsngw9oorjJ8o0+twLS9IqmVoq7R4Y7aTIM9gJubAi1o6sHMlUqzaKIIz5b2mCVH7ySh5EF53lCSZMZdG9nSVaowxoBRWt4QJF8YYzPD8TE2L2QggsfdJjzDM0lTo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1759942041; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=LWXaENrud5lMIOoh2ZuAwZH2Oo66P4MKxQD5hdzO0oI=; 
	b=FdOp1pqv99+ayHDj83J9cswJtDpmYJvwGCL4z9N+g1Q4LiWBOb9PuJHbbkQqwiBNmfxLdb+6sc5F+6TSJ4c/qmiOJt41IFP5w/Nb5mZWnSOPuuUCpxp+chT/iQajL0PRZHFcIzjXuMju1t5s5YeLfiNNBa8/wEYquyERJs2gU0Q=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
	dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1759942041;
	s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=LWXaENrud5lMIOoh2ZuAwZH2Oo66P4MKxQD5hdzO0oI=;
	b=NFmYHSZkkpu+wq4DY2cDL+M9e/1Dbp3TNq7z2Mb51TVN9syyRQEOGzMXKKEkTwi3
	/KTO7HxKrlFzQCzMFrH8tD806eNk0Q+jtmQ7oyGVPMbk381G+uET1mUIzCi3VDyE756
	E1JBOQ0lJZOO3h7z0SlHozEFysdRJC55coUHX7tI=
Received: by mx.zohomail.com with SMTPS id 1759942038267496.8933381449177;
	Wed, 8 Oct 2025 09:47:18 -0700 (PDT)
Message-ID: <00734e4b-ad39-42bd-b65e-13dcc67a95a0@collabora.com>
Date: Wed, 8 Oct 2025 19:47:11 +0300
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.10] gpu/drm/virtio: fix error return in
 vgdev_output_init()
To: Alexandr Sapozhnkiov <alsp705@gmail.com>,
 David Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu
 <olvaffe@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Daniel Vetter <daniel@ffwll.ch>, dri-devel@lists.freedesktop.org,
 virtualization@lists.linux.dev
Cc: lvc-project@linuxtesting.org
References: <20250922144418.41-1-alsp705@gmail.com>
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Content-Language: en-US
In-Reply-To: <20250922144418.41-1-alsp705@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

On 9/22/25 17:44, Alexandr Sapozhnkiov wrote:
> From: Alexandr Sapozhnikov <alsp705@gmail.com>
> 
> Return value of function drm_crtc_init_with_planes(), 
> called at virtgpu_display.c:276, is not checked, 
> but it is usually checked for this function
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> Signed-off-by: Alexandr Sapozhnikov <alsp705@gmail.com>
> ---
>  drivers/gpu/drm/virtio/virtgpu_display.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/virtio/virtgpu_display.c b/drivers/gpu/drm/virtio/virtgpu_display.c
> index ad924a8502e9..59b652e8a630 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_display.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_display.c
> @@ -253,6 +253,7 @@ static const struct drm_connector_funcs virtio_gpu_connector_funcs = {
>  
>  static int vgdev_output_init(struct virtio_gpu_device *vgdev, int index)
>  {
> +	int ret;
>  	struct drm_device *dev = vgdev->ddev;
>  	struct virtio_gpu_output *output = vgdev->outputs + index;
>  	struct drm_connector *connector = &output->conn;
> @@ -273,8 +274,10 @@ static int vgdev_output_init(struct virtio_gpu_device *vgdev, int index)
>  	cursor = virtio_gpu_plane_init(vgdev, DRM_PLANE_TYPE_CURSOR, index);
>  	if (IS_ERR(cursor))
>  		return PTR_ERR(cursor);
> -	drm_crtc_init_with_planes(dev, crtc, primary, cursor,
> +	ret = drm_crtc_init_with_planes(dev, crtc, primary, cursor,
>  				  &virtio_gpu_crtc_funcs, NULL);
> +	if (ret)
> +		return ret;
>  	drm_crtc_helper_add(crtc, &virtio_gpu_crtc_helper_funcs);
>  
>  	drm_connector_init(dev, connector, &virtio_gpu_connector_funcs,

Patch will need a cosmetic correction for the indentation that I'll
change while applying, thanks.

Reviewed-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>

-- 
Best regards,
Dmitry

