Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA27A5228
	for <virtualization@lists.linux.dev>; Wed,  8 May 2024 02:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715136501; cv=none; b=BNpA/1EMQon1svLjbzJTqY4vpt3ZvcvmsxSmo2J3Xcwf1v4/fuPU8awoDjGqktbp7Fxid+NHzv1N1J1fUDQbzFAkD69zWL0gmCW/NPkU5zMqStQq7H0PEFgW4SdkkUYBBUTsVsLHTKkU3iJKnNaIzm56+OtXNxukeqWisRDHgrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715136501; c=relaxed/simple;
	bh=6mixkn9Fid6Dk/Ik0JYQtaBaomna4jxg1cH1vNjJX18=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To:
	 Content-Type; b=kd4kmdTz2HX1sHr1Tsr66qB44yhqyD8b5zCmpG/FU4yBallv/m+96MLOvxr2bOcpsomuzbWUh3GzGOs8eqsdNtGkN+QJ5nZNw47IZOYNdQvq+vuYGFRQPZj87Q9+DdN1vXf5nxX71R6hHU8ryM/0cta8WtXab1emAZhgYQMy6xA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ocXDrRk8; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ocXDrRk8"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1715136496; h=Message-ID:Subject:Date:From:To:Content-Type;
	bh=rQYAAa/F7CRJOCsgbbt4FVyrfGuTssBERGtKQRJ4k3k=;
	b=ocXDrRk8UliBfCO7Key7UdvYDjBI8MIKu6Zhu9R3yLCskbHg7wRyPIQKdPH2Oxib7Edk6BXzfjB+S0aMYg5A0dkPdGYZbU51GbO/Vw/0AJl4AlsdNhUSbO67YDK89XcSuaFZTX27UfMyjaTNwSxwxOYidDjYAIyt+aDj2zG3ZeQ=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067111;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0W61vfK0_1715136494;
Received: from localhost(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W61vfK0_1715136494)
          by smtp.aliyun-inc.com;
          Wed, 08 May 2024 10:48:15 +0800
Message-ID: <1715136282.850367-5-hengqi@linux.alibaba.com>
Subject: Re: [PATCH net-next v2 1/2] virtio_net: introduce ability to get reply info from device
Date: Wed, 8 May 2024 10:44:42 +0800
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
 <20240426065441.120710-2-hengqi@linux.alibaba.com>
 <CACGkMEvUT_uyLaqi533BUOqCYW1dYZTqdW_CC3-LgQXhhdJYFw@mail.gmail.com>
 <1715064795.2147572-1-hengqi@linux.alibaba.com>
 <CACGkMEtdk8L9jAh+9YAE0Nwwsd2_XXULU68mFn5Rje6f-MHWAw@mail.gmail.com>
In-Reply-To: <CACGkMEtdk8L9jAh+9YAE0Nwwsd2_XXULU68mFn5Rje6f-MHWAw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

On Wed, 8 May 2024 10:20:05 +0800, Jason Wang <jasowang@redhat.com> wrote:
> On Tue, May 7, 2024 at 2:56=E2=80=AFPM Heng Qi <hengqi@linux.alibaba.com>=
 wrote:
> >
> > On Tue, 7 May 2024 14:24:19 +0800, Jason Wang <jasowang@redhat.com> wro=
te:
> > > On Fri, Apr 26, 2024 at 2:54=E2=80=AFPM Heng Qi <hengqi@linux.alibaba=
.com> wrote:
> > > >
> > > > From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > >
> > > > As the spec https://github.com/oasis-tcs/virtio-spec/commit/42f3899=
89823039724f95bbbd243291ab0064f82
> > > >
> > > > Based on the description provided in the above specification, we ha=
ve
> > > > enabled the virtio-net driver to support acquiring some response
> > > > information from the device via the CVQ (Control Virtqueue).
> > > >
> > > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > >
> > > I wonder if we need to tweak the spec as it has:
> > >
> > > """
> > > Upon disabling and re-enabling a transmit virtqueue, the device MUST
> > > set the coalescing parameters of the virtqueue
> > > to those configured through the VIRTIO_NET_CTRL_NOTF_COAL_TX_SET
> > > command, or, if the driver did not set any TX coalescing parameters,
> > > to 0.
> > > """
> > >
> > > So for reset, this patch tells us the device would have a non-zero
> > > default value.
> > >
> > > But spec tolds us after vq reset, it has a zero default value ...
> >
> > Maybe we add a bool or flag for driver to mark whether the user has act=
ively
> > configured interrupt coalescing parameters. Then we can take actions wh=
en
> > vq reset occurs?
>=20
> I basically mean we probably need to tweak the spec. For example say
> the device may have a default value for coalescing so driver need to
> read them.

