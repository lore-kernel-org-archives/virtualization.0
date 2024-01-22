Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92C9CE56E
	for <virtualization@lists.linux.dev>; Mon, 22 Jan 2024 07:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705907970; cv=none; b=QG91is3McS1VOA7rcAzuXfrU2uDDRYxpb0+Mjo96LT0QGOSeJ78RLlWLqVXaZp/2UU7x9J5SpeGfDIrT3GRNBIkaVRfrsCMJGYXs7wty2frH0S0yfEb2bpsVLSTUReQjKdppQ3jRUMx3I11x4FGvFccy2Mt6A+4blZ7r1oAOeHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705907970; c=relaxed/simple;
	bh=al8Z0snfFUiE2CtMOwfSLFqI9uQogODjngo0Bj2dZ5U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CPt2YWu2FR3RDmGwJ7U3hahVyyMvlfj4UAeM3/yJ3XJXagVG1RWjlVLxkpOQ5AUg9u8d0Rf90Z7zbR4Sgfp/EkoWAUMNgbVEzZ+qA5aPPBpglQljarH4EoWtvM4NbALi+FdxIxYO6TWA2m6ZTDQAmQZJBcDjxiT0/PMhUdcLAt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Izh+1fkY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Izh+1fkY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705907967;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+wZ6o9ICc7+p+UUTBehje0LLy3KJFhcw7o+CvdVHGfg=;
	b=Izh+1fkYdKdVLNCVhhJ+Jc9rmgxB56QX93iWeOJzKC8akGQzaq+b3XP1LF78JL8vEC0oLp
	5vxpl3fusuMZ+VtnUbMITWVc1H7bnA5jNOQeJhM64JrvvBOp7tEEosFR96X0hK0sis3TDl
	e9VAzfLwl9xIO2Y+QeGeEArjZiLZ0Dg=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-203-pFnzeIYePni104_xC2kpig-1; Mon, 22 Jan 2024 02:19:25 -0500
X-MC-Unique: pFnzeIYePni104_xC2kpig-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-290587143d8so2017010a91.0
        for <virtualization@lists.linux.dev>; Sun, 21 Jan 2024 23:19:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705907964; x=1706512764;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+wZ6o9ICc7+p+UUTBehje0LLy3KJFhcw7o+CvdVHGfg=;
        b=Zs4rEuvNg6nYJTyvjKdxvR3tvWjD87V+JK9yy049uEkDYUbNsY+ji8EJpyFqRD69t4
         +zxpc0xzMrukl4OiaQGEo12n6k0l82tusqLETulOxqiXy3fzzzY3MUlJnchbDr77tKzN
         96VmvpDyfSk1xnSvhSqK3lGbdcwWVYzEl4RJrQAN13wXCK5me7XMFk2o9BvgbZunhfbY
         fZXnQzX/CAHQYgKVyGVY2SZebA0FlZSxgy6safz3OtxPCWg/Z4y/nxICWr4//09ADwwN
         WiEy8tB05082wyPWO98JJB3yzH8wV+rnkHLn5/c2BTGRZlNqZ/3o46xuhZr5eFNLunLA
         +LjA==
X-Gm-Message-State: AOJu0Yx8kdvFDSYWxwrN6L/G2Tlg0iQaBn1gWaS0g44lY/aQa++ZRMdi
	ENAqLlDM8wuabhO2V1dsCrgPC/rCP9/KDOOp1QnFYdlyBWQgdU2sReT+doNNwefZZ15Q4txsYV4
	KS8dGUorRqOwY+yGZFTB6x44jlz+EPwRDuDoDac2ishW/YZFNVaMkTaW00g/VPbvdDutG1GwcZS
	FbPv2+pfx99KXbf9mopF0JsOLfjfPIon8KlWiiSEw=
X-Received: by 2002:a17:90a:f3ca:b0:28e:878f:9b35 with SMTP id ha10-20020a17090af3ca00b0028e878f9b35mr5887722pjb.34.1705907964270;
        Sun, 21 Jan 2024 23:19:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEY33kXfdehvBw3K/O/5OApm4tMYhTbP9uDN7Esz3dOH//JXZzt3vmhMJf2gTsoG3beGw7c32nI8K9uqwsxhj4=
