Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B388918D636
	for <virtualization@lists.linux.dev>; Thu, 13 Nov 2025 02:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763000440; cv=pass; b=fOdobC5wXyKJ2r0emzgqXVXMRe9ZmtYl/HvgEK0oKv7l+2+0IyIwlWlfGKwOqB7TyigGiPdSY0V2fcCMsvHZ4yMihRguQDqLib9twpqlzMSLbc3FKZI7FYR9Upe36G8U5cwTnBHwyRnz+BAP6h5NJEMUC57/Z8fwEyJbdBWwMg8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763000440; c=relaxed/simple;
	bh=5G+EBEAStR9dBA5vNteBh8cQvASM4RvoaKQn4kzVmT0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=AS8qZHHJ9/J5D2Mqy0XPirwIeYlMgO/W5N0ICJm/ped7qIAEBiDPSicVTNmrlMKaUpSS6zfQRKL1rBEy5k4hD38pFINOxxvysJ06w2WiDGzwZ3JXCENHTYwjLXtvPTn1dv9UIAeJFY/p6b8F4+699BfsrI+SWjjylpINdQCpj2k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b=Ykx6cwph; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b="Ykx6cwph"
ARC-Seal: i=1; a=rsa-sha256; t=1763000430; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Fsnr9vZ5NGrdP8x/dqCqh3iOzrS213gfxHn23mHhelONJvn7foNpXlzeHKxvxX/FOCMpG3tfxit8geZeiDi6C4ePmzp4Vwuj4b/Hywcb28qrtBwCCo9MiYj7N0hgVxE65jMC9wwodDXy7kTKVtX+kXrh/40dvgmiAE4NWTqmy4I=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1763000430; h=Content-Type:Content-Transfer-Encoding:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To:Cc; 
	bh=mqbuiA6KomhjuHhIUVCCeKDvtezWgMjIt+vfJaSlA9M=; 
	b=LFKKKW4HxofqGNOe77SPsABG3PsoZykfocEmr19x1tEMQeqnHQCFfdtB+YzZgRUFeudwSRj45aVmkcRZ0cYza03h9qvOW/7fCwJj9IyGZFxdpNUnlM8aEWBn2eoovilD43+arr+Uu9TcCrNPTNjSLaRbAw65oRKCKrDMhN9yw9o=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
	dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1763000430;
	s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
	bh=mqbuiA6KomhjuHhIUVCCeKDvtezWgMjIt+vfJaSlA9M=;
	b=Ykx6cwph64ihkasvXdZAt5C9ZxEisXM1VhJPJBMryvm1kFToEgnNDoCLD2Z2Uj9+
	1qhWBNL1dDP7AUfVB7JnO7NdOkGNnJt9p7niAap1JGKrWfepYAu23M2k8uC/lYLqgEe
	UoCaNOCLnGiSAFAAc+Kbsqa1O/Ia2QUpiSxemGQM=
Received: by mx.zohomail.com with SMTPS id 1763000427524775.8518137767941;
	Wed, 12 Nov 2025 18:20:27 -0800 (PST)
Message-ID: <77d96772-9518-4a60-a258-4bf58bf576ff@collabora.com>
Date: Thu, 13 Nov 2025 05:20:21 +0300
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] drm/virtio: honor blob_alignment requirements
To: Sergio Lopez <slp@redhat.com>, David Airlie <airlied@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu
 <olvaffe@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Simona Vetter <simona@ffwll.ch>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20251110125213.12633-1-slp@redhat.com>
 <20251110125213.12633-3-slp@redhat.com>
Content-Language: en-US
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <20251110125213.12633-3-slp@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

On 11/10/25 15:52, Sergio Lopez wrote:
> diff --git a/drivers/gpu/drm/virtio/virtgpu_object.c b/drivers/gpu/drm/virtio/virtgpu_object.c
> index e6363c887500..6118344bff84 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_object.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_object.c
> @@ -246,8 +246,10 @@ int virtio_gpu_object_create(struct virtio_gpu_device *vgdev,
>  		if (params->blob_mem == VIRTGPU_BLOB_MEM_GUEST)
>  			bo->guest_blob = true;
>  
> -		virtio_gpu_cmd_resource_create_blob(vgdev, bo, params,
> -						    ents, nents);
> +		ret = virtio_gpu_cmd_resource_create_blob(vgdev, bo, params,
> +							  ents, nents);
> +		if (ret)
> +			goto err_put_objs;

Isn't it impossible for host to import guest blob when HOST_PAGE_SIZE >
GUEST_PAGE_SIZE?

-- 
Best regards,
Dmitry
