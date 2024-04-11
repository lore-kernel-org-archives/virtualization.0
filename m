Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36F3513CA86
	for <virtualization@lists.linux.dev>; Thu, 11 Apr 2024 06:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712815782; cv=none; b=TZnHj+2SuDDfmk0vcxWw8XAoGdvOQt1D58M5gP4w6GAZA1OUMQNg7ZxCJ8QrQvF8LgKfWpeeqZ9czshgD6+PWPHzFUrkXwMx0voBxq/sPRTLKoUtfRV82lFt67kn855qBTD7cbVMmH24QWmKQMt8YGsGhLxTZNLVR4X3kdtVhhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712815782; c=relaxed/simple;
	bh=bqgPaNi5Sl55CDHc491bvtSz92fRovu1JYWxQ+edQu8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UqwejFZ58ZkYEiELl7pItm9M/0DF7XgtMEm27eJ2hTXOfzaLLwWCHObbeNaeviJlq1nAy74UhrnZPKJ3DrnKj0TbwuxxSkXLLsRlEpwok62IYBvssG2A5BHNa82E+v92XIDX3Po8Q34XvzRbpE8VMjmNkOhV81Zsc6Rq192y08o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KTNIPtU3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KTNIPtU3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712815779;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QIFdKQqYsA3zYt8ykZHRA8xZ5gGnHgk5nMJ4jMinf0s=;
	b=KTNIPtU3lLCmeVM0fr1IqCoKcTLCccQ7iXOhbJigeOL13G8aPdLntxVfTgg8MXVlSKO0OY
	WTIOAlafg0UNadQXV3Z1yFYx4zNSy1U0BuceGUwtP/WkiM8Te1G3z18pdd1GcchYqT2RLG
	JZkRQ6T6ZvE4MaoHREUCnD8inKuioH4=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-549-GZI75igYPGeK3Lr3yeawSA-1; Thu, 11 Apr 2024 02:09:37 -0400
X-MC-Unique: GZI75igYPGeK3Lr3yeawSA-1
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-1e2c1ce5d14so60346345ad.3
        for <virtualization@lists.linux.dev>; Wed, 10 Apr 2024 23:09:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712815776; x=1713420576;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QIFdKQqYsA3zYt8ykZHRA8xZ5gGnHgk5nMJ4jMinf0s=;
        b=WUCX9A7WYMXiabYCcGnU0fpmdWU/OI5mbLdiod0cW0cCphiOot36Ltoqo4vDTbChf8
         XT+e9fefVDjEQ9zj1Zv7O7/vOXcCQ8blDv0j9zXvpEHR4MgrzH5QCgRjuILzgtryX1Wt
         KnMVHewrwnlyeSFe3T18ACfNnlxax1kUKJb9JE1Z0uBFBo8Wt8u0PbURlehI0uhOubRk
         /70dN/C7QWyWkLkC4IrS5/sU0kV8PVqH23XxXcYzkP5wTXsPEAmS1W1pSsyU/ySlwdBd
         TbuN6kxBFkfDO4ftTHGjvKSch0nKErvz0Ds3e+MfYuTH5gY/QtZAOoAd3lpFKt3O8Npv
         uXXQ==
X-Forwarded-Encrypted: i=1; AJvYcCXhzokgxet5NmAVDVcLvUNA4bQMTAX2cAdryv+LvtR0/Rj4b8321pAngGQ9rNj17a+p56EoYOUdBAy2Dqce9blTh6f/f9xJDbF3sosYsD8=
X-Gm-Message-State: AOJu0YzcraCoLfA1FtLOvCvMzkMCjyeSO8Fq6R4qkMB/0z8sM6ISawWP
	7I+21q69ksZSU/1y4oLHnf0kYJl2rXO3YO3wLEeRuw+ADOSCl4NqAJm4cWpgtgeW2J3uqaENeXV
	eA+Yjxx1mK58xkB+eSZRQwfAj9kK8NJWOhIojuXV9e/wpIWrN6xCoB55PyBPWDo2xETHsFwEKah
	9xaMFJbO+WeCbs6WNTLCWneLNfcBu8ltQQTHsfUWo=
X-Received: by 2002:a17:902:8ec6:b0:1dd:7059:a714 with SMTP id x6-20020a1709028ec600b001dd7059a714mr4314308plo.30.1712815776567;
        Wed, 10 Apr 2024 23:09:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH0JSbHWeN69zUwICw7dBc+Q8GJhjE2SWRhqrCXw+igoLINgWAwDSeXCuko7f7QQzQ/hcdA8WOexww/r9cmQps=