X-Received: by 2002:a17:90a:f3ca:b0:28e:878f:9b35 with SMTP id
 ha10-20020a17090af3ca00b0028e878f9b35mr5887708pjb.34.1705907963953; Sun, 21
 Jan 2024 23:19:23 -0800 (PST)
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
 <1705904164.7020166-3-xuanzhuo@linux.alibaba.com> <CACGkMEsTT7hrm2QWZq-NasfVAJHsUoZq5hijvLE_jY+2YyKytg@mail.gmail.com>
 <CACGkMEt4zyESemjPwZtD5d4d00jtorY0qR5vM9y96NZzKkdj8A@mail.gmail.com> <1705906930.2143333-5-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1705906930.2143333-5-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 22 Jan 2024 15:19:12 +0800
Message-ID: <CACGkMEuO2wO-kwMWdR9hFSCJwLUN5jwKxCCaAmxJOB8sm5bfoA@mail.gmail.com>
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

On Mon, Jan 22, 2024 at 3:07=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> On Mon, 22 Jan 2024 14:58:09 +0800, Jason Wang <jasowang@redhat.com> wrot=
e:
> > On Mon, Jan 22, 2024 at 2:55=E2=80=AFPM Jason Wang <jasowang@redhat.com=
> wrote:
> > >
> > > On Mon, Jan 22, 2024 at 2:20=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.ali=
baba.com> wrote:
> > > >
> > > > On Mon, 22 Jan 2024 12:16:27 +0800, Jason Wang <jasowang@redhat.com=
> wrote:
> > > > > On Mon, Jan 22, 2024 at 12:00=E2=80=AFPM Xuan Zhuo <xuanzhuo@linu=
x.alibaba.com> wrote:
> > > > > >
> > > > > > On Mon, 22 Jan 2024 11:14:30 +0800, Jason Wang <jasowang@redhat=
.com> wrote:
> > > > > > > On Mon, Jan 22, 2024 at 10:12=E2=80=AFAM Zhu Yanjun <yanjun.z=
hu@linux.dev> wrote:
> > > > > > > >
> > > > > > > >
> > > > > > > > =E5=9C=A8 2024/1/20 1:29, Andrew Lunn =E5=86=99=E9=81=93:
> > > > > > > > >>>>>        while (!virtqueue_get_buf(vi->cvq, &tmp) &&
> > > > > > > > >>>>> -           !virtqueue_is_broken(vi->cvq))
> > > > > > > > >>>>> +           !virtqueue_is_broken(vi->cvq)) {
> > > > > > > > >>>>> +        if (timeout)
> > > > > > > > >>>>> +            timeout--;
> > > > > > > > >>>> This is not really a timeout, just a loop counter. 200=
 iterations could
> > > > > > > > >>>> be a very short time on reasonable H/W. I guess this a=
void the soft
> > > > > > > > >>>> lockup, but possibly (likely?) breaks the functionalit=
y when we need to
> > > > > > > > >>>> loop for some non negligible time.
> > > > > > > > >>>>
> > > > > > > > >>>> I fear we need a more complex solution, as mentioned b=
y Micheal in the
> > > > > > > > >>>> thread you quoted.
> > > > > > > > >>> Got it. I also look forward to the more complex solutio=
n to this problem.
> > > > > > > > >> Can we add a device capability (new feature bit) such as=
 ctrq_wait_timeout
> > > > > > > > >> to get a reasonable timeout=EF=BC=9F
> > > > > > > > > The usual solution to this is include/linux/iopoll.h. If =
you can sleep
> > > > > > > > > read_poll_timeout() otherwise read_poll_timeout_atomic().
> > > > > > > >
> > > > > > > > I read carefully the functions read_poll_timeout() and
> > > > > > > > read_poll_timeout_atomic(). The timeout is set by the calle=
r of the 2
> > > > > > > > functions.
> > > > > > >
> > > > > > > FYI, in order to avoid a swtich of atomic or not, we need con=
vert rx
> > > > > > > mode setting to workqueue first:
> > > > > > >
> > > > > > > https://www.mail-archive.com/virtualization@lists.linux-found=
ation.org/msg60298.html
> > > > > > >
> > > > > > > >
> > > > > > > > As such, can we add a module parameter to customize this ti=
meout value
> > > > > > > > by the user?
> > > > > > >
> > > > > > > Who is the "user" here, or how can the "user" know the value?
> > > > > > >
> > > > > > > >
> > > > > > > > Or this timeout value is stored in device register, virtio_=
net driver
> > > > > > > > will read this timeout value at initialization?
> > > > > > >
> > > > > > > See another thread. The design needs to be general, or you ca=
n post a RFC.
> > > > > > >
> > > > > > > In another thought, we've already had a tx watchdog, maybe we=
 can have
> > > > > > > something similar to cvq and use timeout + reset in that case=
.
> > > > > >
> > > > > > But we may block by the reset ^_^ if the device is broken?
> > > > >
> > > > > I mean vq reset here.
> > > >
> > > > I see.
> > > >
> > > > I mean when the deivce is broken, the vq reset also many be blocked=
.
> > > >
> > > >         void vp_modern_set_queue_reset(struct virtio_pci_modern_dev=
ice *mdev, u16 index)
> > > >         {
> > > >                 struct virtio_pci_modern_common_cfg __iomem *cfg;
> > > >
> > > >                 cfg =3D (struct virtio_pci_modern_common_cfg __iome=
m *)mdev->common;
> > > >
> > > >                 vp_iowrite16(index, &cfg->cfg.queue_select);
> > > >                 vp_iowrite16(1, &cfg->queue_reset);
> > > >
> > > >                 while (vp_ioread16(&cfg->queue_reset))
> > > >                         msleep(1);
> > > >
> > > >                 while (vp_ioread16(&cfg->cfg.queue_enable))
> > > >                         msleep(1);
> > > >         }
> > > >         EXPORT_SYMBOL_GPL(vp_modern_set_queue_reset);
> > > >
> > > > In this function, for the broken device, we can not expect somethin=
g.
> > >
> > > Yes, it's best effort, there's no guarantee then. But it doesn't harm=
 to try.
> > >
> > > Thanks
> > >
> > > >
> > > >
> > > > >
> > > > > It looks like we have multiple goals here
> > > > >
> > > > > 1) avoid lockups, using workqueue + cond_resched() seems to be
> > > > > sufficient, it has issue but nothing new
> > > > > 2) recover from the unresponsive device, the issue for timeout is=
 that
