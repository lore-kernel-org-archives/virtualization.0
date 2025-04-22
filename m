Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E021F5859
	for <virtualization@lists.linux.dev>; Tue, 22 Apr 2025 18:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745346671; cv=none; b=iZQUktLk9MZFTl3plRbiYbDIz+AOZi6i+IhmV4HDCMtdcdj7tW2QdFyW+rrA19uPdlAWN5epYd74wxNmrCj3HqV61zOzhkIYggs/JIeilFT3ybocr9HOrUcm6sSQuC0/8RlYn8AincY7MhWKLWs4+/of+sE7N5zwP/TMhJgjLMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745346671; c=relaxed/simple;
	bh=sP2y8V4iFyPf2hZIH31J/Re3lgO9Dig+sImIP/b6z6w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UOWXUHWg56vS3zZ5SX7qxjbiolc59ymFW+SjptT67yKaZSprKen0J32G1/I0CIUMH2gTqK2VdXoIYFZ7SpZRyYBCKO4icxeN7fZdhhZHTWZoNvGQ2wSlMihISPgjggJU5Xa+YwWKQAoZO9QCbDxYW7agnGqqU18Ftftt8glkfqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=z+OoBT8R; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="z+OoBT8R"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2240aad70f2so35355ad.0
        for <virtualization@lists.linux.dev>; Tue, 22 Apr 2025 11:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745346667; x=1745951467; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sP2y8V4iFyPf2hZIH31J/Re3lgO9Dig+sImIP/b6z6w=;
        b=z+OoBT8RFhGXZBg3poNqlgZ0g6TP22Qs9vQnVaC33udvM94UvurrPb8bGJWma1pxxV
         C01cp5I5htTEem/Q4aGSugXRoFMcum3ANaE9rP/fKlkzXb/mAZzaJ/5jZr9Uu7B2uZNE
         oesNClpw2zmzwWGv2fV/v80vlDY5o2IF22RiQuTbjJH9G1/uEH/TbW82hbHm3bkC5qpJ
         i52Hk5dCAMlJoafnqDfZeeAfHwnAj+Vl7AFZ6zSIX73opgLLk+Kxpt2003exk3ykr0Nu
         k1QfnBgcmgOuN/uaubXos+KaqmpjEqefSF0LO6SWKVg/MEuCJywtxmwBDMHYDlcjJad1
         MTXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745346667; x=1745951467;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sP2y8V4iFyPf2hZIH31J/Re3lgO9Dig+sImIP/b6z6w=;
        b=ek1s/sRkL0c6hTnNEmHXeqW7N+Ejp9RjwIhkNBKp3KV2miEvKtBt7B5KyxLfGs4x4/
         jOn9zSrag/r1Oo4dkQmi08ugOTHlbufgaQ/JBmJ5p4ChiOxtFGYidBS2gcn8rupxYAlG
         eOPzwuBmF4TgjbtoFJUNLjYXO0ugLcyPFTMDbpH7GFfUgW1DyQ55zf5EeJbMLsM3f/gQ
         B5LmDArl/qYEUuMmC7ri4WeaRmQ+v4Lag+O64RMn807l/xxzQBgqMDuo1ywtBlnPkm48
         Rht+hxoJ/Zg50Ip221ng/80B3v/6NwUIFvpQd42E2c2AqlDMV8svSw4y4KwtOneWPMK2
         dluQ==
X-Forwarded-Encrypted: i=1; AJvYcCVYsLcn1QrSXqGL+eUCbqJ5fMUHrR1ush11zLKalwZvoJL+05eaZjv/qD9PM++qdHPVtfuKvDwZT0l2pXbKZA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw8Q5yFdslqcF82m3i2NoC/+v6CJPBGkTHyjIZwWpWrxE5wthnm
	d+oPZ1dMKjRt91zzomu6poGanQOM0lhYBL87cvwk3J0ESAn82R1V7etMpXoITTWpm8vIqfG4J1q
	MUZ/T1I1uBQoXdribZZa9QqK+K0zffqukBzwuKlH8HRTYK/jWqw==
