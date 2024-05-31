Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD84EAD5
	for <virtualization@lists.linux.dev>; Fri, 31 May 2024 01:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717119811; cv=none; b=Jz/HKoy/hfqZi7F9B2jo7y1rOJCT7at9KqJrVlQUPbhAPhsrhwPCm5pglW/zD7+B9u1L7Ez++kBQwDCDbbyFfklX5fj8Q713vtnIu9R1UmuOipq5qt4Ybbgys2pe520dwIKjddy5N6O+x69R3izD2LMG5OvArG5KbwLVzDImln8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717119811; c=relaxed/simple;
	bh=OYBjBzfsTUKNJjIFua9gw/fqfpszYi7TDOfquhjtVRc=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=oCdwjF8/YbPGdFuFNztjdf+lMM0klqep8jkUBJ2DBSCkkXD6tcHDqEzwMj+A4B8N2IvDs73H+bMAbNPVF3cXTEbbLH3k1ged9SkIaAJll1+Vo0s0ryOo3um57M7C1Np+gHHfMerBNjS00pVx100D/Im2baQa6hOkkra/x3X+pG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=w9G5AWMG; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="w9G5AWMG"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1717119806; h=Message-ID:Subject:Date:From:To;
	bh=BasWh7r3trW1hENGSqf3w4zcN57q5BXlpvJVUaljc6U=;
	b=w9G5AWMGKK33h9at3bZO3Zxn3CpNTg9GRUpAmfsha9XHgfALEWHGaXWHYUT35d3/uTzNXnTfLVovB4JzZy+LpraqxvAimo6Fgni0aefOJ4ZIG/Ob3aOOt+y1h3M5+wR9HHFL69jltPhQl7jKQOxEdfDcqI1KMH5YZbnL98u1MdA=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R791e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067111;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0W7YGvYX_1717119804;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W7YGvYX_1717119804)
          by smtp.aliyun-inc.com;
          Fri, 31 May 2024 09:43:25 +0800
Message-ID: <1717119614.404968-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next v2 00/12] virtnet_net: prepare for af-xdp
Date: Fri, 31 May 2024 09:40:14 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 virtualization@lists.linux.dev,
 bpf@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>
References: <20240530112406.94452-1-xuanzhuo@linux.alibaba.com>
 <20240530075003-mutt-send-email-mst@kernel.org>
 <1717070084.6955814-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1717070084.6955814-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

On Thu, 30 May 2024 19:54:44 +0800, Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
> On Thu, 30 May 2024 07:53:17 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > On Thu, May 30, 2024 at 07:23:54PM +0800, Xuan Zhuo wrote:
> > > This patch set prepares for supporting af-xdp zerocopy.
> > > There is no feature change in this patch set.
> > > I just want to reduce the patch num of the final patch set,
> > > so I split the patch set.
> > >
> > > Thanks.
> > >
> > > v2:
> > >     1. Add five commits. That provides some helper for sq to support premapped
> > >        mode. And the last one refactors distinguishing xmit types.
> > >
> > > v1:
> > >     1. resend for the new net-next merge window
> > >
> >
> >
> > It's great that you are working on this but
> > I'd like to see the actual use of this first.
>
>
> For me, that is easy. But how should we do, if we use one patch set,
> then the commit number maybe 26, that exceeds 15 (limit of the net next).


Hi, Jakub

There will be a huge patch set (about 25) to support AF-XDP for virtio-net.
Can I just post this huge patch set if the maintainers of virtio-net agree?

Thanks.



>
> Thanks.
>
>
> >
> > >
> > > Xuan Zhuo (12):
> > >   virtio_net: independent directory
> > >   virtio_net: move core structures to virtio_net.h
> > >   virtio_net: add prefix virtnet to all struct inside virtio_net.h
> > >   virtio_net: separate virtnet_rx_resize()
> > >   virtio_net: separate virtnet_tx_resize()
> > >   virtio_net: separate receive_mergeable
> > >   virtio_net: separate receive_buf
> > >   virtio_ring: introduce vring_need_unmap_buffer
> > >   virtio_ring: introduce dma map api for page
> > >   virtio_ring: introduce virtqueue_dma_map_sg_attrs
> > >   virtio_ring: virtqueue_set_dma_premapped() support to disable
> > >   virtio_net: refactor the xmit type
> > >
> > >  MAINTAINERS                                   |   2 +-
> > >  drivers/net/Kconfig                           |   9 +-
> > >  drivers/net/Makefile                          |   2 +-
> > >  drivers/net/virtio/Kconfig                    |  12 +
> > >  drivers/net/virtio/Makefile                   |   8 +
> > >  drivers/net/virtio/virtnet.h                  | 248 ++++++++
> > >  .../{virtio_net.c => virtio/virtnet_main.c}   | 596 +++++++-----------
> > >  drivers/virtio/virtio_ring.c                  | 118 +++-
> > >  include/linux/virtio.h                        |  12 +-
> > >  9 files changed, 606 insertions(+), 401 deletions(-)
> > >  create mode 100644 drivers/net/virtio/Kconfig
> > >  create mode 100644 drivers/net/virtio/Makefile
> > >  create mode 100644 drivers/net/virtio/virtnet.h
> > >  rename drivers/net/{virtio_net.c => virtio/virtnet_main.c} (93%)
> > >
> > > --
> > > 2.32.0.3.g01195cf9f
> >
>
