Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7913F9DE
	for <virtualization@lists.linux.dev>; Mon, 22 Jan 2024 06:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705906565; cv=none; b=Dl/pQ5QzNMyVjY8xHZ9NOm6zyUiCWyjfZ40EpcIH50qctiz9c6K43tMfTyQdAqTG+6dmXFQpSE7571mWgeCWU5IE2DGHihCWGJk5M8NyjPoRWdfSmus4A5PibzNiu8r0/0k/7wlcylrmeqLRqkzgFoIUrRr5BS23f192hXrKE6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705906565; c=relaxed/simple;
	bh=yHGw2+v8p9VMvpwklHnBGyUJGqFxCS4szDR8xKpZYxA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X7lXbf+Hp2ev+vgXa9+2d/0vUcpQeJkQePs9ObDOj04dkZxxFb0wLKlq7rEXvLgO+Saw9bUtLA2btiZd/L7BBZ5nD4Sbv0iFvLee/SqCd8MiRtA6q6YIzzoaqkENSIRirhSN/+YLKGSpXod6PI7jej21QCjGBPPZTroT+tLL22o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YXBNLCu/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YXBNLCu/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705906562;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mtLnLy8EYyovFLNBqJ/6kUkUH1TTl9B7z931Cm9/Gc4=;
	b=YXBNLCu/zxB0q248Br7UNVnTVxG4VPURmA3i90uMIk2JfV8PTY+nVQ+ggKg8myJHd/V+4P
	qE7LkV6EZ48x7e5Qj64blIxwulG0eiUeNFGeaecZ/FliC2skg8zdGFHBm9N/OO3vGIRlTk
	NA+5rirffyU2LYyw7yg00DPTSh3CXtk=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-134-XeUfDj0NNe6BldHw1dx29Q-1; Mon, 22 Jan 2024 01:56:00 -0500
X-MC-Unique: XeUfDj0NNe6BldHw1dx29Q-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-28bbe965866so1530182a91.3
        for <virtualization@lists.linux.dev>; Sun, 21 Jan 2024 22:56:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705906559; x=1706511359;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mtLnLy8EYyovFLNBqJ/6kUkUH1TTl9B7z931Cm9/Gc4=;
        b=F4i5rWemv3JWxUZnPvzyJuPz2x3FsRowTdm5w8Ow4tSD3Wlmu60L17OigXrPxvcKbv
         KgYPDlQQhwh/3jGTiN1lukLz6I6ZO8ZHLp7/i1tf85w0fCOQcnGaP7N6aPQ1evBuKKJL
         vqkRotV7AB97F995iNHBApIzD8kOnV3OYyHcTN/hCuHT0vGAhmUoou1mM6P2xmmJ1aP5
         szc3B+joeoq6EDd0w7nEThUw333bT2Pq+TMBnFQ8u/ylTnhvu7seEBEeCisUlA/fDNSR
         gGXZwMADq6oQ8SG7B4fIPsQdX9eZLrSuNpGVw2xJDoRKv9FFfYGoClFqfAVYcP2vgV3+
         BKJQ==
X-Gm-Message-State: AOJu0Yyf4l5G+JZp0kI6oCgrI9Ojuc3p39SNMav3sE9J4k5XFU/Sfl6Z
	kRgj+Y0+sWNTjcEV2WlSIMnC+Jok2qWffZyvoZUt96vCQsrtqeb578O1bsA4ZyDq9KOv1QirNpB
	7r+RKxCQx/8OUaZ0BFUdSmlcOaxzi+uK7HO+mJ1S2KsvAM2kV5vMWkW3EtxYm5VF+pW6ViYEoW2
	g9D5Cy1mpGMxqEIobjkilLI7wkN4DPplUwIRDfu0w=
X-Received: by 2002:a17:90b:216:b0:290:2921:6bcc with SMTP id fy22-20020a17090b021600b0029029216bccmr940835pjb.74.1705906559560;
        Sun, 21 Jan 2024 22:55:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGu/tVICQ8Ja2Q+KITwjBCNBxyB+AjfEL4OA7NNG2AX136AjQZQlG5ehwfcxnyGKkxhDRcneCXb42vg0bmJrow=
X-Received: by 2002:a17:90b:216:b0:290:2921:6bcc with SMTP id
 fy22-20020a17090b021600b0029029216bccmr940825pjb.74.1705906559293; Sun, 21
 Jan 2024 22:55:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240115012918.3081203-1-yanjun.zhu@intel.com>
 <ea230712e27af2c8d2d77d1087e45ecfa86abb31.camel@redhat.com>
 <667a9520-a53f-40a2-810a-6c1e45146589@linux.dev> <7dd89fc0-f31e-4f83-9c02-58ee67c2d436@linux.alibaba.com>
 <430b899c-aed4-419d-8ae8-544bb9bec5d9@lunn.ch> <64270652-8e0c-4db7-b245-b970d9588918@linux.dev>
 <CACGkMEs18hjxiZRDT5-+PMDHkLbEyiviafGiCWsAE6CGBrj+9g@mail.gmail.com>
 <1705895881.6990144-1-xuanzhuo@linux.alibaba.com> <CACGkMEvvn76w+BZArOWK-c1gsqNNx6bH8HPoqPAqpJG_7EYntA@mail.gmail.com>
 <1705904164.7020166-3-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1705904164.7020166-3-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 22 Jan 2024 14:55:46 +0800
