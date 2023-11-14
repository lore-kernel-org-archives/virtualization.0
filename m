Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C02B8F45
	for <virtualization@lists.linux-foundation.org>; Tue, 14 Nov 2023 03:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hiJicVyN"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DFBE6418AB
	for <virtualization@lists.linux-foundation.org>; Tue, 14 Nov 2023 03:13:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org DFBE6418AB
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=hiJicVyN
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rwabPvX-t4yg
	for <virtualization@lists.linux-foundation.org>;
	Tue, 14 Nov 2023 03:13:41 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp4.osuosl.org (Postfix) with ESMTPS id AA3A9418DA
	for <virtualization@lists.linux-foundation.org>; Tue, 14 Nov 2023 03:13:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org AA3A9418DA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699931619;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v2XQGJKstu4UYjqmSxXC9jloqmIRxuV+9jTNIdrsN00=;
	b=hiJicVyNmOx8U0Fbs7v5DrVFRUlsRuy30CDKjc/C5erRvXjRUvB1XLrB6SOWUsxDoaCm9v
	CcNB5QnYpcrX4r0C70WetlR3mSPEqqFmpLLoXwkd47ZiIbE3suNXyfzPv3vVXa8pZZXiH3
	/dJLC3nT5dAOn3ix562Aro/sIsbHGcA=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-459-KQ5m_wc5P2C4vWkCcLuwJQ-1; Mon, 13 Nov 2023 22:13:38 -0500
X-MC-Unique: KQ5m_wc5P2C4vWkCcLuwJQ-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-5079a3362afso4705546e87.3
        for <virtualization@lists.linux-foundation.org>; Mon, 13 Nov 2023 19:13:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699931616; x=1700536416;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v2XQGJKstu4UYjqmSxXC9jloqmIRxuV+9jTNIdrsN00=;
        b=lMYP7KNLEijqg1V+wpxiGCY8yKR36OpyAwzdRIBypnTahd3R/CLQ7x0XkRQPeBfrht
         2AnhR+kY2uQZdhjVuTJloCqlXvQZGpcn2THU+UeI6PxO0+orw1zdhZngNT3lPFgrPdz0
         MwUtYNDeVx0UWPt51WFwprpTQxgIAX6XZzVODa3iM3XScMGKqbvRPf34BckDvqOxzexU
         TiRwmYp1f51YRspC8eVEldBeEaGrUa6LJPVpHRoO/RV6o5KYacYFHYEJrn3wSHZnyJIQ
         dcOn+Vjt9t6DgnWAD6nncJNxeg5ZVDdrSdoNS2BBLNBsd6PMVr0JzkyPaZ+DSzbvgFER
         /yog==
X-Gm-Message-State: AOJu0Yzj1ZgRDQ2AF5eh+lQPUEO+/7EzO9XEJ+0Y5qAWKtPZMZeb9K5o
	cEOkZ0D7UXp72y3X7To8ZOJcBfIrTS2jiIHSg9/2IVlsS52LTnsUqf0rdw9m06Lg7r1k68kZRSB
	vy3Lc72GdUd9+pzCIhuwzFkk/0a7ZseJDN5p/aorwZ56INSQTEV+i6VfB6A==
X-Received: by 2002:a19:5e47:0:b0:509:476a:ee51 with SMTP id z7-20020a195e47000000b00509476aee51mr5336064lfi.20.1699931616740;
        Mon, 13 Nov 2023 19:13:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGCSX/GmzmA4cB+MfJR1TM5jivE4LTGkWEma8DZRcANS34EeLHcLMHMkqgEjigsE9xzqlDGblYO14wKBmnhzrQ=
X-Received: by 2002:a19:5e47:0:b0:509:476a:ee51 with SMTP id
 z7-20020a195e47000000b00509476aee51mr5336054lfi.20.1699931616357; Mon, 13 Nov
 2023 19:13:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20231110221802.46841-1-shannon.nelson@amd.com> <20231110221802.46841-4-shannon.nelson@amd.com>
In-Reply-To: <20231110221802.46841-4-shannon.nelson@amd.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 14 Nov 2023 11:13:25 +0800
Message-ID: <CACGkMEuhn5zrfnqCU0Ovir4o_F9fXj86_pxmqAEEepESYM++tg@mail.gmail.com>
Subject: Re: [PATCH virtio 3/3] pds_vdpa: set features order
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
> Fix up the order that the device and negotiated features
> are checked to get a more reliable difference when things
> get changed.
>
> Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
> ---
>  drivers/vdpa/pds/vdpa_dev.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/vdpa/pds/vdpa_dev.c b/drivers/vdpa/pds/vdpa_dev.c
> index 9fc89c82d1f0..25c0fe5ec3d5 100644
> --- a/drivers/vdpa/pds/vdpa_dev.c
> +++ b/drivers/vdpa/pds/vdpa_dev.c
> @@ -318,9 +318,8 @@ static int pds_vdpa_set_driver_features(struct vdpa_d=
evice *vdpa_dev, u64 featur
>                 return -EOPNOTSUPP;
>         }
>
> -       pdsv->negotiated_features =3D nego_features;
> -
>         driver_features =3D pds_vdpa_get_driver_features(vdpa_dev);
> +       pdsv->negotiated_features =3D nego_features;

I may miss something, but I don't see how things have changed here.

Thanks

>         dev_dbg(dev, "%s: %#llx =3D> %#llx\n",
>                 __func__, driver_features, nego_features);
>
> --
> 2.17.1
>

