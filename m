Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E6BAC433EF
	for <virtualization@archiver.kernel.org>; Tue, 26 Apr 2022 09:56:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 17D996103B;
	Tue, 26 Apr 2022 09:56:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1Q8hjS7D08yG; Tue, 26 Apr 2022 09:56:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 7621460B45;
	Tue, 26 Apr 2022 09:55:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2CC6EC0039;
	Tue, 26 Apr 2022 09:55:59 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3E6B4C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Apr 2022 09:55:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2B2A2404DF
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Apr 2022 09:55:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fyqC1pt1WQ9w
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Apr 2022 09:55:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 15259403CA
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Apr 2022 09:55:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1650966954;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bKv/ULkJ/wp3hIqk7Hk8ciyskY/Ggu219LeUKhk8ymM=;
 b=XJDpdMIGYRZcO75VJL4/+iTKK1LMUolztoTDTi6BQH38QVF2/XQEc1uhNYVkRwV/gqmtMl
 NmSUgTSdxsiv3Yk9A1C1GKeMugtbA6B7i1m3RhgIUc/4U5kCFtxODWmj7TMFgWKUOZpwVx
 2gqOANX1QiSqiRAMKmGNT1UUQxB8hSE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-453-0OXpxy4sPumlflyl9jkaBw-1; Tue, 26 Apr 2022 05:55:51 -0400
X-MC-Unique: 0OXpxy4sPumlflyl9jkaBw-1
Received: by mail-wr1-f70.google.com with SMTP id
 t17-20020adfa2d1000000b0020ac519c222so3173186wra.4
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Apr 2022 02:55:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=bKv/ULkJ/wp3hIqk7Hk8ciyskY/Ggu219LeUKhk8ymM=;
 b=0d4IH2H8z6CtXLu1SLA2YGv/qPZmptilBccdXvwjwZZh7ovDrvwJHKVeR+He40V3JB
 6TQ0H6Vo/OMkijI9D23fnU2Ce/qHKCzlv6aDk9YyRxXKnxY8+Sy/UCT1uMyaWvIwvchv
 wu715swZt83U/cjde+bLTKp7LXZ0ArNa8DXSkG7rG9spGIAgcM/qzQuuD4f+hZh6D2pZ
 va//SflDIjWBUqBeks5E5p9GtuR3Fs5abQRd00NVImCKKvNWDOM/RNEqD8x1BcCe4XfL
 ztzAFLXEXXFcGTxEbIgQjgD/9qiziIpVV5jeUroWKfBu/iueXJXuSn1qHJn/HGXHw8pW
 E1ew==
X-Gm-Message-State: AOAM530NkM0FdEJQdxWMp2VfeS/vQ4wON1fk7T3/5/BbpDR72danvqBC
 TYqp/gWGzFUQfV2TUyV99So7n+jaNPbmwVQRr6xaaIVXW2IMdU29bpvZ0Jlre5+gYZYn9ZVz/86
 7efp9JvWww5LvjnlsIpxfCu3AjMPTPhvs8l6PUJWFZg==
X-Received: by 2002:a05:600c:3587:b0:393:ec32:d84e with SMTP id
 p7-20020a05600c358700b00393ec32d84emr7912284wmq.92.1650966950532; 
 Tue, 26 Apr 2022 02:55:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz8XKSGFc+0NUl8DKUeaivozN8xsVuR8eLs8RZ1+VRkX8o21nZkof7/x4aaezYJYxtUVEyOAg==
X-Received: by 2002:a05:600c:3587:b0:393:ec32:d84e with SMTP id
 p7-20020a05600c358700b00393ec32d84emr7912255wmq.92.1650966950289; 
 Tue, 26 Apr 2022 02:55:50 -0700 (PDT)
Received: from redhat.com ([2.53.22.137]) by smtp.gmail.com with ESMTPSA id
 204-20020a1c02d5000000b003928c42d02asm13036414wmc.23.2022.04.26.02.55.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Apr 2022 02:55:49 -0700 (PDT)
