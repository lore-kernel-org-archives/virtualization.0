Received: from sender5-op-o11.zoho.com (sender5-op-o11.zoho.com [165.173.182.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB5448E0C4
	for <virtualization@lists.linux.dev>; Thu,  8 Oct 2026 09:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=165.173.182.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791452159; cv=pass; b=idhqz9Nblkf3zd4KkKmu5uXcoTLRwYaUsK8zOrtG+exoO2Q2YkG7obI72ebMJMPG5LM2/PBdswvQrn0p61SM8lbvbfrShtSusD1mQ/BNuk1Mdj5FhEnVGeFkYz7YkliGndAdydwkSdQ/UGhxPG81SN7g2oLqICRTQHPFfy2++f8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791452159; c=relaxed/simple;
	bh=CsXYTuo01XtZSg/MVmH+hBf2Z5KKaYx+e/CEG7TgInY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=utUzC1DAHZPBy2xknmL0u5DGLaPKP5RZGWAOWkrccELRClowyGdEZbTRicJoz0yq+p2SRTCTd3UXmfuGl0R1Y6H/3S4fKjrtt8CfTXnkLfY+5n6qkVpZKO+LCghvJGj9FtaHVhpte2cX253HpHI2MOk2HyPd0XgnBZNeJecwN6U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b=Ovbcn+Dp; arc=pass smtp.client-ip=165.173.182.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b="Ovbcn+Dp"
ARC-Seal: i=1; a=rsa-sha256; t=1791452151; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=EFzOhrqF0D6RuIeHK3Z2/DXsEUOj+JrWQ9MnFSNWYDF6l3jaTv9EU9Qn/7mz6oGsaoE0boIw0Rf1qfP8gEHkxBmO43LfWlJOR3Mco5gqPNOc4/J8Ef0IOopWiOnSQ25N5bzl0hj2X9AXim1T7/dbc+yTEA0tW72A9OjfU64yWYk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1791452151; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=4VnOjx2KntnOr3fpM0koQeAVv8fD8ZmjHvdUfitA1NY=; 
	b=l4Rn2lcc0fJA4FJgkZD44+XZEk2j+htHGejMFV/4mRYXYaiM0RLoiLKdICmqwIkJ7srcTkGmEr67tS0DOPqeVxl3s0BAix/8BvFZ/PBU8MWX6y9+EQ//yn8YZOaQzWGS68TfAbuiCpQJM00uSYw2uEEdy6QF3WuqWVXTtIo8/EM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
	dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1791452151;
	s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:From:From:To:To:Cc:Cc:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=4VnOjx2KntnOr3fpM0koQeAVv8fD8ZmjHvdUfitA1NY=;
	b=Ovbcn+DpQthlnuB5owvSuEw90A3H4zHhemwX43JTiNpXACYToaLlzcX+yQuYgak/
	9b/s89n4kXQNwAeBUMAKauSWUuaUkQgPD6RfreQusEHcWhzdK2Ou5Z0iz6pczO36p95
	OtKJFGov53ROX8QGw0vMghIID2zmafUpuahri99g=
Received: by smtp.zohomail.com with SMTPS id 1791452150818849.5609116892517;
	Thu, 8 Oct 2026 02:35:50 -0700 (PDT)
Message-ID: <dae2c4c1-0b60-4975-83d6-924d5255db94@collabora.com>
Date: Thu, 8 Oct 2026 12:35:44 +0300
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] Revert "drm/virtio: Add pixel blend mode property to
 cursor plane"
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
To: David Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu
 <olvaffe@gmail.com>, Marek Szyprowski <m.szyprowski@samsung.com>
Cc: dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20261007222244.295186-1-dmitry.osipenko@collabora.com>
Content-Language: en-US
In-Reply-To: <20261007222244.295186-1-dmitry.osipenko@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

On 10/8/26 01:22, Dmitry Osipenko wrote:
> The cursor blending mode was added twice because the same change was
> applied by accident from different patches. Revert the second patch.
> 
> Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Link: https://lore.kernel.org/dri-devel/ce84d3d2-e78b-4939-aecf-9ef7267bd42a@samsung.com/
> Fixes: 6947b78df4d2 ("drm/virtio: Add pixel blend mode property to cursor plane")
> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> ---
>  drivers/gpu/drm/virtio/virtgpu_plane.c | 13 -------------
>  1 file changed, 13 deletions(-)
> 
> diff --git a/drivers/gpu/drm/virtio/virtgpu_plane.c b/drivers/gpu/drm/virtio/virtgpu_plane.c
> index b422eba42a5f..640815af4098 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_plane.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_plane.c
> @@ -589,7 +589,6 @@ struct drm_plane *virtio_gpu_plane_init(struct virtio_gpu_device *vgdev,
>  	struct drm_plane *plane;
>  	const uint32_t *formats;
>  	int nformats;
> -	int ret;
>  
>  	if (type == DRM_PLANE_TYPE_CURSOR) {
>  		formats = virtio_gpu_cursor_formats;
> @@ -615,17 +614,5 @@ struct drm_plane *virtio_gpu_plane_init(struct virtio_gpu_device *vgdev,
>  		drm_plane_create_blend_mode_property(plane,
>  						     BIT(DRM_MODE_BLEND_PREMULTI));
>  
> -	if (type == DRM_PLANE_TYPE_CURSOR) {
> -		/*
> -		 * The cursor plane exposes a format with an alpha channel,
> -		 * which requires a blend mode property. The host blends
> -		 * premultiplied alpha, matching the property's default.
> -		 */
> -		ret = drm_plane_create_blend_mode_property(plane,
> -							   BIT(DRM_MODE_BLEND_PREMULTI));
> -		if (ret)
> -			return ERR_PTR(ret);
> -	}
> -
>  	return plane;
>  }

Marek, could you please give your r-b?

-- 
Best regards,
Dmitry