X-Gm-Gg: ASbGncsKysaxjj2+BgtPJkuuP1TB4mTSTwgfFYUIuo96uyca14oPd8xWB0Ml1C6Dsl7
	SpFsYy2GjBXgfgkM+XkqpuNApzaC8g5xTbFSlqMAzeTeMIGCEEIySJN2r6zsfhXQgbUPjKRQO8s
	d6taKHerAvmGtfNswEFmtIjrRwFVsNbHcJM60oOk9g8d1r14ilr2jW
X-Google-Smtp-Source: AGHT+IHwBVYqmkFHBIkZqvpRm8yJ+UXOUekkq6sAIy3oK50GRp6r1rxb5Xt4sDCK8GoLsViDZQiuddnPCapKhvr8aTg=
X-Received: by 2002:a17:902:8c82:b0:21f:2ded:bfa0 with SMTP id
 d9443c01a7336-22da2e9587cmr103215ad.25.1745346667017; Tue, 22 Apr 2025
 11:31:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250417231540.2780723-1-almasrymina@google.com>
 <20250417231540.2780723-3-almasrymina@google.com> <484ecaad-56de-4c0d-b7fa-a3337557b0bf@gmail.com>
 <CAHS8izPw9maOMqLALTLc22eOKnutyLK9azOs4FzO1pfaY8xE6g@mail.gmail.com> <957b74ed-f29c-4bb8-b819-af4e1168d6c1@gmail.com>
In-Reply-To: <957b74ed-f29c-4bb8-b819-af4e1168d6c1@gmail.com>
From: Mina Almasry <almasrymina@google.com>
Date: Tue, 22 Apr 2025 11:30:54 -0700
X-Gm-Features: ATxdqUGAYmhnej_FvEeRx5rp6OZSN2G5JXdVv0CxCE5OSvY5qcT3QiMIj5aAdEw
Message-ID: <CAHS8izM8+zG6KOhV7ysTsCj_PEty5eL+P+uUxTZhdsOSZTwmow@mail.gmail.com>
Subject: Re: [PATCH net-next v9 2/9] net: add get_netmem/put_netmem support
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, io-uring@vger.kernel.org, 
	virtualization@lists.linux.dev, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Donald Hunter <donald.hunter@gmail.com>, 
	Jonathan Corbet <corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Jeroen de Borst <jeroendb@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Willem de Bruijn <willemb@google.com>, Jens Axboe <axboe@kernel.dk>, 
	David Ahern <dsahern@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	sdf@fomichev.me, dw@davidwei.uk, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Victor Nogueira <victor@mojatatu.com>, Pedro Tammela <pctammela@mojatatu.com>, 
	Samiullah Khawaja <skhawaja@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 22, 2025 at 11:19=E2=80=AFAM Pavel Begunkov <asml.silence@gmail=
.com> wrote:
>
> On 4/22/25 14:56, Mina Almasry wrote:
> > On Tue, Apr 22, 2025 at 1:43=E2=80=AFAM Pavel Begunkov <asml.silence@gm=
ail.com> wrote:
> >>
> >> On 4/18/25 00:15, Mina Almasry wrote:
> >>> Currently net_iovs support only pp ref counts, and do not support a
> >>> page ref equivalent.
> >>
> >> Makes me wonder why it's needed. In theory, nobody should ever be
> >> taking page references without going through struct ubuf_info
> >> handling first, all in kernel users of these pages should always
> >> be paired with ubuf_info, as it's user memory, it's not stable,
> >> and without ubuf_info the user is allowed to overwrite it.
> >>
> >
> > The concern about the stability of the from-userspace data is already
> > called out in the MSG_ZEROCOPY documentation that we're piggybacking
> > devmem TX onto:
>
> Sure, I didn't object that. There is no problem as long as the
> ubuf_info semantics is followed, which by extension mean that
> any ref manipulation should already be gated on ubuf_info, and
> there should be no need in changing generic paths.
>

I'm sorry I'm not following. skb_frag_ref is how the net stack obtains
references on an skb_frag, regardless on whether the frag is a
MSG_ZEROCOPY one with ubuf info, or a regular tx frag without a
ubuf_info, or even an io_uring frag which I think have the
msg->ubuf_info like we discussed previously. I don't see the net stack
in the current code special casing how it obtains refs on frags, and I
don't see the need to add special casing. Can you elaborate in more
detail what is the gating you expect, and why? Are you asking that I
check the skb has a ubuf_info before allowing to grab the reference on
the dmabuf binding? Or something else?


--=20
Thanks,
Mina
