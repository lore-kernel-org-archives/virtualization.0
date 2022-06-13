Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24E8CC433EF
	for <virtualization@archiver.kernel.org>; Mon, 13 Jun 2022 08:13:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BDA758250B;
	Mon, 13 Jun 2022 08:13:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TRIGMw8wV6_3; Mon, 13 Jun 2022 08:13:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 66F3B82503;
	Mon, 13 Jun 2022 08:13:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3AF11C0039;
	Mon, 13 Jun 2022 08:13:03 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BBF15C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Jun 2022 08:13:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A488E60F16
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Jun 2022 08:13:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id j49PiGkf0GN1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Jun 2022 08:13:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6858960F07
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Jun 2022 08:13:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1655107979;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zYvGhBu9HmB5MMoe90C77tgnPiO/jbA/i6l4B3LwqrA=;
 b=crGdGWyIlYuRUFWiyxclmdb4vK7tM3RjF8w8+dcKLVwHDlSsSnaDsoHGOqc28vW9TyqTIv
 Ai5lD5T+WfOn5GnLPirJJXsoKgUsBWKxjkWPt+sMMA4X7YMcFekXHro+CmeZsuTlhgi42v
 uW0Wj0cz8c+7CqlEtSR1xvFQuZkfilg=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-436-G8aTnZCMOVuV679iGa-J0Q-1; Mon, 13 Jun 2022 04:12:58 -0400
X-MC-Unique: G8aTnZCMOVuV679iGa-J0Q-1
Received: by mail-lf1-f72.google.com with SMTP id
 h35-20020a0565123ca300b00479113319f9so2755062lfv.0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Jun 2022 01:12:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=zYvGhBu9HmB5MMoe90C77tgnPiO/jbA/i6l4B3LwqrA=;
 b=yZe7pO8u3v8aRwzyBSb6MeIY5pmeHJgJTz6Tu+bZDMfOOikIDQGZ+RorUjpklie96m
 3XMzw8AS8ElVJh9SaWSK0mMOcyeyPlTJwpHFL7PHwNXOE6UzaihXHCDjPgZmfAimQMPC
 6/Zr7/84Sxf8aQcDjZZ3B3iDKgdoiq2RIU2gW26TjFFz3RjCdKqG4Rfn+I04r+N834Ag
 jVC60B8MPp0ACu1SsacKg3pzvxqZ5fPntymMosOLXzjmdhb0uQfixP+5nstvVEf4uvpy
 ZFFTIEOkW3YHkvaGhF+3Kj4ng+jdtgVYpTlyiwMlF7gKmtl9hNQYYwv6uaqfzinoUMgA
 S5Tg==
X-Gm-Message-State: AOAM530ZeNqsPg9gaQ+0Gz8bk70ydA95ovdTT6JLzCsN/Y1klrbgVkwz
 Yk4GeHXDFXDkx3sqrY3Cl00+eAMzi9bCSOA//bukgI/kGi6FU4wADYvv4yvhIEVgryLwgsJI+kF
 s4Bb5sGhEtk/a8yo6JhHrNH/onbfUo5N6l8ORUAwtxpM657KkrRjvPYPNuw==
X-Received: by 2002:a05:6512:a8f:b0:479:63e5:d59f with SMTP id
 m15-20020a0565120a8f00b0047963e5d59fmr18242611lfu.124.1655107976648; 
 Mon, 13 Jun 2022 01:12:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxoz6YdTTkziAJVqYGZS4sICU2CRqhsvvMO8wJ45GEUUXf6uE6PSxjIbxuhvL9EGVlilwwa1RpUsG8dxhIgDH0=
X-Received: by 2002:a05:6512:a8f:b0:479:63e5:d59f with SMTP id
 m15-20020a0565120a8f00b0047963e5d59fmr18242601lfu.124.1655107976442; Mon, 13
 Jun 2022 01:12:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220613075958.511064-1-elic@nvidia.com>
 <20220613075958.511064-2-elic@nvidia.com>
