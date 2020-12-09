Return-Path: <SRS0=MC01=FN=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B233C433FE
	for <virtualization@archiver.kernel.org>; Wed,  9 Dec 2020 06:46:36 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D576723B7D
	for <virtualization@archiver.kernel.org>; Wed,  9 Dec 2020 06:46:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D576723B7D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 6FE0086A97;
	Wed,  9 Dec 2020 06:46:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 94DYWW5IOGDh; Wed,  9 Dec 2020 06:46:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id D78E086A7F;
	Wed,  9 Dec 2020 06:46:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B3729C0FA7;
	Wed,  9 Dec 2020 06:46:34 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 429ABC013B
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Dec 2020 06:46:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 216D5203A8
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Dec 2020 06:46:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id feijZrKsFCdh
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Dec 2020 06:46:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by silver.osuosl.org (Postfix) with ESMTPS id 115AA20385
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Dec 2020 06:46:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1607496390;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JWegwtDJ2omVRz2Kp6FHFNujjEo+eYTsjLuIyLZ+Tmg=;
 b=RrKhhwk2BZZKdUur+g/oi6un9ZRdnfcEzLso7rP8hOE2eAU4Wvp9GHWBbB3vEXc1fbr1B8
 Fw9mc7MoVRHGeiJ4wQq2oYMHoKpcaRfdSiuu2IaaDGbfozOOo6SDrX0GdJwIcXLdlmnNM/
 TB7a+IONKavJzmchVKXENSpu9eO6EvY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-523-h4lrl4Y-Mfubv5fsP5l5sA-1; Wed, 09 Dec 2020 01:46:28 -0500
X-MC-Unique: h4lrl4Y-Mfubv5fsP5l5sA-1
Received: by mail-wr1-f72.google.com with SMTP id 91so262096wrk.17
 for <virtualization@lists.linux-foundation.org>;
 Tue, 08 Dec 2020 22:46:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=JWegwtDJ2omVRz2Kp6FHFNujjEo+eYTsjLuIyLZ+Tmg=;
 b=mYFor6gMZDVgjYddKbsjW+mI55CaQXM8ARv/8slErtMFAyVrbaPemc6cYUNSUhMSOD
 YqlngFSr1zcONrAJBaklcXdXiD6tS0HQ1qLDnFUO8g1UKS9VkVRa32S0bE1RHcIBck3a
 HMyov8IO8cMmANlL8Lzjk3tLgDIcDD1MUvA3Xp1QpuhWRveBwvq3Rds/Twr6FxhT6NbY
 Qx94H9PtcFcAW+WY+cfcul13wYlRn+0Vd4Rrt3bB3d5MImj2dppOTGyf+OnyTLNUsmG3
 dvIYgkM7UzqCJZVSnm6kPv4S8n5ert5AVYnlx8tckrXcLIFtpZzIkukfsgueSUAe5LiE
 lmiQ==
X-Gm-Message-State: AOAM530/52A3kn11MvbJ5cUSiMI4pe6AhPWDyyhMJgxuL93Gh+U0gT4z
 eZThGRq/DiieS2Cdw6LyQtyqtgVltKKLQLmq347aO5NuGZapUyKjeaV4eZ+QBm3q+28t9PoyN4S
 Ml43sFkjUGyTMFSRafRklg4fXt88GeuEnWD3zXlI83Q==
X-Received: by 2002:a5d:4d88:: with SMTP id b8mr903706wru.134.1607496387253;
 Tue, 08 Dec 2020 22:46:27 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwnALlGGbRyalUyQiiAMD7PPni/fY1a6aRhLxMF3Q+mP8mccZfLMhdqrEwUXVX4ohHXuNvquQ==
X-Received: by 2002:a5d:4d88:: with SMTP id b8mr903690wru.134.1607496387039;
 Tue, 08 Dec 2020 22:46:27 -0800 (PST)
Received: from redhat.com (bzq-79-176-44-197.red.bezeqint.net. [79.176.44.197])
 by smtp.gmail.com with ESMTPSA id j13sm1379338wmi.36.2020.12.08.22.46.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Dec 2020 22:46:25 -0800 (PST)
Date: Wed, 9 Dec 2020 01:46:22 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eli Cohen <elic@nvidia.com>
Subject: Re: [PATCH] vdpa/mlx5: Use write memory barrier after updating CQ
 index
Message-ID: <20201209014547-mutt-send-email-mst@kernel.org>
References: <20201206105719.123753-1-elic@nvidia.com>
 <20201208164356-mutt-send-email-mst@kernel.org>
 <20201209060230.GA57362@mtl-vdi-166.wap.labs.mlnx>
MIME-Version: 1.0
In-Reply-To: <20201209060230.GA57362@mtl-vdi-166.wap.labs.mlnx>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: linux-kernel@vger.kernel.org, lulu@redhat.com,
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

On Wed, Dec 09, 2020 at 08:02:30AM +0200, Eli Cohen wrote:
> On Tue, Dec 08, 2020 at 04:45:04PM -0500, Michael S. Tsirkin wrote:
> > On Sun, Dec 06, 2020 at 12:57:19PM +0200, Eli Cohen wrote:
> > > Make sure to put write memory barrier after updating CQ consumer index
> > > so the hardware knows that there are available CQE slots in the queue.
> > > 
> > > Failure to do this can cause the update of the RX doorbell record to get
> > > updated before the CQ consumer index resulting in CQ overrun.
> > > 
> > > Change-Id: Ib0ae4c118cce524c9f492b32569179f3c1f04cc1
> > > Fixes: 1a86b377aa21 ("vdpa/mlx5: Add VDPA driver for supported mlx5 devices")
> > > Signed-off-by: Eli Cohen <elic@nvidia.com>
> > 
> > Aren't both memory writes?
> 
> Not sure what exactly you mean here.

Both updates are CPU writes into RAM that hardware then reads
using DMA.

> > And given that, isn't dma_wmb() sufficient here?
> 
> I agree that dma_wmb() is more appropriate here.
> 
> > 
> > 
> > > ---
> > >  drivers/vdpa/mlx5/net/mlx5_vnet.c | 5 +++++
> > >  1 file changed, 5 insertions(+)
> > > 
> > > diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > index 1f4089c6f9d7..295f46eea2a5 100644
> > > --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > @@ -478,6 +478,11 @@ static int mlx5_vdpa_poll_one(struct mlx5_vdpa_cq *vcq)
> > >  static void mlx5_vdpa_handle_completions(struct mlx5_vdpa_virtqueue *mvq, int num)
> > >  {
> > >  	mlx5_cq_set_ci(&mvq->cq.mcq);
> > > +
> > > +	/* make sure CQ cosumer update is visible to the hardware before updating
> > > +	 * RX doorbell record.
> > > +	 */
> > > +	wmb();
> > >  	rx_post(&mvq->vqqp, num);
> > >  	if (mvq->event_cb.callback)
> > >  		mvq->event_cb.callback(mvq->event_cb.private);
> > > -- 
> > > 2.27.0
> > 

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
