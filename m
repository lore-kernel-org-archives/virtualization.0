Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D1471D07BA
	for <virtualization@lists.linux.dev>; Thu, 27 Feb 2025 04:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740629930; cv=none; b=keXMaoZDO9jaEKX6quiS5J1tL7htwlI8kql96YVOy16RPjGTlmxN9qkcs4xsjH9kWaYItQ2ludQTuuRnG6CJd0B8k/ngWc30+PmMcU3LdjctLJxVwPsd5B4vqcJzM+V1BgIqMQxBqMWnRZ36sTXH3+ouLptPQiTmFzfIjDWfMWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740629930; c=relaxed/simple;
	bh=1VVOB+5HIZbTuri2DD6/2MWlh5ARSLCqhqwCGD9JXTw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XntglxaB1WCQRGQrOlqG//p1NO6kVsd/PQLqX11fWGZpP0xaIlbVlmh+Th/FgD2w/AHngf2+qr9odrG2qbJ22q0chzuYGNKVaovmLL7iAXy1l9q2tm9ooQCzReNZCSZSGgg+r7/S5niYyeI9cd4C0NF9lI2XOnI6FzzHY9phk60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K+LwwiZN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K+LwwiZN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740629927;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EZ0UDIL0wZfdL22hiRtuwOr2shEsAIgobx1O4hYXA98=;
	b=K+LwwiZNGhYFTjoKn24zCjKBmBoNDlFNPvTMJjLE/xl3sahq+l+ekrRkQ4Bo2Bwt5FPMhF
	UHFpZF9ev1rYi+wMI6nnwpTvi/81gLC0BW6NjDB58zD0dDxNSAbA691TU0mJsdb7S0PNYx
	iCRZHRgjUhqyrVusA+c2ouRNXOlFhj8=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-378-fa9FoZ5APsypxmNnu3HKIQ-1; Wed, 26 Feb 2025 23:18:46 -0500
X-MC-Unique: fa9FoZ5APsypxmNnu3HKIQ-1
X-Mimecast-MFC-AGG-ID: fa9FoZ5APsypxmNnu3HKIQ_1740629925
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2fc2b258e82so1189012a91.0
        for <virtualization@lists.linux.dev>; Wed, 26 Feb 2025 20:18:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740629925; x=1741234725;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EZ0UDIL0wZfdL22hiRtuwOr2shEsAIgobx1O4hYXA98=;
        b=mEgieWhYsDHn6dpvD5tesu8HnTdXVSic9BMXaHhRzwq/9k6FMmGj5hI3jabxLfeXaR
         Muc6Tm6sKJw7W0fx6j+O4EQzNMdE/Fs67Nh1WPA+luUfppNeG4Z3QasJDd3JxwuCGsqc
         Oz8G++GYMlrnHYkexPcwlH2hdeo3vantEORZLcdTuTxMdyf8ycxVQEV1R0VOJP/YyRW6
         j5P34nMqtdbCu044W944oDY+wKTMWJ4Wp09J6ya46ZpjxcHyxHXQbuep2b1OxOuL+Qwl
         Ao8NBpsrQMW7AX+Xq3sfDk6bVJqTgXODTHT8P2AElOaG1BDONVXgX+cu8J0LNYK7I1uH
         0Vbw==
X-Forwarded-Encrypted: i=1; AJvYcCWYr5x42+totrSQHnKsMF97xW9GJqIaRj3s9mkpWNuI3UsCW+rh0GGdCE8FZbRYJciP0VZ1lMoWJEYPTEZ0Jg==@lists.linux.dev
X-Gm-Message-State: AOJu0YziWckRsX/K+UfpMqejEYgosj7m9bRhMw7aTL1BFoDJzTjXHqi5
	SAgKfYW/qS0GKsAIhZkpfyuxjutlf2E7mvdIH/kD2K9FzPPrqyrvgWoD8FzgGCP/09IB0jJJc6N
	FekahGlChmki8Y+RoT60du7jO52VvN38+JgdJYPIyHGNp13rA9qE74wJngxNELVqYMGs+RzOPlK
	Uy0IJK8Ebz+Pu/koMMX88Eb0M/s3OZV5mRuyAoJU4=
