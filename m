Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92B0CC433F5
	for <virtualization@archiver.kernel.org>; Tue, 21 Dec 2021 05:49:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1F34E60E8E;
	Tue, 21 Dec 2021 05:49:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id weywdZAsbORi; Tue, 21 Dec 2021 05:49:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id C95B660E88;
	Tue, 21 Dec 2021 05:49:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A3C81C001E;
	Tue, 21 Dec 2021 05:49:04 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AB1BCC0012
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Dec 2021 05:49:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 97AD14051B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Dec 2021 05:49:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QArsnIt0R1Io
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Dec 2021 05:49:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 92BC0404FE
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Dec 2021 05:49:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1640065741;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=U+uPlyLluhWcMZ5Pp6c8+uspTbsCN+qXmN0R6SgTPOo=;
 b=YH1Q8PLH7btnSkLNWvWdHL2h8CghUg5x0++vhDcI6Tdj4xzzHVWl1uMh3sfqz7CSzyPbN1
 iLgfK9jlciIdT79tWEELQvOAi28VKF6j1upeY18vhTfaBRnEbQZ2GbDjlO/57TtbdMMzNp
 zCODTg7Gt6/kmmZ6mTLAuyYLW3sVdsg=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-384-boPRh76BMbSyWbAZzSvnyQ-1; Tue, 21 Dec 2021 00:48:59 -0500
X-MC-Unique: boPRh76BMbSyWbAZzSvnyQ-1
Received: by mail-lf1-f71.google.com with SMTP id
 h7-20020ac24da7000000b0042521f16f1fso5699831lfe.21
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Dec 2021 21:48:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=U+uPlyLluhWcMZ5Pp6c8+uspTbsCN+qXmN0R6SgTPOo=;
 b=Xwk/Zq3TWOsvSphYya4zGXpDYLrxRIGuZlZE9CYYouag0nVr3keAlu82mXaUbABglf
 uzr+kNMkBpvTvidtqzK/OBipUz4D3708rUJgyky9hQHVvkqzP0ywuqOX4Y25IpamRh8y
 ufhcnMFwD11NoOJC/ZQJ/i5LMXjVvpJZPofj9F+FQRwhOqoR8gBMiFsbfPC/3aOAZ0ge
 1FbaZebvO42Ug69phlFYgT7ixKxtBhiz2jGhWrHVHVsU7CU/u3T1kRyhDjtatFYStc5R
 jJEHdeiHjzpPjG4pBquiAzl6dfvhTpHqaAD6X58hDg4aJJbkS8ddStjVyzH0mKx9ASqA
 W6TQ==
X-Gm-Message-State: AOAM531OhGMmEz+euRNNyj6Gs1qXlmPzq4r03RpJd2NEuCyFSzZPkm2k
 jAubBIHiUcTjpz0ZF1X4n/n+uBT/glInUoeNhKgq9i38rVHHhkR0Kp0A9awH/0zpKUM8w452mzZ
 9OtrWeKxo9j782cmpBX1lxjpXid/m5IPSH4KxQ9fXwO3hcEmzma3B3quLcQ==
X-Received: by 2002:a2e:9f55:: with SMTP id v21mr1318043ljk.420.1640065738374; 
 Mon, 20 Dec 2021 21:48:58 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzQVF3bM+MUYK0LL2x13+OdBpOd6h4VwiHKPq1Nc03bq9Xtmt4AsV9Lo3LP8H3sMUlEdsc7WkFHZ3LhEMC8E48=
X-Received: by 2002:a2e:9f55:: with SMTP id v21mr1318034ljk.420.1640065738171; 
 Mon, 20 Dec 2021 21:48:58 -0800 (PST)
MIME-Version: 1.0
References: <20211219140236.27479-1-elic@nvidia.com>
 <20211219140236.27479-3-elic@nvidia.com>
