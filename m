Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 849B819C553
	for <virtualization@lists.linux.dev>; Thu, 27 Feb 2025 04:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740631688; cv=none; b=VZ/SEliRY5GcDi6CY6SB13/KqvrbS/0p4TWKSgJUva6iY2v4VHiEO01LWQnS82CfUPHkGqq30Rv/Ir/Ko36W3kDTYldqKmHT8N5ytPpwRyVeGKz/YTFGTkVcnMISKDv8ar2BvrCKoMNKUDijVKk7k0GGzDrqhGm7Rs8stz1DyxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740631688; c=relaxed/simple;
	bh=Dz5CLJbJtxhty0xg8roq/GxXUaSa9CenQ02zc3yTaa8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g1iMhX/x5COviBnzVY8R6Tw4oMnsIAiLfqS4pDLHhlzE3i1XgnZai3zo0L63F27NuRmSXWCwLZukx9OQfkTjnjvtVK4RW0CYJjEXbv9wOtVL/5LdMR+uFna90U1IkBxz5xsbGrKhSDI1Bkon8O/eWlCK/6D4zvOoecctrkcUGvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=nSKKrvYh; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="nSKKrvYh"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4720a115d15so14513651cf.1
        for <virtualization@lists.linux.dev>; Wed, 26 Feb 2025 20:48:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1740631685; x=1741236485; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=j9RrWBQnGmr7pfCKfDKI3Or5JbQRE5y4Ygu5ENY7AJw=;
        b=nSKKrvYhW4VZB82TvrzVN47x4xt6MtInYzO13vUU3oUyy2n8L0jt6FTMcBhueQkJjw
         pBaoAwrU9KX9g8b3CFDoqLs9NDdLDvX2gZH4kzqIPwKq/ykk6STQk+xzQhxEYk0eAiJ7
         3wtimZRWPxxixUBlbzbU/AHtxkrDyp79R9Cq0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740631685; x=1741236485;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j9RrWBQnGmr7pfCKfDKI3Or5JbQRE5y4Ygu5ENY7AJw=;
        b=pvZf68L8y2gxh41wq243BjIuCtEa4RnWbF8RwAqDtm0Kk5ypxGFH41VuD9ZVwz1Kkm
         aODKjtQEk0pcKGpjw3TR5fRftc2R7DNxtaSpWIYWhR+qYCzUJRPY6CvMoy0TXfNDTd2W
         09Qgi8LpXZg8nDlhnGQU45i9UPliet1w6/znhQzXz+v4EfZ2tYywEsDtzYw8/yxYdyNS
         BXDFDlLawEKrOsqNk1V8rm7Wjp+eNGLoWO6Sgo1JoZgG8caLIax3TvxV22k3MYaBLZgz
         ewn91tbBsAzBXfjtBfHAyVBpEZIsKNoDVTo97Npi6/p7SrJG54D1a9FMTPLMPbIXlvPB
         puYQ==
X-Forwarded-Encrypted: i=1; AJvYcCXH4tUQs1MrZDW/qPivOS7Tee3yW6QOZd0W3Mnn1fPY1toEsAyAUt+bm6aNbjOIYKJ++bt/wiOezsEhhH/DhA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy5RZ1ediXX5VB3R2+v1mUnaznFDXF18OfmJSNWfWHldHE9hWNl
	RFO71ZuLI5d7QW9MOX6oriVxHKyVL1hL5MLavRRnv7CM+DgrHjvlzKiI6mQD6GI=
X-Gm-Gg: ASbGncsGHxsH638B8UhE2Srs8l8Q9EH0jB063zsPJnPCLBPVXnX/gtj5EzyRU7mGAlO
	86Gwh0/DWwm3eWbHdJky4h3w36sdkXHD2jhK3uGbN96cfuwHG/B/6krBJS3j/OzX1/DhRHkKKL7
	418r5VTlTnYcXEb9QaN8hN+oST4JCHQA2dCEv6CXIUTMM0DRagy3DDuQ6YU4ZIXT0K3nX5H2pyL
	CdyJy+oyfMc9v+lmkZGrI7Or+REjmD6S6NAlaCoMhyTAnomtQOlDEQOibXrgauqNxNgU43JBkFu
	RH6dEVe0ZKpd2FtFnGhxunjTHy7x+iMKiFDk94sR0rkXbmnfVNV6tTkS+y0b7kdp
