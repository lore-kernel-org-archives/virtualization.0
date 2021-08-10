Return-Path: <SRS0=EG+p=NB=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09601C4338F
	for <virtualization@archiver.kernel.org>; Tue, 10 Aug 2021 14:32:30 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BF7160EBB
	for <virtualization@archiver.kernel.org>; Tue, 10 Aug 2021 14:32:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9BF7160EBB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5F3D060843;
	Tue, 10 Aug 2021 14:32:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id S4moRV9IRyaL; Tue, 10 Aug 2021 14:32:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 1084C606CB;
	Tue, 10 Aug 2021 14:32:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D3F60C001A;
	Tue, 10 Aug 2021 14:32:24 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8768FC000E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 Aug 2021 14:32:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6499683404
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 Aug 2021 14:32:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id buYU3So7tsUv
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 Aug 2021 14:32:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 817FB831E7
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 Aug 2021 14:32:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1628605941;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=om5Y/ZhdMeC1b5IvOSlyVjyQ6lHMYCbKlin2oMAH9GY=;
 b=FdcpXm+bYMSn1ynEGINj2IB13GSGOihqt6LmhRzkzHDbYFEj8xVb2f7pUKPblA3ASHbN5p
 7z/dtCSHlX9y3Bg/ryUl/g9v0x362Vhf251LhH2wOrvgXPaJ+flyNuENbHeuLQfyD3hRfq
 MstWbK0wiIGB7wu2NuRoR7Dhmn0lRk8=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-319-kB5jBUtuNWK3Nu5xyQ-o1Q-1; Tue, 10 Aug 2021 10:32:19 -0400
X-MC-Unique: kB5jBUtuNWK3Nu5xyQ-o1Q-1
Received: by mail-ed1-f72.google.com with SMTP id
 v20-20020aa7d9d40000b02903be68450bf3so3058299eds.23
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 Aug 2021 07:32:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=om5Y/ZhdMeC1b5IvOSlyVjyQ6lHMYCbKlin2oMAH9GY=;
 b=Blbn3qCyerhF58Q72B1i9JL4JEn6j/qlH8CEFeP65tLYvrn+uEHTw/12Vf5ML3lqMT
 x/dEuEUnOAnTpYoTNPQY+64Ge9sa3sZK2+B/N/MTUnoud3Y0f5YmSTCpTfma0GnaUaAq
 TOVYC1KMX4th7we97+mfQLWCaoKOWdrJ3sB6AeUkAGY+W8OJkG1tsBw6Tg/WC+Is7FOy
 U4Mq3ZbOyGQpx2yGtET+tVrNFBqjluCwi7GeXr6YXoUDlvWnHTX94afFsLFoPbA4NrPP
 oEYOvaz8T7Wp7WH5Xfg/n+/YhKgZ3JkP8tEkmrTUdubc64F2m+3louzCEb3PLKIylb8m
 qAeQ==
X-Gm-Message-State: AOAM5334GFEOqs4MKaM9g2icEm9kozrFVBIpoUxjPv09PaJQ2h0kLgJ0
 o77Twiz9ruv9KKEGLpcnms9wX1HGdu8S4pux0vU8MKt+285b496L6LRcUBP8UlDLnkMXzJXTcBp
 mIqLaHHGWvXfUH6R/jqgs4eUnrVws78mRFFI5JGbyFw==
X-Received: by 2002:aa7:d896:: with SMTP id u22mr3440860edq.290.1628605938788; 
 Tue, 10 Aug 2021 07:32:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy2L+u7J7XHZTTPT8H/MAFOxXTK17efl+SevY+l1CC/Xy8T3Q/6wiwJtOObK/1SAolUCXNpow==
X-Received: by 2002:aa7:d896:: with SMTP id u22mr3440839edq.290.1628605938644; 
 Tue, 10 Aug 2021 07:32:18 -0700 (PDT)
