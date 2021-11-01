Return-Path: <SRS0=TJKJ=PU=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3B32C433F5
	for <virtualization@archiver.kernel.org>; Mon,  1 Nov 2021 07:03:15 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7101760C40
	for <virtualization@archiver.kernel.org>; Mon,  1 Nov 2021 07:03:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7101760C40
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3805880C7B;
	Mon,  1 Nov 2021 07:03:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dE_FxnPNcJhp; Mon,  1 Nov 2021 07:03:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id B782080C46;
	Mon,  1 Nov 2021 07:03:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 87A99C0019;
	Mon,  1 Nov 2021 07:03:13 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C7ABFC000E
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Nov 2021 07:03:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id AD8DA40151
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Nov 2021 07:03:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id naxxs7LfG7CE
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Nov 2021 07:03:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0170740143
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Nov 2021 07:03:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1635750186;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8nIZ9XZS8kXj/EsotjjSLAWLpZa2G0PtCLWtzDmN8pk=;
 b=bxvJXoyyQ2ds3jPGaHKyj1ohWedjfkEeK2zmsXgEoFDEqxs4aTOGmrfniGlv6J/nWpSPVF
 GqSIV52c2Mbo89R/FnoKzXeJMVdVZ8IDj17hMqedXAPksYulmtzfxmYedkMITsAcjA47IH
 wt3TdumGpog8zo8WJJ1OExH2BLjTx+4=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-366-Xr3X0bNwM0ORn_9JIjsSog-1; Mon, 01 Nov 2021 03:03:05 -0400
X-MC-Unique: Xr3X0bNwM0ORn_9JIjsSog-1
Received: by mail-lf1-f69.google.com with SMTP id
 l30-20020ac2555e000000b0040017981499so549350lfk.18
 for <virtualization@lists.linux-foundation.org>;
 Mon, 01 Nov 2021 00:03:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=8nIZ9XZS8kXj/EsotjjSLAWLpZa2G0PtCLWtzDmN8pk=;
 b=whzT+b2X40bm9AAVqqr+tqidn5D7vhz3rcUyn7IF8NmoqmeG85Ax9/2F/QdQWPMFGD
 r3Us+vLLGrymW52EXfNqzsdqcnnsfQL7z88GvKi5Zd+/fzfCft43H3/BXxF2wCtUwqo4
 wyD71deorsZxUArJEI3ZZFxk5LBu5OaPyP8/hHW2uBsgGADo6wb0iabrTEmE3miXufni
 jGShD+OmcdQtbed1EZzOynwCdoO3mFABszbtaEFvxVLtK9RLIbDVr0tinybHswiVZg+a
 9+7qqrmE3AZXU/W1l4/lXHvmI6JGspEVhMOPq6/mIZyCtN4A8iYhuReCVtX3nfJ37yZr
 qZMA==
X-Gm-Message-State: AOAM532SaTQw7MoWrR0m8CTiX816UXhxzjwEG+c+4XdiUP/p/52i2FxL
 SLohDzf4RFqUOVJSdK/CHJ03gqixV/JvzyKkdOmEDd89+s9KklaB2U5ELe4tUQPu2OK8J7bgJGW
 RIPWirMbJdSIQeZtY0Eu3zGWh3XQSSdoqIBlBWWV/ia+5QBSH5xF85zXwog==
X-Received: by 2002:a05:6512:32c1:: with SMTP id
 f1mr26983589lfg.498.1635750183492; 
 Mon, 01 Nov 2021 00:03:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxvCUMxg2fWpw2CfJJoYRfJmyKMm7aQRlkb2EtHXN1hEP8h95d8aY4eDNKwn4e6z4ENnTVOAdVv2/jphY/X41o=
X-Received: by 2002:a05:6512:32c1:: with SMTP id
 f1mr26983574lfg.498.1635750183286; 
 Mon, 01 Nov 2021 00:03:03 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1634870456.git.wuzongyong@linux.alibaba.com>
 <cover.1635493219.git.wuzongyong@linux.alibaba.com>
 <CACGkMEv8+1YMhXfS31CoyFuwJ-toCLXd12ny7b=Ge+3fXWNYUw@mail.gmail.com>
 <20211101062250.GA29814@L-PF27918B-1352.localdomain>
In-Reply-To: <20211101062250.GA29814@L-PF27918B-1352.localdomain>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 1 Nov 2021 15:02:52 +0800
Message-ID: <CACGkMEvZkdEgAFpSo1Oen5JWthSowZ7NHqnp_X5AhNt+jxuiZg@mail.gmail.com>
Subject: Re: [PATCH v7 0/9] vDPA driver for Alibaba ENI
To: Wu Zongyong <wuzongyong@linux.alibaba.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: wei.yang1@linux.alibaba.com, mst <mst@redhat.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
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

