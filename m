Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3674E3A1BA
	for <virtualization@lists.linux.dev>; Mon, 15 Apr 2024 08:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713170095; cv=none; b=oyV2Ega3WAuFa0ww8Sa6tp5ZdD8q0pkwWdnORg4+n8ySiRVnSMcSuH7YQMayaSwq+w/Su3rB08FSuPE3OyxmXnCgDj+5E6AE9j1mnPq9bZ0hUEo0EWnFaJkZFA5tNwLx4qCrKW+KfTJfvVPIGChQRzxqvJkdUwxR4aktnVi9vK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713170095; c=relaxed/simple;
	bh=kP2vVarYJUgfZsE02DabXd55VBnSX70aqj2Sn6PmIYk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZVPg2R5OdzpAgITVhpz3rSb1b2pckIbYuDmREoNz0GBejEoGruLBZUjxNrSCPT7quet0+GdEd/q5bLn/RCgdLXklI9tezUvaK23xoF14CsMWvz3UOrwrZtkuh53mkhOXPFuxW0MzRfKTUfnnyhHo/GqbVBL4zZCPeW6/Xx4Ko5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RzSkp0ff; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RzSkp0ff"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713170092;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=elJjozH+zMMLVFAhsEocpxXCjTMSFN+CvE7S6kRfGzM=;
	b=RzSkp0ff2HBrYqRP2Y59I4fh8a56JQi8iCzHRY45OWYZaiZe39QKSUB8DDV7we9AmUjuJu
	IVmv2qHN/iTn/bVAjYjlhGfwmpJZcVy9vLk0PUOZ5Vy8cPTw97tGS54Ha5UQ5jDONsFw93
	s/rIuCxXlpqth6kVBGEqxzVsyZVYoVA=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-dWzqmJofNdGlD_pOuhLRpw-1; Mon, 15 Apr 2024 04:34:50 -0400
X-MC-Unique: dWzqmJofNdGlD_pOuhLRpw-1
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-5cec8bc5c66so1776668a12.1
        for <virtualization@lists.linux.dev>; Mon, 15 Apr 2024 01:34:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713170089; x=1713774889;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=elJjozH+zMMLVFAhsEocpxXCjTMSFN+CvE7S6kRfGzM=;
        b=hdgnIKXgU4keVL9izGkK30VsixySgYijX3ew95KKjMQEGo9rzLqfSi3TU5mzdPvx/x
         ej8FNpNHcVGhxi5p1z+Ao53rVDL2jd3Qnnw26Oqpq7yxH1Gm0T4U7rnIsOTU2ll3p2Kd
         CKHggXFZxidcwDBcpX72LrbZQLZQeI99L2DVLf/KKFROZ7DxqS3lJYqTqLzjqwIijzWB
         Gs/lBMRUpUGouKFFEZMh+sSHUPHXAeabsrhXqDdVs7ZJXsm5K+c8LRsTTa1wDmyhc3A+
         ei0gxpcQ5F+Axff1ax9xwCMOA9RnOB0v70dyxGYU+nj0mu0FtLN5J9Kvf9Cg68Nh+8lr
         G+cw==
X-Forwarded-Encrypted: i=1; AJvYcCVI+XJyojoCzbQ2T4UI8b0M2B6gqUyjcdh2B6C/QZ/jtBaqyC7Y0rMQfiK/GGj3wKYNaeKjhF6BRswFF+jIQVeK6RqwOWTcdwvRBvip5dM=
X-Gm-Message-State: AOJu0YwNx4fuH66eCU2Q3BxAZPAHjsZEYYqZ0OEAhhr4yXobFG59jQZj
	1ybFKbmHqkQV3xwIqieK00JSr7v4ow48JPa0878HvMA8bvf0EW80erkJmxODFx89QzA18WiKj9C
	bBCwo3oWOGCnLw+C09Y18Gi1DojpQ+mvv8JO/5t1N66ApIrXXbNBdGyhRZLh3uPY8BRZorwSxCU
	i+lJCFPsOmIkLbM3QlAsqfDIIhMpJW/npgw6+DitY=
