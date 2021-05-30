Return-Path: <SRS0=Dilt=KZ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1693C47089
	for <virtualization@archiver.kernel.org>; Sun, 30 May 2021 08:36:29 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C599611AB
	for <virtualization@archiver.kernel.org>; Sun, 30 May 2021 08:36:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C599611AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1B9CF60662;
	Sun, 30 May 2021 08:36:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 28Tr7TXESo99; Sun, 30 May 2021 08:36:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id A5F6660611;
	Sun, 30 May 2021 08:36:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7EB0AC000D;
	Sun, 30 May 2021 08:36:27 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2A228C0001
 for <virtualization@lists.linux-foundation.org>;
 Sun, 30 May 2021 08:36:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0BA2583B42
 for <virtualization@lists.linux-foundation.org>;
 Sun, 30 May 2021 08:36:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vEIcx0M0ZBmA
 for <virtualization@lists.linux-foundation.org>;
 Sun, 30 May 2021 08:36:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 49AF783B35
 for <virtualization@lists.linux-foundation.org>;
 Sun, 30 May 2021 08:36:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1622363784;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rPWV5Lhhmpc5MWX7kc/tOx8+hiom19SEKERJ7ungmEA=;
 b=iwbfgkTC7XP9EjFTCJrMLRXL/So4mcpbjlR4fBj2mw+tkbq2khhG7rxHLuaQPJ/9DdPCLD
 APoK7fJU+oYvGPFzmw5ri+ypLHZtEEZD/BUqNs75PpVa+v7u+iK29D4RKxxll++Ak8LJ1k
 R+HZZMQTTY0HX4fZRfwLVO7qkSc48Fc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-435-TFc0HaDKOQKecPPeSHxeYA-1; Sun, 30 May 2021 04:36:22 -0400
X-MC-Unique: TFc0HaDKOQKecPPeSHxeYA-1
Received: by mail-wm1-f72.google.com with SMTP id
 n20-20020a05600c4f94b029017f371265feso3476666wmq.5
 for <virtualization@lists.linux-foundation.org>;
 Sun, 30 May 2021 01:36:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=rPWV5Lhhmpc5MWX7kc/tOx8+hiom19SEKERJ7ungmEA=;
 b=qJXneqYF076YCQ6l1VrH71N+kLDExyou/TFNoozosEC8ao5y0PGk1vTKQOvA0V4NGi
 KQrvK69bLZhY6FNDyR4clEORFiE7d9GUGBrcelDg03PmIvI6vJi8IVf8btmlefFCG0OW
 N1RpvSb1DkyFDsk1epwLH/TKG/CHqkl2kjuErwLDfejbkRrHpzhYWDlnoq0VsVZk9DPF
 1kKE4al6dfmPEWeHSSTdLCLsuIvzOV3HELeX44YbOZ4LhXVphDTEORaZ1cQXmBoAU68C
 c0igdD0nguqB8W1jQGZ+ERwscBw1mfrQD2sPG1S13sKpe1rj8ODq6yOmE/n5xtzQN4Fe
 LQHQ==
X-Gm-Message-State: AOAM530F1yUsWlgNJS5aRx6gfCD84heFUfHiH4zKHw0ymCDaOHBL+APL
 uqiSjqzblP7o5yH9SwxdKYVU9i+3yqWQHEWnscBxgwoxpujs9jMP69yTkEzlyGmJO896wrBsbXl
 L6tlk8FUZjRZXtfd9/hRsT2nAtWmTe5+WneGMEj4A7g==
X-Received: by 2002:adf:e0c6:: with SMTP id m6mr17461980wri.66.1622363781411; 
 Sun, 30 May 2021 01:36:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzfJVD9JxGTr+o5E29mqDZk0lMDbrZDUMhLuU2yvl6llrQHJ68BCSV+ZNO9mXeb+n23IwdYAQ==
X-Received: by 2002:adf:e0c6:: with SMTP id m6mr17461970wri.66.1622363781286; 
 Sun, 30 May 2021 01:36:21 -0700 (PDT)
Received: from redhat.com ([2a00:a040:196:94e6::1002])
 by smtp.gmail.com with ESMTPSA id g6sm11946594wmg.10.2021.05.30.01.36.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 30 May 2021 01:36:20 -0700 (PDT)
