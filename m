Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BD7AC4332F
	for <virtualization@archiver.kernel.org>; Tue, 13 Dec 2022 15:19:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 32E5260AC9;
	Tue, 13 Dec 2022 15:19:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 32E5260AC9
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XhaOxNIK
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id s66LkG1ip9Lc; Tue, 13 Dec 2022 15:19:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 9326D60773;
	Tue, 13 Dec 2022 15:19:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9326D60773
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5E863C0032;
	Tue, 13 Dec 2022 15:19:22 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2FE3DC002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Dec 2022 15:19:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id EE13B80BC4
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Dec 2022 15:19:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org EE13B80BC4
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=XhaOxNIK
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Y4PT3xZZGLmH
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Dec 2022 15:19:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 23BE980BAD
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 23BE980BAD
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Dec 2022 15:19:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1670944759;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=P0CSk5cc8z+MIxtfJaqK2iC+ecrtBBfDO+a5TkKb2FU=;
 b=XhaOxNIKEIq4IzMHiJ1YAbk/9SkoS76rtnObI36+CDyrBcbMBx/2i4h/SGGCzk38yEqkz4
 lonXM93bE+hEWkDJers7q8GJ/9qAYgKQdFWTWKnbbgjzhGFiElgS3asd6FvgL4zdmE0Ned
 OhMrzmuQiRyzUUwhoPWE6DZDhCrHrGU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-323-eJZRiTq9O8uPPbk3mlAgww-1; Tue, 13 Dec 2022 10:19:17 -0500
X-MC-Unique: eJZRiTq9O8uPPbk3mlAgww-1
Received: by mail-wm1-f71.google.com with SMTP id
 h9-20020a1c2109000000b003cfd37aec58so4975694wmh.1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Dec 2022 07:19:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P0CSk5cc8z+MIxtfJaqK2iC+ecrtBBfDO+a5TkKb2FU=;
 b=CbWphMfhDrJja0MiTyODbcq2YAImXNEIeP1By7L9c43HSL9VdlhSIsflV084zsmSnM
 JllSBwtTjg3K/rcQkprTsy8ccHVmIA+pd/G4M10VNTzgiWJjW2F9JyE3xM6knp204ZVG
 By0rKesoqGjjeON+puDh5rgimZCbt7NmvShVp6besl7YR7LLdWM+LXvuFGcQyupzKXrr
 lKqKlNo2QUz29wthJlJRxL7KNoVwu5AShvuzn9Ock6/3sh+s4Du09Kx2CUS/6UKlfKgu
 HsBcjYDXuW2WigCaPsB5XI2pzTuCc7XIhBxqq0NdaBXO5wf460tQWI1XB0Z5T2nx8GWm
 +nPQ==
X-Gm-Message-State: ANoB5pnwuXXJ99e8qEXV63U1gYnuSszRed65ZzzXyBeQ0rcazsuU68Se
 2yVSHoSRETuslnILjYlshn0P/QAxQ66vNvKWzlHwuYcasFrIqh85DF0/Rym3pa8Jfqidf+DlTdG
 I6hpazEjGiVKEGrXhzc4HJZnP9JK+V0NTAOd3Xd8IBw==
X-Received: by 2002:a05:6000:883:b0:241:94bc:26d3 with SMTP id
 ca3-20020a056000088300b0024194bc26d3mr12880758wrb.49.1670944756427; 
 Tue, 13 Dec 2022 07:19:16 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6seChERFleznECQpOM83h6tXK8y66oPcOVYUArJEX37U9aakvW3lDwTiQIG+CeJ4MrHBQTcw==
X-Received: by 2002:a05:6000:883:b0:241:94bc:26d3 with SMTP id
 ca3-20020a056000088300b0024194bc26d3mr12880749wrb.49.1670944756196; 
 Tue, 13 Dec 2022 07:19:16 -0800 (PST)
Received: from redhat.com ([2.52.138.183]) by smtp.gmail.com with ESMTPSA id
 t15-20020adff60f000000b00241c4bd6c09sm68907wrp.33.2022.12.13.07.19.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Dec 2022 07:19:15 -0800 (PST)
