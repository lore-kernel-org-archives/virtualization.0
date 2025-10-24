Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B3AE2BE644
	for <virtualization@lists.linux.dev>; Fri, 24 Oct 2025 13:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761311827; cv=none; b=Ae/zZ6caUITSY7RgWyMhNF3CDVjlp0XQBWF1cMgqo7hMx9IMrze7tVULbApbdLKc/hxIJ0s1rG6ErCNOpb7FisSbBXjrL9b/YKjS9GiRkB8GcS/DGBvXxeO49hfmvJNPiw5WwI5yPbAFnzEIxFEJJRQP/6fRwpQgJ9LrWSz/FhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761311827; c=relaxed/simple;
	bh=sDhn+dfEREtgN8xa7ihXq8cPV4C90ui+W6JU93cgYig=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QGNMt6yvJuZRl0IBS90WVZgM+g726uvK7LCjgvrRMXVprlaEpZzBxr32pfvv5ciglbD39K4TJ2v+Br+34ezVqE0xiMMCHEVmROXejNSKy51SDUiXPCp0AShFRSXOHN6nklDB/eyMe6KzMDsLascZaIIK9NJoHKhtb0ytzMkTvi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P109evmv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P109evmv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761311824;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ge4wmUcXTfZNuOeMfkfVL7HYbqF4GOnhAVQLb4Z8TRQ=;
	b=P109evmvxdI/Uxf8yeObR92ZAM7nRCr8/Jzp1Rm4Hm/jlrg/UZpPqC9sm7Hul24ZKsPnHH
	rLE8lVL9EkkdHjYArRUYhcVSZJ2mG7DI8OIefJvdCNdJFF+J/zzScI/R15Tap4wRMxZ0EG
	6BtCzAOl9FdJH/asq83Oo1bBgWR898k=
