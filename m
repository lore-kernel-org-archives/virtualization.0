Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 659BB17276E
	for <virtualization@lists.linux.dev>; Thu, 30 May 2024 11:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717070212; cv=none; b=WX2CcOeOLGWecqi/cyVag7/APoS+RKfV537niN+sbPZuSSkaUic5iUTLxEcKj75p+caqVuChn86uITHvvS127ScdvUZb9O4NmdEeSVgw2mMuR/Ky4GFQtNueFJn8LKB7d5B5quimOA8HIVWPXJCoFRPJGHove/SkQFDapRD6P9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717070212; c=relaxed/simple;
	bh=u6rjcblz8SIk/Kflt8ggKzEN9vyweGys/cV5XYAICRE=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=SfGAyj7FFLLJWhIl0KeaZMIRc1T7QaG9OVs1KL/g4spT4ua4k9U1/TzW5nxW/pW5GSQhu0cUTx66hTReVq9ksKbhvO62bGfrz/LgBNJmud1KUqc0LNFVTNQwljHSyBo/z/N4JRRRjsLXqPVkT4DmKjqoTmDxinfsBs3iYHN3Yp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=K0l9TuCZ; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="K0l9TuCZ"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1717070208; h=Message-ID:Subject:Date:From:To;
	bh=SZvgl02PU3BFYWIQEW2nLuYF/jdHIVBgu2ECb4NmBEo=;
	b=K0l9TuCZI6M5CVa7f044rQ0oFD/cP9kfHB3xziwpds/GVlzty/CdZ2OY8AlaIO5mCs04M4I1jrfjFETwwfVV8EKGnGIhr6+9NBYf6t4o8kLEZqHZ3svG35gcycZN2Zijjg8giyogVPLjSoRAVZbF5ijFxd6yPGnE8OCAaXzK5mk=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067113;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0W7Wx6gr_1717070206;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W7Wx6gr_1717070206)
          by smtp.aliyun-inc.com;
          Thu, 30 May 2024 19:56:47 +0800
Message-ID: <1717070084.6955814-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next v2 00/12] virtnet_net: prepare for af-xdp
Date: Thu, 30 May 2024 19:54:44 +0800
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


For me, that is easy. But how should we do, if we use one patch set,
then the commit number maybe 26, that exceeds 15 (limit of the net next).

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