Date: Sun, 30 May 2021 04:36:17 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eli Cohen <elic@nvidia.com>
Subject: Re: [PATCH 1/2] vdpa/mlx5: Fix umem sizes assignments on VQ create
Message-ID: <20210530043536-mutt-send-email-mst@kernel.org>
References: <20210530063128.183258-1-elic@nvidia.com>
 <20210530040458-mutt-send-email-mst@kernel.org>
 <20210530081536.GA119906@mtl-vdi-166.wap.labs.mlnx>
 <20210530041624-mutt-send-email-mst@kernel.org>
 <20210530082646.GA120333@mtl-vdi-166.wap.labs.mlnx>
MIME-Version: 1.0
In-Reply-To: <20210530082646.GA120333@mtl-vdi-166.wap.labs.mlnx>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
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

On Sun, May 30, 2021 at 11:26:46AM +0300, Eli Cohen wrote:
> On Sun, May 30, 2021 at 04:19:01AM -0400, Michael S. Tsirkin wrote:
> > On Sun, May 30, 2021 at 11:15:36AM +0300, Eli Cohen wrote:
> > > On Sun, May 30, 2021 at 04:05:16AM -0400, Michael S. Tsirkin wrote:
> > > > On Sun, May 30, 2021 at 09:31:28AM +0300, Eli Cohen wrote:
> > > > > Fix copy paste bug assigning umem1 size to umem2 and umem3.
> > > > > 
> > > > > Fixes: 1a86b377aa21 ("vdpa/mlx5: Add VDPA driver for supported mlx5 devices")
> > > > > Signed-off-by: Eli Cohen <elic@nvidia.com>
> > > > 
> > > > could you clarify the impact of the bug please?
> > > > 
> > > 
> > > I leads to firmware failure to create the virtqueue resource when you
> > > try to use a 1:1 mapping MR. This kind of usage is presented in the
> > > virtio_vdpa support I sent earlier.
> > 
> > OK pls include this info in the commit log.
> OK
> 
> > And is 1:1 the only case where
> > sizes differ? Is it true that in other cases sizes are all the same?
> > 
> The sizes are calculated based on firmware published paramters and a
> formula provided by the spec. They do differ but it so happened that
> size1 was larger than size2 and size3 so we did not see failures till
> now.

can this have a security impact? e.g. can guest access addresses
outside of it's memory with this?

> > > > > ---
> > > > >  drivers/vdpa/mlx5/net/mlx5_vnet.c | 4 ++--
> > > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > > > 
> > > > > diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > > > index 189e4385df40..53312f0460ad 100644
> > > > > --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > > > +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > > > @@ -828,9 +828,9 @@ static int create_virtqueue(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtque
> > > > >  	MLX5_SET(virtio_q, vq_ctx, umem_1_id, mvq->umem1.id);
> > > > >  	MLX5_SET(virtio_q, vq_ctx, umem_1_size, mvq->umem1.size);
> > > > >  	MLX5_SET(virtio_q, vq_ctx, umem_2_id, mvq->umem2.id);
> > > > > -	MLX5_SET(virtio_q, vq_ctx, umem_2_size, mvq->umem1.size);
> > > > > +	MLX5_SET(virtio_q, vq_ctx, umem_2_size, mvq->umem2.size);
> > > > >  	MLX5_SET(virtio_q, vq_ctx, umem_3_id, mvq->umem3.id);
> > > > > -	MLX5_SET(virtio_q, vq_ctx, umem_3_size, mvq->umem1.size);
> > > > > +	MLX5_SET(virtio_q, vq_ctx, umem_3_size, mvq->umem3.size);
> > > > >  	MLX5_SET(virtio_q, vq_ctx, pd, ndev->mvdev.res.pdn);
> > > > >  	if (MLX5_CAP_DEV_VDPA_EMULATION(ndev->mvdev.mdev, eth_frame_offload_type))
> > > > >  		MLX5_SET(virtio_q, vq_ctx, virtio_version_1_0, 1);
> > > > > -- 
> > > > > 2.31.1
> > > > 
> > 

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
