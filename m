Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF55E5695
	for <virtualization@lists.linux.dev>; Tue, 18 Jun 2024 01:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718672662; cv=none; b=d+ok3SIaZgIaSKOq3ClUXPXyZ0BYcwN7xQbmh+ypyxpUeD7OMhCIk/IsvLWvsIZapeJ4n3yfLaj0/eK1ZVAzui3OxvpiUuWr4aSvRIcGHfjhH6PZHxTgJERUdYPePwy5JhtLa/m87HXlrVpvFoDntY/eu151vKfoCNFmikCgeEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718672662; c=relaxed/simple;
	bh=E1rGrs/QNXf4XbPROpGco58lXSpBUUdLnbooI3IML04=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WBDS/6dDAzUeSrcymum8CFoGtAAr1YDxJBjd57wK3QygfU6GH5G44zLU14qEoVOSNVXSFQ+46bUROEwyUsR6t/PSF104ITgWxvvNJMnw+j9fBp8yymWvt0+VaB0BTPp1SLrgTw60JDhUwCDGUbJAvFY+M3qjI3Hwx9KU6OkKUiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y3gM9gxS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y3gM9gxS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718672659;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fogfteCXFA3OgE3/+IIVtRDP5+xYgH0Ae3ZLYaDpaKM=;
	b=Y3gM9gxScqtTFTM8MQwmQ8xS3f7G3egQM67XzyPTX4Zr0ujxoXYzvZhGids+4DpRHjAg9D
	xPPUlkVllFHMlmLT8CEgHozW7G2K79hN64aGZv8T20LoHiPgFVtgXd0wXJsZxJD8OvohYO
	9U7i91iK8Yv98sPQtO7B2EJ6IGB9S0g=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-688-r7D70QebMbGDTvHSnQNvmQ-1; Mon, 17 Jun 2024 21:04:16 -0400
X-MC-Unique: r7D70QebMbGDTvHSnQNvmQ-1
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-7051baf0519so1883716a12.0
        for <virtualization@lists.linux.dev>; Mon, 17 Jun 2024 18:04:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718672655; x=1719277455;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fogfteCXFA3OgE3/+IIVtRDP5+xYgH0Ae3ZLYaDpaKM=;
        b=PMTnVwGBg3oXGRn4Mba44yojws4gmJJxx4Na1kHkCwtTYGFC7bUs3bjqTD2CD/hHsX
         MclJLdpialT/w9bTkEuPFPm0zxECgr9kIEx8BJdTLlsEPeqBhWFiJXlA+zIZJ4w2Fjkg
         0S7sO5jMXd+l+dAHhOAF+H38fVP178A0ZYY/jymGos4o50nBp1lNVs2Wb0DcR88lbUAW
         dvXZDkcGciS35GQdCl5tvJcr7G3yDc4a8eLPC29E49m9HGkgT+rQALnQzr7zxX9UdNrS
         iKB0swANsRSvj2Sphwan0hivrmbL+DZkfPdItx8LwEou3YcwXgH+htWo+wFApxmtSCSZ
         XWQQ==
X-Forwarded-Encrypted: i=1; AJvYcCXK4CZcGt6PlQstqEVpyKYmOC2wiaG6UfT6E8496Wb6QR4wp9hvCWavBdtYVNV+DPgc498DC5vJ01McJGtAore6TEQiF6aAfRBHijEP0qA=
X-Gm-Message-State: AOJu0YwYFXZEBb8sRP3KxX2AT7QalX6bOHt8gWnNgi7tlK6sVggyCR6v
	IbZ7MEg3j9BOdEdoz3FGJ5qxxM9ljla2v07c4fHsIa3HLuRbKcLkKnjGv+8B6FxESHUQL+Uo9WI
	eKgF4hPEJ2UbTcHySzutkCSObkmGm4I2/LAcLgUkQUAfP4C9D/MOsVg6eX2/ISfSC20Lxr63+qu
	wcz+YMqv1BcITqqfGSQ1lO1BsJcM7tcS6FDSoyOyE=
X-Received: by 2002:a05:6a21:6da8:b0:1b2:b5af:ce67 with SMTP id adf61e73a8af0-1bae82e3564mr11184685637.59.1718672655189;
        Mon, 17 Jun 2024 18:04:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEy7r4Pl26FO/pVoHuFobnp8YuNRODGRxmd/rJHwT+X9hHIMGWg8rn1edutBN1DvMrogNhD9Lb2eftvwnCu93Q=
X-Received: by 2002:a05:6a21:6da8:b0:1b2:b5af:ce67 with SMTP id
 adf61e73a8af0-1bae82e3564mr11184653637.59.1718672654660; Mon, 17 Jun 2024
 18:04:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240614063933.108811-1-xuanzhuo@linux.alibaba.com>
 <20240614063933.108811-10-xuanzhuo@linux.alibaba.com> <CACGkMEuLJSuM2Y1JRnvDoQG-dBsLGaOctv7tDdq8NjFOD2miSw@mail.gmail.com>
 <1718610191.0911355-4-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1718610191.0911355-4-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 18 Jun 2024 09:04:03 +0800
