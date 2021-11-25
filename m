Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20441C433F5
	for <virtualization@archiver.kernel.org>; Thu, 25 Nov 2021 04:38:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 88FB8608C3;
	Thu, 25 Nov 2021 04:38:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Kw3dcFugR_or; Thu, 25 Nov 2021 04:38:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 12F08607FB;
	Thu, 25 Nov 2021 04:38:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D6B1AC0038;
	Thu, 25 Nov 2021 04:38:16 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 51258C000A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Nov 2021 04:38:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 27CF582668
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Nov 2021 04:38:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Q73JbhcMW8cp
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Nov 2021 04:38:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id EDBF681D9F
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Nov 2021 04:38:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1637815092;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aqSE9nhJNuZGY0LOL67oniaVihqUg/fpSOJs+CA1BWM=;
 b=XBTf2/qRg9BNdXUq0END8Le9feT7Cxejsre9LcUZxziOQMoJ0KNHoym+jhWYfWm/y/SumJ
 4s2IW1Uy+Sz0DnmGk/O/9UlpvFdThDodzJ/ww6eOW0u5mEcvzjXMAtLxfbMov0M7+lMsdD
 mzWJiaPllN1vJZfiRfha0SU7S3eOpLs=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-25-k9sr3yqxPr6AciPbttYo5A-1; Wed, 24 Nov 2021 23:38:11 -0500
X-MC-Unique: k9sr3yqxPr6AciPbttYo5A-1
Received: by mail-lf1-f72.google.com with SMTP id
 m2-20020a056512014200b0041042b64791so2564458lfo.6
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Nov 2021 20:38:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=aqSE9nhJNuZGY0LOL67oniaVihqUg/fpSOJs+CA1BWM=;
 b=0JKhoGm1ZHpASrYdPm56rrA1S3PDyC8nGSrNsLgI7kzUrJXtmxipicgaG2pqS3vTDd
 aK1hvLYiLeehwaWsfSAJjbku90RpkgF93WaI3kd4l5NSyQokiTn4hEUJ2lsj6eciWSbz
 cIWwxf/0kdVpJqNSvt5S+jYnLM/DZE5MQBBSSMiiVimv4VEuQA7ndp3Zb93BuN+gj1zE
 rrgeRpg6ssOq9mL7FFnotQC5lGjQ0Id0DHqU1RzgK19Uk6K2X/Lt+lfeG1JyYeSLq1GI
 GTF2FKqdPUhS4mXlhSDyDa+pQmHr4GBIf20T+Og/b/tuHbSzsIVKYE1UGTSNSTbieGu3
 cWLg==
X-Gm-Message-State: AOAM53126LTmSE7qTMWGo4YRWVdzOcIkNRuzNXQfAg/NXJK4etcxiuPd
 AL8QQc8DgBNU3Ei1D/FVWxFsUPlm1DfjMiU0+NDrMAX1bxMcuVgye8yEupeI56pIMmWWyUZzvn3
 ZOmlxkg3iD5HGV4f0YhBcZsHcVMjWkSpqdhxU+zsvtEuhUabbJg0DJjxUbQ==
X-Received: by 2002:ac2:5310:: with SMTP id c16mr21611642lfh.580.1637815089850; 
 Wed, 24 Nov 2021 20:38:09 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy23X/azL7eyiu7uaJGVOrujEZ2u3SLZJTm0qVf3aPkjM/w/AJVArYKYYset/ZNlW9hNhMPHhodLCo0m8DiLgY=
X-Received: by 2002:ac2:5310:: with SMTP id c16mr21611628lfh.580.1637815089683; 
 Wed, 24 Nov 2021 20:38:09 -0800 (PST)
MIME-Version: 1.0
References: <20211124170949.51725-1-elic@nvidia.com>
In-Reply-To: <20211124170949.51725-1-elic@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 25 Nov 2021 12:37:58 +0800
Message-ID: <CACGkMEvxW0p7=r7vvOUiOYp3sEEp5dMP5YfU54x2yeRCmvQzww@mail.gmail.com>
Subject: Re: [PATCH] net/mlx5_vdpa: Offer VIRTIO_NET_F_MTU when setting MTU
To: Eli Cohen <elic@nvidia.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Laurent Vivier <lvivier@redhat.com>, mst <mst@redhat.com>,
 virtualization <virtualization@lists.linux-foundation.org>,
 eperezma <eperezma@redhat.com>, si-wei.liu@oracle.com
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

On Thu, Nov 25, 2021 at 1:10 AM Eli Cohen <elic@nvidia.com> wrote:
>
> Make sure to offer VIRTIO_NET_F_MTU since we configure the MTU based on
> what was queried from the device.
>
> This allows the virtio driver to allocate large enough buffers based on
> the reported MTU.
>
> Signed-off-by: Eli Cohen <elic@nvidia.com>

Acked-by: Jason Wang <jasowang@redhat.com>

> ---
>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> index 465e832f2ad1..ed7a63e48335 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -1956,6 +1956,7 @@ static u64 mlx5_vdpa_get_features(struct vdpa_device *vdev)
>         ndev->mvdev.mlx_features |= BIT_ULL(VIRTIO_NET_F_CTRL_MAC_ADDR);
>         ndev->mvdev.mlx_features |= BIT_ULL(VIRTIO_NET_F_MQ);
>         ndev->mvdev.mlx_features |= BIT_ULL(VIRTIO_NET_F_STATUS);
> +       ndev->mvdev.mlx_features |= BIT_ULL(VIRTIO_NET_F_MTU);
>
>         print_features(mvdev, ndev->mvdev.mlx_features, false);
>         return ndev->mvdev.mlx_features;
> --
> 2.33.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
