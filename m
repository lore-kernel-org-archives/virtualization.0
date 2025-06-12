Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C5791A23B6
	for <virtualization@lists.linux.dev>; Thu, 12 Jun 2025 08:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749716486; cv=none; b=mLWkCpFjf43UApZMh23wrvEPnGQkvMm3jE0HbonERGwXGBmR/OU/3DC1m26BVfABVSFy7jSZwhJmqOJmeJ0mcIfFs8M3cC3VBUbgo3QCdZ9lUNNdSu50FNt+WFnU3d3rI4bASTj1CAWy3rASR+Uje5739hGmFGAsYXmqjBfU3ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749716486; c=relaxed/simple;
	bh=cA1qk3yB6bh3HRDOAFOZEbWTkiE34cfwmnNRWGtfb2E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kpxkO+FHjfD64V0AQh3Xj4RpCRVcRc2sqqnenn+iLfjSS2lmrSPju+rUl4pGaURkDzY3HCCTKceQz7YuFTt6lc7L1o4qHbCHCXEJAk1Zc4D9jVlP1PgO/In0lho3aI/3WoOB80zHBuVpPs7QShp+v+y19SPUZHoGFMmFOMnj93A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IQ0WaPgL; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IQ0WaPgL"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-747fba9f962so601954b3a.0
        for <virtualization@lists.linux.dev>; Thu, 12 Jun 2025 01:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749716485; x=1750321285; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AGY5/ZppoucW3cdRAPG2Yq6T7pXeZ7SlaGjUvy+OgTk=;
        b=IQ0WaPgLI74BrQCQ0O0ztO8h5T6VGN6FntrZlIW8SoPBPPtIPjxYYHui6OFQC6j/nK
         SQGx4L9oDN/ayv799BFLe/By5vimfnP4PE2bk4BYmXc93sMEKSYrGcwQU0pz8meDnijO
         CFgRHX1ooRYkEjjswfBjr7YIMIxctmbXLRa8QwJqTLaWXbJvCDgV1a6HN/wAVW9MFO6d
         E3oUishoMzLSzkbSAgfwHfdxdH2pOP70AKrwzqq6X2ibtlpmvimc6T5226OhOAK67vjP
         WoiWuRk+B05twktIJ9lgcjC794Qk+kieZsgbSYQdMH3wPusEU2bQlbTQG4rUMCMhxe9N
         8X3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749716485; x=1750321285;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AGY5/ZppoucW3cdRAPG2Yq6T7pXeZ7SlaGjUvy+OgTk=;
        b=MiGlp8Ps/Hx/Ls6j0NTAmGb2KQ1a1S8ftCOi+gODLJ98K+um7E/JRfhKA8Ylyw5q02
         htXwOwz6T9TG03Ipi2U62N5T+fqJPfK7fxplbZ0CXO6VLPgB6Bsfsy0fI51VXmr5JlVh
         gxO4Fs51XWco44IwOPlpDc6raDFh6EhD3MobHBJcphIcnfKyP2TYsX7vFs7OB6wn/b8F
         OkcOI7QgRyjaAmWiKuRIwsf5Tc1m7COzJO1Yt3w+X7jcAhNdNUIJPFoxQrdDBwydfI7Y
         ElemG8Vk9seTE4EsthdtOe/ceu4gdGEfs7g1QlCRS0exr3CualUZMPZhLo5bqmjKQGEs
         k13w==
X-Forwarded-Encrypted: i=1; AJvYcCVa3eInLr7UQUwaHW73MKdBISYmUowIEL/DaJ4OZroij9yyA8v0BSVbuFrfgE2P4EBWv1zGU/JPgnURv97IKg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzrVNgcnBtwvFhkJaZBZJSnSsH1fuAx5/PZ7svfPEylqjLBZkEL
	N7/QI8lUJ4lbnl8k20dEY/8NiH+nZ2k52rnQXgNJMTah5zISi0H8Xmxa