X-Google-Smtp-Source: AGHT+IG6AMaCEtuGDNAymqPMHPgx7iO0OQVDvaKjbVaa0iyhzZP9jJJbU8LowBwmScd9NGrAxjr9OQ==
X-Received: by 2002:a05:622a:1187:b0:46f:d6c3:2ddc with SMTP id d75a77b69052e-473d8f7f11emr31340551cf.1.1740631685293;
        Wed, 26 Feb 2025 20:48:05 -0800 (PST)
Received: from LQ3V64L9R2 (ool-44c5a22e.dyn.optonline.net. [68.197.162.46])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-47472409ac2sm6469901cf.58.2025.02.26.20.48.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 20:48:04 -0800 (PST)
Date: Wed, 26 Feb 2025 23:48:01 -0500
From: Joe Damato <jdamato@fastly.com>
To: Jason Wang <jasowang@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org,
	mkarsten@uwaterloo.ca, gerhard@engleder-embedded.com,
	xuanzhuo@linux.alibaba.com, kuba@kernel.org,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	"open list:VIRTIO CORE AND NET DRIVERS" <virtualization@lists.linux.dev>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v4 3/4] virtio-net: Map NAPIs to queues
Message-ID: <Z7_ugUyyE1WPV_bb@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Jason Wang <jasowang@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org,
	mkarsten@uwaterloo.ca, gerhard@engleder-embedded.com,
	xuanzhuo@linux.alibaba.com, kuba@kernel.org,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	"open list:VIRTIO CORE AND NET DRIVERS" <virtualization@lists.linux.dev>,
	open list <linux-kernel@vger.kernel.org>
References: <20250225020455.212895-1-jdamato@fastly.com>
 <20250225020455.212895-4-jdamato@fastly.com>
 <CACGkMEv6y+TkZnWWLPG4UE59iyREhkiaby8kj==cnp=6chmu+w@mail.gmail.com>
 <Z79XXQjp9Dz7OYYQ@LQ3V64L9R2>
 <Z79YseiGrzYxoyvr@LQ3V64L9R2>
 <Z795Pt_RnfnvC-1N@LQ3V64L9R2>
 <20250226171252-mutt-send-email-mst@kernel.org>
 <CACGkMEv=ejJnOWDnAu7eULLvrqXjkMkTL4cbi-uCTUhCpKN_GA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEv=ejJnOWDnAu7eULLvrqXjkMkTL4cbi-uCTUhCpKN_GA@mail.gmail.com>

