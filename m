Return-Path: <SRS0=tl6X=PO=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C166C433EF
	for <virtualization@archiver.kernel.org>; Tue, 26 Oct 2021 04:09:55 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C37E60EDF
	for <virtualization@archiver.kernel.org>; Tue, 26 Oct 2021 04:09:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3C37E60EDF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 034DF404BB;
	Tue, 26 Oct 2021 04:09:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KDXLwT_42-IJ; Tue, 26 Oct 2021 04:09:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 7679C404B1;
	Tue, 26 Oct 2021 04:09:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 442CBC0012;
	Tue, 26 Oct 2021 04:09:53 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3CDD8C000E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Oct 2021 04:09:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2B0A7401D2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Oct 2021 04:09:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 87OyXXj8YCRO
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Oct 2021 04:09:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4D0C24015C
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Oct 2021 04:09:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1635221390;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xxsoKgI7McKz4Cb2UYdcIVzgRAsWmN1dPrk3AnojM0A=;
 b=QMdpXZOJEhFyr9M6jaC8NmUmPDABMrXlwR3n1nP7SdlGmdDtw/6JLjF0Xwdb9kftCQ7Zzq
 /DX9Db09K+/VrL+Ct6ZhdaIJNpr5V86NCimzbdkLFeG8qoVsi/nWx7khDethdJfHpCWlD7
 Br2V0IIUXt9EbmLQxIKmzj2jl+1g81Y=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-314-4AQ_zLPaOImJUFs_xS3TDw-1; Tue, 26 Oct 2021 00:09:44 -0400
X-MC-Unique: 4AQ_zLPaOImJUFs_xS3TDw-1
Received: by mail-lf1-f71.google.com with SMTP id
 k15-20020a0565123d8f00b003ffb31e2ea9so1268668lfv.17
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Oct 2021 21:09:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=xxsoKgI7McKz4Cb2UYdcIVzgRAsWmN1dPrk3AnojM0A=;
 b=1aTdJ3CPJ6IykCRh+b9GJNKGJwSAaU5c9jQdRF9xxxb2J3O+QiqgAibLwtULvUi+R8
 2KqXa1jafCDsZg8f5BUEGcD06IHWlw4bkwTZF2+5iwsNKcUOT7Up9Cw3VT3Pgp7Q7Jmg
 +U7uFu1VLBHJLCr6KyhkotPcK6y4IsUy0BP6gYnwigazRdgw0c2tka3tVrpq/VDhN+of
 wir3weZHSduiAU/yJ9+cFtbrhP5hrJXjIfnhT/6aalAXUTKHd4DGTODUnnSMRfQRhRAL
 DLZdpd8Mar5CHO9lK1e7qXLryl3opS0pV3BezLMhue7i0ayZ7QtqH3SQMRNHKr23b4cD
 qqCg==
X-Gm-Message-State: AOAM530NIbWKcjABfPGbRg4SOBEOU4MttZz0twpYsh6Btt1x9NdyfzPb
 VdfMeUb3flJBA9Qz4FbbK+pNBqyLb9DUbC6EsIwApU9X8rM9neozwLxjhJhkY5c1MyESUx9g2ut
 I3lYoEcRXpIS7OFzFC+13hfFJ8Ba9oFBifWGqGqB078GM+pTCsRNXgsAUzg==
X-Received: by 2002:a05:6512:282:: with SMTP id
 j2mr7627296lfp.580.1635221383439; 
 Mon, 25 Oct 2021 21:09:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwAfNrJJWBlWoWI6iL4xJJsHpC7utsDmjVqrgABd4vGVJ1RHoOjvq/qNzK40Ay6jj6OC7LXvtQ/IQA6skycLJE=
X-Received: by 2002:a05:6512:282:: with SMTP id
 j2mr7627279lfp.580.1635221383269; 
 Mon, 25 Oct 2021 21:09:43 -0700 (PDT)
MIME-Version: 1.0
References: <20211026040243.79005-1-parav@nvidia.com>
 <20211026040243.79005-7-parav@nvidia.com>
In-Reply-To: <20211026040243.79005-7-parav@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 26 Oct 2021 12:09:32 +0800
Message-ID: <CACGkMEuWEnNkMJ=c9n29ap9KKk=Y+ED9LdfKNReBUEZQKji--Q@mail.gmail.com>
Subject: Re: [PATCH linux-next v6 6/8] vdpa/mlx5: Fix clearing of
 VIRTIO_NET_F_MAC feature bit
To: Parav Pandit <parav@nvidia.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Eli Cohen <elic@nvidia.com>, mst <mst@redhat.com>,
 virtualization <virtualization@lists.linux-foundation.org>
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

On Tue, Oct 26, 2021 at 12:03 PM Parav Pandit <parav@nvidia.com> wrote:
>
> Cited patch in the fixes tag clears the features bit during reset.
> mlx5 vdpa device feature bits are static decided by device capabilities.
> These feature bits (including VIRTIO_NET_F_MAC) are initialized during
> device addition time.
>
> Clearing features bit in reset callback cleared the VIRTIO_NET_F_MAC. Due to
> this MAC address provided by the device is not honored.
>
> Fix it by not clearing the static feature bits during reset.
>
> Fixes: 0686082dbf7a ("vdpa: Add reset callback in vdpa_config_ops")
> Signed-off-by: Parav Pandit <parav@nvidia.com>
> Reviewed-by: Eli Cohen <elic@nvidia.com>

Acked-by: Jason Wang <jasowang@redhat.com>

> ---
> changelog:
> v5->v6:
>  - expanded commit log description to indicate that feature bits are
>    initialized during device addition
>
> ---
>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> index 6bbdc0ece707..8d1539728a59 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -2194,7 +2194,6 @@ static int mlx5_vdpa_reset(struct vdpa_device *vdev)
>         clear_vqs_ready(ndev);
>         mlx5_vdpa_destroy_mr(&ndev->mvdev);
>         ndev->mvdev.status = 0;
> -       ndev->mvdev.mlx_features = 0;
>         memset(ndev->event_cbs, 0, sizeof(ndev->event_cbs));
>         ndev->mvdev.actual_features = 0;
>         ++mvdev->generation;
> --
> 2.25.4
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
