Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6FF6C001DF
	for <virtualization@archiver.kernel.org>; Tue,  1 Aug 2023 03:15:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 56FD94058B;
	Tue,  1 Aug 2023 03:15:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 56FD94058B
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SBIK1bYzq3t6; Tue,  1 Aug 2023 03:15:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 94D6F4026E;
	Tue,  1 Aug 2023 03:15:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 94D6F4026E
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6F76FC0071;
	Tue,  1 Aug 2023 03:15:23 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 21DF3C0032
 for <virtualization@lists.linux-foundation.org>;
 Tue,  1 Aug 2023 03:15:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E6ECE60E29
 for <virtualization@lists.linux-foundation.org>;
 Tue,  1 Aug 2023 03:15:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E6ECE60E29
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wrr-f11MYnu0
 for <virtualization@lists.linux-foundation.org>;
 Tue,  1 Aug 2023 03:15:20 +0000 (UTC)
Received: from out30-101.freemail.mail.aliyun.com
 (out30-101.freemail.mail.aliyun.com [115.124.30.101])
 by smtp3.osuosl.org (Postfix) with ESMTPS id DFB716109B
 for <virtualization@lists.linux-foundation.org>;
 Tue,  1 Aug 2023 03:15:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org DFB716109B
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R251e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046050;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=14; SR=0;
 TI=SMTPD_---0Vojog7j_1690859708; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0Vojog7j_1690859708) by smtp.aliyun-inc.com;
 Tue, 01 Aug 2023 11:15:09 +0800
Message-ID: <1690858650.8698683-2-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH vhost v11 05/10] virtio_ring: introduce virtqueue_dma_dev()
Date: Tue, 1 Aug 2023 10:57:30 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jakub Kicinski <kuba@kernel.org>
References: <20230710034237.12391-1-xuanzhuo@linux.alibaba.com>
 <20230710034237.12391-6-xuanzhuo@linux.alibaba.com>
 <ZK/cxNHzI23I6efc@infradead.org>
 <20230713104805-mutt-send-email-mst@kernel.org>
 <ZLjSsmTfcpaL6H/I@infradead.org>
 <20230720131928-mutt-send-email-mst@kernel.org>
 <ZL6qPvd6X1CgUD4S@infradead.org>
 <1690251228.3455179-1-xuanzhuo@linux.alibaba.com>
 <20230725033321-mutt-send-email-mst@kernel.org>
 <1690283243.4048996-1-xuanzhuo@linux.alibaba.com>
 <1690524153.3603117-1-xuanzhuo@linux.alibaba.com>
 <20230728080305.5fe3737c@kernel.org>
 <CACGkMEs5uc=ct8BsJzV2SEJzAGXqCP__yxo-MBa6d6JzDG4YOg@mail.gmail.com>
 <20230731084651.16ec0a96@kernel.org>
 <1690855424.7821567-1-xuanzhuo@linux.alibaba.com>
 <20230731193606.25233ed9@kernel.org>
In-Reply-To: <20230731193606.25233ed9@kernel.org>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, "Michael S. Tsirkin" <mst@redhat.com>,
 netdev@vger.kernel.org, John Fastabend <john.fastabend@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, virtualization@lists.linux-foundation.org,
 Christoph Hellwig <hch@infradead.org>, Eric Dumazet <edumazet@google.com>,
 bpf@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
 "David S.  Miller" <davem@davemloft.net>
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Mon, 31 Jul 2023 19:36:06 -0700, Jakub Kicinski <kuba@kernel.org> wrote:
> On Tue, 1 Aug 2023 10:03:44 +0800 Xuan Zhuo wrote:
> > > Virtio is either a SW
> > > construct or offloaded to very capable HW, so either way cost of
> > > creating an extra instance for DPDK or whatever else is very low.
> >
> > The extra instance is virtio-net?
> >
> > I think there is a gap. So let me give you a brief introduction of our case.
> >
> > Firstly, we donot use dpdk. We use the AF_XDP, because of that the AF_XDP is
> > more simpler and easy to deploy for the nginx.
> >
> > We use the AF_XDP to speedup the UDP of the quic. By the library, the APP just
> > needs some simple change.
> >
> > On the AliYun, the net driver is virtio-net. So we want the virtio-net support
> > the AF_XDP.
> >
> > I guess what you mean is that we can speed up through the cooperation of devices
> > and drivers, but our machines are public clouds, and we cannot change the
> > back-end devices of virtio under normal circumstances.
> >
> > Here I do not know the different of the real hw and the virtio-net.
>
> You have this working and benchmarked or this is just and idea?

This is not just an idea. I said that has been used on large scale.

This is the library for the APP to use the AF_XDP. We has open it.
https://gitee.com/anolis/libxudp

This is the Alibaba version of the nginx. That has been opened, that supported
to work with the libray to use AF_XDP.
http://tengine.taobao.org/

I supported this on our kernel release Anolis/Alinux.

The work was done about 2 years ago. You know, I pushed the first version to
enable AF_XDP on virtio-net about two years ago. I never thought the job would
be so difficult.

The nic (virtio-net) of AliYun can reach 24,000,000PPS.
So I think there is no different with the real HW on the performance.

With the AF_XDP, the UDP pps is seven times that of the kernel udp stack.

>
> What about io_uring zero copy w/ pre-registered buffers.
> You'll get csum offload, GSO, all the normal perf features.

We tried io-uring, but it was not suitable for our scenario.

Yes, now the AF_XDP does not support the csum offload and GSO.
This is indeed a small problem.

Thanks.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
