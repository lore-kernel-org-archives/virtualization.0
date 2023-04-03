Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49A1CC761A6
	for <virtualization@archiver.kernel.org>; Mon,  3 Apr 2023 18:10:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C6FC381CD0;
	Mon,  3 Apr 2023 18:10:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C6FC381CD0
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=hRCuT61c
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zwMhGH73f9N9; Mon,  3 Apr 2023 18:10:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 4E7AB81CBA;
	Mon,  3 Apr 2023 18:10:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4E7AB81CBA
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 34CC7C0036;
	Mon,  3 Apr 2023 18:10:45 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 28203C002F
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 Apr 2023 18:10:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id EA1F281CD0
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 Apr 2023 18:10:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org EA1F281CD0
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jifsrj1GygBj
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 Apr 2023 18:10:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 10CAF81CBA
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 10CAF81CBA
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 Apr 2023 18:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1680545441;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ekb+7VZWDLO+9PsaCg//+LF2qmSztqUPoMJ7IaCQSl8=;
 b=hRCuT61c3Vy8Ao4hLuO9vOaVeet8nEHrv9Fkm+fYbL/QzZONZ6upujO7saWirPt+NvEZ9G
 /4gG6r7Rrl1xdOGeOYgQ6QWuMTrM2NgMErj3gQvs6lJxCEuCKihUt7jkRWKZyQXdezT52n
 YT0OrucVJ7Yj6kJGrt5Tb16KKRnguBQ=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-580-daJJTqkGOvmL6_4ETPWNQA-1; Mon, 03 Apr 2023 14:10:40 -0400
X-MC-Unique: daJJTqkGOvmL6_4ETPWNQA-1
Received: by mail-ed1-f70.google.com with SMTP id
 a27-20020a50c31b000000b0050047ecf4bfso42474126edb.19
 for <virtualization@lists.linux-foundation.org>;
 Mon, 03 Apr 2023 11:10:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1680545439;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ekb+7VZWDLO+9PsaCg//+LF2qmSztqUPoMJ7IaCQSl8=;
 b=xN0rNlsSj2h5fek1n9ESh7jTMgZpuXn6Cawb3k4vstUhm7X+4Gygh20oX3L5JoRNuI
 w6Ehw1cv/mrqUgQtVIDTURk4uRfPExxYBFOTKNcvDVY6KM9mvMeKhPv8cFvSCNMKtEEp
 odXj+RcPmvpT6VxWQKzwbqn8lKRPvpCYaqTQ666DKlO1dacDM2zoAr3JBM+ugdpWzsxx
 o87LPP7+0+tjll61a/M4RR5z4qZ0MAtj9M0t4jEqMYDr5JsmxLVw75MpELam0qU7KQKj
 BbcwQgrvNGEutKGF7GzO8qXmesZ4XkbvruwZbhDxfouGytLQuuFzT7US1QKR9qaP5dya
 RyVw==
X-Gm-Message-State: AAQBX9ce/T1fTsv9k+WDm2vOPp6VoUOmmWQFrbhI9o2D3+7583Jl6Kn9
 2DDmxMCdjdhuCyDWKbtCHJpPBe55bxCQT0hOe8KkdO1j3q+2DsU4OvnjteHNQqHGc9zLKkgfhc6
 irKSEMjLwLXEE3ZICyqIoyP9RVjETfjvXUqzTE2kzCg==
X-Received: by 2002:aa7:c913:0:b0:502:2953:8ecb with SMTP id
 b19-20020aa7c913000000b0050229538ecbmr127514edt.13.1680545439422; 
 Mon, 03 Apr 2023 11:10:39 -0700 (PDT)
X-Google-Smtp-Source: AKy350bsKCs9oIDMf/Ynmz93qxYetyoMgBMlw5LhSI29pwGG7cAhb0qH4+afV/fQMnBl8eZu1bPNkQ==
X-Received: by 2002:aa7:c913:0:b0:502:2953:8ecb with SMTP id
 b19-20020aa7c913000000b0050229538ecbmr127503edt.13.1680545439166; 
 Mon, 03 Apr 2023 11:10:39 -0700 (PDT)
Received: from redhat.com ([213.152.162.235]) by smtp.gmail.com with ESMTPSA id
 j26-20020a50d01a000000b004c4eed3fe20sm4971556edf.5.2023.04.03.11.10.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Apr 2023 11:10:38 -0700 (PDT)
Date: Mon, 3 Apr 2023 14:10:33 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Subject: Re: [PATCH 0/1] posted interrtups support for mlx5
Message-ID: <20230403141005-mutt-send-email-mst@kernel.org>
References: <20230403162039.18932-1-elic@nvidia.com>
 <9db042bd-1bf9-9664-cb01-419be1a2f209@nvidia.com>
 <20230403140728-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20230403140728-mutt-send-email-mst@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: parav@mellanox.com, virtualization@lists.linux-foundation.org,
 eperezma@redhat.com, Eli Cohen <elic@nvidia.com>
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

On Mon, Apr 03, 2023 at 02:09:46PM -0400, Michael S. Tsirkin wrote:
> On Mon, Apr 03, 2023 at 01:00:16PM -0400, Parav Pandit wrote:
> > 
> > 
> > On 4/3/2023 12:20 PM, Eli Cohen wrote:
> > > Hi,
> > > 
> > > the single patch in this series adds support for posted interrupts in
> > > mlx5.
> > > 
> > > It depends on the patch series already accpted can be seen here:
> > > https://patchwork.kernel.org/project/netdevbpf/patch/20230324231341.29808-1-saeed@kernel.org/
> > > 
> > > git pull  git://git.kernel.org/pub/scm/linux/kernel/git/saeed/linux.git
> > > tags/mlx5-updates-2023-03-20
> > > 
> > > Eli Cohen (1):
> > >    vdpa/mlx5: Support interrupt bypassing
> > > 
> > >   drivers/vdpa/mlx5/net/mlx5_vnet.c | 139 ++++++++++++++++++++++++++++--
> > >   drivers/vdpa/mlx5/net/mlx5_vnet.h |  14 +++
> > >   2 files changed, 144 insertions(+), 9 deletions(-)
> > > 
> > In subject
> > 
> > s/interrtups/interrupts/
> 
> In fact if we are splitting hairs, this is a reduced relative (full form
> would be "support of posted interrupts") so it should not use a plural
> form. Also pls use a prefix in the patch subject. In the end:
> 	mlx5: posted interrupt support
> would be better.

Having said that, it's 0/1 so typos do not matter, they are not
in commit log.

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