Well, I'll post a tweak patch, and since the current virtio spec mailing li=
st
is still not ready, I'll Cc people who were previously involved in the
discussion.

Thanks.

>=20
> Thanks
>=20
> >
> > Thanks.
> >
> > >
> > > Thanks
> > >
> > >
> > > > ---
> > > >  drivers/net/virtio_net.c | 24 +++++++++++++++++-------
> > > >  1 file changed, 17 insertions(+), 7 deletions(-)
> > > >
> > > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > > index 7176b956460b..3bc9b1e621db 100644
> > > > --- a/drivers/net/virtio_net.c
> > > > +++ b/drivers/net/virtio_net.c
> > > > @@ -2527,11 +2527,12 @@ static int virtnet_tx_resize(struct virtnet=
_info *vi,
> > > >   * supported by the hypervisor, as indicated by feature bits, shou=
ld
> > > >   * never fail unless improperly formatted.
> > > >   */
> > > > -static bool virtnet_send_command(struct virtnet_info *vi, u8 class=
, u8 cmd,
> > > > -                                struct scatterlist *out)
> > > > +static bool virtnet_send_command_reply(struct virtnet_info *vi, u8=
 class, u8 cmd,
> > > > +                                      struct scatterlist *out,
> > > > +                                      struct scatterlist *in)
> > > >  {
> > > > -       struct scatterlist *sgs[4], hdr, stat;
> > > > -       unsigned out_num =3D 0, tmp;
> > > > +       struct scatterlist *sgs[5], hdr, stat;
> > > > +       u32 out_num =3D 0, tmp, in_num =3D 0;
> > > >         int ret;
> > > >
> > > >         /* Caller should know better */
> > > > @@ -2549,10 +2550,13 @@ static bool virtnet_send_command(struct vir=
tnet_info *vi, u8 class, u8 cmd,
> > > >
> > > >         /* Add return status. */
> > > >         sg_init_one(&stat, &vi->ctrl->status, sizeof(vi->ctrl->stat=
us));
> > > > -       sgs[out_num] =3D &stat;
> > > > +       sgs[out_num + in_num++] =3D &stat;
> > > >
> > > > -       BUG_ON(out_num + 1 > ARRAY_SIZE(sgs));
> > > > -       ret =3D virtqueue_add_sgs(vi->cvq, sgs, out_num, 1, vi, GFP=
_ATOMIC);
> > > > +       if (in)
> > > > +               sgs[out_num + in_num++] =3D in;
> > > > +
> > > > +       BUG_ON(out_num + in_num > ARRAY_SIZE(sgs));
> > > > +       ret =3D virtqueue_add_sgs(vi->cvq, sgs, out_num, in_num, vi=
, GFP_ATOMIC);
> > > >         if (ret < 0) {
> > > >                 dev_warn(&vi->vdev->dev,
> > > >                          "Failed to add sgs for command vq: %d\n.",=
 ret);
> > > > @@ -2574,6 +2578,12 @@ static bool virtnet_send_command(struct virt=
net_info *vi, u8 class, u8 cmd,
> > > >         return vi->ctrl->status =3D=3D VIRTIO_NET_OK;
> > > >  }
> > > >
> > > > +static bool virtnet_send_command(struct virtnet_info *vi, u8 class=
, u8 cmd,
> > > > +                                struct scatterlist *out)
> > > > +{
> > > > +       return virtnet_send_command_reply(vi, class, cmd, out, NULL=
);
> > > > +}
> > > > +
> > > >  static int virtnet_set_mac_address(struct net_device *dev, void *p)
> > > >  {
> > > >         struct virtnet_info *vi =3D netdev_priv(dev);
> > > > --
> > > > 2.32.0.3.g01195cf9f
> > > >
> > >
> >
>=20
