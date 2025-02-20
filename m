Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3AC21D88BE
	for <virtualization@lists.linux.dev>; Thu, 20 Feb 2025 03:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740021631; cv=pass; b=fBvoJsSxM43jUU7qpjDt6wbWMBzQJi/RfYQb+1NUGSP522lQ9ZFSZYKXJmhg7qUK1rLRfWO/wZ4/Www/fIca9tGGRDDR9qSIpWCZsxnDwR+jybENAv3CLmPBZb9pXtk16cqJuYw6s1oQ+LnB/p95HjYeZd5ZfpjiyfdmkAl8zEs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740021631; c=relaxed/simple;
	bh=FFRqQD38fqHqNNra69YMR0ZnN6Yry8+yeUHE07ibhpE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Hr9pR2ddzxII0r9VEzFCw7sbl0Pyw0Kkl/KjVHTNG7+6bvuOmnShEDYZiVVF0ep2nmR+Dl06Fj5i8Q6WQDEn/O5USPegndOkYBTdkIvbCiQCNrVJlVEmX/nYgc/QI38jt/5HSxkLdfXgbGI41aWIMXVG+RYDpYEjxznck9bK/Uw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b=Td0u68vs; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b="Td0u68vs"
ARC-Seal: i=1; a=rsa-sha256; t=1740021622; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=n5Hb6jI2YOgJvoMOM5AWZuWfhIARag7BXle+ouX0gV5c6s51QOVvsw3NtDIsCUchYAHjQFel8rTKqYn3QLRVfKENIl48sp/BlQ9JTT4Y0U3iRehjoZPP+VfSglEBa9AU9H83jPpfKk/yyXcg0YP74XQChTd+7CCrhKHBej1rl3Y=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1740021622; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=goELxg5KRmIAVFiFo0WsH6I8YxpNZKoXy3YbksbDQ5Q=; 
	b=chzILRRNTBRD5OlJP++5hnxNeiLgiK2ci+77QBz+S7LC73NVuJwAkpeUK7nTQgmg7sRaqrsKDVNZYksvyMcKBmfqvo63GpZ+ub//mRFd3xQIn32dJ2DqJ9aV0sIEejuy09qwaLFykOCPhjBSskTONO3qfNnTq2hZDRztTbGtf5g=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
	dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1740021622;
	s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=goELxg5KRmIAVFiFo0WsH6I8YxpNZKoXy3YbksbDQ5Q=;
	b=Td0u68vsLAKi/a2k0vTvbI3wCZO97WtRkuQMBG5u46ytyqT0OMcsqLR7WtrNEI9/
	AP1r7MgliczWKsJ2ZsXvqLuiwbqYrfOH9qZ1GgcC6mmGDIpg1gRtrADszhkCt+CCV4B
	mmHCq2oqfNEYe53OGEtgBTW953lSrKsEy2lxE/Ao=
Received: by mx.zohomail.com with SMTPS id 1740021619797826.5630263636273;
	Wed, 19 Feb 2025 19:20:19 -0800 (PST)
Message-ID: <1f9a86a5-97d6-41d5-9a30-0422fc9ec137@collabora.com>
Date: Thu, 20 Feb 2025 06:20:13 +0300
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 4/5] virtio-mmio: read shm region page size
To: Sergio Lopez <slp@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Daniel Verkamp <dverkamp@chromium.org>, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, David Airlie <airlied@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu
 <olvaffe@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Simona Vetter <simona@ffwll.ch>, Rob Clark <robdclark@gmail.com>,
 fnkl.kernel@gmail.com
Cc: virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org
References: <20250214-virtio-shm-page-size-v2-0-aa1619e6908b@redhat.com>
 <20250214-virtio-shm-page-size-v2-4-aa1619e6908b@redhat.com>
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Content-Language: en-US
In-Reply-To: <20250214-virtio-shm-page-size-v2-4-aa1619e6908b@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

On 2/14/25 18:16, Sergio Lopez wrote:
> Use the newly introduced SHM_PAGE_SHIFT register to read the page shift
> for the shared memory region, derive the page size from it and store the
> resulting value into virtio_shm_region.
> 
> Signed-off-by: Sergio Lopez <slp@redhat.com>
> ---
>  drivers/virtio/virtio_mmio.c     | 11 ++++++++++-
>  include/uapi/linux/virtio_mmio.h |  3 +++
>  2 files changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
> index 1f594b626d7a7734e8ec58766737a118c26bad94..0f892770739ea84b3e7be5615332773049b10ab1 100644
> --- a/drivers/virtio/virtio_mmio.c
> +++ b/drivers/virtio/virtio_mmio.c
> @@ -537,6 +537,7 @@ static bool vm_get_shm_region(struct virtio_device *vdev,
>  			      struct virtio_shm_region *region, u8 id)
>  {
>  	struct virtio_mmio_device *vm_dev = to_virtio_mmio_device(vdev);
> +	u8 page_shift = 0;
>  	u64 len, addr;
>  
>  	/* Select the region we're interested in */
> @@ -560,7 +561,15 @@ static bool vm_get_shm_region(struct virtio_device *vdev,
>  
>  	region->addr = addr;
>  
> -	region->page_size = 4096;
> +	/* If supported by the device transport, read the region page size.
> +	 * The page_shift variable is initialized to zero above, so if this
> +	 * feature isn't supported it will result in a page_size of 4096, a
> +	 * default safe value.
> +	 */
> +	if (__virtio_test_bit(vdev, VIRTIO_F_SHM_PAGE_SIZE))
> +		page_shift = (u8) readl(vm_dev->base + VIRTIO_MMIO_SHM_PAGE_SHIFT);
> +
> +	region->page_size = 1 << (page_shift + 12);
>  
>  	return true;
>  }
> diff --git a/include/uapi/linux/virtio_mmio.h b/include/uapi/linux/virtio_mmio.h
> index 0650f91bea6c70f935764070d825d181a2379afb..43348be30eff90ee228b6490b9d3c35ba4c50aa5 100644
> --- a/include/uapi/linux/virtio_mmio.h
> +++ b/include/uapi/linux/virtio_mmio.h
> @@ -133,6 +133,9 @@
>  #define VIRTIO_MMIO_SHM_BASE_LOW        0x0b8
>  #define VIRTIO_MMIO_SHM_BASE_HIGH       0x0bc
>  
> +/* Shared memory region page shift */
> +#define VIRTIO_MMIO_SHM_PAGE_SHIFT      0x0c4

What's the logic behind choosing 0x0c4, why not 0x0c0?

-- 
Best regards,
Dmitry
