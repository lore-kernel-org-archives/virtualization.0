Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD944340A72
	for <virtualization@lists.linux.dev>; Wed, 12 Nov 2025 16:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762966150; cv=none; b=EVG974GKHQRajXPY3aoI8FHrWbTE2guqPtgtXPE4GYZg3Cmo0UPCUHCVDOuFih46PM9aZl15uL+xicKwIgTalktWMRpUG+jq7/OlcbELOSCM3sB/nI53zd+1QQRE6HXS31OmFGOxR7w7lZP/VSNPU28bFsJ3HTf2RaGvI6IA2q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762966150; c=relaxed/simple;
	bh=yzJtWdMT1CSwYPtr1yZUG8pMMEoemT4XzUq0eUYhnQE=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=utUSO69Pj+bo459+YXcG3LOt5mf7n2J5L6RL4vN6gPtij2tgn7dY55q6/KKWscsutfqzFQzRocvN/U/RmDpYBOvO0nsygwuExg3HcsrV6b9wRHMWeNdKYpi2JvomgEQQPExywFvNPFrJSoVK2+4awFknhFGBIxUF9063syU1BKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NDmG2PYE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NDmG2PYE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762966147;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Vau743XOutCT7ZaDBV7vi7WPKrVykTyysCrhrB+GhO4=;
	b=NDmG2PYEAYZ2xZ7NA+bZvEJDjSxwW5nw8W9VJcLho9Auf0k5HQKsfdI1WV/rPIN2902X6X
	jSvKdkh5zqtWjm3ZYjYeu6DzPqQfj5kelgF1Vv75rogJlvuUmrol5iUZ7te5ncXFVVcUWw
	FXN/9ch+wjuyz3pIE1L8JGnB46v70iE=