Received: from redhat.com ([2.55.156.103])
 by smtp.gmail.com with ESMTPSA id bm1sm6996069ejb.38.2021.08.10.07.32.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Aug 2021 07:32:17 -0700 (PDT)
Date: Tue, 10 Aug 2021 10:32:13 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eli Cohen <elic@nvidia.com>
Subject: Re: [PATCH 0/3] vdpa/mlx5: Add Control VQ and MAC and Multi queue
 support
Message-ID: <20210810093152-mutt-send-email-mst@kernel.org>
References: <20210809080043.169701-1-elic@nvidia.com>
 <20210809053528-mutt-send-email-mst@kernel.org>
 <20210809094803.GA217441@mtl-vdi-166.wap.labs.mlnx>
 <20210809054908-mutt-send-email-mst@kernel.org>
 <20210809095950.GA217852@mtl-vdi-166.wap.labs.mlnx>
MIME-Version: 1.0
In-Reply-To: <20210809095950.GA217852@mtl-vdi-166.wap.labs.mlnx>
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

On Mon, Aug 09, 2021 at 12:59:50PM +0300, Eli Cohen wrote:
> On Mon, Aug 09, 2021 at 05:50:02AM -0400, Michael S. Tsirkin wrote:
> > On Mon, Aug 09, 2021 at 12:48:03PM +0300, Eli Cohen wrote:
> > > On Mon, Aug 09, 2021 at 05:35:49AM -0400, Michael S. Tsirkin wrote:
> > > > On Mon, Aug 09, 2021 at 11:00:40AM +0300, Eli Cohen wrote:
> > > > > Hi Michael,
> > > > > 
> > > > > First patch is just a cleaup.
> > > > > Second patch adds control virtqueue support for mlx5_vdpa and handle MAC
> > > > > configutations through the control VQ.
> > > > > Third patch adds multi queue support for mlx5_vdpa accepting
> > > > > configurations from the control VQ.
> > > > 
> > > > Threading broken again :(
> > > 
> > > My mail client failed after sending the first two patches so I sent the
> > > other two as distinct emails. I assume it is realted but how can you see
> > > that threading is broken?
> > 
> > Patches 2 and 3 do not have In-Reply-To or References headers.
> > 
> > Patch 1 does:
> > 
> > In-Reply-To: <20210809080043.169701-1-elic@nvidia.com>
> > References: <20210809080043.169701-1-elic@nvidia.com>
> > 
> > One way to fix the setup is using git-send-email.
> > 
> 
> I did use git-send-email and here's what I got:
> 
> ...
> Result: 250
> (mbox) Adding cc: Eli Cohen <elic@nvidia.com> from line 'From: Eli Cohen
> <elic@nvidia.com>'
> (body) Adding cc: Eli Cohen <elic@nvidia.com> from line 'Signed-off-by:
> Eli Cohen <elic@nvidia.com>'
> 4.3.1 Insufficient system resources

That's your server's response.

> 
> Maybe it was a temporary problem. I will resend. Should I put v1 on it?

v1 is implicit.  Either v2 or "resend" in the prefix.

> > 
> > 
> > > > 
> > > > > Eli Cohen (3):
> > > > >   vdpa/mlx5: Remove redundant header file inclusion
> > > > >   vdpa/mlx5: Add support for control VQ and MAC setting
> > > > >   vdpa/mlx5: Add multiqueue support
> > > > > 
> > > > >  drivers/vdpa/mlx5/core/mlx5_vdpa.h |  25 +-
> > > > >  drivers/vdpa/mlx5/core/mr.c        |  87 ++++--
> > > > >  drivers/vdpa/mlx5/core/resources.c |  41 +++
> > > > >  drivers/vdpa/mlx5/net/mlx5_vnet.c  | 471 +++++++++++++++++++++++++----
> > > > >  4 files changed, 549 insertions(+), 75 deletions(-)
> > > > > 
> > > > > -- 
> > > > > 2.31.1
> > > > 
> > 

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
