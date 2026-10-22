Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792691906;
	b=n1OTeOArY1tK2uAa0KRtKnyC3JEOU+K0h6vzOOiklNqLjuy3JkrlfMphMNLHOVxvNtox
	 EkAGhnqWLBF3rjDkMFV4Mf6bb7nbFkzxZcZZmdF5QnBLoefGYBU3bKNmV/wQdbfE+9N16
	 YT0CK5l8UtgvB1XzNAdmG5Ha72BQdfnQmpDEQIJIS9b7k7Co/5M1/+Z52DMfgkBqwFCbx
	 8RDq7DPNB89Nra6mmhIxPrjRyRb2ksxE3uL8cbf+OC6oTO6bfTHe9WqisjItQ28lbnlH9
	 DkzbmPr2ociBN1hzgMdjCIdY5OGzUDtpL/TwYPiaBIIuhIhCritVBbVkv3D81/B+pdQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792691906;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=gOxyJqweGrhnvnodtSAXe9yahnUU1PnlCf3PPg5Ekys=;
	b=JMeGoctQSQ+j7GHDFZ0BxnGBwjly4bYmv+pvA2tjemfAUhBuOnJr8t4VYcDJGczviIQr
	 O8DSW9LpNGC7ZMJIsTrP6KM2bLzMk8TcJyM7GKKRTnSJcD4ybomlhslbLpLsRJuqDuFZS
	 Xiu/D6JZP3BuPTIjVfN2o6yaJOSqk/y78AUY9XUdX1F4MR2jnvngDYksQMBIm1XsSp70G
	 Cv0Y7HxGwXVtTXVojPMfB5GSwUkMzv3/8dhpLUO+xMjWw8OswV8w9jwV9826WbtRspkF0
	 NtMuvmO+D9d+KJCy+vsFiEfaQ6TFZg/SaeKIKAnZZ1XHG4Gju1mK0jxC9WQ22r60s5w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=XUdEXCxi;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.52
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49DC3606A319
	for <virtualization@lists.linux.dev>; Thu, 22 Oct 2026 17:58:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 49DC3606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=XUdEXCxi
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-150ef97e790so970c88.1
        for <virtualization@lists.linux.dev>; Thu, 22 Oct 2026 10:58:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792691905; cv=none;
        d=google.com; s=arc-20260327;
        b=deZX6e5VYwfcXTrXPLIr8n3ZrHTEdgBgmPce7Kk8gQQoHccxu8oQNhmDlEFHXBmjwg
         MIpiIJcQ+7X9RVhcnuOiSFo6USOGk4k3bUWGYRiK2Mr/7B9d4UhiglYQ4766HIGOGVTp
         TyxiF4QSDe8bEOLS1Nih6sLFZWAxXsM8tjaFhQfpWcOI77uZj4WK/qALjvYYTpvyZ/1B
         4/pjneaTjLLvSz7irCYcKWgb+aLDGsTl/ukuef3pu2kNXP2I6oE+C+dr9jcB6wvknpbV
         ec7dUKcnObMw+VvG/4xbxBTXDHPcmMjliNq8mOuXres5vxESf4usHDwNBIE1skoR6lux
         xMLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gOxyJqweGrhnvnodtSAXe9yahnUU1PnlCf3PPg5Ekys=;
        fh=sTKw+b8iDsoQd9XFT1Ag8uQaQcXfRx8E6OvvbkX2jI0=;
        b=Yyj4R09+ComO4Jm6qf8yCVeWy+l+AUZtb4w/sXGJHDN05gSdQwgq+gKIrdSpKq5Hgt
         2pZeRyoHn32C/LDxyFKUzfL4BjqPX6cSujV3jK8XmNWRkuY2ZAJJJ2ogN/NgizH3vZf4
         fM8gipQ/FJiG05INdfRawAKcONyTE/FXZzXsrfDVkZYcc5f3/4BMW436G88SCY+hI3T8
         AQ0lfrRSuz8lizthGBA+zK2r8IOiVHbwholMvMN9qSTRhSy6jdLDXzthskXxkkrvbtrR
         TcMM4Iqr2S8MHyDpWgMXh3+J/k7gSXnPqPnlRKIWc3exZWLFQpoIBRN+b6aXSBQ7ebE/
         tN1Q==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792691905; x=1793296705; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gOxyJqweGrhnvnodtSAXe9yahnUU1PnlCf3PPg5Ekys=;
        b=XUdEXCxiPGydrJNDZOASJ3Nc+TsqsvoNtIUr6+LG5q4cVvyxPLUWNmBzFxOVu+zoW6
         /lssfCQM0654pOY/UuJJQ6hsTFNp+mFKAEibLhJS9WO6devQYX9nyy/RTYKUExJCI73f
         wGARqisyApfTImQFOTTGj3rM1ECsg7K8PKxJZKD9fT6zzKZl3Ww9kt/LvJNrjwX204JK
         i+dVWpF1U5lQET4inim+MNncQ+8Rnrd/gMDOc841Lg3alQW1FcYul0wCe43bcFDNDpxZ
         2bJ0GFVP2wK6upX288Ntn7gx22JryEqlVPa5x7MqssMrTHiyzHF9944ifUlFjab0sjrs
         ZV4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792691905; x=1793296705;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gOxyJqweGrhnvnodtSAXe9yahnUU1PnlCf3PPg5Ekys=;
        b=FRaZ50rAHxn/MxKfgmzhWTVmNd3EB/YNQHiPoRvMnQvTIKETnHvP6GW42lz3JlmQR7
         GSOGVFeoZfOIk2h4sebUtI7KHrUicr7JuaTLFaW3VqWh16+4xL5dJi9qUVvz54hrQgxj
         x4PyfFC4IYgKQrVvIMt2LmTnppzSTnUyqw96S/co2QSvNcFO8izK23I3AIudr82/uIk1
         6Wn2DWVbjzvnqlr0HC0ocoye0b3gffIeV7v/JPH+MBPQp+riDO+WjVVgMpENvzvvfpY2
         T+P9HTSFhNbHKDplV19gxTCr2s4SkCx5Eq8tErggoK6EE3QUuhVdwOFeggtHUwvYNQal
         4HIQ==
