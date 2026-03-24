Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4DEA1DF26E
	for <virtualization@lists.linux.dev>; Tue, 24 Mar 2026 00:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774312486; cv=none; b=jQ/rSo567xAnAqjLkNJkYFrCnoY/SUM6qfrBfNjgfIay1YCNYglzFuhFQM/tuXhZ6eeCkXmRp9815bdyR4LR/r/jnI/o5xnTBJbp1spa8M80keLddVm391LxZ/Y6A+/famD0A5KPUfnFQpz2t8XHddloqJpDKJJ9Zs2ifI/MR9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774312486; c=relaxed/simple;
	bh=NmX6aq1AjJs12Yq+PWPzbIZnkkSYYGFdr1l5n18R484=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g8CUwZXKyuYOkylYlYqyZ5QR6oQzfQAqJL4dRK/y+NsVR+VpnKirv9ATe9E7f46m33a1AsBPF0etoMLq1BXccq4jk/Gnw0pzwjMRd3jl1BuYdcjg+wlJV+fmECoaiD6DQMWDeFHXwK6gxTurjVyIx5eCSUOgwIq7V04U4mCzv24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ddgf8HKU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ddgf8HKU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774312483;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=saGQT6VbC9RUqD0YOp9yO8+1VRHnufK9WLW/Cpl18Rg=;
	b=Ddgf8HKUN0J1TQkC+Ogwpu7XcfBqnbz1XOSnHq6z5vKrdvT6Da8WgQphLSkxT3g6TJ0kla
	/Uo/LrlZXBDFE1Pg7UEdU47ju2WjFFUi+Q+zKlW3DT8LYsGgyfPuyF3hLtawc4TP5/6JB/
	JOYZcHPUPYTI8iBr6SW7WAnRlBEHFwE=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-497-49PubPWiPC2XbMJ-_MprAg-1; Mon, 23 Mar 2026 20:34:42 -0400
X-MC-Unique: 49PubPWiPC2XbMJ-_MprAg-1
X-Mimecast-MFC-AGG-ID: 49PubPWiPC2XbMJ-_MprAg_1774312481
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2b059511554so5410265ad.0
        for <virtualization@lists.linux.dev>; Mon, 23 Mar 2026 17:34:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774312481; x=1774917281;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=saGQT6VbC9RUqD0YOp9yO8+1VRHnufK9WLW/Cpl18Rg=;
        b=H+ntie9v9JZulSYE9Ryva0wX2rsbd9JCGpM8Ya6QgxRiscMcmcVLXkFCVzqkNyPsbk
         CSbtMpTdxjX8xNvTgxLPRwNi15HpvtzVwA97qAd5zfkk4EAPAtf8KwcTqeH5naEXsO0i
         w1UMZO69tK3Ib/xCfS2wI+FoSTJuRmgxRD7O97rK2riYxIoiXjjYMCm/VFDUUgb13fE/
         JzdyX9l+WV69lN2MFRid8DuIpEVO2dnDGqJpLremLp1/tSkjkwwkMtStioSQdRaDpCKM
         V8w9Sa4SPTxywdjadE3n8aSqtQszcesIHQ6Ec1hLJfItS523zTOIdD6gUmqvihs/a1KI
         YMSA==
X-Forwarded-Encrypted: i=1; AJvYcCXVgeiv7OoFWWQoEsdlXYNVIRwn0JBi07lg0SNlaLCZsPWClh0mqLvin/xL+fEruv4hWX5+ZSaJZzAm845jWw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyCh4IfKS3zDwSpa2FpTAWfdD/gnuX+97tr/YF5HQyvhJMYvhME
	5YzinszXKi2S0/EPqJk8Qk3Wf8nGXbUWqBL/4LG/soPgZNtQM/qZ5tdQ6l5gHx+qHE+iw5FOd9E
	HETHwHBV8XKsX83v2opX+e+tzS37vVy3qhw1z+w+PADhqGxO/Nj6f6YcrCdJMts6eIWzwEEKzu6
	NODG9kBmDMhd+CEP/4D38fxjobKkEcRp7KubCmxL62rF0=
X-Gm-Gg: ATEYQzxXnBcWhYes58+6PWRM7H/jVSLjETTzrfKH/S8201BfvJMIRrERN6bVgbiLSZJ
	Q+bErPp9Ry24wiDbNLKV43IUSVXRT0EYN5DmVrUDu+jhgSa5PKPHKE2U0WsBzyvHHtKgUKqD6op
	D/VYpWCmDRakOV+URT2WZpx/ljnWMoAupj4Ix0Mp6qqSNr+O9PPd367YIpJbS9CfFQ2Zq1jZR0M
	1x7
X-Received: by 2002:a17:902:d4c5:b0:2ad:dfb8:8ed3 with SMTP id d9443c01a7336-2b0826d7570mr125521045ad.8.1774312481449;
        Mon, 23 Mar 2026 17:34:41 -0700 (PDT)