X-Gm-Gg: ASbGncuTvnmWEGT3IzlcXff8DriE0NNuTBvDp1dEahJuxhtNzh4xfcgqWVt+b7C38qf
	g157FZvkqqnQSloFETuJ50QzYhsRwzAk3ntckoomVGnbobJo0an6l8lrugFK4Le9q5OO7EXBBbQ
	==
X-Received: by 2002:a17:90b:2411:b0:2fe:a545:4c84 with SMTP id 98e67ed59e1d1-2fea5454d1emr1541112a91.34.1740629925129;
        Wed, 26 Feb 2025 20:18:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFpxoLlIbPBR1z+e3dptMbf0F6aseLOY6nkspSv1OJx3k/0gEXTNw6rvyxRnzs6DHRWsHIlvDdDlJHnaeA+Gzg=
X-Received: by 2002:a17:90b:2411:b0:2fe:a545:4c84 with SMTP id
 98e67ed59e1d1-2fea5454d1emr1541087a91.34.1740629924715; Wed, 26 Feb 2025
 20:18:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250225020455.212895-1-jdamato@fastly.com> <20250225020455.212895-4-jdamato@fastly.com>
 <CACGkMEv6y+TkZnWWLPG4UE59iyREhkiaby8kj==cnp=6chmu+w@mail.gmail.com>
 <Z79XXQjp9Dz7OYYQ@LQ3V64L9R2> <Z79YseiGrzYxoyvr@LQ3V64L9R2>
 <Z795Pt_RnfnvC-1N@LQ3V64L9R2> <20250226171252-mutt-send-email-mst@kernel.org>
In-Reply-To: <20250226171252-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 27 Feb 2025 12:18:33 +0800
X-Gm-Features: AQ5f1JrcgH-RY0XhWOvBxo3ebVPfT8pD_akPl5SaLe6th0YudFAaLBbFw06vL8o
Message-ID: <CACGkMEv=ejJnOWDnAu7eULLvrqXjkMkTL4cbi-uCTUhCpKN_GA@mail.gmail.com>
Subject: Re: [PATCH net-next v4 3/4] virtio-net: Map NAPIs to queues
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Joe Damato <jdamato@fastly.com>, netdev@vger.kernel.org, mkarsten@uwaterloo.ca, 
	gerhard@engleder-embedded.com, xuanzhuo@linux.alibaba.com, kuba@kernel.org, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	"open list:VIRTIO CORE AND NET DRIVERS" <virtualization@lists.linux.dev>, open list <linux-kernel@vger.kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: YkL1R9coPb22uCosAsWR-zD5q6yGDWvuJgl7i-rZkYg_1740629925
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 27, 2025 at 6:13=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Wed, Feb 26, 2025 at 03:27:42PM -0500, Joe Damato wrote:
> > On Wed, Feb 26, 2025 at 01:08:49PM -0500, Joe Damato wrote:
> > > On Wed, Feb 26, 2025 at 01:03:09PM -0500, Joe Damato wrote:
> > > > On Wed, Feb 26, 2025 at 01:48:50PM +0800, Jason Wang wrote:
> > > > > On Tue, Feb 25, 2025 at 10:05=E2=80=AFAM Joe Damato <jdamato@fast=
ly.com> wrote:
> > > > > >
> > > > > > Use netif_queue_set_napi to map NAPIs to queue IDs so that the =
mapping
> > > > > > can be accessed by user apps, taking care to hold RTNL as neede=
d.
> > > > >
> > > > > I may miss something but I wonder whether letting the caller hold=
 the
