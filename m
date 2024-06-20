Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C76481A8C20
	for <virtualization@lists.linux.dev>; Thu, 20 Jun 2024 10:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718881086; cv=none; b=gJ4DMpgHexDXqEzlskIdVjADHgS4pORyiCRbTsFlwfoId7UII3LGNkJtWRqRVpTlWThwusVeM6rO6DGLoNkFPlcrGumWBkM+tybMxV9QvAdYvO0UJp/cR62zM4vPUUQKxFOv2Vs9G+Ba5pruY7h5zPRGqg+c9CoHKW80KS+wt+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718881086; c=relaxed/simple;
	bh=kIqNZT7Y/2I214ckOZtVCOZwMUmxnwADE+Z6ZC7k6ek=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=qo4qF8vA06egQdXANfGiPYV7YZucyEqqnJ7VyNIEHhZlfYCPCSzBiWuhQb1gQbtZ1nWA1KWCuQA9ji+zUVYUeun9/Yr4mSqaUi8ycXq7bXhIue8dkAfn2VUrL7eI1IlZOMfCOyEnPIJBUi10bHbu2tJbKELZq1TqekFhaN7g/NY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=AtrpU8f9; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="AtrpU8f9"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1718881082; h=Message-ID:Subject:Date:From:To;
	bh=a3c1ylxFN5nTy1Dk8OE874gV7bmy1Q7+61Aj0oQTYXs=;
	b=AtrpU8f9LEP7ZL5BQMH71OP3a9dtnAX0uGtTwmhsptf+ZTyj7bJiJUQIbRzTv74jEWnVjTK2cxQH+VnhrZy80O6PQ0IOD/iMnUU2bh8bucJKzHIXx0QeALCazitD9JYTMXLwxA4st7V+tccncYN0W0uK6KOljeuuk0Ax6VvPslk=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R241e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033068164191;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0W8s8bOx_1718881081;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W8s8bOx_1718881081)
          by smtp.aliyun-inc.com;
          Thu, 20 Jun 2024 18:58:01 +0800
Message-ID: <1718881025.1145291-5-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next v6 09/10] virtio_net: xsk: rx: support recv merge mode
Date: Thu, 20 Jun 2024 18:57:05 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 virtualization@lists.linux.dev,
 bpf@vger.kernel.org,
 netdev@vger.kernel.org
References: <20240618075643.24867-1-xuanzhuo@linux.alibaba.com>
 <20240618075643.24867-10-xuanzhuo@linux.alibaba.com>
 <b3fc84d24bce9ab2997a414cc84ae7e12ba87987.camel@redhat.com>
In-Reply-To: <b3fc84d24bce9ab2997a414cc84ae7e12ba87987.camel@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

On Thu, 20 Jun 2024 12:37:43 +0200, Paolo Abeni <pabeni@redhat.com> wrote:
> On Tue, 2024-06-18 at 15:56 +0800, Xuan Zhuo wrote:
> > Support AF-XDP for merge mode.
> >
> > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > ---
> >  drivers/net/virtio_net.c | 139 +++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 139 insertions(+)
> >
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index 06608d696e2e..cfa106aa8039 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -504,6 +504,10 @@ static int virtnet_xdp_handler(struct bpf_prog *xdp_prog, struct xdp_buff *xdp,
> >  			       struct net_device *dev,
> >  			       unsigned int *xdp_xmit,
> >  			       struct virtnet_rq_stats *stats);
> > +static struct sk_buff *virtnet_skb_append_frag(struct sk_buff *head_skb,
> > +					       struct sk_buff *curr_skb,
> > +					       struct page *page, void *buf,
> > +					       int len, int truesize);
> >
> >  static bool is_xdp_frame(void *ptr)
> >  {
> > @@ -1128,6 +1132,139 @@ static struct sk_buff *virtnet_receive_xsk_small(struct net_device *dev, struct
> >  	}
> >  }
> >
> > +static void xsk_drop_follow_bufs(struct net_device *dev,
> > +				 struct receive_queue *rq,
> > +				 u32 num_buf,
> > +				 struct virtnet_rq_stats *stats)
> > +{
> > +	struct xdp_buff *xdp;
> > +	u32 len;
> > +
> > +	while (num_buf-- > 1) {
>
> Why do you skip the last buffer? I thought it should be dropped, too?!?


Here, we just need to drop the follow bufs (num_buf - 1). The first one have be
dropped.

Thanks.


>
> Thanks!
>
> Paolo
>
