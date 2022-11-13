Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 228CAC433FE
	for <virtualization@archiver.kernel.org>; Sun, 13 Nov 2022 13:58:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 95F5A40496;
	Sun, 13 Nov 2022 13:58:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 95F5A40496
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=aj5l4aJE
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OgZnU3tCnnaD; Sun, 13 Nov 2022 13:58:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 21B0C40165;
	Sun, 13 Nov 2022 13:58:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 21B0C40165
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DC9FEC0033;
	Sun, 13 Nov 2022 13:58:02 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DC8C6C002D
 for <virtualization@lists.linux-foundation.org>;
 Sun, 13 Nov 2022 13:58:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A4C9560881
 for <virtualization@lists.linux-foundation.org>;
 Sun, 13 Nov 2022 13:58:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A4C9560881
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=aj5l4aJE
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WqOm9mkxWQRM
 for <virtualization@lists.linux-foundation.org>;
 Sun, 13 Nov 2022 13:58:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D952760767
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D952760767
 for <virtualization@lists.linux-foundation.org>;
 Sun, 13 Nov 2022 13:58:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1668347879;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Sxn4y8zEogALzM6SceTBzYKfTeerKNoCiWqt/Q5KsoU=;
 b=aj5l4aJEfZ/goYi5F1/cZJcoj9dWuX/VG/OQJM93vFzluV6QWnbwv0SGiC0/0A7gB38dFu
 KuUmGqxQVK7poPSxSd+ZGnvdwNjOzTStVJ5n3bSWYVL+MiL07udFAjyUGbKi54QHCxQFRN
 ZULFctYPvEEKpsUR3fvBgJ+1FbL9+OI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-571-c3aUSPd-NfmmEBRstPmpSQ-1; Sun, 13 Nov 2022 08:57:52 -0500
X-MC-Unique: c3aUSPd-NfmmEBRstPmpSQ-1
Received: by mail-wm1-f72.google.com with SMTP id
 186-20020a1c02c3000000b003cfab28cbe0so7477789wmc.9
 for <virtualization@lists.linux-foundation.org>;
 Sun, 13 Nov 2022 05:57:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Sxn4y8zEogALzM6SceTBzYKfTeerKNoCiWqt/Q5KsoU=;
 b=4UnOCZdbXBruIhaXNhQtfhw+LtjlfAvcAoBXecr9jHQcuuMBL/h25oGqZ8Jv+/BgA7
 LMdZTor3QYVS3SuqEfnDtxLXPktuAH2wbe54HxIwtF/pjBL/pJVugdZYg6TqjArWn3fd
 BvT2pG9fiSm0NNcaKoZ4qx5FID8km+aWeewsE5pH7uBJM7SLVEgozh8FUzk6mO4TbcXF
 j/ixZTJtjwXBUlr/6ckGmmiu6nqfkG3aXLHUdCFpcna7Dj7tLq46N38Vs7rf3dvn+Ktp
 RaeK1ug0fnjC/w06uqpC1i+dEnmrmNwf3hPTR4ilmQhe5mfLn/4tbGm9faUzPrxvR/r8
 RCEw==
X-Gm-Message-State: ANoB5pmNDIGipgSjqCftz0u1Vic2cnhWQkggmnwTDeauabI1zFHuvyBF
 m8a1rc4Vq7ocFTu8UkID9+7ZRhLAYO+Jw3vjMdk/xH9amFe0K3xti6bmW85DIW9ErOhZACdluxK
 lhXxVEfMnEP0As484Bwf3BZRrCD2Xc9GQXkUMiuwS0Q==
X-Received: by 2002:a05:600c:1e83:b0:3cf:6ab3:4a60 with SMTP id
 be3-20020a05600c1e8300b003cf6ab34a60mr5850607wmb.32.1668347871752; 
 Sun, 13 Nov 2022 05:57:51 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6sj46Yoe6+WzbEdbDAptfcusvqC0lkHaz7X1vmJQK6RoGsd1oLq6ETs2H2lhekrgkToe+DKg==
