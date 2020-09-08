Return-Path: <SRS0=DDSL=CR=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E44A3C433E2
	for <virtualization@archiver.kernel.org>; Tue,  8 Sep 2020 12:04:49 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64B9A21D81
	for <virtualization@archiver.kernel.org>; Tue,  8 Sep 2020 12:04:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I3pV64oU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64B9A21D81
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 19184869BC;
	Tue,  8 Sep 2020 12:04:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Kqe49lU-_USy; Tue,  8 Sep 2020 12:04:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 8EE1E864C3;
	Tue,  8 Sep 2020 12:04:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6839DC0859;
	Tue,  8 Sep 2020 12:04:46 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F1A18C0051
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Sep 2020 12:04:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id DA329872B2
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Sep 2020 12:04:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id C5iF-HKXWYwR
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Sep 2020 12:04:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-1.mimecast.com
 [205.139.110.61])
 by hemlock.osuosl.org (Postfix) with ESMTPS id CFA42872B0
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Sep 2020 12:04:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599566682;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YjOdee3Q/C2UqkYbF7JyUTOdPT3/RYJMa4NGdcXzk8c=;
 b=I3pV64oUhii8hf9Jxp9y9ygsz5MKtYHnZDXcpLUdBeIQA9yjTVMsvrFueA03+hDyQLBH0t
 ZxCjooDozfJZw5RJUHCXNmBzypLd6cxVhvhrHG4Yk1036rB2Q6hQ+E5RHJEanXLvLbFnrH
 p/AQF6SxHYKaUrjZPVr0hOfx9qsZC8c=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-230-0GqQZfmnO2a-vg9cjwS0xg-1; Tue, 08 Sep 2020 08:04:41 -0400
X-MC-Unique: 0GqQZfmnO2a-vg9cjwS0xg-1
Received: by mail-wm1-f70.google.com with SMTP id w3so4661155wmg.4
 for <virtualization@lists.linux-foundation.org>;
 Tue, 08 Sep 2020 05:04:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=YjOdee3Q/C2UqkYbF7JyUTOdPT3/RYJMa4NGdcXzk8c=;
 b=pmgbebchS/X0AWeX0iVAF4s/fPRI6gl1oRLMcoY9ouBSD3Xa63u4o6aSVCE0WR7tIZ
 gC9WMqlDWcCB67RZPE7L9fA2i3tslesApkTV0XWcTJBS/rehSRqhPbUXeVXEhBWEwKrU
 HXobgXPRkrVcchQ3K752wK4aMtPOQyAaQ31G0UGKI24RkKWf4dS5UmJyb5nsAATwHRy0
 zSOnTVGJakhrES4xF1R7Wbwet7DfaAoU+/mELK2QEyfM15SryIHOB2Fxsvvoz4J+Q3Ov
 bsOdas01vt/J1ZOwncW8u1O1jEKkTA2cgCA7y99EECp8yneXXqqHz9bq19uWoKQHQLdZ
 aNNA==
X-Gm-Message-State: AOAM532TRoQEyP0zUPNINJDLoQ5+bLfqW6i0BxZ+vkFUIZRfMyLhu4vN
 TRWrYQrEnP8W5klmPUmiayeSAbIymubCtIoiQ/iZY7nhfJInyyBO8ddxDUKDbnX3wj1rivgb1aO
 rCm07GmJKOfUmvRlnGMaZET6/xTI2gov+YKwuW5xoJw==
X-Received: by 2002:a1c:a557:: with SMTP id o84mr3980904wme.96.1599566679918; 
 Tue, 08 Sep 2020 05:04:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzfM0XajRaKoImehnmBKZJjqFN0ajTAWb3xXq9shTOYnMiiCcSF9D1X8Yic4i86U+wLx/EFRw==
X-Received: by 2002:a1c:a557:: with SMTP id o84mr3980888wme.96.1599566679700; 
 Tue, 08 Sep 2020 05:04:39 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-221-30.inter.net.il. [80.230.221.30])
 by smtp.gmail.com with ESMTPSA id v204sm32533592wmg.20.2020.09.08.05.04.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2020 05:04:38 -0700 (PDT)
Date: Tue, 8 Sep 2020 08:04:35 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eli Cohen <elic@nvidia.com>
Subject: Re: [PATCH] vdpa/mlx5: Setup driver only if VIRTIO_CONFIG_S_DRIVER_OK
Message-ID: <20200908080428-mutt-send-email-mst@kernel.org>
References: <20200907075136.GA114876@mtl-vdi-166.wap.labs.mlnx>
 <20200907073319-mutt-send-email-mst@kernel.org>
 <20200907114351.GC121033@mtl-vdi-166.wap.labs.mlnx>
MIME-Version: 1.0
In-Reply-To: <20200907114351.GC121033@mtl-vdi-166.wap.labs.mlnx>
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

On Mon, Sep 07, 2020 at 02:43:51PM +0300, Eli Cohen wrote:
> On Mon, Sep 07, 2020 at 07:34:00AM -0400, Michael S. Tsirkin wrote:
> > On Mon, Sep 07, 2020 at 10:51:36AM +0300, Eli Cohen wrote:
> > > If the memory map changes before the driver status is
> > > VIRTIO_CONFIG_S_DRIVER_OK, don't attempt to create resources because it
> > > may fail. For example, if the VQ is not ready there is no point in
> > > creating resources.
> > > 
> > > Fixes: 1a86b377aa21 ("vdpa/mlx5: Add VDPA driver for supported mlx5 devices")
> > > Signed-off-by: Eli Cohen <elic@nvidia.com>
> > 
> > 
> > Could you add a bit more data about the problem to the log?
> > To be more exact, what exactly happens right now?
> >
> 
> Sure I can.
> 
> set_map() is used by mlx5 vdpa to create a memory region based on the
> address map passed by the iotlb argument. If I get successive calls, I
> will destroy the current memory region and build another one based on
> the new address mapping. I also need to setup the hardware resources
> since they depend on the memory region.
> 
> If these calls happen before DRIVER_OK, It means it that driver VQs may
> also not been setup and I may not create them yet. In this case I want
> to avoid setting up the other resources and defer this till I get DRIVER
> OK.
> 
> Let me know if that answers your question so I can post another patch.

it does, pls do.

> > > ---
> > >  drivers/vdpa/mlx5/net/mlx5_vnet.c | 3 +++
> > >  1 file changed, 3 insertions(+)
> > > 
> > > diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > index 9df69d5efe8c..c89cd48a0aab 100644
> > > --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > @@ -1645,6 +1645,9 @@ static int mlx5_vdpa_change_map(struct mlx5_vdpa_net *ndev, struct vhost_iotlb *
> > >  	if (err)
> > >  		goto err_mr;
> > >  
> > > +	if (!(ndev->mvdev.status & VIRTIO_CONFIG_S_DRIVER_OK))
> > > +		return 0;
> > > +
> > >  	restore_channels_info(ndev);
> > >  	err = setup_driver(ndev);
> > >  	if (err)
> > > -- 
> > > 2.26.0
> > 

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
