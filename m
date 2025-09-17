Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D8A2C11E9
	for <virtualization@lists.linux.dev>; Wed, 17 Sep 2025 08:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758097004; cv=none; b=F+nW2gRDYCDQALm7NDZ5CVfYDpP0pyTTlfpil91r2tFe51ueLMnGWDlFL6TfBHhbbfiTPrLQhyuMHPaWDA5eS0XZ5UsMNjRLLhr2DpuesIsdxThFS35CuUtcZb08DsxBfAmTGA/PEyIekzEqhh7u15T2/Mn+44uvr97MCvtgDnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758097004; c=relaxed/simple;
	bh=D3uVpe7idnuVpYyj6TCQjWxP6DdLGs6ovCUc93Dppr4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oL0OHTtNd32jVqaGwgA3O9dwAGTG0qiXJH36cE569cHamJnPggMXGH+89jB4YnIiowSkxnkY1DeGR4k/F1q9YxV+vlkTDGYyDEbrrbQJNzOG0my2rapP58Egwi0ljDdExlSnIIcOOpZsHHpQ9hAOb6oOaYPs9uD5Om2Fgm+VVU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F+2Ho/RB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F+2Ho/RB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758097002;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tIezN4SyC16JlEntDsupLzOf+WZCvKC1Igsxjt0hakc=;
	b=F+2Ho/RBRPUqTsfOvw42cIxYLZBtzKmQ/et7myfA8UvAd3LQ2UIGb7Tyvz2lKKa8ab5AeG
	4S4p7RyvdLLuNVD2zBQDlaQdr0cQr1WSfoYhMZ8U5VB77gmFWp6RANYu/1KNJG24Z9r5Lc
	x5z8W9w8o1+XrXoa0EDH7lHAdHgZrIA=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615-hx9i0yoONZixCfhjhg2ZHA-1; Wed, 17 Sep 2025 04:16:41 -0400
X-MC-Unique: hx9i0yoONZixCfhjhg2ZHA-1
X-Mimecast-MFC-AGG-ID: hx9i0yoONZixCfhjhg2ZHA_1758097000
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-32ee157b9c9so533452a91.2
        for <virtualization@lists.linux.dev>; Wed, 17 Sep 2025 01:16:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758097000; x=1758701800;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tIezN4SyC16JlEntDsupLzOf+WZCvKC1Igsxjt0hakc=;
        b=k9+IXlI3JKf3LSPKG3QMZvGb/busWggM0rP+Gg2Fl/AqadEUM9Jb8Gy9wlJZng2ATG
         PbYFRWzOTF+kfdiQb++BSPCx79RoJ4ddaX7DH95HBGhCMJ2zg2fKoXhumOddyo52Vecy
         /l4sUN9WsZDe/8SoM7cnk4gu9js2CuILLJuecjwnIfMUrQBblJAhOv4oZPTD/Ka3QomM
         KduYCGMw9xwPxs+8VHnpmz37Hjlhz9FtKmNyRK3v9AREpe8rqe1Gv92d5kwsrFP3DreP
         845BqEFCvgsFrIpr6LxFyLwQk0YfZz8vXvY2n/QtZiIHbzPG8SjUj1GLFwm4/3/0ySOe
         fg9w==
X-Forwarded-Encrypted: i=1; AJvYcCXI2G+BiYttsHNTi/o6O1uCrMqa0jvPzd2JerD2nKCRhUCxNG86Psmcxz2r12UP1LJuwuJRxFqwS+9YMu82Xw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz718fbI/qkCiu+uU4MxTygrvuu3SqkDiNRC7I/QyxGm19/fNH3
	E9FNd0P89jfuJxNRwXk3DP0Bd5scv0Irm+j/gkLfzWfEfZiM6ixLNJjlc046JJ6T0EjAdKDj83b
	cxv3WYjbrMhNf7KsDgsoO6Lv6XwhKgAmCPcRjnCmyg9HQTK51ZjPZCWf7c70BZsJxjnGDt6Yf0p
	fJbZYHgEKlVzRlMObW6leHevbUjIw6WpR/t5IVByBuzn4=
X-Gm-Gg: ASbGncv+9W4DNFqS1Mu0bdS2X7Cok3QjHVnixcbgXJe9Elxol8cbrL+IykJnnaqT+uw
	ZdmPgSnGS6VCy8KxnJdVWS5vxSQBM45Uepg9enRFnfwokiTL0JQZUKv2JcU1zLK3ZrZ3cozZkjb
	MviuPRk7v1ODVx/fbo5g==
