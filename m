Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DB8A4F1E5
	for <virtualization@lists.linux.dev>; Thu, 21 Mar 2024 09:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711014257; cv=none; b=RyhlNKdvyyy/Lz8KrWHH2PrK/YwO7yal1ewxsMX9t4sYHWOokXfzKwBE4czfawko9SyGT8wd5Th1bsg/iT1dodwFOjQHcUtxkrwc6b0zuGBNYHavdK1VZxFF5BMeBkGe4VnygyIWUZ4hdQ14VSdvj6SwxvoyuuF0h2wbEHWonj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711014257; c=relaxed/simple;
	bh=+BddkWmVb2KxQclyW5gI/MMg+/38KCLwOvq0RB+zoRg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CiZSO0wXeU8tdflmGgs4DLv6HWsDWm3GPsSNestD3Ih8QcPFuWe+bse5a0NKHFPiB40RGJeb03lR4Vt15qt/6EXlZQuJfF2IH2LqOMtwW028/HWFwPm4/kRp+sOcGdUXHcyl6YpELStfT9GR9u1aZNlpcS5mtuc/i73GgIciXZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gooddata.com; spf=pass smtp.mailfrom=gooddata.com; dkim=pass (1024-bit key) header.d=gooddata.com header.i=@gooddata.com header.b=TPkK55+x; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gooddata.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gooddata.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gooddata.com header.i=@gooddata.com header.b="TPkK55+x"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2d41d1bedc9so13698381fa.3
        for <virtualization@lists.linux.dev>; Thu, 21 Mar 2024 02:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gooddata.com; s=google; t=1711014253; x=1711619053; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7bnysIZLRHuJugMNjksHZ7KgXRP8kfnV+ELbUklK0tQ=;
        b=TPkK55+x+CyoX62hcEdT63q4B95D/iL7JUtspc+fSBfHCHI+if2dvInzYwtMMIvk9E
         udpy9Wr/1ZkjHd07pl+yFl2vHTrjd1FH3kCwkZw6F7adV5pLdlNbd6IZnC5k10s/PC1C
         KIvZck56Ww3NSJtSYMhU5PHYgom8QkHv67ioo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711014253; x=1711619053;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7bnysIZLRHuJugMNjksHZ7KgXRP8kfnV+ELbUklK0tQ=;
        b=Ds6olaNCVMz78v0+Tvm/mLv9lZ3koPQ9LJNpc7hSuWva/sCTkJXa2lpSOvoUwzshy7
         d6q2Nj6UCW27I9PHsG7ci2MxpPBsyTS9Fax0LXogSQ/AZJIMuxKsjwp6pYyxDdii3B9B
         T2sc8QSljKCfI318toL7RL5SOhqlzpyg08yVq58nmOkSs+piDkmY6njhfY+/IE7HA5xN
         7qbpDdFfRH/yaQsMrEaeV208jUWQvth08vXMxF47b/9WTxjlIDsd3n3GhLwbn0tTi4cC
         Mrd4MTQY74bPT36zIzvteFLRcTHeo7XEUJJPPYQIw7fl/AxRYEkWmB3Ck5yoVnx3uVRG
         6tTA==
X-Forwarded-Encrypted: i=1; AJvYcCVTPK6VSQUmEA8YUUXMzO2K+yJNYTBqkcpT55XM2SJZpZuwDzFQaVXqQhW2RefKYVUDVftcdTcLNDwZIT8JNmE2rNavpb+1Hvbt68pzqVI=
X-Gm-Message-State: AOJu0YxlPvdlg0qMC5adD08cWBbpAI2eCZ1ATasW5BjEJRfwVI7BIJW2
	M1aZ6w8wEg9R82Eb1XxIvDtUrjtogPbISkAh6CnOuxedEmwH90C0Cj6IbugOgAstqly+hLI1qfv
	dM275bfsYyiKVJQRyH33kEvEPhL8u5DzNFnXq
