Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82777363C50
	for <virtualization@lists.linux.dev>; Mon,  2 Feb 2026 11:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770032129; cv=none; b=qJeuSFuh+/kTobrvvaenqXKdhMxeu6V3FAUIU1g54VhB9/W6uzPkmNBd3qJeJB2IEsU9AUUWnhY0CaMidZtcTWqOn80AeGDvF7SxCClsJIQDJmmMU4cpkqnsAxoHfuKDoC00oJ8Dq6IzqjpY+y7aU7JL+FtCf/CdhzXVutcuxR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770032129; c=relaxed/simple;
	bh=UQSoKQ0mb5qCQWRkngnezTDmNsixUS9hAstSuSxB/TE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i06Zuhrerv40IMyq51SaGtlG2lD0hkjEKbq1tNcKirMN7e8hB7sNTUDlb7yXrBwmT3I8wKUP2TfkfHnKo46TxAeW122XNhrELc7kDphbkRvrrFbvoo8UMnxeHZI+9IWD7X9lz11jHEEa2T64b6G1AzNZcW2b0XxK5D+cuu7/WNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PegYOGGU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PegYOGGU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770032126;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Rl2bTHtR42w+Ap4MZ031u42TK52anRClmCgeDZ8vBGI=;
	b=PegYOGGUfjva6rDip2ldq9ZmOSI1CY2W57NLWKXI+smssxLGJZwAuTpzVZ/9b++b0insNr
	toEgRZgCI/VVVdU0ADmE7ypF+hw7NYbpf+pizhcodNglG3xthH77gNbHcyImJ+lih2H0pQ
	QKnAlFGVcDpw8UvghAOhRm/evGBv3Po=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-135-26GNXIymOi-Tve1wcdzpRg-1; Mon, 02 Feb 2026 06:35:25 -0500
X-MC-Unique: 26GNXIymOi-Tve1wcdzpRg-1
X-Mimecast-MFC-AGG-ID: 26GNXIymOi-Tve1wcdzpRg_1770032125
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-79402e48414so68952407b3.2
        for <virtualization@lists.linux.dev>; Mon, 02 Feb 2026 03:35:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770032125; x=1770636925;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Rl2bTHtR42w+Ap4MZ031u42TK52anRClmCgeDZ8vBGI=;
        b=ZKdl0OHTZluTXla+QWBZ09Y2lUppFwiEdF+TIts9iLy9pHfjCQJ6OegMcLgyV16uS4
         UnrKdKMdsZ8T0pWnKP3qdHQEB/UISqeRFLVEOKxGzzk7Xi+oFEC2noUyl8PejyfObQWn
         yHWwzDuJHOJh6hWVSt8hvMc4EBPS6/19ppkIpUxQgxeLoFSp0uR5hU1EqAbw9YmYGsyM
         E0oG7DQDAmOCt/OnL7PPcijJghABTKrqJ946lDWcnDsqv0pVLO63hJxMGgn/VM4EuLMq
         3/odVIJIB53/dCfr/ti268EC5QBPWc0XXcR5p4E6hdCUvPxXis85fVIQ4Tijk2m3312J
         evLQ==
X-Forwarded-Encrypted: i=1; AJvYcCVxuLyYi+R1uFTUqZihFeFOgx4DBcA7CEragBA8Vfy6dio3bOTlcGXvrlZjohazn/2i7YCrLA8ahfZrtnuvMQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwTOdArJw/q4qJclaN3/CO1fAx/NAoIHi7lHBuSNonEUYSKrEF0
	h+EZENAz598Thm/8l1nJRqgMuNT6duKUVJmLG7C4/IwrKfjx4hC4YRL+DfMPa6Ayqji+j4/80V+
	WG+JbljASlg181Rq720C0ok7nCp8LH2JRbMMEEl27e6avAh1wrbM0xSRt3Iyz21gvulXCmWWUmU
	E5KOCgKksNwvvo2VjVRKJABIqMrZsb6dpVC/c65SeCzFQ=
X-Gm-Gg: AZuq6aK3XaSC8Pv/ZaIcU8N00O+JN5ozZau7imcbXVZHewbOudSpAQmakxSH5Eehl+H
	zgzY9+B82ObHEcTBlR3ZryWs61wNqNptd93lAb7XvSmyjD7gPyJDnqP977vEcVdR1R2o8eEuSIj
	crH8Fvs+v8M+xG2Qw90OJ5UWCiUnZ/BwNmO2E4LlEjeG3tL5FOszczV/WEuQc1E9GnjQ==
X-Received: by 2002:a05:690c:7013:b0:794:bfe3:6db1 with SMTP id 00721157ae682-794bfe38086mr42992667b3.64.1770032124732;
        Mon, 02 Feb 2026 03:35:24 -0800 (PST)
X-Received: by 2002:a05:690c:7013:b0:794:bfe3:6db1 with SMTP id
 00721157ae682-794bfe38086mr42992537b3.64.1770032124400; Mon, 02 Feb 2026
 03:35:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260202095940.1358613-1-arnd@kernel.org> <20260202095940.1358613-2-arnd@kernel.org>
