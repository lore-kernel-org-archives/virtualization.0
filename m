Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E14693612DC
	for <virtualization@lists.linux.dev>; Mon,  2 Feb 2026 11:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770031748; cv=none; b=XWJzpD6cA/TItOXL/CTUiDLaCBq/kFEGFDCGoWxnUlVStiNCdA27zuLI7tXez02WlU+XIdXG/vlyWcUxvwzNYobJtauCRnVzG7XsG55zgyLgYShbDr4Vx3WGWCTDXtkPLqOWA5/WClEsqb/piIH+htlHcd/hwn9Mjoa2slkTyMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770031748; c=relaxed/simple;
	bh=GjlQSndozBKfBvafD0kZgNTtxz+hinvLFjD7eNgIPKw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cPNx4vZP6bjcU9HvM4DCnP14ym5MYxND/OnuKr0uKkSegzt2PU5+VjLaimcO2PZ0W1uEeV/5kDMqUr2zxs4VtKfSYl2+2m9dJyn8YJUgUxQCXurLnrge7gnQ+4o2F81vIlj7+jfylvNusZqIfsJovXZwZz0NoJG8CghCLr/4l0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ALOVDkrI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ALOVDkrI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770031746;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PwPIhjD2z6mcxuXS/Trl18k8mkoG+q/uLpTwXhCmx/o=;
	b=ALOVDkrILm7Vc7CP1SnLT2JGEzeAR9lBeNaj7aJZTDB0a9QIJIdcse2pnKxJRR06HY1whS
	JybW6nlIk5UiZzUahDYQCZlZCkhq//c46R1MEiw4zeqKFxI/gy6cINI6UWtwJ3ceMHmhKE
	jPMPM+gu0KyiFfyAuL1sWcqhe/F9Gm0=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-646-4TpINuBQMfKJztGfD2ej-g-1; Mon, 02 Feb 2026 06:29:04 -0500
X-MC-Unique: 4TpINuBQMfKJztGfD2ej-g-1
X-Mimecast-MFC-AGG-ID: 4TpINuBQMfKJztGfD2ej-g_1770031744
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-790656ac3faso60894277b3.1
        for <virtualization@lists.linux.dev>; Mon, 02 Feb 2026 03:29:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770031744; x=1770636544;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PwPIhjD2z6mcxuXS/Trl18k8mkoG+q/uLpTwXhCmx/o=;
        b=oHoI7PBY1jtJwqdbsP3LQtVRCK5Eoi1E17jbUINeSFuP3aDo0VDCzIHe3RJ4eMsDqM
         qFnWB1D6uQF66rEtPZxdLco80ow2DJfa6YPWd1rKVKk1UUyc3InbQZm+K33eAz/QHTqz
         CyQtL4MeUL4KKyqtXMPj6wfF58VnJ0IgV/B7+yEMdFQaOfwa+pMQDEQo53tEAT8q+u6s
         TEYmyPqQEsoFBD3v0K97md1O2Qq0Nmx9InewDyflgmelFmqGlRmGChrB1a3MYsQH/NY4
         PUkxfGe4pE5mQ1ciPD9bHegTGgB/iI5jCl7zIfceFGUQyFbFuoyTLMWkS7LMvF+EhTvP
         YH/Q==
X-Forwarded-Encrypted: i=1; AJvYcCVyUztiIRjvKrnJYoPwHQMDvQq8sDXwHLBBnt+qe4P+/AHmFp8ugeUsx/xLXtdpA6HxFlFzplug19+ZPRG2Fg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxkgmZIddTMCGJeYsuJaWxcbWK/63dFH2Z1XXrs8NyYx2X0Tadc
	XmHfCG6C0Iezs0hrfx4Nr49AvW08AkgfG75tetNK5BfGKOclkwXunZYaRzAiwIdmvm3db0aiXBv
	LPwsPXcJtWXvl+z1an+4F3U7EYxqp4vc8o3bZIZ5qFDFfZa1nGuxcadOKzw4RFDFn9u6MKV57vm
	JHjRpMEup50rRKGQNbtRw/ihaQngc8cMIxtgq2utdATJw=
