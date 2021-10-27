Return-Path: <SRS0=5D8L=PP=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D808CC433EF
	for <virtualization@archiver.kernel.org>; Wed, 27 Oct 2021 06:05:07 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F16460F9B
	for <virtualization@archiver.kernel.org>; Wed, 27 Oct 2021 06:05:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7F16460F9B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 47BCF80D26;
	Wed, 27 Oct 2021 06:05:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yowvT5UnPPLG; Wed, 27 Oct 2021 06:05:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id EB36D80D52;
	Wed, 27 Oct 2021 06:05:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C1F7AC0012;
	Wed, 27 Oct 2021 06:05:05 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1F8A4C000E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Oct 2021 06:05:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0F44180D52
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Oct 2021 06:05:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id H32v0XYvhxve
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Oct 2021 06:05:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D738380D26
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Oct 2021 06:05:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1635314702;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vbxtys2q4AEZ/z72OsgsWRQpujUMnyT0hF77gie/tT0=;
 b=gnfI8Q2EVkY4Ql5dV1ULujTXtElnr9il+XO0zjX9BLa9cSZKGQkQXDHcQ7it+6WeGZQnNK
 leDQVaVxVnuG83nor+EGw1DqLmiXKC/Vz0NG4wfzSJa+LW8OeJK7KqUMRbV3NTqtz0Zw+Y
 XGvj5LpuJEVKuoruYjr8AlxWo7zRFpk=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-151-ELYS2DR9NmKEOw620VanAQ-1; Wed, 27 Oct 2021 02:05:01 -0400
X-MC-Unique: ELYS2DR9NmKEOw620VanAQ-1
Received: by mail-lf1-f69.google.com with SMTP id
 j22-20020a05651231d600b003ffacdb8311so894289lfe.7
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Oct 2021 23:05:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=vbxtys2q4AEZ/z72OsgsWRQpujUMnyT0hF77gie/tT0=;
 b=FfFAI+P6wMFGHbmaHbtXboubitA+lmE4WPvpUYzpU62r1iClGsXrhzCoPjtsMnWsRX
 z9xKKFJ0Wl78BujfURM/H82IYdVv/4CdXrKmBeOb8c7zzgUW0Pg1RCBmeiypt0krMdUv
 waNQyshwT9VusuTQb1EGZIU6Tt0PWnYGzpIZmqqKIdupCoNpFvK6G/5TW9e1aKx0f2Ud
 ZE4LLm78NWTqySSUYtXPEojmzRV23mI6m71E2Jcl2+/LDN9ltq0wKKSiXocF0JYfilx+
 Gdj20GIS+SnlLoEP0PRTqpVlYJw2SNl5CvGpBIQTwkDphIE0tsNgWD8DxJyuj8/WGRTV
 0HSQ==
X-Gm-Message-State: AOAM533hlrXapp7nj7hmDLxHkf2o2TRi1B2BBOG6dn/DcjIJtzr6GDjq
 lELoixZJXVgXCbS9bol17OYlCKAgKKuwcFcNHZEDCw/m/G3AAn+IiaCJFojS01Qrq1wX9nWm/Ky
 TTd23QfshzAeXNpDbQmtrDN/PRphn/O4nrJeWJ1uWWQmFcYTnvx70L6jK7Q==
X-Received: by 2002:a05:651c:1254:: with SMTP id
 h20mr781277ljh.420.1635314699682; 
 Tue, 26 Oct 2021 23:04:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxkwjlMSMGBh6lSurCqj9dWGLMCbCA6Do+40yCir3Rg32cTVZkdeABz7C8lvLyPPIpDvZfJlIvWeGLVO9w2wqk=
X-Received: by 2002:a05:651c:1254:: with SMTP id
 h20mr781265ljh.420.1635314699492; 
 Tue, 26 Oct 2021 23:04:59 -0700 (PDT)
MIME-Version: 1.0
References: <20211026175519.87795-1-parav@nvidia.com>
 <20211026175519.87795-7-parav@nvidia.com>
In-Reply-To: <20211026175519.87795-7-parav@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 27 Oct 2021 14:04:48 +0800
Message-ID: <CACGkMEvvLADu3jCzBv-+2DuXisD2HC5oXCTY1q22pqpK6PH-dA@mail.gmail.com>
Subject: Re: [PATCH linux-next v7 6/8] vdpa/mlx5: Fix clearing of
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

On Wed, Oct 27, 2021 at 1:56 AM Parav Pandit <parav@nvidia.com> wrote:
>
> Cited patch in the fixes tag clears the features bit during reset.
> mlx5 vdpa device feature bits are static decided by device capabilities.
> These feature bits (including VIRTIO_NET_F_MAC) are initialized during
> device addition time.
>
> Clearing features bit in reset callback cleared the VIRTIO_NET_F_MAC. Due
> to this, MAC address provided by the device is not honored.
>
> Fix it by not clearing the static feature bits during reset.
>
> Fixes: 0686082dbf7a ("vdpa: Add reset callback in vdpa_config_ops")
> Signed-off-by: Parav Pandit <parav@nvidia.com>
> Reviewed-by: Eli Cohen <elic@nvidia.com>

Acked-by: Jason Wang <jasowang@redhat.com>

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
