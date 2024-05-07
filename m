Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FF3C40BE6
	for <virtualization@lists.linux.dev>; Tue,  7 May 2024 04:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715054607; cv=none; b=TA4psPaNUlt8HY2SFl6X2q1qllu9ccf2TgPPg/VQaJQDUs0gy3SRcVJhkP6skaN1s7qHMO1DA1cI9WjAgW1s5stpQcLylPu+C7qDtg844eX5mUg7WzXlzW3Ocl3hEQ2HHJBZdxwZJ++OgElwUiinf9xLoKiLIjZV9GJBoArixVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715054607; c=relaxed/simple;
	bh=FqV3AbKlccRXCFqRxRE8vsbribJLrStV4+LVYDVI3FQ=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To:
	 Content-Type; b=h1iCSpzspKt92qJETZUEKpv52JslXf/iEQNXTzx0uxfCO8ld+qUJ7YOGVGQQRZwrjpyiFUiZ3wJVjFRoyDIHpcy1APAGvasaZIiBtNgkiwEbsRJDIJiR4RPVfWIK5cqYuyPeXPIpnNbw+vxv92DTWMpLto5JDWm1dlE0PQ2FBBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=SY1sZnWI; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="SY1sZnWI"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1715054596; h=Message-ID:Subject:Date:From:To:Content-Type;
	bh=drFKTC1lCB74URextnlQhzXn22hNILgXybh4fhLMzaA=;
	b=SY1sZnWIjQEDAJdBSrBqiGKTMM8n5HVcV1+86h03kFq4OVQbRRUiixlJTn4aZg/6H3m/MUxE9LEz9Ct8mf6/Y3zNKhSPg0pNirLoqFc9ZeSwAmMPt8p+YJIiVM1F5rV/uZp4pxzR38M5VO/BoFYYlCb/kDTQT9+TfX9fw/2dVfI=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R381e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033068173054;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0W6-mMtE_1715054594;
Received: from localhost(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W6-mMtE_1715054594)
          by smtp.aliyun-inc.com;
          Tue, 07 May 2024 12:03:15 +0800
Message-ID: <1715054136.4593592-1-hengqi@linux.alibaba.com>
Subject: Re: [PATCH net-next 1/3] virtio_net: enable irq for the control vq
Date: Tue, 7 May 2024 11:55:36 +0800
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
References: <20240425125855.87025-1-hengqi@linux.alibaba.com>
 <20240425125855.87025-2-hengqi@linux.alibaba.com>
 <CACGkMEtpy0ZDcGQReaPVtJy4hDcqdKQwEF2Uhf5W4+7g=jts-Q@mail.gmail.com>
In-Reply-To: <CACGkMEtpy0ZDcGQReaPVtJy4hDcqdKQwEF2Uhf5W4+7g=jts-Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

