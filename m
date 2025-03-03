Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF2F51E7C03
	for <virtualization@lists.linux.dev>; Mon,  3 Mar 2025 18:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741026796; cv=none; b=OkAEZgSWFS4/WcHGni7Lj9uM0ry6GFy6Qi04oKD6QEpCj3TfZoZj1Ps8Zl9Wjt+xNw9fGiBZXJ35M6USFkFEbcjmHyi+SkYBBkHVUlweWvMK1j0jcYrpdY5OaLt5GWjcbFNG1rjYbOQ0ZzNX+4K0PhqdA0NB76sJY1/7jaoM5Cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741026796; c=relaxed/simple;
	bh=nLsZQWU52zNpjADgh0ICFnQQGW+rEKz5WdNIEuaOhHc=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vef3FKd9IPH3uMEeZw9u/8VUgmU/i2NZNV9eHXa2sA+kxp0ECyT+bSrNc+ipRmhdgdz3deaIcTY1h5KVhvoFNIbVnhPRDQmhplF2PmLAWlU3CaaoESg4CHGH0MGiz3S2nP8KusV0AKI7yH182jBunEbywLNQRFtyMRruYXP3G0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=MHY253SS; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="MHY253SS"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-474bc1aaf5fso63412701cf.0
        for <virtualization@lists.linux.dev>; Mon, 03 Mar 2025 10:33:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1741026793; x=1741631593; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=eue7H577BiYj6J1iAvYYX1Oj2dBdZtr+Y46C5Co92Q0=;
        b=MHY253SSHiVKv9B2XOUXTPXXA6cq5p70WYD8kHzzM1faONY5nmZhIjaJo+aRFDMcOk
         DqyksJ9jxbRPGhbd04Tp5bLZVQH7EL39CQloo0sAA8YTIvWwJGvkhTGK82F2erHl60BN
         zXt5t2aNI2tjP1qt8i4wUEEQpb2d5CGcKSQnU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741026793; x=1741631593;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eue7H577BiYj6J1iAvYYX1Oj2dBdZtr+Y46C5Co92Q0=;
        b=q5+nmDU1fPaN7sc/OmK8CTnWSkSsWPlnzf0znLR4uVQ/IoHrbDPs3nuNA4iZykzGwj
         Wrkw83ar6aYLNSKlyIZ6ctzRSx5DHVfnIlTFfyrJvGIuoFgCHnG2QHYKDJXhiW0wrUZI
         1RWF4rGCf7/YGBtSMDNJBjOBXEnHAwkefv2MdTIs8FTnvsRJeXEXzS3ixsBoIGIg/oI6
         rSI7xmvkf0hetzIzWzWDctPGpXtS4KdGrfIZy3u2E/I6JqUu7Zh2vWQveA3UC9aQeSF+
         uROwzXpmOvlxToMOpsgrZYWqwxpICNn1JqB/J5PFrNnpZ8sxc0j/6gz5tlV6+NL4zNvF
         +McA==
X-Forwarded-Encrypted: i=1; AJvYcCWHfZka/0F+WQ3BQl6JP6BYCepvWptA9IhWh53nmknDz1QSdtl41h8bkjhL/Xrb2elPf8CUkgJ1KqgU8gUSBQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw/KexvAhT3NvGqvJOo4iqMpH5lL/U49SJH1OmsxK+f46+SoPEt
	nErIx3n3jm53Ic7jxKFAnvuwwTuE3k+w/Chd0HezFEKOWdXMxE7MzMJtVwL21KLchSul5nnJ/q/
	9
X-Gm-Gg: ASbGncuK3zHlVN3mqf8j1L5dje0EBT0kZCxOPZSWZIMw0Ucw5X6g7pHPdy5BQOOC+ns
	hXDzwnjUxh9u44j8l56o532A7eH3cP/gZ/ZCdTKcpitDYRQfKdOyVOl+PV9L6oTKfOfMpp8ymbD
	bcw3MpyTeOmIQl9MrNaDmivWmYJSWdlNXjJ1rB88gD5LraG8b6PYXapvx5UwAq9akV0AqV9ZSRB
	SZiuS4ndDm7U27ewqUW7Py+pzD1Hr56wjbc3TJNU7ITKnoHtuGxDZelQ4QNOi+PmGhW3x+AX6d+
	rXFSh0IWkfv9m/LuospLH1x1ZLJDvM6PjBpd7Emf7bLC8pC4miognWT0Q5iJdvMmJSglfttb6pN
	Fb745BFE=
X-Google-Smtp-Source: AGHT+IF6Vz0gCa5XLjA6WsMMc9U4S/ofS/vlbDvCV4hoA9DNJ2ex3Jp7A+0DKEqmWTWUFP8908I9Cw==
X-Received: by 2002:a05:622a:1a9d:b0:471:f9e7:5042 with SMTP id d75a77b69052e-474bc083cc3mr236149171cf.14.1741026793293;
        Mon, 03 Mar 2025 10:33:13 -0800 (PST)
