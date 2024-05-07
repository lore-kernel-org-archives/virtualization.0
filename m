Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B44E971754
	for <virtualization@lists.linux.dev>; Tue,  7 May 2024 07:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715065281; cv=none; b=nyj0I0neRQaQ3asVBWfmBF6dQVyHptkYGjg1Zk8KnyCUJau9FGlb4BLJhnoatA7Y27g6GV4FLsOA+5ZWhfZrVd8UKGlh5QOJYsJHCAQJqDb5JFP4Kts7/mKsDUrkdJSOk1FndpuXXUwf3JkTSesQcZq4lcj5gFBaPEjYI4Hxavo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715065281; c=relaxed/simple;
	bh=OJij+/uF1ZYPWxMc7QMzEcxYkC9syvRuRfPvMpjgyyI=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To:
	 Content-Type; b=RZV0a/cQWo6sRRdM2JcozCp+ormzmhe2WmZ/0t41Ko99RU+PYjelGic5wj/0rSBxCyNkhH5lvtcVp/FjkuzbjOTNu3hjA/FVk7+ozq/zrIPC2XTBkTGsXqk8Rv86qeQGCANSYtQwVV+4GNLnrdTmt9IHG30pf9njMlJh0eZtFKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=NQJyFLcM; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="NQJyFLcM"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1715065271; h=Message-ID:Subject:Date:From:To:Content-Type;
	bh=BdAhZYI87jeMuNJTmfFXwT/elkVUxwkPmc/ystwppN0=;
	b=NQJyFLcMGejJvnUgYAq6mf9VePEiWKK96XpInfc3DF9WwIzOBj1muf8pj5M3lNiBbGHYrQlQDu+fpBAm2Fsru5pY0Dkj5hOBmlBVXCoGNLkHTC0Tj48kG6HJuLdRscRy+Qw6NJ5WNtqsnV7ynvodPRNz6X9wCqAZuMipNoIFmXs=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R751e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032014031;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0W6.AoA3_1715065267;
Received: from localhost(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W6.AoA3_1715065267)
          by smtp.aliyun-inc.com;
          Tue, 07 May 2024 15:01:09 +0800
Message-ID: <1715065002.9314177-2-hengqi@linux.alibaba.com>
Subject: Re: [PATCH net-next v2 2/2] virtio_net: get init coalesce value when probe
Date: Tue, 7 May 2024 14:56:42 +0800
From: Heng Qi <hengqi@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
Cc: netdev@vger.kernel.org,
 virtualization@lists.linux.dev,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 Eric Dumazet <edumazet@google.com>,
 "David S . Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
References: <20240426065441.120710-1-hengqi@linux.alibaba.com>
 <20240426065441.120710-3-hengqi@linux.alibaba.com>
 <CACGkMEs9nrFTjLa18XN9ZAokgLsw4MtXM3O3kVmQv=ofP49coA@mail.gmail.com>
In-Reply-To: <CACGkMEs9nrFTjLa18XN9ZAokgLsw4MtXM3O3kVmQv=ofP49coA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

On Tue, 7 May 2024 14:24:12 +0800, Jason Wang <jasowang@redhat.com> wrote:
> On Fri, Apr 26, 2024 at 2:54=E2=80=AFPM Heng Qi <hengqi@linux.alibaba.com=
> wrote:
> >
> > Currently, virtio-net lacks a way to obtain the default coalesce
> > values of the device during the probe phase. That is, the device
> > may have default experience values, but the user uses "ethtool -c"
> > to query that the values are still 0.
> >
> > Therefore, we reuse VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET to complete the go=
al.
> >
> > Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
> > ---
> >  drivers/net/virtio_net.c | 68 +++++++++++++++++++++++++++++++++++-----
> >  1 file changed, 61 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index 3bc9b1e621db..fe0c15819dd3 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -4623,6 +4623,46 @@ static int virtnet_validate(struct virtio_device=
 *vdev)
