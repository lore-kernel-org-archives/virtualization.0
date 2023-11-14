Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D002D185D
	for <virtualization@lists.linux-foundation.org>; Tue, 14 Nov 2023 03:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FSUTTpax"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 3A511401A4
	for <virtualization@lists.linux-foundation.org>; Tue, 14 Nov 2023 03:11:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3A511401A4
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FSUTTpax
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 14CTBF7DYpmA
	for <virtualization@lists.linux-foundation.org>;
	Tue, 14 Nov 2023 03:11:12 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp2.osuosl.org (Postfix) with ESMTPS id AF6BD40015
	for <virtualization@lists.linux-foundation.org>; Tue, 14 Nov 2023 03:11:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org AF6BD40015
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699931471;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eNaeRiSsktA6pnSGxMvukUXcHNGp1X9/xR1jkt+YMck=;
	b=FSUTTpaxazhONKG+EHh9qCl9/6c8zgEIOGFsvfRtGen2ZA/ub8O5kMrQN13xJ4bmQcNYCL
	ezlOFKhvRFrWQNfx5safPbQX5eS5HDHyz1ycR+z5englJ442YqTL+44vSlENe9RPdfLRcA
	jzA3/MRgr+tq+fQ0+0hbp2ig0frUm0M=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-121-vDyKIMi8PQCpV_Z5bQVwvA-1; Mon, 13 Nov 2023 22:11:08 -0500
X-MC-Unique: vDyKIMi8PQCpV_Z5bQVwvA-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-509d0c2b075so3696972e87.1
        for <virtualization@lists.linux-foundation.org>; Mon, 13 Nov 2023 19:11:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699931467; x=1700536267;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eNaeRiSsktA6pnSGxMvukUXcHNGp1X9/xR1jkt+YMck=;
        b=EJDYb0NXGZAehFoXjC3DpYnkAeBTVkpDfUezREnnrVY/WRJxRwU8piCmI/HKq/N0fU
         MilZfhqEZJ33+PwNbhOeObKCsIqAThbQTWAiRF7BLND8RGdY+bV2jYFwoOG2Gdxjg6SJ
         P4WkaWTM+rdAg1vKVddfry6j3QAR96Aolv2XlS+6ianBiEfHNl08bWcmEnXHSGKWxTcH
         6EEsWmtTeZxhHSjzCEOHH/+zCGZK25Rr/JcNNtQFO46kJ8Nf4/vLncI/wpHf373n+u8V
         9nUJM8gA3fXyxnC0UUbkLdkf2sBItbbZvmMem42+jEMMPhpNA4f4VYjBhDxZodk/viLO
         MUvg==
X-Gm-Message-State: AOJu0YyF/yR0dmJdmJyq9s2qDdGKivBRDDGGr2WDAQqvKd9Vk2uUXUnN
	+r+zmA+rcmh3rDju5f3wxcvXRdMpcWNwp/YM/RF2WJHAP+Znd5zwehJXr8r52lmuRGx/GxBEESI
	353zMkj7+VbtA4nIDJ7IpGtAAK+O4EEbOk+8b+xf27eQ8ak/+yPLReZ+VGw==
X-Received: by 2002:ac2:47fa:0:b0:509:4492:2a94 with SMTP id b26-20020ac247fa000000b0050944922a94mr5068623lfp.49.1699931467314;
        Mon, 13 Nov 2023 19:11:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG80SAzVdqk8T98YpJPrNaw2fd92g20k5qDfYw4eZbGb65ajS3NI6MswdquG3nGbYWUg+VaWI9PxRVmG4T7MgQ=
X-Received: by 2002:ac2:47fa:0:b0:509:4492:2a94 with SMTP id
 b26-20020ac247fa000000b0050944922a94mr5068616lfp.49.1699931466937; Mon, 13
 Nov 2023 19:11:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20231110221802.46841-1-shannon.nelson@amd.com> <20231110221802.46841-2-shannon.nelson@amd.com>
In-Reply-To: <20231110221802.46841-2-shannon.nelson@amd.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 14 Nov 2023 11:10:55 +0800
Message-ID: <CACGkMEtTT+UJdM3r17z41r=1HYf8eA-VAB56G3R81t=ZQ6rebw@mail.gmail.com>
Subject: Re: [PATCH virtio 1/3] pds_vdpa: fix up format-truncation complaint
To: Shannon Nelson <shannon.nelson@amd.com>
Cc: mst@redhat.com, virtualization@lists.linux-foundation.org, 
	brett.creeley@amd.com, lkp@intel.com, drivers@pensando.io
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 11, 2023 at 6:18=E2=80=AFAM Shannon Nelson <shannon.nelson@amd.=
com> wrote:
>
> Our friendly kernel test robot has recently been pointing out
> some format-truncation issues.  Here's a fix for one of them.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202311040109.RfgJoE7L-lkp@i=
ntel.com/
> Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>

Acked-by: Jason Wang <jasowang@redhat.com>

I think this is needed for -stable?

Thanks

> ---
>  drivers/vdpa/pds/debugfs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/vdpa/pds/debugfs.c b/drivers/vdpa/pds/debugfs.c
> index 9b04aad6ec35..c328e694f6e7 100644
> --- a/drivers/vdpa/pds/debugfs.c
> +++ b/drivers/vdpa/pds/debugfs.c
> @@ -261,7 +261,7 @@ void pds_vdpa_debugfs_add_vdpadev(struct pds_vdpa_aux=
 *vdpa_aux)
>         debugfs_create_file("config", 0400, vdpa_aux->dentry, vdpa_aux->p=
dsv, &config_fops);
>
>         for (i =3D 0; i < vdpa_aux->pdsv->num_vqs; i++) {
> -               char name[8];
> +               char name[16];
>
>                 snprintf(name, sizeof(name), "vq%02d", i);
>                 debugfs_create_file(name, 0400, vdpa_aux->dentry,
> --
> 2.17.1
>

