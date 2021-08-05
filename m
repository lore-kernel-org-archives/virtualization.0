Return-Path: <SRS0=C5bb=M4=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,URIBL_RED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA7AAC4338F
	for <virtualization@archiver.kernel.org>; Thu,  5 Aug 2021 09:57:54 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C7D160F58
	for <virtualization@archiver.kernel.org>; Thu,  5 Aug 2021 09:57:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5C7D160F58
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 21B96834E8;
	Thu,  5 Aug 2021 09:57:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ts9lyJbJge23; Thu,  5 Aug 2021 09:57:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id A9A228374F;
	Thu,  5 Aug 2021 09:57:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7A072C001A;
	Thu,  5 Aug 2021 09:57:52 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7409BC000E
 for <virtualization@lists.linux-foundation.org>;
 Thu,  5 Aug 2021 09:57:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5C35F40277
 for <virtualization@lists.linux-foundation.org>;
 Thu,  5 Aug 2021 09:57:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oeh2bSON1BVy
 for <virtualization@lists.linux-foundation.org>;
 Thu,  5 Aug 2021 09:57:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id DFAA0400AF
 for <virtualization@lists.linux-foundation.org>;
 Thu,  5 Aug 2021 09:57:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1628157468;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hHO4/ABpu9qjxJVlO6Rkz3rP1PZcdkOaFEAvVhW3trE=;
 b=TSwFcd572vgtfE7ABxDvPE+aK7KsGSiLf+2YM2vwketPyPIWoeqKJq0ZVSr1jBTd7Q5Qaj
 AzjtXTFTOkfU0kFS4ufTdop6IODOTfT7VWXKrFw2C2eZ5msIcclZtRHcL3iyQK0PrMdd1t
 5IHAf6tljJLeTDLMsJEyFODFyYpHAjo=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-518-7O_J1mHlP1azAvfpVyOzvw-1; Thu, 05 Aug 2021 05:57:47 -0400
X-MC-Unique: 7O_J1mHlP1azAvfpVyOzvw-1
Received: by mail-ed1-f69.google.com with SMTP id
 x1-20020a05640218c1b02903bc7f97f858so2894064edy.2
 for <virtualization@lists.linux-foundation.org>;
 Thu, 05 Aug 2021 02:57:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=hHO4/ABpu9qjxJVlO6Rkz3rP1PZcdkOaFEAvVhW3trE=;
 b=T+oootq1gxRYoi2t9Rc1BrOfya41dhiIVsGcly5geMoo/j+3RMQl+OdtKOYxmNEZgu
 xpFPNb8WmlCLPb51Dx6KBXFyqiEGPcVlKgfaCDYthOTG9+w+k5VkjktppG1RM5qxFyCt
 5XSeAkaB2Fiv/jl3DNVNMkvRmJFigSVvG7P9krCehDvYskL86/iV1YnBxTSX0CUguMDo
 ov1k0AKZqx1CTvPxXIgs8sKa1QrqBRbk0YN2c+BRJDCH9fCRz81yyUjV2s8oTdy3vWJB
 ue5sLqLiJG2gvOnlM7el2sQ9XczkaJ9GyWR1/x23hIQsDghluBfyLo6dFpUSDP4ojauA
 cpxQ==
X-Gm-Message-State: AOAM531C1oCAqj5sKZU2+O8sfomfqeiGtmtv+Ayh1TD67pXKWEiMbOeu
 Y85kH4Rh8iOUWLDM5v9GxqBLemry+IrJSmEv3FzTGpg1/9ORfU8JZVFQcMYIixnto8A2fArvWmM
 FUQzBOy5ewgGlawkB9nqstmSGbi9SSUtnD82GrRH1WQ==
X-Received: by 2002:aa7:c597:: with SMTP id g23mr5362692edq.340.1628157466342; 
 Thu, 05 Aug 2021 02:57:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyzChwfCn6znDf2sPCAo2EwMmd6nvlNYKafZUm9J0yEqEVyKqC85CFn1gStfjDBL7q1/E05YQ==
X-Received: by 2002:aa7:c597:: with SMTP id g23mr5362680edq.340.1628157466207; 
 Thu, 05 Aug 2021 02:57:46 -0700 (PDT)
Received: from redhat.com ([2.55.141.248])
 by smtp.gmail.com with ESMTPSA id n10sm1544569ejk.86.2021.08.05.02.57.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Aug 2021 02:57:45 -0700 (PDT)