Date: Tue, 13 Dec 2022 10:19:12 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eli Cohen <elic@nvidia.com>
Subject: Re: [PATH v2 0/8] vdpa/mlx5: Add debugfs subtree and fixes
Message-ID: <20221213101853-mutt-send-email-mst@kernel.org>
References: <20221114131759.57883-1-elic@nvidia.com>
 <DM8PR12MB540016371DAF2915B3277949AB0F9@DM8PR12MB5400.namprd12.prod.outlook.com>
 <DM8PR12MB540004BAE87EF27CFC6B1C69ABE39@DM8PR12MB5400.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <DM8PR12MB540004BAE87EF27CFC6B1C69ABE39@DM8PR12MB5400.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: "lulu@redhat.com" <lulu@redhat.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "eperezma@redhat.com" <eperezma@redhat.com>
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

Yes it's all going into the next pull, thanks!

On Tue, Dec 13, 2022 at 07:33:08AM +0000, Eli Cohen wrote:
> Michael?
> 
> > -----Original Message-----
> > From: Eli Cohen
> > Sent: Thursday, 24 November 2022 8:34
> > To: mst@redhat.com; jasowang@redhat.com; linux-kernel@vger.kernel.org;
> > virtualization@lists.linux-foundation.org
> > Cc: si-wei.liu@oracle.com; eperezma@redhat.com; lulu@redhat.com
> > Subject: RE: [PATH v2 0/8] vdpa/mlx5: Add debugfs subtree and fixes
> > 
> > Hi Michael,
> > 
> > Are you going to pull this series? It has been reviewed.
> > 
> > 
> > > -----Original Message-----
> > > From: Eli Cohen <elic@nvidia.com>
> > > Sent: Monday, 14 November 2022 15:18
> > > To: mst@redhat.com; jasowang@redhat.com; linux-
> > kernel@vger.kernel.org;
> > > virtualization@lists.linux-foundation.org
> > > Cc: si-wei.liu@oracle.com; eperezma@redhat.com; lulu@redhat.com; Eli
> > > Cohen <elic@nvidia.com>
> > > Subject: [PATH v2 0/8] vdpa/mlx5: Add debugfs subtree and fixes
> > >
> > > This series is a resend of previously sent patch list. It adds a few
> > > fixes so I treat as a v0 of a new series.
> > >
> > > It adds a kernel config param CONFIG_MLX5_VDPA_STEERING_DEBUG
> > that
> > > when
> > > eabled allows to read rx unicast and multicast counters per tagged or
> > untagged
> > > traffic.
> > >
> > > Examples:
> > > $ cat /sys/kernel/debug/mlx5/mlx5_core.sf.1/vdpa-
> > > 0/rx/untagged/mcast/packets
> > > $ cat /sys/kernel/debug/mlx5/mlx5_core.sf.1/vdpa-
> > 0/rx/untagged/ucast/bytes
> > >
> > > v1->v2:
> > > 1. Reorder patches so fixes are first
> > > 2. Break "Fix rule forwarding VLAN to TIR" into two patches
> > > 3. Squash fix for bug in first patch from "Add RX counters to debugfs"
> > > 4. Move clearing of nb_registered before calling mlx5_notifier_unregister()
> > in
> > > mlx5_vdpa_dev_del()
> > >
> > >
> > > Eli Cohen (8):
> > >   vdpa/mlx5: Fix rule forwarding VLAN to TIR
> > >   vdpa/mlx5: Return error on vlan ctrl commands if not supported
> > >   vdpa/mlx5: Fix wrong mac address deletion
> > >   vdpa/mlx5: Avoid using reslock in event_handler
> > >   vdpa/mlx5: Avoid overwriting CVQ iotlb
> > >   vdpa/mlx5: Move some definitions to a new header file
> > >   vdpa/mlx5: Add debugfs subtree
> > >   vdpa/mlx5: Add RX counters to debugfs
> > >
> > >  drivers/vdpa/Kconfig               |  12 ++
> > >  drivers/vdpa/mlx5/Makefile         |   2 +-
> > >  drivers/vdpa/mlx5/core/mlx5_vdpa.h |   5 +-
> > >  drivers/vdpa/mlx5/core/mr.c        |  44 ++---
> > >  drivers/vdpa/mlx5/net/debug.c      | 152 ++++++++++++++++++
> > >  drivers/vdpa/mlx5/net/mlx5_vnet.c  | 250 ++++++++++++++---------------
> > >  drivers/vdpa/mlx5/net/mlx5_vnet.h  |  94 +++++++++++
> > >  7 files changed, 412 insertions(+), 147 deletions(-)
> > >  create mode 100644 drivers/vdpa/mlx5/net/debug.c
> > >  create mode 100644 drivers/vdpa/mlx5/net/mlx5_vnet.h
> > >
> > > --
> > > 2.38.1
> 

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
