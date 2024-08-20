Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 531A517BB7
	for <virtualization@lists.linux.dev>; Tue, 20 Aug 2024 14:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724164076; cv=none; b=qdDaf0D1ncbRvTkiz2piUShILEQOXZdwoi7RUhZb4yYL/hecIjVPXCeRIYNMkIuTJeDQ2kE4gq/+RBam5Xzpjioak7XtBT30lTbeY/l8nLTF2wSKC8sY/HwVU/SaKDS/FsjIT2s5exLy8BYlRacVM44Ly2kRRJLJSfYVjB03mFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724164076; c=relaxed/simple;
	bh=ud7WgUdQsTU0o/iKSERG5jnLd+ZxS35DomwyHljjrU4=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iZAmfK93rSjqlTIHbHprkmRd0kBfQcsPYIZhf+Qgs08qb7mdCDa1G0fNgO6SpG080StQv3UckHBt0bdJwUFHwcZDW2IdolecCAG+0mM+U4VzTBF5D66jsyrhV+1pFcbP21Y5M7Y1SAjMP8uvB447zRzQk6FGbQl5W1ri593qibo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FFbTZ6+z; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FFbTZ6+z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724164073;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ubk8Yb33ek9o28qQ4n8Su7NGdGoK0OIgkJPolUgXNBk=;
	b=FFbTZ6+zMiUwhUi6n/9fKLngWjFSUA2yel3XrnfKt67/sme9oh3UAk75Wekvq+vYE0ss2E
	8dxMsR8oM/bkWl6QlusHqpF5uLCPI2OU7kw09FmKMeEVN+RRK+bR89KHzrNDyA6xrHLnW0
	Rs6JGzbDepc7k8TcWQj+Ofxxa34YRIs=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-442-I8zcGTNdPUG73dtaqe2EqA-1; Tue, 20 Aug 2024 10:27:50 -0400
X-MC-Unique: I8zcGTNdPUG73dtaqe2EqA-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2d3c6b19444so5289221a91.2
        for <virtualization@lists.linux.dev>; Tue, 20 Aug 2024 07:27:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724164070; x=1724768870;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:to:from:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=x3ovf2iShaZ9qbPPkoSbbQpKOfxaHuRmMXoaahs1Ka0=;
        b=v1TpwmEabLqk4AlGegn9rVi7fXfQapVFK4ys51VhbQXmxw1Zu2zYTXJSbZPork+PUs
         /Zi9xKEFbsi+TOAeIzptXgUsQPdmMI71JVrGPqRAhhM4PMw91vCSFqKxfFYw0TWR0weJ
         88UjevohVorQ4o0Y4h2VRdGHUHHQQwlJO5C9cZhIER9BbFXbXu7cxXdpqRg+0RFO9WAp
         v9H4AsJY9UlC0FDQFdh738zQAJbqhgmXogyha4UYOVHzYaZeGd02gUUYm81RBjQrKaLn
         pNs/9M9afE5+TfXTIcuwgbxYyEzHiT305fHPpf5Or2AXy/lNW6IFKo4EOy78XhhyZBcM
         Yvag==
X-Forwarded-Encrypted: i=1; AJvYcCWL8q7Gxm9Mhhz5/xsuXeAlRMy3EgYSrgPcOGi9EpROHXqSymKNXupy3eSA+zokka5F6+EKm832O5Z2VC3HYTsAWg/chO2GWSv0XPDDeW0=
X-Gm-Message-State: AOJu0YzgEMNMkeMLPPngkhH+GfwZQ+Lo80Qcs4BUtrB8YIQaoGZ1JpfC
	4mE/mw5eA9MPlN26SnKK9ttdURZ16aQUTQhyftOwn7xrnQqGdbOICfGmMumAPdg5suOvPVcvFxe
	k4k7xQWhNWCcTsKNta1b0i+uamscwdSJMkIUa8xog9vVV1UU+JdEw1qcBNB/8uPZ/
X-Received: by 2002:a17:90a:d50a:b0:2c9:69cc:3a6f with SMTP id 98e67ed59e1d1-2d3e00ebf73mr13052237a91.31.1724164069917;
        Tue, 20 Aug 2024 07:27:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHypeLeTNx3e7ttHvILw7VadgW74FuCGTQOH1UI/v7taOrjRzD7/mgP3FVnPfvZk5PmxOkWCA==
X-Received: by 2002:a17:90a:d50a:b0:2c9:69cc:3a6f with SMTP id 98e67ed59e1d1-2d3e00ebf73mr13052205a91.31.1724164069457;
        Tue, 20 Aug 2024 07:27:49 -0700 (PDT)