X-Received: by 2002:a17:90b:4fcf:b0:32b:9774:d340 with SMTP id 98e67ed59e1d1-32ee3f65f8fmr1626610a91.33.1758096999848;
        Wed, 17 Sep 2025 01:16:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHIkxjd0/uhjioyGtcGfYeyein79f8hWTFCB4uxGdlricZylwdZfn4c7q447hODwObIf1FbULmLRqFoRrt+XFg=
X-Received: by 2002:a17:90b:4fcf:b0:32b:9774:d340 with SMTP id
 98e67ed59e1d1-32ee3f65f8fmr1626580a91.33.1758096999290; Wed, 17 Sep 2025
 01:16:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250915073429.54027-1-sheng.zhao@bytedance.com>
In-Reply-To: <20250915073429.54027-1-sheng.zhao@bytedance.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 17 Sep 2025 16:16:28 +0800
X-Gm-Features: AS18NWDdK52MK9sQQXIdv5o4rOSPYP_dSgDnuW1SA-AFv4QeEg7eeyISx-0L_-c
Message-ID: <CACGkMEuvT3=a+6LyaFZFmCZzGS5tntPSbSJg=h6FAHdk89pC8g@mail.gmail.com>
Subject: Re: [PATCH] vduse: Use fixed 4KB bounce pages for arm64 64KB page size
To: sheng.zhao@bytedance.com
Cc: mst@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	xieyongji@bytedance.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: HOlu2mtfKXVqmM3aZh4NftWpPZWfxN25kTAswxweJIA_1758097000
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 15, 2025 at 3:34=E2=80=AFPM <sheng.zhao@bytedance.com> wrote:
>
> From: Sheng Zhao <sheng.zhao@bytedance.com>
>
> The allocation granularity of bounce pages is PAGE_SIZE. This may cause
> even small IO requests to occupy an entire bounce page exclusively. The
> kind of memory waste will be more significant on arm64 with 64KB pages.

Let's tweak the title as there are archs that are using non 4KB pages
other than arm.

>
> So, optimize it by using fixed 4KB bounce pages.
>
> Signed-off-by: Sheng Zhao <sheng.zhao@bytedance.com>
> ---
>  drivers/vdpa/vdpa_user/iova_domain.c | 120 +++++++++++++++++----------
>  drivers/vdpa/vdpa_user/iova_domain.h |   5 ++
>  2 files changed, 83 insertions(+), 42 deletions(-)
>
> diff --git a/drivers/vdpa/vdpa_user/iova_domain.c b/drivers/vdpa/vdpa_use=
r/iova_domain.c
> index 58116f89d8da..768313c80b62 100644
> --- a/drivers/vdpa/vdpa_user/iova_domain.c
> +++ b/drivers/vdpa/vdpa_user/iova_domain.c
> @@ -103,19 +103,26 @@ void vduse_domain_clear_map(struct vduse_iova_domai=
n *domain,
>  static int vduse_domain_map_bounce_page(struct vduse_iova_domain *domain=
,
>                                          u64 iova, u64 size, u64 paddr)
>  {
> -       struct vduse_bounce_map *map;
> +       struct vduse_bounce_map *map, *head_map;
> +       struct page *tmp_page;
>         u64 last =3D iova + size - 1;
>
>         while (iova <=3D last) {
> -               map =3D &domain->bounce_maps[iova >> PAGE_SHIFT];
> +               map =3D &domain->bounce_maps[iova >> BOUNCE_PAGE_SHIFT];

BOUNCE_PAGE_SIZE is kind of confusing as it's not the size of any page
at all when PAGE_SIZE is not 4K.

>                 if (!map->bounce_page) {
> -                       map->bounce_page =3D alloc_page(GFP_ATOMIC);
> -                       if (!map->bounce_page)
> -                               return -ENOMEM;
> +                       head_map =3D &domain->bounce_maps[(iova & PAGE_MA=
SK) >> BOUNCE_PAGE_SHIFT];
> +                       if (!head_map->bounce_page) {
> +                               tmp_page =3D alloc_page(GFP_ATOMIC);
> +                               if (!tmp_page)
> +                                       return -ENOMEM;
> +                               if (cmpxchg(&head_map->bounce_page, NULL,=
 tmp_page))
> +                                       __free_page(tmp_page);

I don't understand why we need cmpxchg() logic.

Btw, it looks like you want to make multiple bounce_map to point to
the same 64KB page? I wonder what's the advantages of doing this. Can
we simply keep the 64KB page in bounce_map?

Thanks