> >         return 0;
> >  }
> >
> > +static int virtnet_get_coal_init_value(struct virtnet_info *vi,
> > +                                      u16 _vqn, bool is_tx)
> > +{
> > +       struct virtio_net_ctrl_coal *coal =3D &vi->ctrl->coal_vq.coal;
> > +       __le16 *vqn =3D &vi->ctrl->coal_vq.vqn;
> > +       struct scatterlist sgs_in, sgs_out;
> > +       u32 usecs, pkts, i;
> > +       bool ret;
> > +
> > +       *vqn =3D cpu_to_le16(_vqn);
> > +
> > +       sg_init_one(&sgs_out, vqn, sizeof(*vqn));
> > +       sg_init_one(&sgs_in, coal, sizeof(*coal));
> > +       ret =3D virtnet_send_command_reply(vi, VIRTIO_NET_CTRL_NOTF_COA=
L,
> > +                                        VIRTIO_NET_CTRL_NOTF_COAL_VQ_G=
ET,
> > +                                        &sgs_out, &sgs_in);
> > +       if (!ret)
> > +               return ret;
> > +
> > +       usecs =3D le32_to_cpu(coal->max_usecs);
> > +       pkts =3D le32_to_cpu(coal->max_packets);
> > +       if (is_tx) {
> > +               vi->intr_coal_tx.max_usecs =3D usecs;
> > +               vi->intr_coal_tx.max_packets =3D pkts;
> > +               for (i =3D 0; i < vi->max_queue_pairs; i++) {
> > +                       vi->sq[i].intr_coal.max_usecs =3D usecs;
> > +                       vi->sq[i].intr_coal.max_packets =3D pkts;
> > +               }
> > +       } else {
> > +               vi->intr_coal_rx.max_usecs =3D usecs;
> > +               vi->intr_coal_rx.max_packets =3D pkts;
> > +               for (i =3D 0; i < vi->max_queue_pairs; i++) {
> > +                       vi->rq[i].intr_coal.max_usecs =3D usecs;
> > +                       vi->rq[i].intr_coal.max_packets =3D pkts;
> > +               }
> > +       }
> > +
> > +       return 0;
> > +}
> > +
> >  static bool virtnet_check_guest_gso(const struct virtnet_info *vi)
> >  {
> >         return virtio_has_feature(vi->vdev, VIRTIO_NET_F_GUEST_TSO4) ||
> > @@ -4885,13 +4925,6 @@ static int virtnet_probe(struct virtio_device *v=
dev)
> >                         vi->intr_coal_tx.max_packets =3D 0;
> >         }
> >
> > -       if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_VQ_NOTF_COAL)) {
> > -               /* The reason is the same as VIRTIO_NET_F_NOTF_COAL. */
> > -               for (i =3D 0; i < vi->max_queue_pairs; i++)
> > -                       if (vi->sq[i].napi.weight)
> > -                               vi->sq[i].intr_coal.max_packets =3D 1;
> > -       }
> > -
> >  #ifdef CONFIG_SYSFS
> >         if (vi->mergeable_rx_bufs)
> >                 dev->sysfs_rx_queue_group =3D &virtio_net_mrg_rx_group;
> > @@ -4926,6 +4959,27 @@ static int virtnet_probe(struct virtio_device *v=
dev)
> >
> >         virtio_device_ready(vdev);
> >
> > +       if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_VQ_NOTF_COAL)) {
> > +               /* The reason is the same as VIRTIO_NET_F_NOTF_COAL. */
> > +               for (i =3D 0; i < vi->max_queue_pairs; i++)
> > +                       if (vi->sq[i].napi.weight)
> > +                               vi->sq[i].intr_coal.max_packets =3D 1;
> > +
> > +               /* The loop exits if the default value from any
> > +                * queue is successfully read.
> > +                */
>=20
> So this assumes the default values are the same. Is this something
> required by the spec? If not, we probably need to iterate all the
> queues.
>=20

From internal practice, and from the default behavior of other existing dri=
vers,
the queues all have the same value at the beginning, so here it seems feasi=
ble
that we get the value of queue 0 to represent the global value instead of u=
sing
a loop.

Moreover, obtaining the value once for each queue initially does not seem t=
o be
very friendly for devices with a large number of queues.

Thanks.

> Thanks
>=20
>=20
> > +               for (i =3D 0; i < vi->max_queue_pairs; i++) {
> > +                       err =3D virtnet_get_coal_init_value(vi, rxq2vq(=
i), false);
> > +                       if (!err)
> > +                               break;
> > +               }
> > +               for (i =3D 0; i < vi->max_queue_pairs; i++) {
> > +                       err =3D virtnet_get_coal_init_value(vi, txq2vq(=
i), true);
> > +                       if (!err)
> > +                               break;
> > +               }
> > +       }
> > +
> >         _virtnet_set_queues(vi, vi->curr_queue_pairs);
> >
> >         /* a random MAC address has been assigned, notify the device.
> > --
> > 2.32.0.3.g01195cf9f
> >
>=20