Message-ID: <CACGkMEvySjELA_4vU6yzR+sBAX75u9Rv-XmUUbNA8SaaPf-XXg@mail.gmail.com>
Subject: Re: [PATCH net-next v5 09/15] virtio_net: xsk: bind/unbind xsk
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, virtualization@lists.linux.dev, 
	bpf@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 17, 2024 at 3:49=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> On Mon, 17 Jun 2024 14:19:10 +0800, Jason Wang <jasowang@redhat.com> wrot=
e:
> > On Fri, Jun 14, 2024 at 2:39=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.aliba=
ba.com> wrote:
> > >
> > > This patch implement the logic of bind/unbind xsk pool to sq and rq.
> > >
> > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > ---
> > >  drivers/net/virtio_net.c | 201 +++++++++++++++++++++++++++++++++++++=
+-
> > >  1 file changed, 200 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > index 88ab9ea1646f..35fd8bca7fcf 100644
> > > --- a/drivers/net/virtio_net.c
> > > +++ b/drivers/net/virtio_net.c
> > > @@ -26,6 +26,7 @@
> > >  #include <net/netdev_rx_queue.h>
> > >  #include <net/netdev_queues.h>
> > >  #include <uapi/linux/virtio_ring.h>
> > > +#include <net/xdp_sock_drv.h>
> > >
> > >  static int napi_weight =3D NAPI_POLL_WEIGHT;
> > >  module_param(napi_weight, int, 0444);
> > > @@ -57,6 +58,8 @@ DECLARE_EWMA(pkt_len, 0, 64)
> > >
> > >  #define VIRTNET_DRIVER_VERSION "1.0.0"
> > >
> > > +static struct virtio_net_hdr_mrg_rxbuf xsk_hdr;
> >
> > Does this mean AF_XDP only supports virtio_net_hdr_mrg_rxbuf but not ot=
hers?
>
> Sorry, this is the old code.
>
> Should be virtio_net_common_hdr.
>
> Here we should use the max size of the virtio-net header.

Better but still suboptimal, for example it could be extended as we're
adding more features?