X-Forwarded-Encrypted: i=1; AKwUvBwvZU4PNrK9RNwg+PWiYRhieL/Gba/8EERyw/sOD1RBJBTTQzwXHOL7IOBx/UFw5v6reHWdPTvO3yJ8R7M4vg==@lists.linux.dev
X-Gm-Message-State: AFq9FYLgkpwz2U9l+DfjWlFKr1h9SWB8n/RRRZSI+eTotRiPmhrcevEh
	5UnR23D2gpBYl68Cib0jI/Whoo941eZOveZhVzmES3wVuE4sApK10vX66GFqUGVx6VaZkOFlv5g
	6MWyxflCSgFz0Fp3hmo7SiSMoElLHi2wZ0i1nNwM=
X-Gm-Gg: AYBFou0Q+XL6iCh9imdqnbwdPOrv2DlYEgfcGFYspOuUlJJk4Lr8DyhZettkOUS1Sh5
	wV8shEWswMXoqxmS8LVZvNgSGiH/ueIx/O5ffBfit0M3UrWh+iPaS+huJK/Oxoq7VaI4mqzwJHT
	ff+WwEEbZCihXFQuodfuCFZl8GijusCouEvO62ITbKLH4dv6R4AdsbBxLL+OpwasnH6OVnUMWaU
	jmxZdUUkS6rpl+ejlU8ZUDtRXh9+L+jnV8SX4SnrByQlG97oJPdkqpuOrrWWKz2SHpWaYC75EbP
	eRWUZPNhYSDiDij3+KgitrS1l1SnWAm0rXfPXVjFCly3/nXYNGjni4N7Jhx5gMUVEiDo5ZnKMmy
	/IcrIJ6/fQpKl2gZE7iNRDLGenraNZ3tLikN7zY1pX8BZ5mbIsL3TINthiAbTMjyYj/Oqw9NfJC
	mrjVYffRNHFisz6qKVil+unZY1mE+GF2lPFfLOaxyYG4yGY4yOvaCv
