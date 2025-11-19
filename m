Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD99226D17
	for <virtualization@lists.linux-foundation.org>; Wed, 19 Nov 2025 02:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763518065; cv=none; b=VcfplupwsSksh92jw7r4k+8kZLqcQvGbKTMxo072WUNz5VNltouzzMEXO8QjM9TU4X/tXitdGe5gvOSpctP8VXfVBL92LRJXstcwN9uzJkMFF8+XihNS94HwFYSUnYDp17kXoeL09HLAofHOUS5WlmqazNzvQFF5b+PDEgeY/T0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763518065; c=relaxed/simple;
	bh=qCPvjbPyrqEz/TADGcfkQrklmfu8vszx3E4BBHEcAEw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Aj9dNsh0TB2A0W6Bzk3sMu4isk4bOaV53Jonq15qelCl6UjB/5zdWC2/p0fAlf+DmVAaa6FrZAnIj8bIliVkohq8Ms7Lnc+9nvLepcbCUPg5WLd7RzoZVd4gN3RgPCUf8XAUcBn5Bs7Nnv31S8sTK49+rFw/W6vqzYWrrqDT3/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hb5lc6Q3; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hb5lc6Q3"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 525B484588
	for <virtualization@lists.linux-foundation.org>; Wed, 19 Nov 2025 02:07:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.792
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id s0PqC2jCmaGB for <virtualization@lists.linux-foundation.org>;
 Wed, 19 Nov 2025 02:07:42 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=jasowang@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 24D3384548
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 24D3384548
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=hb5lc6Q3
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 24D3384548
	for <virtualization@lists.linux-foundation.org>; Wed, 19 Nov 2025 02:07:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763518060;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z4eFjpzST/7FqskG5nkglbLK48aXe7h6Rso97yeE/nI=;
	b=hb5lc6Q3Re9O38S7EazLM6+klOIDO6cwQJM4nJpMJQoiI8Uu23zTMd+6UX8kbPVNT2RTja
	cQZZrh6SiR9ijxykwO5lJQKJUYudBPRHZUeGfuGNROPRtGNLuVFxcQoshrmMUeHpHV+wYG
	UVyfZdD5TMaluggUDVb5vX2xGtfbCg8=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-624-PI7sUG_vOOSbtIIGRd7YDg-1; Tue, 18 Nov 2025 21:07:39 -0500
X-MC-Unique: PI7sUG_vOOSbtIIGRd7YDg-1
X-Mimecast-MFC-AGG-ID: PI7sUG_vOOSbtIIGRd7YDg_1763518058
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-297e66542afso205877655ad.3
        for <virtualization@lists.linux-foundation.org>; Tue, 18 Nov 2025 18:07:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763518058; x=1764122858;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Z4eFjpzST/7FqskG5nkglbLK48aXe7h6Rso97yeE/nI=;
        b=iuFHfRTsQk+Iofe3NHuX+C9OCqoYENMRVn6BlZ+xZeTYczyzNUv6+/E7Qt1YTzI+Ux
         ggqx74hs0zHNLPwBEje4JBdB7nvubZz2uWvF5IMk5Pm1tUiluS7XdhBJd6eDyTCo3CZ6
         oZZwEbty1GJb6wzV2G/6IzGU5ZZVFI/3ugWiiw3Up8/8vpz3/Fb5WZcBOxGjC986Kw62
         Wexfchd7to4Kv3Ntfn87j/5+Xc7wn6dNY+2uTdA3PrNDNjc0cvomSab94yuOltNHJv4+
         jSZmNXM/wxZ5LT2uEFYZ1YbgIq2OXse6uTCwHxKb5Puv0Tyve/RRaGx1UtL/0OxZ7V1M
         vYuQ==
