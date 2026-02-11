Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0479234FF63
	for <virtualization@lists.linux.dev>; Wed, 11 Feb 2026 22:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770850731; cv=pass; b=WQ5fSVh8sTfcf74fe93RlPhBRVC+xMbusZiwYJP2yvJX4qFvB1j3cUTneVrLTpub2yfyUWyek3qvyO8kDNgd9WrRAW6gFms++H5Mqytj6xEaMDzHtKxHXKON8ZcAbVtu95lRw+eBfSHaJA60dPnRGQtQVzq9eksP4+DvYlskAS0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770850731; c=relaxed/simple;
	bh=srf3xjhvd9z9Ci5sLW1yNHQKrzcasC6YfvtI39BlR78=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TIMft/wBjyOQF+RO0O+/4MHSE+Cj+aufepmAe5meVxgJrhxCP+zeQrlbMPlImKD2GxXiXzibs0CNBZNwCXI+SOILEoCoS/jca1VK8SOyrqpTojaUa+xXvEFXEofueFKVPZmNRGX1DVNRVA19MqehFvuxpw+hqxIRF0Rt0EXCLfI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b=dV2CXZ+n; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b="dV2CXZ+n"
ARC-Seal: i=1; a=rsa-sha256; t=1770850716; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=MxrOMo5d6/mJLR3+tUr/QJOPUIJA9cntXWv0C+UXRGHuFnYnUhFHXZLAg9Do0Sp4G/udJUKK30LPgilaIA6B5lmlNexQKFSEYVqbeJ92jtb1UBHIWy5p85BpEzRQFfy+IsKO+DDUB0Awt/h51ePZ5LWwKZRJNO0hGTdYx2B9vfo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1770850716; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=u0fIcMRjfAcgBBlHlVGAIBXjKC32Ith8CmSk3y8tjw4=; 
	b=btUEEGGChSWJrNze8wxO0fn4dsXVjtE7xotft1YJ6IRizM07JI1ueSe2/ft5c0Zgf7Ooy4wJ62r0ZNoDfknLN2E1lehDM5Z97zais42E2NGnuQX1kMDEuyzU5ahyMM/8m0S92jV8W0QETLiTxu9clURzg4CMQCnsFMUXRHB5mNg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
	dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1770850716;
	s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=u0fIcMRjfAcgBBlHlVGAIBXjKC32Ith8CmSk3y8tjw4=;
	b=dV2CXZ+nnyCjfjQYasMF0k3Wkawiiy35BCr5U+qqNnq1uneOdZlIoQVZgZXzYLEf
	Sy8UnfWlQfVYFXkZiZYy7EG1PAmizit1vlNpo9SLKH29GL18I28ETLEGiKWBubnP49H
	7LLh0saY+6CErcS6EbvD3EUwmY9DYyOdcr+mlP2g=
Received: by mx.zohomail.com with SMTPS id 1770850714342875.3506197676041;
	Wed, 11 Feb 2026 14:58:34 -0800 (PST)
Message-ID: <b871f1d3-7a38-4f02-ac7a-7b8db188f464@collabora.com>
Date: Thu, 12 Feb 2026 01:58:29 +0300
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/virtio: Allow importing prime buffers when 3D is
 enabled
To: Val Packett <val@invisiblethingslab.com>,
 David Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu
 <olvaffe@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Simona Vetter <simona@ffwll.ch>, Vivek Kasireddy <vivek.kasireddy@intel.com>
Cc: Dongwon Kim <dongwon.kim@intel.com>,
 Christian Koenig <christian.koenig@amd.com>,
 dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20251210154755.1119861-2-val@invisiblethingslab.com>
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Content-Language: en-US
In-Reply-To: <20251210154755.1119861-2-val@invisiblethingslab.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

On 12/10/25 18:39, Val Packett wrote:
> This functionality was added for using a KMS-only virtgpu with a physical
> (or SR-IOV) headless GPU in passthrough, but it should not be restricted
> to KMS-only mode. It can be used with cross-domain to pass guest memfds
> to the host compositor with zero copies (using udmabuf on both sides).
> 
> Drop the check for the absence of virgl_3d to allow for more use cases.
> 
> Fixes: ca77f27a2665 ("drm/virtio: Import prime buffers from other devices as guest blobs")
> Signed-off-by: Val Packett <val@invisiblethingslab.com>
> ---
> 
> Hi. I couldn't find any comments on that line in the reviews (on patchwork), so I assume
> there was never a specific technical reason for that check, just an abundance of caution?
> 
> BTW, while here.. The drm_gem_prime_import "fallback" seems pretty much equivalent to
> `return (-ENODEV)`, as drm_gem_prime_import(_dev) just translates the call to
> gem_prime_import_sg_table which we don't use. Should it be replaced with `return (-ENODEV)`?
> 
> ---
>  drivers/gpu/drm/virtio/virtgpu_prime.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/virtio/virtgpu_prime.c b/drivers/gpu/drm/virtio/virtgpu_prime.c
> index ce49282198cb..2fedd5d3bd62 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_prime.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_prime.c
> @@ -312,7 +312,7 @@ struct drm_gem_object *virtgpu_gem_prime_import(struct drm_device *dev,
>  		}
>  	}
>  
> -	if (!vgdev->has_resource_blob || vgdev->has_virgl_3d)
> +	if (!vgdev->has_resource_blob)
>  		return drm_gem_prime_import(dev, buf);
>  
>  	bo = kzalloc(sizeof(*bo), GFP_KERNEL);

Reviewed-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>

-- 
Best regards,
Dmitry