X-Gm-Gg: ASbGncuLsv18Ss1mkC68LBA0XVSeeyw9c7zVV0uEe86Ii6jzEEfY8WFOenWUSq8QR6O
	y5y3P5kQYtutWo9gHhRrNRnDJ5kTmWG3whnTnyoW0Nkv+McIOGNLWn7mwBrwBVUt3GJwrd2yglb
	6pBzBSPyNTR/GVa+9LD3eGUcInYBcfx6VHzLY+XuI1qJ/Q2kSBKlYYccYn6wctFA0qfkLXgRQ8P
	8SD2DQsztOf55VycO2lk1wU1Hh+niKrmXqZri/jnfU4SppJW3yKJrijJKx3XRjKRwGDBNDBSRyB
	1oG0TwMCJVLLxr+tySkI7bzCfbMBFEeTyOhtSpbnVGLqDePOv/cE8vCYQVLrLCLYVK9BMKPV68/
	7z5J6rp4+LxEfUqYnAVg=
X-Google-Smtp-Source: AGHT+IE+LDi/Ab84IBFtCqrYc1tpyvpJ4aUiVqEazD1/iV2mWYI0UZMCjrUiYLHgOoy0bCfPKn/26A==
X-Received: by 2002:a05:6a00:6086:b0:746:2217:5863 with SMTP id d2e1a72fcca58-7487ce58871mr2355872b3a.6.1749716484623;
        Thu, 12 Jun 2025 01:21:24 -0700 (PDT)
Received: from devant.antgroup-inc.local ([47.89.83.0])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-748808962d5sm885967b3a.54.2025.06.12.01.21.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jun 2025 01:21:24 -0700 (PDT)
From: Xuewei Niu <niuxuewei97@gmail.com>
X-Google-Original-From: Xuewei Niu <niuxuewei.nxw@antgroup.com>
To: sgarzare@redhat.com
Cc: Oxffffaa@gmail.com,
	avkrasnov@salutedevices.com,
	davem@davemloft.net,
	edumazet@google.com,
	eperezma@redhat.com,
	horms@kernel.org,
	jasowang@redhat.com,
	kuba@kernel.org,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mst@redhat.com,
	netdev@vger.kernel.org,
	niuxuewei.nxw@antgroup.com,
	niuxuewei97@gmail.com,
	pabeni@redhat.com,
	stefanha@redhat.com,
	virtualization@lists.linux.dev,
	xuanzhuo@linux.alibaba.com
Subject: Re: [PATCH net] vsock/virtio: fix `rx_bytes` accounting for stream sockets
Date: Thu, 12 Jun 2025 16:21:02 +0800
Message-Id: <20250612082102.995225-1-niuxuewei.nxw@antgroup.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CAGxU2F6c7=M-jbBRXkU-iUfzNbUYAr9QApDvRVOAU6Q0zDsFGQ@mail.gmail.com>
References: <CAGxU2F6c7=M-jbBRXkU-iUfzNbUYAr9QApDvRVOAU6Q0zDsFGQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> On Thu, 12 Jun 2025 at 08:50, Xuewei Niu <niuxuewei97@gmail.com> wrote:
> >
> > > On Thu, Jun 12, 2025 at 01:32:01PM +0800, Xuewei Niu wrote:
> > > > No comments since last month.
> > > >
> > > > The patch [1], which adds SIOCINQ ioctl support for vsock, depends on this
> > > > patch. Could I get more eyes on this one?
> > > >
> > > > [1]: https://lore.kernel.org/lkml/bbn4lvdwh42m2zvi3rdyws66y5ulew32rchtz3kxirqlllkr63@7toa4tcepax3/#t
> > > >
> > > > Thanks,
> > > > Xuewei
> > >
> > > it's been in net for two weeks now, no?
> >
> > Umm sorry, I didn't check the date carefully, because there are several
> > ongoing patches. Next time I'll check it carefully. Sorry again.
> >
> > It looks like no one is paying attention to this patch. I am requesting
> > someone interested in vsock to review this. I'd appreciate that!
> 
> Which patch do you mean?
> 
> Thanks,
> Stefano

I am saying your patch, "vsock/virtio: fix `rx_bytes` accounting for stream
sockets".

Once this gets merged, I will send a new version of my patch to support
SIOCINQ ioctl. Thus, I can reuse `rx_bytes` to count unread bytes, as we
discussed.

Thanks,
Xuewei
