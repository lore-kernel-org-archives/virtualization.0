Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16C6138F94
	for <virtualization@lists.linux.dev>; Mon, 22 Jan 2024 08:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705912383; cv=none; b=MqGtcgXLzW/Wkdf0o5Zd007wBNHWbkzmAfbV3Uwbeoj2yedx0M7JXhvHf2+SU3ci/RS0XKDu6KUsd6rFmz70FL5AM1EzCEkf+eKqL9zZ1SXA09H5bZSrn2Sc95PWtWqck7kzzA5yvhAOPk7aIU4/MWaqMdfG+0J2LLObfqJqy2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705912383; c=relaxed/simple;
	bh=ezgmB3Kw8Sv6XHFM7YGBgEcB1VIaa+huQyqGILJKEHI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oJU0qjSAIKRmowtIa2xOKt1AEFVymgrwfo6KqkR9ENTAw8pxlNvDYXUQIoY9iLuRw7NFT+8vd+izHzz1+Q9w8Tnof5H4nQps9jS7VlgjbZQOvSVPS5c0B+py44VYqDYUFwAb7Bxjsx8SWSi4LTRE4CXBI8sGBj2BH9QoLhrwnxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ap17QGvO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ap17QGvO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705912381;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OpRUyUVDJ5dic+JNhKzSDxIeJIk1xGlAm8tjhGDfHCk=;
	b=Ap17QGvOT4Q2SWWJoZ+XGN0cyfZCajzjUk600u85E5jEDW6OT1cY52NOm7uwqv/HwQUjUP
	w/Naj6iSgNCirumopPvbOGXB4ieCQYrnpABPNiHEK1bYkNkLCL68NoMLMQjgfkP7457zBe
	9IkL5LdflXMR/vYBiMF6qvoQD+qTDaM=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-308-j17DKkloN4u2qGlI9H7eMA-1; Mon, 22 Jan 2024 03:32:59 -0500
X-MC-Unique: j17DKkloN4u2qGlI9H7eMA-1
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-6da57e2d2b9so2098387b3a.2
        for <virtualization@lists.linux.dev>; Mon, 22 Jan 2024 00:32:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705912378; x=1706517178;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OpRUyUVDJ5dic+JNhKzSDxIeJIk1xGlAm8tjhGDfHCk=;
        b=RC/YP07dIa6Q7Jx5ylXCe60xX3cg1aonFQcFS7RAsBApfSwITj67DQAph7/VrwyWUL
         7/+U0n66UTVzxTYruPxBWxjqD0GSlSBbyC/zbv6zAbC1oz1+csBl/4UEDdPzmcMk2iU6
         517RUVpYaY5UnoabUTkpZEATCWKsob585WfBroCVt5ZIhmW7g6GZwbBbPqYQG3sFuWcM
         1a5YVfVZW/Q60aE4HFrkqeS/N5O10eKXSjESnSMwbi261dzyKO7GWcMSi005QRKCR4NA
         tUp9t0rCGp17OoFzgbz0xG6Qgws6W/JUxJfOYu0p2I91Sh+pJYMy6IKNWTCtRVnhmMX1
         h3/Q==
X-Gm-Message-State: AOJu0YwYwE7QxX8c1EAl7t7/w19C/QwMWjcCXmYkomTttspKlDTmcZjp
	ZeF39b1xBOOd1fuBDV5Jjhu+IBZBbB/RqvJwZ7OZ30gk0k5VwPNG11L43qmckl8UxFjUMNONtSG
	CR20AvN5//c/ssUBakygp561k+SEmsluOukyBp1HAgRyTPcOuXwA49btjrk+GBzN3HnOvmVtPip
	7MrvNl9qO48UimpUieVXilLbY23OkTBwCchefM4ck=
X-Received: by 2002:a05:6a00:3926:b0:6db:cd50:a552 with SMTP id fh38-20020a056a00392600b006dbcd50a552mr1658444pfb.12.1705912378342;
        Mon, 22 Jan 2024 00:32:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF9msMMwh2NuFbsPztXL+DTYyH/OUqr9qyteHptAuvixmpZef7LIWI8LBp75aJCB0gj8QbzG35GrgIf+Y40zrk=