X-Google-Smtp-Source: AGHT+IEuiJ3gPiBp0utLLCSVFQZk+rtPf3Lsyn4LSIs5SyTRd+I+8Eds85ZIqUIGPgvT//dxXReBQprBN392uYZNzpA=
X-Received: by 2002:a05:651c:3cf:b0:2d4:132b:9f21 with SMTP id
 f15-20020a05651c03cf00b002d4132b9f21mr1205215ljp.6.1711014253330; Thu, 21 Mar
 2024 02:44:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CA+9S74hbTMxckB=HgRiqL6b8ChZMQfJ6-K9y_GQ0ZDiWkev_vA@mail.gmail.com>
 <20240319131207.GB1096131@fedora> <CA+9S74jMBbgrxaH2Nit50uDQsHES+e+VHnOXkxnq2TrUFtAQRA@mail.gmail.com>
 <CACGkMEvX2R+wKcH5V45Yd6CkgGhADVbpvfmWsHducN2zCS=OKw@mail.gmail.com>
In-Reply-To: <CACGkMEvX2R+wKcH5V45Yd6CkgGhADVbpvfmWsHducN2zCS=OKw@mail.gmail.com>
From: Igor Raits <igor@gooddata.com>
Date: Thu, 21 Mar 2024 10:44:01 +0100
Message-ID: <CA+9S74g5fR=hBxWk1U2TyvW1uPmU3XgJnjw4Owov8LNwLiiOZw@mail.gmail.com>
Subject: Re: REGRESSION: RIP: 0010:skb_release_data+0xb8/0x1e0 in vhost/tun
To: Jason Wang <jasowang@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	Stefano Garzarella <sgarzare@redhat.com>, Jaroslav Pulchart <jaroslav.pulchart@gooddata.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Jason & others,

On Wed, Mar 20, 2024 at 10:33=E2=80=AFAM Jason Wang <jasowang@redhat.com> w=
rote:
>
> On Tue, Mar 19, 2024 at 9:15=E2=80=AFPM Igor Raits <igor@gooddata.com> wr=
ote:
> >
> > Hello Stefan,
> >
> > On Tue, Mar 19, 2024 at 2:12=E2=80=AFPM Stefan Hajnoczi <stefanha@redha=
t.com> wrote:
> > >
> > > On Tue, Mar 19, 2024 at 10:00:08AM +0100, Igor Raits wrote:
> > > > Hello,
> > > >
> > > > We have started to observe kernel crashes on 6.7.y kernels (atm we
> > > > have hit the issue 5 times on 6.7.5 and 6.7.10). On 6.6.9 where we
> > > > have nodes of cluster it looks stable. Please see stacktrace below.=
 If
> > > > you need more information please let me know.
> > > >
> > > > We do not have a consistent reproducer but when we put some bigger
> > > > network load on a VM, the hypervisor's kernel crashes.
> > > >
> > > > Help is much appreciated! We are happy to test any patches.
> > >
> > > CCing Michael Tsirkin and Jason Wang for vhost_net.
> > >
> > > >
> > > > [62254.167584] stack segment: 0000 [#1] PREEMPT SMP NOPTI
> > > > [62254.173450] CPU: 63 PID: 11939 Comm: vhost-11890 Tainted: G
> > > >    E      6.7.10-1.gdc.el9.x86_64 #1
> > >
> > > Are there any patches in this kernel?
> >
> > Only one, unrelated to this part. Removal of pr_err("EEVDF scheduling
> > fail, picking leftmost\n"); line (reported somewhere few months ago
> > and it was suggested workaround until proper solution comes).
>
> Btw, a bisection would help as well.

In the end it seems like we don't really have "stable" setup, so
bisection looks to be useless but we did find few things meantime:

1. On 6.6.9 it crashes either with unexpected GSO type or usercopy:
Kernel memory exposure attempt detected from SLUB object
'skbuff_head_cache'
2. On 6.7.5, 6.7.10 and 6.8.1 it crashes with RIP:
0010:skb_release_data+0xb8/0x1e0
3. It does NOT crash on 6.8.1 when VM does not have multi-queue setup

Looks like the multi-queue setup (we have 2 interfaces =C3=97 3 virtio
queues for each) is causing problems as if we set only one queue for
each interface the issue is gone.
Maybe there is some race condition in __pfx_vhost_task_fn+0x10/0x10 or
somewhere around? We have noticed that there are 3 of such functions
in the stacktrace that gave us hints about what we could try=E2=80=A6

>
> Thanks
>

Thank you!
