Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D7D5C636D4
	for <virtualization@archiver.kernel.org>; Mon, 13 Feb 2023 12:14:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id F2DFB4060C;
	Mon, 13 Feb 2023 12:14:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org F2DFB4060C
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=HVxH9oJ/
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UsG8TdwQjKz2; Mon, 13 Feb 2023 12:14:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 605CE403EA;
	Mon, 13 Feb 2023 12:14:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 605CE403EA
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 439A0C0032;
	Mon, 13 Feb 2023 12:14:18 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 581AEC002B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Feb 2023 12:14:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2C367410DF
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Feb 2023 12:14:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2C367410DF
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=HVxH9oJ/
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rzg4bvpTC6Jy
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Feb 2023 12:14:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 22B1340629
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 22B1340629
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Feb 2023 12:14:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1676290454;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oeKUhJ47kuIa1giwunE6XHk8Ozo1R+YBkI35wsuG/UQ=;
 b=HVxH9oJ/GDqXupHWHM9EDJ4voGxh+5EpR6pdlr9BR1/BhHb4Kq//6wVGjKB02QZlZCGx+K
 7btDcIcNaysYdn7GdbymPVYHFEaGQSz3TF+SWIajh4YFVUsoHgmgzIpc/5aVsyw3L7Fsfg
 +CvlIR/+0V7Pg9xf8+155kDZOVE9ZOw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-670-Xu2d6b0VOYGZTfD8XKWL9A-1; Mon, 13 Feb 2023 07:14:12 -0500
X-MC-Unique: Xu2d6b0VOYGZTfD8XKWL9A-1
Received: by mail-wm1-f69.google.com with SMTP id
 r14-20020a05600c35ce00b003e10bfcd160so6743776wmq.6
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Feb 2023 04:14:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oeKUhJ47kuIa1giwunE6XHk8Ozo1R+YBkI35wsuG/UQ=;
 b=xqxG4f6NjBqQXKxCssdZno186OmXlUiZSKhtfJz02i7SRPb9MrYJLbrVQAm0ld1cfB
 O+Fk24Aad4qswknziELVsHMqIoZ8aNrQljfB3IGU/hx3IEZxkEDS6zMx7emnKh90zA6X
 3rJyK68apjyc17cKQDqxaiHGBNg30K5O48NEzGcGYPkaN18w8iTx4kC5XNB/8I050Fju
 uFXrsSjgaPCbWTBbv5BmE1eldx+Phlt+fCJugUqHMxgVXjyZeEOzZm2kM8ga/NMTRHyN
 10bFDSFfVUN2HoMhTys2sE593GMpRfC9/jD0+QOGefTe7W7uM2wLqgQx/VWTFhcLR5om
 eDZw==
X-Gm-Message-State: AO0yUKXkNXhH21gc+UTPdCq3g7hagttj7pFEPUfbJpzJAL02oiLWH30C
 cmZjXOZcZO6l0UpS88SXwuDrAJi63vtQALfstEGUcj+eWZfeonw047TMu7E1/lwoBotVfNNjgke
 GClGKEKhMGIsbuJwMNb+/NdK5Y4pUBaqStA2b8uw59w==
X-Received: by 2002:a5d:6805:0:b0:2c5:5886:8505 with SMTP id
 w5-20020a5d6805000000b002c558868505mr2644585wru.53.1676290451749; 
 Mon, 13 Feb 2023 04:14:11 -0800 (PST)
X-Google-Smtp-Source: AK7set8zRUxN2ig0D8GPy5vqM46LPVnmz4Mz8yPLO/l25VAgcGxc7IfVbeSwjm4uNe1CdrT8idz/FA==
X-Received: by 2002:a5d:6805:0:b0:2c5:5886:8505 with SMTP id
 w5-20020a5d6805000000b002c558868505mr2644557wru.53.1676290451543; 
 Mon, 13 Feb 2023 04:14:11 -0800 (PST)
Received: from redhat.com ([2.52.132.212]) by smtp.gmail.com with ESMTPSA id
 q14-20020a5d574e000000b002bfb02153d1sm10468168wrw.45.2023.02.13.04.14.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Feb 2023 04:14:10 -0800 (PST)