Received: from mail-yx1-f69.google.com (mail-yx1-f69.google.com
 [74.125.224.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-279-knqWZW7POGSeot-Y7uEoRQ-1; Fri, 24 Oct 2025 09:17:03 -0400
X-MC-Unique: knqWZW7POGSeot-Y7uEoRQ-1
X-Mimecast-MFC-AGG-ID: knqWZW7POGSeot-Y7uEoRQ_1761311823
Received: by mail-yx1-f69.google.com with SMTP id 956f58d0204a3-63e13b766dbso2510088d50.0
        for <virtualization@lists.linux.dev>; Fri, 24 Oct 2025 06:17:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761311823; x=1761916623;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ge4wmUcXTfZNuOeMfkfVL7HYbqF4GOnhAVQLb4Z8TRQ=;
        b=ZtdNtyF+8R+YA+fEW3cpe1MtldZG0mJQxo8rTsTuSlh9B6+gUg78v3sMTShCoT/RNO
         YK1JxfkRc4DogtiVDsk/oNFOvDbPLPnuRCAA04FlJs4JjlThFESCE9BmnwXaHBkIY1nW
         EpbXhkZARf5hDKFAVafEZqJhACVDpXIDiDUt35l9THrU22DKBN6aosqWKquV4OPOJh/u
         wl44vRpiyN52U9Eq1eJzw09/stWCGzenwtgVmLbUDiKFiZYOIIef6b0p9m6A2xT///xh
         VO2GGAMyUMAEzuMDHkh/CUxRReMxlkjuQBYavgiuNDt9ptk3hqZolD6tWhc+oS+ZmY2T
         KxOw==
X-Forwarded-Encrypted: i=1; AJvYcCXnu4tN156FEROjzvxhVBzfkf0lFTQHnCIJQaQAui7EysXEmS5EtiDtlCeH3MOgZMnHxCxooivsH9EJV5+ycA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxduOfO/9RLaEMaoan/ey/SdSj5/+NrYcClNmnzSAu4a995so91
	rtmz/7gVvAG5HGdi12twMuaJc9AbMWeIGUqAoswMpNPtBOl0rPeK9PE05PmDe8OC11A2/L7OdUa
	AbgATGnNuKCGrCLdhx7NAngQ1D177z/C2nP0kfSQ58GjAwJwZa+HqK9GDTbnu1Z1ynSgLsT1cpu
	Y4n9wG/BoAwyEu9CufdlyAhmzwzvLBc+BC8yM9sLOx7hk=
X-Gm-Gg: ASbGncsMPBXExzhgJxrPet+FOTSo24gCPzBAGCRU8kcSnGJpnKXmTd8se1GZp1Ac1GJ
	KIAePEbcb9mLQi8uwHPe0yfYDA2rL9tvZeawPw5n1eLWHeZbatIOjcCOLipyj8kn1ndgw2w5NB1
	7Nt1ibOf2iNfQgLeJmip0mSb9W2AWRoTafs7SzbXtcElsCjXdcWk4Klg==
X-Received: by 2002:a05:690c:d84:b0:785:cbf4:72cd with SMTP id 00721157ae682-785e006d977mr19286947b3.3.1761311821269;
        Fri, 24 Oct 2025 06:17:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFw2pHpFwqrLR0jLivutX2xPOBZG6CgaJ2Z66kijd60YMdU40Jwv9xsb6JC8+9xUIZbekki8LE+Qe/CRsRCIP4=
X-Received: by 2002:a05:690c:d84:b0:785:cbf4:72cd with SMTP id
 00721157ae682-785e006d977mr19286637b3.3.1761311820805; Fri, 24 Oct 2025
 06:17:00 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 24 Oct 2025 06:16:59 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 24 Oct 2025 06:16:59 -0700
From: Sergio Lopez Pascual <slp@redhat.com>
In-Reply-To: <9aa46e0e-5a10-47d5-815f-8e97d42fff94@collabora.com>
References: <20250402-virtio-gpu-host-page-size-v2-0-0afdc8c16cb9@redhat.com> <9aa46e0e-5a10-47d5-815f-8e97d42fff94@collabora.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Date: Fri, 24 Oct 2025 06:16:59 -0700
X-Gm-Features: AS18NWCQd2MYruc2pY3CEbkCOWeEH2LhMemjFsj6NKnUIFE35JvS0VbBWCc5og8
Message-ID: <CAAiTLFWCjKYSU1YaQHj1D5Xaj2e+P2OqUVt1NZQNkrHG+ypcXw@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] drm/virtio: introduce the HOST_PAGE_SIZE feature
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>, David Airlie <airlied@redhat.com>, 
	Gerd Hoffmann <kraxel@redhat.com>, Gurchetan Singh <gurchetansingh@chromium.org>, 
	Chia-I Wu <olvaffe@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	Simona Vetter <simona@ffwll.ch>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Rob Clark <robdclark@gmail.com>
Cc: dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: c3xDB7WaJBBsWAeOEAen-30e9U1VdTlbrATcjsaGerY_1761311823
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"

Dmitry Osipenko <dmitry.osipenko@collabora.com> writes:

> On 4/2/25 20:45, Sergio Lopez wrote:
>> There's an incresing number of machines supporting multiple page sizes
>> and on these machines the host and a guest can be running, each one,
>> with a different page size.
>>
>> For what pertains to virtio-gpu, this is not a problem if the page size
>> of the guest happens to be bigger or equal than the host, but will
>> potentially lead to failures in memory allocations and/or mappings
>> otherwise.
>>
>> To improve this situation, we introduce here the HOST_PAGE_SIZE feature.
>> This feature indicates that the host has an extended virtio_gpu_config
>> structure that include it's own page size a new field.
>>
>> On the second commit, we also add a new param that can be read with
>> VIRTGPU_GETPARAM by userspace applications running in the guest to
>> obtain the host's page size and find out the right alignment to be used
>> in shared memory allocations.
>>
>> There has been a discussion in virtio-comments about whether the
>> information about alignment restrictions must be shared in a generic or
>> in a device-specific way, favoring the latter:
>>
>> https://lore.kernel.org/virtio-comment/CY8PR12MB7195B5E575099CD9CA1F2F39DCAF2@CY8PR12MB7195.namprd12.prod.outlook.com/T/#t
>>
>> v2:
>>  - Rebase on top of current upstream.
>>  - Make a reference in the cover to the discussion about how device
>>    page alignment restrictions should be shared with the driver.
>>
>> Signed-off-by: Sergio Lopez <slp@redhat.com>
>> ---
>> Sergio Lopez (2):
>>       drm/virtio: introduce the HOST_PAGE_SIZE feature
>>       drm/virtio: add VIRTGPU_PARAM_HOST_PAGE_SIZE to params
>>
>>  drivers/gpu/drm/virtio/virtgpu_drv.c   |  1 +
>>  drivers/gpu/drm/virtio/virtgpu_drv.h   |  2 ++
>>  drivers/gpu/drm/virtio/virtgpu_ioctl.c |  5 +++++
>>  drivers/gpu/drm/virtio/virtgpu_kms.c   | 13 ++++++++++---
>>  include/uapi/drm/virtgpu_drm.h         |  1 +
>>  include/uapi/linux/virtio_gpu.h        |  5 +++++
>>  6 files changed, 24 insertions(+), 3 deletions(-)
>> ---
>> base-commit: acc4d5ff0b61eb1715c498b6536c38c1feb7f3c1
>> change-id: 20250402-virtio-gpu-host-page-size-282c99dfe44c
>>
>> Best regards,
>
> Hi Sergio,
>
> Curious if this feature still wanted. The protocol was updated many
> months ago with the VIRTIO_GPU_F_BLOB_ALIGNMENT addition.

Yes, we still need it to avoid having to carry downstream patches in
Mesa with a hack to hardcoded the alignment.

I'll prepare a new patch series (referencing this one) next week.

Thanks,
Sergio.