On Tue, 7 May 2024 11:15:22 +0800, Jason Wang <jasowang@redhat.com> wrote:
> On Thu, Apr 25, 2024 at 8:59=E2=80=AFPM Heng Qi <hengqi@linux.alibaba.com=
> wrote:
> >
> > Control vq polling request results consume more CPU.
> > Especially when dim issues more control requests to the device,
> > it's beneficial to the guest to enable control vq's irq.
> >
> > Suggested-by: Jason Wang <jasowang@redhat.com>
> > Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
> > ---
> >  drivers/net/virtio_net.c | 45 ++++++++++++++++++++++++++++++----------
> >  1 file changed, 34 insertions(+), 11 deletions(-)
> >
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index a4d3c76654a4..79a1b30c173c 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -287,6 +287,12 @@ struct virtnet_info {
> >         bool has_cvq;
> >         struct mutex cvq_lock;
> >
> > +       /* Wait for the device to complete the request */
> > +       struct completion completion;
> > +
> > +       /* Work struct for acquisition of cvq processing results. */
> > +       struct work_struct get_cvq;
> > +
> >         /* Host can handle any s/g split between our header and packet =
data */
> >         bool any_header_sg;
> >
> > @@ -520,6 +526,13 @@ static bool virtqueue_napi_complete(struct napi_st=
ruct *napi,
> >         return false;
> >  }
> >
> > +static void virtnet_cvq_done(struct virtqueue *cvq)
> > +{
> > +       struct virtnet_info *vi =3D cvq->vdev->priv;
> > +
> > +       schedule_work(&vi->get_cvq);
> > +}
> > +
> >  static void skb_xmit_done(struct virtqueue *vq)
> >  {
> >         struct virtnet_info *vi =3D vq->vdev->priv;
> > @@ -2036,6 +2049,20 @@ static bool try_fill_recv(struct virtnet_info *v=
i, struct receive_queue *rq,
> >         return !oom;
> >  }
> >
> > +static void virtnet_get_cvq_work(struct work_struct *work)
> > +{
> > +       struct virtnet_info *vi =3D
> > +               container_of(work, struct virtnet_info, get_cvq);
> > +       unsigned int tmp;
> > +       void *res;
> > +
> > +       mutex_lock(&vi->cvq_lock);
> > +       res =3D virtqueue_get_buf(vi->cvq, &tmp);
> > +       if (res)
> > +               complete(&vi->completion);
> > +       mutex_unlock(&vi->cvq_lock);
> > +}
> > +
> >  static void skb_recv_done(struct virtqueue *rvq)
> >  {
> >         struct virtnet_info *vi =3D rvq->vdev->priv;
> > @@ -2531,7 +2558,7 @@ static bool virtnet_send_command(struct virtnet_i=
nfo *vi, u8 class, u8 cmd,
> >                                  struct scatterlist *out)
> >  {
> >         struct scatterlist *sgs[4], hdr, stat;
> > -       unsigned out_num =3D 0, tmp;
> > +       unsigned out_num =3D 0;
> >         int ret;
> >
> >         /* Caller should know better */
> > @@ -2566,16 +2593,10 @@ static bool virtnet_send_command(struct virtnet=
_info *vi, u8 class, u8 cmd,
> >                 return vi->ctrl->status =3D=3D VIRTIO_NET_OK;
> >         }
> >
> > -       /* Spin for a response, the kick causes an ioport write, trappi=
ng
> > -        * into the hypervisor, so the request should be handled immedi=
ately.
> > -        */
> > -       while (!virtqueue_get_buf(vi->cvq, &tmp) &&
> > -              !virtqueue_is_broken(vi->cvq)) {
> > -               cond_resched();
> > -               cpu_relax();
> > -       }
> > -
> >         mutex_unlock(&vi->cvq_lock);
> > +
> > +       wait_for_completion(&vi->completion);
> > +
>=20
> A question here, can multiple cvq requests be submitted to the device?
> If yes, what happens if the device completes them out of order?

For user commands (such as ethtool cmds), multiple cvq requests is not allo=
wed.
because it holds the netlink lock when waiting for the response.

For multiple dim commands and a user command allowed to be sent simultaneou=
sly
, the corresponding command-specific information(desc_state) will be used to
distinguish different responses.

Thanks.

>=20
> Thanks
>=20
> >         return vi->ctrl->status =3D=3D VIRTIO_NET_OK;
> >  }
> >
> > @@ -4433,7 +4454,7 @@ static int virtnet_find_vqs(struct virtnet_info *=
vi)
> >
> >         /* Parameters for control virtqueue, if any */
> >         if (vi->has_cvq) {
> > -               callbacks[total_vqs - 1] =3D NULL;
> > +               callbacks[total_vqs - 1] =3D virtnet_cvq_done;
> >                 names[total_vqs - 1] =3D "control";
> >         }
> >
> > @@ -4952,6 +4973,8 @@ static int virtnet_probe(struct virtio_device *vd=
ev)
> >         if (vi->has_rss || vi->has_rss_hash_report)
> >                 virtnet_init_default_rss(vi);
> >
> > +       INIT_WORK(&vi->get_cvq, virtnet_get_cvq_work);
> > +       init_completion(&vi->completion);
> >         enable_rx_mode_work(vi);
> >
> >         /* serialize netdev register + virtio_device_ready() with ndo_o=
pen() */
> > --
> > 2.32.0.3.g01195cf9f
> >
>=20
