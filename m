Return-Path: <SRS0=iZVf=BO=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50A44C433DF
	for <virtualization@archiver.kernel.org>; Tue,  4 Aug 2020 21:29:27 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 298F120842
	for <virtualization@archiver.kernel.org>; Tue,  4 Aug 2020 21:29:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vrs6HTPd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 298F120842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id C14E52048E;
	Tue,  4 Aug 2020 21:29:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AYAtM9thQYKD; Tue,  4 Aug 2020 21:29:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 317D31FD21;
	Tue,  4 Aug 2020 21:29:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2291CC0050;
	Tue,  4 Aug 2020 21:29:25 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B9936C004C
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Aug 2020 21:29:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 9F39020433
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Aug 2020 21:29:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4keY1lmrfNLH
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Aug 2020 21:29:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [205.139.110.120])
 by silver.osuosl.org (Postfix) with ESMTPS id 8A05D1FD21
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Aug 2020 21:29:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596576561;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mp8oPykQbFI3PCYtU3bJ6U6U1V5IO9G5ow6aH0G/PE4=;
 b=Vrs6HTPdQftHvX90p9SwE0bJfAJvzzRPx29krHBYUwtuAEKqSB2KXzPSzaA+Jp7Y0NsGhT
 QAFldci66IMsbhWWAFplYuqU8ESriOIzZyqs0DlDgoOwQptg1ApUcIBP8KNQG9WPtoo3En
 KxeL7v6TUcNoKQkoVMijpB4lGJjj6e8=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-106-Da2x4KAdO6Ou6P7LSHljBQ-1; Tue, 04 Aug 2020 17:29:15 -0400
X-MC-Unique: Da2x4KAdO6Ou6P7LSHljBQ-1
Received: by mail-qk1-f199.google.com with SMTP id c191so19671519qkb.4
 for <virtualization@lists.linux-foundation.org>;
 Tue, 04 Aug 2020 14:29:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=mp8oPykQbFI3PCYtU3bJ6U6U1V5IO9G5ow6aH0G/PE4=;
 b=tYKuGaHkSG9npc9ETpxmA3M00RgSTRC8cHOphdqWwXBiRWn7MG6TjRyZOEKW/VRc94
 un43x7LMYcxgUKCqY6ZYmDmkenM6jI7qvuCbYXT62wI4wezii3NB7aKTojPXuydyzgXH
 dAa476IK4PvuHdos1H37OEb5/MQJfCGiW6UrZJzaedN70broC0RGiZAwUbGM33Im71IT
 iemlikMjVIkIkHCWgTkUQLCdb9PXoeFiz1xp595ln8rALYg1Z538LPZAsUj1W8yoR2H4
 QfzChHnURtXcwPP/XKLQMV7GQPci8ogbeqpqU+PeBqKIyyabimDTpqRUyap3pX2XHiw6
 RnEw==
X-Gm-Message-State: AOAM5321xvtsUJRFiS9HO9G3cChHkWuZA29yLQ1gmFgu6C+1esNz1EqM
 v7JFn0G3WYPQw2bAoXhhEO2WARj1C4Mq40kNx1WNFyAZl55TmAQPGjHkCniud0CowCVllQJSv7j
 kbok2Tqfdb0xE0j5rBckT7Vjl9q8p3pWNmL1y4XNT8w==
X-Received: by 2002:aed:38c3:: with SMTP id k61mr83723qte.11.1596576555026;
 Tue, 04 Aug 2020 14:29:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzrZQvRXXmOImw3ZNin/9p58rw3YAMvyB6SPFfMvQL7L/uzQmZg02eL1z+mLAWH0ljJoCYKTA==
X-Received: by 2002:aed:38c3:: with SMTP id k61mr83705qte.11.1596576554750;
 Tue, 04 Aug 2020 14:29:14 -0700 (PDT)
Received: from redhat.com (bzq-79-177-102-128.red.bezeqint.net.
 [79.177.102.128])
 by smtp.gmail.com with ESMTPSA id c42sm256143qte.5.2020.08.04.14.29.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Aug 2020 14:29:14 -0700 (PDT)
Date: Tue, 4 Aug 2020 17:29:09 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eli Cohen <eli@mellanox.com>
Subject: Re: [PATCH V4 linux-next 00/12] VDPA support for Mellanox ConnectX
 devices
Message-ID: <20200804172726-mutt-send-email-mst@kernel.org>
References: <20200804162048.22587-1-eli@mellanox.com>
MIME-Version: 1.0
In-Reply-To: <20200804162048.22587-1-eli@mellanox.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
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

On Tue, Aug 04, 2020 at 07:20:36PM +0300, Eli Cohen wrote:
> Hi Michael,
> please note that this series depends on mlx5 core device driver patches
> in mlx5-next branch in
> git://git.kernel.org/pub/scm/linux/kernel/git/mellanox/linux.git.

Thanks! OK so what's the plan for merging this?
Do patches at least build well enough that I can push them
upstream? Or do they have to go on top of the mellanox tree?


> git pull git://git.kernel.org/pub/scm/linux/kernel/git/mellanox/linux.git mlx5-next 
> 
> They also depend Jason Wang's patches: https://lkml.org/lkml/2020/7/1/301