Received: from localhost ([181.120.144.238])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d418e7b76csm6684852a91.2.2024.08.20.07.27.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 07:27:49 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Jocelyn Falempe <jfalempe@redhat.com>, Thomas Zimmermann
 <tzimmermann@suse.de>, David Airlie <airlied@redhat.com>, Gerd Hoffmann
 <kraxel@redhat.com>, Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I
 Wu <olvaffe@gmail.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Daniel Vetter <daniel@ffwll.ch>, dri-devel@lists.freedesktop.org,
 virtualization@lists.linux.dev
Subject: Re: [PATCH v2 2/2] drm/virtio: Fix host color format for big endian
 guests
In-Reply-To: <ddd41844-1d3e-4755-9013-9ae4e751c501@redhat.com>
References: <20240820090908.151042-1-jfalempe@redhat.com>
 <20240820090908.151042-2-jfalempe@redhat.com>
 <efe083ed-b83b-45e8-a418-1861f535e31f@suse.de>
 <ddd41844-1d3e-4755-9013-9ae4e751c501@redhat.com>
Date: Tue, 20 Aug 2024 16:27:46 +0200
Message-ID: <87a5h79sm5.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jocelyn Falempe <jfalempe@redhat.com> writes:

> On 20/08/2024 14:48, Thomas Zimmermann wrote:
>> Hi
>>=20
>> Am 20.08.24 um 11:07 schrieb Jocelyn Falempe:
>>> The colors are inverted when testing a s390x VM on a s390x host.
>>> Changing the conversion from DRM_FORMAT -> VIRTIO_GPU_FORMAT on big
>>> endian guests fixes the colors. But it may break big-endian guest on
>>> little-endian host. In this case, the fix should be in qemu, because
>>> the host endianess is not known in the guest VM.
>>>
>>> Signed-off-by: Jocelyn Falempe <jfalempe@redhat.com>
>>> Acked-by: Javier Martinez Canillas <javierm@redhat.com>
>>> ---
>>> =C2=A0 drivers/gpu/drm/virtio/virtgpu_plane.c | 12 ++++++++++--
>>> =C2=A0 1 file changed, 10 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/virtio/virtgpu_plane.c=20
>>> b/drivers/gpu/drm/virtio/virtgpu_plane.c
>>> index 860b5757ec3fc..0ec6ecc96eb13 100644
>>> --- a/drivers/gpu/drm/virtio/virtgpu_plane.c
>>> +++ b/drivers/gpu/drm/virtio/virtgpu_plane.c
>>> @@ -37,16 +37,24 @@ static const uint32_t virtio_gpu_cursor_formats[] =
=3D {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 DRM_FORMAT_ARGB8888,
>>> =C2=A0 };
>>> +#ifdef __BIG_ENDIAN
>>> +#define VIRTIO_GPU_HOST_XRGB8888 VIRTIO_GPU_FORMAT_X8R8G8B8_UNORM
>>> +#define VIRTIO_GPU_HOST_ARGB8888 VIRTIO_GPU_FORMAT_A8R8G8B8_UNORM
>>> +#else
>>> +#define VIRTIO_GPU_HOST_XRGB8888 VIRTIO_GPU_FORMAT_B8G8R8X8_UNORM
>>> +#define VIRTIO_GPU_HOST_ARGB8888 VIRTIO_GPU_FORMAT_B8G8R8A8_UNORM
>>> +#endif
>>=20
>> As these defines are only used here, would it be beneficial to put the=
=20
>> __BIG_ENDIAN branch directly around the switch statement?
>
> That was my first version, but I found it difficult to read, when I mix=
=20
> #ifdef in a switch case.
>
>
> or maybe something like the following would be better ?
>
>
>   =09switch (drm_fourcc) {
> #ifdef _BIG_ENDIAN
>   =09case DRM_FORMAT_XRGB8888:
> =09=09format =3D VIRTIO_GPU_FORMAT_X8R8G8B8_UNORM;
>   =09=09break;
>   =09case DRM_FORMAT_ARGB8888:
> =09=09format =3D VIRTIO_GPU_FORMAT_A8R8G8B8_UNORM;
>   =09=09break;
> #else
>   =09case DRM_FORMAT_XRGB8888:
> =09=09format =3D VIRTIO_GPU_FORMAT_B8G8R8X8_UNORM;
>   =09=09break;
>   =09case DRM_FORMAT_ARGB8888:
> =09=09format =3D VIRTIO_GPU_FORMAT_B8G8R8A8_UNORM;
>   =09=09break;
> #endif

IMO your current patch is easier to read than having the ifdefery
in the switch statement.

--=20
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

