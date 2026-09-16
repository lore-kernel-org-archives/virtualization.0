Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F3964A6CE9
	for <virtualization@lists.linux.dev>; Wed, 16 Sep 2026 09:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789551019; cv=none; b=gNslblqFmlKSMlSTzDJRhQKEZP1GzEEwm5HbVfZciCzKHV40RZ4Suwcfc5TW4rB07g6Yxz+6B3u7EXFhaKHun68cmJrsmQm4sdRt6v28sVh7xlpnqzxIUmQH9ciD4g0zOap4vuGe+haUvu8u08/Kjwa/as5GumP40oU9Zn/6yM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789551019; c=relaxed/simple;
	bh=rVlNPjI4P2z37o7qE9/JXBSWEwGmZChcHXGnM7D9n6c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RCeR/mLN7qumqoum8B2gSZbt1gvKgP75nBjsGh9ukuMoD91mYhM5wN4UKo2Ln8Ztfi7qUDKDbU0B/joPuWuZ9Z0D3OD4ae/xenScyM53K5JcuUFyiHwPNmxznXy9ly3006V62EIt6J3tVvB+Q0HudAcSmABuOuCb0EBA7Kx6xjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Fs7uoYbK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fs7uoYbK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789550999;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pLJ3zniryXoIXYXj2kORk+UpoeKS9R6ImYDJyVbdKgw=;
	b=Fs7uoYbKDKY066K9mEP3HRx+ID0WQ/kgm9TcfeRaV/m2a/zUOl35CscWm0lj0D1cQaem/v
	8GDTETseFv5XUW4Waf59eLU87zvZeHYcQwD8ZJjWXk95nZSpTwms9w85ZC5lolaTKIUgQt
	SfSDULybjPURnR4f4dhCzrAI3hDsPnU=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-633-CxkmmuqtO1ujDl_2JPEx-Q-1; Wed, 16 Sep 2026 05:29:56 -0400
X-MC-Unique: CxkmmuqtO1ujDl_2JPEx-Q-1
X-Mimecast-MFC-AGG-ID: CxkmmuqtO1ujDl_2JPEx-Q_1789550995
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2ce7dff6253so21891485ad.1
        for <virtualization@lists.linux.dev>; Wed, 16 Sep 2026 02:29:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789550995; x=1790155795;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pLJ3zniryXoIXYXj2kORk+UpoeKS9R6ImYDJyVbdKgw=;
        b=JZYqCmCu1hyjRT5q5ipT7k+NbXToJKdW2zGIOpl9B1jTFE089xffr0jShAIcSJLxRt
         SANweUcSfuhW8ZYlyOHh0t6Zr6M2moOHGWtnVLR/OIAyOkASjl+EWxbxY68iuOJ0H9xV
         3im/XHXM/N/JvLx8iZYNrf/t1grksMikddiGAr1OpDzj7sVCoIxl32fSTSTajp+OsqW+
         bMJgNOQUDx4pdZcQMJAdE6/RjMHkjyFPe4kn7noCtZZ4XpbGapkwXTe2gEniXJQbKWoG
         7HyCRkMTG2eEoc+8LXgO914rkQYpFhQmEtHclieSwH+nes2R0fkSZPDj1lehoXBzkYys
         Gw7w==
X-Forwarded-Encrypted: i=1; AKwUvBxIkRBx/AHlbvT8NAB1jNZnweI2VixTMzErAwTyS0TDN10KGuQsF6gYzVVVESjXDeUMLQ8jfi1xMnVvoBvrbg==@lists.linux.dev
X-Gm-Message-State: AFuF++k/pZWGnSCqlweARA3v0aYpBuUB7cL3rCxCjlLvWCHTpppsGymI
	hnMkbhfLuQ6wxlsQCB5ZjIlYg8Ce9nR81P6V+CnBND5nSLrkwoDDMBAUfs+dy40jK8qvdBcceOI
	Gsnn5Ff3+/mI2t+uHpgD10pWXiVdkMUSUJ1rZJKKoaG1LIYR5VBHXTR3eRobeT6aHXBoc41XIR8
	gsL1eoBfzQaKp1MHx7eFlmXsw+KXW6txMYe1js1RICQyQ=
