Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF24816FF37
	for <virtualization@lists.linux.dev>; Wed,  4 Dec 2024 04:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733285706; cv=none; b=rN3BH+BEgyXzWzjy5bji+s3Qt1od7DeL6nWv+U/Rb899Da0GJZj7L3nHNBFaov7dYPdlkpoWkuuIBE4X2qlzbQbQD55uJQS4fUdL+aWdOxV2+DjxhnHtnjouAEDEAqExKhTiPNx4wd1RWk87nXdG0MgJ+saOTjcmSBqHPFINsos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733285706; c=relaxed/simple;
	bh=IrUEeeXk0XqjRNrEb78avFaZBzk2PWSNq8LbhH2Q5vc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z5Y9ENasuVe8bIlqG3oCZFON5UVIid7sAR7K0NC+54YxKkPjFcrFzdPii4z2Zlhwcm1sSziW93H1iIw+XcXUkCRw017AXdKfmlljOP0jSpI3uuWLkqa3lT2wNrgXEjGA5ynspYqBXFq2mtNLG3QDmzTQ7a99tuehQqhGvc8jvOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=EksffH91; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="EksffH91"
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id A4CD93F2BD
	for <virtualization@lists.linux.dev>; Wed,  4 Dec 2024 04:14:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1733285695;
	bh=Q24GDRfJXQyjTe8o63+C0HsFRR+/g6kWIzNile+zMUE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:In-Reply-To;
	b=EksffH91slgbCiU5/TxXHLq6LFOPz/G9JiNodlPs8f/6TwGRKYNLTfesbFWx3F98C
	 2xMupUMvs1i1Uk74Vi3kwbO4HKEbBx8XWkqQiAFjv+KAIebkBbailN1HWybNRCZDpD
	 Y/+7TLfKoA7/1c62zV72V5PZhLoyzPvSj85iU5cR2PjETiUvhzqee+u5ZOOJrixil9
	 0XTaQyTsT4XVPnYiHitPGCw4kDg9QgHF9LOGKuGZWeHJlHuWGcvXBS15Nl6tlrDCAH
	 paap9DNWku8yTSFlfBFTfoFOFIYupBXpmUI/MvPF8cl/TDBya7D7M/yTUVmJWwSPp1
	 sd8VOnOYIUV1g==
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2eeeb5b7022so2425823a91.0
        for <virtualization@lists.linux.dev>; Tue, 03 Dec 2024 20:14:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733285694; x=1733890494;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q24GDRfJXQyjTe8o63+C0HsFRR+/g6kWIzNile+zMUE=;
        b=HcniegCGu+VWeYS91zfFRd+JGXFVNxu/G+g72INj70E3KycL4kijfImmLeV3Svwwk/
         toRtQXVlkHxj1fk+RPJXBp98a6Eh+VyW5I2XaJjEqvQGvUWkxEXOFHHvMl8HCBzeMIS6
         r97ZRlOUO5vuNs2v+mUWe+YQjsRUZTenbh5a6jD9Wz2sdFj9UbKzVk8vQHVRQ/OpaAO5
         103at5QjtI2YunkHdixAYwwDj5uzprmzaYjI1aeCWjJ0trpaHW8pAduunFBuZzR72eqE
         e/UQKaOkmvbCmYX+g48MSs/rRj5e8nGNSHAz5svHCGfTb62+J92dKMGmeGhMYGcdax7A
         FuZg==
X-Gm-Message-State: AOJu0Yz6LuFWusfyeQGxUIw8hgfl4EhrrQFE32JqbQpCHEKkSDYYzPuT
	ifTcLyl9lPI2K1DttTlaukP74qpJ1EI80y4pQZg6/dLmnQPTycjx7h6LHOu3izK1A44BqmKbdiD
	9BO6KSlH0roiMjgg3u2U0mqhmIBl92O0cdI+30DZHx3S1q4SgYQXegKiurlo+P1MSJHjUUqhPBJ
	qZjN8Z
X-Gm-Gg: ASbGncs9bj0Vkuzc+oa60UZNhXq9zQYiqq/MQOfMAjaa88Eiw/jXST+7Cl7CIt6T14G
	NgN5Hgtb7PLLlmCG8w535Jh1HEIcud91UndIm+LtSXcTDEqNPvBSm51V5RMNZdZNO/oMw0k44Ib
	AMiajK0VNO/SpTXuxhlq73glU0wKpo9FCk2FJ8bmOKHn+4xtrPbSbnPk0eN3VXMxez8SKMQ/94E
	xcm47LqvOD+HsGBgiHWGrl5gwraRFoohzpJ8SyKDDQSlH0IMFV6
X-Received: by 2002:a17:90a:e70c:b0:2ee:f440:53ed with SMTP id 98e67ed59e1d1-2ef0127597bmr5969994a91.31.1733285694353;
        Tue, 03 Dec 2024 20:14:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHmmxQJst2LuugrSZJhqPzCTrbLye21ezDzuZBBWTLDHpaGBRfvTE3sFkECyoe3UpjTjDpNpw==
X-Received: by 2002:a17:90a:e70c:b0:2ee:f440:53ed with SMTP id 98e67ed59e1d1-2ef0127597bmr5969973a91.31.1733285694019;
        Tue, 03 Dec 2024 20:14:54 -0800 (PST)
