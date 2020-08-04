Return-Path: <SRS0=iZVf=BO=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B56D0C433DF
	for <virtualization@archiver.kernel.org>; Tue,  4 Aug 2020 09:40:10 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6D5022CA1
	for <virtualization@archiver.kernel.org>; Tue,  4 Aug 2020 09:40:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SOX8JKmr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6D5022CA1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 33B8D85DFC;
	Tue,  4 Aug 2020 09:40:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IK7ms1FrnHHN; Tue,  4 Aug 2020 09:40:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 7130E85DC7;
	Tue,  4 Aug 2020 09:40:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 54CD3C0050;
	Tue,  4 Aug 2020 09:40:09 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 51D01C004C
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Aug 2020 09:40:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 406D385DFC
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Aug 2020 09:40:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NP9agHu48n8i
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Aug 2020 09:40:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [205.139.110.120])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 70C7A85DC7
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Aug 2020 09:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596534006;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jW84deMk6p56y/ykUAk+F7yv3Eu/gTy0iAOseaqw0ns=;
 b=SOX8JKmrutm8zGqLdY4S8G42KB0ncGC+7QyK6WJYGhy9zLW7C58whcun2SikxJ7qo9zmVI
 Un0b2jYLXTw/W8lWeeyG8s4LWeuPmbb7RWX3B4ooVRAkcQfA/HNopSaaWNuetcqiXIhdAX
 zE1FJVDdFxghGlzGrD9ocy22Nr18fm8=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-218-kRJ77D39NzuY-nYKSly8-g-1; Tue, 04 Aug 2020 05:40:03 -0400
X-MC-Unique: kRJ77D39NzuY-nYKSly8-g-1
Received: by mail-qv1-f72.google.com with SMTP id d9so18883577qvl.10
 for <virtualization@lists.linux-foundation.org>;
 Tue, 04 Aug 2020 02:40:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=jW84deMk6p56y/ykUAk+F7yv3Eu/gTy0iAOseaqw0ns=;
 b=ngAWybDShdm2Icq1MOXjqAbML08fRRo+QgiKvjoX9P2ri/+BJiS4lZplW+dAjwkW5J
 VLyfey4HQrILMI1cpJDDzOVPiQGMdbIHe1TtPFvobjFoRkaDjhFtcN4L/GXVveNPrQ5c
 7KdOoN6xVoCJUTNFYCwAHguyFSxZ2LSRH3TkU66zjND7/7kxZKo451LvLu1tPObrzXvo
 GxNjw9+Vjg8rAiURXEDOLfnT4UxXtgG+EoxmnJzGNOgiThOCEtwsLj81EdzGHi3pRn/3
 7sdgFkLvhCOFWLTaCxRGeO8K687t1Bz8vXJfrdd2pevsBB5a3nIC4eOJB1P6dweT/imv
 ibrw==
X-Gm-Message-State: AOAM532OBD/aeyWhZMbrLcsON1ERxgFFx/Nn6l/MXWI9JcBW20iR2LNm
 zGon6Dboxmk3C8O8QDymkxFc8g1zZPdMTA0iDEreQqzgej2A4Ur0e14+sW5aROJzOPl7iqKtXQa
 lXCFGbXhSRVCChIj3JBPe+akLV6ZLKTS684ublI9mrw==
X-Received: by 2002:a05:620a:201a:: with SMTP id
 c26mr19770593qka.155.1596534003228; 
 Tue, 04 Aug 2020 02:40:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwegsCmBSNKHy1HPOjgd1tOgkTvjxnCvldsLlV5BQGIA+2luie2cUE4wQXf0SIZGLmj/gdnmw==
X-Received: by 2002:a05:620a:201a:: with SMTP id
 c26mr19770573qka.155.1596534002957; 
 Tue, 04 Aug 2020 02:40:02 -0700 (PDT)
Received: from redhat.com (bzq-79-177-102-128.red.bezeqint.net.
 [79.177.102.128])
 by smtp.gmail.com with ESMTPSA id m203sm21443199qke.114.2020.08.04.02.40.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Aug 2020 02:40:02 -0700 (PDT)
Date: Tue, 4 Aug 2020 05:39:58 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eli Cohen <eli@mellanox.com>
Subject: Re: [PATCH V3 vhost next 00/10] VDPA support for Mellanox ConnectX
 devices
Message-ID: <20200804053922-mutt-send-email-mst@kernel.org>
References: <20200728060539.4163-1-eli@mellanox.com>
 <20200803164756-mutt-send-email-mst@kernel.org>
 <20200804053432.GB58580@mtl-vdi-166.wap.labs.mlnx>
MIME-Version: 1.0
In-Reply-To: <20200804053432.GB58580@mtl-vdi-166.wap.labs.mlnx>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: shahafs@mellanox.com, parav@mellanox.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, saeedm@mellanox.com
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

On Tue, Aug 04, 2020 at 08:34:32AM +0300, Eli Cohen wrote:
> On Mon, Aug 03, 2020 at 04:51:27PM -0400, Michael S. Tsirkin wrote:
> > On Tue, Jul 28, 2020 at 09:05:29AM +0300, Eli Cohen wrote:
> > > Hi Michael,
> > > please note that this series depends on mlx5 core device driver patches
> > > in mlx5-next branch in
> > > git://git.kernel.org/pub/scm/linux/kernel/git/mellanox/linux.git.
> > > git pull git://git.kernel.org/pub/scm/linux/kernel/git/mellanox/linux.git mlx5-next 
> > > 
> > > They also depend Jason Wang's patches submitted a couple of weeks ago.
> > > 
> > > vdpa_sim: use the batching API
> > > vhost-vdpa: support batch updating
> > 
> > Hmm this makes merging them messy. I can ack merging them through
> > the mellanox tree, but
> > conflicts between Jason's patches and what's in my tree also exist.
> > 
> 
> Let me see if this is something I can fix.
> 
> > How big is the dependency? Can I pick it up with your ack?
> > 
> > Also, mips build failures need to be dealt with.
> > 
> Will look into it.


