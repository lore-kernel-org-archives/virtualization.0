Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DD2DC433F5
	for <virtualization@archiver.kernel.org>; Mon,  7 Feb 2022 03:40:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id D62C340201;
	Mon,  7 Feb 2022 03:40:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GBotQ7vRS1eZ; Mon,  7 Feb 2022 03:39:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 0A631400E5;
	Mon,  7 Feb 2022 03:39:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DE18BC0011;
	Mon,  7 Feb 2022 03:39:58 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2F7A4C000B
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Feb 2022 03:39:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0A511607C0
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Feb 2022 03:39:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EzE5Z5skapeE
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Feb 2022 03:39:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9901A6059C
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Feb 2022 03:39:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1644205193;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xVIuoCTqsLoPm1wGvsBC88Fgmkqn303MCtDtpNt2DAQ=;
 b=NFIHeEMfnyg3pVVNI2+S94Q+m+InYTqv1IV7q27k+O4u6mJhIse6fU5ijJxjQ+5J6xHimC
 xTlNDIVSdl+CAKPRmdB04s0xhgOFUOIh8H83awiy3JCkeICCwwOKVZ/7jYHjZHz4By9W0g
 /mSIK2h8qkrw6Z2uKCn0pkfDEYnMrn8=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-210-ZhKkO2LCNkW9cUEbcjg81g-1; Sun, 06 Feb 2022 22:39:49 -0500
X-MC-Unique: ZhKkO2LCNkW9cUEbcjg81g-1
Received: by mail-lj1-f199.google.com with SMTP id
 c31-20020a2ebf1f000000b0022d87a28911so3881733ljr.1
 for <virtualization@lists.linux-foundation.org>;
 Sun, 06 Feb 2022 19:39:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=xVIuoCTqsLoPm1wGvsBC88Fgmkqn303MCtDtpNt2DAQ=;
 b=bC6dQNx7/7MHTWSeEstjIMETP6osgsJk6Mo2OI0ZaES/2qlaHZRUUnI1fUxdH1aiXS
 aFdjOkqG99L/770WbiT4J47EKrx5V2XADrqVOEbTNRVJcTB3nvAsbDjEIQEnAa0SotxI
 aameoUTK2zAf/FdGCSb+fpNxtWoyjmsu0ZuzCykJ5RLX8I79r352z/g2V7bh1zD9P3HG
 B4aI30yCoWenOOApZM5IXvc9Y1iq2xAU9+Z3IscpfBNWo1Vt6CMGMP2wB1q7NdlBs75w
 UEblgO2cbj7vz/B1bfyQIn1I424gO18d1wCMwVSLM7YbMkpAc4H/dCXcNVY1jaPlQjtO
 WaYg==
X-Gm-Message-State: AOAM530ZX72dbjq+Suuq5Yo9aOtSo9Kp7EtK4O4czcvf1yrLWmZ9chIY
 Ju+Je7Oe+SnInX8DzT1EEZye9baADROHNT+nsWRRWnkYp3Q+JjTzzDRikQGuj82xYgvU9eSj+PC
 Ix6JRjP0thF/bsEJ6neahQkDzZR3uOO5y+050XSI+XPTvqoCM5jtWee83Fw==
X-Received: by 2002:a2e:a4a9:: with SMTP id g9mr7613475ljm.369.1644205188304; 
 Sun, 06 Feb 2022 19:39:48 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwQMAzYq+CxytLesVKBqO45/3hGiHz1b6TXhrBr/eXRPDdce+EOxX9OpBCJ3GQOmMhNUh/OlcI2VNakyYjFmnw=
X-Received: by 2002:a2e:a4a9:: with SMTP id g9mr7613459ljm.369.1644205188083; 
 Sun, 06 Feb 2022 19:39:48 -0800 (PST)
MIME-Version: 1.0
References: <20220126073533.44994-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20220126073533.44994-1-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 7 Feb 2022 11:39:36 +0800
Message-ID: <CACGkMEspyHTmcSaq9fgpU88VCZGzu21Khp9H+fqL-pb5GLdEpA@mail.gmail.com>
Subject: Re: [PATCH v3 00/17] virtio pci support VIRTIO_F_RING_RESET
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, "Michael S. Tsirkin" <mst@redhat.com>,
 netdev <netdev@vger.kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Jakub Kicinski <kuba@kernel.org>, bpf@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>
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

On Wed, Jan 26, 2022 at 3:35 PM Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
>
> ================================================================================
> The virtio spec already supports the virtio queue reset function. This patch set
> is to add this function to the kernel. The relevant virtio spec information is
> here:
>
>     https://github.com/oasis-tcs/virtio-spec/issues/124
>
> Also regarding MMIO support for queue reset, I plan to support it after this
> patch is passed.
>
> #14-#17 is the disable/enable function of rx/tx pair implemented by virtio-net
> using the new helper.

One thing that came to mind is the steering. E.g if we disable an RX,
should we stop steering packets to that queue?

Thanks

> This function is not currently referenced by other
> functions. It is more to show the usage of the new helper, I not sure if they
> are going to be merged together.
>
> Please review. Thanks.
>
> v3:
>   1. keep vq, irq unreleased
>
> Xuan Zhuo (17):
>   virtio_pci: struct virtio_pci_common_cfg add queue_notify_data
>   virtio: queue_reset: add VIRTIO_F_RING_RESET
>   virtio: queue_reset: struct virtio_config_ops add callbacks for
>     queue_reset
>   virtio: queue_reset: add helper
>   vritio_ring: queue_reset: extract the release function of the vq ring
>   virtio_ring: queue_reset: split: add __vring_init_virtqueue()
>   virtio_ring: queue_reset: split: support enable reset queue
>   virtio_ring: queue_reset: packed: support enable reset queue
>   virtio_ring: queue_reset: add vring_reset_virtqueue()
>   virtio_pci: queue_reset: update struct virtio_pci_common_cfg and
>     option functions
>   virtio_pci: queue_reset: release vq by vp_dev->vqs
>   virtio_pci: queue_reset: setup_vq use vring_setup_virtqueue()
>   virtio_pci: queue_reset: support VIRTIO_F_RING_RESET
>   virtio_net: virtnet_tx_timeout() fix style
>   virtio_net: virtnet_tx_timeout() stop ref sq->vq
>   virtio_net: split free_unused_bufs()
>   virtio_net: support pair disable/enable
>
>  drivers/net/virtio_net.c               | 220 ++++++++++++++++++++++---
>  drivers/virtio/virtio_pci_common.c     |  62 ++++---
>  drivers/virtio/virtio_pci_common.h     |  11 +-
>  drivers/virtio/virtio_pci_legacy.c     |   5 +-
>  drivers/virtio/virtio_pci_modern.c     | 120 +++++++++++++-
>  drivers/virtio/virtio_pci_modern_dev.c |  28 ++++
>  drivers/virtio/virtio_ring.c           | 144 +++++++++++-----
>  include/linux/virtio.h                 |   1 +
>  include/linux/virtio_config.h          |  75 ++++++++-
>  include/linux/virtio_pci_modern.h      |   2 +
>  include/linux/virtio_ring.h            |  42 +++--
>  include/uapi/linux/virtio_config.h     |   7 +-
>  include/uapi/linux/virtio_pci.h        |   2 +
>  13 files changed, 618 insertions(+), 101 deletions(-)
>
> --
> 2.31.0
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