On Mon, Nov 1, 2021 at 2:23 PM Wu Zongyong <wuzongyong@linux.alibaba.com> wrote:
>
> On Mon, Nov 01, 2021 at 11:31:15AM +0800, Jason Wang wrote:
> > On Fri, Oct 29, 2021 at 5:15 PM Wu Zongyong
> > <wuzongyong@linux.alibaba.com> wrote:
> > >
> > > This series implements the vDPA driver for Alibaba ENI (Elastic Network
> > > Interface) which is built based on virtio-pci 0.9.5 specification.
> >
> > It looks to me Michael has applied the patches, if this is the case,
> > we probably need to send patches on top.
>
> What do you mean by saying "send patches on top"?
> Sorry, I'm a newbie to contribute for kernel, could you please explain
> it in detail?

I meant you probably need to send incremental patch on top of:

git://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git linux-next.

Thanks


>
> Thanks
> > Thanks
> >
> > >
> > > Changes since V6:
> > > - set default min vq size to 1 intead of 0
> > > - enable eni vdpa driver only on X86 hosts
> > > - fix some typos
> > >
> > > Changes since V5:
> > > - remove unused codes
> > >
> > > Changes since V4:
> > > - check return values of get_vq_num_{max,min} when probing devices
> > > - disable the driver on BE host via Kconfig
> > > - add missing commit message
> > >
> > > Changes since V3:
> > > - validate VIRTIO_NET_F_MRG_RXBUF when negotiate features
> > > - present F_ORDER_PLATFORM in get_features
> > > - remove endian check since ENI always use litter endian
> > >
> > > Changes since V2:
> > > - add new attribute VDPA_ATTR_DEV_MIN_VQ_SIZE instead
> > >   VDPA_ATTR_DEV_F_VERSION_1 to guide users to choose correct virtqueue
> > >   size as suggested by Jason Wang
> > > - present ACCESS_PLATFORM in get_features callback as suggested by Jason
> > >   Wang
> > > - disable this driver on Big Endian host as suggested by Jason Wang
> > > - fix a typo
> > >
> > > Changes since V1:
> > > - add new vdpa attribute VDPA_ATTR_DEV_F_VERSION_1 to indicate whether
> > >   the vdpa device is legacy
> > > - implement dedicated driver for Alibaba ENI instead a legacy virtio-pci
> > >   driver as suggested by Jason Wang
> > > - some bugs fixed
> > >
> > > Wu Zongyong (9):
> > >   virtio-pci: introduce legacy device module
> > >   vdpa: fix typo
> > >   vp_vdpa: add vq irq offloading support
> > >   vdpa: add new callback get_vq_num_min in vdpa_config_ops
> > >   vdpa: min vq num of vdpa device cannot be greater than max vq num
> > >   virtio_vdpa: setup correct vq size with callbacks get_vq_num_{max,min}
> > >   vdpa: add new attribute VDPA_ATTR_DEV_MIN_VQ_SIZE
> > >   eni_vdpa: add vDPA driver for Alibaba ENI
> > >   eni_vdpa: alibaba: fix Kconfig typo
> > >
> > >  drivers/vdpa/Kconfig                   |   8 +
> > >  drivers/vdpa/Makefile                  |   1 +
> > >  drivers/vdpa/alibaba/Makefile          |   3 +
> > >  drivers/vdpa/alibaba/eni_vdpa.c        | 553 +++++++++++++++++++++++++
> > >  drivers/vdpa/vdpa.c                    |  13 +
> > >  drivers/vdpa/virtio_pci/vp_vdpa.c      |  12 +
> > >  drivers/virtio/Kconfig                 |  10 +
> > >  drivers/virtio/Makefile                |   1 +
> > >  drivers/virtio/virtio_pci_common.c     |  10 +-
> > >  drivers/virtio/virtio_pci_common.h     |   9 +-
> > >  drivers/virtio/virtio_pci_legacy.c     | 101 ++---
> > >  drivers/virtio/virtio_pci_legacy_dev.c | 220 ++++++++++
> > >  drivers/virtio/virtio_vdpa.c           |  16 +-
> > >  include/linux/vdpa.h                   |   6 +-
> > >  include/linux/virtio_pci_legacy.h      |  42 ++
> > >  include/uapi/linux/vdpa.h              |   1 +
> > >  16 files changed, 917 insertions(+), 89 deletions(-)
> > >  create mode 100644 drivers/vdpa/alibaba/Makefile
> > >  create mode 100644 drivers/vdpa/alibaba/eni_vdpa.c
> > >  create mode 100644 drivers/virtio/virtio_pci_legacy_dev.c
> > >  create mode 100644 include/linux/virtio_pci_legacy.h
> > >
> > > --
> > > 2.31.1
> > >
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
