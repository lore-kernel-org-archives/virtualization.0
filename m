Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A0A4C433FE
	for <virtualization@archiver.kernel.org>; Fri,  3 Dec 2021 02:32:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0F49060647;
	Fri,  3 Dec 2021 02:32:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id z5BU1ZmIVY5t; Fri,  3 Dec 2021 02:32:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id B202C60629;
	Fri,  3 Dec 2021 02:32:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 76AD7C0012;
	Fri,  3 Dec 2021 02:32:00 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 27070C000A
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Dec 2021 02:31:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0E8FB8345D
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Dec 2021 02:31:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id W5FIDfbi3f1x
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Dec 2021 02:31:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id EB72283459
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Dec 2021 02:31:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1638498715;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lJn3RstTizvLto2og4+N6iDKK0zplPhhADys5e8rPeY=;
 b=JHlhTpJFmo3ABl21yWw1rHhn7CBaSc9ZzzJ0C64xI2+UNC9tFwvqauDsnE/0GqqF/ToFKY
 ehSJULKr1/yfBtcVehpj0CjtjAHcEHhB2jHfsWEJO3kmZecurRprlkPdJMGUXLrcqByClB
 IDxGPTZMhTv1/hxXcH7szsukALmni9w=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-445-GvmWtvZ7Mw6O2632lDbSMQ-1; Thu, 02 Dec 2021 21:31:52 -0500
X-MC-Unique: GvmWtvZ7Mw6O2632lDbSMQ-1
Received: by mail-lj1-f199.google.com with SMTP id
 y11-20020a2e978b000000b00218df7f76feso604933lji.11
 for <virtualization@lists.linux-foundation.org>;
 Thu, 02 Dec 2021 18:31:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=lJn3RstTizvLto2og4+N6iDKK0zplPhhADys5e8rPeY=;
 b=J/Db9ejRNLpms1nuMH9pKedd69a/+PTe2QyDHfnNdU2YYo3NpqgdE578mFa5rRuLAn
 wVEn7xEeRkFEGaqhApFV2mDyhUpaxQD+gAUfcLK5SiNW23lJWlQis59CIRIZLdwIm3T4
 BM1QMZNFC3NEiguR85L9zSjuRT0WaPUXHe4FCpSPPfik0GK9jiKtvgBqDp6dH13jroS/
 D0zsaa5DrP1raNpoizgI5CunwP9ctKJhIRKnrST+AXICFoBOpwHxOGUfiQVR5FkrCPvp
 Kl1+jd58NexKbWwq+6F2tZSIyrS7eLNxFbIsKsfj+KyAPfh5kIOD0r+XvHBH7oPkGzVb
 Pn7g==
X-Gm-Message-State: AOAM532wtV1ocL9uoIccTST+R3/Jg4R/TdklOhXpGIvAnwmBC4MyuEuN
 tWfKZnz/HHqnK1BeHdhJvQlJxx1qSOFhu0EmlFyfZFSa7c9zJQHMrYgVTsgTtHX6n0fTMfI9NGM
 LipS/9DUNPnCI8CLdu3GDHM3Zd2wuQ8FZ/8mBnEej/ZtBhucOggVtRpJrKA==
X-Received: by 2002:a05:6512:3b2b:: with SMTP id
 f43mr15381095lfv.629.1638498711266; 
 Thu, 02 Dec 2021 18:31:51 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzWclhQo78T+jMOf5wNI3H/eA5YFMWSJCWq6XoVdTxrMwfVUw8VSaj3aSwo7tWnp/K6wvassKkEBgvBwRqlhQk=
X-Received: by 2002:a05:6512:3b2b:: with SMTP id
 f43mr15381074lfv.629.1638498711104; 
 Thu, 02 Dec 2021 18:31:51 -0800 (PST)
MIME-Version: 1.0
References: <20211201195724.17503-1-elic@nvidia.com>
 <20211201195724.17503-5-elic@nvidia.com>
In-Reply-To: <20211201195724.17503-5-elic@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 3 Dec 2021 10:31:40 +0800
Message-ID: <CACGkMEuFY7V1149gMPYx+GCRAHjeDEEu=GMX_RXb2LNbz26o7A@mail.gmail.com>
Subject: Re: [PATCH 4/7] vdpa/mlx5: Report queried max supported virtqueues
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

On Thu, Dec 2, 2021 at 3:58 AM Eli Cohen <elic@nvidia.com> wrote:
>
> Report back in get_vq_num_max() the correct number of virtqueues queried
> from the device instead of using a constant value.
>
> Signed-off-by: Eli Cohen <elic@nvidia.com>
> ---
>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> index 62aba5dbd8fa..336eda3dcf41 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -1992,10 +1992,10 @@ static void mlx5_vdpa_set_config_cb(struct vdpa_device *vdev, struct vdpa_callba
>         ndev->config_cb = *cb;
>  }
>
> -#define MLX5_VDPA_MAX_VQ_ENTRIES 256
>  static u16 mlx5_vdpa_get_vq_num_max(struct vdpa_device *vdev)
>  {
> -       return MLX5_VDPA_MAX_VQ_ENTRIES;
> +       struct mlx5_vdpa_dev *mvdev = to_mvdev(vdev);
> +       return MLX5_CAP_DEV_VDPA_EMULATION(mvdev->mdev, max_num_virtio_queues);
>  }

I may miss something but I guess it should not be the hardware
limitation but the one that is set from netlink.

Thanks

>
>  static u32 mlx5_vdpa_get_device_id(struct vdpa_device *vdev)
> --
> 2.33.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
