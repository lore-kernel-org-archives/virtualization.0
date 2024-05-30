Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D59B255898
	for <virtualization@lists.linux.dev>; Thu, 30 May 2024 08:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717056645; cv=none; b=pMIibe46DUXg4BL0aelELcxI+Qk1/BYQaFR8Pm8Vfqe6yn6hYmKv59uiADT2Y/LPVmEu7KPtde9XiXgTPC0GkKijib+3uVj2ivNFKpKMFIcgBznZK8yyWPvEDrr6unm9Lwcp2oSSYmmKZ1Ddy5NXa5TKSX3NpU0u2MhdAdBD7UY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717056645; c=relaxed/simple;
	bh=GLzxHdzRl2iItoZp0xM8DrqAyA8JpFmL8jvdJEihmBI=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=mFhCp2K4AHl4dUmC098dwUohonM33dJ6F3Vt6z8OlkfG4CDhOeRUrigCtO0ATmNlGvNgoO2awqZlQGV5FeiPXs1SMFlVf25NElExK75kS+SyVlZMVtoZjXi+P9EsqzbIgzZs3n1vqDx0zt0USBcoXZjnrk72uuSIkTDa5HbFt+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=COWzOnr6; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="COWzOnr6"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1717056634; h=Message-ID:Subject:Date:From:To;
	bh=p7v6dFet5uex4RBTfnO23XVSl7MKtg20v2AYV+GGHaI=;
	b=COWzOnr6dEmqueDm7bxWsXimTmzKq4vvXba9tomgDVSy90GHK1HVcHCpf1O08UCBthnZ3bCmU2WlQFXnBsFGIpzGTrAvdlb56OFsd7BfPk1tnqX4O5iQgyZoEufEKfQz9taL2jYikj1Phe2ZNPcTQTZx7D+ycESiH8QSlLMdMSY=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R931e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033068173054;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0W7WF7gX_1717056633;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W7WF7gX_1717056633)
          by smtp.aliyun-inc.com;
          Thu, 30 May 2024 16:10:33 +0800
Message-ID: <1717056010.897231-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next v1 0/7] virtnet_net: prepare for af-xdp
Date: Thu, 30 May 2024 16:00:10 +0800
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
References: <20240530072649.102437-1-xuanzhuo@linux.alibaba.com>
 <20240530034921-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240530034921-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

On Thu, 30 May 2024 03:55:35 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> On Thu, May 30, 2024 at 03:26:42PM +0800, Xuan Zhuo wrote:
> > This patch set prepares for supporting af-xdp zerocopy.
> > There is no feature change in this patch set.
> > I just want to reduce the patch num of the final patch set,
> > so I split the patch set.
> >
> > #1-#3 add independent directory for virtio-net
> > #4-#7 do some refactor, the sub-functions will be used by the subsequent commits
> >
> > Thanks.
> >
> > v1:
> >     1. resend for the new net-next merge window
>
> What I said at the time is
>
> 	I am fine adding xsk in a new file or just adding in same file working on a split later.
>
> Given this was a year ago and all we keep seing is "prepare" patches,
> I am inclined to say do it in the reverse order: add
> af-xdp first then do the split when it's clear there is not
> a lot of code sharing going on.

If all is done in one patch set, maybe is ok. But we have about 14 commits for
af-xdp. If that patch set includes these commits, then we will exceed 15
(net-next limits the commit number of one patch set).

I separated these patches from the final patch set because I think these commits
can exist independently even without af-xdp.

Whether the final xsk should use a separate file, we can look at it in future
patches. If you think we can merge it into one file, I am also OK with it.
Although other drivers currently use separate files.

So if you think this patch set itself is fine, then I hope we can merge this
first.

Thanks.

>
>
> >
> > Xuan Zhuo (7):
> >   virtio_net: independent directory
> >   virtio_net: move core structures to virtio_net.h
> >   virtio_net: add prefix virtnet to all struct inside virtio_net.h
> >   virtio_net: separate virtnet_rx_resize()
> >   virtio_net: separate virtnet_tx_resize()
> >   virtio_net: separate receive_mergeable
> >   virtio_net: separate receive_buf
> >
> >  MAINTAINERS                                   |   2 +-
> >  drivers/net/Kconfig                           |   9 +-
> >  drivers/net/Makefile                          |   2 +-
> >  drivers/net/virtio/Kconfig                    |  12 +
> >  drivers/net/virtio/Makefile                   |   8 +
> >  drivers/net/virtio/virtnet.h                  | 248 ++++++++
> >  .../{virtio_net.c => virtio/virtnet_main.c}   | 536 ++++++------------
> >  7 files changed, 454 insertions(+), 363 deletions(-)
> >  create mode 100644 drivers/net/virtio/Kconfig
> >  create mode 100644 drivers/net/virtio/Makefile
> >  create mode 100644 drivers/net/virtio/virtnet.h
> >  rename drivers/net/{virtio_net.c => virtio/virtnet_main.c} (94%)
> >
> > --
> > 2.32.0.3.g01195cf9f
>
