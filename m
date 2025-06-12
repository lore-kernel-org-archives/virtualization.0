Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 845081E5713
	for <virtualization@lists.linux.dev>; Thu, 12 Jun 2025 08:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749718535; cv=none; b=tksP+IOmCH6wXB4bLpk7CzUIhP0nAxVBZv+wcuVSvzubC9jQIuPCw8qRYFECrn9A6rugBx+KtQjsJ2iLwGKBp5ZiuI8yb6uVYhSpoLm9JQJz4QEtCcKuD9O5vH4he4n+U+rBAjwLDXdEZPo45bZ12cDu+hEd+avB7pIXkA3+Ooc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749718535; c=relaxed/simple;
	bh=VZXDJzKIiAsBEUC2cmW7v9IAJ9vLIMf0Brbum9EX6hU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lp2eRpETHZOzNIpwOrUZ5hJhrsmuqfUP3tXnJuJ+vMwvQWoQDhim8I5vUwOAOqIQMwMSedHf6V1NnK+xDz5IwvQCd9IUi9DZxyiow65vYIEP74pDh5Yci+FKKUEZz5Qk5n457tVZ7tJMU0MACrMOp6aL4eofs2rZlATtRtV/ZWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VvmXyoWP; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VvmXyoWP"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-235ea292956so6877175ad.1
        for <virtualization@lists.linux.dev>; Thu, 12 Jun 2025 01:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749718534; x=1750323334; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r+jaW01Ram8J0CFjvnmO+DegLpwAOHm96vNJd5ZWYGc=;
        b=VvmXyoWPIyttyqS968+GBgyc4gXGA8tCQ+lr5ipEuav4PN8tPYkjRxfZ83JdjCoH5p
         dohy9jiGD9wK3L6KLQKvFR94dBSdTDXImJTOnzDQVGUgJK8FJ9rLuHtXGbXF1PA8K3Vn
         9iLOy8pFKtf48bax8f/TTsacth0Wl7SJZBSFdnXo3qpFnySD54pJpzkW1/9spv96BXu/
         O4FSrdJrXNqJHUwJP8WX8YvvvXrxJJmZ7O2v6XGNM2JyhjpT2BTWGdehcs1t4x/RGHEF
         QfObSD/5gK9MU3rBRDXPzWBPUA6ORU5pgR8MZqYlwNDMmXLn2JYF3W8zWA9/m5JaQxFU
         PRlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749718534; x=1750323334;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r+jaW01Ram8J0CFjvnmO+DegLpwAOHm96vNJd5ZWYGc=;
        b=tG4OoOr/iBBdXAJWrcCTDo/MnllvFr5bkCau7HfcBZjXLGPzQOezX6kKAZWYOqx3fh
         BkMQU4CLqUjxz6MyE3ys4MygnIiB+nqMhDzqKiTmfHjSgca86/9mWUYZCAopa3e0e/KJ
         90QXfMqJE32C4xZV5E8gkIq3s4yEBPR7UFWLl7jX8vOow19WPj0PHAs053sLzySat6XA
         xoaMlynukBC/hE6Njn151YGPQ5yKyzjtmPbXQ28oqW+3cZUJqgWS+bibHIqcJKo0e8Vk
         QuantpgSUsiGmzCLzdos8ychFnPgIC3K4CtVJ43+lNsm7JjtRtMRShm8sBAsp+CpMwez
         /fiw==
X-Forwarded-Encrypted: i=1; AJvYcCXuya7MCKKp+VmeAtekjepCjQWcK+LKVEgaY3F0KeC1+Mvm/MChktMNptJMHZKFV/hAKTyqHlrCP+NiGYiTcA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxo7ySN4fKCb1d2DCElMuh/p6aR8OJCTVK6Pf7Bcp38W+ukPWEA
	h1YLyUHo9519E4acjfE4xCod1Qd6IEYpEZawo6Po0NE6UjZ4rK1gTWWTFgSyOGWMf+DUTqlt
