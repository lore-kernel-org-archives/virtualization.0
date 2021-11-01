Return-Path: <SRS0=TJKJ=PU=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2144BC433F5
	for <virtualization@archiver.kernel.org>; Mon,  1 Nov 2021 03:31:37 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B80C460F0F
	for <virtualization@archiver.kernel.org>; Mon,  1 Nov 2021 03:31:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B80C460F0F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 562A04022C;
	Mon,  1 Nov 2021 03:31:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4dgWTVe6riuw; Mon,  1 Nov 2021 03:31:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id B644E40227;
	Mon,  1 Nov 2021 03:31:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 604EBC0019;
	Mon,  1 Nov 2021 03:31:34 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 848EEC000E
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Nov 2021 03:31:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 532F140175
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Nov 2021 03:31:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YaPTxEXJv02E
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Nov 2021 03:31:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1C2D140151
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Nov 2021 03:31:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1635737489;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4z+r8vmmaZ/XATkk552nndpk1JEP3wPG2o03Q4EEusg=;
 b=NvZLcYMg8sgcDdyNf6cVhtlMTYTa5x96IDO3rYpC9rj48MS6TUUVwCC6237Owjhl5FE5JK
 DVNUMXTI69WmSVXqlG2Hq1aREwZZxgmZHwvLK8AgO9WKifzGLj1j4YMZzi/iYvJgiYJoKF
 DH4G9cX6ti7fOAZ3TiSdVnFpl/HShSw=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-293-oF0c3m5kOliJ_U-C3vM4sQ-1; Sun, 31 Oct 2021 23:31:27 -0400
X-MC-Unique: oF0c3m5kOliJ_U-C3vM4sQ-1
Received: by mail-lj1-f200.google.com with SMTP id
 q6-20020a2e2a06000000b00212c856abc8so2324259ljq.4
 for <virtualization@lists.linux-foundation.org>;
 Sun, 31 Oct 2021 20:31:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=4z+r8vmmaZ/XATkk552nndpk1JEP3wPG2o03Q4EEusg=;
 b=A8rnNeUkZWEmNh/TSgedkBTPuAEfgqKPbgQ85uKh07ayv1irNZk6u36SFsuuyfWpfX
 376PnINirw1dhfYNDnltZUAxBUYWUGOx9d4aKZXRk1jZmuktnvovHoUz4ctWwTumwc7R
 LGqdaliT4L9thuJMiFQUjbeJrsDdHVItO+qlFfj3uZDs3xkwsiZqUnighEanO3WXoQvP
 ppRaveOjzGBJ03CmW/s8nKxtRvvFP0EBUXObou8Cy11tTZ9GmhrVCEX4Eh70z7d29KW7
 QYmSBaInXZy5+6o5/caaWI3XA0iHpvVUh3hRRIbSsD69RTaFFClUWFX4/841Mbs9Cbl8
 8moQ==
X-Gm-Message-State: AOAM530MsGVzTEXeFgk15QKbI6lu2cRgZiroAL1jJMbtIUkxlA5j7GYr
 fa2TgWC/j5koDwVJpDNz1fIl+wV2PVaLs20zQoIb805ceSP3vBppKUCXl+OxzMpj5xWRK0mhCsM
 YnxiKv8UwLwuJkTFMrdyEw/D5tKrK093DNFYBmSgAzMRl3sQZ8yQV+6jDdg==
X-Received: by 2002:a05:6512:32c1:: with SMTP id
 f1mr26163877lfg.498.1635737486321; 
 Sun, 31 Oct 2021 20:31:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzZWlYpHrxQKnB/mRgYJvPm5oK6xilCclq1C6WxSTBWhrktLxqFq+3etE8VWgYQ6+O+qG2hnOnZIaIV2E/R9cI=
X-Received: by 2002:a05:6512:32c1:: with SMTP id
 f1mr26163867lfg.498.1635737486110; 
 Sun, 31 Oct 2021 20:31:26 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1634870456.git.wuzongyong@linux.alibaba.com>
 <cover.1635493219.git.wuzongyong@linux.alibaba.com>
