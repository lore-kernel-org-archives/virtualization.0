Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F0BFC433F5
	for <virtualization@archiver.kernel.org>; Wed, 12 Jan 2022 02:35:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 40D2F60D6A;
	Wed, 12 Jan 2022 02:35:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3AZvqJc6DAUH; Wed, 12 Jan 2022 02:35:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id E6C1260D6B;
	Wed, 12 Jan 2022 02:35:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CB8ABC002F;
	Wed, 12 Jan 2022 02:35:55 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 99F29C001E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Jan 2022 02:35:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 87BF483F0C
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Jan 2022 02:35:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gaNAdFD1dCCB
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Jan 2022 02:35:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C40F583F08
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Jan 2022 02:35:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1641954952;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sIC7TYQzsseQ071TF8U6TIksEQCxg2/pSXZlTIi0JIg=;
 b=UBeuruvWwor2p4s4CUL7I9p0Zwug9wBI9rGizMgSuVVPiYxPLvprXoaXTzzkXh5me25Ke7
 fSmNBNfJdOrVCLlvpXByCQJ7kiZlAIgBaInzRVhYReglTTeITZsU8B2WpTJPofHnCwrhK0
 p0m8x1V6Ie3eACnODc1gQqX/QHc7gWM=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-533-QP6mcBXgM6qfe28_3w7giQ-1; Tue, 11 Jan 2022 21:35:51 -0500
X-MC-Unique: QP6mcBXgM6qfe28_3w7giQ-1
Received: by mail-lf1-f72.google.com with SMTP id
 d34-20020a0565123d2200b0042ed74cbf6aso132742lfv.11
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Jan 2022 18:35:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=sIC7TYQzsseQ071TF8U6TIksEQCxg2/pSXZlTIi0JIg=;
 b=IXZFoYMJuIkMu0YrqK1zwZGDSk0nFigHAn8xZS2REG4eNZMmkbcGIeSBcuS7biJC+m
 HtT8usWhPoKdyq/glns1tKgkFUrA0Xb/31rJR5PmYfCA38lWKNgc0qhvcHZYJ5/1rPG8
 sET55CgJB3j9noT68U6ZQDRs3tV8IdgOwqhyM2WXrI9OE4r6sizrK9jkEP+lHjd/ifzx
 ACfFy1XoE7JF2ntewGKUWIm28j2qGafv98yqXwoc5i31U7JuInc+YW/lL4L24MoJVzE2
 NO/Oc2PcMjEAkcTYYawQocQpbumWfHbPsLYTR3XEiVH4KwU8q+71FU6DhwAz8TktROC5
 zOiw==
X-Gm-Message-State: AOAM533u/+cWygaJadn+W0HY/+NerMsj9fJnCZT9iq3Q1QdYNBy8+c4o
 mNbpYTkitvuj6gcdGbif+3QRYoFcH7iZa9ABsZrnB/nCuCvJBmB+awoO/m3k0ae1wMgR0YWyPYu
 MkwK39IKxck6n+YiyLJLT0JiGXEe71HrA/xy7obnbkHU7EczHrKShRwwiyw==
X-Received: by 2002:a2e:a177:: with SMTP id u23mr4813092ljl.217.1641954949941; 
 Tue, 11 Jan 2022 18:35:49 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw08lRNYxdjos4K/wWVJASU5zgSq4DYVtanzX/zxdxSLOwVIi1IllI1/0q8wRer7Y2LdlvvCljm6bc0A2Fuzg8=
X-Received: by 2002:a2e:a177:: with SMTP id u23mr4813076ljl.217.1641954949740; 
 Tue, 11 Jan 2022 18:35:49 -0800 (PST)
MIME-Version: 1.0
References: <20220111183400.38418-1-elic@nvidia.com>
 <20220111183400.38418-5-elic@nvidia.com>
In-Reply-To: <20220111183400.38418-5-elic@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 12 Jan 2022 10:35:38 +0800
Message-ID: <CACGkMEthoRMfiL-6_2So---L_BGMJaGV1PfHuyWsTiMhje8RnA@mail.gmail.com>
Subject: Re: [PATCH 4/4] vdpa/mlx5: Fix tracking of current number of VQs
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

On Wed, Jan 12, 2022 at 2:34 AM Eli Cohen <elic@nvidia.com> wrote:
>
> Modify the code such that ndev->cur_num_vqs better reflects the actual
> number of data virtqueues. The value can be accurately realized after
> features have been negotiated.
>
> This is to prevent possible failures when modifying the RQT object if
> the cur_num_vqs bears invalid value.
>
> No issue was actually encountered but this also makes the code more
> readable.
>
> Fixes: c5a5cd3d3217 ("vdpa/mlx5: Support configuring max data virtqueue")
> Signed-off-by: Eli Cohen <elic@nvidia.com>

Acked-by: Jason Wang <jasowang@redhat.com>

> ---
>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> index 9eacfdb48434..b53603d94082 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -1246,8 +1246,7 @@ static int create_rqt(struct mlx5_vdpa_net *ndev)
>         if (!(ndev->mvdev.actual_features & BIT_ULL(VIRTIO_NET_F_MQ)))
>                 num = 1;
>         else
> -               num = mlx5vdpa16_to_cpu(&ndev->mvdev,
> -                                       ndev->config.max_virtqueue_pairs);
> +               num = ndev->cur_num_vqs / 2;
>
>         max_rqt = min_t(int, roundup_pow_of_two(num),
>                         1 << MLX5_CAP_GEN(ndev->mvdev.mdev, log_max_rqt_size));
> @@ -1983,6 +1982,11 @@ static int mlx5_vdpa_set_driver_features(struct vdpa_device *vdev, u64 features)
>                 return err;
>
>         ndev->mvdev.actual_features = features & ndev->mvdev.mlx_features;
> +       if (ndev->mvdev.actual_features & BIT_ULL(VIRTIO_NET_F_MQ))
> +               ndev->cur_num_vqs = 2 * mlx5vdpa16_to_cpu(mvdev, ndev->config.max_virtqueue_pairs);
> +       else
> +               ndev->cur_num_vqs = 2;
> +
>         update_cvq_info(mvdev);
>         return err;
>  }
> @@ -2233,6 +2237,7 @@ static int mlx5_vdpa_reset(struct vdpa_device *vdev)
>         clear_vqs_ready(ndev);
>         mlx5_vdpa_destroy_mr(&ndev->mvdev);
>         ndev->mvdev.status = 0;
> +       ndev->cur_num_vqs = 0;
>         memset(ndev->event_cbs, 0, sizeof(*ndev->event_cbs) * (mvdev->max_vqs + 1));
>         ndev->mvdev.actual_features = 0;
>         ++mvdev->generation;
> @@ -2641,9 +2646,8 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
>
>         ndev->nb.notifier_call = event_handler;
>         mlx5_notifier_register(mdev, &ndev->nb);
> -       ndev->cur_num_vqs = 2 * mlx5_vdpa_max_qps(max_vqs);
>         mvdev->vdev.mdev = &mgtdev->mgtdev;
> -       err = _vdpa_register_device(&mvdev->vdev, ndev->cur_num_vqs + 1);
> +       err = _vdpa_register_device(&mvdev->vdev, 2 * mlx5_vdpa_max_qps(max_vqs) + 1);
>         if (err)
>                 goto err_reg;
>
> --
> 2.34.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