X-Gm-Gg: ASbGncu0jWFBKl04Pw6uN8MzCmi1zFdxLdzGtbSi7hEKasnajaHTCl3uMFfVvsT5wai
	spIebzR3P2Yk8AvepMEKSsgWqDDcsAgc8lGMWJetb12RCoFW2M8N/4R9z3zNcwU1QxHJ9Ogccj2
	V3qCHIxCtPEFaqrseDv/3he6Ijnf+yxoRukeicgRUMF8e0zAIl8EaaPDhrqxauyKJOgyBMkGPeT
	CdE2vlwmeWpXEVPKMkfkFgYpz7Fv/yba2b/vjEP7wNoxNEu86hqTxyXX1DlNLLFi70mgKY7lFJR
	hr6yAdrXoTebpfDeoSM7qztIlSetWDmZPorXV2YTST9rfrlGqH7ueP4QyMcYuDNQib/LVg0/ixJ
	wJEFpd5q3
X-Google-Smtp-Source: AGHT+IGjP2s+60vt5yfxvQLR/980gfc56krWjJoT6dyD3iyrJFgNwpVJkdwAlwAWklxXdUzbHas1Fg==
X-Received: by 2002:a17:90b:2e07:b0:312:1ae9:153a with SMTP id 98e67ed59e1d1-313c08c7f55mr3402555a91.25.1749718533518;
        Thu, 12 Jun 2025 01:55:33 -0700 (PDT)
Received: from devant.antgroup-inc.local ([47.89.83.0])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-313c1c6ab91sm929480a91.48.2025.06.12.01.55.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jun 2025 01:55:32 -0700 (PDT)
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
Date: Thu, 12 Jun 2025 16:55:14 +0800
Message-Id: <20250612085514.996837-1-niuxuewei.nxw@antgroup.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CAGxU2F4JkO8zxDZg8nTYmCsg9DaaH58o5L+TBzZxo+3TnXbA9Q@mail.gmail.com>
References: <CAGxU2F4JkO8zxDZg8nTYmCsg9DaaH58o5L+TBzZxo+3TnXbA9Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> On Thu, 12 Jun 2025 at 10:21, Xuewei Niu <niuxuewei97@gmail.com> wrote:
> >
> > > On Thu, 12 Jun 2025 at 08:50, Xuewei Niu <niuxuewei97@gmail.com> wrote:
> > > >
> > > > > On Thu, Jun 12, 2025 at 01:32:01PM +0800, Xuewei Niu wrote:
> > > > > > No comments since last month.
> > > > > >
> > > > > > The patch [1], which adds SIOCINQ ioctl support for vsock, depends on this
> > > > > > patch. Could I get more eyes on this one?
> > > > > >
> > > > > > [1]: https://lore.kernel.org/lkml/bbn4lvdwh42m2zvi3rdyws66y5ulew32rchtz3kxirqlllkr63@7toa4tcepax3/#t
> > > > > >
> > > > > > Thanks,
> > > > > > Xuewei
> > > > >
> > > > > it's been in net for two weeks now, no?
> > > >
> > > > Umm sorry, I didn't check the date carefully, because there are several
> > > > ongoing patches. Next time I'll check it carefully. Sorry again.
> > > >
> > > > It looks like no one is paying attention to this patch. I am requesting
> > > > someone interested in vsock to review this. I'd appreciate that!
> > >
> > > Which patch do you mean?
> > >
> > > Thanks,
> > > Stefano
> >
> > I am saying your patch, "vsock/virtio: fix `rx_bytes` accounting for stream
> > sockets".
> >
> > Once this gets merged, I will send a new version of my patch to support
> > SIOCINQ ioctl. Thus, I can reuse `rx_bytes` to count unread bytes, as we
> > discussed.
> 
> As Michael pointed out, it was merged several weeks ago in net tree,
> see https://lore.kernel.org/netdev/174827942876.985160.7017354014266756923.git-patchwork-notify@kernel.org/
> And it also landed in Linus tree:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=45ca7e9f0730ae36fc610e675b990e9cc9ca0714

I misunderstood Michael's point. I am new to this, and not familiar with
the process. Sorry about that...

> So, I think you can go head with your patch, right?
>
> Please remember to target net-next, since it will be a new feature IIRC.
> 
> Thanks,
> Stefano

Yes, I'll do it ASAP.

Thanks,
Xuewei
