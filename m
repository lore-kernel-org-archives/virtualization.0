Return-Path: <SRS0=zxqJ=OA=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE97DC433EF
	for <virtualization@archiver.kernel.org>; Fri, 10 Sep 2021 01:44:23 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7FFC861101
	for <virtualization@archiver.kernel.org>; Fri, 10 Sep 2021 01:44:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7FFC861101
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 49F3082848;
	Fri, 10 Sep 2021 01:44:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pOVlZDWAvLBh; Fri, 10 Sep 2021 01:44:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id C011981A16;
	Fri, 10 Sep 2021 01:44:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9DCA3C000F;
	Fri, 10 Sep 2021 01:44:21 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 86805C000D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 10 Sep 2021 01:44:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 624FB40466
 for <virtualization@lists.linux-foundation.org>;
 Fri, 10 Sep 2021 01:44:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qbfLF3fSajH2
 for <virtualization@lists.linux-foundation.org>;
 Fri, 10 Sep 2021 01:44:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2A41540461
 for <virtualization@lists.linux-foundation.org>;
 Fri, 10 Sep 2021 01:44:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1631238257;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aczxOukc0e/xKHxdBLhwIfeEUY65ijyEUqlB4pI2VbA=;
 b=fsnT7dun+A05/vWLMTbDUJ0NeQiwdt3/SW7VniH9ma5PJatqxftjjSKmfhtSQJ5JZn3ISz
 B6bDtH4h8h2RWE78I52axZ0Iv94Vg78B1T+BgpFE7aa61HnqHp5C6cLCidiboo9/I0HzlY
 NT+vjKiOUQZ6xWmA7xEi+Otjus8h0ZU=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-567-sHAtEzAPOBOY1MNyMzmI7g-1; Thu, 09 Sep 2021 21:44:16 -0400
X-MC-Unique: sHAtEzAPOBOY1MNyMzmI7g-1
Received: by mail-lf1-f72.google.com with SMTP id
 q5-20020ac25fc5000000b003d9227d9edcso177284lfg.2
 for <virtualization@lists.linux-foundation.org>;
 Thu, 09 Sep 2021 18:44:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=aczxOukc0e/xKHxdBLhwIfeEUY65ijyEUqlB4pI2VbA=;
 b=6UcBK/Q3P7m/AsYcn6GCNMC9cWg5d67W3fRngX4Wjfr5/hm791rolp5rZu6N48pN+u
 v8ufKpMeYIYhhgs66kHOiJW1uF7LFCOV63qPomYJailtxE7j6STp8liWNkdGYSEFi4kL
 BbGcdUujWleUm8gxBrfcQncTVGe9NkG5bOc2lYKVrstoAEXlixcoPQku3PAFrvIAbbMp
 6jGXTCJgazIz1qp2lhvBdcSs/Jpml0HaQwBWSY2rIJo3XyLT1Fh7F/Qb6Wj1H66zzBqR
 Iv0a44tQ9XUOG+f8PXmn2fDKCE97P+TWlulYVG5tJnJZKVnsegEouJWlE+Tjl32AXDsF
 uQsQ==
X-Gm-Message-State: AOAM531WXj79vtzmnVnS6StFERq3zoWB7u+dcqhJOXaYZwlp6NSs8z/9
 ga0S0tgewxpoaAiqNcrIl9ijnbMbfriKK/xDh201xdsrEodck6/XPNIFQ68TB7VDMvNm4MuEqBr
 Lx7w2yzgmZdbVQPQvFqQeiSEmKbj6D95oL8ep0zt7EwKjFI9UwcRuUkyj6A==
X-Received: by 2002:a05:651c:54c:: with SMTP id
 q12mr2201472ljp.369.1631238255301; 
 Thu, 09 Sep 2021 18:44:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJynpVsk+eknNot+yeLFNkpC/5GhmoV6b/yshf++NyqtU6iv1FVD3fZeyQUcxb17W8eMyrZ+iTj0wv0oyDd50gE=
X-Received: by 2002:a05:651c:54c:: with SMTP id
 q12mr2201461ljp.369.1631238255083; 
 Thu, 09 Sep 2021 18:44:15 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1631101392.git.wuzongyong@linux.alibaba.com>
 <CACGkMEuEwbDQUtYHz=0O4pQcb6ibY0MAT7hLDjN=Okw8c9CZGA@mail.gmail.com>
 <20210909125338.GA17535@L-PF27918B-1352.localdomain>
In-Reply-To: <20210909125338.GA17535@L-PF27918B-1352.localdomain>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 10 Sep 2021 09:44:04 +0800
Message-ID: <CACGkMEuqDupA4hU_8s-z=E9UjVzKXyCVmw+mnmFUH0bq4eg=pA@mail.gmail.com>
Subject: Re: [PATCH 0/6] vDPA driver for legacy virtio-pci device
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