Received: from localhost ([240f:74:7be:1:9c88:3d14:cbea:e537])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ef27050103sm388122a91.41.2024.12.03.20.14.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 20:14:53 -0800 (PST)
Date: Wed, 4 Dec 2024 13:14:51 +0900
From: Koichiro Den <koichiro.den@canonical.com>
To: Jason Wang <jasowang@redhat.com>
Cc: virtualization@lists.linux.dev, mst@redhat.com, 
	xuanzhuo@linux.alibaba.com, eperezma@redhat.com, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, jiri@resnulli.us, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net-next v2 4/5] virtio_ring: add 'flushed' as an
 argument to virtqueue_reset()
Message-ID: <ub7pbfodhjpubwixxsbxlkiclthp3adbxin7etff5seoxqs5i7@aj3c7tpeirwq>
References: <20241203073025.67065-1-koichiro.den@canonical.com>
 <20241203073025.67065-5-koichiro.den@canonical.com>
 <CACGkMEuUa+6_uaa7H2CSvUnfNzBr-rdoQ+cp8eZD+Ay1CZ=A-g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEuUa+6_uaa7H2CSvUnfNzBr-rdoQ+cp8eZD+Ay1CZ=A-g@mail.gmail.com>

On Wed, Dec 04, 2024 at 10:49:02AM +0800, Jason Wang wrote:
> On Tue, Dec 3, 2024 at 3:31 PM Koichiro Den <koichiro.den@canonical.com> wrote:
> >
> > When virtqueue_reset() has actually recycled all unused buffers,
> > additional work may be required in some cases. Relying solely on its
> > return status is fragile, so introduce a new argument 'flushed' to
> > explicitly indicate whether it has really occurred.
> >
> > Signed-off-by: Koichiro Den <koichiro.den@canonical.com>
> > ---
> >  drivers/net/virtio_net.c     | 6 ++++--
> >  drivers/virtio/virtio_ring.c | 6 +++++-
> >  include/linux/virtio.h       | 3 ++-
> >  3 files changed, 11 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index 0103d7990e44..d5240a03b7d6 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -5695,6 +5695,7 @@ static int virtnet_rq_bind_xsk_pool(struct virtnet_info *vi, struct receive_queu
> >                                     struct xsk_buff_pool *pool)
> >  {
> >         int err, qindex;
> > +       bool flushed;
> >
> >         qindex = rq - vi->rq;
> >
> > @@ -5713,7 +5714,7 @@ static int virtnet_rq_bind_xsk_pool(struct virtnet_info *vi, struct receive_queu
> >
> >         virtnet_rx_pause(vi, rq);
> >
> > -       err = virtqueue_reset(rq->vq, virtnet_rq_unmap_free_buf);
> > +       err = virtqueue_reset(rq->vq, virtnet_rq_unmap_free_buf, &flushed);
> >         if (err) {
> >                 netdev_err(vi->dev, "reset rx fail: rx queue index: %d err: %d\n", qindex, err);
> >
> > @@ -5737,12 +5738,13 @@ static int virtnet_sq_bind_xsk_pool(struct virtnet_info *vi,
> >                                     struct xsk_buff_pool *pool)
> >  {
> >         int err, qindex;
> > +       bool flushed;
> >
> >         qindex = sq - vi->sq;
> >
> >         virtnet_tx_pause(vi, sq);
> >
> > -       err = virtqueue_reset(sq->vq, virtnet_sq_free_unused_buf);
> > +       err = virtqueue_reset(sq->vq, virtnet_sq_free_unused_buf, &flushed);
> >         if (err) {
> >                 netdev_err(vi->dev, "reset tx fail: tx queue index: %d err: %d\n", qindex, err);
> >                 pool = NULL;
> > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > index 34a068d401ec..b522ef798946 100644
> > --- a/drivers/virtio/virtio_ring.c
> > +++ b/drivers/virtio/virtio_ring.c
> > @@ -2828,6 +2828,7 @@ EXPORT_SYMBOL_GPL(virtqueue_resize);
> >   * virtqueue_reset - detach and recycle all unused buffers
> >   * @_vq: the struct virtqueue we're talking about.
> >   * @recycle: callback to recycle unused buffers
> > + * @flushed: whether or not unused buffers are all flushed
> >   *
> >   * Caller must ensure we don't call this with other virtqueue operations
> >   * at the same time (except where noted).
> > @@ -2839,14 +2840,17 @@ EXPORT_SYMBOL_GPL(virtqueue_resize);
> >   * -EPERM: Operation not permitted
> >   */
> >  int virtqueue_reset(struct virtqueue *_vq,
> > -                   void (*recycle)(struct virtqueue *vq, void *buf))
> > +                   void (*recycle)(struct virtqueue *vq, void *buf),
> > +                   bool *flushed)
> >  {
> >         struct vring_virtqueue *vq = to_vvq(_vq);
> >         int err;
> >
> > +       *flushed = false;
> >         err = virtqueue_disable_and_recycle(_vq, recycle);
> >         if (err)
> >                 return err;
> > +       *flushed = true;
> >
> 
> This makes me think if it would be easier if we just find a way to
> reset the tx queue inside virtqueue_disable_and_recycle().
> 
> For example, introducing a recycle_done callback?

It sounds reasonable and much cleaner. I'll prepare and send v3 shortly.
Thanks for the review.

-Koichiro Den

> 
> Thanks
> 