Date: Tue, 26 Apr 2022 05:55:41 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH v9 00/32] virtio pci support VIRTIO_F_RING_RESET
 (refactor vring)
Message-ID: <20220426055423-mutt-send-email-mst@kernel.org>
References: <20220406034346.74409-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <20220406034346.74409-1-xuanzhuo@linux.alibaba.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Vadim Pasternak <vadimp@nvidia.com>, linux-remoteproc@vger.kernel.org,
 Alexei Starovoitov <ast@kernel.org>, virtualization@lists.linux-foundation.org,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>, linux-s390@vger.kernel.org,
 Johannes Berg <johannes.berg@intel.com>,
 Daniel Borkmann <daniel@iogearbox.net>, Richard Weinberger <richard@nod.at>,
 Vincent Whitchurch <vincent.whitchurch@axis.com>,
 John Fastabend <john.fastabend@gmail.com>, Halil Pasic <pasic@linux.ibm.com>,
 Jakub Kicinski <kuba@kernel.org>, Heiko Carstens <hca@linux.ibm.com>,
 platform-driver-x86@vger.kernel.org, Jesper Dangaard Brouer <hawk@kernel.org>,
 Vasily Gorbik <gor@linux.ibm.com>, Jeff Dike <jdike@addtoit.com>,
 linux-um@lists.infradead.org, Mark Gross <markgross@kernel.org>,
 Hans de Goede <hdegoede@redhat.com>, kvm@vger.kernel.org,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 Mathieu Poirier <mathieu.poirier@linaro.org>, netdev@vger.kernel.org,
 Cornelia Huck <cohuck@redhat.com>, Sven Schnelle <svens@linux.ibm.com>,
 bpf@vger.kernel.org, "David S. Miller" <davem@davemloft.net>
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

On Wed, Apr 06, 2022 at 11:43:14AM +0800, Xuan Zhuo wrote:
> The virtio spec already supports the virtio queue reset function. This patch set
> is to add this function to the kernel. The relevant virtio spec information is
> here:
> 
>     https://github.com/oasis-tcs/virtio-spec/issues/124
> 
> Also regarding MMIO support for queue reset, I plan to support it after this
> patch is passed.

Regarding the spec, there's now an issue proposing
some changes to the interface. What do you think about that
proposal? Could you respond on that thread on the virtio TC mailing list?


