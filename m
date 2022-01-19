Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D92BC433EF
	for <virtualization@archiver.kernel.org>; Wed, 19 Jan 2022 06:14:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id D0873403B4;
	Wed, 19 Jan 2022 06:14:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cFW492Wkndeu; Wed, 19 Jan 2022 06:14:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 44B53408F7;
	Wed, 19 Jan 2022 06:14:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 24DD4C0039;
	Wed, 19 Jan 2022 06:14:01 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BB1B7C002F
 for <virtualization@lists.linux-foundation.org>;
 Wed, 19 Jan 2022 06:13:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9B94A82726
 for <virtualization@lists.linux-foundation.org>;
 Wed, 19 Jan 2022 06:13:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id o1EsA-B2Bd9X
 for <virtualization@lists.linux-foundation.org>;
 Wed, 19 Jan 2022 06:13:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C4AED82725
 for <virtualization@lists.linux-foundation.org>;
 Wed, 19 Jan 2022 06:13:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1642572837;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=a03gbbuzXPNoimfa4arJZO3z67X1K6dLgkpCsTgVtIw=;
 b=XyNdggHltXlVZ2aG+AueGpdyhMMF5dxOGk3KHNpbNi0VmdBcZGUcNoL1pGTDf8LoWgxidO
 8oAqB3qO7IR7K3ky2vAjngATdzK84bz8R7HXG0pviaD5UL6B1Jm/Iz5n4jOgm9O70cwqLO
 YRBB5MHrbgk9XeVkhPytMK/FPwcgcbQ=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-194--4tjUh1AOeyv0uERsBdaMQ-1; Wed, 19 Jan 2022 01:13:51 -0500
X-MC-Unique: -4tjUh1AOeyv0uERsBdaMQ-1
Received: by mail-lf1-f72.google.com with SMTP id
 7-20020ac24827000000b0042e731a7bc7so817713lft.18
 for <virtualization@lists.linux-foundation.org>;
 Tue, 18 Jan 2022 22:13:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=a03gbbuzXPNoimfa4arJZO3z67X1K6dLgkpCsTgVtIw=;
 b=5IVI2vTCu7mYgYiBwAL/4P+QUOh+TyYSRFEPGU3WHZ4wmDddz6bON2EhmhOB6S+vAu
 PUFutdJ0zgm453aXuLslr1YpG3V4ZwiP0t87wYBTeJoxbL1Hh8GnZ1Rhlu4jgHIngkoM
 Zkels5OS6VIxO0UUtA6wswA2T9bCouMSIk8XyAoaTIld1qGHhHBYdHCcfyMJe0vQQXf4
 uPd3GPrgba9iWDAFaA5oZISouxWW6qQ6MZDKsLIKZH4r/06uAd0eqb4BnGMjB6U6r+ij
 JsMngDBaNoFZon3mN7Ye+/lNlOi3DWVlxT0XWjqZ8xsEzz2JtFudiKMkDwu6kQwIwcpy
 AsMg==
X-Gm-Message-State: AOAM5330nNS3QKLDFw2j19PW8F1pB5jblI7YYVL/i4L3EwI3ai0Qgzjh
 7VeDXuH1JUYlPDXoc5bOsGFefIyuZ1a/E6DHTACkoLecK4tYU5xF9h27RdbA6jCALrg+K3mn8Fv
 Vxv9rX8MT5N2f8VnEvuLfZXTftO5E/z9GNrrzXWwR2qeW1cZ0pb8uVDmyLQ==
X-Received: by 2002:a19:760f:: with SMTP id c15mr24488275lff.498.1642572830116; 
 Tue, 18 Jan 2022 22:13:50 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzMCVvKUr8D/8+7kcN4/GB5qy/GYGEIK8nal/k5z9qO5DeVAYzgSBHt0PQ9ojqrJcMTwo8DRReGPEupsDOOXgE=
X-Received: by 2002:a19:760f:: with SMTP id c15mr24488265lff.498.1642572829937; 
 Tue, 18 Jan 2022 22:13:49 -0800 (PST)
MIME-Version: 1.0
References: <20220119023543.91620-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20220119023543.91620-1-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 19 Jan 2022 14:13:39 +0800
Message-ID: <CACGkMEsaz+LLBVwg5X7JajYZGAhkTcz4sJLoXhkOOn24fqF5hQ@mail.gmail.com>
Subject: Re: [PATCH 0/6] virtio pci support VIRTIO_F_RING_RESET
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
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

On Wed, Jan 19, 2022 at 10:35 AM Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
>
> The virtio spec already supports the virtio queue reset function. This patch set
> is to add this function to the kernel. The relevant virtio spec information is
> here:
>
>     https://github.com/oasis-tcs/virtio-spec/issues/124
>
> virtio-net's queue disable/enable function based on virtio queue reset is here
>
>     https://github.com/fengidri/linux/commit/021165b4eda44f87c4b7771ef637bab2512d066f
>
> I plan to include this patch in the subsequent virtio-net support AF_XDP
> patch set.

It's better to send them all to see how the new helpers are actually used.

Thanks

>
> Also regarding MMIO support for queue reset, I plan to support it after this
> patch is passed.
>
> Please review. Thanks.
>
> Xuan Zhuo (6):
>   virtio: pci: struct virtio_pci_common_cfg add queue_notify_data
>   virtio: queue_reset: add VIRTIO_F_RING_RESET
>   virtio: queue_reset: pci: update struct virtio_pci_common_cfg and
>     option functions
>   virtio: queue_reset: pci: extract some functions for subsequent
>     patches
>   virtio: queue_reset: pci: support VIRTIO_F_RING_RESET
>   virtio: queue_reset: add helper
>
>  drivers/virtio/virtio_pci_common.c     | 140 +++++++++++++++++++------
>  drivers/virtio/virtio_pci_common.h     |   5 +
>  drivers/virtio/virtio_pci_modern.c     |  81 ++++++++++++++
>  drivers/virtio/virtio_pci_modern_dev.c |  28 +++++
>  include/linux/virtio_config.h          |  78 ++++++++++++++
>  include/linux/virtio_pci_modern.h      |   2 +
>  include/uapi/linux/virtio_config.h     |   7 +-
>  include/uapi/linux/virtio_pci.h        |   2 +
>  8 files changed, 310 insertions(+), 33 deletions(-)
>
> --
> 2.31.0
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
