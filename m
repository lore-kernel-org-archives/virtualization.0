Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E13ADC433EF
	for <virtualization@archiver.kernel.org>; Mon, 10 Jan 2022 07:04:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 71FBC60C00;
	Mon, 10 Jan 2022 07:04:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yyB0yYOTBjoM; Mon, 10 Jan 2022 07:04:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 1B38660A8D;
	Mon, 10 Jan 2022 07:04:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DCD0BC002F;
	Mon, 10 Jan 2022 07:04:41 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4F00BC001E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Jan 2022 07:04:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 36D2C8270B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Jan 2022 07:04:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JwfM9ypuon9x
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Jan 2022 07:04:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7B26B826FF
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Jan 2022 07:04:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1641798279;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=glrYLaq/zeCDJ8EBauBMXO6thKGQa/sy38wwmV8Efpc=;
 b=DvtytRwU7FPiH4DKzHpe4Gcbm3PfWSXKdPs4PcBjZG9+Baw5rP2f2pwPvHy/uv3gY9m03m
 3d3DxsrNnLpbzo2lwAvHxH0jsGApbS/h0HJTGkDJA7MZbdgQnsKi/uIsbndAP+Shgkbacs
 pAwVE3/k3O1YhLJee71+5oRLP2hJ+8w=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-606-AwDJQi2TNPK6cCsNoJptBQ-1; Mon, 10 Jan 2022 02:04:38 -0500
X-MC-Unique: AwDJQi2TNPK6cCsNoJptBQ-1
Received: by mail-wm1-f69.google.com with SMTP id
 s190-20020a1ca9c7000000b00347c6c39d9aso3469644wme.5
 for <virtualization@lists.linux-foundation.org>;
 Sun, 09 Jan 2022 23:04:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=glrYLaq/zeCDJ8EBauBMXO6thKGQa/sy38wwmV8Efpc=;
 b=3pu70JLvznoyPZM/zevvjwyx4hhpxZtWXg9iAPzRiA3WCVAcuS/WReGWEk/8N52xCJ
 luPjg+eq00ujjFHC90hu6CzzaqGYHfOtTWa3jlPvvysza4hn5Z7oc1EIcaIKqetTNZDV
 Y8S3qQjTfk+HUOgqu+LalxETV1qf8zYsyB7OlbuSCIXg5Y8AMxdl0Yu+UMRPmA5zQZvm
 ik8/2WOCGHXJMKnxgMlGIfTa6ixbnmM4SduNLAZVEG91tvdLYmIi5swwuxoozAMEqQWP
 yDb6XYMMM5jmwixwOpp2SeOGpZi7SeK1PPRN7KqJKr00ioIzU8BLtnbI8sdFwMpcrKF4
 cxWg==
X-Gm-Message-State: AOAM533YlXAJF/fhPSLJX0djxPT5X/7HX5+rO8VH3WtpdsxhgehzI9Et
 xd/QKXmR3iJoEX86yagDKSzgNOWteanYY3Y51JxD0/FaGJMKd0/0i8FI9FbhSkDnBUOAyfwjwNB
 0RbaqQKe7y9gYg2e2vdmb0UcO5IN+v7uq1LDI3E8xTQ==
X-Received: by 2002:a5d:6f06:: with SMTP id ay6mr16304542wrb.54.1641798276881; 
 Sun, 09 Jan 2022 23:04:36 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwWmjGAV166Ixy71n40Bf9Q6MmfrKCLEKWzprARRbZ3psss7a/OOsxtoAYA2B0tis44/jMV0g==
X-Received: by 2002:a5d:6f06:: with SMTP id ay6mr16304528wrb.54.1641798276653; 
 Sun, 09 Jan 2022 23:04:36 -0800 (PST)
Received: from redhat.com ([2a03:c5c0:107d:b60c:c297:16fe:7528:e989])
 by smtp.gmail.com with ESMTPSA id r11sm6424967wrz.78.2022.01.09.23.04.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Jan 2022 23:04:36 -0800 (PST)
Date: Mon, 10 Jan 2022 02:04:32 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eli Cohen <elic@nvidia.com>
Subject: Re: [PATCH v7 00/14] Allow for configuring max number of virtqueue
 pairs