X-Received: by 2002:a05:6a20:564b:b0:1a7:79b2:ff1b with SMTP id is11-20020a056a20564b00b001a779b2ff1bmr6568165pzc.27.1713170088968;
        Mon, 15 Apr 2024 01:34:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHZmwPZ2hWrbm8QS2tSip80S0YLAIlyuhoPq8TcCqWtl7XkbZ1bqDM/18ra+zjHttBP7954Xc0SAL+7PnM+ihE=
X-Received: by 2002:a05:6a20:564b:b0:1a7:79b2:ff1b with SMTP id
 is11-20020a056a20564b00b001a779b2ff1bmr6568155pzc.27.1713170088618; Mon, 15
 Apr 2024 01:34:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240318110602.37166-1-xuanzhuo@linux.alibaba.com>
 <20240318110602.37166-5-xuanzhuo@linux.alibaba.com> <CACGkMEujuYh+Ups9jx5jEwe7bydtgCyurG5bPLe3X8jpSJhqvA@mail.gmail.com>
 <1712746366.8053942-2-xuanzhuo@linux.alibaba.com> <CACGkMEsvAUyk+h3e5SO5T4L8HuSGcViKj2WM2J33JOb7KTKjUw@mail.gmail.com>
 <1713148927.6675713-2-xuanzhuo@linux.alibaba.com> <CACGkMEvbLvQUppO6nnp0DCxACco7S=2QLgge4ZhARo9Ov_fJKQ@mail.gmail.com>
 <1713168679.2714498-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1713168679.2714498-1-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 15 Apr 2024 16:34:37 +0800
Message-ID: <CACGkMEucuS0yGP1d9w3KEUigGusP_ks71KwZAwuBJNdZQ=v13Q@mail.gmail.com>
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

On Mon, Apr 15, 2024 at 4:15=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> On Mon, 15 Apr 2024 14:45:36 +0800, Jason Wang <jasowang@redhat.com> wrot=
e:
> > On Mon, Apr 15, 2024 at 10:51=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux.alib=
aba.com> wrote:
> > >
> > > On Thu, 11 Apr 2024 14:09:24 +0800, Jason Wang <jasowang@redhat.com> =
wrote:
> > > > On Wed, Apr 10, 2024 at 6:55=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.a=
libaba.com> wrote:
> > > > >
> > > > > On Wed, 10 Apr 2024 14:09:23 +0800, Jason Wang <jasowang@redhat.c=
om> wrote:
> > > > > > On Mon, Mar 18, 2024 at 7:06=E2=80=AFPM Xuan Zhuo <xuanzhuo@lin=
ux.alibaba.com> wrote:
> > > > > > >
> > > > > > > As the spec https://github.com/oasis-tcs/virtio-spec/commit/4=
2f389989823039724f95bbbd243291ab0064f82
> > > > > > >
> > > > > > > make virtio-net support getting the stats from the device by =
ethtool -S
> > > > > > > <eth0>.
> > > > > > >
> > > > > > > Due to the numerous descriptors stats, an organization method=
 is