On Thu, Feb 27, 2025 at 12:18:33PM +0800, Jason Wang wrote:
> On Thu, Feb 27, 2025 at 6:13 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Wed, Feb 26, 2025 at 03:27:42PM -0500, Joe Damato wrote:
> > > On Wed, Feb 26, 2025 at 01:08:49PM -0500, Joe Damato wrote:
> > > > On Wed, Feb 26, 2025 at 01:03:09PM -0500, Joe Damato wrote:
> > > > > On Wed, Feb 26, 2025 at 01:48:50PM +0800, Jason Wang wrote:
> > > > > > On Tue, Feb 25, 2025 at 10:05 AM Joe Damato <jdamato@fastly.com> wrote:
> > > > > > >
> > > > > > > Use netif_queue_set_napi to map NAPIs to queue IDs so that the mapping
> > > > > > > can be accessed by user apps, taking care to hold RTNL as needed.
> > > > > >
> > > > > > I may miss something but I wonder whether letting the caller hold the
> > > > > > lock is better.
> > > > >
> > > > > Hmm...
> > > > >
> > > > > Double checking all the paths over again, here's what I see:
> > > > >   - refill_work, delayed work that needs RTNL so this change seems
> > > > >     right?
> > > > >
> > > > >   - virtnet_disable_queue_pair, called from virtnet_open and
> > > > >     virtnet_close. When called via NDO these are safe and hold RTNL,
> > > > >     but they can be called from power management and need RTNL.
> > > > >
> > > > >   - virtnet_enable_queue_pair called from virtnet_open, safe when
> > > > >     used via NDO but needs RTNL when used via power management.
> > > > >
> > > > >   - virtnet_rx_pause called in both paths as you mentioned, one
> > > > >     which needs RTNL and one which doesn't.
> > > >
> > > > Sorry, I missed more paths:
> > > >
> > > >     - virtnet_rx_resume
> > > >     - virtnet_tx_pause and virtnet_tx_resume
> > > >
> > > > which are similar to path you mentioned (virtnet_rx_pause) and need
> > > > rtnl in one of two different paths.
> > > >
> > > > Let me know if I missed any paths and what your preferred way to fix
> > > > this would be?
> > > >
> > > > I think both options below are possible and I have no strong
> > > > preference.
> > >
> > > OK, my apologies. I read your message and the code wrong. Sorry for
> > > the back-to-back emails from me.
> > >
> > > Please ignore my message above... I think after re-reading the code,
> > > here's where I've arrived:
> > >
> > >   - refill_work needs to hold RTNL (as in the existing patch)
> > >
> > >   - virtnet_rx_pause, virtnet_rx_resume, virtnet_tx_pause,
> > >     virtnet_tx_resume -- all do NOT need to hold RTNL because it is
> > >     already held in the ethtool resize path and the XSK path, as you
> > >     explained, but I mis-read (sorry).
> > >
> > >   - virtnet_disable_queue_pair and virtnet_enable_queue_pair both
> > >     need to hold RTNL only when called via power management, but not
> > >     when called via ndo_open or ndo_close
> > >
> > > Is my understanding correct and does it match your understanding?
> > >
> > > If so, that means there are two issues:
> > >
> > >   1. Fixing the hardcoded bools in rx_pause, rx_resume, tx_pause,
> > >      tx_resume (all should be false, RTNL is not needed).
> > >
> > >   2. Handling the power management case which calls virtnet_open and
> > >      virtnet_close.
> > >
> > > I made a small diff included below as an example of a possible
> > > solution:
> > >
> > >   1. Modify virtnet_disable_queue_pair and virtnet_enable_queue_pair
> > >      to take a "bool need_rtnl" and pass it through to the helpers
> > >      they call.
> > >
> > >   2. Create two helpers, virtnet_do_open and virt_do_close both of
> > >      which take struct net_device *dev, bool need_rtnl. virtnet_open
> > >      and virtnet_close are modified to call the helpers and pass
> > >      false for need_rtnl. The power management paths call the
> > >      helpers and pass true for need_rtnl. (fixes issue 2 above)
> > >
> > >   3. Fix the bools for rx_pause, rx_resume, tx_pause, tx_resume to
> > >      pass false since all paths that I could find that lead to these
> > >      functions hold RTNL. (fixes issue 1 above)
> > >
> > > See the diff below (which can be applied on top of patch 3) to see
> > > what it looks like.
> > >
> > > If you are OK with this approach, I will send a v5 where patch 3
> > > includes the changes shown in this diff.
> > >
> > > Please let me know what you think:
> >
> >
> >
> > Looks ok I think.
> >
> > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > index 13bb4a563073..76ecb8f3ce9a 100644
> > > --- a/drivers/net/virtio_net.c
> > > +++ b/drivers/net/virtio_net.c
> > > @@ -3098,14 +3098,16 @@ static int virtnet_poll(struct napi_struct *napi, int budget)
> > >       return received;
> > >  }
> > >
> > > -static void virtnet_disable_queue_pair(struct virtnet_info *vi, int qp_index)
> > > +static void virtnet_disable_queue_pair(struct virtnet_info *vi, int qp_index,
> > > +                                    bool need_rtnl)
> > >  {
> > > -     virtnet_napi_tx_disable(&vi->sq[qp_index], false);
> > > -     virtnet_napi_disable(&vi->rq[qp_index], false);
> > > +     virtnet_napi_tx_disable(&vi->sq[qp_index], need_rtnl);
> > > +     virtnet_napi_disable(&vi->rq[qp_index], need_rtnl);
> > >       xdp_rxq_info_unreg(&vi->rq[qp_index].xdp_rxq);
> > >  }
> > >
> > > -static int virtnet_enable_queue_pair(struct virtnet_info *vi, int qp_index)
> > > +static int virtnet_enable_queue_pair(struct virtnet_info *vi, int qp_index,
> > > +                                  bool need_rtnl)
> > >  {
> > >       struct net_device *dev = vi->dev;
> > >       int err;
> > > @@ -3120,8 +3122,8 @@ static int virtnet_enable_queue_pair(struct virtnet_info *vi, int qp_index)
> > >       if (err < 0)
> > >               goto err_xdp_reg_mem_model;
> > >
> > > -     virtnet_napi_enable(&vi->rq[qp_index], false);
> > > -     virtnet_napi_tx_enable(&vi->sq[qp_index], false);
> > > +     virtnet_napi_enable(&vi->rq[qp_index], need_rtnl);
> > > +     virtnet_napi_tx_enable(&vi->sq[qp_index], need_rtnl);
> > >
> > >       return 0;
> > >
> > > @@ -3156,7 +3158,7 @@ static void virtnet_update_settings(struct virtnet_info *vi)
> > >               vi->duplex = duplex;
> > >  }
> > >
> > > -static int virtnet_open(struct net_device *dev)
> > > +static int virtnet_do_open(struct net_device *dev, bool need_rtnl)
> > >  {
> > >       struct virtnet_info *vi = netdev_priv(dev);
> > >       int i, err;
> > > @@ -3169,7 +3171,7 @@ static int virtnet_open(struct net_device *dev)
> > >                       if (!try_fill_recv(vi, &vi->rq[i], GFP_KERNEL))
> > >                               schedule_delayed_work(&vi->refill, 0);
> > >
> > > -             err = virtnet_enable_queue_pair(vi, i);
> > > +             err = virtnet_enable_queue_pair(vi, i, need_rtnl);
> > >               if (err < 0)
> > >                       goto err_enable_qp;
> > >       }
> > > @@ -3190,13 +3192,18 @@ static int virtnet_open(struct net_device *dev)
> > >       cancel_delayed_work_sync(&vi->refill);
> > >
> > >       for (i--; i >= 0; i--) {
> > > -             virtnet_disable_queue_pair(vi, i);
> > > +             virtnet_disable_queue_pair(vi, i, need_rtnl);
> > >               virtnet_cancel_dim(vi, &vi->rq[i].dim);
> > >       }
> > >
> > >       return err;
> > >  }
> > >
> > > +static int virtnet_open(struct net_device *dev)
> > > +{
> > > +     return virtnet_do_open(dev, false);
> > > +}
> > > +
> > >  static int virtnet_poll_tx(struct napi_struct *napi, int budget)
> > >  {
> > >       struct send_queue *sq = container_of(napi, struct send_queue, napi);
> > > @@ -3373,7 +3380,7 @@ static void virtnet_rx_pause(struct virtnet_info *vi, struct receive_queue *rq)
> > >       bool running = netif_running(vi->dev);
> > >
> > >       if (running) {
> > > -             virtnet_napi_disable(rq, true);
> > > +             virtnet_napi_disable(rq, false);
> > >               virtnet_cancel_dim(vi, &rq->dim);
> > >       }
> > >  }
> > > @@ -3386,7 +3393,7 @@ static void virtnet_rx_resume(struct virtnet_info *vi, struct receive_queue *rq)
> > >               schedule_delayed_work(&vi->refill, 0);
> > >
> > >       if (running)
> > > -             virtnet_napi_enable(rq, true);
> > > +             virtnet_napi_enable(rq, false);
> > >  }
> > >
> > >  static int virtnet_rx_resize(struct virtnet_info *vi,
> > > @@ -3415,7 +3422,7 @@ static void virtnet_tx_pause(struct virtnet_info *vi, struct send_queue *sq)
> > >       qindex = sq - vi->sq;
> > >
> > >       if (running)
> > > -             virtnet_napi_tx_disable(sq, true);
> > > +             virtnet_napi_tx_disable(sq, false);
> > >
> > >       txq = netdev_get_tx_queue(vi->dev, qindex);
> > >
> > > @@ -3449,7 +3456,7 @@ static void virtnet_tx_resume(struct virtnet_info *vi, struct send_queue *sq)
> > >       __netif_tx_unlock_bh(txq);
> > >
> > >       if (running)
> > > -             virtnet_napi_tx_enable(sq, true);
> > > +             virtnet_napi_tx_enable(sq, false);
> 
> Instead of this, it looks to me it would be much simpler if we can
> just hold the rtnl lock in freeze/restore.

I disagree.

Holding RTNL for all of open and close instead of just the 1 API
call that needs it has the possibility of introducing other lock
ordering bugs now or in the future.

We only need RTNL for 1 API, why hold it for all of open or close?