In-Reply-To: <20220613075958.511064-2-elic@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 13 Jun 2022 16:12:45 +0800
Message-ID: <CACGkMEszmgnYoSi-CaMhUpZSg1c9FgzLoN9esT94A4MCgknP2Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] vdpa/mlx5: Initializde CVQ vringh only once
To: Eli Cohen <elic@nvidia.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: eperezma <eperezma@redhat.com>,
 virtualization <virtualization@lists.linux-foundation.org>,
 linux-kernel <linux-kernel@vger.kernel.org>, mst <mst@redhat.com>
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

On Mon, Jun 13, 2022 at 4:00 PM Eli Cohen <elic@nvidia.com> wrote:
>
> Currently, CVQ vringh is initialized inside setup_virtqueues() which is
> called every time a memory update is done. This is undesirable since it
> resets all the context of the vring, including the available and used
> indices.
>
> Move the initialization to mlx5_vdpa_set_status() when
> VIRTIO_CONFIG_S_DRIVER_OK is set.
>
> Signed-off-by: Eli Cohen <elic@nvidia.com>

Acked-by: Jason Wang <jasowang@redhat.com>

> ---
>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 31 ++++++++++++++++++++-----------
>  1 file changed, 20 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> index 789c078ff1af..e85c1d71f4ed 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -2176,7 +2176,6 @@ static int verify_driver_features(struct mlx5_vdpa_dev *mvdev, u64 features)
>  static int setup_virtqueues(struct mlx5_vdpa_dev *mvdev)
>  {
>         struct mlx5_vdpa_net *ndev = to_mlx5_vdpa_ndev(mvdev);
> -       struct mlx5_control_vq *cvq = &mvdev->cvq;
>         int err;
>         int i;
>
> @@ -2186,16 +2185,6 @@ static int setup_virtqueues(struct mlx5_vdpa_dev *mvdev)
>                         goto err_vq;
>         }
>
> -       if (mvdev->actual_features & BIT_ULL(VIRTIO_NET_F_CTRL_VQ)) {
> -               err = vringh_init_iotlb(&cvq->vring, mvdev->actual_features,
> -                                       MLX5_CVQ_MAX_ENT, false,
> -                                       (struct vring_desc *)(uintptr_t)cvq->desc_addr,
> -                                       (struct vring_avail *)(uintptr_t)cvq->driver_addr,
> -                                       (struct vring_used *)(uintptr_t)cvq->device_addr);
> -               if (err)
> -                       goto err_vq;
> -       }
> -
>         return 0;
>
>  err_vq:
> @@ -2468,6 +2457,21 @@ static void clear_vqs_ready(struct mlx5_vdpa_net *ndev)
>         ndev->mvdev.cvq.ready = false;
>  }
>
> +static int setup_cvq_vring(struct mlx5_vdpa_dev *mvdev)
> +{
> +       struct mlx5_control_vq *cvq = &mvdev->cvq;
> +       int err = 0;
> +
> +       if (mvdev->actual_features & BIT_ULL(VIRTIO_NET_F_CTRL_VQ))
> +               err = vringh_init_iotlb(&cvq->vring, mvdev->actual_features,
> +                                       MLX5_CVQ_MAX_ENT, false,
> +                                       (struct vring_desc *)(uintptr_t)cvq->desc_addr,
> +                                       (struct vring_avail *)(uintptr_t)cvq->driver_addr,
> +                                       (struct vring_used *)(uintptr_t)cvq->device_addr);
> +
> +       return err;
> +}
> +
>  static void mlx5_vdpa_set_status(struct vdpa_device *vdev, u8 status)
>  {
>         struct mlx5_vdpa_dev *mvdev = to_mvdev(vdev);
> @@ -2480,6 +2484,11 @@ static void mlx5_vdpa_set_status(struct vdpa_device *vdev, u8 status)
>
>         if ((status ^ ndev->mvdev.status) & VIRTIO_CONFIG_S_DRIVER_OK) {
>                 if (status & VIRTIO_CONFIG_S_DRIVER_OK) {
> +                       err = setup_cvq_vring(mvdev);
> +                       if (err) {
> +                               mlx5_vdpa_warn(mvdev, "failed to setup control VQ vring\n");
> +                               goto err_setup;
> +                       }
>                         err = setup_driver(mvdev);
>                         if (err) {
>                                 mlx5_vdpa_warn(mvdev, "failed to setup driver\n");
> --
> 2.35.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
