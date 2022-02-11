Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A322C433F5
	for <virtualization@archiver.kernel.org>; Fri, 11 Feb 2022 05:41:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E9B83415EE;
	Fri, 11 Feb 2022 05:41:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0M9ERRzaT_PT; Fri, 11 Feb 2022 05:41:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 7619240925;
	Fri, 11 Feb 2022 05:41:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 49564C001A;
	Fri, 11 Feb 2022 05:41:16 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4D404C000B
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Feb 2022 05:41:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1FFAA82FE7
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Feb 2022 05:41:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Aby_FiqpdnWJ
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Feb 2022 05:41:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9507E82FE4
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Feb 2022 05:41:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1644558072;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cDY2/mAEz0DQk9D+NgCrbqdeAZ4u0IeTKwgJqx2x5yo=;
 b=Op4XLWbnYb2fbwEXjJxR4EjK0VYhlTZo54zuwJwwYKpDP6nerVVT1t4BTJXH/09m1xNy+p
 5VMV0tFJx17pJ/uzDjQJ9oUfx4e07EnLpY3b+Rig9bHwr2irfpeGo5JCq6aXCAfvEXuunx
 7Dj2pY8uaNhQ5/QYF1yYP7XyGYFEoc8=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-354-LPnZyMJCMOqd_h25qQYxbg-1; Fri, 11 Feb 2022 00:41:05 -0500
X-MC-Unique: LPnZyMJCMOqd_h25qQYxbg-1
Received: by mail-lf1-f70.google.com with SMTP id
 h6-20020ac25966000000b00442b0158d70so1772920lfp.12
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Feb 2022 21:41:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=cDY2/mAEz0DQk9D+NgCrbqdeAZ4u0IeTKwgJqx2x5yo=;
 b=V5FRIYZHu8cYHUOly4fWl74AtGJvwyEayVAmxz4q+ORdgpfmyys9Ujz0YsT/bUWET6
 GPwgyPI1QWvRL3xOFsdqjkRytDvUVYSS9d91X5D1gF+EPYDSNufnUhDj57f9MriER1SH
 v3+gGnZJEPO74dkineZmc1otNFWXz+N8TPSkGC0jS2Mhb/oRJvAu5RANMlbfTqA8vd6i
 /0n3KZYZCnrWq+t1aoCtFREAAmZlW8zopfTEqE5h51UNZxGrqRplS87QqJMP4dE3zX+u
 mIhSONCBvt5aqx99PGBE+Td50Z5W7GOQzIoI5zgCMQxCsX37Fx+azGPbLxCmjhIm3tNr
 nHBw==
X-Gm-Message-State: AOAM532GhuXu5fKBf39uNBYvMcJt69R8hleOz6xMZVsEhEbAEq5EtPKy
 qVD0zX50jQpsQMyQalCiv81PzwIIzQqZL3c0OjdtzCX99XfHsv+mEoQz8PYmFLOGA3VseszBYg/
 gEfvOaUTzBpIsTspacQ5/TQzaZIU4h6SkqmKG9WtP3OCdalJRK/zHZuUNMA==
X-Received: by 2002:a05:6512:3986:: with SMTP id
 j6mr111863lfu.84.1644558063685; 
 Thu, 10 Feb 2022 21:41:03 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzT2cx1o5JMs7VMOWCwzGsHA1oGktnK5f/g5wrBlZbEi8ZfHJV1PtgZpflHUjAvgefPOGvfRNR1EMudlMR8YO0=
X-Received: by 2002:a05:6512:3986:: with SMTP id
 j6mr111854lfu.84.1644558063470; 
 Thu, 10 Feb 2022 21:41:03 -0800 (PST)
MIME-Version: 1.0
References: <20220209122901.51790-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20220209122901.51790-1-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 11 Feb 2022 13:40:52 +0800
Message-ID: <CACGkMEs7jR7Y5QKLeSfwJNqOooqe2Pgcm-GeTqb9rgAyawPSrQ@mail.gmail.com>
Subject: Re: [PATCH v4 00/14] virtio pci support VIRTIO_F_RING_RESET
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: virtualization <virtualization@lists.linux-foundation.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
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

On Wed, Feb 9, 2022 at 8:29 PM Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
>
> The virtio spec already supports the virtio queue reset function. This patch set
> is to add this function to the kernel. The relevant virtio spec information is
> here:
>
>     https://github.com/oasis-tcs/virtio-spec/issues/124
>
> Also regarding MMIO support for queue reset, I plan to support it after this
> patch is passed.

So I had an idea, we can implement ethtool_set_ringparam() in this
series to get one real users.

But this came into another question: it looks to me current virito-net
just uses the maximum ring size, so it basically means we just can
decrease the number from startup, so I wonder how much value if we
don't limit the startup queue size to a dedicated value.

Thanks

>
> Please review. Thanks.
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
> Xuan Zhuo (14):
>   virtio_pci: struct virtio_pci_common_cfg add queue_notify_data
>   virtio: queue_reset: add VIRTIO_F_RING_RESET
>   virtio_ring: queue_reset: add function vring_setup_virtqueue()
>   virtio_ring: queue_reset: split: add __vring_init_virtqueue()
>   virtio_ring: queue_reset: split: support enable reset queue
>   virtio_ring: queue_reset: packed: support enable reset queue
>   virtio_ring: queue_reset: extract the release function of the vq ring
>   virtio_ring: queue_reset: add vring_release_virtqueue()
>   virtio: queue_reset: struct virtio_config_ops add callbacks for
>     queue_reset
>   virtio_pci: queue_reset: update struct virtio_pci_common_cfg and
>     option functions
>   virtio_pci: queue_reset: release vq by vp_dev->vqs
>   virtio_pci: queue_reset: setup_vq() support vring_setup_virtqueue()
>   virtio_pci: queue_reset: vp_setup_vq() support ring_num
>   virtio_pci: queue_reset: support VIRTIO_F_RING_RESET
>
>  drivers/virtio/virtio_pci_common.c     |  65 +++++++---
>  drivers/virtio/virtio_pci_common.h     |  11 +-
>  drivers/virtio/virtio_pci_legacy.c     |   5 +-
>  drivers/virtio/virtio_pci_modern.c     |  99 ++++++++++++--
>  drivers/virtio/virtio_pci_modern_dev.c |  36 +++++
>  drivers/virtio/virtio_ring.c           | 173 ++++++++++++++++++-------
>  include/linux/virtio.h                 |   6 +
>  include/linux/virtio_config.h          |  13 ++
>  include/linux/virtio_pci_modern.h      |   2 +
>  include/linux/virtio_ring.h            |  37 ++++--
>  include/uapi/linux/virtio_config.h     |   7 +-
>  include/uapi/linux/virtio_pci.h        |  14 ++
>  12 files changed, 375 insertions(+), 93 deletions(-)
>
> --
> 2.31.0
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
