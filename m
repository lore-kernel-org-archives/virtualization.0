Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6F11C001DE
	for <virtualization@archiver.kernel.org>; Tue,  1 Aug 2023 02:27:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 2BD444018F;
	Tue,  1 Aug 2023 02:27:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2BD444018F
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XCBznt92CKiC; Tue,  1 Aug 2023 02:27:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 94ED0400D7;
	Tue,  1 Aug 2023 02:27:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 94ED0400D7
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5D488C0072;
	Tue,  1 Aug 2023 02:27:43 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 03C32C0032
 for <virtualization@lists.linux-foundation.org>;
 Tue,  1 Aug 2023 02:27:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id CDFB381A5C
 for <virtualization@lists.linux-foundation.org>;
 Tue,  1 Aug 2023 02:27:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CDFB381A5C
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QCGByTZZeTu5
 for <virtualization@lists.linux-foundation.org>;
 Tue,  1 Aug 2023 02:27:40 +0000 (UTC)
Received: from out30-98.freemail.mail.aliyun.com
 (out30-98.freemail.mail.aliyun.com [115.124.30.98])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E026A818CA
 for <virtualization@lists.linux-foundation.org>;
 Tue,  1 Aug 2023 02:27:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E026A818CA
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R301e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018045176;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=14; SR=0;
 TI=SMTPD_---0VojLbbu_1690856850; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0VojLbbu_1690856850) by smtp.aliyun-inc.com;
 Tue, 01 Aug 2023 10:27:31 +0800
Message-ID: <1690855424.7821567-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH vhost v11 05/10] virtio_ring: introduce virtqueue_dma_dev()
Date: Tue, 1 Aug 2023 10:03:44 +0800
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
In-Reply-To: <20230731084651.16ec0a96@kernel.org>
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

On Mon, 31 Jul 2023 08:46:51 -0700, Jakub Kicinski <kuba@kernel.org> wrote:
> On Mon, 31 Jul 2023 09:23:29 +0800 Jason Wang wrote:
> > > I'd step back and ask you why do you want to use AF_XDP with virtio.
> > > Instead of bifurcating one virtio instance into different queues why
> > > not create a separate virtio instance?
> >
> > I'm not sure I get this, but do you mean a separate virtio device that
> > owns AF_XDP queues only? If I understand it correctly, bifurcating is
> > one of the key advantages of AF_XDP. What's more, current virtio
> > doesn't support being split at queue (pair) level. And it may still
> > suffer from the yes/no DMA API issue.
>
> I guess we should step even further back and ask Xuan what the use case
> is, because I'm not very sure. All we hear is "enable AF_XDP on virtio"
> but AF_XDP is barely used on real HW, so why?


Why just for real HW?

I want to enable AF_XDP on virtio-net. Then the user can send/recv packets by
AF_XDP bypass through the kernel. That has be used on large scale.

I donot know what is the problem of the virtio-net.
Why do you think that the virtio-net cannot work with AF_XDP?


>
> Bifurcating makes (used to make?) some sense in case of real HW when you
> had only one PCI function and had to subdivide it.

Sorry I do not get this.


> Virtio is either a SW
> construct or offloaded to very capable HW, so either way cost of
> creating an extra instance for DPDK or whatever else is very low.


The extra instance is virtio-net?

I think there is a gap. So let me give you a brief introduction of our case.

Firstly, we donot use dpdk. We use the AF_XDP, because of that the AF_XDP is
more simpler and easy to deploy for the nginx.

We use the AF_XDP to speedup the UDP of the quic. By the library, the APP just
needs some simple change.

On the AliYun, the net driver is virtio-net. So we want the virtio-net support
the AF_XDP.

I guess what you mean is that we can speed up through the cooperation of devices
and drivers, but our machines are public clouds, and we cannot change the
back-end devices of virtio under normal circumstances.

Here I do not know the different of the real hw and the virtio-net.


Thanks.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
