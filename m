Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D38419995B
	for <virtualization@lists.linux.dev>; Mon,  2 Dec 2024 17:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733159998; cv=none; b=uHD0ynkcNMYBaRoXOISYQNvin0BG18epT6Fi7xE0djqyPwtunVLl8tYmYPWOkvg2ncPYo4vScv5Rev1kWWr8n/ZslkKqECf6NEtltUNLW95mCiyXajhyjd/VcFh5Vg9BPzztZQ9+rQ7QPixuZE6WhSF/F9Em8swt1McvFHObqv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733159998; c=relaxed/simple;
	bh=hVlnEEYy3yDi00u82Ouy/7ev7XcY9fPHePYgTs0AyJk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LPyZLGtEzh91dDgEQwp/4L4zL7FLv8PEy8SxvJlNRmrr0V0aplp6wnwz7Mge2d06UX/ByliJ0swprD2JZuujjYNzi6TxQRNrkeKjchTl99novFeLvXRmnVJ/9alQ5O6GAG2OPX1yyw8po8lqX+j2le7shEgvcULlbO2uKNV3FH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KoCB6DR0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KoCB6DR0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733159995;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WOfr91+KiLZkCa9xiK0L/FZ2M5u6/xclChDT0RYiwkk=;
	b=KoCB6DR0nYog5Ax5wa2wQEhucXKO2/lyhOlSMaJjByQRQqWtFKvDvR066XBIpMf3i6k/pI
	Ui4nTwhqH0mY6l7TgT+KCmVVPRPPvJL0420CHb3tCdpxsPK+Em/aUyoF9MOI+wR4iWDFqh
	TNnKdufpwlYKXae9VWNmUfDoqUaATLA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-455-XcmU-3hpOPyLUIguENrtOg-1; Mon, 02 Dec 2024 12:19:54 -0500
X-MC-Unique: XcmU-3hpOPyLUIguENrtOg-1
X-Mimecast-MFC-AGG-ID: XcmU-3hpOPyLUIguENrtOg
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4349d895ef8so43300605e9.0
        for <virtualization@lists.linux.dev>; Mon, 02 Dec 2024 09:19:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733159992; x=1733764792;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WOfr91+KiLZkCa9xiK0L/FZ2M5u6/xclChDT0RYiwkk=;
        b=cGrw7L/I4PK5TXrHUE/EXRGIxWV9USYjGKkPtWVqvQMuOd/4DklFY8OaRrNAX0pAw1
         3Lr0WkjBWe/JzFH3rlwQc9ErmUl7fkZaX6JumscTrKhsOzjbTB10qp3RyurxU17qXSla
         mW7ESNCXRcsXvC/b1o/MXZ14cWxzyNqgAhUB9BEKzLyTrXzT4x9Dgnn3lIqxyCfxtva/
         pqBTIP0qK5KivUm6LRoP3cCn9/BOb0XfBXChv0sK0p672nCg3e34WeSMR49k2pDdndz6
         pD53Y0AjPH05VPLP45WPuiCFGD2gJDKYPNk7taiIhLgDFz2LPamtEMfFeXtd0vzz0ahA
         IfkQ==
X-Gm-Message-State: AOJu0YwCTnk51kLnDvmCzqOskgeyOU7wwt5MA03LfGumVfEaVecLnuTI
	wO4S242BZbEOCxQVn9BjJO4t3h4bwL2hdxrDl+PilyprZnwIctLDAoqVjt2o0hr1Ib7ZUcGg1me
	gfYDZYQqAOIHXt89Vt/j/rvzIdsrQCUJt2b+ty8XT5iokNi+Zj3vOepw+6IY74+xUAgXKBTwI
X-Gm-Gg: ASbGncvfKQY6htoig4YBdr4dbTRs41zEUFrivevzb233xaNwp7V3rzw8WuLYvW1t0uj
	2nveIfXF4WE/N2U2ng6Nhh3eXRu10Q2gEhXPIERFM/O6wyVTa4F8BfpkjYOmmcN6zA8gINKQ0G6
	0lPrhoTFrvbZezTbVpGHYWa7JweglIgER+gXNYHgEMTH5jnNX4HeUGlfRjJV6+C5iP0b26RyygM
	p0vqTTsqlHu/66GUZDIicO+QZNxxiXLaQqifhHqd1psatW4Z1Qlii+hzFtC0tIrlu1zHmaDRlqw
	I9zyYPOg21N9rg==
X-Received: by 2002:a05:6000:683:b0:385:f1ac:3ac9 with SMTP id ffacd0b85a97d-385f1ac3d18mr6152849f8f.17.1733159992492;
        Mon, 02 Dec 2024 09:19:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGG85WlZO/QBaGMCugoF9sYm8aSKqDaJ5QSq+jZSb+fyCDanlsNLsHP9JFWpNh2ca7HuW9w2g==