X-Gm-Gg: AZuq6aILsVWj1Ty30mZkolk5nl9jFFYUAbxlO+RyuMiv2fkT9zlIr3nINGPrmoorSWt
	kwaS7FB61sqIV9NrLcBwY3K0P5RjB/VMh56LMbknugSqRkybUxqIVNFl1Hl/z1LaM71JZU4S3Lq
	kfUHc6GfUEvmIjII70kGih3xuPtOCa3PNSZQ27j5lIilpdxdiRpzR4qOjKWH69GANPuw==
X-Received: by 2002:a05:690c:4b87:b0:792:7463:c9b7 with SMTP id 00721157ae682-7949deccc58mr92856247b3.20.1770031743981;
        Mon, 02 Feb 2026 03:29:03 -0800 (PST)
X-Received: by 2002:a05:690c:4b87:b0:792:7463:c9b7 with SMTP id
 00721157ae682-7949deccc58mr92855997b3.20.1770031743610; Mon, 02 Feb 2026
 03:29:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260202095940.1358613-1-arnd@kernel.org>
In-Reply-To: <20260202095940.1358613-1-arnd@kernel.org>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Mon, 2 Feb 2026 12:28:26 +0100
X-Gm-Features: AZwV_Qi9wvklaJjWC-DW2IcFqRsD7T_JyJnPCUkfZOY3S-1rSUcdUQOR_TDJRJM
Message-ID: <CAJaqyWcrjuQAp=sTfpiQsBu4pS7sxix-ggS4BPCzxyDwW5MZQQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] vduse: avoid adding implicit padding
To: Arnd Bergmann <arnd@kernel.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Arnd Bergmann <arnd@arndb.de>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Xie Yongji <xieyongji@bytedance.com>, 
	Anders Roxell <anders.roxell@linaro.org>, Marco Crivellari <marco.crivellari@suse.com>, 
	Ashwini Sahu <ashwini@wisig.com>, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: dQzWMDI2XxcwTgLEmQ3USOS5CsUCwcyiJDyZ9jhxkng_1770031744
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 2, 2026 at 11:06=E2=80=AFAM Arnd Bergmann <arnd@kernel.org> wro=
te:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> The vduse_iova_range_v2 and vduse_iotlb_entry_v2 structures are both
> defined in a way that adds implicit padding and is incompatible between
> i386 and x86_64 userspace because of the different structure alignment
> requirements. Building the header with -Wpadded shows these new warnings:
>
> vduse.h:305:1: error: padding struct size to alignment boundary with 4 by=
tes [-Werror=3Dpadded]
> vduse.h:374:1: error: padding struct size to alignment boundary with 4 by=
tes [-Werror=3Dpadded]
>
> Change the amount of padding in these two structures to align them to
> 64 bit words and avoid those problems. Since the v1 vduse_iotlb_entry
> already has an inconsistent size, do not attempt to reuse the structure
> but rather list the members indiviudally, with a fixed amount of

s/indiviudally/individually/ if v2

> padding.
>

That's something I didn't take into account, thanks!

