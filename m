Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26CB26A009
	for <virtualization@lists.linux.dev>; Sat, 22 Feb 2025 00:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740183875; cv=none; b=RN2oef5LubdIQv/2lgnjN5oIXeldDSjvE5Yb/ckwguj6AfPgLj5n9rnsrP40X0m/wx+wfgaE9kAgZ034ydzlprSVUC0bR5V1fjvykVNE9tIeLR8uNNNG2pTRjv8vTNE/YArRVbNx3rymqv3qmTfkOwEbhkH+aPd55Wsx4A2W0fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740183875; c=relaxed/simple;
	bh=hPpnlZKOG91aAsSK3c+6EiQG/hLmCAaD3GdYrIVqp9s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nivpVig1LN//I6UrnKHKvEqD2bPSARqmVJUoMeP4qr6GhNvDiX/oG8Rh5GrTwfn44S/1y6Ltt7AHgWmuToBirz1b3t0gwfGV7f4w1BiYmsRXVtjKCMsVIdBneDBEau+yKjgVwIpQu9MPcHuvoTcA+yeh62LerO9fYNOq6UE9Hes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=h6OoGTVQ; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h6OoGTVQ"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-221ac1f849fso29285ad.1
        for <virtualization@lists.linux.dev>; Fri, 21 Feb 2025 16:24:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740183873; x=1740788673; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K/x8vAcUB/ic855YHRH64Mw9k0JCngQUmBTGGdXhTfY=;
        b=h6OoGTVQaEOERSpH0BH4/MgtnMAqbvTLJawKhxp5HQ9X6I0xdodFVqZnGhkiUB0FJu
         4/Ry2sJVFUB07UXqdc9Db9Dqy25YWeSgYt6fdy/bf+6ntL6GHARRZnUlZ7afOe2xHd8s
         kh6YMVNBW9qZYE32cd+2rWEfleY0dbGq7KXYEhyFr5azGXSd1ak6f1PFCGCqlh0QurdU
         cpJEJQkP3334VooeEVrueKHeoL+Fp+/6qwZmOAxppQPgTNyjWDD/ZUT8xTvIB0D9OtER
         bJvQ8Jh2AZkzJ/UzHPUiEFC/IHFm9sVrrvvxY4U5PlfyPk0QXGyL8o34uKH8qKkwJ/ne
         KV7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740183873; x=1740788673;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K/x8vAcUB/ic855YHRH64Mw9k0JCngQUmBTGGdXhTfY=;
        b=gC7fozxoUHUTABbnAemYIYX35uZE0gAGt/BQwlV3rLzRZRNNA+7CLl5pEQdOLlAdrS
         JWl5ySI6ajEWyxQPEmRt1b/2wnGw3ZpdS50Bl3ehY4Gudn0fhfAB8yjTyI5fuDYybGyX
         SwEYyChH9s02dWxyIJR+rib2m8+avvZAIdvJ1mb6Ca5PpiuvA5hFPBdtLNNdyc8FEVbu
         j5PJYpiXfFqcG+vzW/bLxe7YcV5q1QjAaKUOa42vuehZoAFj4OKKwwobIcWd9OooVNrM
         zy85wMKJUKUBQTKEYRdzVoPI+GYwKMv51/oeNWQdACe7WasqR+R7jecG2mQa1W5qODPd
         F5Gw==
X-Forwarded-Encrypted: i=1; AJvYcCV63tjJz6Tlbo52fh9vAPWrqZTNUK5R4kv204Fv7fuRx7MrTWfl8kQZVOV1yVowYFA2W8vfyUPTfx5ZquX/uA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwSgu1jQKv0BGYq6FxP1Tgmti2MIV6tc4i5wT+GT0V9bi/iU8C1
	m7B9GOJ2rXqqt5V38yodbofo0gOAdKhtCuxqycycrft5lne44og6DpkTg/BHVtzBGRaaMbfZ8pR
	77DZfFVA53n8/Z45axnXqCrwqV5hdVeq4BStu
X-Gm-Gg: ASbGncuT5hz4eVijBzvUwpZUdvs6WuauvYKqkv/NHgj6CnkvOnUUCOovEUmq1s9M3Df
	6dP8BwHewJu1LtL+ER7LpfljKVdOPyHmABdyqJ1HQ1CZ9xAgmgc8oBMToi+3pEIINGi47qzAxTb
	GNSv1W7b4=
