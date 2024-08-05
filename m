Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 314501428E3
	for <virtualization@lists.linux.dev>; Mon,  5 Aug 2024 09:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722849256; cv=none; b=PKAmbXdAg3ZRf7lFNeAU/kANLf4HXfy4q4O6YlwQzFbaW7URE+ElAIz2FMqmfFjySaNZLiw7IfthTRcVU2d38iJsOcsQAbu1lczK54YUvw0z6gzIJIr16RRYyGJq+EvRXXk0ZJhT5mexZZmq7kbr30DiX7Jqrq4rycSZeUPZJ/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722849256; c=relaxed/simple;
	bh=cYEr12ESNSjKojO6NUh+zO4URzAONDoFGizHlfeb6CM=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g4Ch9tMo2Xna2pUWbYL01drOwkHza9FEGSNQKcIiSV/tG19ubJH+B1zN8kGBRha46eCC+nVZsSWiG7YmBfxWaytDsTLqb0HWE6zglkpK46Cs9QQLqVSGfgrG4LgPmP+/M13KeOjxowRCOJHFGx//9V0Leqth/Q+tUYhQkppXKh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WXFw5BtV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WXFw5BtV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722849253;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cYEr12ESNSjKojO6NUh+zO4URzAONDoFGizHlfeb6CM=;
	b=WXFw5BtViZwUqbc0+CS1qP5qd5eOmmRILvUR4BD7GPx2HfGt4QKyUL9i9KYpueYP4waX8H
	5aRt0udzZSnHmkIguWYS6STVzlhxzWqkx5EyIdNPzjOjffdkjuISDwnpvNvudT+yKBNOVH
	EEsTwi7SDW8PxDqFchSAzCiHcUJiZXs=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-227-h973fvPwNB2Jr5X_AsZK_g-1; Mon, 05 Aug 2024 05:14:11 -0400
X-MC-Unique: h973fvPwNB2Jr5X_AsZK_g-1
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-70e97ac260eso10039954b3a.2
        for <virtualization@lists.linux.dev>; Mon, 05 Aug 2024 02:14:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722849250; x=1723454050;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cYEr12ESNSjKojO6NUh+zO4URzAONDoFGizHlfeb6CM=;
        b=pVXjdjjLyuZ4lnV8FbfXqFyo8Z7s24WVoQDSHVr0YvMm9cfF6Hf7UDTyHLLtOL6OIG
         4qsQnphs7WG7q2lpKetNcDcWEassKM8ITcK6vEZKXkWhL9ZeXJyehtRSS91K3RaxQc7f
         8gtED7RJShY76UeU1bVTAI2NXP3bWrhzUXtFU/QRx0eX5su9zuOZ+yemC2FbIRu4TOQi
         PkfiFjkrkdKhxZn9GUqQQab7EIohgeD3wdMvziKsKfInqTVNSZfl8P7Xlk5OBv/JJDZ7
         XpWmEoz0tpfygT4tqb+V0hirk0Axz1Nuw6TLmshx53EMAMZYEAGmUJNTZKABem6Gj+Vs
         bhmw==
X-Forwarded-Encrypted: i=1; AJvYcCWGYx0gzZYoBW4L+s8HB6xNALYd8b1tokqkHP8B5gdeJU2tQ48F127TgNhGE3t5hSjEELjVglH9orPgohTYOYr7qjs2/C3U1kU6jtYs/Lo=
X-Gm-Message-State: AOJu0Yw8YUh+vZsZbeHkvDZgEM5VQyI77mJ6Z7AD2SedIMdfwd2/GsV4
	W1IecT1JCUw+mDZOg7J8F12MPNHtBiXxcDFOZ1G7yFcuKIYru/rG/oYJSD3asiFuJ/RGwSzpwqt
	Amgqe1H8QGcAZYxjwCt4Vj5M6lHBM/35jypNgdFJMTYmMRZF/gh9dxV/BFIo3xzF1GNBZ67+soP
	Lyi/lBSnZUzh0Sve4GEPEPndAdgYzii1pk+RP97Kw=
X-Received: by 2002:a05:6a20:d80d:b0:1c0:f5ea:d447 with SMTP id adf61e73a8af0-1c69959d1ecmr11272132637.31.1722849250574;
        Mon, 05 Aug 2024 02:14:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHHx+ra0bxEhW+9FV7kXYO0559BlpJINXNAHMKtXsFbYfAG4Tt3wh9BjFp2TlNFgdjgQOeIaX1M39gbMSBHCUQ=
X-Received: by 2002:a05:6a20:d80d:b0:1c0:f5ea:d447 with SMTP id
 adf61e73a8af0-1c69959d1ecmr11272112637.31.1722849250168; Mon, 05 Aug 2024
 02:14:10 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 5 Aug 2024 04:14:09 -0500
From: Sergio Lopez Pascual <slp@redhat.com>
In-Reply-To: <942afa37-a24c-48ed-ae10-c811849165bf@collabora.com>
References: <20240723114914.53677-1-slp@redhat.com> <942afa37-a24c-48ed-ae10-c811849165bf@collabora.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Date: Mon, 5 Aug 2024 04:14:09 -0500
Message-ID: <CAAiTLFV6mAgrMj=itcxoBCibvYRyrAk02wYp-gYJ8kxhF0EPmw@mail.gmail.com>
Subject: Re: [PATCH 0/2] drm/virtio: introduce the HOST_PAGE_SIZE feature
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>, gurchetansingh@chromium.org, 
	tzimmermann@suse.de, mripard@kernel.org, olvaffe@gmail.com, kraxel@redhat.com, 
	daniel@ffwll.ch, maarten.lankhorst@linux.intel.com, airlied@redhat.com
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux.dev, 
	dri-devel@lists.freedesktop.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"

Dmitry Osipenko <dmitry.osipenko@collabora.com> writes:

> On 7/23/24 14:49, Sergio Lopez wrote:
>> There's an incresing number of machines supporting multiple page sizes
>> and on these machines the host and a guest can be running, each one,
>> with a different page size.
>>
>> For what pertains to virtio-gpu, this is not a problem if the page size
>> of the guest happens to be bigger or equal than the host, but will
>> potentially lead to failures in memory allocations and/or mappings
>> otherwise.
>
> Please describe concrete problem you're trying to solve. Guest memory
> allocation consists of guest pages, I don't see how knowledge of host
> page size helps anything in userspace.
>
> I suspect you want this for host blobs, but then it should be
> virtio_gpu_vram_create() that should use max(host_page_sz,
> guest_page_size), AFAICT. It's kernel who is responsible for memory
> management, userspace can't be trusted for doing that.

Mesa's Vulkan/Venus uses CREATE_BLOB to request the host the creation
and mapping into the guest of device-backed memory and shmem regions.
The CREATE_BLOB ioctl doesn't update drm_virtgpu_resource_create->size,
so the guest kernel (and, as a consequence, the host kernel) can't
override the user's request.

I'd like Mesa's Vulkan/Venus in the guest to be able to obtain the host
page size to align the size of the CREATE_BLOB requests as required.

Thanks,
Sergio.

