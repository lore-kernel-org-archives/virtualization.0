Return-Path: <SRS0=LSNt=OE=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACE82C433F5
	for <virtualization@archiver.kernel.org>; Tue, 14 Sep 2021 02:58:08 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3EF3E6112D
	for <virtualization@archiver.kernel.org>; Tue, 14 Sep 2021 02:58:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3EF3E6112D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 00E6E607C6;
	Tue, 14 Sep 2021 02:58:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gQuTq4E68WYa; Tue, 14 Sep 2021 02:58:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id A975B607BC;
	Tue, 14 Sep 2021 02:58:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 75E14C0011;
	Tue, 14 Sep 2021 02:58:06 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5F69EC000D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Sep 2021 02:58:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 48550607BC
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Sep 2021 02:58:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id veEOpP3PV5KP
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Sep 2021 02:58:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 89270607A6
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Sep 2021 02:58:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1631588283;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wLQAP9QEuGEZ7dNU/LIcvxNGVI1xJN9i8W+8d0addzo=;
 b=eLZLYTpEBzJsDRrbpB7Ijlysr0BstQVcJFPo7nPw9jYV+wkIbUn5wnms5rQ8UornB4HzXR
 18aUxFYE50L/YWnEL3gI2Fi9v0E7/Jkv/yKm0G/VccC9zh4FkDiHz1NzQ9BHLQ3wQorniD
 nuyd5zgI26pUWPswxfuNLcI4KtmOXYE=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-445--PcLZX_BNYmWCz9aA5lzkQ-1; Mon, 13 Sep 2021 22:58:02 -0400
X-MC-Unique: -PcLZX_BNYmWCz9aA5lzkQ-1
Received: by mail-lj1-f199.google.com with SMTP id
 c16-20020a2e89d0000000b001d018ef42aaso5147163ljk.23
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Sep 2021 19:58:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=wLQAP9QEuGEZ7dNU/LIcvxNGVI1xJN9i8W+8d0addzo=;
 b=sq66CRKkUeivQO9ThoAIZHMISv5JJLajc8lYJDFnZsNFydB6wzFV0XB034pamgHOtw
 rwoqMXvqhegDSL/i7QQSnnZSixhTIJJ16cyVPpX2aoCc8kq6u9qku8+WV2e7cCmI0R/p
 1eUPhuHI+4i/j6I6AKMFyAIuFZcRyxhseJo3Ax7SBuHpdJtPRWGNjlBVrTuS++2DvFNA
 wohM8gZJ3DDqL5AqrxhIDE8OMszhSUjDaeKGpL3JKGuurTHGMylriBjEQZ4BcJKgXfB4
 7H5Tg9cKgk53FrpjYMUP/Hu8fR5nCK6ZCp0yktnbyFm3ATsy7uj9vADIcl890gJUtLbH
 S1Cw==
X-Gm-Message-State: AOAM530rf9AELef6TiGDWbzBLdWyF62dZ9ArFgv9hiSatfY03PztIpAO
 NiwHXezunDCEdd3taKVNhmp99eOXWtrRW1AlEwrZL70c1lcJ4weBTna8/YxzOqwlh0wKb+Of2m6
 522JFGs266Y0AOTszhNWOOZZxaVqEgLzdXwZnrXOXzffUg5ho8F9xIjyg6Q==
X-Received: by 2002:ac2:5fc5:: with SMTP id q5mr11186997lfg.629.1631588280748; 
 Mon, 13 Sep 2021 19:58:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwZC8OcqaVG/6wIzi5QuuXTYBI1782ihBgQO0EjUxc0y3dp1p7F1hVlqy6wCvm0lvR72dsVjZ1KZgZg7/hfytk=
X-Received: by 2002:ac2:5fc5:: with SMTP id q5mr11186982lfg.629.1631588280536; 
 Mon, 13 Sep 2021 19:58:00 -0700 (PDT)
MIME-Version: 1.0
References: <20210909123635.30884-1-elic@nvidia.com>
 <20210909123635.30884-3-elic@nvidia.com>
In-Reply-To: <20210909123635.30884-3-elic@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 14 Sep 2021 10:57:49 +0800
Message-ID: <CACGkMEu7Xj4=GmEOXcCNiimidonZgERpvrvxV9ee_Lqj0kxrSQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] vdpa/mlx5: Rename control VQ workqueue to vdpa wq
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

On Thu, Sep 9, 2021 at 8:36 PM Eli Cohen <elic@nvidia.com> wrote:
>
> A subesequent patch will use the same workqueue for executing other
> work not related to control VQ. Rename the workqueue and the work queue
> entry used to convey information to the workqueue.
>
> Signed-off-by: Eli Cohen <elic@nvidia.com>

Acked-by: Jason Wang <jasowang@redhat.com>

> ---
>  drivers/vdpa/mlx5/core/mlx5_vdpa.h | 2 +-
>  drivers/vdpa/mlx5/net/mlx5_vnet.c  | 8 ++++----
>  2 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/vdpa/mlx5/core/mlx5_vdpa.h b/drivers/vdpa/mlx5/core/mlx5_vdpa.h
> index 01a848adf590..81dc3d88d3dd 100644
> --- a/drivers/vdpa/mlx5/core/mlx5_vdpa.h
> +++ b/drivers/vdpa/mlx5/core/mlx5_vdpa.h
> @@ -63,7 +63,7 @@ struct mlx5_control_vq {
>         unsigned short head;
>  };
>
> -struct mlx5_ctrl_wq_ent {
> +struct mlx5_vdpa_wq_ent {
>         struct work_struct work;
>         struct mlx5_vdpa_dev *mvdev;
>  };
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> index 08ac15b17b83..59f1874648ae 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -1556,14 +1556,14 @@ static void mlx5_cvq_kick_handler(struct work_struct *work)
>  {
>         virtio_net_ctrl_ack status = VIRTIO_NET_ERR;
>         struct virtio_net_ctrl_hdr ctrl;
> -       struct mlx5_ctrl_wq_ent *wqent;
> +       struct mlx5_vdpa_wq_ent *wqent;
>         struct mlx5_vdpa_dev *mvdev;
>         struct mlx5_control_vq *cvq;
>         struct mlx5_vdpa_net *ndev;
>         size_t read, write;
>         int err;
>
> -       wqent = container_of(work, struct mlx5_ctrl_wq_ent, work);
> +       wqent = container_of(work, struct mlx5_vdpa_wq_ent, work);
>         mvdev = wqent->mvdev;
>         ndev = to_mlx5_vdpa_ndev(mvdev);
>         cvq = &mvdev->cvq;
> @@ -1615,7 +1615,7 @@ static void mlx5_vdpa_kick_vq(struct vdpa_device *vdev, u16 idx)
>         struct mlx5_vdpa_dev *mvdev = to_mvdev(vdev);
>         struct mlx5_vdpa_net *ndev = to_mlx5_vdpa_ndev(mvdev);
>         struct mlx5_vdpa_virtqueue *mvq;
> -       struct mlx5_ctrl_wq_ent *wqent;
> +       struct mlx5_vdpa_wq_ent *wqent;
>
>         if (!is_index_valid(mvdev, idx))
>                 return;
> @@ -2466,7 +2466,7 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name)
>         if (err)
>                 goto err_mr;
>
> -       mvdev->wq = create_singlethread_workqueue("mlx5_vdpa_ctrl_wq");
> +       mvdev->wq = create_singlethread_workqueue("mlx5_vdpa_wq");
>         if (!mvdev->wq) {
>                 err = -ENOMEM;
>                 goto err_res2;
> --
> 2.31.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