The ones you included, right?

> Jason, I had to resolve some conflicts so I would appreciate of you can verify
> that it is ok.
> 
> The following series of patches provide VDPA support for Mellanox
> devices. The supported devices are ConnectX6 DX and newer.
> 
> Currently, only a network driver is implemented; future patches will
> introduce a block device driver. iperf performance on a single queue is
> around 12 Gbps.  Future patches will introduce multi queue support.
> 
> The files are organized in such a way that code that can be used by
> different VDPA implementations will be placed in a common are resides in
> drivers/vdpa/mlx5/core.
> 
> Only virtual functions are currently supported. Also, certain firmware
> capabilities must be set to enable the driver. Physical functions (PFs)
> are skipped by the driver.
> 
> To make use of the VDPA net driver, one must load mlx5_vdpa. In such
> case, VFs will be operated by the VDPA driver. Although one can see a
> regular instance of a network driver on the VF, the VDPA driver takes
> precedence over the NIC driver, steering-wize.
> 
> Currently, the device/interface infrastructure in mlx5_core is used to
> probe drivers. Future patches will introduce virtbus as a means to
> register devices and drivers and VDPA will be adapted to it.
> 
> The mlx5 mode of operation required to support VDPA is switchdev mode.
> Once can use Linux or OVS bridge to take care of layer 2 switching.
> 
> In order to provide virtio networking to a guest, an updated version of
> qemu is required. This version has been tested by the following quemu
> version:
> 
> url: https://github.com/jasowang/qemu.git
> branch: vdpa
> Commit ID: 6f4e59b807db
> 
> 
> V2->V3
> Fix makefile to use include path relative to the root of the kernel
> 
> V3-V4
> Rebase Jason's patches on linux-next branch
> Fix krobot error on mips arch
> Make use of the free callback to destroy resoruces on unload
> Use VIRTIO_F_ACCESS_PLATFORM instead of legacy VIRTIO_F_IOMMU_PLATFORM
> Add empty implementations for get_vq_notification() and get_vq_irq()
> 
> 
> Eli Cohen (6):
>   net/vdpa: Use struct for set/get vq state
>   vdpa: Modify get_vq_state() to return error code
>   vdpa/mlx5: Add hardware descriptive header file
>   vdpa/mlx5: Add support library for mlx5 VDPA implementation
>   vdpa/mlx5: Add shared memory registration code
>   vdpa/mlx5: Add VDPA driver for supported mlx5 devices
> 
> Jason Wang (5):
>   vhost-vdpa: refine ioctl pre-processing
>   vhost: generialize backend features setting/getting
>   vhost-vdpa: support get/set backend features
>   vhost-vdpa: support IOTLB batching hints
>   vdpasim: support batch updating
> 
> Max Gurtovoy (1):
>   vdpa: remove hard coded virtq num
> 
>  drivers/vdpa/Kconfig                   |   19 +
>  drivers/vdpa/Makefile                  |    1 +
>  drivers/vdpa/ifcvf/ifcvf_base.c        |    4 +-
>  drivers/vdpa/ifcvf/ifcvf_base.h        |    4 +-
>  drivers/vdpa/ifcvf/ifcvf_main.c        |   13 +-
>  drivers/vdpa/mlx5/Makefile             |    4 +
>  drivers/vdpa/mlx5/core/mlx5_vdpa.h     |   91 ++
>  drivers/vdpa/mlx5/core/mlx5_vdpa_ifc.h |  168 ++
>  drivers/vdpa/mlx5/core/mr.c            |  484 ++++++
>  drivers/vdpa/mlx5/core/resources.c     |  284 ++++
>  drivers/vdpa/mlx5/net/main.c           |   76 +
>  drivers/vdpa/mlx5/net/mlx5_vnet.c      | 1965 ++++++++++++++++++++++++
>  drivers/vdpa/mlx5/net/mlx5_vnet.h      |   24 +
>  drivers/vdpa/vdpa.c                    |    3 +
>  drivers/vdpa/vdpa_sim/vdpa_sim.c       |   53 +-
>  drivers/vhost/net.c                    |   18 +-
>  drivers/vhost/vdpa.c                   |   76 +-
>  drivers/vhost/vhost.c                  |   15 +
>  drivers/vhost/vhost.h                  |    2 +
>  include/linux/vdpa.h                   |   24 +-
>  include/uapi/linux/vhost.h             |    2 +
>  include/uapi/linux/vhost_types.h       |   11 +
>  22 files changed, 3284 insertions(+), 57 deletions(-)
>  create mode 100644 drivers/vdpa/mlx5/Makefile
>  create mode 100644 drivers/vdpa/mlx5/core/mlx5_vdpa.h
>  create mode 100644 drivers/vdpa/mlx5/core/mlx5_vdpa_ifc.h
>  create mode 100644 drivers/vdpa/mlx5/core/mr.c
>  create mode 100644 drivers/vdpa/mlx5/core/resources.c
>  create mode 100644 drivers/vdpa/mlx5/net/main.c
>  create mode 100644 drivers/vdpa/mlx5/net/mlx5_vnet.c
>  create mode 100644 drivers/vdpa/mlx5/net/mlx5_vnet.h
> 
> -- 
> 2.26.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
