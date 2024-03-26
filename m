Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC5B1292FD
	for <virtualization@lists.linux.dev>; Tue, 26 Mar 2024 04:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711426113; cv=none; b=AJC60IIXE9AoKaqG7wMsAGdPTJSIAtMW3HYcnWn18ymWyihHsMK/Hy19yDqxXnGzwcfkATkQegMUA5m47VaJVZgg/HH5sq8SBa5HQbDvcdSWGSTR2ee7Q66Bn7eBjot40abB7SYXy7Bk91vn5G5GHP9m4L+P8czC1PowZmSQ2RQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711426113; c=relaxed/simple;
	bh=StPWDnlpYhi+VnvUUlAezhM3U+Iq/7qgaasIGyswI6c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l710WEtPvHT+hctGrHVOmJapvzk2+1F9xraIjoQLEj49rMHAGh6wGB10Z5X+9pbaflDNSSAuhqUZp8BwqJudYi6D+dXE4M8uAdFTRbPX1RSZd/bseBMTM1VOvp2DYFFWXo9NVmhIQKWFe5TA6RyE7kiZSxGYYv5TauPIez0iimc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dvEFtq6L; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dvEFtq6L"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711426110;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=StPWDnlpYhi+VnvUUlAezhM3U+Iq/7qgaasIGyswI6c=;
	b=dvEFtq6LGcYH777sjNhiGmyZzVc9zHI/qiCs/BLa76JoXq8flx8DebQPv3D+0v6SfgOPGZ
	uMuXzdQGsUbj79qiHPorLpBDEWGhJ5aI3aLV2aiWKozWddqp0cvGba2ADVsJ4LlTpDxabW
	gErEgIfc9DonIMZFm16TLi5jezF/u6k=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-133-wKH1wYkEO_KxamaAznQKBw-1; Tue, 26 Mar 2024 00:08:28 -0400
X-MC-Unique: wKH1wYkEO_KxamaAznQKBw-1
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-6e6fd225b40so4521150b3a.1
        for <virtualization@lists.linux.dev>; Mon, 25 Mar 2024 21:08:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711426108; x=1712030908;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=StPWDnlpYhi+VnvUUlAezhM3U+Iq/7qgaasIGyswI6c=;
        b=EhWSxJBQyx2WzR3vCmvaaIf5h7qOghbzoXJrTeZMXT0STfyCvMjwA/V+6+aHV9Perp
         zEpOw4dVoH2nl5mUPJKNgBPxIIs8uh+WOECMO+ul62hsB3d2pazQ9ynCflaPv0MD1KHp
         Mr68NjaNqOUogByjPwsI9iUUX78l5syyarOxKdbBCrEKX1QyimhIQNiJBh5EqUfPN94+
         OK/ez4dmv5rZ/g3u4RLMHrZzrfiuRFH72tadKUTyfHUaBcwEv2+gyl0oRaGJGi5O5GlA
         re3iWJL+JT6WbzqhW9uWKnK4LTY1oKXZBYCwGfeP0TH3urnR6L8R86V1huMHBnaBnwt6
         Z/Gg==
X-Forwarded-Encrypted: i=1; AJvYcCXK1KMAsVWY2aRBcwIEkYSx1JAFPKFlCm3AUI7HgEMH9QXBlSHs/lHNzyD0pHCuER9hKDHsSTjH1xz1E/4cmtxt/lkratHmnnVhWfQfr9g=
X-Gm-Message-State: AOJu0YzomNZvm+EvZOddwU7la3NH7NDz0kr7daq8IpT99ZheYIfKsYzD
	DRSi3ZimdNCmyd9JuatDjsy1y/IaT1VsgeLTi2yQJIsRIt6K7tR3EKg8KO39S7EEo4QDnVnNjK3
	FbpCdVvImELbn9cT8HuJzYr6D/w88hUgcGhBRiXw+v4uyvRH+isJmMj8NLdkWCB7eQCAh6u9hBe
	xXapHV5d3wF9R4xGDqbrbdCnNV/T0XmcESaup4pZQ=