> This patch set implements the refactoring of vring. Finally, the
> virtuque_resize() interface is provided based on the reset function of the
> transport layer.
> 
> Test environment:
>     Host: 4.19.91
>     Qemu: QEMU emulator version 6.2.50 (with vq reset support)
>     Test Cmd:  ethtool -G eth1 rx $1 tx $2; ethtool -g eth1
> 
>     The default is split mode, modify Qemu virtio-net to add PACKED feature to test
>     packed mode.
> 
> Qemu code:
>     https://github.com/fengidri/qemu/compare/89f3bfa3265554d1d591ee4d7f1197b6e3397e84...master
> 
> In order to simplify the review of this patch set, the function of reusing
> the old buffers after resize will be introduced in subsequent patch sets.
> 
> Please review. Thanks.
> 
> v9:
>   1. Provide a virtqueue_resize() interface directly
>   2. A patch set including vring resize, virtio pci reset, virtio-net resize
>   3. No more separate structs
> 
> v8:
>   1. Provide a virtqueue_reset() interface directly
>   2. Split the two patch sets, this is the first part
>   3. Add independent allocation helper for allocating state, extra
> 
> v7:
>   1. fix #6 subject typo
>   2. fix #6 ring_size_in_bytes is uninitialized
>   3. check by: make W=12
> 
> v6:
>   1. virtio_pci: use synchronize_irq(irq) to sync the irq callbacks
>   2. Introduce virtqueue_reset_vring() to implement the reset of vring during
>      the reset process. May use the old vring if num of the vq not change.
>   3. find_vqs() support sizes to special the max size of each vq
> 
> v5:
>   1. add virtio-net support set_ringparam
> 
> v4:
>   1. just the code of virtio, without virtio-net
>   2. Performing reset on a queue is divided into these steps:
>     1. reset_vq: reset one vq
>     2. recycle the buffer from vq by virtqueue_detach_unused_buf()
>     3. release the ring of the vq by vring_release_virtqueue()
>     4. enable_reset_vq: re-enable the reset queue
>   3. Simplify the parameters of enable_reset_vq()
>   4. add container structures for virtio_pci_common_cfg
> 
> v3:
>   1. keep vq, irq unreleased
> 
> Xuan Zhuo (32):
>   virtio: add helper virtqueue_get_vring_max_size()
>   virtio: struct virtio_config_ops add callbacks for queue_reset
>   virtio_ring: update the document of the virtqueue_detach_unused_buf
>     for queue reset
>   virtio_ring: remove the arg vq of vring_alloc_desc_extra()
>   virtio_ring: extract the logic of freeing vring
>   virtio_ring: split: extract the logic of alloc queue
>   virtio_ring: split: extract the logic of alloc state and extra
>   virtio_ring: split: extract the logic of attach vring
>   virtio_ring: split: extract the logic of vq init
>   virtio_ring: split: introduce virtqueue_reinit_split()
>   virtio_ring: split: introduce virtqueue_resize_split()
>   virtio_ring: packed: extract the logic of alloc queue
>   virtio_ring: packed: extract the logic of alloc state and extra
>   virtio_ring: packed: extract the logic of attach vring
>   virtio_ring: packed: extract the logic of vq init
>   virtio_ring: packed: introduce virtqueue_reinit_packed()
>   virtio_ring: packed: introduce virtqueue_resize_packed()
>   virtio_ring: introduce virtqueue_resize()
>   virtio_pci: struct virtio_pci_common_cfg add queue_notify_data
>   virtio: queue_reset: add VIRTIO_F_RING_RESET
>   virtio_pci: queue_reset: update struct virtio_pci_common_cfg and
>     option functions
>   virtio_pci: queue_reset: extract the logic of active vq for modern pci
>   virtio_pci: queue_reset: support VIRTIO_F_RING_RESET
>   virtio: find_vqs() add arg sizes
>   virtio_pci: support the arg sizes of find_vqs()
>   virtio_mmio: support the arg sizes of find_vqs()
>   virtio: add helper virtio_find_vqs_ctx_size()
>   virtio_net: set the default max ring size by find_vqs()
>   virtio_net: get ringparam by virtqueue_get_vring_max_size()
>   virtio_net: split free_unused_bufs()
>   virtio_net: support rx/tx queue resize
>   virtio_net: support set_ringparam
> 
>  arch/um/drivers/virtio_uml.c             |   3 +-
>  drivers/net/virtio_net.c                 | 219 +++++++-
>  drivers/platform/mellanox/mlxbf-tmfifo.c |   3 +
>  drivers/remoteproc/remoteproc_virtio.c   |   3 +
>  drivers/s390/virtio/virtio_ccw.c         |   4 +
>  drivers/virtio/virtio_mmio.c             |  11 +-
>  drivers/virtio/virtio_pci_common.c       |  28 +-
>  drivers/virtio/virtio_pci_common.h       |   3 +-
>  drivers/virtio/virtio_pci_legacy.c       |   8 +-
>  drivers/virtio/virtio_pci_modern.c       | 149 +++++-
>  drivers/virtio/virtio_pci_modern_dev.c   |  36 ++
>  drivers/virtio/virtio_ring.c             | 626 ++++++++++++++++++-----
>  drivers/virtio/virtio_vdpa.c             |   3 +
>  include/linux/virtio.h                   |   6 +
>  include/linux/virtio_config.h            |  38 +-
>  include/linux/virtio_pci_modern.h        |   2 +
>  include/uapi/linux/virtio_config.h       |   7 +-
>  include/uapi/linux/virtio_pci.h          |  14 +
>  18 files changed, 964 insertions(+), 199 deletions(-)
> 
> --
> 2.31.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