Message-ID: <CACGkMEsTT7hrm2QWZq-NasfVAJHsUoZq5hijvLE_jY+2YyKytg@mail.gmail.com>
Subject: Re: [PATCH 1/1] virtio_net: Add timeout handler to avoid kernel hang
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heng Qi <hengqi@linux.alibaba.com>, 
	Paolo Abeni <pabeni@redhat.com>, Zhu Yanjun <yanjun.zhu@intel.com>, mst@redhat.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	Zhu Yanjun <yanjun.zhu@linux.dev>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 22, 2024 at 2:20=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> On Mon, 22 Jan 2024 12:16:27 +0800, Jason Wang <jasowang@redhat.com> wrot=
e:
> > On Mon, Jan 22, 2024 at 12:00=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alib=
aba.com> wrote:
> > >
> > > On Mon, 22 Jan 2024 11:14:30 +0800, Jason Wang <jasowang@redhat.com> =
wrote:
> > > > On Mon, Jan 22, 2024 at 10:12=E2=80=AFAM Zhu Yanjun <yanjun.zhu@lin=
ux.dev> wrote:
> > > > >
> > > > >
> > > > > =E5=9C=A8 2024/1/20 1:29, Andrew Lunn =E5=86=99=E9=81=93:
> > > > > >>>>>        while (!virtqueue_get_buf(vi->cvq, &tmp) &&
> > > > > >>>>> -           !virtqueue_is_broken(vi->cvq))
> > > > > >>>>> +           !virtqueue_is_broken(vi->cvq)) {
> > > > > >>>>> +        if (timeout)
> > > > > >>>>> +            timeout--;
> > > > > >>>> This is not really a timeout, just a loop counter. 200 itera=
tions could
> > > > > >>>> be a very short time on reasonable H/W. I guess this avoid t=
he soft
> > > > > >>>> lockup, but possibly (likely?) breaks the functionality when=
 we need to
> > > > > >>>> loop for some non negligible time.
> > > > > >>>>
> > > > > >>>> I fear we need a more complex solution, as mentioned by Mich=
eal in the
> > > > > >>>> thread you quoted.
> > > > > >>> Got it. I also look forward to the more complex solution to t=
his problem.
> > > > > >> Can we add a device capability (new feature bit) such as ctrq_=
wait_timeout
> > > > > >> to get a reasonable timeout=EF=BC=9F
> > > > > > The usual solution to this is include/linux/iopoll.h. If you ca=
n sleep
> > > > > > read_poll_timeout() otherwise read_poll_timeout_atomic().
> > > > >
> > > > > I read carefully the functions read_poll_timeout() and
> > > > > read_poll_timeout_atomic(). The timeout is set by the caller of t=
he 2
> > > > > functions.
> > > >
> > > > FYI, in order to avoid a swtich of atomic or not, we need convert r=
x
> > > > mode setting to workqueue first:
> > > >
> > > > https://www.mail-archive.com/virtualization@lists.linux-foundation.=
org/msg60298.html
> > > >
> > > > >
> > > > > As such, can we add a module parameter to customize this timeout =
value
> > > > > by the user?
> > > >
> > > > Who is the "user" here, or how can the "user" know the value?
> > > >
> > > > >
> > > > > Or this timeout value is stored in device register, virtio_net dr=
iver
> > > > > will read this timeout value at initialization?
> > > >
> > > > See another thread. The design needs to be general, or you can post=
 a RFC.
> > > >
> > > > In another thought, we've already had a tx watchdog, maybe we can h=
ave
> > > > something similar to cvq and use timeout + reset in that case.
> > >
> > > But we may block by the reset ^_^ if the device is broken?
> >
> > I mean vq reset here.
>
> I see.
>
> I mean when the deivce is broken, the vq reset also many be blocked.
>
>         void vp_modern_set_queue_reset(struct virtio_pci_modern_device *m=
dev, u16 index)
>         {
>                 struct virtio_pci_modern_common_cfg __iomem *cfg;
>
>                 cfg =3D (struct virtio_pci_modern_common_cfg __iomem *)md=
ev->common;
>
>                 vp_iowrite16(index, &cfg->cfg.queue_select);
>                 vp_iowrite16(1, &cfg->queue_reset);
>
>                 while (vp_ioread16(&cfg->queue_reset))
>                         msleep(1);
>
>                 while (vp_ioread16(&cfg->cfg.queue_enable))
>                         msleep(1);
>         }
>         EXPORT_SYMBOL_GPL(vp_modern_set_queue_reset);
>
> In this function, for the broken device, we can not expect something.

Yes, it's best effort, there's no guarantee then. But it doesn't harm to tr=
y.

Thanks

>
>
> >
> > It looks like we have multiple goals here
> >
> > 1) avoid lockups, using workqueue + cond_resched() seems to be
> > sufficient, it has issue but nothing new
> > 2) recover from the unresponsive device, the issue for timeout is that
> > it needs to deal with false positives
>
>
> I agree.
>
> But I want to add a new goal, cvq async. In the netdim, we will
> send many requests via the cvq, so the cvq async will be nice.
>
> Thanks.
>
>
> >
> > Thanks
> >
> > >
> > > Thanks.
> > >
> > >
> > > >
> > > > Thans
> > > >
> > > > >
> > > > > Zhu Yanjun
> > > > >
> > > > > >
> > > > > >       Andrew
> > > > >
> > > >
> > >
> >
>

