Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8586324B3C
	for <virtualization@lists.linux.dev>; Fri, 30 Jan 2026 08:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769763360; cv=none; b=Gsr7AvxpcocbhGazgaQBG5KrooMMcjowdyKxNS21orzbL0QwbVlhjC1NlDaZSQT6oQ7itvhZsD9iYJqbOdmUkj/5k2DK+Z+rWzBHCfLeyhiaJE+ycKQK/KfCGhNeIt1p3TFbDpud6U5mSZ9BQt/qyMzfQxsyoXE9PP8MZRNRneA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769763360; c=relaxed/simple;
	bh=tDUV2M7sFM1EXX304FGpuqw+CFIvJOM0R/NfHzgnVWk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qC8FXT4r+ZRtUA0jkrgMdTjLThIlWDVR9JQtSuVlMrK9BWZqN/dRqopLgBXxPJBfHVno0VrAHUPMv2SdomAGpdIvxI6bHDC9Cus/8SZzf4giKSGY/KkQNeSoHySQIvyyahUysSE433wg7c60hJBQ6rIABgeJUHdqFXLesyA+YHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y6k09UEn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y6k09UEn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769763358;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hy7Lg/JNukiw01dctwhw0lTv8BVxCRgkGATAIRLOljo=;
	b=Y6k09UEnbYqjuUJoP3Q2j3fjIRQ3nJFR1bR4mM4NaRVMrSSXWbXqO+167/yDy93TyAOhNf
	uAIgbU2Rwj09bUsSEy1O9WNThxtzgYhSbBPhh3/owzyeyFNPNnshLujzpft4X1Rsgoi0Ew
	u7ZO7n13eonGHAKCFggJMXxgmkejc2w=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-601-MJ37zsfwMtyWRBd5F3fgaQ-1; Fri, 30 Jan 2026 03:55:55 -0500
X-MC-Unique: MJ37zsfwMtyWRBd5F3fgaQ-1
X-Mimecast-MFC-AGG-ID: MJ37zsfwMtyWRBd5F3fgaQ_1769763355
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-7943aea6515so26701397b3.1
        for <virtualization@lists.linux.dev>; Fri, 30 Jan 2026 00:55:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769763355; x=1770368155;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hy7Lg/JNukiw01dctwhw0lTv8BVxCRgkGATAIRLOljo=;
        b=c2w6+Pt5BOIpPrkv8PNXSVWzS5rkBGIM5yeeUQ3g8Wu6YFSv2GbsHIrSDbmc5ij3Pa
         kmkqXQJxe0pKbRaSZz6Bjj+iSMjrJclmFQ+aAGE/LU+4QqyQ8BKOQpWYgiwFTXht+Ata
         qaFU2gKiP/CwRJDiA7bd3HDM3D3TtJuBRp4oAdH2bjGjE+QZyNgS0peKd1z9ksa4Vov8
         kr32hiKuhBOJHJPPOjAdVjlAGiFbL9LjVpzGeN8GlfvpHo/MCrsEw7DUSotJrt+y/5Jz
         VAwxywBmb+7sYFWuYQplMJrHRvUS+ErQwbmXQLDfc41qqG3QwP2hud7aTXL/tqv2yR3P
         OnkA==
X-Forwarded-Encrypted: i=1; AJvYcCX35aEzWKBz9iOcgdeMLrPtEKLpNo3siswlI7LiV58QCePYwfFI6ONgviN41u+VFv+AS6UjlttMFF8fEYbx2Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YwNOkY4/nDWbLoW0NQ4Xm2Ox49hTM0/mFW24eC0aPJSG+Pisr9v
	7bhtokU7Xlyuv+PMSOU3Bz4+y1XxS3aHKEcXAlIj/gYrs7/8nYjKaFOEVqGpBvx6+0gIB7Q/Vza
	47DwgQm41c0pfp8RJt3TOym8jt7JYv+kqRuqa/dwtGuuTYuICGDk/L+TNE6LsikoTDvT/D0xCfB
	Gxos0Q/qi/4S8ZYWH9sql1BcF6JTiwakdwlZglATNW0hU=