> > > > > lock is better.
> > > >
> > > > Hmm...
> > > >
> > > > Double checking all the paths over again, here's what I see:
> > > >   - refill_work, delayed work that needs RTNL so this change seems
> > > >     right?
> > > >
> > > >   - virtnet_disable_queue_pair, called from virtnet_open and
> > > >     virtnet_close. When called via NDO these are safe and hold RTNL=
,
> > > >     but they can be called from power management and need RTNL.
> > > >
> > > >   - virtnet_enable_queue_pair called from virtnet_open, safe when
> > > >     used via NDO but needs RTNL when used via power management.
> > > >
> > > >   - virtnet_rx_pause called in both paths as you mentioned, one
> > > >     which needs RTNL and one which doesn't.
> > >
> > > Sorry, I missed more paths:
> > >
> > >     - virtnet_rx_resume
> > >     - virtnet_tx_pause and virtnet_tx_resume
> > >
> > > which are similar to path you mentioned (virtnet_rx_pause) and need
> > > rtnl in one of two different paths.
> > >
> > > Let me know if I missed any paths and what your preferred way to fix
> > > this would be?
> > >
> > > I think both options below are possible and I have no strong
> > > preference.
> >
> > OK, my apologies. I read your message and the code wrong. Sorry for
> > the back-to-back emails from me.
> >
> > Please ignore my message above... I think after re-reading the code,
> > here's where I've arrived:
> >
> >   - refill_work needs to hold RTNL (as in the existing patch)
> >
> >   - virtnet_rx_pause, virtnet_rx_resume, virtnet_tx_pause,
> >     virtnet_tx_resume -- all do NOT need to hold RTNL because it is
> >     already held in the ethtool resize path and the XSK path, as you
> >     explained, but I mis-read (sorry).
> >
> >   - virtnet_disable_queue_pair and virtnet_enable_queue_pair both
> >     need to hold RTNL only when called via power management, but not
> >     when called via ndo_open or ndo_close
> >
> > Is my understanding correct and does it match your understanding?
> >
> > If so, that means there are two issues:
> >
> >   1. Fixing the hardcoded bools in rx_pause, rx_resume, tx_pause,
> >      tx_resume (all should be false, RTNL is not needed).
> >
> >   2. Handling the power management case which calls virtnet_open and
> >      virtnet_close.
> >
> > I made a small diff included below as an example of a possible
> > solution:
> >
> >   1. Modify virtnet_disable_queue_pair and virtnet_enable_queue_pair
> >      to take a "bool need_rtnl" and pass it through to the helpers
> >      they call.
> >
> >   2. Create two helpers, virtnet_do_open and virt_do_close both of
> >      which take struct net_device *dev, bool need_rtnl. virtnet_open
> >      and virtnet_close are modified to call the helpers and pass
> >      false for need_rtnl. The power management paths call the
> >      helpers and pass true for need_rtnl. (fixes issue 2 above)
> >
> >   3. Fix the bools for rx_pause, rx_resume, tx_pause, tx_resume to
> >      pass false since all paths that I could find that lead to these
> >      functions hold RTNL. (fixes issue 1 above)
> >
> > See the diff below (which can be applied on top of patch 3) to see
> > what it looks like.
> >
> > If you are OK with this approach, I will send a v5 where patch 3
> > includes the changes shown in this diff.
> >
> > Please let me know what you think:
>
>
>
> Looks ok I think.
>
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index 13bb4a563073..76ecb8f3ce9a 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -3098,14 +3098,16 @@ static int virtnet_poll(struct napi_struct *nap=
i, int budget)
> >       return received;
> >  }
> >
> > -static void virtnet_disable_queue_pair(struct virtnet_info *vi, int qp=
_index)
> > +static void virtnet_disable_queue_pair(struct virtnet_info *vi, int qp=
_index,
> > +                                    bool need_rtnl)
> >  {
> > -     virtnet_napi_tx_disable(&vi->sq[qp_index], false);
> > -     virtnet_napi_disable(&vi->rq[qp_index], false);
> > +     virtnet_napi_tx_disable(&vi->sq[qp_index], need_rtnl);
> > +     virtnet_napi_disable(&vi->rq[qp_index], need_rtnl);
> >       xdp_rxq_info_unreg(&vi->rq[qp_index].xdp_rxq);
> >  }
> >
> > -static int virtnet_enable_queue_pair(struct virtnet_info *vi, int qp_i=
ndex)
> > +static int virtnet_enable_queue_pair(struct virtnet_info *vi, int qp_i=
ndex,
> > +                                  bool need_rtnl)
> >  {
> >       struct net_device *dev =3D vi->dev;
> >       int err;
> > @@ -3120,8 +3122,8 @@ static int virtnet_enable_queue_pair(struct virtn=
et_info *vi, int qp_index)
> >       if (err < 0)
> >               goto err_xdp_reg_mem_model;
> >
> > -     virtnet_napi_enable(&vi->rq[qp_index], false);
> > -     virtnet_napi_tx_enable(&vi->sq[qp_index], false);
> > +     virtnet_napi_enable(&vi->rq[qp_index], need_rtnl);
> > +     virtnet_napi_tx_enable(&vi->sq[qp_index], need_rtnl);
> >
> >       return 0;
> >
> > @@ -3156,7 +3158,7 @@ static void virtnet_update_settings(struct virtne=
t_info *vi)
> >               vi->duplex =3D duplex;
> >  }
> >
> > -static int virtnet_open(struct net_device *dev)
> > +static int virtnet_do_open(struct net_device *dev, bool need_rtnl)
> >  {
> >       struct virtnet_info *vi =3D netdev_priv(dev);
> >       int i, err;
> > @@ -3169,7 +3171,7 @@ static int virtnet_open(struct net_device *dev)
> >                       if (!try_fill_recv(vi, &vi->rq[i], GFP_KERNEL))
> >                               schedule_delayed_work(&vi->refill, 0);
> >
> > -             err =3D virtnet_enable_queue_pair(vi, i);
> > +             err =3D virtnet_enable_queue_pair(vi, i, need_rtnl);
> >               if (err < 0)
> >                       goto err_enable_qp;
> >       }
> > @@ -3190,13 +3192,18 @@ static int virtnet_open(struct net_device *dev)
> >       cancel_delayed_work_sync(&vi->refill);
> >
> >       for (i--; i >=3D 0; i--) {
> > -             virtnet_disable_queue_pair(vi, i);
> > +             virtnet_disable_queue_pair(vi, i, need_rtnl);
> >               virtnet_cancel_dim(vi, &vi->rq[i].dim);
> >       }
> >
> >       return err;
> >  }
> >
> > +static int virtnet_open(struct net_device *dev)
> > +{
> > +     return virtnet_do_open(dev, false);
> > +}
> > +
> >  static int virtnet_poll_tx(struct napi_struct *napi, int budget)
> >  {
> >       struct send_queue *sq =3D container_of(napi, struct send_queue, n=
api);
> > @@ -3373,7 +3380,7 @@ static void virtnet_rx_pause(struct virtnet_info =
*vi, struct receive_queue *rq)
> >       bool running =3D netif_running(vi->dev);
> >
> >       if (running) {
> > -             virtnet_napi_disable(rq, true);
> > +             virtnet_napi_disable(rq, false);
> >               virtnet_cancel_dim(vi, &rq->dim);
> >       }
> >  }
> > @@ -3386,7 +3393,7 @@ static void virtnet_rx_resume(struct virtnet_info=
 *vi, struct receive_queue *rq)
> >               schedule_delayed_work(&vi->refill, 0);
> >
> >       if (running)
> > -             virtnet_napi_enable(rq, true);
> > +             virtnet_napi_enable(rq, false);
> >  }
> >
> >  static int virtnet_rx_resize(struct virtnet_info *vi,
> > @@ -3415,7 +3422,7 @@ static void virtnet_tx_pause(struct virtnet_info =
*vi, struct send_queue *sq)
> >       qindex =3D sq - vi->sq;
> >
> >       if (running)
> > -             virtnet_napi_tx_disable(sq, true);
> > +             virtnet_napi_tx_disable(sq, false);
> >
> >       txq =3D netdev_get_tx_queue(vi->dev, qindex);
> >
> > @@ -3449,7 +3456,7 @@ static void virtnet_tx_resume(struct virtnet_info=
 *vi, struct send_queue *sq)
> >       __netif_tx_unlock_bh(txq);
> >
> >       if (running)
> > -             virtnet_napi_tx_enable(sq, true);
> > +             virtnet_napi_tx_enable(sq, false);

Instead of this, it looks to me it would be much simpler if we can
just hold the rtnl lock in freeze/restore.

Thanks

