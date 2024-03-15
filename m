Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7A7E14AB8
	for <virtualization@lists.linux.dev>; Fri, 15 Mar 2024 08:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710490271; cv=none; b=LBu26/jsUGr7ZwCj/uAIDv7LABXeCJoVm/hmCxwUzd8zEhTPQiO7P9z7ocQipm1i2KdyPz4Ft0qj87dUYkSjo5up/5uPFCj9Cpi1aP6Ei/5vo2mxd/MjuxHxGEkpBCHGgikXIG8nUq0YYFer5fBw+CraxJVMMoXrugba11K8oo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710490271; c=relaxed/simple;
	bh=DRkkmD/QbTHhutIxMrgokTp3CCqI7QaR/h8T7hy55is=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=RDYXSeDJKww+rBmo6w9q3AdjBH/nXE68Irvp5x3W2BOuyXqye0Cqm18V9jN4To+2DkzjBax+aLSQ9L2Xj0rg4n9CRif3ICwtvvNrOQdbGSEeeuhBkdpA1V2MB/TAvnLfZhBceHUzGjXiwaZr9V3J2KuUfYyQwicvtDZ4A3VUorI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=haheg2Ec; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="haheg2Ec"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1710490266; h=Message-ID:Subject:Date:From:To;
	bh=YPsibT017DvxyxoNSxNBbO0nrsAsyY5mHP0Y0p2jK9w=;
	b=haheg2Ec7oNb1oepTKjT3oUC+HkAWUl7G76h+oTbKVkk/MCbdh9SE1j9ldSsCCUOLYb857zw1xKmQ+m/0prCQ1MQQR02fLr0uqHs1qLWVxe30oQI5ryDd0uSvfnDU/4KCQysG3rcI9Tvgo0ELbauxEYpQCD2xqxQ1qF831y3gPg=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R561e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0W2Vb0V3_1710490264;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W2Vb0V3_1710490264)
          by smtp.aliyun-inc.com;
          Fri, 15 Mar 2024 16:11:05 +0800
Message-ID: <1710490258.2804203-2-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next v4 8/8] virtio-net: support queue stat
Date: Fri, 15 Mar 2024 16:10:58 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>,
 Eric  Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>,
 "Michael S.  Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Alexei  Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@google.com>,
 Amritha  Nambiar <amritha.nambiar@intel.com>,
 Larysa Zaremba <larysa.zaremba@intel.com>,
 Sridhar Samudrala <sridhar.samudrala@intel.com>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 virtualization@lists.linux.dev,
 bpf@vger.kernel.org
References: <20240314085459.115933-1-xuanzhuo@linux.alibaba.com>
 <20240314085459.115933-9-xuanzhuo@linux.alibaba.com>
 <20240314155616.107de7c3@kernel.org>
In-Reply-To: <20240314155616.107de7c3@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

On Thu, 14 Mar 2024 15:56:16 -0700, Jakub Kicinski <kuba@kernel.org> wrote:
> On Thu, 14 Mar 2024 16:54:59 +0800 Xuan Zhuo wrote:
> > +static void virtnet_get_base_stats(struct net_device *dev,
> > +				   struct netdev_queue_stats_rx *rx,
> > +				   struct netdev_queue_stats_tx *tx)
> > +{
> > +	/* The queue stats of the virtio-net will not be reset. So here we
> > +	 * return 0.
> > +	 */
> > +	memset(rx, 0, sizeof(*rx));
> > +	memset(tx, 0, sizeof(*tx));
> > +}
>
> /**
>  * struct netdev_stat_ops - netdev ops for fine grained stats
>  * @get_queue_stats_rx:	get stats for a given Rx queue
>  * @get_queue_stats_tx:	get stats for a given Tx queue
>  * @get_base_stats:	get base stats (not belonging to any live instance)
>  *
>  * Query stats for a given object. The values of the statistics are undefined
>  * on entry (specifically they are *not* zero-initialized). Drivers should
>  * assign values only to the statistics they collect. Statistics which are not
>  * collected must be left undefined.                  ^^^^^^^^^^^^^^^^^^^^^^^^
>    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

I see.

Thanks.