X-Received: by 2002:a05:600c:1e83:b0:3cf:6ab3:4a60 with SMTP id
 be3-20020a05600c1e8300b003cf6ab34a60mr5850601wmb.32.1668347871500; 
 Sun, 13 Nov 2022 05:57:51 -0800 (PST)
Received: from redhat.com ([2.52.4.127]) by smtp.gmail.com with ESMTPSA id
 q10-20020adff94a000000b0022cc6b8df5esm6970526wrr.7.2022.11.13.05.57.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Nov 2022 05:57:51 -0800 (PST)
Date: Sun, 13 Nov 2022 08:57:47 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eli Cohen <elic@nvidia.com>
Subject: Re: [PATCH 0/7] vdpa/mlx5: Add debugfs subtree and fixes
Message-ID: <20221113085723-mutt-send-email-mst@kernel.org>
References: <20221113134442.152695-1-elic@nvidia.com>
 <20221113085044-mutt-send-email-mst@kernel.org>
 <DM8PR12MB5400DB70B0AA6831E6ABF7AAAB029@DM8PR12MB5400.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <DM8PR12MB5400DB70B0AA6831E6ABF7AAAB029@DM8PR12MB5400.namprd12.prod.outlook.com>
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

On Sun, Nov 13, 2022 at 01:56:00PM +0000, Eli Cohen wrote:
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Sunday, 13 November 2022 15:52
> > To: Eli Cohen <elic@nvidia.com>
> > Cc: jasowang@redhat.com; linux-kernel@vger.kernel.org;
> > virtualization@lists.linux-foundation.org; si-wei.liu@oracle.com;
> > eperezma@redhat.com; lulu@redhat.com
> > Subject: Re: [PATCH 0/7] vdpa/mlx5: Add debugfs subtree and fixes
> > 
> > On Sun, Nov 13, 2022 at 03:44:35PM +0200, Eli Cohen wrote:
> > > This series is a resend of previously sent patch list. It adds a few
> > > fixes so I treat as a v0 of a new series.
> > >
> > > It adds a kernel config param CONFIG_MLX5_VDPA_STEERING_DEBUG that
> > when
> > > eabled allows to read rx unicast and multicast counters per tagged or
> > untagged traffic.
> > >
> > > Examples:
> > > $ cat /sys/kernel/debug/mlx5/mlx5_core.sf.1/vdpa-
> > 0/rx/untagged/mcast/packets
> > > $ cat /sys/kernel/debug/mlx5/mlx5_core.sf.1/vdpa-
> > 0/rx/untagged/ucast/bytes
> > 
> > 
> > Thanks!
> > Is this patchset intended for 6.2 then?
> > 
> 
> The debugfs part can go to 6.2 but maybe the fixes should go to 6.1.


Tat's fine - do they apply cleanly if I just drop 4/7?

> > >
> > > Eli Cohen (7):
> > >   vdpa/mlx5: Fix rule forwarding VLAN to TIR
> > >   vdpa/mlx5: Fix wrong mac address deletion
> > >   vdpa/mlx5: Move some definitions to a new header file
> > >   vdpa/mlx5: Add debugfs subtree
> > >   vdpa/mlx5: Add RX counters to debugfs
> > >   vdpa/mlx5: Avoid using reslock in event_handler
> > >   vdpa/mlx5: Avoid overwriting CVQ iotlb
> > >
> > >  drivers/vdpa/Kconfig               |  12 ++
> > >  drivers/vdpa/mlx5/Makefile         |   2 +-
> > >  drivers/vdpa/mlx5/core/mlx5_vdpa.h |   5 +-
> > >  drivers/vdpa/mlx5/core/mr.c        |  44 ++---
> > >  drivers/vdpa/mlx5/net/debug.c      | 152 ++++++++++++++++++
> > >  drivers/vdpa/mlx5/net/mlx5_vnet.c  | 248 ++++++++++++++---------------
> > >  drivers/vdpa/mlx5/net/mlx5_vnet.h  |  94 +++++++++++
> > >  7 files changed, 411 insertions(+), 146 deletions(-)
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