In-Reply-To: <cover.1635493219.git.wuzongyong@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 1 Nov 2021 11:31:15 +0800
Message-ID: <CACGkMEv8+1YMhXfS31CoyFuwJ-toCLXd12ny7b=Ge+3fXWNYUw@mail.gmail.com>
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

On Fri, Oct 29, 2021 at 5:15 PM Wu Zongyong
<wuzongyong@linux.alibaba.com> wrote:
>
> This series implements the vDPA driver for Alibaba ENI (Elastic Network
> Interface) which is built based on virtio-pci 0.9.5 specification.

It looks to me Michael has applied the patches, if this is the case,
we probably need to send patches on top.

Thanks

>
> Changes since V6:
> - set default min vq size to 1 intead of 0
> - enable eni vdpa driver only on X86 hosts
> - fix some typos
>
> Changes since V5:
> - remove unused codes
>
> Changes since V4:
> - check return values of get_vq_num_{max,min} when probing devices
> - disable the driver on BE host via Kconfig
> - add missing commit message
>
> Changes since V3:
> - validate VIRTIO_NET_F_MRG_RXBUF when negotiate features
> - present F_ORDER_PLATFORM in get_features
> - remove endian check since ENI always use litter endian
>
> Changes since V2:
> - add new attribute VDPA_ATTR_DEV_MIN_VQ_SIZE instead
>   VDPA_ATTR_DEV_F_VERSION_1 to guide users to choose correct virtqueue
>   size as suggested by Jason Wang
> - present ACCESS_PLATFORM in get_features callback as suggested by Jason
>   Wang
> - disable this driver on Big Endian host as suggested by Jason Wang
> - fix a typo
>
> Changes since V1:
> - add new vdpa attribute VDPA_ATTR_DEV_F_VERSION_1 to indicate whether
>   the vdpa device is legacy
> - implement dedicated driver for Alibaba ENI instead a legacy virtio-pci
>   driver as suggested by Jason Wang
> - some bugs fixed
>
> Wu Zongyong (9):
>   virtio-pci: introduce legacy device module
>   vdpa: fix typo
>   vp_vdpa: add vq irq offloading support
>   vdpa: add new callback get_vq_num_min in vdpa_config_ops
>   vdpa: min vq num of vdpa device cannot be greater than max vq num
>   virtio_vdpa: setup correct vq size with callbacks get_vq_num_{max,min}
>   vdpa: add new attribute VDPA_ATTR_DEV_MIN_VQ_SIZE
>   eni_vdpa: add vDPA driver for Alibaba ENI
>   eni_vdpa: alibaba: fix Kconfig typo
>
>  drivers/vdpa/Kconfig                   |   8 +
>  drivers/vdpa/Makefile                  |   1 +
>  drivers/vdpa/alibaba/Makefile          |   3 +
>  drivers/vdpa/alibaba/eni_vdpa.c        | 553 +++++++++++++++++++++++++
>  drivers/vdpa/vdpa.c                    |  13 +
>  drivers/vdpa/virtio_pci/vp_vdpa.c      |  12 +
>  drivers/virtio/Kconfig                 |  10 +
>  drivers/virtio/Makefile                |   1 +
>  drivers/virtio/virtio_pci_common.c     |  10 +-
>  drivers/virtio/virtio_pci_common.h     |   9 +-
>  drivers/virtio/virtio_pci_legacy.c     | 101 ++---
>  drivers/virtio/virtio_pci_legacy_dev.c | 220 ++++++++++
>  drivers/virtio/virtio_vdpa.c           |  16 +-
>  include/linux/vdpa.h                   |   6 +-
>  include/linux/virtio_pci_legacy.h      |  42 ++
>  include/uapi/linux/vdpa.h              |   1 +
>  16 files changed, 917 insertions(+), 89 deletions(-)
>  create mode 100644 drivers/vdpa/alibaba/Makefile
>  create mode 100644 drivers/vdpa/alibaba/eni_vdpa.c
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
