Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68645EC8
	for <virtualization@lists.linux-foundation.org>; Thu, 11 Jan 2024 03:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S0es7WoO"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E6CCC613DF
	for <virtualization@lists.linux-foundation.org>; Thu, 11 Jan 2024 03:27:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E6CCC613DF
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=S0es7WoO
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -0.599
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fhLzfkRWW2x3
	for <virtualization@lists.linux-foundation.org>;
	Thu, 11 Jan 2024 03:27:37 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp3.osuosl.org (Postfix) with ESMTPS id C59B9611CE
	for <virtualization@lists.linux-foundation.org>; Thu, 11 Jan 2024 03:27:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C59B9611CE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704943655;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AUSAkkLrb0z3ZgTRvc5R86FhRwLBEg1Wd5G+5voljgI=;
	b=S0es7WoOYFLJm9j9L7fGF3SAMcfeL1H2HLl0PkaOZqz3aKgr/NjMS9c5ORMRHOm/NffCox
	RfYwprHAtmaC7cr7Av+CBiAKiOMNn7FmjmugsN46jFKqwHyz4tqRrlrcYcUS5fabQnVdFm
	iYW9FjDPwEX7RQGMuKidph8qNCHs6I8=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-111-r4QpojUoOFOcFNZstuAqQg-1; Wed, 10 Jan 2024 22:27:34 -0500
X-MC-Unique: r4QpojUoOFOcFNZstuAqQg-1
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-3bd3af050ddso4453992b6e.2
        for <virtualization@lists.linux-foundation.org>; Wed, 10 Jan 2024 19:27:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704943652; x=1705548452;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AUSAkkLrb0z3ZgTRvc5R86FhRwLBEg1Wd5G+5voljgI=;
        b=aQtEFes369RxeAdyl9mFZe05Vftc7lb/7u8JTraEn2GmT5sazGeC2bIps/KvjdkmBW
         oamDRd3lR9ih85NgrLx5SEHn+iJ+Ay8R+Oj4QqQghmAfF0AdgA/Odi5hcfndZ0rot4U9
         oSe2wthaTdS0lGg3f9UOODb3Zz5s5NAMoXj8ze2pJUYLbx6CDDLc+bCFYYhgSFeLxODy
         i9gBTh0HbmRzzSKbAn4d0hZkQehl8y0AxmKZmVEZN1lELIhw2vbIgOk5QjO0vD2V2XRc
         SLn2h2aw8gXeCJ9OCgklp8YXl6pe9xg6qyhtTa0M0OBLdS4fiwBz4oabHlm3W5L0/gj2
         lh1w==
X-Gm-Message-State: AOJu0YwL+GHM7Ht3R3U6UdbMM7G9g3ATkswGZo6fdRf78eCrcNUYYJgi
	q5BsDnK1GlxaPZXPy5HRN32D79Z73c3jL0P/vyxzN0fFB8EHCFaZqsdp1hzP0aXvco/H02n8mOs
	IeRpIaVEKc6uLiti3M5Jp63sRDxkhJHeH/BWJ1xiUh5rZRKqKslvwsxfzBuuAl3+chw==
X-Received: by 2002:a05:6808:2f10:b0:3bd:3ce8:2377 with SMTP id gu16-20020a0568082f1000b003bd3ce82377mr1008848oib.114.1704943652663;
        Wed, 10 Jan 2024 19:27:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEs8BJSRABz8aEdKyp40req/7d+/7A982/3ciC8ZpjhwQIZZsbp4MHstORlvr74V2fg98eAbKEU0qT16NyDo70=
X-Received: by 2002:a05:6808:2f10:b0:3bd:3ce8:2377 with SMTP id
 gu16-20020a0568082f1000b003bd3ce82377mr1008825oib.114.1704943652388; Wed, 10
 Jan 2024 19:27:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20231229073108.57778-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20231229073108.57778-1-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 11 Jan 2024 11:27:19 +0800
Message-ID: <CACGkMEsExWq6wn7rLxqbL6o4aTiu7fm8yDN36qdtd1K9aeyHVw@mail.gmail.com>
Subject: Re: [PATCH net-next v3 00/27] virtio-net: support AF_XDP zero copy
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	virtualization@lists.linux-foundation.org, bpf@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 29, 2023 at 3:31=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> ## AF_XDP
>
> XDP socket(AF_XDP) is an excellent bypass kernel network framework. The z=
ero
> copy feature of xsk (XDP socket) needs to be supported by the driver. The
> performance of zero copy is very good. mlx5 and intel ixgbe already suppo=
rt
> this feature, This patch set allows virtio-net to support xsk's zerocopy =
xmit
> feature.
>
> At present, we have completed some preparation:
>
> 1. vq-reset (virtio spec and kernel code)
> 2. virtio-core premapped dma
> 3. virtio-net xdp refactor
>
> So it is time for Virtio-Net to complete the support for the XDP Socket
> Zerocopy.
>
> Virtio-net can not increase the queue num at will, so xsk shares the queu=
e with
> kernel.
>
> On the other hand, Virtio-Net does not support generate interrupt from dr=
iver
> manually, so when we wakeup tx xmit, we used some tips. If the CPU run by=
 TX