X-Forwarded-Encrypted: i=1; AJvYcCUTahh8OZHpJfph9UTBryCxWHCwRjdPIYzxCBsVWZMuR49N6T6aG/QMu5d456juOnLJawf1nubP4EY9zUBwMg==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0Yxr5t7NESBMtFKGq+GHzoj8klO5xPyWAKNR/z/g8SKsGi4cBs6j
	jNvbn4AIFBHiYPQVEGyP+hhjUNVxgoezLbeyZxyWbfz9RHMbBTWwYM6BeHeXiM/GpHqdFjYDb/o
	0PL5Vd0IVPYCDGrkLJnpVj1E7uRRe/Rp6yTqg6DdilF5TFBLuLkWIBAr1ktg6Q+wXCxEstjU0my
	3WF8+n2uu6/RbjChXVlP2yX+xHYH4W38BVaUuEB051Rai12P2fu81dfrluUQ==
X-Gm-Gg: ASbGnctytkgBDi2HX50NB4uN0WiAzqwD9LyGB/S4gfU0w873hFkjCaYyiED0hdj9R46
	OuHYgbvai/jfDnqARiLQNs08yg69ACWvzmubp/QFmmIhr4bM7kYUrlWFEchOKkM7a4BCfXO/KU9
	3wn/3mmmkfhslD9NnbI4W8aT1amXEcSi93p/Az1n0hHgJBMHOKkbHC/F4Z60sP58A=
X-Received: by 2002:a17:902:d506:b0:294:f30f:ea4b with SMTP id d9443c01a7336-2986a6b876dmr182238595ad.8.1763518057978;
        Tue, 18 Nov 2025 18:07:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGeNmmVfrrspl6rGIc3D9CV7NqJozv/OQZ7x2GYHJcSke+eR1q39k1K+UiJUfQ97cov5THZVM1u3R8wVQVhXxE=
X-Received: by 2002:a17:902:d506:b0:294:f30f:ea4b with SMTP id
 d9443c01a7336-2986a6b876dmr182238245ad.8.1763518057445; Tue, 18 Nov 2025
 18:07:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251113015420.3496-1-jasowang@redhat.com> <20251113030230-mutt-send-email-mst@kernel.org>
 <CACGkMEtnihOt=g+zs0gVQ=wnx8_YF_F=QSuLQ4RGWBVuOeFi7w@mail.gmail.com>
 <20251114012141-mutt-send-email-mst@kernel.org> <CACGkMEuqPtrCotXRcP2kzdaJ50L3oY7U-LVAKNuXOFJP_h1_PQ@mail.gmail.com>
 <20251117034446-mutt-send-email-mst@kernel.org>
In-Reply-To: <20251117034446-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 19 Nov 2025 10:07:25 +0800
X-Gm-Features: AWmQ_blKbntcqNTR-p4W8w_fljr4MW0-vt2uxGDqpZFsxDx5iKHoNZJAujuIHy4
Message-ID: <CACGkMEtoKYrv5A9GAq_KcrpvN03SkoYPRkxnb20NhBVcOHp3jg@mail.gmail.com>
Subject: Re: [PATCH net] vhost: rewind next_avail_head while discarding descriptors
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: hKyHgJXE10I04fWlgfdT1hBe0IYAkVyIzmGAx9UxyHk_1763518058
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 17, 2025 at 4:49=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Mon, Nov 17, 2025 at 12:26:51PM +0800, Jason Wang wrote:
> > On Fri, Nov 14, 2025 at 2:25=E2=80=AFPM Michael S. Tsirkin <mst@redhat.=
com> wrote:
> > >
> > > On Fri, Nov 14, 2025 at 09:53:12AM +0800, Jason Wang wrote:
> > > > On Thu, Nov 13, 2025 at 4:13=E2=80=AFPM Michael S. Tsirkin <mst@red=
hat.com> wrote:
> > > > >
> > > > > On Thu, Nov 13, 2025 at 09:54:20AM +0800, Jason Wang wrote:
> > > > > > When discarding descriptors with IN_ORDER, we should rewind
> > > > > > next_avail_head otherwise it would run out of sync with
> > > > > > last_avail_idx. This would cause driver to report
> > > > > > "id X is not a head".
> > > > > >
> > > > > > Fixing this by returning the number of descriptors that is used=
 for