In-Reply-To: <20260202095940.1358613-2-arnd@kernel.org>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Mon, 2 Feb 2026 12:34:48 +0100
X-Gm-Features: AZwV_Qimgk1wXmITo5x5v479wazZDuxP1uG8s6l0Vk3LE-BJ7ZNOdA6GCSmpol8
Message-ID: <CAJaqyWeJs4u6G46gEg=-G6o3u6LsgzVC03fTGR=O_qd_HujLuw@mail.gmail.com>
Subject: Re: [PATCH 2/2] vduse: fix compat handling for VDUSE_IOTLB_GET_FD/VDUSE_VQ_GET_INFO
To: Arnd Bergmann <arnd@kernel.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xie Yongji <xieyongji@bytedance.com>, Arnd Bergmann <arnd@arndb.de>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Anders Roxell <anders.roxell@linaro.org>, 
	Marco Crivellari <marco.crivellari@suse.com>, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: wD3x46y7iPFO3iqHrnGeUTLebJCrFlY5ipqKp1KUpkc_1770032125
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 2, 2026 at 11:07=E2=80=AFAM Arnd Bergmann <arnd@kernel.org> wro=
te:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> These two ioctls are incompatible on 32-bit x86 userspace, because
> the data structures are shorter than they are on 64-bit.
>
> Add compad handling to the regular ioctl handler to just handle
> them the same way and ignore the extra padding. This could be
> done in a separate .compat_ioctl handler, but the main one already
> handles two versions of VDUSE_IOTLB_GET_FD, so adding a third one
> fits in rather well.
>

I'm just learning about the COMPAT_ stuff but does this mean the
userland app need to call a different ioctl depending if it is
compiled for 32 bits or 64 bits? I guess it is not the case, but how
is that handled?

> Fixes: ad146355bfad ("vduse: Support querying information of IOVA regions=
")
> Fixes: c8a6153b6c59 ("vduse: Introduce VDUSE - vDPA Device in Userspace")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/vdpa/vdpa_user/vduse_dev.c | 43 +++++++++++++++++++++++++++---
>  1 file changed, 40 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/=
vduse_dev.c
> index 405d59610f76..39cbff2f379d 100644
> --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> @@ -1341,6 +1341,37 @@ static int vduse_dev_iotlb_entry(struct vduse_dev =
*dev,
>         return r;
>  }
>
> +#if defined(CONFIG_X86_64) && defined(CONFIG_COMPAT)
> +/*
> + * i386 has different alignment constraints than x86_64,
> + * so there are only 3 bytes of padding instead of 7.
> + */
> +struct compat_vduse_iotlb_entry {
> +       compat_u64 offset;
> +       compat_u64 start;
> +       compat_u64 last;
> +       __u8 perm;
> +       __u8 padding[__alignof__(compat_u64) - 1];
> +};
> +#define COMPAT_VDUSE_IOTLB_GET_FD      _IOWR(VDUSE_BASE, 0x10, struct co=
mpat_vduse_iotlb_entry)
> +
> +struct compat_vduse_vq_info {
> +       __u32 index;
> +       __u32 num;
> +       compat_u64 desc_addr;
> +       compat_u64 driver_addr;
> +       compat_u64 device_addr;
> +       union {
> +               struct vduse_vq_state_split split;
> +               struct vduse_vq_state_packed packed;
> +       };
> +       __u8 ready;
> +       __u8 padding[__alignof__(compat_u64) - 1];
> +} __uapi_arch_align;
> +#define COMPAT_VDUSE_VQ_GET_INFO       _IOWR(VDUSE_BASE, 0x15, struct co=
mpat_vduse_vq_info)
> +
> +#endif
> +
>  static long vduse_dev_ioctl(struct file *file, unsigned int cmd,
>                             unsigned long arg)
>  {
> @@ -1352,6 +1383,9 @@ static long vduse_dev_ioctl(struct file *file, unsi=
gned int cmd,
>                 return -EPERM;
>
>         switch (cmd) {
> +#if defined(CONFIG_X86_64) && defined(CONFIG_COMPAT)
> +       case COMPAT_VDUSE_IOTLB_GET_FD:
> +#endif
>         case VDUSE_IOTLB_GET_FD:
>         case VDUSE_IOTLB_GET_FD2: {
>                 struct vduse_iotlb_entry_v2 entry =3D {0};
> @@ -1455,13 +1489,16 @@ static long vduse_dev_ioctl(struct file *file, un=
signed int cmd,
>                 ret =3D 0;
>                 break;
>         }
> +#if defined(CONFIG_X86_64) && defined(CONFIG_COMPAT)
> +       case COMPAT_VDUSE_VQ_GET_INFO:
> +#endif
>         case VDUSE_VQ_GET_INFO: {
> -               struct vduse_vq_info vq_info;
> +               struct vduse_vq_info vq_info =3D {};
>                 struct vduse_virtqueue *vq;
>                 u32 index;
>
>                 ret =3D -EFAULT;
> -               if (copy_from_user(&vq_info, argp, sizeof(vq_info)))
> +               if (copy_from_user(&vq_info, argp, _IOC_SIZE(cmd)))
>                         break;
>
>                 ret =3D -EINVAL;
> @@ -1491,7 +1528,7 @@ static long vduse_dev_ioctl(struct file *file, unsi=
gned int cmd,
>                 vq_info.ready =3D vq->ready;
>
>                 ret =3D -EFAULT;
> -               if (copy_to_user(argp, &vq_info, sizeof(vq_info)))
> +               if (copy_to_user(argp, &vq_info, _IOC_SIZE(cmd)))
>                         break;
>
>                 ret =3D 0;
> --
> 2.39.5
>
>

