Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D7F9C61DA4
	for <virtualization@archiver.kernel.org>; Tue, 14 Feb 2023 06:20:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 20AC8400C4;
	Tue, 14 Feb 2023 06:20:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 20AC8400C4
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Rpi8o7F4
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id repW2iWw-hc1; Tue, 14 Feb 2023 06:20:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id B5AFF405AE;
	Tue, 14 Feb 2023 06:20:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B5AFF405AE
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 341ACC0032;
	Tue, 14 Feb 2023 06:20:23 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2FE80C002B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Feb 2023 06:20:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 055EF405AE
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Feb 2023 06:20:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 055EF405AE
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MTyEaBAPeEgV
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Feb 2023 06:20:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 45285400C4
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 45285400C4
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Feb 2023 06:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1676355620;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xI69jZKg9dx+a1MKdDsqtA7LTjuUH3e/j2qfMu27oPA=;
 b=Rpi8o7F4T2UN3LbC27vmiB0u5/cv8OXvvR/pcpexts/usmmJB7wz9FhABplEEC/ycQo1jk
 golWN5O8oerkX42DNIzTO6Qir5T+e2gsKVk6/IQidmel2WN+QXGODYK5FsA7vNROy3+RZE
 pN0STXOPdYXhSCMwuFMXUcMXhKsO1ss=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-387-BYsShxunNlu8ayvnE8CDhQ-1; Tue, 14 Feb 2023 01:20:18 -0500
X-MC-Unique: BYsShxunNlu8ayvnE8CDhQ-1
Received: by mail-ot1-f71.google.com with SMTP id
 l2-20020a9d6a82000000b0068bc95856f2so7471981otq.15
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Feb 2023 22:20:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xI69jZKg9dx+a1MKdDsqtA7LTjuUH3e/j2qfMu27oPA=;
 b=Wy6biv0Qjc/2Sf205jeR3lAtPStBDFi6q45HM0+FKaD2KxXJcopcsTmInPV9mGMy7h
 UmrSCoeWJc69vDwOL5dQRMviFiMZuVEykDH1MCTGIiQDd6oHRTmt2JdCeIcezFiQnGKV
 v9WdMSEUrCPjA40+zy23AfnggFWUH3mm59isLY2G5Zw0USOM2vtNmBuOLlspwrMcvwTT
 gapf6nTP2lyKA61p93ZJfM+sT1p1co9IBuoLTqeqeZhZEBvqSiIb2IpiXw76tT8xwUiN
 X3G9p4bMN81Q7KsdiFDwVG+P4qxrtEKYNsIuIc5b+QHOBEcvaEv8OgUX5yrf1tX6tSFn
 WSTQ==
X-Gm-Message-State: AO0yUKWA7ViD6R5Hl/GY63xHcYohsHF1L2k3eOVHaHFW1RCVVFhLFIev
 9ZAOfvp5chbD/ri+659x0suhTNxMT0ix2k7/0F57hQR94KEiUVLc+CYz2DIhKHA9KyWT1YCvHBZ
 InE+Kw2AANosZIO4uNp60mDooLk5dHjOee8nAXoDW2zjYcx+bomb66Cq5Yw==
X-Received: by 2002:a05:6808:1a20:b0:37d:5d77:e444 with SMTP id
 bk32-20020a0568081a2000b0037d5d77e444mr1004276oib.35.1676355618111; 
 Mon, 13 Feb 2023 22:20:18 -0800 (PST)
X-Google-Smtp-Source: AK7set+Hne4gWfLZE6vZsWr4yg1VxQbKJzulcCAu2WQ15H5hDw43jxoLUsVLw6tYdC4+do43imCLtVkw3F46ic0Zc1w=
X-Received: by 2002:a05:6808:1a20:b0:37d:5d77:e444 with SMTP id
 bk32-20020a0568081a2000b0037d5d77e444mr1004270oib.35.1676355617888; Mon, 13
 Feb 2023 22:20:17 -0800 (PST)