> > > > > > > required. For this purpose, I have introduced the "virtnet_st=
ats_map".
> > > > > > > Utilizing this array simplifies coding tasks such as generati=
ng field
> > > > > > > names, calculating buffer sizes for requests and responses, a=
nd parsing
> > > > > > > replies from the device. By iterating over the "virtnet_stats=
_map,"
> > > > > > > these operations become more streamlined and efficient.
> > > > > > >
> > > > > > > NIC statistics:
> > > > > > >      rx0_packets: 582951
> > > > > > >      rx0_bytes: 155307077
> > > > > > >      rx0_drops: 0
> > > > > > >      rx0_xdp_packets: 0
> > > > > > >      rx0_xdp_tx: 0
> > > > > > >      rx0_xdp_redirects: 0
> > > > > > >      rx0_xdp_drops: 0
> > > > > > >      rx0_kicks: 17007
> > > > > > >      rx0_hw_packets: 2179409
> > > > > > >      rx0_hw_bytes: 510015040
> > > > > > >      rx0_hw_notifications: 0
> > > > > > >      rx0_hw_interrupts: 0
> > > > > > >      rx0_hw_drops: 12964
> > > > > > >      rx0_hw_drop_overruns: 0
> > > > > > >      rx0_hw_csum_valid: 2179409
> > > > > > >      rx0_hw_csum_none: 0
> > > > > > >      rx0_hw_csum_bad: 0
> > > > > > >      rx0_hw_needs_csum: 2179409
> > > > > > >      rx0_hw_ratelimit_packets: 0
> > > > > > >      rx0_hw_ratelimit_bytes: 0
> > > > > > >      tx0_packets: 15361
> > > > > > >      tx0_bytes: 1918970
> > > > > > >      tx0_xdp_tx: 0
> > > > > > >      tx0_xdp_tx_drops: 0
> > > > > > >      tx0_kicks: 15361
> > > > > > >      tx0_timeouts: 0
> > > > > > >      tx0_hw_packets: 32272
> > > > > > >      tx0_hw_bytes: 4311698
> > > > > > >      tx0_hw_notifications: 0
> > > > > > >      tx0_hw_interrupts: 0
> > > > > > >      tx0_hw_drops: 0
> > > > > > >      tx0_hw_drop_malformed: 0
> > > > > > >      tx0_hw_csum_none: 0
> > > > > > >      tx0_hw_needs_csum: 32272
> > > > > > >      tx0_hw_ratelimit_packets: 0
> > > > > > >      tx0_hw_ratelimit_bytes: 0
> > > > > > >
> > > > > > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > > > > > ---
> > > > > > >  drivers/net/virtio_net.c | 401 +++++++++++++++++++++++++++++=
+++++++++-
> > > > > > >  1 file changed, 397 insertions(+), 4 deletions(-)
> > > > > > >
> > > > > > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_ne=
t.c
> > > > > > > index 8cb5bdd7ad91..70c1d4e850e0 100644
> > > > > > > --- a/drivers/net/virtio_net.c
> > > > > > > +++ b/drivers/net/virtio_net.c
> > > > > > > @@ -128,6 +128,129 @@ static const struct virtnet_stat_desc v=
irtnet_rq_stats_desc[] =3D {
> > > > > > >  #define VIRTNET_SQ_STATS_LEN   ARRAY_SIZE(virtnet_sq_stats_d=
esc)
> > > > > > >  #define VIRTNET_RQ_STATS_LEN   ARRAY_SIZE(virtnet_rq_stats_d=
esc)
> > > > > > >
> > > > > > > +#define VIRTNET_STATS_DESC_CQ(name) \
> > > > > > > +       {#name, offsetof(struct virtio_net_stats_cvq, name)}
> > > > > > > +
> > > > > > > +#define VIRTNET_STATS_DESC_RX(class, name) \
> > > > > > > +       {#name, offsetof(struct virtio_net_stats_rx_ ## class=
, rx_ ## name)}
> > > > > > > +
> > > > > > > +#define VIRTNET_STATS_DESC_TX(class, name) \
> > > > > > > +       {#name, offsetof(struct virtio_net_stats_tx_ ## class=
, tx_ ## name)}
> > > > > > > +
> > > > > > > +static const struct virtnet_stat_desc virtnet_stats_cvq_desc=
[] =3D {
> > > > > > > +       VIRTNET_STATS_DESC_CQ(command_num),
> > > > > > > +       VIRTNET_STATS_DESC_CQ(ok_num),
> > > > > > > +};
> > > > > > > +
> > > > > > > +static const struct virtnet_stat_desc virtnet_stats_rx_basic=
_desc[] =3D {
> > > > > > > +       VIRTNET_STATS_DESC_RX(basic, packets),
> > > > > > > +       VIRTNET_STATS_DESC_RX(basic, bytes),
> > > > > > > +
> > > > > > > +       VIRTNET_STATS_DESC_RX(basic, notifications),
> > > > > > > +       VIRTNET_STATS_DESC_RX(basic, interrupts),
> > > > > > > +
> > > > > > > +       VIRTNET_STATS_DESC_RX(basic, drops),
> > > > > > > +       VIRTNET_STATS_DESC_RX(basic, drop_overruns),
> > > > > > > +};
> > > > > > > +
> > > > > > > +static const struct virtnet_stat_desc virtnet_stats_tx_basic=
_desc[] =3D {
> > > > > > > +       VIRTNET_STATS_DESC_TX(basic, packets),
> > > > > > > +       VIRTNET_STATS_DESC_TX(basic, bytes),
> > > > > > > +
> > > > > > > +       VIRTNET_STATS_DESC_TX(basic, notifications),
> > > > > > > +       VIRTNET_STATS_DESC_TX(basic, interrupts),
> > > > > > > +
> > > > > > > +       VIRTNET_STATS_DESC_TX(basic, drops),
> > > > > > > +       VIRTNET_STATS_DESC_TX(basic, drop_malformed),
> > > > > > > +};
> > > > > > > +
> > > > > > > +static const struct virtnet_stat_desc virtnet_stats_rx_csum_=
desc[] =3D {
> > > > > > > +       VIRTNET_STATS_DESC_RX(csum, csum_valid),
> > > > > > > +       VIRTNET_STATS_DESC_RX(csum, needs_csum),
> > > > > > > +
> > > > > > > +       VIRTNET_STATS_DESC_RX(csum, csum_none),
> > > > > > > +       VIRTNET_STATS_DESC_RX(csum, csum_bad),
> > > > > > > +};
> > > > > > > +
> > > > > > > +static const struct virtnet_stat_desc virtnet_stats_tx_csum_=
desc[] =3D {
> > > > > > > +       VIRTNET_STATS_DESC_TX(csum, needs_csum),
> > > > > > > +       VIRTNET_STATS_DESC_TX(csum, csum_none),
> > > > > > > +};
> > > > > > > +
> > > > > > > +static const struct virtnet_stat_desc virtnet_stats_rx_gso_d=
esc[] =3D {
> > > > > > > +       VIRTNET_STATS_DESC_RX(gso, gso_packets),
> > > > > > > +       VIRTNET_STATS_DESC_RX(gso, gso_bytes),
> > > > > > > +       VIRTNET_STATS_DESC_RX(gso, gso_packets_coalesced),
> > > > > > > +       VIRTNET_STATS_DESC_RX(gso, gso_bytes_coalesced),
> > > > > > > +};
> > > > > > > +
> > > > > > > +static const struct virtnet_stat_desc virtnet_stats_tx_gso_d=
esc[] =3D {
> > > > > > > +       VIRTNET_STATS_DESC_TX(gso, gso_packets),
> > > > > > > +       VIRTNET_STATS_DESC_TX(gso, gso_bytes),
> > > > > > > +       VIRTNET_STATS_DESC_TX(gso, gso_segments),
> > > > > > > +       VIRTNET_STATS_DESC_TX(gso, gso_segments_bytes),
> > > > > > > +       VIRTNET_STATS_DESC_TX(gso, gso_packets_noseg),
> > > > > > > +       VIRTNET_STATS_DESC_TX(gso, gso_bytes_noseg),
> > > > > > > +};
> > > > > > > +
> > > > > > > +static const struct virtnet_stat_desc virtnet_stats_rx_speed=
_desc[] =3D {
> > > > > > > +       VIRTNET_STATS_DESC_RX(speed, ratelimit_packets),
> > > > > > > +       VIRTNET_STATS_DESC_RX(speed, ratelimit_bytes),
> > > > > > > +};
> > > > > > > +
> > > > > > > +static const struct virtnet_stat_desc virtnet_stats_tx_speed=
_desc[] =3D {
> > > > > > > +       VIRTNET_STATS_DESC_TX(speed, ratelimit_packets),
> > > > > > > +       VIRTNET_STATS_DESC_TX(speed, ratelimit_bytes),
> > > > > > > +};
> > > > > > > +
> > > > > > > +#define VIRTNET_Q_TYPE_RX 0
> > > > > > > +#define VIRTNET_Q_TYPE_TX 1
> > > > > > > +#define VIRTNET_Q_TYPE_CQ 2
> > > > > > > +
> > > > > > > +struct virtnet_stats_map {
> > > > > > > +       /* The stat type in bitmap. */
> > > > > > > +       u64 stat_type;
> > > > > > > +
> > > > > > > +       /* The bytes of the response for the stat. */
> > > > > > > +       u32 len;
> > > > > > > +
> > > > > > > +       /* The num of the response fields for the stat. */
> > > > > > > +       u32 num;
> > > > > > > +
> > > > > > > +       /* The type of queue corresponding to the statistics.=
 (cq, rq, sq) */
> > > > > > > +       u32 queue_type;
> > > > > > > +
> > > > > > > +       /* The reply type of the stat. */
> > > > > > > +       u8 reply_type;
> > > > > > > +
> > > > > > > +       /* Describe the name and the offset in the response. =
*/
> > > > > > > +       const struct virtnet_stat_desc *desc;
> > > > > > > +};
> > > > > > > +
> > > > > > > +#define VIRTNET_DEVICE_STATS_MAP_ITEM(TYPE, type, queue_type=
)  \
> > > > > > > +       {                                                    =
   \
> > > > > > > +               VIRTIO_NET_STATS_TYPE_##TYPE,                =
   \
> > > > > > > +               sizeof(struct virtio_net_stats_ ## type),    =
   \
> > > > > > > +               ARRAY_SIZE(virtnet_stats_ ## type ##_desc),  =
   \
> > > > > > > +               VIRTNET_Q_TYPE_##queue_type,                 =
   \
> > > > > > > +               VIRTIO_NET_STATS_TYPE_REPLY_##TYPE,          =
   \
> > > > > > > +               &virtnet_stats_##type##_desc[0]              =
   \
> > > > > > > +       }
> > > > > > > +
> > > > > > > +static struct virtnet_stats_map virtio_net_stats_map[] =3D {
> > > > > > > +       VIRTNET_DEVICE_STATS_MAP_ITEM(CVQ, cvq, CQ),
> > > > > > > +
> > > > > > > +       VIRTNET_DEVICE_STATS_MAP_ITEM(RX_BASIC, rx_basic, RX)=
,
> > > > > > > +       VIRTNET_DEVICE_STATS_MAP_ITEM(RX_CSUM,  rx_csum,  RX)=
,
> > > > > > > +       VIRTNET_DEVICE_STATS_MAP_ITEM(RX_GSO,   rx_gso,   RX)=
,
> > > > > > > +       VIRTNET_DEVICE_STATS_MAP_ITEM(RX_SPEED, rx_speed, RX)=
,
> > > > > > > +
> > > > > > > +       VIRTNET_DEVICE_STATS_MAP_ITEM(TX_BASIC, tx_basic, TX)=
,
> > > > > > > +       VIRTNET_DEVICE_STATS_MAP_ITEM(TX_CSUM,  tx_csum,  TX)=
,
> > > > > > > +       VIRTNET_DEVICE_STATS_MAP_ITEM(TX_GSO,   tx_gso,   TX)=
,
> > > > > > > +       VIRTNET_DEVICE_STATS_MAP_ITEM(TX_SPEED, tx_speed, TX)=
,
> > > > > > > +};
> > > > > >
> > > > > > I think the reason you did this is to ease the future extension=
s but
> > > > > > multiple levels of nested macros makes the code hard to review.=
 Any
> > > > > > way to eliminate this?
> > > > >
> > > > >
> > > > > NOT only for the future extensions.
> > > > >
> > > > > When we parse the reply from the device, we need to check the rep=
ly stats
> > > > > one by one, we need the stats info to help parse the stats.
> > > >
> > > > Yes, but I meant for example any reason why it can't be done by
> > > > extending virtnet_stat_desc ?
> > >
> > >
> > >
> > > You know, virtio_net_stats_map is way to organize the descs.
> > >
> > > This is used to avoid the big if-else when parsing the replys from th=
e device.
> > >
> > > If no this map, we will have a big if-else like:
> > >
> > >  if (reply.type =3D=3D rx_basic) {
> > >          /* do the same something */
> > >  }
> > >  if (reply.type =3D=3D tx_basic) {
> > >          /* do the same something */
> > >  }
> > >  if (reply.type =3D=3D rx_csum) {
> > >          /* do the same something */
> > >  }
> > >  if (reply.type =3D=3D tx_csum) {
> > >          /* do the same something */
> > >  }
> > >  if (reply.type =3D=3D rx_gso) {
> > >          /* do the same something */
> > >  }
> > >  if (reply.type =3D=3D tx_gso) {
> > >          /* do the same something */
> > >  }
> > >  if (reply.type =3D=3D rx_speed) {
> > >          /* do the same something */
> > >  }
> > >  if (reply.type =3D=3D tx_speed) {
> > >          /* do the same something */
> > >  }
> > >
> > > I want to avoid this, so introducing this map.
> >
> > Could we have a function pointers array indexed by the type?
>
> Then these functions will be similar and mass.
>
> Maybe we can start with the if-else or the function.
> That will be easy to review. We can optimize on that.

Fine with me.

Thanks

>
> Thanks.
>
>
>
> >
> > Thanks
> >
> > >
> > > YES. I noticed other comments, but I think we should
> > > fix this problem firstly.
> > >
> > > Thanks.
> > >
> > >
> > > >
> > > > >
> > > > >         static void virtnet_fill_stats(struct virtnet_info *vi, u=
32 qid,
> > > > >                                       struct virtnet_stats_ctx *c=
tx,
> > > > >                                       const u8 *base, u8 type)
> > > > >         {
> > > > >                u32 queue_type, num_rx, num_tx, num_cq;
> > > > >                struct virtnet_stats_map *m;
> > > > >                u64 offset, bitmap;
> > > > >                const __le64 *v;
> > > > >                int i, j;
> > > > >
> > > > >                num_rx =3D VIRTNET_RQ_STATS_LEN + ctx->desc_num[VI=
RTNET_Q_TYPE_RX];
> > > > >                num_tx =3D VIRTNET_SQ_STATS_LEN + ctx->desc_num[VI=
RTNET_Q_TYPE_TX];
> > > > >                num_cq =3D ctx->desc_num[VIRTNET_Q_TYPE_CQ];
> > > > >
> > > > >                queue_type =3D vq_type(vi, qid);
> > > > >                bitmap =3D ctx->bitmap[queue_type];
> > > > >                offset =3D 0;
> > > > >
> > > > >                if (queue_type =3D=3D VIRTNET_Q_TYPE_TX) {
> > > > >                        offset =3D num_cq + num_rx * vi->curr_queu=
e_pairs + num_tx * (qid / 2);
> > > > >                        offset +=3D VIRTNET_SQ_STATS_LEN;
> > > > >                } else if (queue_type =3D=3D VIRTNET_Q_TYPE_RX) {
> > > > >                        offset =3D num_cq + num_rx * (qid / 2) + V=
IRTNET_RQ_STATS_LEN;
> > > > >                }
> > > > >
> > > > >                for (i =3D 0; i < ARRAY_SIZE(virtio_net_stats_map)=
; ++i) {
> > > > >                        m =3D &virtio_net_stats_map[i];
> > > > >
> > > > > ->                     if (m->stat_type & bitmap)
> > > > >                                offset +=3D m->num;
> > > > >
> > > > > ->                     if (type !=3D m->reply_type)
> > > > >                                continue;
> > > > >
> > > > >                        for (j =3D 0; j < m->num; ++j) {
> > > > >                                v =3D (const __le64 *)(base + m->d=
esc[j].offset);
> > > > >                                ctx->data[offset + j] =3D le64_to_=
cpu(*v);
> > > > >                        }
> > > > >
> > > > >                        break;
> > > > >                }
> > > > >         }
> > > > >
> > > > > Thanks.
> > > >
> > > > Btw, just a reminder, there are other comments for this patch.
> > > >
> > > > Thanks
> > > >
> > >
> >
>

