Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3EA1C43217
	for <virtualization@archiver.kernel.org>; Mon, 14 Nov 2022 07:53:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 536614028C;
	Mon, 14 Nov 2022 07:53:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 536614028C
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=bw6rpNFr
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8C-kgZrUm_1a; Mon, 14 Nov 2022 07:53:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 9F3E54023F;
	Mon, 14 Nov 2022 07:53:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9F3E54023F
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 624C7C0032;
	Mon, 14 Nov 2022 07:53:26 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EBB80C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Nov 2022 07:53:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B30C4409E1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Nov 2022 07:53:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B30C4409E1
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=bw6rpNFr
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lrr5z2qrsDT7
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Nov 2022 07:53:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0B086409D3
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0B086409D3
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Nov 2022 07:53:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1668412402;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=i2TV4qSy21VU+sk5sjRM64dTZU7pZku1ImCIDTVwlIA=;
 b=bw6rpNFr4cyEbpsMFZ5f/ZQ21pWFMgv1DGZgJVH8cgalnhtiyVmfQZKcjGa4y90etc2BiL
 aZi4gonRM13hXGKrt+nPRlIpUdlgFSYjoxR8qtxyp0oRfrRFjHD+ehY31d693ie8ryAtjQ
 7U+DiymnkMUfxmqFSM4FUVLe+97VYQo=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-659-xBayNM2tNVebN7BKKnm0qw-1; Mon, 14 Nov 2022 02:53:21 -0500
X-MC-Unique: xBayNM2tNVebN7BKKnm0qw-1
Received: by mail-oo1-f69.google.com with SMTP id
 w21-20020a4a3555000000b0049eeb6b145eso3474177oog.2
 for <virtualization@lists.linux-foundation.org>;
 Sun, 13 Nov 2022 23:53:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=i2TV4qSy21VU+sk5sjRM64dTZU7pZku1ImCIDTVwlIA=;
 b=XmFCaWK3e7I21JFV3PXlyx7/wBNyzLB0BrliGKpvMOH0IuSurQIrWQL53lZrPvWSjO
 n6I8LQ8XLOttP3Mb08HMRTx6/2o8IfhOnHAHN9jCtgVM+Fol7vCQg+ArgVIVoUwonYk5
 vt+QSz1Q9IOZmhXwnPgMYxS3iybgp+3GLzjzLNyTWaKyvQngAr+xtAIq+1SsHYI3+G6R
 EDXXkN+wBWkFQ6p8wAjDlVI/AX/dzX3BL6dNFDXBgooW+uxqPbn2IGDPxNDh8pN/IOan
 21R1fNpjubN/lV311VwdJ9X4oIdXmiDHFpHCxCKB1XQeI93cH81xbhgW1KfdHjyCdyuZ
 7CZQ==
X-Gm-Message-State: ANoB5pkWhYBrW0Gv1Ip2FSy04HE1Iha1LyrtjNkDumnI9cpdU0has8Tj
 1OeQr2pnWiwqC91+bEAuLup9N63iLbvv2MgCdRWXkBYkao3G/lUjLcypyRfXMUVgS7c0RBQrzNQ
 bnbN27EQWK9SpNSXOYzenbgvNycYb99PTK8YZEjLx1XX9jCcupJFIvIUjtQ==
X-Received: by 2002:a54:4605:0:b0:354:68aa:9c59 with SMTP id
 p5-20020a544605000000b0035468aa9c59mr5210569oip.35.1668412400638; 
 Sun, 13 Nov 2022 23:53:20 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6Vkq31SLnZPS7YCw3N8XrceMuGkoMwan8QFQOt1NWvPgsD49puCtuMISsrbN/ojMoIW2ZKe4qVQNuSMrgJB2E=
X-Received: by 2002:a54:4605:0:b0:354:68aa:9c59 with SMTP id
 p5-20020a544605000000b0035468aa9c59mr5210557oip.35.1668412400397; Sun, 13 Nov
 2022 23:53:20 -0800 (PST)
MIME-Version: 1.0
References: <20221113134442.152695-1-elic@nvidia.com>
 <20221113134442.152695-7-elic@nvidia.com>
In-Reply-To: <20221113134442.152695-7-elic@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 14 Nov 2022 15:53:09 +0800
Message-ID: <CACGkMEt+7kKD8_q_OFKURbFR1W=YbJpcuwZq5bf5jC4qzE8PEA@mail.gmail.com>
Subject: Re: [PATCH 6/7] vdpa/mlx5: Avoid using reslock in event_handler
To: Eli Cohen <elic@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: lulu@redhat.com, mst@redhat.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, eperezma@redhat.com
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

On Sun, Nov 13, 2022 at 9:45 PM Eli Cohen <elic@nvidia.com> wrote:
>
> event_handler runs under atomic context and may not acquire reslock. We
> can still guarantee that the handler won't be called after suspend by
> clearing nb_registered, unregistering the handler and flushing the
> workqueue.
>
> Signed-off-by: Eli Cohen <elic@nvidia.com>
> ---
>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 14 +++-----------
>  1 file changed, 3 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> index 6e6490c85be2..bebfba530247 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -2872,8 +2872,8 @@ static int mlx5_vdpa_suspend(struct vdpa_device *vdev)
>         int i;
>
>         down_write(&ndev->reslock);
> -       mlx5_notifier_unregister(mvdev->mdev, &ndev->nb);
>         ndev->nb_registered = false;
> +       mlx5_notifier_unregister(mvdev->mdev, &ndev->nb);

I wonder why this can help anything. And if it does, we have simliar
logic in mlx5_vdpa_dev_del() do we need to fix that as well?

Thanks

>         flush_workqueue(ndev->mvdev.wq);
>         for (i = 0; i < ndev->cur_num_vqs; i++) {
>                 mvq = &ndev->vqs[i];
> @@ -3051,7 +3051,7 @@ static void update_carrier(struct work_struct *work)
>         else
>                 ndev->config.status &= cpu_to_mlx5vdpa16(mvdev, ~VIRTIO_NET_S_LINK_UP);
>
> -       if (ndev->config_cb.callback)
> +       if (ndev->nb_registered && ndev->config_cb.callback)
>                 ndev->config_cb.callback(ndev->config_cb.private);
>
>         kfree(wqent);
> @@ -3068,21 +3068,13 @@ static int event_handler(struct notifier_block *nb, unsigned long event, void *p
>                 switch (eqe->sub_type) {
>                 case MLX5_PORT_CHANGE_SUBTYPE_DOWN:
>                 case MLX5_PORT_CHANGE_SUBTYPE_ACTIVE:
> -                       down_read(&ndev->reslock);
> -                       if (!ndev->nb_registered) {
> -                               up_read(&ndev->reslock);
> -                               return NOTIFY_DONE;
> -                       }
>                         wqent = kzalloc(sizeof(*wqent), GFP_ATOMIC);
> -                       if (!wqent) {
> -                               up_read(&ndev->reslock);
> +                       if (!wqent)
>                                 return NOTIFY_DONE;
> -                       }
>
>                         wqent->mvdev = &ndev->mvdev;
>                         INIT_WORK(&wqent->work, update_carrier);
>                         queue_work(ndev->mvdev.wq, &wqent->work);
> -                       up_read(&ndev->reslock);
>                         ret = NOTIFY_OK;
>                         break;
>                 default:
> --
> 2.38.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