Date: Mon, 13 Feb 2023 07:14:05 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH 00/33] virtio-net: support AF_XDP zero copy
Message-ID: <20230213071148-mutt-send-email-mst@kernel.org>
References: <20230202110058.130695-1-xuanzhuo@linux.alibaba.com>
 <5fda6140fa51b4d2944f77b9e24446e4625641e2.camel@redhat.com>
 <1675395211.6279888-2-xuanzhuo@linux.alibaba.com>
 <20230203034212-mutt-send-email-mst@kernel.org>
 <1675651276.3841548-3-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <1675651276.3841548-3-xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Petr Machata <petrm@nvidia.com>, Menglong Dong <imagedong@tencent.com>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
 John Fastabend <john.fastabend@gmail.com>,
 =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Kuniyuki Iwashima <kuniyu@amazon.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Jonathan Lemon <jonathan.lemon@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
 bpf@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
 virtualization@lists.linux-foundation.org,
 "David S. Miller" <davem@davemloft.net>,
 Magnus Karlsson <magnus.karlsson@intel.com>
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

On Mon, Feb 06, 2023 at 10:41:16AM +0800, Xuan Zhuo wrote:
> On Fri, 3 Feb 2023 04:17:59 -0500, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > On Fri, Feb 03, 2023 at 11:33:31AM +0800, Xuan Zhuo wrote:
> > > On Thu, 02 Feb 2023 15:41:44 +0100, Paolo Abeni <pabeni@redhat.com> wrote:
> > > > On Thu, 2023-02-02 at 19:00 +0800, Xuan Zhuo wrote:
> > > > > XDP socket(AF_XDP) is an excellent bypass kernel network framework. The zero
> > > > > copy feature of xsk (XDP socket) needs to be supported by the driver. The
> > > > > performance of zero copy is very good. mlx5 and intel ixgbe already support
> > > > > this feature, This patch set allows virtio-net to support xsk's zerocopy xmit
> > > > > feature.
> > > > >
> > > > > Virtio-net did not support per-queue reset, so it was impossible to support XDP
> > > > > Socket Zerocopy. At present, we have completed the work of Virtio Spec and
> > > > > Kernel in Per-Queue Reset. It is time for Virtio-Net to complete the support for
> > > > > the XDP Socket Zerocopy.
> > > > >
> > > > > Virtio-net can not increase the queue at will, so xsk shares the queue with
> > > > > kernel.
> > > > >
> > > > > On the other hand, Virtio-Net does not support generate interrupt manually, so
> > > > > when we wakeup tx xmit, we used some tips. If the CPU run by TX NAPI last time
> > > > > is other CPUs, use IPI to wake up NAPI on the remote CPU. If it is also the
> > > > > local CPU, then we wake up sofrirqd.
> > > >
> > > > Thank you for the large effort.
> > > >
> > > > Since this will likely need a few iterations, on next revision please
> > > > do split the work in multiple chunks to help the reviewer efforts -
> > > > from Documentation/process/maintainer-netdev.rst:
> > > >
> > > >  - don't post large series (> 15 patches), break them up
> > > >
> > > > In this case I guess you can split it in 1 (or even 2) pre-req series
> > > > and another one for the actual xsk zero copy support.
> > >
> > >
> > > OK.
> > >
> > > I can split patch into multiple parts such as
> > >
> > > * virtio core
> > > * xsk
> > > * virtio-net prepare
> > > * virtio-net support xsk zerocopy
> > >
> > > However, there is a problem, the virtio core part should enter the VHOST branch
> > > of Michael. Then, should I post follow-up patches to which branch vhost or
> > > next-next?
> > >
> > > Thanks.
> > >
> >
> > Here are some ideas on how to make the patchset smaller
> > and easier to merge:
> > - keep everything in virtio_net.c for now. We can split
> >   things out later, but this way your patchset will not
> >   conflict with every since change merged meanwhile.
> >   Also, split up needs to be done carefully with sane
> >   APIs between components, let's maybe not waste time
> >   on that now, do the split-up later.
> > - you have patches that add APIs then other
> >   patches use them. as long as it's only virtio net just
> >   add and use in a single patch, review is actually easier this way.
> 
> I will try to merge #16-#18 and #20-#23.

don't do the code reorg thing for now either.

leave this for later.

> 
> > - we can try merging pre-requisites earlier, then patchset
> >   size will shrink.
> 
> Do you mean the patches of virtio core? Should we put these
> patches to vhost branch?
> 
> Thanks.

I can merge patches 1-8, yes.
This patchset probably missed the merge window anyway.


> >
> >
> > > >
> > > > Thanks!
> > > >
> > > > Paolo
> > > >
> >

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