X-Received: by 2002:a05:6a20:2d21:b0:1a3:6a71:8282 with SMTP id g33-20020a056a202d2100b001a36a718282mr10074811pzl.0.1711426107683;
        Mon, 25 Mar 2024 21:08:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHBlkL9Z9LCjG2AzHQwehG3CJAeH4UJ5fo1nk/Ns/ww09oy/aF6P2JJr07fKJQmaIcaJvaaZgBdaQGRm8gMtj0=
X-Received: by 2002:a05:6a20:2d21:b0:1a3:6a71:8282 with SMTP id
 g33-20020a056a202d2100b001a36a718282mr10074794pzl.0.1711426107315; Mon, 25
 Mar 2024 21:08:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <1711021557-58116-1-git-send-email-hengqi@linux.alibaba.com>
 <1711021557-58116-3-git-send-email-hengqi@linux.alibaba.com>
 <CACGkMEuZ457UU6MhPtKHd_Y0VryvZoNU+uuKOc_4OK7jc62WwA@mail.gmail.com>
 <5708312a-d8eb-40ee-88a9-e16930b94dda@linux.alibaba.com> <CACGkMEu8or7+fw3+vX_PY3Qsrm7zVSf6TS9SiE20NpOsz-or6g@mail.gmail.com>
 <b54ad370-67bd-4b8c-82fb-54625e68288b@linux.alibaba.com> <CACGkMEv88U1_2K2b0KdmH97gfrdOvK_1ajqh=UTK6=KgZ4OYvQ@mail.gmail.com>
 <36ce2bbf-3a31-4c01-99f3-1875f79e2831@linux.alibaba.com> <CACGkMEvShZKd7AvMFtmEWBVGQsQrGkQMTEx8yQYYU0uYqp=uMg@mail.gmail.com>
 <62451c11-0957-4d1b-8a34-5e224ea552e0@linux.alibaba.com>
In-Reply-To: <62451c11-0957-4d1b-8a34-5e224ea552e0@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 26 Mar 2024 12:08:16 +0800
Message-ID: <CACGkMEsvsmyUaTD35kp=4qJhMdDYG=hGVbT0JGGTwGTb3XRuLg@mail.gmail.com>
Subject: Re: [PATCH 2/2] virtio-net: reduce the CPU consumption of dim worker
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Eric Dumazet <edumazet@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 26, 2024 at 10:46=E2=80=AFAM Heng Qi <hengqi@linux.alibaba.com>=
 wrote:
