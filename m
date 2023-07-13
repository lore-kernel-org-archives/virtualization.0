Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2275AEB64DD
	for <virtualization@archiver.kernel.org>; Thu, 13 Jul 2023 11:40:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8F56542063;
	Thu, 13 Jul 2023 11:40:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8F56542063
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=iP9hSc1U
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hayR7X1DSQTP; Thu, 13 Jul 2023 11:40:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id A19F04204D;
	Thu, 13 Jul 2023 11:40:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A19F04204D
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6DF8DC0072;
	Thu, 13 Jul 2023 11:40:26 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DEC85C0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Jul 2023 11:40:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B2F3C4170A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Jul 2023 11:40:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B2F3C4170A
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=iP9hSc1U
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JbaKZOOSLih1
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Jul 2023 11:40:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E138E400C7
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E138E400C7
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Jul 2023 11:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689248422;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=guFh+wPFNIRuesCzeZY5yldfMavaJ0y5Zd0rOUtQc9o=;
 b=iP9hSc1ULDI7yiY/4xVEqrIQhN/vsFwx5NrkwF0VJBnciSVdioYuNi3Qxy2g2TvFRXwETh
 4D4v+WK+iK2OwTgE4aTwdcFi1jt93EHF66YEpCYXzB+YGoUfkGj/37nniywnU3MWNdlLZ6
 hwliCIS+8pQxe+EPKkkKf4XbNWGZ9PA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-376-VHVzJ6HuNuSkgpzA8a2IiQ-1; Thu, 13 Jul 2023 07:40:18 -0400
X-MC-Unique: VHVzJ6HuNuSkgpzA8a2IiQ-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-3fbfc766a78so3176595e9.3
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Jul 2023 04:40:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689248417; x=1691840417;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=guFh+wPFNIRuesCzeZY5yldfMavaJ0y5Zd0rOUtQc9o=;
 b=R2rVyzNWTEzNYkI6HWvEQlaJI1YvweY84Ab82/je+8NEZ3dU7ACOgv04+wIM0yi9D+
 wOWQizwwMDrwcdLAYKPKKZ+Q0USzUM/oyVm8KlWFRlYYvOu1D1PG0SVNrLRL+f6Hq3EM
 O/9wo2CrZqviJiGPj7bVxvdy3dlQyKV1F0Yb2ueVSezvPCCEHcb79my9/1V5AebK/2AZ
 3nvrHPa3g7KqgfQituBdmfGW9l8ZV8cn40DFhDU2oMciKzO3UYbRsHcz4ZP3C4SrOBwT
 2tUdC+pgc9428XZ4YTvkTBaMOLOqsCJqef55zEos4V1tYTkyQEnxvayBseR1ChSTI5za
 D7sQ==
X-Gm-Message-State: ABy/qLY+sLh8iXnDyp8BuUS2Z7Pq2mqz9DtUFyopTlvDsgkS2Ldm/Zfy
 eHtg30MPAB4qI4GKMWsOZk2oeZQE69IshdOxcOAD9sLmXs+Tbxtf2Qz8pGJBPO/PiPs54XWNhy6
 nBIpOhbE0I0JS6hGZTNjMmMr/O2/hSES0Y9y7roehzA==
X-Received: by 2002:a05:600c:240d:b0:3fb:b5dc:dab1 with SMTP id
 13-20020a05600c240d00b003fbb5dcdab1mr1150134wmp.39.1689248417231; 
 Thu, 13 Jul 2023 04:40:17 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHd/eNeg4sLyvuXqL+tXWMQGEDTMZBr/VxoDrK+A9Qk8/hmWz5tdxZsKTFz4SAT52dsIuaXmA==
X-Received: by 2002:a05:600c:240d:b0:3fb:b5dc:dab1 with SMTP id
 13-20020a05600c240d00b003fbb5dcdab1mr1150120wmp.39.1689248416901; 
 Thu, 13 Jul 2023 04:40:16 -0700 (PDT)
Received: from redhat.com ([2.52.158.233]) by smtp.gmail.com with ESMTPSA id
 v21-20020a7bcb55000000b003fba9db141esm18158573wmj.38.2023.07.13.04.40.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Jul 2023 04:40:16 -0700 (PDT)
Date: Thu, 13 Jul 2023 07:40:12 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Gavin Li <gavinl@nvidia.com>
Subject: Re: [PATCH net-next V1 0/4] virtio_net: add per queue interrupt
 coalescing support
Message-ID: <20230713074001-mutt-send-email-mst@kernel.org>
References: <20230710092005.5062-1-gavinl@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20230710092005.5062-1-gavinl@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: xuanzhuo@linux.alibaba.com, hawk@kernel.org, daniel@iogearbox.net,
 netdev@vger.kernel.org, john.fastabend@gmail.com, ast@kernel.org,
 edumazet@google.com, jiri@nvidia.com, kuba@kernel.org, bpf@vger.kernel.org,
 pabeni@redhat.com, virtualization@lists.linux-foundation.org,
 davem@davemloft.net, linux-kernel@vger.kernel.org
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

On Mon, Jul 10, 2023 at 12:20:01PM +0300, Gavin Li wrote:
> Currently, coalescing parameters are grouped for all transmit and receive
> virtqueues. This patch series add support to set or get the parameters for
> a specified virtqueue.
> 
> When the traffic between virtqueues is unbalanced, for example, one virtqueue
> is busy and another virtqueue is idle, then it will be very useful to
> control coalescing parameters at the virtqueue granularity.

series:

Acked-by: Michael S. Tsirkin <mst@redhat.com>



> Example command:
> $ ethtool -Q eth5 queue_mask 0x1 --coalesce tx-packets 10
> Would set max_packets=10 to VQ 1.
> $ ethtool -Q eth5 queue_mask 0x1 --coalesce rx-packets 10
> Would set max_packets=10 to VQ 0.
> $ ethtool -Q eth5 queue_mask 0x1 --show-coalesce
>  Queue: 0
>  Adaptive RX: off  TX: off
>  stats-block-usecs: 0
>  sample-interval: 0
>  pkt-rate-low: 0
>  pkt-rate-high: 0
> 
>  rx-usecs: 222
>  rx-frames: 0
>  rx-usecs-irq: 0
>  rx-frames-irq: 256
> 
>  tx-usecs: 222
>  tx-frames: 0
>  tx-usecs-irq: 0
>  tx-frames-irq: 256
> 
>  rx-usecs-low: 0
>  rx-frame-low: 0
>  tx-usecs-low: 0
>  tx-frame-low: 0
> 
>  rx-usecs-high: 0
>  rx-frame-high: 0
>  tx-usecs-high: 0
>  tx-frame-high: 0
> 
> In this patch series:
> Patch-1: Extract interrupt coalescing settings to a structure.
> Patch-2: Extract get/set interrupt coalesce to a function.
> Patch-3: Support per queue interrupt coalesce command.
> Patch-4: Enable per queue interrupt coalesce feature.
> 
> Gavin Li (4):
>   virtio_net: extract interrupt coalescing settings to a structure
>   virtio_net: extract get/set interrupt coalesce to a function
>   virtio_net: support per queue interrupt coalesce command
>   virtio_net: enable per queue interrupt coalesce feature
> 
>  drivers/net/virtio_net.c        | 169 ++++++++++++++++++++++++++------
>  include/uapi/linux/virtio_net.h |  14 +++
>  2 files changed, 154 insertions(+), 29 deletions(-)
> 
> -- 
> 2.39.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
