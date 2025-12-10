Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01F2E1E49F
	for <virtualization@lists.linux.dev>; Wed, 10 Dec 2025 05:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765345537; cv=none; b=LcnzLJ+bGUB2JrjlUqd+tKBluENeeDvrV1zgBl6LM9ZSMmRArd9bTM9wWwTplPTPfaz7Ih+8TdDIqfgfdeRw0dJw+pX9HG7JrFjmr1EVN0wvICcnrFQ5FfIVw70S6w3BVFDlphP6waZgRy96a9raLIvnpjUuJDaw5MTIJ1FB0tU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765345537; c=relaxed/simple;
	bh=w6iiCVQLpFikPUe4uciKj0mkXr2KE4ORLhI9r5rmOzE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ISrhGzqTb7qIoeeMZekF/VLrzICOc+qOg6cWSOT3mPxK+dGgtPh4wf56mgNU3gXbpcyAgInVOqGF4qA8V6Ex4czn+qaHfKZAWiwETDMHiWo5vgLwbs7gduVc4S/8NonFApqWEuSgivOTFdbu5awf7TSpJ5LKPnzPGGCRl9cQNY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aMpzgr5J; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aMpzgr5J"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765345535;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U5u9zjHxp5nOkcmQAgH5/2pjjFKz+7xciix+1rrgeQw=;
	b=aMpzgr5JEKi+SSFpRO+X3Nb39rOBFKDCPtX8Tvez79DzxXSE7FIsam/z9B5/p8aKUNnNVJ
	LLG/Jj3l60DCKnyRhW2V77IXD/WdpmEc9G7LYjI6lTEZFEQ4LNG3iZmbs0kS8hAhTrO4B7
	iPe4v75wBvNoyFpUDNBAxhRzTFpNnls=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617-fw9_VdI2MWeJAVHjuWUCEg-1; Wed, 10 Dec 2025 00:45:33 -0500
X-MC-Unique: fw9_VdI2MWeJAVHjuWUCEg-1
X-Mimecast-MFC-AGG-ID: fw9_VdI2MWeJAVHjuWUCEg_1765345532
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-343e262230eso7231875a91.2
        for <virtualization@lists.linux.dev>; Tue, 09 Dec 2025 21:45:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765345532; x=1765950332;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=U5u9zjHxp5nOkcmQAgH5/2pjjFKz+7xciix+1rrgeQw=;
        b=IFqaSyY+dphnDKLNUKy1Jf5y6SR4Zwms9yOYbiJyr6KToaB/1OKOwJQtoqiMy8yUQQ
         zeb/XzqAFxpjj/iHDxUSZo2rTTJ6Dzh/nysKEk5ncbAXZG+HW3Y7bDCCGJiYLMlDGSSZ
         o6KEOqvc6Q5lgpivUjPUJpS9pnQJ9Yq5Ze1eTpbpGGoIFcujtMppopTyVcjOfp6pAVip
         wOPqLk7YcAJSvjRqbuzX70HvgG1VfvdR8OWTs2Jw8UEGv70cEAWkGg1HSZgokVia7C9U
         OgUjrVOnHyqT0mvwm2Zctltj8ci2jU+inrooiOdyIaeCGEbRUN2PgVXxFs9n2mIcN0gw
         v73A==
X-Forwarded-Encrypted: i=1; AJvYcCWRbJBP1rH684lDO/JQ/ympKXFxbzGZ4cS82WgoQ/LQczstT1vJ+TYcvTboe4xfr3mMDbA5r+YHFDWcEAQEHA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzanGX2yk/qBf7Q9DXYtiIHcp9gZ0rh4JEl3tbCahqJfkfGNtf1
	TB1nY5SGnsKPcmUXWNEBBaHVCiL4z/ex27rOJ1nf2gHlWAb6OTBZ8bsD7Bl2tRaKpRBsr9wXza/
	FFejVNuVBjAhdGjmCFn8OZK00VRpXnWwXZNmJ0CanDXJugcv+UKzP2PInYkcYtVGUvtajbsl+Aa
	xJ54TfXxZ07H0CgZhf0dUn1hm7ANt9cwcvm2KO4zl82Ko=
X-Gm-Gg: AY/fxX7LcZF1rQDht8SYDol5aV47g3P0Hh+66y5Ux7p02apuCrxnal4WsMvUWz6NHeb
	dJ6yby93RaKLSzkfD2hA1RMohw8KBkFOAuowz2IXsK24iyKotYOO/ZAOCPH7JIQanh7hq46or6c
	yMDo9qR3sZJXsiyrV9xrrnOAxJlljX8ZLs4fcwMI7DVy3RJrPQtYIUdhs1P/nh33z+TPw=
X-Received: by 2002:a17:90b:3847:b0:340:a5b2:c305 with SMTP id 98e67ed59e1d1-34a72808f67mr1088302a91.2.1765345532551;
        Tue, 09 Dec 2025 21:45:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGh6+dEVRAMV2C5vYHDGZU4Qf85RNHec+uPwoESl74tc15tqIpJSGl+Ri/dVxp9XR0wrBpc75hUH8L0OPBAOfQ=
