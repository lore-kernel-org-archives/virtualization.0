Return-Path: <SRS0=8M8J=N7=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA024C433F5
	for <virtualization@archiver.kernel.org>; Thu,  9 Sep 2021 03:05:24 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86A5861181
	for <virtualization@archiver.kernel.org>; Thu,  9 Sep 2021 03:05:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 86A5861181
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 422A36140A;
	Thu,  9 Sep 2021 03:05:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iCY7GElTH8Vw; Thu,  9 Sep 2021 03:05:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id D45EB60724;
	Thu,  9 Sep 2021 03:05:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B9F60C000F;
	Thu,  9 Sep 2021 03:05:22 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 24668C000D
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Sep 2021 03:05:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id F37C3406DC
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Sep 2021 03:05:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QoLW92K4dVQF
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Sep 2021 03:05:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 32B6240451
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Sep 2021 03:05:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1631156720;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NU5ka/ttka6vOdhYaa9ciTz54egntIe+PWYBKnyBETs=;
 b=EQaNIMKiks7oKOTgJiYAdH6xAvLMyM3p4N7pvuqdx80GtntA12Ti46dig09VJkkpJI6836
 m4Ty9qElLfAAKDmt2JOdIzl4lc0zqHf+uUCj6ED4EBFgZWP4BmWb0ZTIk12zuT4Z6MRwIt
 zj4ddHujBff88FlED/N5vQhBqkaYuOI=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-588-2aEgyXOkOt6argLvbiqUrg-1; Wed, 08 Sep 2021 23:05:19 -0400
X-MC-Unique: 2aEgyXOkOt6argLvbiqUrg-1
Received: by mail-lj1-f200.google.com with SMTP id
 c16-20020a2e89d0000000b001d018ef42aaso141898ljk.23
 for <virtualization@lists.linux-foundation.org>;
 Wed, 08 Sep 2021 20:05:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=NU5ka/ttka6vOdhYaa9ciTz54egntIe+PWYBKnyBETs=;
 b=UkmfcZCuWjXvqTC42k5cbKIctVjq95Uo0U4uVFUrOS0/VIO5prpceyVfewvVDjDxik
 9Fq4ndKVQz9EfEf4kZX/H0PPmICiDm94vgYvPhITlNYMxwHUCEA/pvQqfB/asP6i8avz
 YXGh6QH0U/DpQakaG83lSsOUPpuA+lZzdLyU+XzDOCM+hRF0dWDMy165+NwUmF3hZur8
 jzUc/Fc1kwmaIxZBiYGuEf7Xq9aUntI8h/8l7QF3P1jlzc2zVIoxxjGIfY/m3QVwg8+G
 6QstL8ORMBaNS8qaGSO68NRT6vmNgKRb5im+fqeqN9zvq14OJP8fuQsg736wrjN1sOF3
 jDVQ==
X-Gm-Message-State: AOAM530f/WOWCnNOWyLimLkzklo/Wl1HCansj/pNbr+wKaVBwHTNWLUb
 EbckvrLNYO7yFXdFxPYAdTHBwZy+FDuFMuvU+zGL/091x3PM6E6oAa7NYC9qZ1GpipKyLjQ95IN
 ak3P/785RxWBM2TE+Hts5eTzJZ1hkHJD/VqUdzxvQSfjLLxVVjeueqdv+pA==
X-Received: by 2002:a19:6b18:: with SMTP id d24mr694443lfa.84.1631156717372;
 Wed, 08 Sep 2021 20:05:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwyf6WWUf+K61c6ZqyObAjKFSDb7DNWOBkoEfX4dffRDBnQyUToBmG4FMDi64K+hRcszK0E9x5ctIJcVAhJHWQ=
X-Received: by 2002:a19:6b18:: with SMTP id d24mr694425lfa.84.1631156717143;
 Wed, 08 Sep 2021 20:05:17 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1631101392.git.wuzongyong@linux.alibaba.com>
In-Reply-To: <cover.1631101392.git.wuzongyong@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 9 Sep 2021 11:05:06 +0800
Message-ID: <CACGkMEuEwbDQUtYHz=0O4pQcb6ibY0MAT7hLDjN=Okw8c9CZGA@mail.gmail.com>
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

