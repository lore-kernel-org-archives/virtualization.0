Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D456F31A
	for <virtualization@lists.linux.dev>; Thu, 30 May 2024 10:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717065285; cv=none; b=sGWHMcVXONjFfBucnTEi/TptEonWoDimsncLmSohzaNrSUX464UkuBIoSwtODz/CNIgY4v25g0yzj9fjS0p8Cs7Nv2aFt0VhmENRvPPXhquAUx5K8FZbYeWF2i5z6E0hcdnCkeI0W3s1DloLYJKhm/UtzLEASM0EhcVYnP3704Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717065285; c=relaxed/simple;
	bh=ePmgCh8f6VP8cJpAjv3aRynpva2CXsinJUvR63f6q5I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GxI45p49oijyEf9uxejbhK4HKDlhG0JAGz9ZzERoZbi+b9Q7f5V8e0lNGc7qdyft8mWmsdEnzaDlU/OzmZU90bEDPCFVbXJO7xtNtw03LMyNe1pGla7RIc6LfnOHTB12xIjyTg50XfAeeQz0Hk7Q5R8+9eSCR9EcH44VXCDWPXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RupBH0Zb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RupBH0Zb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717065283;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mwLCS9VGdrJbwBiT7iSopRHZglWQyG9eLhkRIAFbkGQ=;
	b=RupBH0Zb3Er9jbf6eDVBQrDVqvXtRwAPAn6ZSKiMs68s4DbWSMO6+bqplbMmWodhxeO/h1
	Qnvql52YzrADWjT7U2V8qMbH1IUCBLnQG0dCMeggS2x32YUHgyeWG7/qM5oJXef0giBfhf
	U1uWPP2ve5ZVJnksoU+u3vk3KLQnU6g=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-473-Sibfs1rSOlaSacf4FO455g-1; Thu, 30 May 2024 06:34:42 -0400
X-MC-Unique: Sibfs1rSOlaSacf4FO455g-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2bffbc8ad81so637648a91.2
        for <virtualization@lists.linux.dev>; Thu, 30 May 2024 03:34:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717065281; x=1717670081;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mwLCS9VGdrJbwBiT7iSopRHZglWQyG9eLhkRIAFbkGQ=;
        b=WlTi7ALnMmFa9u0/CXpM7oYYjLEQAmrixn6oHilr68iLyLNYVjuG3oedPLKpKij5Ng
         /BIRTDTrZL5uL4BD/xxO8r2jc9p9XbryyYhFov6FO/J9fnu1s4bd9sSXrCVe/hI+GZfB
         fg4C8zGXgt89Hc6PyHAN1cOdFBBUTFIIuoTJRacZrbPiR4V5niUOkUR1Obfa6IvSj1Km
         hz4w0TAUBTsbRxToLYyGOZXMC4d9kk6xoZ26wNRbTMHW7pOOg+Tn3l6N+UfPk1ZLssvJ
         yNf9RAPylFSGVTNcqOl6oljN7DkCO4pPhRnCriSW8NNvOPFEOTblJZidVAb028sofWF0
         UQ5A==
X-Forwarded-Encrypted: i=1; AJvYcCV089G7htDAt3rLFtnYCiHfuZm1gPzPhctwLc8wXKc6FGg+cwntq3hu1BmebO6ZhPj6nnBDXV2AeiJ0SNUqCBBfT5pbemQ8qkYUgrG8tyQ=
X-Gm-Message-State: AOJu0YxU4SiHVEl+2yE2uX/pjTxGkP5Kz8yd8YMZmMszZteJYfGaamaA
	yNdz1SlHl9epqCDJhoEP2JOo4EXP1M4ixceKLsZnXm60AW9zuwK7PoxEtraj6Gc0uHBrffRfO60
	ZMJYcAg28Qix3svEp4j5u+HrUyMSnbVCJujVVAw7oDgZUa5QwkS+16plG22BGAIWk4ff5nwcT/8
	oTfIb715f64oL46e5E3aeQDd9V/fZbDy3h6RYXrt8=
X-Received: by 2002:a17:90b:270b:b0:2bd:92d9:65ee with SMTP id 98e67ed59e1d1-2c1abc4d0d4mr1453140a91.45.1717065280937;
        Thu, 30 May 2024 03:34:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHk6+dfMQCKGwc1HtwekDNqHFptPdJqcRTcTRCLYqrYTDLlvOHyke+Y+SyRiGtLAEESjhX8MP2i+utCSG64urM=