>
> >
> > > +
> > >  static const unsigned long guest_offloads[] =3D {
> > >         VIRTIO_NET_F_GUEST_TSO4,
> > >         VIRTIO_NET_F_GUEST_TSO6,
> > > @@ -321,6 +324,12 @@ struct send_queue {
> > >         bool premapped;
> > >
> > >         struct virtnet_sq_dma_info dmainfo;
> > > +
> > > +       struct {
> > > +               struct xsk_buff_pool *pool;
> > > +
> > > +               dma_addr_t hdr_dma_address;
> > > +       } xsk;
> > >  };
> > >
> > >  /* Internal representation of a receive virtqueue */
> > > @@ -372,6 +381,13 @@ struct receive_queue {
> > >
> > >         /* Record the last dma info to free after new pages is alloca=
ted. */
> > >         struct virtnet_rq_dma *last_dma;
> > > +
> > > +       struct {
> > > +               struct xsk_buff_pool *pool;
> > > +
> > > +               /* xdp rxq used by xsk */
> > > +               struct xdp_rxq_info xdp_rxq;
> > > +       } xsk;
> > >  };
> > >
> > >  /* This structure can contain rss message with maximum settings for =
indirection table and keysize
> > > @@ -695,7 +711,7 @@ static void virtnet_sq_free_dma_meta(struct send_=
queue *sq)
> > >  /* This function must be called immediately after creating the vq, o=
r after vq
> > >   * reset, and before adding any buffers to it.
> > >   */
> > > -static __maybe_unused int virtnet_sq_set_premapped(struct send_queue=
 *sq, bool premapped)
> > > +static int virtnet_sq_set_premapped(struct send_queue *sq, bool prem=
apped)
> > >  {
> > >         if (premapped) {
> > >                 int r;
> > > @@ -5177,6 +5193,187 @@ static int virtnet_restore_guest_offloads(str=
uct virtnet_info *vi)
> > >         return virtnet_set_guest_offloads(vi, offloads);
> > >  }
> > >
> > > +static int virtnet_rq_bind_xsk_pool(struct virtnet_info *vi, struct =
receive_queue *rq,
> > > +                                   struct xsk_buff_pool *pool)
> > > +{
> > > +       int err, qindex;
> > > +
> > > +       qindex =3D rq - vi->rq;
> > > +
> > > +       if (pool) {
> > > +               err =3D xdp_rxq_info_reg(&rq->xsk.xdp_rxq, vi->dev, q=
index, rq->napi.napi_id);
> > > +               if (err < 0)
> > > +                       return err;
> > > +
> > > +               err =3D xdp_rxq_info_reg_mem_model(&rq->xsk.xdp_rxq,
> > > +                                                MEM_TYPE_XSK_BUFF_PO=
OL, NULL);
> > > +               if (err < 0) {
> > > +                       xdp_rxq_info_unreg(&rq->xsk.xdp_rxq);
> > > +                       return err;
> > > +               }
> > > +
> > > +               xsk_pool_set_rxq_info(pool, &rq->xsk.xdp_rxq);
> > > +       }
> > > +
> > > +       virtnet_rx_pause(vi, rq);
> > > +
> > > +       err =3D virtqueue_reset(rq->vq, virtnet_rq_unmap_free_buf);
> > > +       if (err) {
> > > +               netdev_err(vi->dev, "reset rx fail: rx queue index: %=
d err: %d\n", qindex, err);
> > > +
> > > +               pool =3D NULL;
> > > +       }
> > > +
> > > +       if (!pool)
> > > +               xdp_rxq_info_unreg(&rq->xsk.xdp_rxq);
> >
> > Let's use err label instead of duplicating xdp_rxq_info_unreg() here?
> >
> > > +
> > > +       rq->xsk.pool =3D pool;
> > > +
> > > +       virtnet_rx_resume(vi, rq);
> > > +
> > > +       return err;
> > > +}
> > > +
> > > +static int virtnet_sq_bind_xsk_pool(struct virtnet_info *vi,
> > > +                                   struct send_queue *sq,
> > > +                                   struct xsk_buff_pool *pool)
> > > +{
> > > +       int err, qindex;
> > > +
> > > +       qindex =3D sq - vi->sq;
> > > +
> > > +       virtnet_tx_pause(vi, sq);
> > > +
> > > +       err =3D virtqueue_reset(sq->vq, virtnet_sq_free_unused_buf);
> > > +       if (err)
> > > +               netdev_err(vi->dev, "reset tx fail: tx queue index: %=
d err: %d\n", qindex, err);
> > > +       else
> > > +               err =3D virtnet_sq_set_premapped(sq, !!pool);
> > > +
> > > +       if (err)
> > > +               pool =3D NULL;
> > > +
> > > +       sq->xsk.pool =3D pool;
> > > +
> > > +       virtnet_tx_resume(vi, sq);
> > > +
> > > +       return err;
> > > +}
> > > +
> > > +static int virtnet_xsk_pool_enable(struct net_device *dev,
> > > +                                  struct xsk_buff_pool *pool,
> > > +                                  u16 qid)
> > > +{
> > > +       struct virtnet_info *vi =3D netdev_priv(dev);
> > > +       struct receive_queue *rq;
> > > +       struct send_queue *sq;
> > > +       struct device *dma_dev;
> > > +       dma_addr_t hdr_dma;
> > > +       int err;
> > > +
> > > +       /* In big_packets mode, xdp cannot work, so there is no need =
to
> > > +        * initialize xsk of rq.
> > > +        *
> > > +        * Support for small mode firstly.
> >
> > This comment is kind of confusing, I think mergeable mode is also
> > supported. If it's true, we can simply remove it.
>
> For the commit num limit of the net-next, I have to remove some commits.
>
> So the mergeable mode is not supported by this patch set.
>
> I plan to support the merge mode after this patch set.

Then, I'd suggest to split the patches into two series:

1) AF_XDP TX zerocopy
2) AF_XDP RX zerocopy

And implement both small and mergeable in series 2).

>
>
> >
> > > +        */
> > > +       if (vi->big_packets)
> > > +               return -ENOENT;
> > > +
> > > +       if (qid >=3D vi->curr_queue_pairs)
> > > +               return -EINVAL;
> > > +
> > > +       sq =3D &vi->sq[qid];
> > > +       rq =3D &vi->rq[qid];
> > > +
> > > +       /* xsk tx zerocopy depend on the tx napi.
> > > +        *
> > > +        * All xsk packets are actually consumed and sent out from th=
e xsk tx
> > > +        * queue under the tx napi mechanism.
> > > +        */
> > > +       if (!sq->napi.weight)
> > > +               return -EPERM;
> > > +
> > > +       /* For the xsk, the tx and rx should have the same device. Bu=
t
> > > +        * vq->dma_dev allows every vq has the respective dma dev. So=
 I check
> > > +        * the dma dev of vq and sq is the same dev.
> > > +        */
> > > +       if (virtqueue_dma_dev(rq->vq) !=3D virtqueue_dma_dev(sq->vq))
> > > +               return -EPERM;
> >
> > I don't understand how a different DMA device matters here. It looks
> > like the code is using per virtqueue DMA below.
>
> The af-xdp may use one buffer to receive from the rx and reuse this buffe=
r to
> send by the tx.  So the dma dev of sq and rq should be the same one.

Right, let's tweak the comment to say something like this.

Thanks

