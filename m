Return-Path: <SRS0=oNZg=CQ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40BEDC43461
	for <virtualization@archiver.kernel.org>; Mon,  7 Sep 2020 11:34:18 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3AA6215A4
	for <virtualization@archiver.kernel.org>; Mon,  7 Sep 2020 11:34:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FgtE5O7Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3AA6215A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 301CC87126;
	Mon,  7 Sep 2020 11:34:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SoMrQvXfI8f4; Mon,  7 Sep 2020 11:34:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 00113870FC;
	Mon,  7 Sep 2020 11:34:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D650CC0859;
	Mon,  7 Sep 2020 11:34:15 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 58063C0051
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Sep 2020 11:34:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 47C2385E83
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Sep 2020 11:34:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7RwRvKlXHibk
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Sep 2020 11:34:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-1.mimecast.com
 [207.211.31.81])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 48C5D85E5C
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Sep 2020 11:34:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599478451;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=my7C9bnTqduGCO7MqL3mwZJ3lvwe6tTXAbKJeMeZpsw=;
 b=FgtE5O7Q9nRDN6xYhYGkOjQ6SR9+xMaayUOQCrhG350FU5IE1V+5mA3dB3fk6qUwCEfjkI
 ngvgFKzo0URJyOYg7bXDglliHOZ36Xc3Cdzv3iPZvNk/EjOWrCCzXn7kWq76Kbl/KlvGju
 XfBWdJ4tLnYQ0+oa7fo45ExOJPms7WI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-137-C4IUZiw0N8OufmuEuDICUQ-1; Mon, 07 Sep 2020 07:34:09 -0400
X-MC-Unique: C4IUZiw0N8OufmuEuDICUQ-1
Received: by mail-wr1-f71.google.com with SMTP id r15so5589703wrt.8
 for <virtualization@lists.linux-foundation.org>;
 Mon, 07 Sep 2020 04:34:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=my7C9bnTqduGCO7MqL3mwZJ3lvwe6tTXAbKJeMeZpsw=;
 b=GeDWTataorDu91tkh9wZzfZi4a8SMizV4Z5+j+SR9I7Dd1OlktstQP1oU7E9GqKJIN
 99M4l9pzATtx06S+iMfPLsNnrVdYPTYlcswwxd6ux3a/+BsTP9VePUcupNf/zu+anRBI
 Mr8lkHeCYmCydb5Qlhlj/GtQsG82rDWNsSCeiE5yeXQA7tbBq78bH7cOsf/IRUBacrxq
 6S21kgcBCVEi50egAKyaClQRiSVQh62FhIEu5DiPdI5g6Ed+Fhc9efsYdaVnmCY0IcGG
 YHPDHs5T3QlVX3T2ED0ZWCpteEJ4sJ+KBB5cxmHXNg1E3aj2V6Mb4Hm9co/3chu8R4+a
 xHmA==
X-Gm-Message-State: AOAM532jTA48lb5CIADErHpTCs6VzofMbT6P1IiI5DUZXtz1Ww/Y9SXg
 nHt9ko7w/P2+tl/ftWAshFeTeD92AkA9P2hQDgX0VrwZOo84oSWYb3kCvc2bz2uNqmUa07VE2Gr
 I/fIyhxTL3FEaqMp01Bdb0nWm7LB93VUfCoi3qTg0gg==
X-Received: by 2002:a05:600c:1:: with SMTP id g1mr19389808wmc.57.1599478448524; 
 Mon, 07 Sep 2020 04:34:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJylLFC0f0WrGm77BTxL4v95Dw1glpL5jHRTRjXWVbhHVzorqlr1MuKQVccvAMKh/KgK2Z+nNA==
X-Received: by 2002:a05:600c:1:: with SMTP id g1mr19389788wmc.57.1599478448324; 
 Mon, 07 Sep 2020 04:34:08 -0700 (PDT)
Received: from redhat.com ([192.117.173.58])
 by smtp.gmail.com with ESMTPSA id r14sm28258858wrn.56.2020.09.07.04.34.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2020 04:34:07 -0700 (PDT)
Date: Mon, 7 Sep 2020 07:34:00 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eli Cohen <elic@nvidia.com>
Subject: Re: [PATCH] vdpa/mlx5: Setup driver only if VIRTIO_CONFIG_S_DRIVER_OK
Message-ID: <20200907073319-mutt-send-email-mst@kernel.org>
References: <20200907075136.GA114876@mtl-vdi-166.wap.labs.mlnx>
MIME-Version: 1.0
In-Reply-To: <20200907075136.GA114876@mtl-vdi-166.wap.labs.mlnx>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: netdev <netdev@vger.kernel.org>, Cindy Lu <lulu@redhat.com>,
 virtualization@lists.linux-foundation.org
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

On Mon, Sep 07, 2020 at 10:51:36AM +0300, Eli Cohen wrote:
> If the memory map changes before the driver status is
> VIRTIO_CONFIG_S_DRIVER_OK, don't attempt to create resources because it
> may fail. For example, if the VQ is not ready there is no point in
> creating resources.
> 
> Fixes: 1a86b377aa21 ("vdpa/mlx5: Add VDPA driver for supported mlx5 devices")
> Signed-off-by: Eli Cohen <elic@nvidia.com>


Could you add a bit more data about the problem to the log?
To be more exact, what exactly happens right now?

> ---
>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> index 9df69d5efe8c..c89cd48a0aab 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -1645,6 +1645,9 @@ static int mlx5_vdpa_change_map(struct mlx5_vdpa_net *ndev, struct vhost_iotlb *
>  	if (err)
>  		goto err_mr;
>  
> +	if (!(ndev->mvdev.status & VIRTIO_CONFIG_S_DRIVER_OK))
> +		return 0;
> +
>  	restore_channels_info(ndev);
>  	err = setup_driver(ndev);
>  	if (err)
> -- 
> 2.26.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