X-Received: by 2002:a17:90b:270b:b0:2bd:92d9:65ee with SMTP id
 98e67ed59e1d1-2c1abc4d0d4mr1453124a91.45.1717065280528; Thu, 30 May 2024
 03:34:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240528134116.117426-1-hengqi@linux.alibaba.com>
 <20240528134116.117426-3-hengqi@linux.alibaba.com> <20240530051420-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240530051420-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 30 May 2024 18:34:28 +0800
Message-ID: <CACGkMEswextPQ-Cf9uYxAqJg24FkrBRr_nXP+e9YpYCck8sjnA@mail.gmail.com>
Subject: Re: [PATCH net v3 2/2] virtio_net: fix a spurious deadlock issue
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Heng Qi <hengqi@linux.alibaba.com>, netdev@vger.kernel.org, 
	virtualization@lists.linux.dev, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Jiri Pirko <jiri@resnulli.us>, 
	Daniel Jurgens <danielj@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 30, 2024 at 5:17=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Tue, May 28, 2024 at 09:41:16PM +0800, Heng Qi wrote:
> > When the following snippet is run, lockdep will report a deadlock[1].
> >
> >   /* Acquire all queues dim_locks */
> >   for (i =3D 0; i < vi->max_queue_pairs; i++)
> >           mutex_lock(&vi->rq[i].dim_lock);
> >
> > There's no deadlock here because the vq locks are always taken
> > in the same order, but lockdep can not figure it out. So refactoring
> > the code to alleviate the problem.
> >
> > [1]
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
> > WARNING: possible recursive locking detected
> > 6.9.0-rc7+ #319 Not tainted
> > --------------------------------------------
> > ethtool/962 is trying to acquire lock:
> >
> > but task is already holding lock:
> >
> > other info that might help us debug this:
> > Possible unsafe locking scenario:
> >
> >       CPU0
> >       ----
> >  lock(&vi->rq[i].dim_lock);
> >  lock(&vi->rq[i].dim_lock);
> >
> > *** DEADLOCK ***
> >
> >  May be due to missing lock nesting notation
> >
> > 3 locks held by ethtool/962:
> >  #0: ffffffff82dbaab0 (cb_lock){++++}-{3:3}, at: genl_rcv+0x19/0x40
> >  #1: ffffffff82dad0a8 (rtnl_mutex){+.+.}-{3:3}, at:
> >                               ethnl_default_set_doit+0xbe/0x1e0
> >
> > stack backtrace:
> > CPU: 6 PID: 962 Comm: ethtool Not tainted 6.9.0-rc7+ #319
> > Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
> >          rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
> > Call Trace:
> >  <TASK>
> >  dump_stack_lvl+0x79/0xb0
> >  check_deadlock+0x130/0x220
> >  __lock_acquire+0x861/0x990
> >  lock_acquire.part.0+0x72/0x1d0
> >  ? lock_acquire+0xf8/0x130
> >  __mutex_lock+0x71/0xd50
> >  virtnet_set_coalesce+0x151/0x190
> >  __ethnl_set_coalesce.isra.0+0x3f8/0x4d0
> >  ethnl_set_coalesce+0x34/0x90
> >  ethnl_default_set_doit+0xdd/0x1e0
> >  genl_family_rcv_msg_doit+0xdc/0x130
> >  genl_family_rcv_msg+0x154/0x230
> >  ? __pfx_ethnl_default_set_doit+0x10/0x10
> >  genl_rcv_msg+0x4b/0xa0
> >  ? __pfx_genl_rcv_msg+0x10/0x10
> >  netlink_rcv_skb+0x5a/0x110
> >  genl_rcv+0x28/0x40
> >  netlink_unicast+0x1af/0x280
> >  netlink_sendmsg+0x20e/0x460
> >  __sys_sendto+0x1fe/0x210
> >  ? find_held_lock+0x2b/0x80
> >  ? do_user_addr_fault+0x3a2/0x8a0
> >  ? __lock_release+0x5e/0x160
> >  ? do_user_addr_fault+0x3a2/0x8a0
> >  ? lock_release+0x72/0x140
> >  ? do_user_addr_fault+0x3a7/0x8a0
> >  __x64_sys_sendto+0x29/0x30
> >  do_syscall_64+0x78/0x180
> >  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> >
> > Fixes: 4d4ac2ececd3 ("virtio_net: Add a lock for per queue RX coalesce"=
)
> > Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
>
>
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
>

Acked-by: Jason Wang <jasowang@redhat.com>

Btw, adding notation seems to be another way.

Thanks

