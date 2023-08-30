Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A7D0C83F15
	for <virtualization@archiver.kernel.org>; Wed, 30 Aug 2023 19:42:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id BFF6440474;
	Wed, 30 Aug 2023 19:42:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org BFF6440474
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Y0Neyw37
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fk8GLiZOLoli; Wed, 30 Aug 2023 19:42:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 38C4A40017;
	Wed, 30 Aug 2023 19:42:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 38C4A40017
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 124F7C0071;
	Wed, 30 Aug 2023 19:42:23 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 050D4C0032
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Aug 2023 19:42:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D1BDD418A6
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Aug 2023 19:42:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D1BDD418A6
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Y0Neyw37
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PXvCSb562YV6
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Aug 2023 19:42:21 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C629D41888
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Aug 2023 19:42:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C629D41888
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693424539;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3NjxVK/JrpkWvoiz6/GperXEOF12luau1rGvSVhj2Bc=;
 b=Y0Neyw37cqhxL7zIuvYqItLdK3B+qwyCY56J1Z0DijxQEkwAOU1pLmgrsym/MmGgHIf9Bx
 8J+AUhlyaul3Tehz4tMJ70N3nUvwgfnAAshlmroiNiCr4BVHk2SwmQaapDfb/cjBtVyGjr
 pa9HU8oMAeO8/FRXynzHUfPtQj3YVfE=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-29-kfFpEMxVO32Z9AsH_y7GkQ-1; Wed, 30 Aug 2023 15:42:18 -0400
X-MC-Unique: kfFpEMxVO32Z9AsH_y7GkQ-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-993eeb3a950so459421866b.2
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Aug 2023 12:42:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693424537; x=1694029337;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3NjxVK/JrpkWvoiz6/GperXEOF12luau1rGvSVhj2Bc=;
 b=ElkRQT7pG1KSX8PPJiTnj9EkK4HF33DWepg7rjMq+GbEgkZBS3iUAPUZ3pPrjbrihK
 0x6ejBPQn8UuPQmwpk1wYMG2K22a9RnBiHH4H2zzWr+Qq3AxCxjagfFig0efJQ9Bf/ue
 fxliFXvSteL5X4w68WJMmHHF34wVcOi8aQNotQhxhdQs6WyvARBSpqjXApTu4UUqz7GV
 t7Fh4E99V7SDr635/Ki2BW0c5eD7ZCPg00OIQjinF+D+1PkLyIGM4IernvCm1tQ9Y7Qu
 GAOY8g7RfoNxC9/Ydjw91d3OWQfzJJ5k65RQe7gkKdK8NqAIgS/gD19e0OeTyshjNqNk
 7YnA==
X-Gm-Message-State: AOJu0YxgeTmniOyyf3ocY7ty+6O414VPZl5IQtlJzugJ9hweT3gSaiCA
 BuFEDRrffDyh4D4/21HclsGwtYIA3hjnQ9py4fQZEBswPUmbrIwGDDkklFE33S5Jt2n7E1AxIMf
 rBHL35+SGrnCefuTTPl0TD9N/7BSgyHbTGxbiZ2IYmg==
X-Received: by 2002:a17:906:18d:b0:9a2:16a7:fd0 with SMTP id
 13-20020a170906018d00b009a216a70fd0mr2423107ejb.21.1693424537367; 
 Wed, 30 Aug 2023 12:42:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEPl2d8yog5OYYxnVfR719SFpTMzeSHrPCryTF2nxMjc68c11HQgd4yjH64I6CkiNALUEQ33w==
X-Received: by 2002:a17:906:18d:b0:9a2:16a7:fd0 with SMTP id
 13-20020a170906018d00b009a216a70fd0mr2423093ejb.21.1693424537027; 
 Wed, 30 Aug 2023 12:42:17 -0700 (PDT)
Received: from redhat.com ([2.55.167.22]) by smtp.gmail.com with ESMTPSA id
 z3-20020a1709064e0300b009a19fa8d2e9sm7490757eju.206.2023.08.30.12.42.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Aug 2023 12:42:16 -0700 (PDT)