X-Gm-Gg: AZuq6aL+1xAG699OCm5nvKxSjO7XftJYicXVA+rXls+bA0A6atfUS7vctGYwKikDnjt
	wz03jUPyjiF0AMR526bsOO+fsRMsPdn+T0OGiLCidK4pCleLx15gRad5fCBcBUp0tfxAgF2jYdl
	rgse9636aMeLo/Fmgj38XbLNUT7AAXhdYplZpBB40WrnhPCC8QwvxDNAd7F/NWbxKlDg==
X-Received: by 2002:a05:690c:45c5:b0:794:8f0f:e8c5 with SMTP id 00721157ae682-7949e01d485mr20229037b3.58.1769763355269;
        Fri, 30 Jan 2026 00:55:55 -0800 (PST)
X-Received: by 2002:a05:690c:45c5:b0:794:8f0f:e8c5 with SMTP id
 00721157ae682-7949e01d485mr20228917b3.58.1769763354885; Fri, 30 Jan 2026
 00:55:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260130050750.4050-1-jasowang@redhat.com>
In-Reply-To: <20260130050750.4050-1-jasowang@redhat.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Fri, 30 Jan 2026 09:55:18 +0100
X-Gm-Features: AZwV_Qj4av1QMp6k4LYgz2oCC7PDlNamd-x8snWeLLa05FtKcVnQe5UNZ4leKag
Message-ID: <CAJaqyWdciiqB7uvUs0_13zYY9bO_h0KSxGqESDUN0ZRGfuWODg@mail.gmail.com>
Subject: Re: [PATCH] VDUSE: avoid leaking information to userspace
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, xuanzhuo@linux.alibaba.com, 
	xieyongji@bytedance.com, stable@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: sSow9Sek5vcFz1zyI-1BylpXB6GnJQ1Rgo_724_BZ48_1769763355
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 30, 2026 at 6:08=E2=80=AFAM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> The bounceing is not necessarily page aligned, so current VDUSE can
> leak kernel information through mapping bounce pages to
> userspace. Allocate bounce pages with __GFP_ZERO to avoid leaking
> information to userspace.
>
> Fixes: 8c773d53fb7b ("vduse: Implement an MMU-based software IOTLB")
> Cc: stable@vger.kernel.org

Reviewed-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

Thanks!

> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  drivers/vdpa/vdpa_user/iova_domain.c | 2 +-
>  drivers/vdpa/vdpa_user/vduse_dev.c   | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/vdpa/vdpa_user/iova_domain.c b/drivers/vdpa/vdpa_use=
r/iova_domain.c
> index 0a9f668467a8..ec743bed361c 100644
> --- a/drivers/vdpa/vdpa_user/iova_domain.c
> +++ b/drivers/vdpa/vdpa_user/iova_domain.c
> @@ -124,7 +124,7 @@ static int vduse_domain_map_bounce_page(struct vduse_=
iova_domain *domain,
>                 if (!map->bounce_page) {
>                         head_map =3D &domain->bounce_maps[(iova & PAGE_MA=
SK) >> BOUNCE_MAP_SHIFT];
>                         if (!head_map->bounce_page) {
> -                               tmp_page =3D alloc_page(GFP_ATOMIC);
> +                               tmp_page =3D alloc_page(GFP_ATOMIC | __GF=
P_ZERO);
>                                 if (!tmp_page)
>                                         return -ENOMEM;
>                                 if (cmpxchg(&head_map->bounce_page, NULL,=
 tmp_page))
> diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/=
vduse_dev.c
> index 73d1d517dc6c..57a40a821c65 100644
> --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> @@ -976,7 +976,7 @@ static void *vduse_dev_alloc_coherent(union virtio_ma=
p token, size_t size,
>         if (!token.group)
>                 return NULL;
>
> -       addr =3D alloc_pages_exact(size, flag);
> +       addr =3D alloc_pages_exact(size, flag | __GFP_ZERO);
>         if (!addr)
>                 return NULL;
>
> --
> 2.34.1
>

