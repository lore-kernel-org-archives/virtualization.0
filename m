Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9212518AED
	for <virtualization@lists.linux.dev>; Tue, 23 Apr 2024 05:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713851802; cv=none; b=EnYr8cg0yYTvU/0B4vqZTJ58z2SoTTyQc6cwc5fQOewu5plOGNqRcHpnZO5CKpVjoMrzvMdq5hMP9M19K+owxt7RCP5yWnIX2qF0xKuFTxezo69glUsFBxh3d043uYvEdY/VuA1YIw4NW0hyHrS2yS5SSAZzdpL4OykwyxWV/XE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713851802; c=relaxed/simple;
	bh=FUtZ1xvClmdmTBUAURFroa1ipOw8c203HiCdSlH64dw=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=CkiJVwlWqFRFFMBq9tniR7On4sHoI/JOcyLN6UWl3KHeXla7kD/DuXqG27jIPBTo4/5gbLJafefnPgTgDll3JdbRRsgAfbgXDDcsTJqq8JylHwDnm0lSB/KMyIqJnB6qV0ydC8ylZGuraWviz4n+CUzRJNTw5qNrgVvUAuzL1qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=rKOHiYNA; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="rKOHiYNA"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1713851798; h=Message-ID:Subject:Date:From:To;
	bh=GHCysremovBWIsP3Dli5jXdc1mNQf4cWC+uRc/bjoJ0=;
	b=rKOHiYNAhdPe3I6hOURp9VOToaGqs9Gr0YsaXUfTs/Ec2PGqZfg/GcXewnYwHXXNuaoPFD3ynLpL60HGdSBNTMT0lw7cy59Yr7uKUd0yRodnLTP5+RTyNdEllRrWAS+6z7jROasQgJjJ7JICJ71ccN39iRa5Tq2uqfQrkPjaNgo=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0W57uPlJ_1713851795;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W57uPlJ_1713851795)
          by smtp.aliyun-inc.com;
          Tue, 23 Apr 2024 13:56:36 +0800
Message-ID: <1713851675.6547418-3-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next v5 0/9] virtio-net: support device stats
Date: Tue, 23 Apr 2024 13:54:35 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: netdev@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@google.com>,
 Amritha Nambiar <amritha.nambiar@intel.com>,
 Larysa Zaremba <larysa.zaremba@intel.com>,
 Sridhar Samudrala <sridhar.samudrala@intel.com>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 virtualization@lists.linux.dev,
 bpf@vger.kernel.org
References: <20240318110602.37166-1-xuanzhuo@linux.alibaba.com>
 <20240422163231-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240422163231-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

On Mon, 22 Apr 2024 16:33:01 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> On Mon, Mar 18, 2024 at 07:05:53PM +0800, Xuan Zhuo wrote:
> > As the spec:
> >
> > https://github.com/oasis-tcs/virtio-spec/commit/42f389989823039724f95bbbd243291ab0064f82
> >
> > The virtio net supports to get device stats.
> >
> > Please review.
>
> series:
>
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
>
> I think you can now repost for net-next.

Thanks for your ack.

I and Jason discussed  a way to remove the "maps".

I will post a new patch set with that.

Thanks.


>
>
> > Thanks.
> >
> > v5:
> >     1. Fix some small problems in last version
> >     2. Not report stats that will be reported by netlink
> >     3. remove "_queue" from  ethtool -S
> >
> > v4:
> >     1. Support per-queue statistics API
> >     2. Fix some small problems in last version
> >
> > v3:
> >     1. rebase net-next
> >
> > v2:
> >     1. fix the usage of the leXX_to_cpu()
> >     2. add comment to the structure virtnet_stats_map
> >
> > v1:
> >     1. fix some definitions of the marco and the struct
> >
> >
> >
> >
> >
> >
> > Xuan Zhuo (9):
> >   virtio_net: introduce device stats feature and structures
> >   virtio_net: virtnet_send_command supports command-specific-result
> >   virtio_net: remove "_queue" from ethtool -S
> >   virtio_net: support device stats
> >   virtio_net: stats map include driver stats
> >   virtio_net: add the total stats field
> >   virtio_net: rename stat tx_timeout to timeout
> >   netdev: add queue stats
> >   virtio-net: support queue stat
> >
> >  Documentation/netlink/specs/netdev.yaml | 104 ++++
> >  drivers/net/virtio_net.c                | 755 +++++++++++++++++++++---
> >  include/net/netdev_queues.h             |  27 +
> >  include/uapi/linux/netdev.h             |  19 +
> >  include/uapi/linux/virtio_net.h         | 143 +++++
> >  net/core/netdev-genl.c                  |  23 +-
> >  tools/include/uapi/linux/netdev.h       |  19 +
> >  7 files changed, 1013 insertions(+), 77 deletions(-)
> >
> > --
> > 2.32.0.3.g01195cf9f
>