On Wed, Sep 8, 2021 at 8:22 PM Wu Zongyong <wuzongyong@linux.alibaba.com> wrote:
>
> This series implements the vDPA driver for legacy virtio-pci device.
> Currently we already have the vDPA driver for modern virtio-pci device
> only, but there are some legacy virtio-pci devices conforming to the
> virtio-pci specifications of 0.9.x or older versions. For example,
> ENI(Elastic Network Interface) of Alibaba ECS baremetal instance is a
> hardware virtio network device which follows the Virtio PCI Card 0.9.5
> Draft specification. Such legacy virtio-pci devices have some
> inconsistent behaviour with modern virtio-pci devices, so some common
> codes are split out and modern device specific codes are moved to a
> separated file.

What worries me a little bit are:

1) vDPA requires IOMMU_PLATFORM to be supported by the device to work,
if I understand ENI correctly, it's a legacy device so it can't
support ACCESS_PLATFORM. Or is it a legacy device that supports
ACCESS_PLATFORM implicitly.
2) vDPA tries to present a 1.0 device, in this case the behavior could
be ruled by the spec. If we tries to present an 1.0 device on top of
legacy device we may suffer a lot of issues:

- endian issue: 1.0 use le but legacy may use native endian
- queue_enable semantic which is missed in the legacy
- virtqueue size, as you mentioned below

I guess what the device(ENI) supports are:

1) semantic of ACCESS_PLATFORM without a feature
2) little endian
3) but a legacy device

So I think it might be better:

1) introduce the library for legacy as you did in this patch
2) having a dedicated ENI vDPA driver

3) live migration support, though it was not supported by the spec
yet, but we are working on the support, and we know legacy device can
support this.

Thanks

>
> For legacy devices, it is not supported to negotiate the virtqueue size
> by the specification. So a new callback get_vq_num_unchangeable is
> introduced to indicate user not to try change the virtqueue size of the
> legacy vdpa device. For example, QEMU should not allocate memory for
> virtqueue according to the properties tx_queue_size and rx_queue_size if
> we use legacy virtio-pci device as the vhost-vdpa backend. Instead, QEMU
> should use the new callback get_vq_num_unchangeable first to check if
> the vdpa device support to change virtqueue size. If not, QEMU should
> call the callback get_vq_num_max to get the static virtqueue size then
> allocate the same size memory for the virtqueue.
>
> This series have been tested with the ENI in Alibaba ECS baremetal
> instance.
>
> These patches may under consideration, welcome for comments.
>
>
> Wu Zongyong (6):
>   virtio-pci: introduce legacy device module
>   vdpa: fix typo
>   vp_vdpa: add vq irq offloading support
>   vp_vdpa: split out reusable and device specific codes to separate file
>   vdpa: add get_vq_num_unchangeable callback in vdpa_config_ops
>   vp_vdpa: introduce legacy virtio pci driver
>
>  drivers/vdpa/Kconfig                     |   7 +
>  drivers/vdpa/virtio_pci/Makefile         |   3 +
>  drivers/vdpa/virtio_pci/vp_vdpa.c        |   8 +
>  drivers/vdpa/virtio_pci/vp_vdpa_common.c | 220 ++++++++++++++
>  drivers/vdpa/virtio_pci/vp_vdpa_common.h |  67 +++++
>  drivers/vdpa/virtio_pci/vp_vdpa_legacy.c | 346 +++++++++++++++++++++++
>  drivers/vdpa/virtio_pci/vp_vdpa_modern.c | 327 +++++++++++++++++++++
>  drivers/vhost/vdpa.c                     |  19 ++
>  drivers/virtio/Kconfig                   |  10 +
>  drivers/virtio/Makefile                  |   1 +
>  drivers/virtio/virtio_pci_common.c       |  10 +-
>  drivers/virtio/virtio_pci_common.h       |   9 +-
>  drivers/virtio/virtio_pci_legacy.c       | 101 ++-----
>  drivers/virtio/virtio_pci_legacy_dev.c   | 220 ++++++++++++++
>  drivers/virtio/virtio_vdpa.c             |   5 +-
>  include/linux/vdpa.h                     |   6 +-
>  include/linux/virtio_pci_legacy.h        |  44 +++
>  include/uapi/linux/vhost.h               |   2 +
>  18 files changed, 1320 insertions(+), 85 deletions(-)
>  create mode 100644 drivers/vdpa/virtio_pci/vp_vdpa_common.c
>  create mode 100644 drivers/vdpa/virtio_pci/vp_vdpa_common.h
>  create mode 100644 drivers/vdpa/virtio_pci/vp_vdpa_legacy.c
>  create mode 100644 drivers/vdpa/virtio_pci/vp_vdpa_modern.c
>  create mode 100644 drivers/virtio/virtio_pci_legacy_dev.c
>  create mode 100644 include/linux/virtio_pci_legacy.h
>
> --
> 2.31.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