X-Received: by 2002:a17:902:8ec6:b0:1dd:7059:a714 with SMTP id
 x6-20020a1709028ec600b001dd7059a714mr4314287plo.30.1712815776234; Wed, 10 Apr
 2024 23:09:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240318110602.37166-1-xuanzhuo@linux.alibaba.com>
 <20240318110602.37166-5-xuanzhuo@linux.alibaba.com> <CACGkMEujuYh+Ups9jx5jEwe7bydtgCyurG5bPLe3X8jpSJhqvA@mail.gmail.com>
 <1712746366.8053942-2-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1712746366.8053942-2-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 11 Apr 2024 14:09:24 +0800
Message-ID: <CACGkMEsvAUyk+h3e5SO5T4L8HuSGcViKj2WM2J33JOb7KTKjUw@mail.gmail.com>
Subject: Re: [PATCH net-next v5 4/9] virtio_net: support device stats
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@google.com>, Amritha Nambiar <amritha.nambiar@intel.com>, 
	Larysa Zaremba <larysa.zaremba@intel.com>, Sridhar Samudrala <sridhar.samudrala@intel.com>, 
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>, virtualization@lists.linux.dev, 
	bpf@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 10, 2024 at 6:55=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> On Wed, 10 Apr 2024 14:09:23 +0800, Jason Wang <jasowang@redhat.com> wrot=
e:
> > On Mon, Mar 18, 2024 at 7:06=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.aliba=
ba.com> wrote:
> > >
> > > As the spec https://github.com/oasis-tcs/virtio-spec/commit/42f389989=
823039724f95bbbd243291ab0064f82
> > >
> > > make virtio-net support getting the stats from the device by ethtool =
-S
> > > <eth0>.
> > >
> > > Due to the numerous descriptors stats, an organization method is
> > > required. For this purpose, I have introduced the "virtnet_stats_map"=
.
> > > Utilizing this array simplifies coding tasks such as generating field
> > > names, calculating buffer sizes for requests and responses, and parsi=
ng
> > > replies from the device. By iterating over the "virtnet_stats_map,"
> > > these operations become more streamlined and efficient.
> > >
> > > NIC statistics:
> > >      rx0_packets: 582951
> > >      rx0_bytes: 155307077
> > >      rx0_drops: 0
> > >      rx0_xdp_packets: 0
> > >      rx0_xdp_tx: 0
> > >      rx0_xdp_redirects: 0
> > >      rx0_xdp_drops: 0
> > >      rx0_kicks: 17007
> > >      rx0_hw_packets: 2179409
> > >      rx0_hw_bytes: 510015040
> > >      rx0_hw_notifications: 0
> > >      rx0_hw_interrupts: 0
> > >      rx0_hw_drops: 12964
> > >      rx0_hw_drop_overruns: 0
> > >      rx0_hw_csum_valid: 2179409
> > >      rx0_hw_csum_none: 0
> > >      rx0_hw_csum_bad: 0
> > >      rx0_hw_needs_csum: 2179409
> > >      rx0_hw_ratelimit_packets: 0
> > >      rx0_hw_ratelimit_bytes: 0
> > >      tx0_packets: 15361
> > >      tx0_bytes: 1918970
> > >      tx0_xdp_tx: 0
> > >      tx0_xdp_tx_drops: 0
> > >      tx0_kicks: 15361
> > >      tx0_timeouts: 0
> > >      tx0_hw_packets: 32272
> > >      tx0_hw_bytes: 4311698
> > >      tx0_hw_notifications: 0
> > >      tx0_hw_interrupts: 0
> > >      tx0_hw_drops: 0
> > >      tx0_hw_drop_malformed: 0
> > >      tx0_hw_csum_none: 0
> > >      tx0_hw_needs_csum: 32272
> > >      tx0_hw_ratelimit_packets: 0
> > >      tx0_hw_ratelimit_bytes: 0
> > >
> > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > ---
> > >  drivers/net/virtio_net.c | 401 +++++++++++++++++++++++++++++++++++++=
+-
> > >  1 file changed, 397 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > index 8cb5bdd7ad91..70c1d4e850e0 100644
> > > --- a/drivers/net/virtio_net.c
> > > +++ b/drivers/net/virtio_net.c
> > > @@ -128,6 +128,129 @@ static const struct virtnet_stat_desc virtnet_r=
q_stats_desc[] =3D {
> > >  #define VIRTNET_SQ_STATS_LEN   ARRAY_SIZE(virtnet_sq_stats_desc)
> > >  #define VIRTNET_RQ_STATS_LEN   ARRAY_SIZE(virtnet_rq_stats_desc)
> > >
> > > +#define VIRTNET_STATS_DESC_CQ(name) \
> > > +       {#name, offsetof(struct virtio_net_stats_cvq, name)}
> > > +
> > > +#define VIRTNET_STATS_DESC_RX(class, name) \
> > > +       {#name, offsetof(struct virtio_net_stats_rx_ ## class, rx_ ##=
 name)}
> > > +
> > > +#define VIRTNET_STATS_DESC_TX(class, name) \
> > > +       {#name, offsetof(struct virtio_net_stats_tx_ ## class, tx_ ##=
 name)}
