Return-Path: <SRS0=TJKJ=PU=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B129C433EF
	for <virtualization@archiver.kernel.org>; Mon,  1 Nov 2021 11:12:31 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 285C360C41
	for <virtualization@archiver.kernel.org>; Mon,  1 Nov 2021 11:12:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 285C360C41
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C218B40224;
	Mon,  1 Nov 2021 11:12:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HEh90f3rkDAb; Mon,  1 Nov 2021 11:12:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 6065B4020C;
	Mon,  1 Nov 2021 11:12:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4257DC0012;
	Mon,  1 Nov 2021 11:12:29 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EBF9AC000E
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Nov 2021 11:12:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id DA8C040224
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Nov 2021 11:12:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WMq0LBKN8kAt
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Nov 2021 11:12:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E402140214
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Nov 2021 11:12:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1635765145;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6ZFhVEO+We6qm43UDAioY1QSBCdYaZIxbYcL8uvY64Y=;
 b=C7vUXWFwNriag4Be6a1qjYWCGfy5W0f93h6XBE6stNsK0mV4Tbum4iuYaZAmxoUeokk9jU
 vmKWeTKONJU2EaYr/GVStmYKxMZQeEZ+26DM70/PvD5+AEss0+UQ4LmeSKGNOF6QBDkjh5
 BGbWkY9rUw4GTG428d9bRhm5hcHbe7k=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-84-fXS2kc1BPhK5VR86MQnT8w-1; Mon, 01 Nov 2021 07:12:24 -0400
X-MC-Unique: fXS2kc1BPhK5VR86MQnT8w-1
Received: by mail-wm1-f70.google.com with SMTP id
 l187-20020a1c25c4000000b0030da46b76daso5727255wml.9
 for <virtualization@lists.linux-foundation.org>;
 Mon, 01 Nov 2021 04:12:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=6ZFhVEO+We6qm43UDAioY1QSBCdYaZIxbYcL8uvY64Y=;
 b=Ngled0JX2Ub7VKwhuoOrc+rYXOioaERvFAcB5QoBbZuB6otBsZ60grMQXYqxmfJy8k
 U0kQcarkrgUOr8HZbOPMhN3V2tNlpHzZsflmVN8M/a0H0BxPyXnPOEDn6EgHa2cb87rz
 WQWNVRfFx1W+cDmBNFAOcpKD1sYzeCU9DX14OGfZdWtXf5zROU3/2dJBGFBUQ3Ik4HyH
 O89LYqEUvXXSw0UbBXSE8wBfJpSCJB60vveDtYHfGeW0dCdMv05ntsqUcM7SyhYlOZxs
 3iqHccYMoLdkoAV5LXYyAjWq0qjg4lmaT+rzy20qy3rZ6LhO+0qXBoaQomw4RwMQsdPs
 68Fw==
X-Gm-Message-State: AOAM531VLg4HPyXdvS0ldkx1JjLsqhoyZAfvfmj0eKBMCwAXRXU59xwM
 bgT0AZIs7Umsq43XtwHRPURJApXpsZyt21ZbbBYEuwbay44bqfSN5/HxRuR2y8UTYs/uUmF1M33
 X3MzpaX634gegmPfma6AOlTOk0DMfyRF3FBw550PyjA==
X-Received: by 2002:a1c:8090:: with SMTP id b138mr16426505wmd.25.1635765143636; 
 Mon, 01 Nov 2021 04:12:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwisKVtWLf4fD5NwZ4Am8fKpj39xISIcWYMZ4VZQyVX9L141g3kzyjbm8B0Xz0WdH5R58pfqw==
X-Received: by 2002:a1c:8090:: with SMTP id b138mr16426488wmd.25.1635765143448; 
 Mon, 01 Nov 2021 04:12:23 -0700 (PDT)
Received: from redhat.com ([2a03:c5c0:107f:7087:907d:ff12:1534:78b7])
 by smtp.gmail.com with ESMTPSA id v3sm14122663wrg.23.2021.11.01.04.12.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Nov 2021 04:12:22 -0700 (PDT)
Date: Mon, 1 Nov 2021 07:12:17 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Wu Zongyong <wuzongyong@linux.alibaba.com>
Subject: Re: [PATCH v7 0/9] vDPA driver for Alibaba ENI
Message-ID: <20211101071140-mutt-send-email-mst@kernel.org>
References: <cover.1634870456.git.wuzongyong@linux.alibaba.com>
 <cover.1635493219.git.wuzongyong@linux.alibaba.com>
 <CACGkMEv8+1YMhXfS31CoyFuwJ-toCLXd12ny7b=Ge+3fXWNYUw@mail.gmail.com>
 <20211101062250.GA29814@L-PF27918B-1352.localdomain>
 <CACGkMEvZkdEgAFpSo1Oen5JWthSowZ7NHqnp_X5AhNt+jxuiZg@mail.gmail.com>
 <20211101081159.GA4341@L-PF27918B-1352.localdomain>
MIME-Version: 1.0
In-Reply-To: <20211101081159.GA4341@L-PF27918B-1352.localdomain>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: wei.yang1@linux.alibaba.com, linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>
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

