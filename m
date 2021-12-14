Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F161C433F5
	for <virtualization@archiver.kernel.org>; Tue, 14 Dec 2021 03:44:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 0A5E940137;
	Tue, 14 Dec 2021 03:44:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4_SaODjEfyBD; Tue, 14 Dec 2021 03:44:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 728C3400F5;
	Tue, 14 Dec 2021 03:44:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 53745C001E;
	Tue, 14 Dec 2021 03:44:26 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 70D2EC0012
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Dec 2021 03:44:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5C1D94010E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Dec 2021 03:44:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yLFUdbpAhRSG
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Dec 2021 03:44:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 847CB400F5
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Dec 2021 03:44:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1639453463;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=adf7D2GDWtV+LegCQwKjdwJVyhLRb+p86YYDf4Dk4rc=;
 b=AmVAcL7pJ3W4Djh4mSZhBXD9UOIw0fxydzc80G5Ipw1VUTcjmtPDIzoXWOFawJBcyDmRKe
 CUASTRTZJ8RS4DF/UBCoqnVoXiYGmjbDk+3fJCwRP7ggzKiLlTP3U+KIf0Om6DLho0dg5n
 KM3dWpuHUUTY4ACqOFRfJyR1tWiMKbc=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-589-9G-5-RHHM8WSrUjIzcLkyg-1; Mon, 13 Dec 2021 22:44:19 -0500
X-MC-Unique: 9G-5-RHHM8WSrUjIzcLkyg-1
Received: by mail-lf1-f72.google.com with SMTP id
 m2-20020a056512014200b0041042b64791so8442676lfo.6
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Dec 2021 19:44:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=adf7D2GDWtV+LegCQwKjdwJVyhLRb+p86YYDf4Dk4rc=;
 b=UGQ4iOi06i6SRO9C5CyfQBYyepJM5XncJv8ssQCR6+Ya1BVfCazmn3a8S8zICJqLBN
 W4+LTQgYM+p8Wid1uS1+jwAPuitBIkhkoOON3PvJ4argzTtFf7QkZA1ZTRU43CP0ml5s
 2w+VLHIlTiOXiceJame/Y2cPds7Q1uutEAmOsxmYjaCM/H6RKqoCJXTaAr5jMX+diwLW
 12A7n2/fNQml5+vkEy463vwPj1tr5XK1mYbUzTka7pBB2op92QFu5Dn9W2Wqmt7qMXBH
 Lh655QgC+XiA8vV7BKm2udsYVd0QjWEnw7q0ZWZm0iBLi2E+K6ZU0dDAYba1z+LI2Hth
 gnGA==
X-Gm-Message-State: AOAM533a4TqrT8lDJFrW5/Tw9NoibavCw9HDqnJjJABb/w2QAIrLa089
 K26sbIAT9lGSyXv/qMpgyGa67Ya+GopzNi8ZAntizRfQ6c5BFwNJNnqqxytaM/TEgm1IERBlzSf
 a7RqN8Yg8EXd5qBEEylwHgumxT3YrNUmnzW0Icn//Tmz+WpRA/Ng00eAFvg==
X-Received: by 2002:ac2:50c6:: with SMTP id h6mr2481946lfm.580.1639453457859; 
 Mon, 13 Dec 2021 19:44:17 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyhOx6O6xnapuOaBnNftMrCqQK0u5v3/xsEf4XeHJwzsHPi0dNnZjcoeRVCPMIWXuMO5S7XXT0GJnTT248ClpE=
X-Received: by 2002:ac2:50c6:: with SMTP id h6mr2481927lfm.580.1639453457711; 
 Mon, 13 Dec 2021 19:44:17 -0800 (PST)
MIME-Version: 1.0
References: <20211213144258.179984-1-elic@nvidia.com>
 <20211213144258.179984-4-elic@nvidia.com>
In-Reply-To: <20211213144258.179984-4-elic@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 14 Dec 2021 11:44:06 +0800
Message-ID: <CACGkMEuJPc6jU0f3ZjEJJoXqZ_07WXEUcZoU0UgFoBPXUu0K-Q@mail.gmail.com>
Subject: Re: [PATCH v2 03/10] vdpa: Read device configuration only if
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

On Mon, Dec 13, 2021 at 10:43 PM Eli Cohen <elic@nvidia.com> wrote:
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
>         hdr = genlmsg_put(msg, portid, seq, &vdpa_nl_family, flags,
>                           VDPA_CMD_DEV_CONFIG_GET);
>         if (!hdr)

It looks to me we need to synchronize this with set_status() and
cf_mutex (set_config).

Or simply return all the config space (the maximum set of features)

Thanks

> --
> 2.33.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
