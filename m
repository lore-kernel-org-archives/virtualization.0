Return-Path: <SRS0=TJKJ=PU=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19DACC433F5
	for <virtualization@archiver.kernel.org>; Mon,  1 Nov 2021 08:19:30 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5D2F60E52
	for <virtualization@archiver.kernel.org>; Mon,  1 Nov 2021 08:19:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C5D2F60E52
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8BEC080CB3;
	Mon,  1 Nov 2021 08:19:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SVwFK95Ir0Br; Mon,  1 Nov 2021 08:19:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 2A41080CA2;
	Mon,  1 Nov 2021 08:19:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 121CBC0019;
	Mon,  1 Nov 2021 08:19:28 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C2B22C000E
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Nov 2021 08:19:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B17FE6066F
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Nov 2021 08:19:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PoU3qbcmw6Ha
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Nov 2021 08:19:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 66B0C60597
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Nov 2021 08:19:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1635754764;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kBVOOyaoa1InLL/+ffGw+8bT8fwSPIwAJAyuABlhWqc=;
 b=VyNampVpFffACNdl3qJA6fxrxwSmDlE25/FOqqZLLtaUYipWaf4bnjcPE9LYCCJNwIVQD7
 RJfo921K47oSSip1sfG0g3EpYsU4oD5zwI3MTpOgzLYhncPtnSduIBFnCuOvDx7A0yxiQV
 4BM7FsHORyUIxSICd76/JNI2Q0F3Vvo=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-184-o5O_KQnPP1GvYxRs8t-GYg-1; Mon, 01 Nov 2021 04:19:23 -0400
X-MC-Unique: o5O_KQnPP1GvYxRs8t-GYg-1
Received: by mail-ed1-f71.google.com with SMTP id
 w7-20020a056402268700b003dd46823a18so14827213edd.18
 for <virtualization@lists.linux-foundation.org>;
 Mon, 01 Nov 2021 01:19:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=kBVOOyaoa1InLL/+ffGw+8bT8fwSPIwAJAyuABlhWqc=;
 b=hK/uo5YLOfjnMr5LpnAR+ybQHOBzPf/DYkLgcAjWN3KkhsNsWJQKJZkl6UJ/CDzkjq
 hDEz5TAvSlbdsfegaz3k+4V3uarLfW6qESYrEpXtJDReFg9U2eVXl/OFRrfv39cJNuGf
 b7Z529I8x1rRpd6rJ5pnPZ9TK3BY2CMF9dmn8zW99Vz5pmZSIMOE+2ZLnVkQS5hYTjvW
 IaP7DAeiJGeMRcKwRFLI+pTqWEOsdLziBYvLk7QHs+vZ6mouxDDpqgAi24JL/FWdeUel
 KPFFSYR+CjyTFesGfURF/NZx0BPiBIBR9rDkvzmNGs/yoHCI4YBL1PY6k7PErV3EwGLM
 R7bA==
X-Gm-Message-State: AOAM530gVrkRFCQkjPkYjlRAraKfGCUPzn2LSmFnlX8axfO30FVn4iFs
 3bFoUX4Zi42Ks07/0dOjlYd+g3UBiLKQHw4p5kyNIqE3f85DvrREyB+G2sFw7jzIahRCVzBBaxe
 ZI2V+ZgMH8ixrBnES6T6kxE5XRrw2rO3yQwnPwy8rDQ==
X-Received: by 2002:a17:906:9501:: with SMTP id
 u1mr33785979ejx.496.1635754761875; 
 Mon, 01 Nov 2021 01:19:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzonKX2m+XR50OstF9piRdvpS0ryGxmcZfSehSgi21On/RYiZJT85J1FRh0pPRnji5Gx1AJ+A==
X-Received: by 2002:a17:906:9501:: with SMTP id
 u1mr33785961ejx.496.1635754761739; 
 Mon, 01 Nov 2021 01:19:21 -0700 (PDT)
Received: from redhat.com ([176.12.204.186])
 by smtp.gmail.com with ESMTPSA id v10sm8329296edt.24.2021.11.01.01.19.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Nov 2021 01:19:20 -0700 (PDT)
Date: Mon, 1 Nov 2021 04:19:16 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Wu Zongyong <wuzongyong@linux.alibaba.com>
Subject: Re: [PATCH v7 0/9] vDPA driver for Alibaba ENI
Message-ID: <20211101041846-mutt-send-email-mst@kernel.org>
References: <cover.1634870456.git.wuzongyong@linux.alibaba.com>
 <cover.1635493219.git.wuzongyong@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <cover.1635493219.git.wuzongyong@linux.alibaba.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: wei.yang1@linux.alibaba.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org
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

On Fri, Oct 29, 2021 at 05:14:41PM +0800, Wu Zongyong wrote:
> This series implements the vDPA driver for Alibaba ENI (Elastic Network
> Interface) which is built based on virtio-pci 0.9.5 specification.

In the future pls do not send v7 as a reply to v6.
Start a new thread with each version.

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

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
