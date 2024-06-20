Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93FD82C694
	for <virtualization@lists.linux.dev>; Thu, 20 Jun 2024 10:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718880912; cv=none; b=YOEdFOEVEPy0jkMMPDwmyPElYNGeZAm+lotax4/BQwphAl7DcArda49+FLy8fF3jwuBrGZsYiOB3GtpJ9uBjB4TzNGX3xRGw6HY0Tou9I63R3HdS7T264M83G79KmFxu+DNuuTSZQBaezhkpeRaeP/43OwfTRq1z+Mc4A/S/wtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718880912; c=relaxed/simple;
	bh=kROW9RQ/mhmEg14a8RjZNTEPPLtvdCD4Fhrlk7IyI3w=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=Tw8Q1O1NZaO8jUSxDKdiEz4VCygUoTSP2oGLAk8K/k6Xyc6i2GHim26iITrYp/ZZ99VKsPJ0e7HN1sp2rz9lc9snk4LnP9Olouhew/aFAdscA6v9mkK+z+55McL2DjZx2JBjewyXocWmTGkPl4ISh21veFqtGcYVQQUHQHuG/BI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=sKMDGs1p; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="sKMDGs1p"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1718880907; h=Message-ID:Subject:Date:From:To;
	bh=Fel2/8/EOFmcfP6qOXtVIWxVD5zcPAVWJrMLgPVGTog=;
	b=sKMDGs1pObF7DwjK2tvRvdP/9hdEAnCybX80G5XxvA5PTyafM3fvGr+4ebG0puVj8pqPFeXOZPP5EoRj5nVyInk1PuLtv5G76Au23hObFU760ql0HOERcSZAs0cpgOjhhhlYbOwB9gsq2AXcTnE1bMT1PB2FvJMG9y2VW0vXQyA=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045075189;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0W8s9g52_1718880905;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W8s9g52_1718880905)
          by smtp.aliyun-inc.com;
          Thu, 20 Jun 2024 18:55:05 +0800
Message-ID: <1718880882.9011145-4-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next v6 10/10] virtio_net: xsk: rx: free the unused xsk buffer
Date: Thu, 20 Jun 2024 18:54:42 +0800
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
 <20240618075643.24867-11-xuanzhuo@linux.alibaba.com>
 <38db3facdfefbefecd367ccce2e9b094d0b0314d.camel@redhat.com>
In-Reply-To: <38db3facdfefbefecd367ccce2e9b094d0b0314d.camel@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

On Thu, 20 Jun 2024 12:46:24 +0200, Paolo Abeni <pabeni@redhat.com> wrote:
> On Tue, 2024-06-18 at 15:56 +0800, Xuan Zhuo wrote:
> > Release the xsk buffer, when the queue is releasing or the queue is
> > resizing.
> >
> > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > ---
> >  drivers/net/virtio_net.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index cfa106aa8039..33695b86bd99 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -967,6 +967,11 @@ static void virtnet_rq_unmap_free_buf(struct virtqueue *vq, void *buf)
> >
> >  	rq = &vi->rq[i];
> >
> > +	if (rq->xsk.pool) {
> > +		xsk_buff_free((struct xdp_buff *)buf);
> > +		return;
> > +	}
> > +
> >  	if (!vi->big_packets || vi->mergeable_rx_bufs)
> >  		virtnet_rq_unmap(rq, buf, 0);
>
>
> I'm under the impression this should be squashed in a previous patch,
> likely "virtio_net: xsk: bind/unbind xsk for rx"

OK.

Thanks.


>
> Thanks,
>
> Paolo
>