On Thu, Sep 9, 2021 at 8:53 PM Wu Zongyong <wuzongyong@linux.alibaba.com> wrote:
>
> On Thu, Sep 09, 2021 at 11:05:06AM +0800, Jason Wang wrote:
> > On Wed, Sep 8, 2021 at 8:22 PM Wu Zongyong <wuzongyong@linux.alibaba.com> wrote:
> > >
> > > This series implements the vDPA driver for legacy virtio-pci device.
> > > Currently we already have the vDPA driver for modern virtio-pci device
> > > only, but there are some legacy virtio-pci devices conforming to the
> > > virtio-pci specifications of 0.9.x or older versions. For example,
> > > ENI(Elastic Network Interface) of Alibaba ECS baremetal instance is a
> > > hardware virtio network device which follows the Virtio PCI Card 0.9.5
> > > Draft specification. Such legacy virtio-pci devices have some
> > > inconsistent behaviour with modern virtio-pci devices, so some common
> > > codes are split out and modern device specific codes are moved to a
> > > separated file.
> >
> > What worries me a little bit are:
> >
> > 1) vDPA requires IOMMU_PLATFORM to be supported by the device to work,
> > if I understand ENI correctly, it's a legacy device so it can't
> > support ACCESS_PLATFORM. Or is it a legacy device that supports
> > ACCESS_PLATFORM implicitly.
> > 2) vDPA tries to present a 1.0 device, in this case the behavior could
> > be ruled by the spec. If we tries to present an 1.0 device on top of
> > legacy device we may suffer a lot of issues:
> >
> > - endian issue: 1.0 use le but legacy may use native endian
> > - queue_enable semantic which is missed in the legacy
> > - virtqueue size, as you mentioned below
> >
> > I guess what the device(ENI) supports are:
> >
> > 1) semantic of ACCESS_PLATFORM without a feature
> > 2) little endian
> > 3) but a legacy device
> >
> > So I think it might be better:
> >
> > 1) introduce the library for legacy as you did in this patch
> > 2) having a dedicated ENI vDPA driver
>
> Would you mind I place the ENI vDPA driver inside virtio_pci folder? Or
> should I create a new folder for it?

I think it's better to have a new folder.

Thanks

>
> >
> > 3) live migration support, though it was not supported by the spec
> > yet, but we are working on the support, and we know legacy device can
> > support this.
> >
> > Thanks
> >
> > >
> > > For legacy devices, it is not supported to negotiate the virtqueue size
> > > by the specification. So a new callback get_vq_num_unchangeable is
> > > introduced to indicate user not to try change the virtqueue size of the
> > > legacy vdpa device. For example, QEMU should not allocate memory for
> > > virtqueue according to the properties tx_queue_size and rx_queue_size if
> > > we use legacy virtio-pci device as the vhost-vdpa backend. Instead, QEMU
> > > should use the new callback get_vq_num_unchangeable first to check if
> > > the vdpa device support to change virtqueue size. If not, QEMU should
> > > call the callback get_vq_num_max to get the static virtqueue size then
> > > allocate the same size memory for the virtqueue.
> > >
> > > This series have been tested with the ENI in Alibaba ECS baremetal
> > > instance.
> > >
> > > These patches may under consideration, welcome for comments.
> > >
> > >
> > > Wu Zongyong (6):
> > >   virtio-pci: introduce legacy device module
> > >   vdpa: fix typo
> > >   vp_vdpa: add vq irq offloading support
> > >   vp_vdpa: split out reusable and device specific codes to separate file
> > >   vdpa: add get_vq_num_unchangeable callback in vdpa_config_ops
> > >   vp_vdpa: introduce legacy virtio pci driver
> > >
> > >  drivers/vdpa/Kconfig                     |   7 +
> > >  drivers/vdpa/virtio_pci/Makefile         |   3 +
> > >  drivers/vdpa/virtio_pci/vp_vdpa.c        |   8 +
> > >  drivers/vdpa/virtio_pci/vp_vdpa_common.c | 220 ++++++++++++++
> > >  drivers/vdpa/virtio_pci/vp_vdpa_common.h |  67 +++++
> > >  drivers/vdpa/virtio_pci/vp_vdpa_legacy.c | 346 +++++++++++++++++++++++
> > >  drivers/vdpa/virtio_pci/vp_vdpa_modern.c | 327 +++++++++++++++++++++
> > >  drivers/vhost/vdpa.c                     |  19 ++
> > >  drivers/virtio/Kconfig                   |  10 +
> > >  drivers/virtio/Makefile                  |   1 +
> > >  drivers/virtio/virtio_pci_common.c       |  10 +-
> > >  drivers/virtio/virtio_pci_common.h       |   9 +-
> > >  drivers/virtio/virtio_pci_legacy.c       | 101 ++-----
> > >  drivers/virtio/virtio_pci_legacy_dev.c   | 220 ++++++++++++++
> > >  drivers/virtio/virtio_vdpa.c             |   5 +-
> > >  include/linux/vdpa.h                     |   6 +-
> > >  include/linux/virtio_pci_legacy.h        |  44 +++
> > >  include/uapi/linux/vhost.h               |   2 +
> > >  18 files changed, 1320 insertions(+), 85 deletions(-)
> > >  create mode 100644 drivers/vdpa/virtio_pci/vp_vdpa_common.c
> > >  create mode 100644 drivers/vdpa/virtio_pci/vp_vdpa_common.h
> > >  create mode 100644 drivers/vdpa/virtio_pci/vp_vdpa_legacy.c
> > >  create mode 100644 drivers/vdpa/virtio_pci/vp_vdpa_modern.c
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