>
>
>
> =E5=9C=A8 2024/3/25 =E4=B8=8B=E5=8D=884:42, Jason Wang =E5=86=99=E9=81=93=
:
> > On Mon, Mar 25, 2024 at 4:22=E2=80=AFPM Heng Qi <hengqi@linux.alibaba.c=
om> wrote:
> >>
> >>
> >> =E5=9C=A8 2024/3/25 =E4=B8=8B=E5=8D=883:56, Jason Wang =E5=86=99=E9=81=
=93:
> >>> On Mon, Mar 25, 2024 at 3:18=E2=80=AFPM Heng Qi <hengqi@linux.alibaba=
.com> wrote:
> >>>>
> >>>> =E5=9C=A8 2024/3/25 =E4=B8=8B=E5=8D=881:57, Jason Wang =E5=86=99=E9=
=81=93:
> >>>>> On Mon, Mar 25, 2024 at 10:21=E2=80=AFAM Heng Qi <hengqi@linux.alib=
aba.com> wrote:
> >>>>>> =E5=9C=A8 2024/3/22 =E4=B8=8B=E5=8D=881:19, Jason Wang =E5=86=99=
=E9=81=93:
> >>>>>>> On Thu, Mar 21, 2024 at 7:46=E2=80=AFPM Heng Qi <hengqi@linux.ali=
baba.com> wrote:
> >>>>>>>> Currently, ctrlq processes commands in a synchronous manner,
> >>>>>>>> which increases the delay of dim commands when configuring
> >>>>>>>> multi-queue VMs, which in turn causes the CPU utilization to
> >>>>>>>> increase and interferes with the performance of dim.
> >>>>>>>>
> >>>>>>>> Therefore we asynchronously process ctlq's dim commands.
> >>>>>>>>
> >>>>>>>> Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
> >>>>>>> I may miss some previous discussions.
> >>>>>>>
> >>>>>>> But at least the changelog needs to explain why you don't use int=
errupt.
> >>>>>> Will add, but reply here first.
> >>>>>>
> >>>>>> When upgrading the driver's ctrlq to use interrupt, problems may o=
ccur
> >>>>>> with some existing devices.
> >>>>>> For example, when existing devices are replaced with new drivers, =
they
> >>>>>> may not work.
> >>>>>> Or, if the guest OS supported by the new device is replaced by an =
old
> >>>>>> downstream OS product, it will not be usable.
> >>>>>>
> >>>>>> Although, ctrlq has the same capabilities as IOq in the virtio spe=
c,
> >>>>>> this does have historical baggage.
> >>>>> I don't think the upstream Linux drivers need to workaround buggy
> >>>>> devices. Or it is a good excuse to block configure interrupts.
> >>>> Of course I agree. Our DPU devices support ctrlq irq natively, as lo=
ng
> >>>> as the guest os opens irq to ctrlq.
> >>>>
> >>>> If other products have no problem with this, I would prefer to use i=
rq
> >>>> to solve this problem, which is the most essential solution.
> >>> Let's do that.
> >> Ok, will do.
> >>
> >> Do you have the link to the patch where you previously modified the
> >> control queue for interrupt notifications.
> >> I think a new patch could be made on top of it, but I can't seem to fi=
nd it.
> > Something like this?
>
> YES. Thanks Jason.
>
> >
> > https://lore.kernel.org/lkml/6026e801-6fda-fee9-a69b-d06a80368621@redha=
t.com/t/
> >
> > Note that
> >
> > 1) some patch has been merged
> > 2) we probably need to drop the timeout logic as it's another topic
> > 3) need to address other comments
>
> I did a quick read of your patch sets from the previous 5 version:
> [1]
> https://lore.kernel.org/lkml/6026e801-6fda-fee9-a69b-d06a80368621@redhat.=
com/t/
> [2] https://lore.kernel.org/all/20221226074908.8154-1-jasowang@redhat.com=
/
> [3] https://lore.kernel.org/all/20230413064027.13267-1-jasowang@redhat.co=
m/
> [4] https://lore.kernel.org/all/20230524081842.3060-1-jasowang@redhat.com=
/
> [5] https://lore.kernel.org/all/20230720083839.481487-1-jasowang@redhat.c=
om/
>
> Regarding adding the interrupt to ctrlq, there are a few points where
> there is no agreement,
> which I summarize below.
>
> 1. Require additional interrupt vector resource
> https://lore.kernel.org/all/20230516165043-mutt-send-email-mst@kernel.org=
/

I don't think one more vector is a big problem. Multiqueue will
require much more than this.

Even if it is, we can try to share an interrupt as Michael suggests.

Let's start from something that is simple, just one more vector.

> 2. Adding the interrupt for ctrlq may break some devices
> https://lore.kernel.org/all/f9e75ce5-e6df-d1be-201b-7d0f18c1b6e7@redhat.c=
om/

These devices need to be fixed. It's hard to imagine the evolution of
virtio-net is blocked by buggy devices.

> 3. RTNL breaks surprise removal
> https://lore.kernel.org/all/20230720170001-mutt-send-email-mst@kernel.org=
/

The comment is for indefinite waiting for ctrl vq which turns out to
be another issue.

For the removal, we just need to do the wakeup then everything is fine.

>
> Regarding the above, there seems to be no conclusion yet.
> If these problems still exist, I think this patch is good enough and we
> can merge it first.

I don't think so, poll turns out to be problematic for a lot of cases.

>
> For the third point, it seems to be being solved by Daniel now [6], but
> spink lock is used,
> which I think conflicts with the way of adding interrupts to ctrlq.
>
> [6] https://lore.kernel.org/all/20240325214912.323749-1-danielj@nvidia.co=
m/

I don't see how it conflicts with this.

Thanks

>
>
> Thanks,
> Heng
>
> >
> > THanks
> >
> >
> >> Thanks,
> >> Heng
> >>
> >>> Thanks
> >>>
> >>>>> And I remember you told us your device doesn't have such an issue.
> >>>> YES.
> >>>>
> >>>> Thanks,
> >>>> Heng
> >>>>
> >>>>> Thanks
> >>>>>
> >>>>>> Thanks,
> >>>>>> Heng
> >>>>>>
> >>>>>>> Thanks
>