Date: Wed, 30 Aug 2023 15:42:12 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next V1 0/4] virtio_net: add per queue interrupt
 coalescing support
Message-ID: <20230830154200-mutt-send-email-mst@kernel.org>
References: <20230710092005.5062-1-gavinl@nvidia.com>
 <20230713074001-mutt-send-email-mst@kernel.org>
 <1689300651.6874406-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <1689300651.6874406-1-xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: hawk@kernel.org, daniel@iogearbox.net, netdev@vger.kernel.org,
 john.fastabend@gmail.com, ast@kernel.org, edumazet@google.com,
 Gavin Li <gavinl@nvidia.com>, jiri@nvidia.com, kuba@kernel.org,
 bpf@vger.kernel.org, pabeni@redhat.com,
 virtualization@lists.linux-foundation.org, davem@davemloft.net,
 linux-kernel@vger.kernel.org
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

On Fri, Jul 14, 2023 at 10:10:51AM +0800, Xuan Zhuo wrote:
> On Thu, 13 Jul 2023 07:40:12 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > On Mon, Jul 10, 2023 at 12:20:01PM +0300, Gavin Li wrote:
> > > Currently, coalescing parameters are grouped for all transmit and receive
> > > virtqueues. This patch series add support to set or get the parameters for
> > > a specified virtqueue.
> > >
> > > When the traffic between virtqueues is unbalanced, for example, one virtqueue
> > > is busy and another virtqueue is idle, then it will be very useful to
> > > control coalescing parameters at the virtqueue granularity.
> >
> > series:
> >
> > Acked-by: Michael S. Tsirkin <mst@redhat.com>
> 
> 
> Why?
> 
> This series has the bug I reported.
> 
> Are you thinking that is ok? Or this is not a bug?
> 
> Thanks.
> 
> 


I missed that mail. What's the bug?

> >
> >
> >
> > > Example command:
> > > $ ethtool -Q eth5 queue_mask 0x1 --coalesce tx-packets 10
> > > Would set max_packets=10 to VQ 1.
> > > $ ethtool -Q eth5 queue_mask 0x1 --coalesce rx-packets 10
> > > Would set max_packets=10 to VQ 0.
> > > $ ethtool -Q eth5 queue_mask 0x1 --show-coalesce
> > >  Queue: 0
> > >  Adaptive RX: off  TX: off
> > >  stats-block-usecs: 0
> > >  sample-interval: 0
> > >  pkt-rate-low: 0
> > >  pkt-rate-high: 0
> > >
> > >  rx-usecs: 222
> > >  rx-frames: 0
> > >  rx-usecs-irq: 0
> > >  rx-frames-irq: 256
> > >
> > >  tx-usecs: 222
> > >  tx-frames: 0
> > >  tx-usecs-irq: 0
> > >  tx-frames-irq: 256
> > >
> > >  rx-usecs-low: 0
> > >  rx-frame-low: 0
> > >  tx-usecs-low: 0
> > >  tx-frame-low: 0
> > >
> > >  rx-usecs-high: 0
> > >  rx-frame-high: 0
> > >  tx-usecs-high: 0
> > >  tx-frame-high: 0
> > >
> > > In this patch series:
> > > Patch-1: Extract interrupt coalescing settings to a structure.
> > > Patch-2: Extract get/set interrupt coalesce to a function.
> > > Patch-3: Support per queue interrupt coalesce command.
> > > Patch-4: Enable per queue interrupt coalesce feature.
> > >
> > > Gavin Li (4):
> > >   virtio_net: extract interrupt coalescing settings to a structure
> > >   virtio_net: extract get/set interrupt coalesce to a function
> > >   virtio_net: support per queue interrupt coalesce command
> > >   virtio_net: enable per queue interrupt coalesce feature
> > >
> > >  drivers/net/virtio_net.c        | 169 ++++++++++++++++++++++++++------
> > >  include/uapi/linux/virtio_net.h |  14 +++
> > >  2 files changed, 154 insertions(+), 29 deletions(-)
> > >
> > > --
> > > 2.39.1
> >

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