On Mon, Nov 01, 2021 at 04:11:59PM +0800, Wu Zongyong wrote:
> On Mon, Nov 01, 2021 at 03:02:52PM +0800, Jason Wang wrote:
> > On Mon, Nov 1, 2021 at 2:23 PM Wu Zongyong <wuzongyong@linux.alibaba.com> wrote:
> > >
> > > On Mon, Nov 01, 2021 at 11:31:15AM +0800, Jason Wang wrote:
> > > > On Fri, Oct 29, 2021 at 5:15 PM Wu Zongyong
> > > > <wuzongyong@linux.alibaba.com> wrote:
> > > > >
> > > > > This series implements the vDPA driver for Alibaba ENI (Elastic Network
> > > > > Interface) which is built based on virtio-pci 0.9.5 specification.
> > > >
> > > > It looks to me Michael has applied the patches, if this is the case,
> > > > we probably need to send patches on top.
> > >
> > > What do you mean by saying "send patches on top"?
> > > Sorry, I'm a newbie to contribute for kernel, could you please explain
> > > it in detail?
> > 
> > I meant you probably need to send incremental patch on top of:
> > 
> > git://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git linux-next.
> 
> Get it.
> 
> Thanks

No need, I rebased.

> > 
> > Thanks
> > 
> > 
> > >
> > > Thanks
> > > > Thanks
> > > >
> > > > >
> > > > > Changes since V6:
> > > > > - set default min vq size to 1 intead of 0
> > > > > - enable eni vdpa driver only on X86 hosts
> > > > > - fix some typos
> > > > >
> > > > > Changes since V5:
> > > > > - remove unused codes
> > > > >
> > > > > Changes since V4:
> > > > > - check return values of get_vq_num_{max,min} when probing devices
> > > > > - disable the driver on BE host via Kconfig
> > > > > - add missing commit message
> > > > >
> > > > > Changes since V3:
> > > > > - validate VIRTIO_NET_F_MRG_RXBUF when negotiate features
> > > > > - present F_ORDER_PLATFORM in get_features
> > > > > - remove endian check since ENI always use litter endian
> > > > >
> > > > > Changes since V2:
> > > > > - add new attribute VDPA_ATTR_DEV_MIN_VQ_SIZE instead
> > > > >   VDPA_ATTR_DEV_F_VERSION_1 to guide users to choose correct virtqueue
> > > > >   size as suggested by Jason Wang
> > > > > - present ACCESS_PLATFORM in get_features callback as suggested by Jason
> > > > >   Wang
> > > > > - disable this driver on Big Endian host as suggested by Jason Wang
> > > > > - fix a typo
> > > > >
> > > > > Changes since V1:
> > > > > - add new vdpa attribute VDPA_ATTR_DEV_F_VERSION_1 to indicate whether
> > > > >   the vdpa device is legacy
> > > > > - implement dedicated driver for Alibaba ENI instead a legacy virtio-pci
> > > > >   driver as suggested by Jason Wang
> > > > > - some bugs fixed
> > > > >
> > > > > Wu Zongyong (9):
> > > > >   virtio-pci: introduce legacy device module
> > > > >   vdpa: fix typo
> > > > >   vp_vdpa: add vq irq offloading support
> > > > >   vdpa: add new callback get_vq_num_min in vdpa_config_ops
> > > > >   vdpa: min vq num of vdpa device cannot be greater than max vq num
> > > > >   virtio_vdpa: setup correct vq size with callbacks get_vq_num_{max,min}
> > > > >   vdpa: add new attribute VDPA_ATTR_DEV_MIN_VQ_SIZE
> > > > >   eni_vdpa: add vDPA driver for Alibaba ENI
> > > > >   eni_vdpa: alibaba: fix Kconfig typo
> > > > >
> > > > >  drivers/vdpa/Kconfig                   |   8 +
> > > > >  drivers/vdpa/Makefile                  |   1 +
> > > > >  drivers/vdpa/alibaba/Makefile          |   3 +
> > > > >  drivers/vdpa/alibaba/eni_vdpa.c        | 553 +++++++++++++++++++++++++
> > > > >  drivers/vdpa/vdpa.c                    |  13 +
> > > > >  drivers/vdpa/virtio_pci/vp_vdpa.c      |  12 +
> > > > >  drivers/virtio/Kconfig                 |  10 +
> > > > >  drivers/virtio/Makefile                |   1 +
> > > > >  drivers/virtio/virtio_pci_common.c     |  10 +-
> > > > >  drivers/virtio/virtio_pci_common.h     |   9 +-
> > > > >  drivers/virtio/virtio_pci_legacy.c     | 101 ++---
> > > > >  drivers/virtio/virtio_pci_legacy_dev.c | 220 ++++++++++
> > > > >  drivers/virtio/virtio_vdpa.c           |  16 +-
> > > > >  include/linux/vdpa.h                   |   6 +-
> > > > >  include/linux/virtio_pci_legacy.h      |  42 ++
> > > > >  include/uapi/linux/vdpa.h              |   1 +
> > > > >  16 files changed, 917 insertions(+), 89 deletions(-)
> > > > >  create mode 100644 drivers/vdpa/alibaba/Makefile
> > > > >  create mode 100644 drivers/vdpa/alibaba/eni_vdpa.c
> > > > >  create mode 100644 drivers/virtio/virtio_pci_legacy_dev.c
> > > > >  create mode 100644 include/linux/virtio_pci_legacy.h
> > > > >
> > > > > --
> > > > > 2.31.1
> > > > >
> > >

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
