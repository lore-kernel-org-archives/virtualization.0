Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEB562B9BC;
	Fri, 24 Jan 2025 23:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737761688; cv=pass; b=lx8cLKCKtAFvN4ubkEFUouSXmX2S0pAusT0fVK80IfogOJibEVQyCmoncmaieoDcXw1ugeUMR71QkcxcnDjio56KqMdVOw54aQwDkWAm5Cts+ah8Uzg/NzuHGfHNJrRxJhiYTQAoy01EfSV0n7j8GeXjcOVD4b+ziCf/BCcEwiw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737761688; c=relaxed/simple;
	bh=342u/g6UlRf/JfMygBMrVVXYE3nO+ym1nwKrWu/YzQM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EJVG5DjjAzv+/H+A1dZhDXhedqdCkaAHLHgeWT0QEoLNfg+tJQsPQQbmHGnN2E197e0pZdZtaiO6LcjBszuNWCnjTNp+Bo1OS5/WKJbGlqhLik5uVXynPCkePD/RPB1jE37n30izuvq/IiFrqyM2KeuuPAZBHzFEbD4w0aDaxRo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b=GjDtjGlI; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b="GjDtjGlI"
ARC-Seal: i=1; a=rsa-sha256; t=1737761679; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=HC8laApkiQIv9c5nn8RyDLpTuNgM9uUk1V5ELoYvFi4noJW/HH8+hpWi0ZqtWNHI9tYlmzQORFXIioRkksY8GSQR7QVVErXCfDuhbMQbO5+9PscmzDkTH8jSeq/w8DCvJzRR2NpRJXrKXgDMHY1JFdHdCZ0vDdWTjTpL6pQEvk4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1737761679; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=lmgx5CgLHXPGRAIUPh1HNEJgkKltCBb8w5mud1sWVZY=; 
	b=cZrGnkqwe8VUoWxeX5ILq/D2qC5Mf2ZqUPEgmDQkyRbiHqPFiRT2GcVV2FmqZpvetyFyu/zsAaJ/03AGOYJx7i9NTrjAscgXYpTpzuXkn4CoTa94R671Ptfh3XEPOTBgi8vozYrMpSFpg3O5EJfUkKvb8gfirywZOqer4tfaTGQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
	dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1737761679;
	s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=lmgx5CgLHXPGRAIUPh1HNEJgkKltCBb8w5mud1sWVZY=;
	b=GjDtjGlIjKMVHtswNtpynb7jNALUleYrZcMsn7XceGNywO//AqSWYFRI5yxERGIa
	4VLS8+qUriyhaSlB7Q5VlxpjAAUlkMTERoauBXQeDZbixj+Axxn1cH5nhgGP9EGt8Bj
	bMEuV1a8kYs2pxE/IsANrieB/eH8iK8oNKSiuM5Q=
Received: by mx.zohomail.com with SMTPS id 1737761674301215.19811850842348;
	Fri, 24 Jan 2025 15:34:34 -0800 (PST)
Message-ID: <60b0bd4e-fcc3-470e-8294-4000731d6b6a@collabora.com>
Date: Sat, 25 Jan 2025 02:34:28 +0300
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND] drm/virtio: Align host mapping request to maximum
 platform page size
To: Sasha Finkelstein <fnkl.kernel@gmail.com>
Cc: David Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu
 <olvaffe@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Simona Vetter <simona@ffwll.ch>, Sergio Lopez <slp@redhat.com>,
 Rob Clark <robdclark@gmail.com>, dri-devel@lists.freedesktop.org,
 virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
 asahi@lists.linux.dev
References: <20250124-virtgpu-mixed-page-size-v1-1-480403790bac@gmail.com>
 <a55eecdc-76cc-432e-a4b3-90e8753088ac@collabora.com>
 <CAMT+MTSHi26NduO4+2hc-CPwRXQ6qJ0=DwZq=4Tt1vNd7RKyvQ@mail.gmail.com>
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Content-Language: en-US
In-Reply-To: <CAMT+MTSHi26NduO4+2hc-CPwRXQ6qJ0=DwZq=4Tt1vNd7RKyvQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

On 1/25/25 01:58, Sasha Finkelstein wrote:
> On Fri, 24 Jan 2025 at 23:52, Dmitry Osipenko
> <dmitry.osipenko@collabora.com> wrote:
>>> -     ret = drm_mm_insert_node(&vgdev->host_visible_mm, &vram->vram_node,
>>> -                              bo->base.base.size);
>>> +     ret = drm_mm_insert_node_generic(&vgdev->host_visible_mm, &vram->vram_node,
>>> +                                      bo->base.base.size, MAX_PAGE_SIZE, 0, 0);
>>
>> This change only reserves extra space in the memory allocator, but
>> doesn't change actual size of allocated BO. Instead, you likely need to
>> replace all ALIGN(size, PAGE_SIZE) occurrences in the driver code with
>> ALIGN(args->size, MAX_PAGE_SIZE)
> 
> This approach is good enough for my usecase, where the vmm can
> cope with sub-page gpu allocations (by rounding up to full page),
> but can't deal with non page aligned ones.

Driver should work properly with any VMM. Aligning BO size will work
universally, but then you could do it too in a userspace.

-- 
Best regards,
Dmitry