> > > +
> > > +static const struct virtnet_stat_desc virtnet_stats_cvq_desc[] =3D {
> > > +       VIRTNET_STATS_DESC_CQ(command_num),
> > > +       VIRTNET_STATS_DESC_CQ(ok_num),
> > > +};
> > > +
> > > +static const struct virtnet_stat_desc virtnet_stats_rx_basic_desc[] =
=3D {
> > > +       VIRTNET_STATS_DESC_RX(basic, packets),
> > > +       VIRTNET_STATS_DESC_RX(basic, bytes),
> > > +
> > > +       VIRTNET_STATS_DESC_RX(basic, notifications),
> > > +       VIRTNET_STATS_DESC_RX(basic, interrupts),
> > > +
> > > +       VIRTNET_STATS_DESC_RX(basic, drops),
> > > +       VIRTNET_STATS_DESC_RX(basic, drop_overruns),
> > > +};
> > > +
> > > +static const struct virtnet_stat_desc virtnet_stats_tx_basic_desc[] =
=3D {
> > > +       VIRTNET_STATS_DESC_TX(basic, packets),
> > > +       VIRTNET_STATS_DESC_TX(basic, bytes),
> > > +
> > > +       VIRTNET_STATS_DESC_TX(basic, notifications),
> > > +       VIRTNET_STATS_DESC_TX(basic, interrupts),
> > > +
> > > +       VIRTNET_STATS_DESC_TX(basic, drops),
> > > +       VIRTNET_STATS_DESC_TX(basic, drop_malformed),
> > > +};
> > > +
> > > +static const struct virtnet_stat_desc virtnet_stats_rx_csum_desc[] =
=3D {
> > > +       VIRTNET_STATS_DESC_RX(csum, csum_valid),
> > > +       VIRTNET_STATS_DESC_RX(csum, needs_csum),
> > > +
> > > +       VIRTNET_STATS_DESC_RX(csum, csum_none),
> > > +       VIRTNET_STATS_DESC_RX(csum, csum_bad),
> > > +};
> > > +
> > > +static const struct virtnet_stat_desc virtnet_stats_tx_csum_desc[] =
=3D {
> > > +       VIRTNET_STATS_DESC_TX(csum, needs_csum),
> > > +       VIRTNET_STATS_DESC_TX(csum, csum_none),
> > > +};
> > > +
> > > +static const struct virtnet_stat_desc virtnet_stats_rx_gso_desc[] =
=3D {
> > > +       VIRTNET_STATS_DESC_RX(gso, gso_packets),
> > > +       VIRTNET_STATS_DESC_RX(gso, gso_bytes),
> > > +       VIRTNET_STATS_DESC_RX(gso, gso_packets_coalesced),
> > > +       VIRTNET_STATS_DESC_RX(gso, gso_bytes_coalesced),
> > > +};
> > > +
> > > +static const struct virtnet_stat_desc virtnet_stats_tx_gso_desc[] =
=3D {
> > > +       VIRTNET_STATS_DESC_TX(gso, gso_packets),
> > > +       VIRTNET_STATS_DESC_TX(gso, gso_bytes),
> > > +       VIRTNET_STATS_DESC_TX(gso, gso_segments),
> > > +       VIRTNET_STATS_DESC_TX(gso, gso_segments_bytes),
> > > +       VIRTNET_STATS_DESC_TX(gso, gso_packets_noseg),
> > > +       VIRTNET_STATS_DESC_TX(gso, gso_bytes_noseg),
> > > +};
> > > +
> > > +static const struct virtnet_stat_desc virtnet_stats_rx_speed_desc[] =
=3D {
> > > +       VIRTNET_STATS_DESC_RX(speed, ratelimit_packets),
> > > +       VIRTNET_STATS_DESC_RX(speed, ratelimit_bytes),
> > > +};
> > > +
> > > +static const struct virtnet_stat_desc virtnet_stats_tx_speed_desc[] =
=3D {
> > > +       VIRTNET_STATS_DESC_TX(speed, ratelimit_packets),
> > > +       VIRTNET_STATS_DESC_TX(speed, ratelimit_bytes),
> > > +};
> > > +
> > > +#define VIRTNET_Q_TYPE_RX 0
> > > +#define VIRTNET_Q_TYPE_TX 1
> > > +#define VIRTNET_Q_TYPE_CQ 2
> > > +
> > > +struct virtnet_stats_map {
> > > +       /* The stat type in bitmap. */
> > > +       u64 stat_type;
> > > +
> > > +       /* The bytes of the response for the stat. */
> > > +       u32 len;
> > > +
> > > +       /* The num of the response fields for the stat. */
> > > +       u32 num;
> > > +
> > > +       /* The type of queue corresponding to the statistics. (cq, rq=
, sq) */
> > > +       u32 queue_type;
> > > +
> > > +       /* The reply type of the stat. */
> > > +       u8 reply_type;
> > > +
> > > +       /* Describe the name and the offset in the response. */
> > > +       const struct virtnet_stat_desc *desc;
> > > +};
> > > +
> > > +#define VIRTNET_DEVICE_STATS_MAP_ITEM(TYPE, type, queue_type)  \
> > > +       {                                                       \
> > > +               VIRTIO_NET_STATS_TYPE_##TYPE,                   \
> > > +               sizeof(struct virtio_net_stats_ ## type),       \
> > > +               ARRAY_SIZE(virtnet_stats_ ## type ##_desc),     \
> > > +               VIRTNET_Q_TYPE_##queue_type,                    \
> > > +               VIRTIO_NET_STATS_TYPE_REPLY_##TYPE,             \
> > > +               &virtnet_stats_##type##_desc[0]                 \
> > > +       }
> > > +
> > > +static struct virtnet_stats_map virtio_net_stats_map[] =3D {
> > > +       VIRTNET_DEVICE_STATS_MAP_ITEM(CVQ, cvq, CQ),
> > > +
> > > +       VIRTNET_DEVICE_STATS_MAP_ITEM(RX_BASIC, rx_basic, RX),
> > > +       VIRTNET_DEVICE_STATS_MAP_ITEM(RX_CSUM,  rx_csum,  RX),
> > > +       VIRTNET_DEVICE_STATS_MAP_ITEM(RX_GSO,   rx_gso,   RX),
> > > +       VIRTNET_DEVICE_STATS_MAP_ITEM(RX_SPEED, rx_speed, RX),
> > > +
> > > +       VIRTNET_DEVICE_STATS_MAP_ITEM(TX_BASIC, tx_basic, TX),
> > > +       VIRTNET_DEVICE_STATS_MAP_ITEM(TX_CSUM,  tx_csum,  TX),
> > > +       VIRTNET_DEVICE_STATS_MAP_ITEM(TX_GSO,   tx_gso,   TX),
> > > +       VIRTNET_DEVICE_STATS_MAP_ITEM(TX_SPEED, tx_speed, TX),
> > > +};
> >
> > I think the reason you did this is to ease the future extensions but
> > multiple levels of nested macros makes the code hard to review. Any
> > way to eliminate this?
>
>
> NOT only for the future extensions.
>
> When we parse the reply from the device, we need to check the reply stats
> one by one, we need the stats info to help parse the stats.

Yes, but I meant for example any reason why it can't be done by
extending virtnet_stat_desc ?

>
>         static void virtnet_fill_stats(struct virtnet_info *vi, u32 qid,
>                                       struct virtnet_stats_ctx *ctx,
>                                       const u8 *base, u8 type)
>         {
>                u32 queue_type, num_rx, num_tx, num_cq;
>                struct virtnet_stats_map *m;
>                u64 offset, bitmap;
>                const __le64 *v;
>                int i, j;
>
>                num_rx =3D VIRTNET_RQ_STATS_LEN + ctx->desc_num[VIRTNET_Q_=
TYPE_RX];
>                num_tx =3D VIRTNET_SQ_STATS_LEN + ctx->desc_num[VIRTNET_Q_=
TYPE_TX];
>                num_cq =3D ctx->desc_num[VIRTNET_Q_TYPE_CQ];
>
>                queue_type =3D vq_type(vi, qid);
>                bitmap =3D ctx->bitmap[queue_type];
>                offset =3D 0;
>
>                if (queue_type =3D=3D VIRTNET_Q_TYPE_TX) {
>                        offset =3D num_cq + num_rx * vi->curr_queue_pairs =
+ num_tx * (qid / 2);
>                        offset +=3D VIRTNET_SQ_STATS_LEN;
>                } else if (queue_type =3D=3D VIRTNET_Q_TYPE_RX) {
>                        offset =3D num_cq + num_rx * (qid / 2) + VIRTNET_R=
Q_STATS_LEN;
>                }
>
>                for (i =3D 0; i < ARRAY_SIZE(virtio_net_stats_map); ++i) {
>                        m =3D &virtio_net_stats_map[i];
>
> ->                     if (m->stat_type & bitmap)
>                                offset +=3D m->num;
>
> ->                     if (type !=3D m->reply_type)
>                                continue;
>
>                        for (j =3D 0; j < m->num; ++j) {
>                                v =3D (const __le64 *)(base + m->desc[j].o=
ffset);
>                                ctx->data[offset + j] =3D le64_to_cpu(*v);
>                        }
>
>                        break;
>                }
>         }
>
> Thanks.

Btw, just a reminder, there are other comments for this patch.

Thanks