> NAPI last time is other CPUs, use IPI to wake up NAPI on the remote CPU. =
If it
> is also the local CPU, then we wake up napi directly.
>
> This patch set includes some refactor to the virtio-net to let that to su=
pport
> AF_XDP.
>
> ## performance
>
> ENV: Qemu with vhost-user(polling mode).
> Host CPU: Intel(R) Xeon(R) Platinum 8163 CPU @ 2.50GHz
>
> ### virtio PMD in guest with testpmd
>
> testpmd> show port stats all
>
>  ######################## NIC statistics for port 0 #####################=
###
>  RX-packets: 19531092064 RX-missed: 0     RX-bytes: 1093741155584
>  RX-errors: 0
>  RX-nombuf: 0
>  TX-packets: 5959955552 TX-errors: 0     TX-bytes: 371030645664
>
>
>  Throughput (since last show)
>  Rx-pps:   8861574     Rx-bps:  3969985208
>  Tx-pps:   8861493     Tx-bps:  3969962736
>  ########################################################################=
####
>
> ### AF_XDP PMD in guest with testpmd
>
> testpmd> show port stats all
>
>   ######################## NIC statistics for port 0  ###################=
#####
>   RX-packets: 68152727   RX-missed: 0          RX-bytes:  3816552712
>   RX-errors: 0
>   RX-nombuf:  0
>   TX-packets: 68114967   TX-errors: 33216      TX-bytes:  3814438152
>
>   Throughput (since last show)
>   Rx-pps:      6333196          Rx-bps:   2837272088
>   Tx-pps:      6333227          Tx-bps:   2837285936
>   #######################################################################=
#####
>
> But AF_XDP consumes more CPU for tx and rx napi(100% and 86%).
>
> ## maintain
>
> I am currently a reviewer for virtio-net. I commit to maintain AF_XDP sup=
port in
> virtio-net.
>
> Please review.
>
> Thanks.
>
> v3
>     1. virtio introduces helpers for virtio-net sq using premapped dma
>     2. xsk has more complete support for merge mode
>     3. fix some problems
>
> v2
>     1. wakeup uses the way of GVE. No send ipi to wakeup napi on remote c=
pu.
>     2. remove rcu. Because we synchronize all operat, so the rcu is not n=
eeded.
>     3. split the commit "move to virtio_net.h" in last patch set. Just mo=
ve the
>        struct/api to header when we use them.
>     4. add comments for some code
>
> v1:
>     1. remove two virtio commits. Push this patchset to net-next
>     2. squash "virtio_net: virtnet_poll_tx support rescheduled" to xsk: s=
upport tx
>     3. fix some warnings
>
>
>
> Xuan Zhuo (27):
>   virtio_net: rename free_old_xmit_skbs to free_old_xmit
>   virtio_net: unify the code for recycling the xmit ptr
>   virtio_net: independent directory
>   virtio_net: move core structures to virtio_net.h
>   virtio_net: add prefix virtnet to all struct inside virtio_net.h
>   virtio_ring: introduce virtqueue_get_buf_ctx_dma()
>   virtio_ring: virtqueue_disable_and_recycle let the callback detach
>     bufs
>   virtio_ring: introduce virtqueue_detach_unused_buf_dma()
>   virtio_ring: introduce virtqueue_get_dma_premapped()
>   virtio_net: sq support premapped mode
>   virtio_net: separate virtnet_rx_resize()
>   virtio_net: separate virtnet_tx_resize()
>   virtio_net: xsk: bind/unbind xsk
>   virtio_net: xsk: prevent disable tx napi
>   virtio_net: move some api to header
>   virtio_net: xsk: tx: support xmit xsk buffer
>   virtio_net: xsk: tx: support wakeup
>   virtio_net: xsk: tx: handle the transmitted xsk buffer
>   virtio_net: xsk: tx: free the unused xsk buffer
>   virtio_net: separate receive_mergeable
>   virtio_net: separate receive_buf
>   virtio_net: xsk: rx: support fill with xsk buffer
>   virtio_net: xsk: rx: support recv merge mode
>   virtio_net: xsk: rx: support recv small mode
>   virtio_net: xsk: rx: free the unused xsk buffer
>   virtio_net: update tx timeout record
>   virtio_net: xdp_features add NETDEV_XDP_ACT_XSK_ZEROCOPY

Hi Xuan:

This series seems too huge to be reviewed easily.

I'd suggest to split it to be multiple series (as suggested by
https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#tl-dr)

Thanks

>
>  MAINTAINERS                                 |   2 +-
>  drivers/net/Kconfig                         |   8 +-
>  drivers/net/Makefile                        |   2 +-
>  drivers/net/virtio/Kconfig                  |  13 +
>  drivers/net/virtio/Makefile                 |   8 +
>  drivers/net/{virtio_net.c =3D> virtio/main.c} | 806 +++++++++-----------
>  drivers/net/virtio/virtio_net.h             | 337 ++++++++
>  drivers/net/virtio/xsk.c                    | 626 +++++++++++++++
>  drivers/net/virtio/xsk.h                    |  32 +
>  drivers/virtio/virtio_ring.c                | 235 ++++--
>  include/linux/virtio.h                      |  22 +-
>  11 files changed, 1582 insertions(+), 509 deletions(-)
>  create mode 100644 drivers/net/virtio/Kconfig
>  create mode 100644 drivers/net/virtio/Makefile
>  rename drivers/net/{virtio_net.c =3D> virtio/main.c} (90%)
>  create mode 100644 drivers/net/virtio/virtio_net.h
>  create mode 100644 drivers/net/virtio/xsk.c
>  create mode 100644 drivers/net/virtio/xsk.h
>
> --
> 2.32.0.3.g01195cf9f
>