Message-ID: <20220110020122-mutt-send-email-mst@kernel.org>
References: <20220105114646.577224-1-elic@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20220105114646.577224-1-elic@nvidia.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: lvivier@redhat.com, virtualization@lists.linux-foundation.org,
 eperezma@redhat.com, si-wei.liu@oracle.com
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

On Wed, Jan 05, 2022 at 01:46:32PM +0200, Eli Cohen wrote:
> Allow the user to configure the max number of virtqueue pairs for a vdpa
> instance. The user can then control the actual number of virtqueue pairs
> using ethtool.

So I put a version of this in linux-next, but I had to squash in
some bugfixes, and resolve some conflicts. Eli, please take a look
and let me know whether it looks sane. If not pls post a new
version.
Jason, what is your take on merging this now? Si-wei here seems to want
to defer, but OTOH it's up to v7 already, most patches are acked and
most comments look like minor improvement suggestions to me.

> Example, set number of VQPs to 2:
> $ ethtool -L ens1 combined 2
> 
> A user can check the max supported virtqueues for a management device by
> running:
> 
> $ $ vdpa mgmtdev show
>     auxiliary/mlx5_core.sf.1:
>       supported_classes net
>       max_supported_vqs 257
>       dev_features CSUM GUEST_CSUM MTU HOST_TSO4 HOST_TSO6 STATUS CTRL_VQ MQ \
>                    CTRL_MAC_ADDR VERSION_1 ACCESS_PLATFORM
> 
> and refer to this value when adding a device.
> 
> To create a device with a max of 5 VQPs:
> vdpa dev add name vdpa-a mgmtdev auxiliary/mlx5_core.sf.1 max_vqp 5
> 
> Please note that for patches that were changed I removed "Reviewed-by"
> and "Acked-by".
> 
> v6 -> v7:
> 1. Make use of cf_mutex for serializing netlink set/get with other
> calls.
> 2. Some fixes (See in each patch)
> 3. Add patch for vdpa_sim to report supported features
> 4. "Reviewed-by" and "Acked-by" removed from patch 0007 since it had
> slightly changed.
> 
> Eli Cohen (14):
>   vdpa: Provide interface to read driver features
>   vdpa/mlx5: Distribute RX virtqueues in RQT object
>   vdpa: Sync calls set/get config/status with cf_mutex
>   vdpa: Read device configuration only if FEATURES_OK
>   vdpa: Allow to configure max data virtqueues
>   vdpa/mlx5: Fix config_attr_mask assignment
>   vdpa/mlx5: Support configuring max data virtqueue
>   vdpa: Add support for returning device configuration information
>   vdpa/mlx5: Restore cur_num_vqs in case of failure in change_num_qps()
>   vdpa: Support reporting max device capabilities
>   vdpa/mlx5: Report max device capabilities
>   vdpa/vdpa_sim: Configure max supported virtqueues
>   vdpa: Use BIT_ULL for bit operations
>   vdpa/vdpa_sim_net: Report max device capabilities
> 
>  drivers/vdpa/alibaba/eni_vdpa.c      |  16 +++-
>  drivers/vdpa/ifcvf/ifcvf_main.c      |  16 +++-
>  drivers/vdpa/mlx5/net/mlx5_vnet.c    | 134 ++++++++++++++++-----------
>  drivers/vdpa/vdpa.c                  | 100 ++++++++++++++++----
>  drivers/vdpa/vdpa_sim/vdpa_sim.c     |  21 +++--
>  drivers/vdpa/vdpa_sim/vdpa_sim_net.c |   2 +
>  drivers/vdpa/vdpa_user/vduse_dev.c   |  16 +++-
>  drivers/vdpa/virtio_pci/vp_vdpa.c    |  16 +++-
>  drivers/vhost/vdpa.c                 |  11 +--
>  drivers/virtio/virtio_vdpa.c         |   7 +-
>  include/linux/vdpa.h                 |  36 +++++--
>  include/uapi/linux/vdpa.h            |   6 ++
>  12 files changed, 271 insertions(+), 110 deletions(-)
> 
> -- 
> 2.34.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
