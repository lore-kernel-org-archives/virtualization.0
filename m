Return-Path: <SRS0=Keeg=BP=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 454E0C433E0
	for <virtualization@archiver.kernel.org>; Wed,  5 Aug 2020 22:31:16 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08B1E20792
	for <virtualization@archiver.kernel.org>; Wed,  5 Aug 2020 22:31:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hQwWJzDU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08B1E20792
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id C260E86CC1;
	Wed,  5 Aug 2020 22:31:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id g0I5WffFP_7N; Wed,  5 Aug 2020 22:31:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 45FDA86A33;
	Wed,  5 Aug 2020 22:31:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 32FA7C0050;
	Wed,  5 Aug 2020 22:31:15 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2F62AC004C
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Aug 2020 22:31:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id B8433207EF
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Aug 2020 22:31:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0k6xTzzA6gIF
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Aug 2020 22:31:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by silver.osuosl.org (Postfix) with ESMTPS id 03A492050F
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Aug 2020 22:31:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596666670;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ta8W4lWYHuibGb7VenSY+ZFBUsjZkLeP1z3XiFNvHH0=;
 b=hQwWJzDUkFWLQgVxb/+JiWuM9z98Kjv7ZR5XSFGbtflL+HDjo8RHVTukVwEaymaqCka7tf
 CGoaimZIfEl1DoEZ+h3bv0XO5UoyH9CvHaYrXNNos1YiJKJ1WMjA1p81kfTf2tFxKY7LvT
 cYo7cdiCmtI4tayfyE2dVg8ZpkVv304=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-286--KpZITLpNmyXhbbGkhfiXw-1; Wed, 05 Aug 2020 18:31:06 -0400
X-MC-Unique: -KpZITLpNmyXhbbGkhfiXw-1
Received: by mail-wm1-f69.google.com with SMTP id u68so2947360wmu.3
 for <virtualization@lists.linux-foundation.org>;
 Wed, 05 Aug 2020 15:31:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Ta8W4lWYHuibGb7VenSY+ZFBUsjZkLeP1z3XiFNvHH0=;
 b=EWA2vPMFsL6LaImmnkViX77KebnupMqJpsJGm6435j0ozbo9/4/RY9AiK/8RMnmkNn
 yrZutAYc7Y06W6s6p+2HTmBDbnz4U7OLzDWooz2K6rPd/LV4rWaGYiDNwSKuHSjJV/2w
 Pm90irCHwNASSpMeywULyMbShHjZVMwLrmoAutOotARAlIW3jZtNXkOmM6xg4iZ/q6jI
 58Y2tkC/hAJ4Iel2Iniv+MzO36DhBOVagF03+hWucF7qk4jSRft2ZviX1TffFB9zI1vg
 ZC9edHw1kSKHBf+QqAVmR/ECWq0B/3CTLRz4KQ31Y5NvBvrFZR97IUbXYTKokptc8JNC
 i42Q==
X-Gm-Message-State: AOAM533IBNCXSQqMquBHu5RoewTm13UpFea6uZlpnJQf9WwrVYS7soB3
 Ml4U3kF88gLmOJmkxAjejZoaNdBD/ERNK9uOhiJArEXVzek7pn45lhT2ULzgQZrpVBQUfuT9UcI
 BPsDwQDun/5LRz8Csew7RPHRz04Bg8QgBwc2qAla1VA==
X-Received: by 2002:a5d:4ad1:: with SMTP id y17mr4895344wrs.132.1596666665632; 
 Wed, 05 Aug 2020 15:31:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJweYLLE6b8uo1XP/9+STMEkV5LbdOvdlrtunNKnBmO4rNYW4xagyblCQIRFcf+KM51Wo/Qexw==
X-Received: by 2002:a5d:4ad1:: with SMTP id y17mr4895324wrs.132.1596666665385; 
 Wed, 05 Aug 2020 15:31:05 -0700 (PDT)
Received: from redhat.com (bzq-79-177-102-128.red.bezeqint.net.
 [79.177.102.128])
 by smtp.gmail.com with ESMTPSA id 62sm4379354wrq.31.2020.08.05.15.31.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2020 15:31:04 -0700 (PDT)
Date: Wed, 5 Aug 2020 18:31:01 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Gunthorpe <jgg@mellanox.com>
Subject: Re: [PATCH V4 linux-next 00/12] VDPA support for Mellanox ConnectX
 devices
Message-ID: <20200805183017-mutt-send-email-mst@kernel.org>
References: <20200804162048.22587-1-eli@mellanox.com>
 <20200805075856-mutt-send-email-mst@kernel.org>
 <20200805124054.GA125576@mtl-vdi-166.wap.labs.mlnx>
 <20200805084604-mutt-send-email-mst@kernel.org>
 <20200805130158.GA126406@mtl-vdi-166.wap.labs.mlnx>
 <20200805090304-mutt-send-email-mst@kernel.org>
 <063f66418da235ee459b367c5049948ee6db59ce.camel@mellanox.com>
 <20200805194646.GJ19097@mellanox.com>
MIME-Version: 1.0
In-Reply-To: <20200805194646.GJ19097@mellanox.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Shahaf Shuler <shahafs@mellanox.com>, Parav Pandit <parav@mellanox.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 Saeed Mahameed <saeedm@mellanox.com>, Eli Cohen <eli@mellanox.com>
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

On Wed, Aug 05, 2020 at 04:46:46PM -0300, Jason Gunthorpe wrote:
> On Wed, Aug 05, 2020 at 07:01:52PM +0000, Saeed Mahameed wrote:
> > On Wed, 2020-08-05 at 09:12 -0400, Michael S. Tsirkin wrote:
> > > On Wed, Aug 05, 2020 at 04:01:58PM +0300, Eli Cohen wrote:
> > > > On Wed, Aug 05, 2020 at 08:48:52AM -0400, Michael S. Tsirkin wrote:
> > > > > > Did you merge this?:
> > > > > > git pull
> > > > > > git://git.kernel.org/pub/scm/linux/kernel/git/mellanox/linux.gi
> > > > > > t mlx5-next
> > > > > 
> > > > > I can only merge this tree if no one else will. Linus does not
> > > > > like getting same patches through two trees.
> 
> This is not quite the case
> 
> Linus does not like multiple *copies* of the same patches. The same
> actual git commits can be OK.
> 
> Linus also does not like unnecessarily cross linking trees, mlx5-next
> is designed to be small enough and approved enough that it is not
> controversial.
> 
> Linus really doesn't like it when people jams stuff together in rc7 or
> the weeks of the merge window. He wants to see stuff be in linux-next
> for at least a bit. So it may be too late regardless.

I'll try, let's see what happens.

> > We do this all the time with net-next and rdma,
> > mlx5-next is a very small branch based on a very early rc that includes
> > mlx5 shared stuff between rdma and net-next, and now virtio as well.
> 
> Yes, going on two years now? Been working well
> 
> Jason

OK, I'll merge it then. Thanks!

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