X-Received: by 2002:a17:902:d4c5:b0:2ad:dfb8:8ed3 with SMTP id
 d9443c01a7336-2b0826d7570mr125520745ad.8.1774312481005; Mon, 23 Mar 2026
 17:34:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260310183107.2822016-1-vishs@meta.com> <20260323150136.14452-1-oelghoul@linux.ibm.com>
 <20260323114313-mutt-send-email-mst@kernel.org> <20260323122728-mutt-send-email-mst@kernel.org>
In-Reply-To: <20260323122728-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 24 Mar 2026 08:34:29 +0800
X-Gm-Features: AaiRm52xN2lo_tVFI0DDvUo4ivVlfAirVP3edMWUgEftkLvUyxZ5RHdMesVost0
Message-ID: <CACGkMEtUcdwhDYSZPfzc4noSFjgvS7exS0rYcCSscoMiMPvrHA@mail.gmail.com>
Subject: Re: [PATCH net-next v11] virtio_net: add page_pool support for buffer allocation
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Omar Elghoul <oelghoul@linux.ibm.com>, vishs@meta.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, dw@davidwei.uk, edumazet@google.com, eperezma@redhat.com, 
	ilias.apalodimas@linaro.org, kernel-team@meta.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	technoboy85@gmail.com, virtualization@lists.linux.dev, 
	xuanzhuo@linux.alibaba.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 1i7smR8Z71sYN8Kwt6hhMc1XOmKDjS2yKr98dz_LM1U_1774312481
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 24, 2026 at 12:58=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com=
> wrote:
>
> On Mon, Mar 23, 2026 at 11:52:34AM -0400, Michael S. Tsirkin wrote:
> > On Mon, Mar 23, 2026 at 11:01:31AM -0400, Omar Elghoul wrote:
> > > Hi,
> > >
> > > I've been testing linux-next (tags later than 03/17) and hit new issu=
es in
> > > virtio-net on s390x. I bisected the issue, and I found this patch to =
be the
> > > first buggy commit.
> > >
> > > The issue seems to only be reproducible when running in Secure Execut=
ion.
> > > Tested in a KVM guest, the virtio-net performance appears greatly red=
uced,
> > > and the dmesg output shows many instances of the following error mess=
ages.
> > >
> > > Partial relevant logs
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > [   49.332028] macvtap0: bad gso: type: 0, size: 0, flags 1 tunnel 0 =
tnl csum 0
> > > [   74.365668] macvtap0: bad gso: type: 2e, size: 27948, flags 0 tunn=
el 0 tnl csum 0
> > > [  403.302168] macvtap0: bad csum: flags: 2, gso_type: 23 rx_tnl_csum=
 0
> > > [  403.302271] macvtap0: bad csum: flags: 2, gso_type: e0 rx_tnl_csum=
 0
> > > [  403.302279] macvtap0: bad csum: flags: 2, gso_type: e1 rx_tnl_csum=
 0
> > > [  403.309492] macvtap0: bad csum: flags: 2, gso_type: 4c rx_tnl_csum=
 0
> > > [  403.317029] macvtap0: bad csum: flags: 2, gso_type: e0 rx_tnl_csum=
 0
> > >
> > > Steps to reproduce
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > 1. Boot a Linux guest implementing this patch under QEMU/KVM (*) with=
 SE
> > >    enabled and a virtio-net-ccw device attached.
> > > 2. Run dmesg. The error message is usually already present at boot ti=
me,
> > >    but if not, it can be reproduced by creating any network traffic.
> > >
> > > (*) This patch was not tested in a non-KVM hypervisor environment.
> > >
> > > I've further confirmed that reverting this patch onto its parent comm=
it
> > > resolves the issue. Please let me know if you'd like me to test a fix=
 or if