X-Received: by 2002:a05:6a00:3926:b0:6db:cd50:a552 with SMTP id
 fh38-20020a056a00392600b006dbcd50a552mr1658440pfb.12.1705912378049; Mon, 22
 Jan 2024 00:32:58 -0800 (PST)
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
 <CACGkMEt4zyESemjPwZtD5d4d00jtorY0qR5vM9y96NZzKkdj8A@mail.gmail.com>
 <1705906930.2143333-5-xuanzhuo@linux.alibaba.com> <CACGkMEuO2wO-kwMWdR9hFSCJwLUN5jwKxCCaAmxJOB8sm5bfoA@mail.gmail.com>
 <1705908305.1535513-7-xuanzhuo@linux.alibaba.com> <CACGkMEvRQfSN0S0r4nXNHS1A2LzjhSfL4-1bFrYx4y0yM9yOag@mail.gmail.com>
 <1705910488.8207285-9-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1705910488.8207285-9-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 22 Jan 2024 16:32:46 +0800
Message-ID: <CACGkMEu5bO_TeBuKGv0gyaUCnq=euq81y9xJ-MK=VBoCxhVe-Q@mail.gmail.com>
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

On Mon, Jan 22, 2024 at 4:04=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> On Mon, 22 Jan 2024 15:57:08 +0800, Jason Wang <jasowang@redhat.com> wrot=
e:
> > On Mon, Jan 22, 2024 at 3:36=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.aliba=
ba.com> wrote:
> > >
> > > On Mon, 22 Jan 2024 15:19:12 +0800, Jason Wang <jasowang@redhat.com> =
wrote:
> > > > On Mon, Jan 22, 2024 at 3:07=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.a=
libaba.com> wrote:
> > > > >
> > > > > On Mon, 22 Jan 2024 14:58:09 +0800, Jason Wang <jasowang@redhat.c=
om> wrote:
> > > > > > On Mon, Jan 22, 2024 at 2:55=E2=80=AFPM Jason Wang <jasowang@re=
dhat.com> wrote:
> > > > > > >
> > > > > > > On Mon, Jan 22, 2024 at 2:20=E2=80=AFPM Xuan Zhuo <xuanzhuo@l=
inux.alibaba.com> wrote:
> > > > > > > >
> > > > > > > > On Mon, 22 Jan 2024 12:16:27 +0800, Jason Wang <jasowang@re=
dhat.com> wrote:
> > > > > > > > > On Mon, Jan 22, 2024 at 12:00=E2=80=AFPM Xuan Zhuo <xuanz=
huo@linux.alibaba.com> wrote:
> > > > > > > > > >
> > > > > > > > > > On Mon, 22 Jan 2024 11:14:30 +0800, Jason Wang <jasowan=
g@redhat.com> wrote:
> > > > > > > > > > > On Mon, Jan 22, 2024 at 10:12=E2=80=AFAM Zhu Yanjun <=
yanjun.zhu@linux.dev> wrote:
> > > > > > > > > > > >
> > > > > > > > > > > >
> > > > > > > > > > > > =E5=9C=A8 2024/1/20 1:29, Andrew Lunn =E5=86=99=E9=
=81=93:
> > > > > > > > > > > > >>>>>        while (!virtqueue_get_buf(vi->cvq, &tm=
p) &&
> > > > > > > > > > > > >>>>> -           !virtqueue_is_broken(vi->cvq))
> > > > > > > > > > > > >>>>> +           !virtqueue_is_broken(vi->cvq)) {
> > > > > > > > > > > > >>>>> +        if (timeout)
> > > > > > > > > > > > >>>>> +            timeout--;
> > > > > > > > > > > > >>>> This is not really a timeout, just a loop coun=
ter. 200 iterations could
> > > > > > > > > > > > >>>> be a very short time on reasonable H/W. I gues=
s this avoid the soft
> > > > > > > > > > > > >>>> lockup, but possibly (likely?) breaks the func=
tionality when we need to
> > > > > > > > > > > > >>>> loop for some non negligible time.
> > > > > > > > > > > > >>>>
> > > > > > > > > > > > >>>> I fear we need a more complex solution, as men=
tioned by Micheal in the
> > > > > > > > > > > > >>>> thread you quoted.
> > > > > > > > > > > > >>> Got it. I also look forward to the more complex=
 solution to this problem.
> > > > > > > > > > > > >> Can we add a device capability (new feature bit)=
 such as ctrq_wait_timeout
> > > > > > > > > > > > >> to get a reasonable timeout=EF=BC=9F
> > > > > > > > > > > > > The usual solution to this is include/linux/iopol=
l.h. If you can sleep
> > > > > > > > > > > > > read_poll_timeout() otherwise read_poll_timeout_a=
tomic().
> > > > > > > > > > > >
> > > > > > > > > > > > I read carefully the functions read_poll_timeout() =
and
> > > > > > > > > > > > read_poll_timeout_atomic(). The timeout is set by t=
he caller of the 2
> > > > > > > > > > > > functions.
> > > > > > > > > > >
> > > > > > > > > > > FYI, in order to avoid a swtich of atomic or not, we =
need convert rx
> > > > > > > > > > > mode setting to workqueue first:
> > > > > > > > > > >
> > > > > > > > > > > https://www.mail-archive.com/virtualization@lists.lin=
ux-foundation.org/msg60298.html
> > > > > > > > > > >
> > > > > > > > > > > >
> > > > > > > > > > > > As such, can we add a module parameter to customize=
 this timeout value
> > > > > > > > > > > > by the user?
> > > > > > > > > > >
> > > > > > > > > > > Who is the "user" here, or how can the "user" know th=
e value?
> > > > > > > > > > >
> > > > > > > > > > > >
> > > > > > > > > > > > Or this timeout value is stored in device register,=
 virtio_net driver
> > > > > > > > > > > > will read this timeout value at initialization?
> > > > > > > > > > >
> > > > > > > > > > > See another thread. The design needs to be general, o=
r you can post a RFC.
> > > > > > > > > > >
> > > > > > > > > > > In another thought, we've already had a tx watchdog, =
maybe we can have
> > > > > > > > > > > something similar to cvq and use timeout + reset in t=
hat case.
> > > > > > > > > >
> > > > > > > > > > But we may block by the reset ^_^ if the device is brok=
en?
> > > > > > > > >
> > > > > > > > > I mean vq reset here.
> > > > > > > >
> > > > > > > > I see.
> > > > > > > >
> > > > > > > > I mean when the deivce is broken, the vq reset also many be=
 blocked.
> > > > > > > >
> > > > > > > >         void vp_modern_set_queue_reset(struct virtio_pci_mo=
dern_device *mdev, u16 index)
> > > > > > > >         {
> > > > > > > >                 struct virtio_pci_modern_common_cfg __iomem=
 *cfg;
> > > > > > > >
> > > > > > > >                 cfg =3D (struct virtio_pci_modern_common_cf=
g __iomem *)mdev->common;
> > > > > > > >
> > > > > > > >                 vp_iowrite16(index, &cfg->cfg.queue_select)=
;
> > > > > > > >                 vp_iowrite16(1, &cfg->queue_reset);
> > > > > > > >
> > > > > > > >                 while (vp_ioread16(&cfg->queue_reset))
> > > > > > > >                         msleep(1);
> > > > > > > >
> > > > > > > >                 while (vp_ioread16(&cfg->cfg.queue_enable))
> > > > > > > >                         msleep(1);
> > > > > > > >         }
> > > > > > > >         EXPORT_SYMBOL_GPL(vp_modern_set_queue_reset);
> > > > > > > >
> > > > > > > > In this function, for the broken device, we can not expect =
something.
> > > > > > >
> > > > > > > Yes, it's best effort, there's no guarantee then. But it does=
n't harm to try.
> > > > > > >
> > > > > > > Thanks
> > > > > > >
> > > > > > > >
> > > > > > > >
> > > > > > > > >
> > > > > > > > > It looks like we have multiple goals here
> > > > > > > > >
> > > > > > > > > 1) avoid lockups, using workqueue + cond_resched() seems =
to be
> > > > > > > > > sufficient, it has issue but nothing new
> > > > > > > > > 2) recover from the unresponsive device, the issue for ti=
meout is that
> > > > > > > > > it needs to deal with false positives
> > > > > > > >
> > > > > > > >
> > > > > > > > I agree.
> > > > > > > >
> > > > > > > > But I want to add a new goal, cvq async. In the netdim, we =
will
> > > > > > > > send many requests via the cvq, so the cvq async will be ni=
ce.
> > > > > >
> > > > > > Then you need an interrupt for cvq.
> > > > > >
> > > > > > FYI, I've posted a series that use interrupt for cvq in the pas=
t:
> > > > > >
> > > > > > https://lore.kernel.org/lkml/6026e801-6fda-fee9-a69b-d06a803686=
21@redhat.com/t/
> > > > >
> > > > > I know this. But the interrupt maybe not a good solution without =
new space.
> > > >
> > > > What do you mean by "new space"?
> > >
> > > Yes, I know, the cvq can work with interrupt by the virtio spec.
> > > But as I know, many hypervisors implement the cvq without supporting =
interrupt.
> >
> > It's a bug of the hypervisor that needs to be fix. Interrupt is
> > provided by transport not the virtio itself.
>
> YES. I agree.
>
> But I still think we should not work with interrupt without any negotiati=
on
> directly. I more like to introduce a new feature to enable this.

I can hardly believe we need to workaround the issue of specific
hypervisors like this...

Thanks

>
> Thanks.
>
>

