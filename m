Return-Path: <SRS0=Do4E=OD=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C9A4C433EF
	for <virtualization@archiver.kernel.org>; Mon, 13 Sep 2021 22:09:47 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4EB19610A2
	for <virtualization@archiver.kernel.org>; Mon, 13 Sep 2021 22:09:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4EB19610A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 2358C401E2;
	Mon, 13 Sep 2021 22:09:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id D1DcYwXPA-NY; Mon, 13 Sep 2021 22:09:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 76A0E40022;
	Mon, 13 Sep 2021 22:09:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 42993C000F;
	Mon, 13 Sep 2021 22:09:45 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F3357C000D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Sep 2021 22:09:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id DCF4760653
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Sep 2021 22:09:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tyH6Alo4MJq4
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Sep 2021 22:09:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3D68960652
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Sep 2021 22:09:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1631570981;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kX2N76s1+cN76Drh0X53U2RN/TBb27pxqeIlI43YBaU=;
 b=Mt4wqvfj7BIxIEG+uL5q2pJvAuVzrdCTM/MQj2mV8GX3xRQkj9VfwMXMt/HsilQESylzSB
 dlbzN17JOWNjXLzy0nV0FKyRa5eJA2eCAgs4pogvkmjjknZlop4Vn31d24k9ZpSwwlY8c6
 o4l7VKt54b5wq7tK30wVpe4aXRUbbB0=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-502-ot0B8Mi7MLyAsC-P_JxNTQ-1; Mon, 13 Sep 2021 18:09:40 -0400
X-MC-Unique: ot0B8Mi7MLyAsC-P_JxNTQ-1
Received: by mail-ej1-f70.google.com with SMTP id
 ne21-20020a1709077b95b029057eb61c6fdfso4304443ejc.22
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Sep 2021 15:09:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=kX2N76s1+cN76Drh0X53U2RN/TBb27pxqeIlI43YBaU=;
 b=sjrK/auL5SHj5iG+MwyWXxBmyta4cc/uTFrTtNmBbdbLRRR0I/YH2zmxN60ZKObmIy
 GWv7JWqKC6VDMOBVc4e/+zJeVpH+XtQ4WudLqRCYajQ/p8rbsAv9qLgulBVun1Ip3d2E
 5tbku858XSpOsPgw/h7xQbhrG4mejUQRGuuwDROg3jqL1tV5d3WmCCgubVZFplT0xP3C
 DIc0x+lcuJGNjnXFcg9uxNf3aWD3udrc6Nn9SaBsE2YBDG95O6y3TI73OP+lOyQNIsLS
 OWKCKnaEXndBhzupqxlEVVlVYiwzdVjHlW99b9wpFCkazmpstleUe9SVRVl3vYVwJULI
 A0Mw==
X-Gm-Message-State: AOAM5305SRG9i7C5wUfRH0ahX4U5zdaecYXRN3IOwAmV4bLUntn3pT5z
 eV/7hQQAY1RbXKC2ARmyajJoy3l9kv+Ko51azXmMTnFeo3/k4D7EZMgjmT7bq0mGiYHAnt1zJgD
 8/9Wi081XBlJYEQxFT1sGvCTjJj6MMRxJE0Ua7SYbig==
X-Received: by 2002:aa7:d796:: with SMTP id s22mr15629997edq.244.1631570979245; 
 Mon, 13 Sep 2021 15:09:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJytkByJ0ixhli9bTplqvbbImMPWBw6gRouc24Fc9o/03KQesfIwaLfBBIEKKn1mN07/mzN3tg==
X-Received: by 2002:aa7:d796:: with SMTP id s22mr15629979edq.244.1631570979046; 
 Mon, 13 Sep 2021 15:09:39 -0700 (PDT)
Received: from redhat.com ([2.55.151.134])
 by smtp.gmail.com with ESMTPSA id j22sm4070101ejt.11.2021.09.13.15.09.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Sep 2021 15:09:38 -0700 (PDT)
Date: Mon, 13 Sep 2021 18:09:35 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eli Cohen <elic@nvidia.com>
Subject: Re: [PATCH 1/3] vdpa/mlx5: Remove mtu field from vdpa net device
Message-ID: <20210913180801-mutt-send-email-mst@kernel.org>
References: <20210909123635.30884-1-elic@nvidia.com>
 <20210909123635.30884-2-elic@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20210909123635.30884-2-elic@nvidia.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: eperezma@redhat.com, virtualization@lists.linux-foundation.org
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

On Thu, Sep 09, 2021 at 03:36:33PM +0300, Eli Cohen wrote:
> No need to save the mtu int the net device struct. We can save it in the
> config struct which cannot be modified.
> 
> Moreover, move the initialization to. mlx5_vdpa_set_features() callback
> is not the right place to put it.

the reason it's there is the endian-ness mess. before set features
VERSION_1 is not set. Does mlx5 support a transitional mode?
Or modern only? If the later then cpu_to_mlx5vdpa16
should really be switched to just use LE unconfitionally.


> 
> Signed-off-by: Eli Cohen <elic@nvidia.com>
> ---
>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> index 7784e8a5647f..08ac15b17b83 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -159,7 +159,6 @@ struct mlx5_vdpa_net {
>  	struct mlx5_fc *rx_counter;
>  	struct mlx5_flow_handle *rx_rule;
>  	bool setup;
> -	u16 mtu;
>  	u32 cur_num_vqs;
>  };
>  
> @@ -1942,8 +1941,6 @@ static int mlx5_vdpa_set_features(struct vdpa_device *vdev, u64 features)
>  		return err;
>  
>  	ndev->mvdev.actual_features = features & ndev->mvdev.mlx_features;
> -	ndev->config.mtu = cpu_to_mlx5vdpa16(mvdev, ndev->mtu);
> -	ndev->config.status |= cpu_to_mlx5vdpa16(mvdev, VIRTIO_NET_S_LINK_UP);
>  	update_cvq_info(mvdev);
>  	return err;
>  }
> @@ -2405,6 +2402,7 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name)
>  	struct mlx5_vdpa_net *ndev;
>  	struct mlx5_core_dev *mdev;
>  	u32 max_vqs;
> +	u16 mtu;
>  	int err;
>  
>  	if (mgtdev->ndev)
> @@ -2432,10 +2430,13 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name)
>  	init_mvqs(ndev);
>  	mutex_init(&ndev->reslock);
>  	config = &ndev->config;
> -	err = query_mtu(mdev, &ndev->mtu);
> +	err = query_mtu(mdev, &mtu);
>  	if (err)
>  		goto err_mtu;
>  
> +	ndev->config.mtu = cpu_to_mlx5vdpa16(mvdev, mtu);
> +	ndev->config.status |= cpu_to_mlx5vdpa16(mvdev, VIRTIO_NET_S_LINK_UP);
> +
>  	err = mlx5_query_nic_vport_mac_address(mdev, 0, 0, config->mac);
>  	if (err)
>  		goto err_mtu;
> -- 
> 2.31.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