> > > you would need more information.
> > >
> > > Thanks in advance.
> > >
> > > Best,
> > > Omar
> >
> > Well... I am not sure how I missed it. Obvious in hindsight:
> >
> > static void receive_buf(struct virtnet_info *vi, struct receive_queue *=
rq,
> >                         void *buf, unsigned int len, void **ctx,
> >                         unsigned int *xdp_xmit,
> >                         struct virtnet_rq_stats *stats)
> > {
> >         struct net_device *dev =3D vi->dev;
> >         struct sk_buff *skb;
> >         u8 flags;
> >
> >         if (unlikely(len < vi->hdr_len + ETH_HLEN)) {
> >                 pr_debug("%s: short packet %i\n", dev->name, len);
> >                 DEV_STATS_INC(dev, rx_length_errors);
> >                 virtnet_rq_free_buf(vi, rq, buf);
> >                 return;
> >         }
> >
> >         /* About the flags below:
> >          * 1. Save the flags early, as the XDP program might overwrite =
them.
> >          * These flags ensure packets marked as VIRTIO_NET_HDR_F_DATA_V=
ALID
> >          * stay valid after XDP processing.
> >          * 2. XDP doesn't work with partially checksummed packets (refe=
r to
> >          * virtnet_xdp_set()), so packets marked as
> >          * VIRTIO_NET_HDR_F_NEEDS_CSUM get dropped during XDP processin=
g.
> >          */
> >
> >         if (vi->mergeable_rx_bufs) {
> >                 flags =3D ((struct virtio_net_common_hdr *)buf)->hdr.fl=
ags;
> >                 skb =3D receive_mergeable(dev, vi, rq, buf, ctx, len, x=
dp_xmit,
> >                                         stats);
> >         } else if (vi->big_packets) {
> >                 void *p =3D page_address((struct page *)buf);
> >
> >                 flags =3D ((struct virtio_net_common_hdr *)p)->hdr.flag=
s;
> >                 skb =3D receive_big(dev, vi, rq, buf, len, stats);
> >         } else {
> >                 flags =3D ((struct virtio_net_common_hdr *)buf)->hdr.fl=
ags;
> >                 skb =3D receive_small(dev, vi, rq, buf, ctx, len, xdp_x=
mit, stats);
> >         }
> >
> >
> > So we are reading the header, before dma sync, which is within
> > receive_mergeable and friends:
> >
> > static struct sk_buff *receive_mergeable(struct net_device *dev,
> >                                          struct virtnet_info *vi,
> >                                          struct receive_queue *rq,
> >                                          void *buf,
> >                                          void *ctx,
> >                                          unsigned int len,
> >                                          unsigned int *xdp_xmit,
> >                                          struct virtnet_rq_stats *stats=
)
> > {
> >         struct virtio_net_hdr_mrg_rxbuf *hdr =3D buf;
> >         int num_buf =3D virtio16_to_cpu(vi->vdev, hdr->num_buffers);
> >         struct page *page =3D virt_to_head_page(buf);
> >         int offset =3D buf - page_address(page);
> >         struct sk_buff *head_skb, *curr_skb;
> >         unsigned int truesize =3D mergeable_ctx_to_truesize(ctx);
> >         unsigned int headroom =3D mergeable_ctx_to_headroom(ctx);
> >
> >         head_skb =3D NULL;
> >
> >         if (rq->use_page_pool_dma)
> >                 page_pool_dma_sync_for_cpu(rq->page_pool, page, offset,=
 len);
> >
> >
> >
> > Just as a test, the below should fix it (compiled only), but the real
> > fix is more complex since we need to be careful to avoid expensive sync=
ing
> > twice.
> >
> >
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index 97035b49bae7..57b4f5954bed 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -931,9 +931,19 @@ static struct sk_buff *page_to_skb(struct virtnet_=
info *vi,
> >
> >  static void *virtnet_rq_get_buf(struct receive_queue *rq, u32 *len, vo=
id **ctx)
> >  {
> > +     void *buf;
> > +
> >       BUG_ON(!rq->page_pool);
> >
> > -     return virtqueue_get_buf_ctx(rq->vq, len, ctx);
> > +     buf =3D virtqueue_get_buf_ctx(rq->vq, len, ctx);
> > +     if (buf && rq->use_page_pool_dma && *len) {
> > +             struct page *page =3D virt_to_head_page(buf);
> > +             int offset =3D buf - page_address(page);
> > +
> > +             page_pool_dma_sync_for_cpu(rq->page_pool, page, offset, *=
len);
> > +     }
> > +
> > +     return buf;
> >  }
> >
> >  static void virtnet_rq_unmap_free_buf(struct virtqueue *vq, void *buf)
> >
> >
> >
> >
> > --
> > MST
>
> or maybe like this:
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 97035b49bae7..835f52651006 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -1956,13 +1956,6 @@ static struct sk_buff *receive_small(struct net_de=
vice *dev,
>          */
>         buf -=3D VIRTNET_RX_PAD + xdp_headroom;
>
> -       if (rq->use_page_pool_dma) {
> -               int offset =3D buf - page_address(page) +
> -                            VIRTNET_RX_PAD + xdp_headroom;
> -
> -               page_pool_dma_sync_for_cpu(rq->page_pool, page, offset, l=
en);
> -       }
> -
>         len -=3D vi->hdr_len;
>         u64_stats_add(&stats->bytes, len);
>
> @@ -2398,9 +2391,6 @@ static struct sk_buff *receive_mergeable(struct net=
_device *dev,
>
>         head_skb =3D NULL;
>
> -       if (rq->use_page_pool_dma)
> -               page_pool_dma_sync_for_cpu(rq->page_pool, page, offset, l=
en);
> -
>         u64_stats_add(&stats->bytes, len - vi->hdr_len);
>
>         if (check_mergeable_len(dev, ctx, len))
> @@ -2563,6 +2553,13 @@ static void receive_buf(struct virtnet_info *vi, s=
truct receive_queue *rq,
>                 return;
>         }
>
> +       if (rq->use_page_pool_dma) {
> +               struct page *page =3D virt_to_head_page(buf);
> +               int offset =3D buf - page_address(page);
> +
> +               page_pool_dma_sync_for_cpu(rq->page_pool, page, offset, l=
en);
> +       }
> +
>         /* About the flags below:
>          * 1. Save the flags early, as the XDP program might overwrite th=
em.
>          * These flags ensure packets marked as VIRTIO_NET_HDR_F_DATA_VAL=
ID
>

This looks better.

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