> > > > > it needs to deal with false positives
> > > >
> > > >
> > > > I agree.
> > > >
> > > > But I want to add a new goal, cvq async. In the netdim, we will
> > > > send many requests via the cvq, so the cvq async will be nice.
> >
> > Then you need an interrupt for cvq.
> >
> > FYI, I've posted a series that use interrupt for cvq in the past:
> >
> > https://lore.kernel.org/lkml/6026e801-6fda-fee9-a69b-d06a80368621@redha=
t.com/t/
>
> I know this. But the interrupt maybe not a good solution without new spac=
e.

What do you mean by "new space"?

We can introduce something like enable_cb_delayed(), then you will
only get notified after several requests.

>
> >
> > Haven't found time in working on this anymore, maybe we can start from
> > this or not.
>
>
> I said async, but my aim is to put many requests to the cvq before gettin=
g the
> response.

It doesn't differ from TX/RX in this case.

>
> Heng Qi posted this https://lore.kernel.org/all/1705410693-118895-4-git-s=
end-email-hengqi@linux.alibaba.com/
>

This seems like a hack, if interrupt is used, you can simply do that
in the callback.

Thanks

> Thanks.
>
>
> >
> > Thanks
> >
> > > >
> > > > Thanks.
> > > >
> > > >
> > > > >
> > > > > Thanks
> > > > >
> > > > > >
> > > > > > Thanks.
> > > > > >
> > > > > >
> > > > > > >
> > > > > > > Thans
> > > > > > >
> > > > > > > >
> > > > > > > > Zhu Yanjun
> > > > > > > >
> > > > > > > > >
> > > > > > > > >       Andrew
> > > > > > > >
> > > > > > >
> > > > > >
> > > > >
> > > >
> >
>