Date: Thu, 5 Aug 2021 05:57:42 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Subject: Re: [PATCH linux-next v3 0/6] vdpa: enable user to set mac, mtu
Message-ID: <20210805055623-mutt-send-email-mst@kernel.org>
References: <20210616191155.102303-1-parav@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20210616191155.102303-1-parav@nvidia.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: elic@nvidia.com, virtualization@lists.linux-foundation.org
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

On Wed, Jun 16, 2021 at 10:11:49PM +0300, Parav Pandit wrote:
> Currently user cannot set the mac address and mtu of the vdpa device.
> This patchset enables users to set the mac address and mtu of the vdpa
> device once the device is created.
> If a vendor driver supports such configuration user can set it otherwise
> user gets unsupported error.

This makes sense to me overall. People are used to
use netlink to set these parameters, and virtio does
not necessarily have a way to set all device
parameters - they can be RO in the config space.


> vdpa mac address and mtu are device configuration layout fields.
> To keep interface generic enough for multiple types of vdpa devices, mac
> address and mtu setting is implemented as configuration layout config
> knobs.
> This enables to use similar config layout for other virtio devices.
> 
> An example of query & set of config layout fields for vdpa_sim_net
> driver:
> 
> Configuration layout fields are set after device is created.
> This enables user to change such fields at later point without destroying and
> recreating the device for new config.
> 
> $ vdpa mgmtdev show
> vdpasim_net:
>   supported_classes net
> 
> Add the device:
> $ vdpa dev add name bar mgmtdev vdpasim_net
> 
> Configure mac address and mtu:
> $ vdpa dev config set bar mac 00:11:22:33:44:55 mtu 9000
> 
> In above command only mac address or only mtu can also be set.
> 
> View the config after setting:
> $ vdpa dev config show
> bar: mac 00:11:22:33:44:55 link up link_announce false mtu 9000 speed 0 duplex 0
> 
> Patch summary:
> Patch-1 introduced and use helpers for get/set config area
> Patch-2 implement query device config layout
> Patch-3 enanble user to set mac and mtu in config space
> Patch-4 vdpa_sim_net implements get and set of config layout
> Patch-5 mlx5 vdpa driver supports user provided mac config
> Patch-6 mlx5 vdpa driver uses user provided mac during rx flow steering
> 
> changelog:
> v2->v3:
>  - dropped patches which are merged
>  - simplified code to handle non transitional devices
> 
> v1->v2:
>  - new patches to fix kdoc comment to add new kdoc section
>  - new patch to have synchronized access to features and config space
>  - read whole net config layout instead of individual fields
>  - added error extack for unmanaged vdpa device
>  - fixed several endianness issues
>  - introduced vdpa device ops for get config which is synchronized
>    with other get/set features ops and config ops
>  - fixed mtu range checking for max
>  - using NLA_POLICY_ETH_ADDR
>  - set config moved to device ops instead of mgmtdev ops
>  - merged build and set to single routine
>  - ensuring that user has NET_ADMIN capability for configuring network
>    attributes
>  - using updated interface and callbacks for get/set config
>  - following new api for config get/set for mgmt tool in mlx5 vdpa
>    driver
>  - fixes for accessing right SF dma device and bar address
>  - fix for mtu calculation
>  - fix for bit access in features
>  - fix for index restore with suspend/resume operation
> 
> 
> Eli Cohen (2):
>   vdpa/mlx5: Support configuration of MAC
>   vdpa/mlx5: Forward only packets with allowed MAC address
> 
> Parav Pandit (4):
>   vdpa: Introduce and use vdpa device get, set config helpers
>   vdpa: Introduce query of device config layout
>   vdpa: Enable user to set mac and mtu of vdpa device
>   vdpa_sim_net: Enable user to set mac address and mtu
> 
>  drivers/vdpa/mlx5/net/mlx5_vnet.c    | 101 ++++++--
>  drivers/vdpa/vdpa.c                  | 337 +++++++++++++++++++++++++++
>  drivers/vdpa/vdpa_sim/vdpa_sim.c     |  13 ++
>  drivers/vdpa/vdpa_sim/vdpa_sim.h     |   2 +
>  drivers/vdpa/vdpa_sim/vdpa_sim_net.c |  34 +--
>  drivers/vhost/vdpa.c                 |   3 +-
>  include/linux/vdpa.h                 |  38 +--
>  include/uapi/linux/vdpa.h            |  12 +
>  8 files changed, 490 insertions(+), 50 deletions(-)
> 
> -- 
> 2.26.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