> > > > > > each buffer via vhost_get_vq_desc_n() so caller can use the val=
ue
> > > > > > while discarding descriptors.
> > > > > >
> > > > > > Fixes: 67a873df0c41 ("vhost: basic in order support")
> > > > > > Cc: stable@vger.kernel.org
> > > > > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > > >
> > > > > Wow that change really caused a lot of fallout.
> > > > >
> > > > > Thanks for the patch! Yet something to improve:
> > > > >
> > > > >
> > > > > > ---
> > > > > >  drivers/vhost/net.c   | 53 ++++++++++++++++++++++++++---------=
--------
> > > > > >  drivers/vhost/vhost.c | 43 ++++++++++++++++++++++++-----------
> > > > > >  drivers/vhost/vhost.h |  9 +++++++-
> > > > > >  3 files changed, 70 insertions(+), 35 deletions(-)
> > > > > >
> > > > > > diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
> > > > > > index 35ded4330431..8f7f50acb6d6 100644
> > > > > > --- a/drivers/vhost/net.c
> > > > > > +++ b/drivers/vhost/net.c
> > > > > > @@ -592,14 +592,15 @@ static void vhost_net_busy_poll(struct vh=
ost_net *net,
> > > > > >  static int vhost_net_tx_get_vq_desc(struct vhost_net *net,
> > > > > >                                   struct vhost_net_virtqueue *t=
nvq,
> > > > > >                                   unsigned int *out_num, unsign=
ed int *in_num,
> > > > > > -                                 struct msghdr *msghdr, bool *=
busyloop_intr)
> > > > > > +                                 struct msghdr *msghdr, bool *=
busyloop_intr,
> > > > > > +                                 unsigned int *ndesc)
> > > > > >  {
> > > > > >       struct vhost_net_virtqueue *rnvq =3D &net->vqs[VHOST_NET_=
VQ_RX];
> > > > > >       struct vhost_virtqueue *rvq =3D &rnvq->vq;
> > > > > >       struct vhost_virtqueue *tvq =3D &tnvq->vq;
> > > > > >
> > > > > > -     int r =3D vhost_get_vq_desc(tvq, tvq->iov, ARRAY_SIZE(tvq=
->iov),
> > > > > > -                               out_num, in_num, NULL, NULL);
> > > > > > +     int r =3D vhost_get_vq_desc_n(tvq, tvq->iov, ARRAY_SIZE(t=
vq->iov),
> > > > > > +                                 out_num, in_num, NULL, NULL, =
ndesc);
> > > > > >
> > > > > >       if (r =3D=3D tvq->num && tvq->busyloop_timeout) {
> > > > > >               /* Flush batched packets first */
> > > > > > @@ -610,8 +611,8 @@ static int vhost_net_tx_get_vq_desc(struct =
vhost_net *net,
> > > > > >
> > > > > >               vhost_net_busy_poll(net, rvq, tvq, busyloop_intr,=
 false);
> > > > > >
> > > > > > -             r =3D vhost_get_vq_desc(tvq, tvq->iov, ARRAY_SIZE=
(tvq->iov),
> > > > > > -                                   out_num, in_num, NULL, NULL=
);
> > > > > > +             r =3D vhost_get_vq_desc_n(tvq, tvq->iov, ARRAY_SI=
ZE(tvq->iov),
> > > > > > +                                     out_num, in_num, NULL, NU=
LL, ndesc);
> > > > > >       }
> > > > > >
> > > > > >       return r;
> > > > > > @@ -642,12 +643,14 @@ static int get_tx_bufs(struct vhost_net *=
net,
> > > > > >                      struct vhost_net_virtqueue *nvq,
> > > > > >                      struct msghdr *msg,
> > > > > >                      unsigned int *out, unsigned int *in,
> > > > > > -                    size_t *len, bool *busyloop_intr)
> > > > > > +                    size_t *len, bool *busyloop_intr,
> > > > > > +                    unsigned int *ndesc)
> > > > > >  {
> > > > > >       struct vhost_virtqueue *vq =3D &nvq->vq;
> > > > > >       int ret;
> > > > > >
> > > > > > -     ret =3D vhost_net_tx_get_vq_desc(net, nvq, out, in, msg, =
busyloop_intr);
> > > > > > +     ret =3D vhost_net_tx_get_vq_desc(net, nvq, out, in, msg,
> > > > > > +                                    busyloop_intr, ndesc);
> > > > > >
> > > > > >       if (ret < 0 || ret =3D=3D vq->num)
> > > > > >               return ret;
> > > > > > @@ -766,6 +769,7 @@ static void handle_tx_copy(struct vhost_net=
 *net, struct socket *sock)
> > > > > >       int sent_pkts =3D 0;
> > > > > >       bool sock_can_batch =3D (sock->sk->sk_sndbuf =3D=3D INT_M=
AX);
> > > > > >       bool in_order =3D vhost_has_feature(vq, VIRTIO_F_IN_ORDER=
);
> > > > > > +     unsigned int ndesc =3D 0;
> > > > > >
> > > > > >       do {
> > > > > >               bool busyloop_intr =3D false;
> > > > > > @@ -774,7 +778,7 @@ static void handle_tx_copy(struct vhost_net=
 *net, struct socket *sock)
> > > > > >                       vhost_tx_batch(net, nvq, sock, &msg);
> > > > > >
> > > > > >               head =3D get_tx_bufs(net, nvq, &msg, &out, &in, &=
len,
> > > > > > -                                &busyloop_intr);
> > > > > > +                                &busyloop_intr, &ndesc);
> > > > > >               /* On error, stop handling until the next kick. *=
/
> > > > > >               if (unlikely(head < 0))
> > > > > >                       break;
> > > > > > @@ -806,7 +810,7 @@ static void handle_tx_copy(struct vhost_net=
 *net, struct socket *sock)
> > > > > >                               goto done;
> > > > > >                       } else if (unlikely(err !=3D -ENOSPC)) {
> > > > > >                               vhost_tx_batch(net, nvq, sock, &m=
sg);
> > > > > > -                             vhost_discard_vq_desc(vq, 1);
> > > > > > +                             vhost_discard_vq_desc(vq, 1, ndes=
c);
> > > > > >                               vhost_net_enable_vq(net, vq);
> > > > > >                               break;
> > > > > >                       }
> > > > > > @@ -829,7 +833,7 @@ static void handle_tx_copy(struct vhost_net=
 *net, struct socket *sock)
> > > > > >               err =3D sock->ops->sendmsg(sock, &msg, len);
> > > > > >               if (unlikely(err < 0)) {
> > > > > >                       if (err =3D=3D -EAGAIN || err =3D=3D -ENO=
MEM || err =3D=3D -ENOBUFS) {
> > > > > > -                             vhost_discard_vq_desc(vq, 1);
> > > > > > +                             vhost_discard_vq_desc(vq, 1, ndes=
c);
> > > > > >                               vhost_net_enable_vq(net, vq);
> > > > > >                               break;
> > > > > >                       }
> > > > > > @@ -868,6 +872,7 @@ static void handle_tx_zerocopy(struct vhost=
_net *net, struct socket *sock)
> > > > > >       int err;
> > > > > >       struct vhost_net_ubuf_ref *ubufs;
> > > > > >       struct ubuf_info_msgzc *ubuf;
> > > > > > +     unsigned int ndesc =3D 0;
> > > > > >       bool zcopy_used;
> > > > > >       int sent_pkts =3D 0;
> > > > > >
> > > > > > @@ -879,7 +884,7 @@ static void handle_tx_zerocopy(struct vhost=
_net *net, struct socket *sock)
> > > > > >
> > > > > >               busyloop_intr =3D false;
> > > > > >               head =3D get_tx_bufs(net, nvq, &msg, &out, &in, &=
len,
> > > > > > -                                &busyloop_intr);
> > > > > > +                                &busyloop_intr, &ndesc);
> > > > > >               /* On error, stop handling until the next kick. *=
/
> > > > > >               if (unlikely(head < 0))
> > > > > >                       break;
> > > > > > @@ -941,7 +946,7 @@ static void handle_tx_zerocopy(struct vhost=
_net *net, struct socket *sock)
> > > > > >                                       vq->heads[ubuf->desc].len=
 =3D VHOST_DMA_DONE_LEN;
> > > > > >                       }
> > > > > >                       if (retry) {
> > > > > > -                             vhost_discard_vq_desc(vq, 1);
> > > > > > +                             vhost_discard_vq_desc(vq, 1, ndes=
c);
> > > > > >                               vhost_net_enable_vq(net, vq);
> > > > > >                               break;
> > > > > >                       }
> > > > > > @@ -1045,11 +1050,12 @@ static int get_rx_bufs(struct vhost_net=
_virtqueue *nvq,
> > > > > >                      unsigned *iovcount,
> > > > > >                      struct vhost_log *log,
> > > > > >                      unsigned *log_num,
> > > > > > -                    unsigned int quota)
> > > > > > +                    unsigned int quota,
> > > > > > +                    unsigned int *ndesc)
> > > > > >  {
> > > > > >       struct vhost_virtqueue *vq =3D &nvq->vq;
> > > > > >       bool in_order =3D vhost_has_feature(vq, VIRTIO_F_IN_ORDER=
);
> > > > > > -     unsigned int out, in;
> > > > > > +     unsigned int out, in, desc_num, n =3D 0;
> > > > > >       int seg =3D 0;
> > > > > >       int headcount =3D 0;
> > > > > >       unsigned d;
> > > > > > @@ -1064,9 +1070,9 @@ static int get_rx_bufs(struct vhost_net_v=
irtqueue *nvq,
> > > > > >                       r =3D -ENOBUFS;
> > > > > >                       goto err;
> > > > > >               }
> > > > > > -             r =3D vhost_get_vq_desc(vq, vq->iov + seg,
> > > > > > -                                   ARRAY_SIZE(vq->iov) - seg, =
&out,
> > > > > > -                                   &in, log, log_num);
> > > > > > +             r =3D vhost_get_vq_desc_n(vq, vq->iov + seg,
> > > > > > +                                     ARRAY_SIZE(vq->iov) - seg=
, &out,
> > > > > > +                                     &in, log, log_num, &desc_=
num);
> > > > > >               if (unlikely(r < 0))
> > > > > >                       goto err;
> > > > > >
> > > > > > @@ -1093,6 +1099,7 @@ static int get_rx_bufs(struct vhost_net_v=
irtqueue *nvq,
> > > > > >               ++headcount;
> > > > > >               datalen -=3D len;
> > > > > >               seg +=3D in;
> > > > > > +             n +=3D desc_num;
> > > > > >       }
> > > > > >
> > > > > >       *iovcount =3D seg;
> > > > > > @@ -1113,9 +1120,11 @@ static int get_rx_bufs(struct vhost_net_=
virtqueue *nvq,
> > > > > >               nheads[0] =3D headcount;
> > > > > >       }
> > > > > >
> > > > > > +     *ndesc =3D n;
> > > > > > +
> > > > > >       return headcount;
> > > > > >  err:
> > > > > > -     vhost_discard_vq_desc(vq, headcount);
> > > > > > +     vhost_discard_vq_desc(vq, headcount, n);
> > > > >
> > > > > So here ndesc and n are the same, but below in vhost_discard_vq_d=
esc
> > > > > they are different. Fun.
> > > >
> > > > Not necessarily the same, a buffer could contain more than 1 descri=
ptor.
> > >
> > >
> > > *ndesc =3D n kinda guarantees it's the same, no?
> >
> > I misread your comment, in the error path the ndesc is left unused.
>
>
>
>
> > Would this be a problem?
> > >
> > > > >
> > > > > >       return r;
> > > > > >  }
> > > > > >
> > > > > > @@ -1151,6 +1160,7 @@ static void handle_rx(struct vhost_net *n=
et)
> > > > > >       struct iov_iter fixup;
> > > > > >       __virtio16 num_buffers;
> > > > > >       int recv_pkts =3D 0;
> > > > > > +     unsigned int ndesc;
> > > > > >
> > > > > >       mutex_lock_nested(&vq->mutex, VHOST_NET_VQ_RX);
> > > > > >       sock =3D vhost_vq_get_backend(vq);
> > > > > > @@ -1182,7 +1192,8 @@ static void handle_rx(struct vhost_net *n=
et)
> > > > > >               headcount =3D get_rx_bufs(nvq, vq->heads + count,
> > > > > >                                       vq->nheads + count,
> > > > > >                                       vhost_len, &in, vq_log, &=
log,
> > > > > > -                                     likely(mergeable) ? UIO_M=
AXIOV : 1);
> > > > > > +                                     likely(mergeable) ? UIO_M=
AXIOV : 1,
> > > > > > +                                     &ndesc);
> > > > > >               /* On error, stop handling until the next kick. *=
/
> > > > > >               if (unlikely(headcount < 0))
> > > > > >                       goto out;
> > > > > > @@ -1228,7 +1239,7 @@ static void handle_rx(struct vhost_net *n=
et)
> > > > > >               if (unlikely(err !=3D sock_len)) {
> > > > > >                       pr_debug("Discarded rx packet: "
> > > > > >                                " len %d, expected %zd\n", err, =
sock_len);
> > > > > > -                     vhost_discard_vq_desc(vq, headcount);
> > > > > > +                     vhost_discard_vq_desc(vq, headcount, ndes=
c);
> > > > > >                       continue;
> > > > > >               }
> > > > > >               /* Supply virtio_net_hdr if VHOST_NET_F_VIRTIO_NE=
T_HDR */
> > > > > > @@ -1252,7 +1263,7 @@ static void handle_rx(struct vhost_net *n=
et)
> > > > > >                   copy_to_iter(&num_buffers, sizeof num_buffers=
,
> > > > > >                                &fixup) !=3D sizeof num_buffers)=
 {
> > > > > >                       vq_err(vq, "Failed num_buffers write");
> > > > > > -                     vhost_discard_vq_desc(vq, headcount);
> > > > > > +                     vhost_discard_vq_desc(vq, headcount, ndes=
c);
> > > > > >                       goto out;
> > > > > >               }
> > > > > >               nvq->done_idx +=3D headcount;
> > > > > > diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> > > > > > index 8570fdf2e14a..b56568807588 100644
> > > > > > --- a/drivers/vhost/vhost.c
> > > > > > +++ b/drivers/vhost/vhost.c
> > > > > > @@ -2792,18 +2792,11 @@ static int get_indirect(struct vhost_vi=
rtqueue *vq,
> > > > > >       return 0;
> > > > > >  }
> > > > > >
> > > > > > -/* This looks in the virtqueue and for the first available buf=
fer, and converts
> > > > > > - * it to an iovec for convenient access.  Since descriptors co=
nsist of some
> > > > > > - * number of output then some number of input descriptors, it'=
s actually two
> > > > > > - * iovecs, but we pack them into one and note how many of each=
 there were.
> > > > > > - *
> > > > > > - * This function returns the descriptor number found, or vq->n=
um (which is
> > > > > > - * never a valid descriptor number) if none was found.  A nega=
tive code is
> > > > > > - * returned on error. */
> > > > >
> > > > > A new module API with no docs at all is not good.
> > > > > Please add documentation to this one. vhost_get_vq_desc
> > > > > is a subset and could refer to it.
> > > >
> > > > Fixed.
> > > >
> > > > >
> > > > > > -int vhost_get_vq_desc(struct vhost_virtqueue *vq,
> > > > > > -                   struct iovec iov[], unsigned int iov_size,
> > > > > > -                   unsigned int *out_num, unsigned int *in_num=
,
> > > > > > -                   struct vhost_log *log, unsigned int *log_nu=
m)
> > > > > > +int vhost_get_vq_desc_n(struct vhost_virtqueue *vq,
> > > > > > +                     struct iovec iov[], unsigned int iov_size=
,
> > > > > > +                     unsigned int *out_num, unsigned int *in_n=
um,
> > > > > > +                     struct vhost_log *log, unsigned int *log_=
num,
> > > > > > +                     unsigned int *ndesc)
> > > > >
> > > > > >  {
> > > > > >       bool in_order =3D vhost_has_feature(vq, VIRTIO_F_IN_ORDER=
);
> > > > > >       struct vring_desc desc;
> > > > > > @@ -2921,16 +2914,40 @@ int vhost_get_vq_desc(struct vhost_virt=
queue *vq,
> > > > > >       vq->last_avail_idx++;
> > > > > >       vq->next_avail_head +=3D c;
> > > > > >
> > > > > > +     if (ndesc)
> > > > > > +             *ndesc =3D c;
> > > > > > +
> > > > > >       /* Assume notifications from guest are disabled at this p=
oint,
> > > > > >        * if they aren't we would need to update avail_event ind=
ex. */
> > > > > >       BUG_ON(!(vq->used_flags & VRING_USED_F_NO_NOTIFY));
> > > > > >       return head;
> > > > > >  }
> > > > > > +EXPORT_SYMBOL_GPL(vhost_get_vq_desc_n);
> > > > > > +
> > > > > > +/* This looks in the virtqueue and for the first available buf=
fer, and converts
> > > > > > + * it to an iovec for convenient access.  Since descriptors co=
nsist of some
> > > > > > + * number of output then some number of input descriptors, it'=
s actually two
> > > > > > + * iovecs, but we pack them into one and note how many of each=
 there were.
> > > > > > + *
> > > > > > + * This function returns the descriptor number found, or vq->n=
um (which is
> > > > > > + * never a valid descriptor number) if none was found.  A nega=
tive code is
> > > > > > + * returned on error.
> > > > > > + */
> > > > > > +int vhost_get_vq_desc(struct vhost_virtqueue *vq,
> > > > > > +                   struct iovec iov[], unsigned int iov_size,
> > > > > > +                   unsigned int *out_num, unsigned int *in_num=
,
> > > > > > +                   struct vhost_log *log, unsigned int *log_nu=
m)
> > > > > > +{
> > > > > > +     return vhost_get_vq_desc_n(vq, iov, iov_size, out_num, in=
_num,
> > > > > > +                                log, log_num, NULL);
> > > > > > +}
> > > > > >  EXPORT_SYMBOL_GPL(vhost_get_vq_desc);
> > > > > >
> > > > > >  /* Reverse the effect of vhost_get_vq_desc. Useful for error h=
andling. */
> > > > > > -void vhost_discard_vq_desc(struct vhost_virtqueue *vq, int n)
> > > > > > +void vhost_discard_vq_desc(struct vhost_virtqueue *vq, int n,
> > > > > > +                        unsigned int ndesc)
> > > > >
> > > > > ndesc is number of descriptors? And n is what, in that case?
> > > >
> > > > The semantic of n is not changed which is the number of buffers, nd=
esc
> > > > is the number of descriptors.
> > >
> > > History is not that relevant. To make the core readable pls
> > > change the names to readable ones.
> > >
> > > Specifically n is really nbufs, maybe?
> >
> > Right.
> >
> > Thanks
>
> All I am asking for is that in the API the parameter is named in a way
> that makes it clear what it is counting.
>
> vhost_get_vq_desc_n is the function you want to document, making it
> clear what is returned in ndesc and how it's different from the return
> value.

Will do.

Thanks

>
>
>
> --
> MST
>