X-Received: by 2002:a17:90b:3847:b0:340:a5b2:c305 with SMTP id
 98e67ed59e1d1-34a72808f67mr1088273a91.2.1765345532051; Tue, 09 Dec 2025
 21:45:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251208153419.18196-1-minhquangbui99@gmail.com>
 <CACGkMEvtKVeoTMrGG0gZOrNKY=m-DGChVcM0TYcqx6-Ap+FY8w@mail.gmail.com> <66d9f44c-295e-4b62-86ae-a0aff5f062bb@gmail.com>
In-Reply-To: <66d9f44c-295e-4b62-86ae-a0aff5f062bb@gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 10 Dec 2025 13:45:19 +0800
X-Gm-Features: AQt7F2rVVyUHdSbcdKdzi21zc9e3z98C7ZeLVe5qQ4lJ-Awfq6TRhCbVeKZ8w04
Message-ID: <CACGkMEuF0rNYcSSUCdAgsW2Xfen9NGZHNxXpkO2Mt0a4zQJDqQ@mail.gmail.com>
Subject: Re: [PATCH net] virtio-net: enable all napis before scheduling refill work
To: Bui Quang Minh <minhquangbui99@gmail.com>
Cc: netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 5GrJdwrKRrkSzevgJGtC6JeUdXaX-k1WONSVflUyFig_1765345532
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 9, 2025 at 11:23=E2=80=AFPM Bui Quang Minh <minhquangbui99@gmai=
l.com> wrote:
>
> On 12/9/25 11:30, Jason Wang wrote:
> > On Mon, Dec 8, 2025 at 11:35=E2=80=AFPM Bui Quang Minh <minhquangbui99@=
gmail.com> wrote:
> >> Calling napi_disable() on an already disabled napi can cause the
> >> deadlock. In commit 4bc12818b363 ("virtio-net: disable delayed refill
> >> when pausing rx"), to avoid the deadlock, when pausing the RX in
> >> virtnet_rx_pause[_all](), we disable and cancel the delayed refill wor=
k.
> >> However, in the virtnet_rx_resume_all(), we enable the delayed refill
> >> work too early before enabling all the receive queue napis.
> >>
> >> The deadlock can be reproduced by running
> >> selftests/drivers/net/hw/xsk_reconfig.py with multiqueue virtio-net
> >> device and inserting a cond_resched() inside the for loop in
> >> virtnet_rx_resume_all() to increase the success rate. Because the work=
er
> >> processing the delayed refilled work runs on the same CPU as
> >> virtnet_rx_resume_all(), a reschedule is needed to cause the deadlock.
> >> In real scenario, the contention on netdev_lock can cause the
> >> reschedule.
> >>
> >> This fixes the deadlock by ensuring all receive queue's napis are
> >> enabled before we enable the delayed refill work in
> >> virtnet_rx_resume_all() and virtnet_open().
> >>
> >> Fixes: 4bc12818b363 ("virtio-net: disable delayed refill when pausing =
rx")
> >> Reported-by: Paolo Abeni <pabeni@redhat.com>
> >> Closes: https://netdev-ctrl.bots.linux.dev/logs/vmksft/drv-hw-dbg/resu=
lts/400961/3-xdp-py/stderr
> >> Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
> >> ---
> >>   drivers/net/virtio_net.c | 59 +++++++++++++++++++-------------------=
--
> >>   1 file changed, 28 insertions(+), 31 deletions(-)
> >>
> >> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> >> index 8e04adb57f52..f2b1ea65767d 100644
> >> --- a/drivers/net/virtio_net.c
> >> +++ b/drivers/net/virtio_net.c
> >> @@ -2858,6 +2858,20 @@ static bool try_fill_recv(struct virtnet_info *=
vi, struct receive_queue *rq,
> >>          return err !=3D -ENOMEM;
> >>   }
> >>
> >> +static void virtnet_rx_refill_all(struct virtnet_info *vi)
> >> +{
> >> +       bool schedule_refill =3D false;
> >> +       int i;
> >> +
> >> +       enable_delayed_refill(vi);
> > This seems to be still racy?
> >
> > For example, in virtnet_open() we had:
> >
> > static int virtnet_open(struct net_device *dev)
> > {
> >          struct virtnet_info *vi =3D netdev_priv(dev);
> >          int i, err;
> >
> >          for (i =3D 0; i < vi->max_queue_pairs; i++) {
> >                  err =3D virtnet_enable_queue_pair(vi, i);
> >                  if (err < 0)
> >                          goto err_enable_qp;
> >          }
> >
> >          virtnet_rx_refill_all(vi);
> >
> > So NAPI and refill work is enabled in this case, so the refill work
> > could be scheduled and run at the same time?
>
> Yes, that's what we expect. We must ensure that refill work is scheduled
> only when all NAPIs are enabled. The deadlock happens when refill work
> is scheduled but there are still disabled RX NAPIs.

Just to make sure we are on the same page, I meant, after refill work
is enabled, rq0 is NAPI is enabled, in this case the refill work could
be triggered by the rq0's NAPI so we may end up in the refill work
that it tries to disable rq1's NAPI while holding the netdev lock.

Thanks

>
> Thanks,
> Quang Minh.
>