Received: from LQ3V64L9R2 (ool-44c5a22e.dyn.optonline.net. [68.197.162.46])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-474721bf582sm61201591cf.37.2025.03.03.10.33.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 10:33:12 -0800 (PST)
Date: Mon, 3 Mar 2025 13:33:10 -0500
From: Joe Damato <jdamato@fastly.com>
To: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	mkarsten@uwaterloo.ca, gerhard@engleder-embedded.com,
	jasowang@redhat.com, xuanzhuo@linux.alibaba.com, mst@redhat.com,
	leiyang@redhat.com,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	"open list:VIRTIO CORE AND NET DRIVERS" <virtualization@lists.linux.dev>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v5 3/4] virtio-net: Map NAPIs to queues
Message-ID: <Z8X15hxz8t-vXpPU@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	mkarsten@uwaterloo.ca, gerhard@engleder-embedded.com,
	jasowang@redhat.com, xuanzhuo@linux.alibaba.com, mst@redhat.com,
	leiyang@redhat.com,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	"open list:VIRTIO CORE AND NET DRIVERS" <virtualization@lists.linux.dev>,
	open list <linux-kernel@vger.kernel.org>
References: <20250227185017.206785-1-jdamato@fastly.com>
 <20250227185017.206785-4-jdamato@fastly.com>
 <20250228182759.74de5bec@kernel.org>
 <Z8Xc0muOV8jtHBkX@LQ3V64L9R2>
 <Z8XgGrToAD7Bak-I@LQ3V64L9R2>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8XgGrToAD7Bak-I@LQ3V64L9R2>

On Mon, Mar 03, 2025 at 12:00:10PM -0500, Joe Damato wrote:
> On Mon, Mar 03, 2025 at 11:46:10AM -0500, Joe Damato wrote:
> > On Fri, Feb 28, 2025 at 06:27:59PM -0800, Jakub Kicinski wrote:
> > > On Thu, 27 Feb 2025 18:50:13 +0000 Joe Damato wrote:
> > > > @@ -2870,9 +2883,15 @@ static void refill_work(struct work_struct *work)
> > > >  	for (i = 0; i < vi->curr_queue_pairs; i++) {
> > > >  		struct receive_queue *rq = &vi->rq[i];
> > > >  
> > > > +		rtnl_lock();
> > > >  		virtnet_napi_disable(rq);
> > > > +		rtnl_unlock();
> > > > +
> > > >  		still_empty = !try_fill_recv(vi, rq, GFP_KERNEL);
> > > > +
> > > > +		rtnl_lock();
> > > >  		virtnet_napi_enable(rq);
> > > > +		rtnl_unlock();
> > > 
> > > Looks to me like refill_work is cancelled _sync while holding rtnl_lock
> > > from the close path. I think this could deadlock?
> > 
> > Good catch, thank you!
> > 
> > It looks like this is also the case in the failure path on
> > virtnet_open.
> > 
> > Jason: do you have any suggestions?
> > 
> > It looks like in both open and close disable_delayed_refill is
> > called first, before the cancel_delayed_work_sync.
> > 
> > Would something like this solve the problem?
> > 
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index 76dcd65ec0f2..457115300f05 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -2880,6 +2880,13 @@ static void refill_work(struct work_struct *work)
> >         bool still_empty;
> >         int i;
> > 
> > +       spin_lock(&vi->refill_lock);
> > +       if (!vi->refill_enabled) {
> > +               spin_unlock(&vi->refill_lock);
> > +               return;
> > +       }
> > +       spin_unlock(&vi->refill_lock);
> > +
> >         for (i = 0; i < vi->curr_queue_pairs; i++) {
> >                 struct receive_queue *rq = &vi->rq[i];
> >
> 
> Err, I suppose this also doesn't work because:
> 
> CPU0                       CPU1
> rtnl_lock                  (before CPU0 calls disable_delayed_refill) 
>   virtnet_close            refill_work
>                              rtnl_lock()
>   cancel_sync <= deadlock
> 
> Need to give this a bit more thought.

How about we don't use the API at all from refill_work?

Patch 4 adds consistent NAPI config state and refill_work isn't a
queue resize maybe we don't need to call the netif_queue_set_napi at
all since the NAPI IDs are persisted in the NAPI config state and
refill_work shouldn't change that?

In which case, we could go back to what refill_work was doing
before and avoid the problem entirely.

What do you think ?

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 76dcd65ec0f2..d6c8fe670005 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -2883,15 +2883,9 @@ static void refill_work(struct work_struct *work)
        for (i = 0; i < vi->curr_queue_pairs; i++) {
                struct receive_queue *rq = &vi->rq[i];

-               rtnl_lock();
-               virtnet_napi_disable(rq);
-               rtnl_unlock();
-
+               napi_disable(&rq->napi);
                still_empty = !try_fill_recv(vi, rq, GFP_KERNEL);
-
-               rtnl_lock();
-               virtnet_napi_enable(rq);
-               rtnl_unlock();
+               virtnet_napi_do_enable(rq->vq, &rq->napi);

                /* In theory, this can happen: if we don't get any buffers in
                 * we will *never* try to fill again.