X-Google-Smtp-Source: AGHT+IGVsr7xcN9MCd6339oiPC71YpQrUXMaUKu2w5DQntfyomcz0s1pc+sIqfRcq3uFYKJynoApH5QECxwHh6kTReI=
X-Received: by 2002:a17:903:228c:b0:21f:44eb:80f4 with SMTP id
 d9443c01a7336-221b9cfbfbamr1012175ad.4.1740183873140; Fri, 21 Feb 2025
 16:24:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250220020914.895431-1-almasrymina@google.com>
 <20250220020914.895431-10-almasrymina@google.com> <Z7eKHlA0rCF2Wgxb@mini-arch>
 <CAHS8izPA2eQ251-whnsT7ghG01c0e=tERL4Cwg1tBr+ZfVNHpA@mail.gmail.com> <Z7kYYXixRws7Kk-q@mini-arch>
In-Reply-To: <Z7kYYXixRws7Kk-q@mini-arch>
From: Mina Almasry <almasrymina@google.com>
Date: Fri, 21 Feb 2025 16:24:20 -0800
X-Gm-Features: AWEUYZlIN4OsigwtyTsPVx6XPhcjksTX5jYAgeD4mnU6jpvOBA8xEU409eVhNLw
Message-ID: <CAHS8izNF=wAhT29zHzUTtNMnm43NFGYOEeyHc+Gf_S3EDTd+-w@mail.gmail.com>
Subject: Re: [PATCH net-next v4 9/9] selftests: ncdevmem: Implement devmem TCP TX
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, virtualization@lists.linux.dev, 
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Donald Hunter <donald.hunter@gmail.com>, Jonathan Corbet <corbet@lwn.net>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Jeroen de Borst <jeroendb@google.com>, 
	Praveen Kaligineedi <pkaligineedi@google.com>, Shailend Chand <shailend@google.com>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Willem de Bruijn <willemb@google.com>, David Ahern <dsahern@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	sdf@fomichev.me, asml.silence@gmail.com, dw@davidwei.uk, 
	Jamal Hadi Salim <jhs@mojatatu.com>, Victor Nogueira <victor@mojatatu.com>, 
	Pedro Tammela <pctammela@mojatatu.com>, Samiullah Khawaja <skhawaja@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 21, 2025 at 4:20=E2=80=AFPM Stanislav Fomichev <stfomichev@gmai=
l.com> wrote:
>
> On 02/21, Mina Almasry wrote:
> > Hi Stan,
> >
> > Thank you very much for testing. I was wondering/worried that there
> > will be some churn in getting the test working on both our setups.
> > It's not unheard of I think because your ncdevmem changes had to go
> > through a couple of iterations to work for our slightly different
> > setups, but do bear with me. Thanks!
> >
> > On Thu, Feb 20, 2025 at 12:01=E2=80=AFPM Stanislav Fomichev
> > <stfomichev@gmail.com> wrote:
> > > > @@ -25,18 +25,36 @@ def check_rx(cfg) -> None:
> > > >      require_devmem(cfg)
> > > >
> > > >      port =3D rand_port()
> > > > -    listen_cmd =3D f"./ncdevmem -l -f {cfg.ifname} -s {cfg.v6} -p =
{port}"
> > > > +    listen_cmd =3D f"{cfg.bin_local} -l -f {cfg.ifname} -s {cfg.v6=
} -p {port}"
> > > >
> > > >      with bkg(listen_cmd) as socat:
> > > >          wait_port_listen(port)
> > > > -        cmd(f"echo -e \"hello\\nworld\"| socat -u - TCP6:[{cfg.v6}=
]:{port}", host=3Dcfg.remote, shell=3DTrue)
> > > > +        cmd(f"echo -e \"hello\\nworld\"| socat -u - TCP6:{cfg.v6}:=
{port},bind=3D{cfg.remote_v6}:{port}", host=3Dcfg.remote, shell=3DTrue)
> > >
> > > IPv6 address need to be wrapped into [], so has to be at least:
> > >         socat -u - TCP6:[{cfg.v6}]:{port},bind=3D[{cfg.remote_v6}]:{p=
ort}
> > >
> >
> > Yeah, I will need to propagate the ncdevmem ipv4 support to devmem.py
> > in the future, but unnecessary for this series. Will do.
> >
> > > But not sure why we care here about bind address here, let the kernel
> > > figure out the routing.
> > >
> >
> > I will need to add this in the future to support my 5-tuple flow
> > steering setup in the future, but it is indeed unnecessary for this
> > series. Additionally the bind in the check_tx test is unnecessary,
> > removed there as well. Lets see if it works for you.
>
> Hmm, true that it's not needed in check_tx as well. Let's drop from
> check_tx and introduce when you need it? (but up to you really,
> was just wondering why change rx side..)

Yes, that's what I meant. The next iteration will not change the rx side.

A follow up series will add ipv4 and 5-tuple flow steering support to
devmem.py, but that's unrelated. We can discuss when I send it.

--=20
Thanks,
Mina
