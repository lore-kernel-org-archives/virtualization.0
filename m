Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B82E421C19E
	for <virtualization@lists.linux.dev>; Wed, 26 Feb 2025 18:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740592995; cv=none; b=PhsTfVjv60VjJnbBh/+shbhYVaBBCSQ7E4PWLQpSmWyx8AsJ+s0M6AL0xsnMbbxnuEhbT+eKFwPRS9YDtSmuLdjecB0xmRhRtuldBzhps5SwR1UCzXVPEvIJByppYrSvVIQg3GwyaL2SulkqucvDeAZo9ntJILHTzYZxdYNjePE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740592995; c=relaxed/simple;
	bh=pk0pC6t6um9qBn4p+8lB7nBwhVbJXCecjo9e4IElSVg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hdYqrKwM/Sd+Pd0UVIIjf5cApwaTyCQIc1Ns1uPADga22OQ9khtcqMP2LTM0z+wPe8SXhvHD54G8fJDuU/smzvpTWZ3unMIGM7d9Dq/3aPu/gn1jqgWv6mBdzItbCltmVU73viup13dM/YJd6Qdbjc9zVDgHDrIqyfmPFQrEqNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=ZBd9A0xj; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="ZBd9A0xj"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6e6846bcde2so1183196d6.1
        for <virtualization@lists.linux.dev>; Wed, 26 Feb 2025 10:03:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1740592991; x=1741197791; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=of80sMkyjgbyIQl9C+Zi/ibA5uGcLRduGmbGJlBkuUg=;
        b=ZBd9A0xjqlDhAqplZXkBS1cJXYQykfFz1q0mkBoyASAPW+G2vxfWdlU2JaogaaYsND
         HvKDwLYvRuWyWeS1jm1WAjO56V9t8AIVHitxOvgitD47xb/sjyt8xJ3p3JliQGSCTDQC
         jl5LBoHCz33cSgpbpaBN3ksbZiTOmONv3ln+A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740592991; x=1741197791;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=of80sMkyjgbyIQl9C+Zi/ibA5uGcLRduGmbGJlBkuUg=;
        b=HfHZQXT4hFzHhSC3zfBO8rkJl54M0hQvrhj5CNTYDGbbvYJCnDEyJkZr4jOsem/ggW
         X4dDWIyjRmeW5cuFE9CUsDL/A5W+ab0PYp2XDLugzh71wm44qLlCBDf1pCbSx/NaRuGA
         i9s0RDIo8qICh02Ca8AuyYhm4yRHmO99R0hX14gZepbYWGJ14N+/mSCZbpZ+0JM7SDLV
         9jB/yfjmuaN1AMkQjBUj3gbSLc0NfqYOkKGYqmEh8lDj/i2repYZmAbf3qwNIi2llvP8
         rNk1m6jcuesEV1PEpGy2OSKi9nGfydUjqetWKlgzOjDxcPx6IESMoi3+hHc/UXDpLr7L
         A//g==
X-Forwarded-Encrypted: i=1; AJvYcCVQ1I8JeGkqh1YF5HhGgTrfsRsZRh20bMWTg837mE3z46K1mXlJlRYWJ8q80J3gnIaF2Yo6v3TLp2ZcwnOeOg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw7hXkzZyv0WACLafay7zv6p6twdfOejCFXbYRvcH8ECLPeFzrD
	ITmWuvJgHykdNf6nBgDWgnE28N0cEQIi7dIDjH4u7km6FQOIyykhNVa5r+3hb5U=
X-Gm-Gg: ASbGnctg6OPrZcdNWFKgVPPwhBtKzR4trXup0FelI5Yo5JvYN6sxonYDE+h6+wxxcLP
	Ba21rmsIerwhI92Cc4oLM6on6xlIwUxsw4Xe+UgHwJfGwPnbRRA47nb81K3Y0hHLl9tDLnSyQAq
	ZlcwjneJUd8eZk8302tXbvtr5r0vROoDmbqDTjWqpDYLplUnzMZicmLehD0PTNXSqoOURfeD1Ac
	dqwgdvegU+XzPsbDz/IRs6Q0am6nhYFHbAXbkmD9oDDJo5Rt0ktD4uR/R2pBFb648CRxURLEAHl
	UxtvEOuq7H2C5ep/+6NESKu2KmHWSSmWcjCLklXBeghnKh/+l2Q7NyKayvnN065O
X-Google-Smtp-Source: AGHT+IGAaBd6il+E1Xhz7b8qOTER0+iOVpZwG28KVQBnLO0jK5b6kJjGK/qvC93o6b4QspR98NE2kQ==
X-Received: by 2002:a05:6214:f25:b0:6e4:4331:aae4 with SMTP id 6a1803df08f44-6e87ab2f5bdmr108569456d6.1.1740592991562;
        Wed, 26 Feb 2025 10:03:11 -0800 (PST)
