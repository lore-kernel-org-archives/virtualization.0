Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25EBD79DE
	for <virtualization@lists.linux-foundation.org>; Tue, 14 Nov 2023 03:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LGF5n5Vw"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 83E6440199
	for <virtualization@lists.linux-foundation.org>; Tue, 14 Nov 2023 03:11:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 83E6440199
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=LGF5n5Vw
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5GkQoFoTCGYT
	for <virtualization@lists.linux-foundation.org>;
	Tue, 14 Nov 2023 03:11:44 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 9B1D74016D
	for <virtualization@lists.linux-foundation.org>; Tue, 14 Nov 2023 03:11:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9B1D74016D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699931503;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yLIgZFqktIUbYjKto+HT3aySHlcYjrQok8GO+0m1UHM=;
	b=LGF5n5VwoMKZrdUgLl/WFeY2q05yAyLrnW2VRVu9HD2svi7GLErD41+5ZxFn24+mzgKxPU
	tmxG+CxURxu4Ee6BYoURgy2lx47t7TCs11+kNJKj5PNzBWEXJggoGVzX5xn9YfHpXapwF0
	W99v7G7N5EePwnfk9TZh/VY0+RoyVOg=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-588-iAmlDEccNSaFfj4zenmsEg-1; Mon, 13 Nov 2023 22:11:41 -0500
X-MC-Unique: iAmlDEccNSaFfj4zenmsEg-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-5079fe7cc7cso5480944e87.2
        for <virtualization@lists.linux-foundation.org>; Mon, 13 Nov 2023 19:11:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699931499; x=1700536299;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yLIgZFqktIUbYjKto+HT3aySHlcYjrQok8GO+0m1UHM=;
        b=fHb0jfz8/+3XU3Ti8tnkZxipZWwI/eIZ9ztbT7UkDxNzmkmghEuujMjv6LhtEDXHQ/
         NxHRXWzor4AMbkGdSeJ/GxNBMTBn9aJLYmWt5T4A7qSKNCaTFOsBvy0zmrRPEcfRg+iv
         kgGpOMZ00ItbA3LeBsuw+YCsKxkqAQ6Ncm/O+lzsrHiqENmPdthiQepKMimHu8rpk7Q9
         +xt/FX7dXTx/gmBl+6nPqBp7H2qkQcjWQaGk0eQEtA++LMqw4xV17VS3NgfJ3phU3wdS
         L1plZzoQTxwZbSvbjb67aZvD6HyMuRjgcNDzZYztzo6LEy0vgoqCb5TjBsFH9Qfzl2qj
         S8tw==
X-Gm-Message-State: AOJu0YyTDFPrdSk2k7Z+xivXkDaPHuTEyqDfbBRYhrH/4lvwMdz1JbSE
	zpoMuI86snJar/GwoLBHJSi0Pp4Qq5dzP4at34pdoy+X4SnBRgpogdIS0l7x8hV4gpLVWpDQDFS
	uEtMyIdNvBn2HCnuNZ++9m0Ho2ysNHKlmCPMyW8cXkGKhK6JgUen8Daof/g==
X-Received: by 2002:a05:6512:1087:b0:50a:71db:888 with SMTP id j7-20020a056512108700b0050a71db0888mr6736182lfg.17.1699931499771;
        Mon, 13 Nov 2023 19:11:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHoEDwx0/dcNQ1JUOCTutX86o569i0q5eIzO6KYUrhI01+Q+GqaOm9h6DiJyfNyPEgW4cYoG/nSBiAsJE8Jobg=
X-Received: by 2002:a05:6512:1087:b0:50a:71db:888 with SMTP id
 j7-20020a056512108700b0050a71db0888mr6736168lfg.17.1699931499423; Mon, 13 Nov
 2023 19:11:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20231110221802.46841-1-shannon.nelson@amd.com> <20231110221802.46841-3-shannon.nelson@amd.com>
In-Reply-To: <20231110221802.46841-3-shannon.nelson@amd.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 14 Nov 2023 11:11:28 +0800
Message-ID: <CACGkMEs65qa8dJMpK4SNN9KGPK3g8mFsOrboSGS3KZ76ACVcvQ@mail.gmail.com>
Subject: Re: [PATCH virtio 2/3] pds_vdpa: clear config callback when status
 goes to 0
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
> If the client driver is setting status to 0, something is
> getting shutdown and possibly removed.  Make sure we clear
> the config_cb so that it doesn't end up crashing when
> trying to call a bogus callback.
>
> Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

> ---
>  drivers/vdpa/pds/vdpa_dev.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/vdpa/pds/vdpa_dev.c b/drivers/vdpa/pds/vdpa_dev.c
> index 52b2449182ad..9fc89c82d1f0 100644
> --- a/drivers/vdpa/pds/vdpa_dev.c
> +++ b/drivers/vdpa/pds/vdpa_dev.c
> @@ -461,8 +461,10 @@ static void pds_vdpa_set_status(struct vdpa_device *=
vdpa_dev, u8 status)
>
>         pds_vdpa_cmd_set_status(pdsv, status);
>
> -       /* Note: still working with FW on the need for this reset cmd */
>         if (status =3D=3D 0) {
> +               struct vdpa_callback null_cb =3D { };
> +
> +               pds_vdpa_set_config_cb(vdpa_dev, &null_cb);
>                 pds_vdpa_cmd_reset(pdsv);
>
>                 for (i =3D 0; i < pdsv->num_vqs; i++) {
> --
> 2.17.1
>

