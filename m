Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF5EC158867
	for <virtualization@lists.linux.dev>; Wed, 24 Apr 2024 08:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713947014; cv=none; b=Yb6mBCqJiHLw8MywHDVyTMXOOcjRr7GFJnVKhMvxFCwYPo6F4j5PJpfxKZ8CasLZhqV/B2DL4RHPc1ZLy+BC3Dq5FqkPJTXt2bNjUniJNr9LvLNNCiQVmPiqa1CUvzPldgFXfyZAZnm1vNZqg31n8c93rcwGT13d6XdRL/DyEQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713947014; c=relaxed/simple;
	bh=3ARAWoBtxebwEsPBwnDklTrDSSkghbxUEWf1tljbbII=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To:
	 Content-Type; b=UgmRUMCLghRb18nr7sVIr5BDIEXdka8lgJLdak6JIJMIWqh1xRp6Q6D3zOuL3g3LuhX0AeQSUaD/tZ8lFMDnNpvPclQdNGQNq90yZgnyiJCmIo28QM8Y5ZEXR3RHZ0aVQcaE0BpezCQQPv4pVWI+omBpNYroAtHLtxfKoAd1iu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=nlePS1zQ; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="nlePS1zQ"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1713947009; h=Message-ID:Subject:Date:From:To:Content-Type;
	bh=y8Gj3JVfYe7P540GKPgrPDv5i5w7zuz2gXJ/tyV3XKM=;
	b=nlePS1zQDf8qF72kBsfW90p0DoidLoYkzJBj3QwvuQ1kWCZw72WFujyyDyhKiwSDZ/isCx44vbcR22/ToS+4EW7LGke5Rt+OkQyP/LKWSyOqpsSzFdT6O2+lG5m8686klM7ecufP0SGnAPBi4XSIjdbxrgxnkEOnDz57hB1E+es=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067113;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0W5Bjkwb_1713947007;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W5Bjkwb_1713947007)
          by smtp.aliyun-inc.com;
          Wed, 24 Apr 2024 16:23:28 +0800
Message-ID: <1713946991.7525542-2-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next v6 6/8] virtio_net: rename stat tx_timeout to timeout
Date: Wed, 24 Apr 2024 16:23:11 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
Cc: netdev@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
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
 bpf@vger.kernel.org,
 Jiri Pirko <jiri@nvidia.com>
References: <20240423113141.1752-1-xuanzhuo@linux.alibaba.com>
 <20240423113141.1752-7-xuanzhuo@linux.alibaba.com>
 <CACGkMEvoOqcazXxAt6KwShwJxtn=Z-sF7-yZr+JcUGL3Vk=S7g@mail.gmail.com>
In-Reply-To: <CACGkMEvoOqcazXxAt6KwShwJxtn=Z-sF7-yZr+JcUGL3Vk=S7g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

On Wed, 24 Apr 2024 11:55:24 +0800, Jason Wang <jasowang@redhat.com> wrote:
> On Tue, Apr 23, 2024 at 7:32=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba=
.com> wrote:
> >
> > Now, we have this:
> >
> >     tx_queue_0_tx_timeouts
> >
> > This is used to record the tx schedule timeout.
> > But this has two "tx". I think the below is enough.
> >
> >     tx_queue_0_timeouts
> >
> > So I rename this field.
> >
> > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > Reviewed-by: Jiri Pirko <jiri@nvidia.com>
> > ---
> >  drivers/net/virtio_net.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index 8a4d22f5f5b1..51ce2308f4f5 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -87,7 +87,7 @@ struct virtnet_sq_stats {
> >         u64_stats_t xdp_tx;
> >         u64_stats_t xdp_tx_drops;
> >         u64_stats_t kicks;
> > -       u64_stats_t tx_timeouts;
> > +       u64_stats_t timeouts;
> >  };
> >
> >  struct virtnet_rq_stats {
> > @@ -111,7 +111,7 @@ static const struct virtnet_stat_desc virtnet_sq_st=
ats_desc[] =3D {
> >         VIRTNET_SQ_STAT("xdp_tx",       xdp_tx),
> >         VIRTNET_SQ_STAT("xdp_tx_drops", xdp_tx_drops),
> >         VIRTNET_SQ_STAT("kicks",        kicks),
> > -       VIRTNET_SQ_STAT("tx_timeouts",  tx_timeouts),
> > +       VIRTNET_SQ_STAT("timeouts",     timeouts),
>
> Not sure if it is too late to do this as it is noticeable by the userspac=
e.

OK. I remove this in next version.

Thanks.


>
> Thanks
>
> >  };
> >
> >  static const struct virtnet_stat_desc virtnet_rq_stats_desc[] =3D {
> > @@ -2691,7 +2691,7 @@ static void virtnet_stats(struct net_device *dev,
> >                         start =3D u64_stats_fetch_begin(&sq->stats.sync=
p);
> >                         tpackets =3D u64_stats_read(&sq->stats.packets);
> >                         tbytes   =3D u64_stats_read(&sq->stats.bytes);
> > -                       terrors  =3D u64_stats_read(&sq->stats.tx_timeo=
uts);
> > +                       terrors  =3D u64_stats_read(&sq->stats.timeouts=
);
> >                 } while (u64_stats_fetch_retry(&sq->stats.syncp, start)=
);
> >
> >                 do {
> > @@ -4639,7 +4639,7 @@ static void virtnet_tx_timeout(struct net_device =
*dev, unsigned int txqueue)
> >         struct netdev_queue *txq =3D netdev_get_tx_queue(dev, txqueue);
> >
> >         u64_stats_update_begin(&sq->stats.syncp);
> > -       u64_stats_inc(&sq->stats.tx_timeouts);
> > +       u64_stats_inc(&sq->stats.timeouts);
> >         u64_stats_update_end(&sq->stats.syncp);
> >
> >         netdev_err(dev, "TX timeout on queue: %u, sq: %s, vq: 0x%x, nam=
e: %s, %u usecs ago\n",
> > --
> > 2.32.0.3.g01195cf9f
> >
>