Received: from mail-yx1-f71.google.com (mail-yx1-f71.google.com
 [74.125.224.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-455-7HR28tx0N3ClweOXJ9e5Vg-1; Wed, 12 Nov 2025 11:49:04 -0500
X-MC-Unique: 7HR28tx0N3ClweOXJ9e5Vg-1
X-Mimecast-MFC-AGG-ID: 7HR28tx0N3ClweOXJ9e5Vg_1762966143
Received: by mail-yx1-f71.google.com with SMTP id 956f58d0204a3-63e0c5c5faeso1511802d50.0
        for <virtualization@lists.linux.dev>; Wed, 12 Nov 2025 08:49:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762966143; x=1763570943;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vau743XOutCT7ZaDBV7vi7WPKrVykTyysCrhrB+GhO4=;
        b=EpHcOSfvnFL+cPZB0RmUnkFQXhrArRLZ/XtGew1Z7grjEmTNHHc+Lh6C0caHi9bKY5
         X6bZK+Ixsha+pjtFJHIogUfrdJvxezMS8vpXQ5gt7k4W5pAuvqMJDMt59pbmcP8hdCeS
         PmF4YRopxRbfkSrBvQtUgt0lxweHtKU+nmuIPBqaZ3ez7TQT5X0YrQXMUgAzwL6kGRVR
         Kh4IcgIUjSO27E1Zz/lN3o2VMUQBvQrMv7OFLtqdEHO7L30zHAQzkEcCIBLLlZ9XMYup
         /O/xItO5E9uue5bIESNiokWezqN0K51JcogEcGlIGGv2t7bfkTrL/RQKCB/54nC99/M+
         1nLA==
X-Forwarded-Encrypted: i=1; AJvYcCU0nuUu+l4vPEIIsp3RW7rS2NTkm0MPPDaaq6cMNNg1jR9OrR4Z0gVvPs243pg6PpbYEpPjWVocJ/aiLlvWUA==@lists.linux.dev
X-Gm-Message-State: AOJu0YykYz5kW73//yE/EhPetctT5LU4RxPNfPehqqFvNAU5625Tqrmj
	jktVLBKNvv9pylnhIQ/2L5QXU0IPOlXSyIilkY1f4DA9OpFYK+5JmnYL29rAFn2+bGoWlM0SgVg
	LnbRaEApZhEvwMYhFE0vkaqEnxj2pkZYsTX/b6b7Iqi0JYpJRy9XjbjPDAOosz2Dku36Lh1sXw4
	imjA8egFqsNtJztPJ4UnjbSDovHen5e2crUGpGP8CKoLI=
X-Gm-Gg: ASbGncsj0zOWtx3qmeeQV1si+aAGjmQdX5ucXl2T/B4jUc//JK4LS1d0Czj2LVV+bUj
	5pKj++8siFq1+DpZZ9X/CQIz9CLmoDjq9uemcXWpQkJ/HSZq4AAHlEhiPrdUQBJb/4evpj6B2Av
	UgtiluOwa1DoCNQTGBD7eGIOGTpEYin9TtxUOmfLiUxXZo9xZ11+TPWE3m6acCJ+7JrRy74T8zq
	Itwsewh3C/hhcj7Tw==
X-Received: by 2002:a05:690e:42c6:b0:63f:7da8:6b8f with SMTP id 956f58d0204a3-64101b3c87emr3056754d50.54.1762966143613;
        Wed, 12 Nov 2025 08:49:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGmvC2Azip+GS36nKybduxfa97rWHb0V9T2GYDrBXHG+e2gKAEKaLd+WmmO83FeDXeTSFKsNYVIue/h2ojcATo=
X-Received: by 2002:a05:690e:42c6:b0:63f:7da8:6b8f with SMTP id
 956f58d0204a3-64101b3c87emr3056733d50.54.1762966143267; Wed, 12 Nov 2025
 08:49:03 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 12 Nov 2025 08:49:01 -0800
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 12 Nov 2025 08:49:01 -0800
From: Sergio Lopez Pascual <slp@redhat.com>
In-Reply-To: <855ebbf1-0b02-45b5-8fa9-b50c05793e19@collabora.com>
References: <20251110125213.12633-1-slp@redhat.com> <20251110125213.12633-2-slp@redhat.com>
 <855ebbf1-0b02-45b5-8fa9-b50c05793e19@collabora.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Date: Wed, 12 Nov 2025 08:49:01 -0800
X-Gm-Features: AWmQ_blkfmU4xkkhUO-M_WcjqEKuzPzp8_FWp2cGDYKHwbAkWUXG2xTRkwnWvs4
Message-ID: <CAAiTLFUbJ-YpV8+05PofXpmgOu=gNmUh9L6xgj_w80_mf7z8Tw@mail.gmail.com>
Subject: Re: [PATCH 1/3] drm/virtio: support VIRTIO_GPU_F_BLOB_ALIGNMENT
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>, David Airlie <airlied@redhat.com>, 
	Gerd Hoffmann <kraxel@redhat.com>, Gurchetan Singh <gurchetansingh@chromium.org>, 
	Chia-I Wu <olvaffe@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	Simona Vetter <simona@ffwll.ch>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: olMWh76ZN8bi6vuUw1-pKji597oI6o5Qo8qiSH5QZEc_1762966143
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"

Dmitry Osipenko <dmitry.osipenko@collabora.com> writes:

> On 11/10/25 15:52, Sergio Lopez wrote:
>> +	if (virtio_has_feature(vgdev->vdev, VIRTIO_GPU_F_BLOB_ALIGNMENT)) {
>> +		vgdev->has_blob_alignment = true;
>> +		virtio_cread_le(vgdev->vdev, struct virtio_gpu_config,
>> +				blob_alignment, &blob_alignment);
>> +		vgdev->blob_alignment = blob_alignment;
>
> Shouldn't blob_alignment be max(guest_alignment, host_alignment)?

virtio_gpu_config is the minimum alignment required by the device/host.
If the guest requires a higher alignment than the device/host, I would
expect that to be found by a different mechanism, as it would happen on
gpu drivers other than virtio-gpu.

Sergio.