Received: from LQ3V64L9R2 (ool-44c5a22e.dyn.optonline.net. [68.197.162.46])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e87b06dc57sm25238316d6.15.2025.02.26.10.03.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 10:03:11 -0800 (PST)
Date: Wed, 26 Feb 2025 13:03:09 -0500
From: Joe Damato <jdamato@fastly.com>
To: Jason Wang <jasowang@redhat.com>
Cc: netdev@vger.kernel.org, mkarsten@uwaterloo.ca,
	gerhard@engleder-embedded.com, xuanzhuo@linux.alibaba.com,
	kuba@kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	"open list:VIRTIO CORE AND NET DRIVERS" <virtualization@lists.linux.dev>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v4 3/4] virtio-net: Map NAPIs to queues
Message-ID: <Z79XXQjp9Dz7OYYQ@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Jason Wang <jasowang@redhat.com>, netdev@vger.kernel.org,
	mkarsten@uwaterloo.ca, gerhard@engleder-embedded.com,
	xuanzhuo@linux.alibaba.com, kuba@kernel.org,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	"open list:VIRTIO CORE AND NET DRIVERS" <virtualization@lists.linux.dev>,
	open list <linux-kernel@vger.kernel.org>
References: <20250225020455.212895-1-jdamato@fastly.com>
 <20250225020455.212895-4-jdamato@fastly.com>
 <CACGkMEv6y+TkZnWWLPG4UE59iyREhkiaby8kj==cnp=6chmu+w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEv6y+TkZnWWLPG4UE59iyREhkiaby8kj==cnp=6chmu+w@mail.gmail.com>

On Wed, Feb 26, 2025 at 01:48:50PM +0800, Jason Wang wrote:
> On Tue, Feb 25, 2025 at 10:05 AM Joe Damato <jdamato@fastly.com> wrote:
> >
> > Use netif_queue_set_napi to map NAPIs to queue IDs so that the mapping
> > can be accessed by user apps, taking care to hold RTNL as needed.
> 
> I may miss something but I wonder whether letting the caller hold the
> lock is better.

Hmm...

Double checking all the paths over again, here's what I see:
  - refill_work, delayed work that needs RTNL so this change seems
    right?

  - virtnet_disable_queue_pair, called from virtnet_open and
    virtnet_close. When called via NDO these are safe and hold RTNL,
    but they can be called from power management and need RTNL.

  - virtnet_enable_queue_pair called from virtnet_open, safe when
    used via NDO but needs RTNL when used via power management.

  - virtnet_rx_pause called in both paths as you mentioned, one
    which needs RTNL and one which doesn't.

I think there are a couple ways to fix this:

  1. Edit this patch to remove the virtnet_queue_set_napi helper,
     and call netif_queue_set_napi from the napi_enable and
     napi_disable helpers directly. Modify code calling into these
     paths to hold rtnl (or not) as described above.

  2. Modify virtnet_enable_queue_pair, virtnet_disable_queue_pair,
     and virtnet_rx_pause to take a "bool need_rtnl" as an a
     function argument and pass that through.

I'm not sure which is cleaner and I do not have a preference.

Can you let me know which you prefer? I am happy to implement either
one for the next revision.

[...]

