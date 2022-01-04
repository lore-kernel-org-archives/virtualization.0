Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EF89C433F5
	for <virtualization@archiver.kernel.org>; Tue,  4 Jan 2022 02:43:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9617A4021F;
	Tue,  4 Jan 2022 02:43:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VejsGzp_VLjC; Tue,  4 Jan 2022 02:43:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 45689403EC;
	Tue,  4 Jan 2022 02:43:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 18885C002F;
	Tue,  4 Jan 2022 02:43:45 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4E118C001E
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Jan 2022 02:43:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 356AD400F5
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Jan 2022 02:43:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1rjx3yuVEfGY
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Jan 2022 02:43:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D7964400BA
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Jan 2022 02:43:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1641264220;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xBslvMS7j+OctKnC0vneQW1w3vJZ3surxo53C/HUGEM=;
 b=TmTbyQzK12Nud+Q/IKdpAnQa0fZJ9lGHb5KuhYQQ0+eCnhzSU+ge+s063V1wmatDFqUwF2
 EeNPMgtd29SnhEU47np0E0ioy6BsjE3qy1K4lddvEjFsJgBeE5NZu89CRUysfpreoa8ltj
 zrjyNxzhzsiixIj8gn8vz1TuV9bDjb4=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-86-Dl5cg9BZPAa4moMTVh3l1w-1; Mon, 03 Jan 2022 21:43:37 -0500
X-MC-Unique: Dl5cg9BZPAa4moMTVh3l1w-1
Received: by mail-lf1-f70.google.com with SMTP id
 b19-20020ac24113000000b004297f324073so4833657lfi.8
 for <virtualization@lists.linux-foundation.org>;
 Mon, 03 Jan 2022 18:43:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=xBslvMS7j+OctKnC0vneQW1w3vJZ3surxo53C/HUGEM=;
 b=qLoTYhLFBAM48VtcfOjj+eRhX/31iOMTkZbl8BP11J85lWxal0Uil0QeS3b9C0IBqb
 34GyE19EpBga4PFxW101vQZ8IfCLX7zt/wPUxBQV7ef0M1UGDEujsgh5yGGMIn2DgiFD
 9PkyEEKckyUMV7tzLudaBaWRF/YG999r7rhzB+Izs6d4SUcMeYcyOuY7h7HyqcAwuoN+
 +7/mxcWw1TdhIp9KynQODCpWmMKxGHoS+vms54GQOdhW7U/4YYUTUyJygL/1Df/lY93P
 2yeLy4oaOuLsKpCUhgssRel/nesV7OKsWp9akrT4DZ4sQEJaBzi1zNk/hHnbrDdGYDVu
 vLRQ==
X-Gm-Message-State: AOAM530iRhVR60hNLnCduyfVkigyUV8Fh5BWKI0t7VGSWReEbKWjlzVh
 eASqoQf9///NrMBvFtQQvrY/NGXuSMg1rT4DSH4VhZZmZWdDLuvquY1iUzthtxJWT+UZTnVO4mc
 m8Tip8zUOWx9ymx3lr9v+34VqxnOCB8fVrnAnkD+B7VKBC5+rPOyZhhW/sg==
X-Received: by 2002:a2e:9183:: with SMTP id f3mr38554764ljg.277.1641264216408; 
 Mon, 03 Jan 2022 18:43:36 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwDbiCQYGh9CsuhsNELkivaGuy6UvE67yd+cdY22itZ/NeBscfWPAKaNz7nsrSrObNqVuf/rYup8jrDIjAPQl8=
X-Received: by 2002:a2e:9183:: with SMTP id f3mr38554748ljg.277.1641264216229; 
 Mon, 03 Jan 2022 18:43:36 -0800 (PST)
MIME-Version: 1.0
References: <20211230142024.142979-1-elic@nvidia.com>
 <PH0PR12MB54817F9FCB3549B1677C8012DC459@PH0PR12MB5481.namprd12.prod.outlook.com>
In-Reply-To: <PH0PR12MB54817F9FCB3549B1677C8012DC459@PH0PR12MB5481.namprd12.prod.outlook.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 4 Jan 2022 10:43:25 +0800
Message-ID: <CACGkMEss0L9=PgT197mwPh-kFyKxnWLrtL-ypJ1doCGmJXVcyQ@mail.gmail.com>
Subject: Re: [PATCH] vdpa/mlx5: Fix wrong configuration of virtio_version_1_0
To: Parav Pandit <parav@nvidia.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: "lvivier@redhat.com" <lvivier@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "eperezma@redhat.com" <eperezma@redhat.com>,
 "si-wei.liu@oracle.com" <si-wei.liu@oracle.com>, Eli Cohen <elic@nvidia.com>
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Thu, Dec 30, 2021 at 10:49 PM Parav Pandit <parav@nvidia.com> wrote:
>
>
> > From: Eli Cohen <elic@nvidia.com>
> > Sent: Thursday, December 30, 2021 7:50 PM
> >
> > Remove overriding of virtio_version_1_0 which forced the virtqueue object to
> > version 1.
> >
> > Fixes: 1a86b377aa21 ("vdpa/mlx5: Add VDPA driver for supported mlx5
> > devices")
> > Signed-off-by: Eli Cohen <elic@nvidia.com>
> > ---
> >  drivers/vdpa/mlx5/net/mlx5_vnet.c | 2 --
> >  1 file changed, 2 deletions(-)
> >
> > diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > index 1eb473cb9d4d..e946a36bf7ee 100644
> > --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > @@ -871,8 +871,6 @@ static int create_virtqueue(struct mlx5_vdpa_net
> > *ndev, struct mlx5_vdpa_virtque
> >       MLX5_SET(virtio_q, vq_ctx, umem_3_id, mvq->umem3.id);
> >       MLX5_SET(virtio_q, vq_ctx, umem_3_size, mvq->umem3.size);
> >       MLX5_SET(virtio_q, vq_ctx, pd, ndev->mvdev.res.pdn);
> > -     if (MLX5_CAP_DEV_VDPA_EMULATION(ndev->mvdev.mdev,
> > eth_frame_offload_type))
> > -             MLX5_SET(virtio_q, vq_ctx, virtio_version_1_0, 1);
> >
> >       err = mlx5_cmd_exec(ndev->mvdev.mdev, in, inlen, out, sizeof(out));
> >       if (err)
> > --
> > 2.34.1
>
> Reviewed-by: Parav Pandit <parav@nvidia.com>
>

Acked-by: Jason Wang <jasowang@redhat.com>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