Thanks!
I'd like to have everything ready by end of week if possible,
send pull next Monday/Tuesday.

> > > 
> > > 
> > > The following series of patches provide VDPA support for Mellanox
> > > devices. The supported devices are ConnectX6 DX and newer.
> > > 
> > > Currently, only a network driver is implemented; future patches will
> > > introduce a block device driver. iperf performance on a single queue is
> > > around 12 Gbps.  Future patches will introduce multi queue support.
> > > 
> > > The files are organized in such a way that code that can be used by
> > > different VDPA implementations will be placed in a common are resides in
> > > drivers/vdpa/mlx5/core.
> > > 
> > > Only virtual functions are currently supported. Also, certain firmware
> > > capabilities must be set to enable the driver. Physical functions (PFs)
> > > are skipped by the driver.
> > > 
> > > To make use of the VDPA net driver, one must load mlx5_vdpa. In such
> > > case, VFs will be operated by the VDPA driver. Although one can see a
> > > regular instance of a network driver on the VF, the VDPA driver takes
> > > precedence over the NIC driver, steering-wize.
> > > 
> > > Currently, the device/interface infrastructure in mlx5_core is used to
> > > probe drivers. Future patches will introduce virtbus as a means to
> > > register devices and drivers and VDPA will be adapted to it.
> > > 
> > > The mlx5 mode of operation required to support VDPA is switchdev mode.
> > > Once can use Linux or OVS bridge to take care of layer 2 switching.
> > > 
> > > In order to provide virtio networking to a guest, an updated version of
> > > qemu is required. This version has been tested by the following quemu
> > > version:
> > > 
> > > url: https://github.com/jasowang/qemu.git
> > > branch: vdpa
> > > Commit ID: 6f4e59b807db
> > > 
> > > 
> > > V2->V3
> > > Fix makefile to use include path relative to the root of the kernel
> > > 
> > > Eli Cohen (7):
> > >   net/vdpa: Use struct for set/get vq state
> > >   vhost: Fix documentation
> > >   vdpa: Modify get_vq_state() to return error code
> > >   vdpa/mlx5: Add hardware descriptive header file
> > >   vdpa/mlx5: Add support library for mlx5 VDPA implementation
> > >   vdpa/mlx5: Add shared memory registration code
> > >   vdpa/mlx5: Add VDPA driver for supported mlx5 devices
> > > 
> > > Jason Wang (2):
> > >   vhost-vdpa: support batch updating
> > >   vdpa_sim: use the batching API
> > > 
> > > Max Gurtovoy (1):
> > >   vdpa: remove hard coded virtq num
> > > 
> > >  drivers/vdpa/Kconfig                   |   18 +
> > >  drivers/vdpa/Makefile                  |    1 +
> > >  drivers/vdpa/ifcvf/ifcvf_base.c        |    4 +-
> > >  drivers/vdpa/ifcvf/ifcvf_base.h        |    4 +-
> > >  drivers/vdpa/ifcvf/ifcvf_main.c        |   13 +-
> > >  drivers/vdpa/mlx5/Makefile             |    4 +
> > >  drivers/vdpa/mlx5/core/mlx5_vdpa.h     |   91 ++
> > >  drivers/vdpa/mlx5/core/mlx5_vdpa_ifc.h |  168 ++
> > >  drivers/vdpa/mlx5/core/mr.c            |  473 ++++++
> > >  drivers/vdpa/mlx5/core/resources.c     |  284 ++++
> > >  drivers/vdpa/mlx5/net/main.c           |   76 +
> > >  drivers/vdpa/mlx5/net/mlx5_vnet.c      | 1950 ++++++++++++++++++++++++
> > >  drivers/vdpa/mlx5/net/mlx5_vnet.h      |   24 +
> > >  drivers/vdpa/vdpa.c                    |    3 +
> > >  drivers/vdpa/vdpa_sim/vdpa_sim.c       |   35 +-
> > >  drivers/vhost/iotlb.c                  |    4 +-
> > >  drivers/vhost/vdpa.c                   |   46 +-
> > >  include/linux/vdpa.h                   |   24 +-
> > >  include/uapi/linux/vhost_types.h       |    2 +
> > >  19 files changed, 3165 insertions(+), 59 deletions(-)
> > >  create mode 100644 drivers/vdpa/mlx5/Makefile
> > >  create mode 100644 drivers/vdpa/mlx5/core/mlx5_vdpa.h
> > >  create mode 100644 drivers/vdpa/mlx5/core/mlx5_vdpa_ifc.h
> > >  create mode 100644 drivers/vdpa/mlx5/core/mr.c
> > >  create mode 100644 drivers/vdpa/mlx5/core/resources.c
> > >  create mode 100644 drivers/vdpa/mlx5/net/main.c
> > >  create mode 100644 drivers/vdpa/mlx5/net/mlx5_vnet.c
> > >  create mode 100644 drivers/vdpa/mlx5/net/mlx5_vnet.h
> > > 
> > > -- 
> > > 2.26.0
> > 

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