> > ---
> >  drivers/net/virtio_net.c | 73 ++++++++++++++++++++++++++++------------
> >  1 file changed, 52 insertions(+), 21 deletions(-)
> >
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index e578885c1093..13bb4a563073 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -2807,6 +2807,20 @@ static void skb_recv_done(struct virtqueue *rvq)
> >         virtqueue_napi_schedule(&rq->napi, rvq);
> >  }
> >
> > +static void virtnet_queue_set_napi(struct net_device *dev,
> > +                                  struct napi_struct *napi,
> > +                                  enum netdev_queue_type q_type, int qidx,
> > +                                  bool need_rtnl)
> > +{
> > +       if (need_rtnl)
> > +               rtnl_lock();
> > +
> > +       netif_queue_set_napi(dev, qidx, q_type, napi);
> > +
> > +       if (need_rtnl)
> > +               rtnl_unlock();
> > +}
> > +
> >  static void virtnet_napi_do_enable(struct virtqueue *vq,
> >                                    struct napi_struct *napi)
> >  {
> > @@ -2821,15 +2835,21 @@ static void virtnet_napi_do_enable(struct virtqueue *vq,
> >         local_bh_enable();
> >  }
> >
> > -static void virtnet_napi_enable(struct receive_queue *rq)
> > +static void virtnet_napi_enable(struct receive_queue *rq, bool need_rtnl)
> >  {
> > +       struct virtnet_info *vi = rq->vq->vdev->priv;
> > +       int qidx = vq2rxq(rq->vq);
> > +
> >         virtnet_napi_do_enable(rq->vq, &rq->napi);
> > +       virtnet_queue_set_napi(vi->dev, &rq->napi,
> > +                              NETDEV_QUEUE_TYPE_RX, qidx, need_rtnl);
> >  }
> >
> > -static void virtnet_napi_tx_enable(struct send_queue *sq)
> > +static void virtnet_napi_tx_enable(struct send_queue *sq, bool need_rtnl)
> >  {
> >         struct virtnet_info *vi = sq->vq->vdev->priv;
> >         struct napi_struct *napi = &sq->napi;
> > +       int qidx = vq2txq(sq->vq);
> >
> >         if (!napi->weight)
> >                 return;
> > @@ -2843,20 +2863,31 @@ static void virtnet_napi_tx_enable(struct send_queue *sq)
> >         }
> >
> >         virtnet_napi_do_enable(sq->vq, napi);
> > +       virtnet_queue_set_napi(vi->dev, napi, NETDEV_QUEUE_TYPE_TX, qidx,
> > +                              need_rtnl);
> >  }
> >
> > -static void virtnet_napi_tx_disable(struct send_queue *sq)
> > +static void virtnet_napi_tx_disable(struct send_queue *sq, bool need_rtnl)
> >  {
> > +       struct virtnet_info *vi = sq->vq->vdev->priv;
> >         struct napi_struct *napi = &sq->napi;
> > +       int qidx = vq2txq(sq->vq);
> >
> > -       if (napi->weight)
> > +       if (napi->weight) {
> > +               virtnet_queue_set_napi(vi->dev, NULL, NETDEV_QUEUE_TYPE_TX,
> > +                                      qidx, need_rtnl);
> >                 napi_disable(napi);
> > +       }
> >  }
> >
> > -static void virtnet_napi_disable(struct receive_queue *rq)
> > +static void virtnet_napi_disable(struct receive_queue *rq, bool need_rtnl)
> >  {
> > +       struct virtnet_info *vi = rq->vq->vdev->priv;
> >         struct napi_struct *napi = &rq->napi;
> > +       int qidx = vq2rxq(rq->vq);
> >
> > +       virtnet_queue_set_napi(vi->dev, NULL, NETDEV_QUEUE_TYPE_TX, qidx,
> > +                              need_rtnl);
> >         napi_disable(napi);
> >  }
> >
> > @@ -2870,9 +2901,9 @@ static void refill_work(struct work_struct *work)
> >         for (i = 0; i < vi->curr_queue_pairs; i++) {
> >                 struct receive_queue *rq = &vi->rq[i];
> >
> > -               virtnet_napi_disable(rq);
> > +               virtnet_napi_disable(rq, true);
> >                 still_empty = !try_fill_recv(vi, rq, GFP_KERNEL);
> > -               virtnet_napi_enable(rq);
> > +               virtnet_napi_enable(rq, true);
> >
> >                 /* In theory, this can happen: if we don't get any buffers in
> >                  * we will *never* try to fill again.
> > @@ -3069,8 +3100,8 @@ static int virtnet_poll(struct napi_struct *napi, int budget)
> >
> >  static void virtnet_disable_queue_pair(struct virtnet_info *vi, int qp_index)
> >  {
> > -       virtnet_napi_tx_disable(&vi->sq[qp_index]);
> > -       virtnet_napi_disable(&vi->rq[qp_index]);
> > +       virtnet_napi_tx_disable(&vi->sq[qp_index], false);
> > +       virtnet_napi_disable(&vi->rq[qp_index], false);
> >         xdp_rxq_info_unreg(&vi->rq[qp_index].xdp_rxq);
> >  }
> >
> > @@ -3089,8 +3120,8 @@ static int virtnet_enable_queue_pair(struct virtnet_info *vi, int qp_index)
> >         if (err < 0)
> >                 goto err_xdp_reg_mem_model;
> >
> > -       virtnet_napi_enable(&vi->rq[qp_index]);
> > -       virtnet_napi_tx_enable(&vi->sq[qp_index]);
> > +       virtnet_napi_enable(&vi->rq[qp_index], false);
> > +       virtnet_napi_tx_enable(&vi->sq[qp_index], false);
> >
> >         return 0;
> >
> > @@ -3342,7 +3373,7 @@ static void virtnet_rx_pause(struct virtnet_info *vi, struct receive_queue *rq)
> >         bool running = netif_running(vi->dev);
> >
> >         if (running) {
> > -               virtnet_napi_disable(rq);
> > +               virtnet_napi_disable(rq, true);
> 
> During the resize, the rtnl lock has been held on the ethtool path
> 
>         rtnl_lock();
>         rc = __dev_ethtool(net, ifr, useraddr, ethcmd, state);
>         rtnl_unlock();
> 
> virtnet_rx_resize()
>     virtnet_rx_pause()
> 
> and in the case of XSK binding, I see ASSERT_RTNL in xp_assign_dev() at least.

Thanks for catching this. I re-read all the paths and I think I've
outlined a few other issues above.

Please let me know which of the proposed methods above you'd like me
to implement to get this merged.

Thanks.

---
pw-bot: cr