X-Received: by 2002:a05:701b:2085:10b0:192:ce56:4982 with SMTP id
 a92af1059eb24-195b384f21cmr17350c88.1.1792691893149; Thu, 22 Oct 2026
 10:58:13 -0700 (PDT)
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261006154913.2689067-2-val@invisiblethingslab.com>
 <8b0fbe1a-1410-42d7-8031-611795ae39d9@collabora.com> <4d86ec37-ce27-4556-966e-4b4e80ec0718@invisiblethingslab.com>
 <f717bc84-57f4-4001-a15b-fcdca67bb9b4@collabora.com> <6c0f26af-e363-46b8-b3b9-8d3910297dc0@collabora.com>
In-Reply-To: <6c0f26af-e363-46b8-b3b9-8d3910297dc0@collabora.com>
From: Yiwei Zhang <zzyiwei@google.com>
Date: Thu, 22 Oct 2026 10:58:01 -0700
X-Gm-Features: AclHuK8zrBSyPW0ecQ4Wi5vbzBHjWnhi_xIgMiJLjDz9C3zXcHZS3t6jUqqUQ44
Message-ID: <CAKT=dDmEf3McX50KYxmLDb-oeuYWMBSnkcGGSEfi_PO4pD6qjA@mail.gmail.com>
Subject: Re: [PATCH v2] drm/virtio: do not enforce blob_alignment in
 cross-domain contexts
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: Val Packett <val@invisiblethingslab.com>, David Airlie <airlied@redhat.com>, 
	Gerd Hoffmann <kraxel@redhat.com>, Gurchetan Singh <gurchetansingh@chromium.org>, 
	Chia-I Wu <olvaffe@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	Simona Vetter <simona@ffwll.ch>, Sergio Lopez <slp@redhat.com>, Yiwei Zhang <zzyiwei@chromium.org>, 
	Ryan Neph <ryanneph@chromium.org>, dri-devel@lists.freedesktop.org, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 14, 2026 at 2:02=E2=80=AFPM Dmitry Osipenko