X-Received: by 2002:a05:6000:683:b0:385:f1ac:3ac9 with SMTP id ffacd0b85a97d-385f1ac3d18mr6152813f8f.17.1733159992095;
        Mon, 02 Dec 2024 09:19:52 -0800 (PST)
Received: from ?IPV6:2a01:e0a:c:37e0:ced3:55bd:f454:e722? ([2a01:e0a:c:37e0:ced3:55bd:f454:e722])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385ec6a3d8fsm5375947f8f.101.2024.12.02.09.19.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Dec 2024 09:19:51 -0800 (PST)
Message-ID: <a0fc9b8c-e86d-46a2-a1d2-5ce8793ad2a5@redhat.com>
Date: Mon, 2 Dec 2024 18:19:50 +0100
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] drm/virtio: Add drm_panic support
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Ryosuke Yasuoka <ryasuoka@redhat.com>, airlied@redhat.com,
 kraxel@redhat.com, maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, daniel@ffwll.ch, christophe.jaillet@wanadoo.fr
Cc: virtualization@lists.linux.dev, spice-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20241129122408.4167150-1-ryasuoka@redhat.com>
 <be01d2f7-8423-4e10-b65b-a84a7bc7c99e@collabora.com>
 <3ca0382c-a410-4424-a5a4-7c1b8be7ebed@collabora.com>
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <3ca0382c-a410-4424-a5a4-7c1b8be7ebed@collabora.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 2aMF4f9EceHttscpIk0MGdcn1QDCf7dAKnH7pX-_qDI_1733159993
X-Mimecast-Originator: redhat.com
Content-Language: en-US, fr
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 02/12/2024 17:19, Dmitry Osipenko wrote:
> On 12/2/24 17:29, Dmitry Osipenko wrote:
>> On 11/29/24 15:24, Ryosuke Yasuoka wrote:
>> ....
>>> +static int virtio_drm_get_scanout_buffer(struct drm_plane *plane,
>>> +					 struct drm_scanout_buffer *sb)
>>> +{
>>> +	struct virtio_gpu_object *bo;
>>> +
>>> +	if (!plane->state || !plane->state->fb || !plane->state->visible)
>>> +		return -ENODEV;
>>> +
>>> +	bo = gem_to_virtio_gpu_obj(plane->state->fb->obj[0]);
>>> +	if (virtio_gpu_is_vram(bo))
>>> +		return -ENODEV;
>>
>> VirtIO-GPU now supports importing external dmabufs, we should reject
>> bo->base.base.import_attach here now too.
>>
>>> +
>>> +	/* try to vmap it if possible */
>>> +	if (!bo->base.vaddr) {
>>> +		int ret;
>>> +
>>> +		ret = drm_gem_shmem_vmap(&bo->base, &sb->map[0]);
>>> +		if (ret)
>>> +			return ret;
>>
>> I've now noticed that drm_gem_shmem_vmap() expects BO reservation lock
>> to be held and we can't take lock it at a panic time.
>>
>> https://elixir.bootlin.com/linux/v6.12.1/source/drivers/gpu/drm/drm_gem_shmem_helper.c#L330
>>
>> This resv warning isn't triggered because bo->base.vaddr is set for VT
>> framebufffer BO when panic happens.

I usually test using gnome desktop in the VM, and in this case vaddr is 
not set, and calling vmap() is needed. (and I don't get the warning, I 
will check why).
>>
>> We actually should reject all BOs that don't have bo->base.vaddr set at
>> the panic time. Please correct it in v6 and rebase on top of a recent
>> drm-next tree.

The lock is there to prevent race conditions between concurrent tasks. 
In the panic handler, no other tasks can run in parallel. Also the 
buffer object is the one currently displayed, so it can't be in the 
middle of a free/resize or move operation. So I think it's safe to call 
vmap() from the panic handler.

> 
> Think ideally we need to have a pre-allocated and pre-mapped BO. Then
> when panic happens, use that BO and tell host to display it, i.e. not to
> reuse currently displayed BO. This will make panic display work in all
> conditions. WDYT?
> 

This means a full framebuffer will be allocated only for the panic use 
case. For GPU with a small amount of VRAM, it's not possible. But 
virtio-gpu is a bit special as it uses system RAM, so it might be less 
problematic to do that.

An alternate solution would be to make sure the framebuffer is vmapped 
(at least if it's shmem) so the panic handler won't need to call vmap().

Best regards,

-- 

Jocelyn



-- 

Jocelyn

