Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B824AC636CD
	for <virtualization@archiver.kernel.org>; Tue, 31 Jan 2023 05:23:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 34389400EC;
	Tue, 31 Jan 2023 05:23:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 34389400EC
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=bknq3fgd
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0XkrSThAIEmT; Tue, 31 Jan 2023 05:23:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 9D9D7400AF;
	Tue, 31 Jan 2023 05:23:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9D9D7400AF
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7D01CC0032;
	Tue, 31 Jan 2023 05:23:23 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5D925C002B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 Jan 2023 05:23:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 304F18132D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 Jan 2023 05:23:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 304F18132D
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=bknq3fgd
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3FmYqpfc8eND
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 Jan 2023 05:23:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8583F812D6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8583F812D6
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 Jan 2023 05:23:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1675142599;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tBuwpBVXvpFhXGcDe/LdMP61Sfzf57MnN//0wiFS4tA=;
 b=bknq3fgdbkDTwq1TVPDd65JuilgHInI9BT8Pf20onM44IZ9HT017XHk8C1K7RYCWhGReus
 vrWliDnMLT5LxlSrufweKT97nMIjbZiGu9JHMg11jE3QBjuNEh2396hVOhpXlRPyYEl/Gt
 p3j5LSc/LK3m41BDjLIa8Zpt5f22/gc=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-8-F0OZhevCP9WDrwV5c2jAbQ-1; Tue, 31 Jan 2023 00:23:17 -0500
X-MC-Unique: F0OZhevCP9WDrwV5c2jAbQ-1
Received: by mail-ot1-f71.google.com with SMTP id
 e19-20020a0568301e5300b0068bc4598b80so3478497otj.23
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Jan 2023 21:23:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tBuwpBVXvpFhXGcDe/LdMP61Sfzf57MnN//0wiFS4tA=;
 b=3zflKZIIctXyA6b+Zta/mj+JFL195TtIavQ5vvAXaGOTvR73EFKwrGEPHneE1HO0a/
 vqidGv2m3PRS+0bytj8x1cOuubLnWVGBdhizfVJ7aG93lShrDtw0NmKFJKyx883v+450
 953QUfjxGPu/xPhWqVYhKMv4qsMFwx+FuuAgT1FsuDTvHGePZandotzDMKnucW9ZG6Ld
 9vq/Dcr5LAfP8nVHgXlvIQYOdEpgXB3X/znDmSs4smOuFx+VJTMHLZyGv/dTzvCRN7HQ
 pJe7z7oNxMBCqddl30JVrwSYF+jvY4iMK72NZXR1GHjztwzBgb0yv/r0QvO5UhVurQ3q
 s/nA==
X-Gm-Message-State: AFqh2krc7JPKUpMUE4yl90RABpQqvZwok/5aQr9Q5i+l7c398WFopJzF
 8AjTd8dE7jVvdq7b/bJRvwlozpzN+l47c2IwK7pCU0qUueL8ninXD5bmmW2sU7SyFBaWJzpaex5
 AS11rFMru3X6dOjIzCO4wY4WW7kEMryNTEJcQCzbCRx9PP2kxObkUze8g0g==
X-Received: by 2002:a05:6871:10e:b0:15b:96b5:9916 with SMTP id
 y14-20020a056871010e00b0015b96b59916mr4391888oab.280.1675142596890; 
 Mon, 30 Jan 2023 21:23:16 -0800 (PST)
X-Google-Smtp-Source: AMrXdXtz7jMxZSFLd+CNnOJpiqDKGvOYMcNJ6sBtUoRkm8qhoapPK42eBepYF1fhvcrqoTDubwtnrXBwROgRvtImXgM=
X-Received: by 2002:a05:6871:10e:b0:15b:96b5:9916 with SMTP id
 y14-20020a056871010e00b0015b96b59916mr4391882oab.280.1675142596696; Mon, 30
 Jan 2023 21:23:16 -0800 (PST)
MIME-Version: 1.0
References: <20230130092644.37002-1-colin.i.king@gmail.com>
In-Reply-To: <20230130092644.37002-1-colin.i.king@gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 31 Jan 2023 13:23:05 +0800
Message-ID: <CACGkMEu9eg3aem4a_Xu_uxn4HvifyQqe-JRfH0rdxXDmsMfDuw@mail.gmail.com>
Subject: Re: [PATCH][next] vdpa: Fix a couple of spelling mistakes in some
 messages
To: Colin Ian King <colin.i.king@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: kernel-janitors@vger.kernel.org, virtualization@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, "Michael S . Tsirkin" <mst@redhat.com>
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

On Mon, Jan 30, 2023 at 5:26 PM Colin Ian King <colin.i.king@gmail.com> wrote:
>
> There are two spelling mistakes in some literal strings. Fix them.
>
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

> ---
>  drivers/vdpa/vdpa.c                  | 2 +-
>  drivers/vdpa/vdpa_sim/vdpa_sim_net.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
> index 6821b2850bbb..a1bb5b92212d 100644
> --- a/drivers/vdpa/vdpa.c
> +++ b/drivers/vdpa/vdpa.c
> @@ -1016,7 +1016,7 @@ static int vdpa_dev_vendor_stats_fill(struct vdpa_device *vdev,
>         switch (device_id) {
>         case VIRTIO_ID_NET:
>                 if (index > VIRTIO_NET_CTRL_MQ_VQ_PAIRS_MAX) {
> -                       NL_SET_ERR_MSG_MOD(info->extack, "queue index excceeds max value");
> +                       NL_SET_ERR_MSG_MOD(info->extack, "queue index exceeds max value");
>                         err = -ERANGE;
>                         break;
>                 }
> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
> index e827708adcca..862f405362de 100644
> --- a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
> @@ -324,7 +324,7 @@ static int vdpasim_net_get_stats(struct vdpasim *vdpasim, u16 idx,
>                                       rx_errors, VDPA_ATTR_PAD))
>                         break;
>                 if (nla_put_string(msg, VDPA_ATTR_DEV_VENDOR_ATTR_NAME,
> -                                 "rx overrunss"))
> +                                 "rx overruns"))
>                         break;
>                 if (nla_put_u64_64bit(msg, VDPA_ATTR_DEV_VENDOR_ATTR_VALUE,
>                                       rx_overruns, VDPA_ATTR_PAD))
> --
> 2.30.2
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