X-Gm-Gg: AYBFou1Rjm1eclovrH3MzLpYeYAy0ujApM8nHfojnXIlB/98HFLT6bfVB60kP0+V47O
	XuNfe3yx0ysMKnw9nSNahwZSK1eoD+HgwobnWPSAjB/bOSRjoQg6PSLSYfPSLVEGIvAiuTs3hsG
	2Ebe2L+IzmEuwL12kRIx2PrF2ufa6aAeqtCeLjmYh3389lFTZgOXv+QQJd
X-Received: by 2002:a17:903:3b8f:b0:2d7:4bc8:41a4 with SMTP id d9443c01a7336-2dd8ea1cd1dmr23798685ad.10.1789550995062;
        Wed, 16 Sep 2026 02:29:55 -0700 (PDT)
X-Received: by 2002:a17:903:3b8f:b0:2d7:4bc8:41a4 with SMTP id
 d9443c01a7336-2dd8ea1cd1dmr23798155ad.10.1789550994573; Wed, 16 Sep 2026
 02:29:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260911124540.279841-1-tzimmermann@suse.de> <20260911124540.279841-3-tzimmermann@suse.de>
In-Reply-To: <20260911124540.279841-3-tzimmermann@suse.de>
From: Javier Martinez Canillas <javierm@redhat.com>
Date: Wed, 16 Sep 2026 11:29:42 +0200
X-Gm-Features: AcwNN1VjQRR608PaSU5v9yXg9eP7o3aE9lu55JInhqrDujLUhvS3kxSMIUXF4N0
Message-ID: <CAFOAJEfWX09ZvnQvn1+SBeW4_MaSRO2JNLfoJRGYS4jXGr-09w@mail.gmail.com>
Subject: Re: [PATCH v5 02/14] drm/panic: Test address from kmap op for NULL
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: jfalempe@redhat.com, airlied@gmail.com, maarten.lankhorst@linux.intel.com, 
	mripard@kernel.org, geert@linux-m68k.org, rdunlap@infradead.org, 
	dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org, 
	amd-gfx@lists.freedesktop.org, rust-for-linux@vger.kernel.org, 
	linux-hyperv@vger.kernel.org, intel-gfx@lists.freedesktop.org, 
	intel-xe@lists.freedesktop.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, nouveau@lists.freedesktop.org, 
	linux-renesas-soc@vger.kernel.org, virtualization@lists.linux.dev, 
	sashiko-reviews@lists.linux.dev, stable@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 5NHHS3YVlbmPEd45VynZqTYgh9Krx7Ggxuq-PVzo7vc_1789550995
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Thomas,

On Fri, Sep 11, 2026 at 2:46=E2=80=AFPM Thomas Zimmermann <tzimmermann@suse=
.de> wrote:
>
> Do nothing if kmap_local_page_try_from_panic() returns NULL. This is
> not likely to hapen, as the previous page from the same memory area
> has been mapped successfully.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Fixes: 23437509a694 ("drm/panic: Fix 24bit pixel crossing page boundaries=
")
> Cc: Javier Martinez Canillas <javierm@redhat.com>
> Cc: Jocelyn Falempe <jfalempe@redhat.com>
> Cc: dri-devel@lists.freedesktop.org
> Cc: <stable@vger.kernel.org> # v6.18+
> ---
>  drivers/gpu/drm/drm_panic.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/drm_panic.c b/drivers/gpu/drm/drm_panic.c
> index ba21df4be338..d28ce8878e05 100644
> --- a/drivers/gpu/drm/drm_panic.c
> +++ b/drivers/gpu/drm/drm_panic.c
> @@ -178,6 +178,8 @@ static void drm_panic_write_pixel24_xpage(void *vaddr=
, struct page *next_page,
>         u8 *p =3D vaddr + offset;
>
>         vaddr2 =3D kmap_local_page_try_from_panic(next_page);
> +       if (!vaddr2)
> +               return;
>
>         *p++ =3D color & 0xff;
>         color >>=3D 8;
> --
> 2.55.0
>

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

--=20
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