<dmitry.osipenko@collabora.com> wrote:
>
> On 10/10/26 22:40, Dmitry Osipenko wrote:
> > On 10/8/26 23:59, Val Packett wrote:
> >>
> >> On 10/8/26 4:33 AM, Dmitry Osipenko wrote:
> >>> On 10/6/26 18:42, Val Packett wrote:
> >>>> VIRTIO_GPU_F_BLOB_ALIGNMENT is designed for GPU rendering context ty=
pes,
> >>>> however VIRTIO_GPU_CAPSET_CROSS_DOMAIN is not one of those. Resource=
s
> >>>> created under cross-domain contexts are arbitrary shared system memo=
ry
> >>>> files, which includes unusual things like Wayland keymaps received
> >>>> from the host compositor. Do not enforce alignment requirements ther=
e.
> >>>>
> >>>> Fixes: 47248e0d8264 ("drm/virtio: honor blob_alignment requirements"=
)
> >>>> Signed-off-by: Val Packett <val@invisiblethingslab.com>
> >>>> ---
> >>>>
> >>>> v2: also check has_virgl_3d to prevent dereferencing NULL vfpriv
> >>>> v1: https://lore.kernel.org/all/20261006004044.2242154-1-
> >>>> val@invisiblethingslab.com/
> >>>>
> >>>> ~val
> >>>>
> >>>> ---
> >>>>   drivers/gpu/drm/virtio/virtgpu_ioctl.c | 4 +++-
> >>>>   1 file changed, 3 insertions(+), 1 deletion(-)
> >>>>
> >>>> diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/
> >>>> drm/virtio/virtgpu_ioctl.c
> >>>> index 3ddd5481d6bc..4d5ae062834d 100644
> >>>> --- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> >>>> +++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> >>>> @@ -551,7 +551,9 @@ static int verify_blob(struct virtio_gpu_device
> >>>> *vgdev,
> >>>>       params->blob_flags =3D rc_blob->blob_flags;
> >>>>       params->blob_hints =3D rc_blob->blob_hints;
> >>>>   -    if (vgdev->has_blob_alignment &&
> >>>> +    if (vgdev->has_blob_alignment && vgdev->has_virgl_3d &&
> >>>> +        (vfpriv->context_init &
> >>>> VIRTIO_GPU_CONTEXT_INIT_CAPSET_ID_MASK) !=3D
> >>>> +        VIRTIO_GPU_CAPSET_CROSS_DOMAIN &&
> >>>>           !IS_ALIGNED(params->size, vgdev->blob_alignment))
> >>>>           return -EINVAL;
> >>>>
> >>> What userspace has this problem and why it re-purposes virtio-gpu to =
act
> >>> as udmabuf for arbitrary data that never reaches host?
> >>
> >> Sorry, what do you mean by that?
> >>
> >> This is not related to data that "never reaches host" at all! The erro=
r
> >> I referred to in the patch message literally says "received *from* the
> >> host"=E2=80=A6??
> >>
> >> Guest userspace is any of the cross-domain proxies:
> >>
> >> * https://codeberg.org/drakulix/wl-cross-domain-proxy
> >> * https://github.com/talex5/wayland-proxy-virtwl
> >> * https://github.com/google/sommelier-rs (or old C++ version)
> >>
> >> VIRTIO_GPU_CAPSET_CROSS_DOMAIN "repurposes virtio-gpu" to act as a
> >> cross-VM UNIX socket transport that supports fd passing. By referring =
to
> >> virtio-gpu resources in the send command the guest can make the device
> >> send the resources' corresponding host fds to the host Wayland
> >> compositor. It can refer to resources from other contexts, in order to
> >> present drm/venus/etc rendered buffers on Wayland surfaces. (i.e. the
> >> host would send the actual dma-buf from virglrenderer) But the resourc=
es
> >> created on the cross-domain context itself are system memory buffers,
> >> generally used for software rendering and miscellaneous Wayland "stuff=
"
> >> like keymaps which are sent *from* the host, and exposed to Wayland
> >> clients in the guest. Socket receive handling in rutabaga-gfx stores
> >> incoming fds and returns their IDs to the guest, then the guest does a
> >> CREATE_BLOB with matching blob_id, which creates a virtio-gpu resource
> >> from the incoming buffer, so the guest can just MAP_BLOB it. These are
> >> the blobs that are not aligned to anything because they're just
> >> arbitrary memfds on the host.
> >
> > RE "These are the blobs that are not aligned to anything because they'r=
e
> > just arbitrary memfds on the host." I'll appreciate confirmation from
> > people more familiar with Sommelier internals like Gurchetan, Yiwei or =
Ryan.

Technically there's no need to enforce alignment on keymaps backed by
memfds, meanwhile those consumed by GPU have the proper alignment told
by CROSS_DOMAIN_CMD_GET_IMAGE_REQUIREMENTS (unless it fails to do the
right thing).

> >
> > In a case it is a correct claim, might be better to remove the
> > blob_alignment check entirely and let blob sharing fail naturally if
> > alignment is wrong.
> >
>
> Reproduced the bug with Sommelier.
>
> Driver always implicitly rounds up BO size up to PAGE_SIZE for both
> guest and host blobs [1][2], hence need to retain this old behavior to
> fix the problem properly.
>
> Please send v2
>
> [1]
> https://elixir.bootlin.com/linux/v7.2.10/source/drivers/gpu/drm/virtio/vi=
rtgpu_object.c#L217
> [2]
> https://elixir.bootlin.com/linux/v7.2.10/source/drivers/gpu/drm/virtio/vi=
rtgpu_vram.c#L210
>
> --- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> @@ -539,9 +539,15 @@ static int verify_blob(struct virtio_gpu_device *vgd=
ev,
>         params->blob_flags =3D rc_blob->blob_flags;
>         params->blob_hints =3D rc_blob->blob_hints;
>
> -       if (vgdev->has_blob_alignment &&
> -           !IS_ALIGNED(params->size, vgdev->blob_alignment))
> -               return -EINVAL;
> +       /*
> +        * Blob sizes always implicitly rounded up to PAGE_SIZE by the
> +        * driver, userspace may be unaware of the host's alignment.
> +        * Round up to the larger of the host and guest page sizes.
> +        */
> +       if (vgdev->has_blob_alignment)
> +               params->size =3D ALIGN(params->size,
> +                                    max_t(u32, vgdev->blob_alignment,
> PAGE_SIZE));
>
>         return 0;
>  }
>
>
>
> --
> Best regards,
> Dmitry

I like Dmitry's latest proposal much better. Keeping the alignment
agnostic to the guest userspace is more seamless, which also covers
the implicit 4k alignment case without forcing userspace to adapt.

Best,
Yiwei
