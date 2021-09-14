Return-Path: <SRS0=LSNt=OE=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E30B2C433EF
	for <virtualization@archiver.kernel.org>; Tue, 14 Sep 2021 02:54:52 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F4D361108
	for <virtualization@archiver.kernel.org>; Tue, 14 Sep 2021 02:54:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9F4D361108
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6AF1980EE1;
	Tue, 14 Sep 2021 02:54:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HWcBXJsUzrzS; Tue, 14 Sep 2021 02:54:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 2A80380EC9;
	Tue, 14 Sep 2021 02:54:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DDD9CC0011;
	Tue, 14 Sep 2021 02:54:50 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A6B57C000D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Sep 2021 02:54:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 87809607BC
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Sep 2021 02:54:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Ulpixp-ysyv8
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Sep 2021 02:54:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id DA1D7607A6
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Sep 2021 02:54:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1631588087;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2iqkjL4GDcy5sECCQzQ/skpl5d4IINm3ZOrf2JUASKI=;
 b=bNky28NWhOOUthdK2knvIZFdr8P4WFW/o3W1joUGHYOjU7h1xL5x/GdMn+M0dSPjZlMO59
 GEAUQHtTqIKxHijvC8Ou2G8aHY+Dd3GlcBA7eXe2GxTMW36qUbXTFPYK1vOY/hsj3hocQv
 k7D2rFB223q/LaQxk+AtsfxBRLs/AVI=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-551-f05REmDSNLarYGmQ_pT4fg-1; Mon, 13 Sep 2021 22:54:46 -0400
X-MC-Unique: f05REmDSNLarYGmQ_pT4fg-1
Received: by mail-lj1-f199.google.com with SMTP id
 e10-20020a05651c04ca00b001c99c74e564so5158793lji.11
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Sep 2021 19:54:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=2iqkjL4GDcy5sECCQzQ/skpl5d4IINm3ZOrf2JUASKI=;
 b=Matiqscuevq05xw3y4K+cfGvwjOYa/jHX3i6bNv2+l4d1Gu0X8aZnXjOxXfO6UuWME
 LVorjNFSV13IgFb8J32yDpMzomoKfwg+lAMZuO4bBfyZYzroZ0ke+tU8oCl/am25IkFt
 NtuHm4gjZXUwj92Q27oWDMoICsNlNGmv96JbE8PqnQMQbY6lHLhRSKcNDgBJSZgbwA+z
 w6tCunhdrgah41eP/p3W9Qg2kkqIgaY4uZSrHOO9CHcfroBSc2y9UCYjeBEubhnT3No8
 mECUMMthEo59vjCLkKeZLXrpO2bKnpg1irHq8B0vQF54wmlVJOTeZ9op16jK4LLK5baq
 Kvmg==
X-Gm-Message-State: AOAM533shge3jUXRhwD6UhX4gZXqOLpmhe8ZF++Ul5aDwjL9MwfL3nrP
 soxrS5m4aFmIGMm0KZTJMrn9Q/o2DseF4nIXE+X9TSmDF/EXAOymVDbZ6KLAVMr3g7S2tMtYrLY
 28luHsigRfJ8pBgAPnJjCeWzz8xGgWu+vmDJxYdieomeDPVZmjOegnEYaqg==
X-Received: by 2002:a05:651c:54c:: with SMTP id
 q12mr13782878ljp.369.1631588085010; 
 Mon, 13 Sep 2021 19:54:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzaTINYhS6tDRXrQ6Lk4q9w4sJ1IVKyCRLBqQuBmBwar8J332/jBaIEEyI4rgyAuTGQJKxzOEMT5AJzxZBjRig=
X-Received: by 2002:a05:651c:54c:: with SMTP id
 q12mr13782860ljp.369.1631588084831; 
 Mon, 13 Sep 2021 19:54:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210909063738.46970-1-elic@nvidia.com>
In-Reply-To: <20210909063738.46970-1-elic@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 14 Sep 2021 10:54:34 +0800
Message-ID: <CACGkMEuwjX+gpdsxyCvgm5wp2FN5XhuaSGbhjH6dFm0F0edpYQ@mail.gmail.com>
Subject: Re: [PATCH] vdpa/mlx5: Avoid executing set_vq_ready() if device is
 reset
To: Eli Cohen <elic@nvidia.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: eperezma <eperezma@redhat.com>,
 virtualization <virtualization@lists.linux-foundation.org>,
 mst <mst@redhat.com>
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

On Thu, Sep 9, 2021 at 2:37 PM Eli Cohen <elic@nvidia.com> wrote:
>
> Avoid executing set_vq_ready() if the device has been reset. In such
> case, the features are cleared and cannot be used in conditional
> statements. Such reference happens is the function ctrl_vq_idx().
>
> Fixes: 9c90709cf8e7 ("vdpa/mlx5: Add multiqueue support")
> Signed-off-by: Eli Cohen <elic@nvidia.com>

Acked-by: Jason Wang <jasowang@redhat.com>

> ---
>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> index 64dfd0f500d2..bd56de7484dc 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -1714,6 +1714,9 @@ static void mlx5_vdpa_set_vq_ready(struct vdpa_device *vdev, u16 idx, bool ready
>         struct mlx5_vdpa_net *ndev = to_mlx5_vdpa_ndev(mvdev);
>         struct mlx5_vdpa_virtqueue *mvq;
>
> +       if (!mvdev->actual_features)
> +               return;
> +
>         if (!is_index_valid(mvdev, idx))
>                 return;
>
> --
> 2.32.0
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
