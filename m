Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9EF11FBEA6
	for <virtualization@lists.linux.dev>; Thu, 13 Nov 2025 02:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763001282; cv=pass; b=XzI9N5YvBytJ2YU0Z13zfmVCm+Lni7jAwXyBm+Ucnat/6uUYJCgMhvAsi+rTkaNQ2GOF2+MJnXoOXz4ODrHtZONdLUfjyqYhmIluSYRs5hZXF4uXEKkeLpg9DXdAsICwKZBXzZfG1TMxG5C/8rPBl/Eqv9LJjKrHhA2tV745FI4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763001282; c=relaxed/simple;
	bh=mVRXNcvqi82YBgb0uxW1PZbdYgcOsbV9J3Llk/3Byb0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=kH4zRgRi9S5VZDzT47V5vWvdfZ71IUy4/nKQtY0lvGO9OqVWkA9dwDe9d/P/xL3WfeUOT1dNrYkaqGAT3t/GJHSlrHKgvvwTh8D2hMJ2xxYXim1LNUDjxGUHgDTyvOfoDIpghOefRD9pZlza0QQqy7rKnHRtEYNvma4QC2LjDYU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b=P24s5AAV; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b="P24s5AAV"
ARC-Seal: i=1; a=rsa-sha256; t=1763001273; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=B7SFu5ETwjy85/Ic1bbtgLpT4XemaJM8i7JtWQpBZw480F5XkH2ZNkG2RXnohUIYSj8lLDhusWrEKUEaxkT3UXUMB1g+Lm+QWT1S8aNw5HL1vpUB/5Ty/4nTX7plfWMSDz9iuFwomEB60SdhsJruFJFM25xfgaUVTdgkoc7YCc4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1763001273; h=Content-Type:Content-Transfer-Encoding:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To:Cc; 
	bh=2eUPPGkZvURO4UPuvy1UUU86CcUrGh5d2/9bX+GGkoY=; 
	b=NTCWBK0XX1wVMMwOQKLEWx3Ex4x0tlHbCXMO4/T29stLgGcpuEfI5UWT2Z9iLD3IfXma9Tx1gWJEMPBQ/qh9CnvptPOtVssTXbDXtt+c9n700sJFmAmDVBMICiOFBcdLEI0t/hT53EZfMxufXBbbxsfQKlJJxFHhgFV2gp1oBGg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
	dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1763001273;
	s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
	bh=2eUPPGkZvURO4UPuvy1UUU86CcUrGh5d2/9bX+GGkoY=;
	b=P24s5AAVr5+mVW0F+1Nn2Kg6BR4GomUx3Ct+LfFWqfQYJVoQlH7PW/dIfgMtJpJD
	00Tt95TEUZA2qlIZcIc3UhSzBA6vhJ/HyaHVcCoVEc84bRxI+B4Qh+Rd/cDqPoDugQ9
	SgW7QVq7CFfA5DBUHawlqOv/SYmvhBb4ZIFP5u28=
Received: by mx.zohomail.com with SMTPS id 1763001271309192.29208265738407;
	Wed, 12 Nov 2025 18:34:31 -0800 (PST)
Message-ID: <d1de262f-eee9-49bb-94b5-4ef9ee6863f8@collabora.com>
Date: Thu, 13 Nov 2025 05:34:26 +0300
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
> diff --git a/drivers/gpu/drm/virtio/virtgpu_prime.c b/drivers/gpu/drm/virtio/virtgpu_prime.c
> index ce49282198cb..06593496c53f 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_prime.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_prime.c
> @@ -257,8 +257,11 @@ static int virtgpu_dma_buf_init_obj(struct drm_device *dev,
>  	params.blob_flags = VIRTGPU_BLOB_FLAG_USE_SHAREABLE;
>  	params.size = attach->dmabuf->size;
>  
> -	virtio_gpu_cmd_resource_create_blob(vgdev, bo, &params,
> -					    ents, nents);
> +	ret = virtio_gpu_cmd_resource_create_blob(vgdev, bo, &params,
> +						  ents, nents);
> +	if (ret)
> +		goto err_import;

The error handling is incorrect, dma_buf_unmap_attachment() won't be
invoked when it should be.

-- 
Best regards,
Dmitry