In-Reply-To: <20211219140236.27479-3-elic@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 21 Dec 2021 13:48:47 +0800
Message-ID: <CACGkMEvcs93PgokH-oRfYanpeVfXeZU-55KnyykCi5r9rsgcWg@mail.gmail.com>
Subject: Re: [PATCH v3 02/10] vdpa/mlx5: Distribute RX virtqueues in RQT object
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
> Distribute the available rx virtqueues amongst the available RQT
> entries.
>
> RQTs require to have a power of two entries. When creating or modifying
> the RQT, use the lowest number of power of two entries that is not less
> than the number of rx virtqueues. Distribute them in the available
> entries such that some virtqueus may be referenced twice.
>
> This allows to configure any number of virtqueue pairs when multiqueue
> is used.
>
> Reviewed-by: Si-Wei Liu <si-wei.liu@oracle.com>
> Signed-off-by: Eli Cohen <elic@nvidia.com>
> ---

Acked-by: Jason Wang <jasowang@redhat.com>

>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 30 +++++++-----------------------
>  1 file changed, 7 insertions(+), 23 deletions(-)
>
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> index 14b972360a1a..98aed4b36c3f 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -1261,17 +1261,10 @@ static int create_rqt(struct mlx5_vdpa_net *ndev)
>         MLX5_SET(rqtc, rqtc, list_q_type, MLX5_RQTC_LIST_Q_TYPE_VIRTIO_NET_Q);
>         MLX5_SET(rqtc, rqtc, rqt_max_size, max_rqt);
>         list = MLX5_ADDR_OF(rqtc, rqtc, rq_num[0]);
> -       for (i = 0, j = 0; j < max_rqt; j++) {
> -               if (!ndev->vqs[j].initialized)
> -                       continue;
> -
> -               if (!vq_is_tx(ndev->vqs[j].index)) {
> -                       list[i] = cpu_to_be32(ndev->vqs[j].virtq_id);
> -                       i++;
> -               }
> -       }
> -       MLX5_SET(rqtc, rqtc, rqt_actual_size, i);
> +       for (i = 0, j = 0; i < max_rqt; i++, j += 2)
> +               list[i] = cpu_to_be32(ndev->vqs[j % ndev->mvdev.max_vqs].virtq_id);
>
> +       MLX5_SET(rqtc, rqtc, rqt_actual_size, max_rqt);
>         err = mlx5_vdpa_create_rqt(&ndev->mvdev, in, inlen, &ndev->res.rqtn);
>         kfree(in);
>         if (err)
> @@ -1292,7 +1285,7 @@ static int modify_rqt(struct mlx5_vdpa_net *ndev, int num)
>         int i, j;
>         int err;
>
> -       max_rqt = min_t(int, ndev->cur_num_vqs / 2,
> +       max_rqt = min_t(int, roundup_pow_of_two(ndev->cur_num_vqs / 2),
>                         1 << MLX5_CAP_GEN(ndev->mvdev.mdev, log_max_rqt_size));
>         if (max_rqt < 1)
>                 return -EOPNOTSUPP;
> @@ -1308,16 +1301,10 @@ static int modify_rqt(struct mlx5_vdpa_net *ndev, int num)
>         MLX5_SET(rqtc, rqtc, list_q_type, MLX5_RQTC_LIST_Q_TYPE_VIRTIO_NET_Q);
>
>         list = MLX5_ADDR_OF(rqtc, rqtc, rq_num[0]);
> -       for (i = 0, j = 0; j < num; j++) {
> -               if (!ndev->vqs[j].initialized)
> -                       continue;
> +       for (i = 0, j = 0; i < max_rqt; i++, j += 2)
> +               list[i] = cpu_to_be32(ndev->vqs[j % num].virtq_id);
>
> -               if (!vq_is_tx(ndev->vqs[j].index)) {
> -                       list[i] = cpu_to_be32(ndev->vqs[j].virtq_id);
> -                       i++;
> -               }
> -       }
> -       MLX5_SET(rqtc, rqtc, rqt_actual_size, i);
> +       MLX5_SET(rqtc, rqtc, rqt_actual_size, max_rqt);
>         err = mlx5_vdpa_modify_rqt(&ndev->mvdev, in, inlen, ndev->res.rqtn);
>         kfree(in);
>         if (err)
> @@ -1581,9 +1568,6 @@ static virtio_net_ctrl_ack handle_ctrl_mq(struct mlx5_vdpa_dev *mvdev, u8 cmd)
>                         break;
>                 }
>
> -               if (newqps & (newqps - 1))
> -                       break;
> -
>                 if (!change_num_qps(mvdev, newqps))
>                         status = VIRTIO_NET_OK;
>
> --
> 2.34.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
