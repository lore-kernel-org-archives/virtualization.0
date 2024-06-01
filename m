Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B008117CD
	for <virtualization@lists.linux.dev>; Sat,  1 Jun 2024 01:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717204532; cv=none; b=lyggghGdJx7i/XzLvTIsrsox1gQzJiNbC1xlF9c6ysjoDUEzQGkMKfdiDG2Egi56qPu4lT9XgP+LmB933gaLRx2FwMQQvJlWyJ86CM2muNBSP56cn1ckLlfnScnYUXVP5VTvzGB8EmE5AxyNtRwgwyEuEa49+myGiMQsMKadi24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717204532; c=relaxed/simple;
	bh=8njHc4+OQxH6Zvo0xJgYYXhAprYJryPWqzqHTO7+d1Y=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=mtv4EMH0zBgIk3WDcezMEpfNIEwSl0EQtEZS/X0166u2NmTIxmqTqvBvEBFV167eC5lWFKbP58S0iuYuM4HewsSYV/bTwU1bBg6PWWRJ/YiXvVrGi07Mw7/Zf4QgiLRoMXe0MKgSYvm2u0DyA0IlgWRRiQs6tcASqmqRNU2drJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=NcLYGRZj; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="NcLYGRZj"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1717204521; h=Message-ID:Subject:Date:From:To;
	bh=7c9v1vjRkw+eOQnY17pAKIlCydJpq+ODaejt+ncs1Os=;
	b=NcLYGRZj/jFobfpIIx1fx1OYAnOcOfdZVFi6l1XxGAFWGqC/YqcEJ8XbxmTX1vrhPfpIYOnttymCWCvRcq1kk7QP27A/OcrbGCD8iajeKHHD2MddYGcah4DNN8UgdarOxCB938XOUoi+sNOVODHU1db/vJvMvsBcaksMKLJM3ms=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067110;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0W7bCb3w_1717204518;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W7bCb3w_1717204518)
          by smtp.aliyun-inc.com;
          Sat, 01 Jun 2024 09:15:19 +0800
Message-ID: <1717203689.8004525-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next v2 00/12] virtnet_net: prepare for af-xdp
Date: Sat, 1 Jun 2024 09:01:29 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: netdev@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 virtualization@lists.linux.dev,
 bpf@vger.kernel.org
References: <20240530112406.94452-1-xuanzhuo@linux.alibaba.com>
 <20240530075003-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240530075003-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

On Thu, 30 May 2024 07:53:17 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> On Thu, May 30, 2024 at 07:23:54PM +0800, Xuan Zhuo wrote:
> > This patch set prepares for supporting af-xdp zerocopy.
> > There is no feature change in this patch set.
> > I just want to reduce the patch num of the final patch set,
> > so I split the patch set.
> >
> > Thanks.
> >
> > v2:
> >     1. Add five commits. That provides some helper for sq to support premapped
> >        mode. And the last one refactors distinguishing xmit types.
> >
> > v1:
> >     1. resend for the new net-next merge window
> >
>
>
> It's great that you are working on this but
> I'd like to see the actual use of this first.

I want to finish this work quickly. I don't have a particular preference for
whether to use a separate directory; as an engineer, I think it makes sense. I
don't want to keep dwelling on this issue. I also hope that as a maintainer, you
can help me complete this work as soon as possible. You should know that I have
been working on this for about three years now.

I can completely follow your suggestion regarding splitting the directory.
However, there will still be many patches, so I hope that these patches in this
patch set can be merged first.

   virtio_net: separate virtnet_rx_resize()
   virtio_net: separate virtnet_tx_resize()
   virtio_net: separate receive_mergeable
   virtio_net: separate receive_buf
   virtio_net: refactor the xmit type

I will try to compress the subsequent patch sets, hoping to reduce them to about 15.

Thanks.


>
> >
> > Xuan Zhuo (12):
> >   virtio_net: independent directory
> >   virtio_net: move core structures to virtio_net.h
> >   virtio_net: add prefix virtnet to all struct inside virtio_net.h
> >   virtio_net: separate virtnet_rx_resize()
> >   virtio_net: separate virtnet_tx_resize()
> >   virtio_net: separate receive_mergeable
> >   virtio_net: separate receive_buf
> >   virtio_ring: introduce vring_need_unmap_buffer
> >   virtio_ring: introduce dma map api for page
> >   virtio_ring: introduce virtqueue_dma_map_sg_attrs
> >   virtio_ring: virtqueue_set_dma_premapped() support to disable
> >   virtio_net: refactor the xmit type
> >
> >  MAINTAINERS                                   |   2 +-
> >  drivers/net/Kconfig                           |   9 +-
> >  drivers/net/Makefile                          |   2 +-
> >  drivers/net/virtio/Kconfig                    |  12 +
> >  drivers/net/virtio/Makefile                   |   8 +
> >  drivers/net/virtio/virtnet.h                  | 248 ++++++++
> >  .../{virtio_net.c => virtio/virtnet_main.c}   | 596 +++++++-----------
> >  drivers/virtio/virtio_ring.c                  | 118 +++-
> >  include/linux/virtio.h                        |  12 +-
> >  9 files changed, 606 insertions(+), 401 deletions(-)
> >  create mode 100644 drivers/net/virtio/Kconfig
> >  create mode 100644 drivers/net/virtio/Makefile
> >  create mode 100644 drivers/net/virtio/virtnet.h
> >  rename drivers/net/{virtio_net.c => virtio/virtnet_main.c} (93%)
> >
> > --
> > 2.32.0.3.g01195cf9f
>