MIME-Version: 1.0
References: <1676328489-16842-1-git-send-email-si-wei.liu@oracle.com>
In-Reply-To: <1676328489-16842-1-git-send-email-si-wei.liu@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 14 Feb 2023 14:20:06 +0800
Message-ID: <CACGkMEvCCNGeWb0DsExM+fxC23yGOwKuJ24auSujWTQpZEPw7A@mail.gmail.com>
Subject: Re: [PATCH v2] vdpa/mlx5: should not activate virtq object when
 suspended
To: Si-Wei Liu <si-wei.liu@oracle.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: mst@redhat.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, eperezma@redhat.com,
 elic@nvidia.com
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

On Tue, Feb 14, 2023 at 6:48 AM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
>
> Otherwise the virtqueue object to instate could point to invalid address
> that was unmapped from the MTT:
>
>   mlx5_core 0000:41:04.2: mlx5_cmd_out_err:782:(pid 8321):
>   CREATE_GENERAL_OBJECT(0xa00) op_mod(0xd) failed, status
>   bad parameter(0x3), syndrome (0x5fa1c), err(-22)
>
> Fixes: cae15c2ed8e6 ("vdpa/mlx5: Implement susupend virtqueue callback")
> Cc: Eli Cohen <elic@nvidia.com>
> Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
>
> ---
> v2: removed the change for improving warning message
> ---
>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> index 3a6dbbc6..d7e8ca0 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -165,6 +165,7 @@ struct mlx5_vdpa_net {
>         u32 cur_num_vqs;
>         u32 rqt_size;
>         bool nb_registered;
> +       bool suspended;

Any reason we make this net specific? (or is it better to use
mlx5_vdpa_dev structure?)


>         struct notifier_block nb;
>         struct vdpa_callback config_cb;
>         struct mlx5_vdpa_wq_ent cvq_ent;
> @@ -2411,7 +2412,7 @@ static int mlx5_vdpa_change_map(struct mlx5_vdpa_dev *mvdev,
>         if (err)
>                 goto err_mr;
>
> -       if (!(mvdev->status & VIRTIO_CONFIG_S_DRIVER_OK))
> +       if (!(mvdev->status & VIRTIO_CONFIG_S_DRIVER_OK) || ndev->suspended)
>                 goto err_mr;
>
>         restore_channels_info(ndev);
> @@ -2580,6 +2581,7 @@ static int mlx5_vdpa_reset(struct vdpa_device *vdev)
>         mlx5_vdpa_destroy_mr(&ndev->mvdev);
>         ndev->mvdev.status = 0;
>         ndev->cur_num_vqs = 0;
> +       ndev->suspended = false;
>         ndev->mvdev.cvq.received_desc = 0;
>         ndev->mvdev.cvq.completed_desc = 0;
>         memset(ndev->event_cbs, 0, sizeof(*ndev->event_cbs) * (mvdev->max_vqs + 1));
> @@ -2815,6 +2817,8 @@ static int mlx5_vdpa_suspend(struct vdpa_device *vdev)
>         struct mlx5_vdpa_virtqueue *mvq;
>         int i;
>
> +       mlx5_vdpa_info(mvdev, "suspending device\n");
> +

Is this better to show the info after the device has been suspended?

Thanks

>         down_write(&ndev->reslock);
>         ndev->nb_registered = false;
>         mlx5_notifier_unregister(mvdev->mdev, &ndev->nb);
> @@ -2824,6 +2828,7 @@ static int mlx5_vdpa_suspend(struct vdpa_device *vdev)
>                 suspend_vq(ndev, mvq);
>         }
>         mlx5_vdpa_cvq_suspend(mvdev);
> +       ndev->suspended = true;
>         up_write(&ndev->reslock);
>         return 0;
>  }
> --
> 1.8.3.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