> Fixes: 079212f6877e ("vduse: add vq group asid support")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/vdpa/vdpa_user/vduse_dev.c | 40 +++++++++++-------------------
>  include/uapi/linux/vduse.h         |  9 +++++--
>  2 files changed, 21 insertions(+), 28 deletions(-)
>
> diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/=
vduse_dev.c
> index 73d1d517dc6c..405d59610f76 100644
> --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> @@ -1301,7 +1301,7 @@ static int vduse_dev_iotlb_entry(struct vduse_dev *=
dev,
>         int r =3D -EINVAL;
>         struct vhost_iotlb_map *map;
>
> -       if (entry->v1.start > entry->v1.last || entry->asid >=3D dev->nas=
)
> +       if (entry->start > entry->last || entry->asid >=3D dev->nas)
>                 return -EINVAL;
>
>         asid =3D array_index_nospec(entry->asid, dev->nas);
> @@ -1312,18 +1312,18 @@ static int vduse_dev_iotlb_entry(struct vduse_dev=
 *dev,
>
>         spin_lock(&dev->as[asid].domain->iotlb_lock);
>         map =3D vhost_iotlb_itree_first(dev->as[asid].domain->iotlb,
> -                                     entry->v1.start, entry->v1.last);
> +                                     entry->start, entry->last);
>         if (map) {
>                 if (f) {
>                         const struct vdpa_map_file *map_file;
>
>                         map_file =3D (struct vdpa_map_file *)map->opaque;
> -                       entry->v1.offset =3D map_file->offset;
> +                       entry->offset =3D map_file->offset;
>                         *f =3D get_file(map_file->file);
>                 }
> -               entry->v1.start =3D map->start;
> -               entry->v1.last =3D map->last;
> -               entry->v1.perm =3D map->perm;
> +               entry->start =3D map->start;
> +               entry->last =3D map->last;
> +               entry->perm =3D map->perm;
>                 if (capability) {
>                         *capability =3D 0;
>
> @@ -1363,14 +1363,8 @@ static long vduse_dev_ioctl(struct file *file, uns=
igned int cmd,
>                         break;
>
>                 ret =3D -EFAULT;
> -               if (cmd =3D=3D VDUSE_IOTLB_GET_FD2) {
> -                       if (copy_from_user(&entry, argp, sizeof(entry)))
> -                               break;
> -               } else {
> -                       if (copy_from_user(&entry.v1, argp,
> -                                          sizeof(entry.v1)))
> -                               break;
> -               }
> +               if (copy_from_user(&entry, argp, _IOC_SIZE(cmd)))

I did not know about _IOC_SIZE and I like how it reduces the complexity, th=
anks!

As a proposal, maybe we can add MIN(_IOC_SIZE, sizeof(entry)) ? Not
sure if it is too much boilerplate for nothing as the compiler should
make the code identical and the uapi ioctl part should never change.
But it seems to me future changes to the code are better tied with the
MIN.

I'm ok with not including MIN() either way.

> +                       break;
>
>                 ret =3D -EINVAL;
>                 if (!is_mem_zero((const char *)entry.reserved,
> @@ -1385,19 +1379,13 @@ static long vduse_dev_ioctl(struct file *file, un=
signed int cmd,
>                 if (!f)
>                         break;
>
> -               if (cmd =3D=3D VDUSE_IOTLB_GET_FD2)
> -                       ret =3D copy_to_user(argp, &entry,
> -                                          sizeof(entry));
> -               else
> -                       ret =3D copy_to_user(argp, &entry.v1,
> -                                          sizeof(entry.v1));
> -
> +               ret =3D copy_to_user(argp, &entry, _IOC_SIZE(cmd));
>                 if (ret) {
>                         ret =3D -EFAULT;
>                         fput(f);
>                         break;
>                 }
> -               ret =3D receive_fd(f, NULL, perm_to_file_flags(entry.v1.p=
erm));
> +               ret =3D receive_fd(f, NULL, perm_to_file_flags(entry.perm=
));
>                 fput(f);
>                 break;
>         }
> @@ -1603,16 +1591,16 @@ static long vduse_dev_ioctl(struct file *file, un=
signed int cmd,
>                 } else if (info.asid >=3D dev->nas)
>                         break;
>
> -               entry.v1.start =3D info.start;
> -               entry.v1.last =3D info.last;
> +               entry.start =3D info.start;
> +               entry.last =3D info.last;
>                 entry.asid =3D info.asid;
>                 ret =3D vduse_dev_iotlb_entry(dev, &entry, NULL,
>                                             &info.capability);
>                 if (ret < 0)
>                         break;
>
> -               info.start =3D entry.v1.start;
> -               info.last =3D entry.v1.last;
> +               info.start =3D entry.start;
> +               info.last =3D entry.last;
>                 info.asid =3D entry.asid;
>
>                 ret =3D -EFAULT;
> diff --git a/include/uapi/linux/vduse.h b/include/uapi/linux/vduse.h
> index faae7718bd2e..deca8c7b9178 100644
> --- a/include/uapi/linux/vduse.h
> +++ b/include/uapi/linux/vduse.h
> @@ -299,9 +299,13 @@ struct vduse_iova_info {
>   * Structure used by VDUSE_IOTLB_GET_FD2 ioctl to find an overlapped IOV=
A region.
>   */
>  struct vduse_iotlb_entry_v2 {
> -       struct vduse_iotlb_entry v1;
> +       __u64 offset;
> +       __u64 start;
> +       __u64 last;
> +       __u8 perm;
> +       __u8 padding[7];
>         __u32 asid;
> -       __u32 reserved[12];
> +       __u32 reserved[11];
>  };
>
>  /*
> @@ -371,6 +375,7 @@ struct vduse_iova_range_v2 {
>         __u64 start;
>         __u64 last;
>         __u32 asid;
> +       __u32 padding;
>  };
>

