Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3AABC433F5
	for <virtualization@archiver.kernel.org>; Tue, 21 Dec 2021 05:51:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8A0DA60E8F;
	Tue, 21 Dec 2021 05:51:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5YC1P9ft5iZc; Tue, 21 Dec 2021 05:51:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 4BB3460E88;
	Tue, 21 Dec 2021 05:51:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1CE31C001E;
	Tue, 21 Dec 2021 05:51:49 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7B244C0012
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Dec 2021 05:51:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 63BA140210
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Dec 2021 05:51:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6eN6ruqgaG9z
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Dec 2021 05:51:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id BE9D240207
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Dec 2021 05:51:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1640065905;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Heamh1RFwDIi8TSAumUk982hZICCNA3wMh7aJKCBgwQ=;
 b=Z/M1alkuCDOwMU1zInNfprJaxNCJptavHZxvzh0NySbZEHMsrL5rRnII0T6nW9jMmlUUxM
 WEOaemjMAM0CpHGQZVPoW0714/OUlVu235gQiWelp3eTltl5aTpwdszIGYtuJP+fY710To
 2KIoHiBaIMMYkdA0dDI2ujs7hjc3rDk=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-654-gi7BmcN6NCmjk-muM-Q0hw-1; Tue, 21 Dec 2021 00:51:44 -0500
X-MC-Unique: gi7BmcN6NCmjk-muM-Q0hw-1
Received: by mail-lf1-f70.google.com with SMTP id
 b35-20020a0565120ba300b0042604bb4857so1739698lfv.19
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Dec 2021 21:51:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Heamh1RFwDIi8TSAumUk982hZICCNA3wMh7aJKCBgwQ=;
 b=a03rTZsbz/rNqoEV/jH94XS9mQg9GTiztqhbQOaCnMw6SVlVhh0q95PQrA4mzdXJ10
 D1YhJs+pQhsyX4oO77BKsdTldhOov1wUQkAiED10W4Dr+020HFBzM18PtL3/vXh0DLE2
 EoDcQ9BI5B979KqA3cq0D3SYlTsmfQyCFK7z73LntiPf4U8XpFuREfKlRuUvYQqZsvyF
 vUhc25J8uJPhdcG3TCW5Sr5nPnzREA9Rr1pPVgnIZ9h+pzAQIo6i1ELLcgvIwLV+gNWL
 ixaiuLLy6ZplGHK9uBYlwjSLXJQHDeFSPn2ibhvdEvxcVPn8OsQB3gGxjP0GSW+kwwPm
 LIlA==
X-Gm-Message-State: AOAM531na+W9BULTch62tyDYHVXRxUw7HuYpBTicKJZsRmJetzx8iknc
 F5+aCYZ7fdrRyuh/BdbFc4hnC/768aJgX3pOOnZP2wym+WpAjsYvyKTUp7nAe+WAA9kKD8G2wmA
 zzKk+34z2eFUsuS+Du1JXEKUDQNXOAmtcYT+lTDuSzH4TaK4yjvdwqlXSzQ==
X-Received: by 2002:a05:6512:3d21:: with SMTP id
 d33mr1698342lfv.481.1640065903094; 
 Mon, 20 Dec 2021 21:51:43 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxcniHeeHgtiTPTf4uvbyNrmsROXZ8VFvmN2ylq6QMU8XNU0JaJXFf3H3Zr+KEuCf+oibDHT+QE08RtP7U/voY=
X-Received: by 2002:a05:6512:3d21:: with SMTP id
 d33mr1698325lfv.481.1640065902865; 
 Mon, 20 Dec 2021 21:51:42 -0800 (PST)
MIME-Version: 1.0
References: <20211219140236.27479-1-elic@nvidia.com>
 <20211219140236.27479-4-elic@nvidia.com>
In-Reply-To: <20211219140236.27479-4-elic@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 21 Dec 2021 13:51:32 +0800
Message-ID: <CACGkMEsjmOBAW9t__=o=jeKA6f8inr3D6CVidoSc3wjX9DE5Lw@mail.gmail.com>
Subject: Re: [PATCH v3 03/10] vdpa: Read device configuration only if
 FEATURES_OK
To: Eli Cohen <elic@nvidia.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Laurent Vivier <lvivier@redhat.com>, mst <mst@redhat.com>,
 virtualization <virtualization@lists.linux-foundation.org>,
 eperezma <eperezma@redhat.com>, Si-Wei Liu <si-wei.liu@oracle.com>
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

On Sun, Dec 19, 2021 at 10:03 PM Eli Cohen <elic@nvidia.com> wrote:
>
> Avoid reading device configuration during feature negotiation. Read
> device status and verify that VIRTIO_CONFIG_S_FEATURES_OK is set.
> Otherwise, return -EAGAIN.
>
> Signed-off-by: Eli Cohen <elic@nvidia.com>
> ---
>  drivers/vdpa/vdpa.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
> index 42d71d60d5dc..5749cf0a1500 100644
> --- a/drivers/vdpa/vdpa.c
> +++ b/drivers/vdpa/vdpa.c
> @@ -819,8 +819,15 @@ vdpa_dev_config_fill(struct vdpa_device *vdev, struct sk_buff *msg, u32 portid,
>  {
>         u32 device_id;
>         void *hdr;
> +       u8 status;
>         int err;
>
> +       status = vdev->config->get_status(vdev);
> +       if (!(status & VIRTIO_CONFIG_S_FEATURES_OK)) {
> +               NL_SET_ERR_MSG_MOD(extack, "Features negotiation not completed");
> +               return -EAGAIN;
> +       }
> +

I wonder how we synchronize this with set_status(), set/get_config()?

Thanks

>         hdr = genlmsg_put(msg, portid, seq, &vdpa_nl_family, flags,
>                           VDPA_CMD_DEV_CONFIG_GET);
>         if (!hdr)
> --
> 2.34.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
