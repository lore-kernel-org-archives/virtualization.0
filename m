Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE67F1DF988
	for <virtualization@lists.linux.dev>; Thu, 24 Apr 2025 18:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745520571; cv=none; b=dAk6qB5FL5xXk/k0tu0vMiBeLiB0GOLuQorPppPnj1FVxhs+ohsXIaYW4/W7IhK00VGMTwBjGzPAcdyPqhGsDAaOMf3tkmsf/WxTd3KBfiMXQ7O2KtwjX0FbuDlobeTczwwUo5woLlBry2Rn9Hskfst6CKQ7hxi0wFyhnhD7txM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745520571; c=relaxed/simple;
	bh=YJThV8OU+yLTh48RfiUdm+OTToDHsoL5U/oCrdFEqDQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hBOaEcWCAhZd+9osiz235Da4BwYzd3FAeLCthz1HfOqzpcVY+HJbGobo57hKxE+nCXhwru7MmP1h2pD7rSN4kiHft5CICfSaPnCOFYic5MI7QmV8BBdE8GmU3hHE8MPIkueAqaVWddXpXB+9vRFCRQIMBcqcVKWD9vhu4J4ZlCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I914G6RA; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I914G6RA"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2240aad70f2so22925ad.0
        for <virtualization@lists.linux.dev>; Thu, 24 Apr 2025 11:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745520569; x=1746125369; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YJThV8OU+yLTh48RfiUdm+OTToDHsoL5U/oCrdFEqDQ=;
        b=I914G6RABY7rJ27ML/nOPE+XmRwr2Sv6FL/WCA4sjLcwWzI1jOhosyIjcnpI275/PC
         oaZUDtbexDOvsr7VRZKlGneKjPWXsnkaqeWrh3cOi+W8W00i3eeVNYzd1CUe4LsGx0wX
         tOgFQThRPYVCfeQLq/x2h9G0lS5BM87Abpepw3dWaNENgWBQ2AUpXKDv42fR3KvgMl3H
         wj0ofSEoJsPJHMmy8MGxh6f4XrX8DCTu70qn/PL0i2PealT6VfKcEPreiDWogvV16etx
         V/FsHY76Ka9cfsotyNZp40ZD54GNQZ/rR9duCzNr9z1vE8glvpJV+GF4aRlQrHNEfXYY
         deHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745520569; x=1746125369;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YJThV8OU+yLTh48RfiUdm+OTToDHsoL5U/oCrdFEqDQ=;
        b=V4tvp4uz638aIepGJaLLGu3Ze4VjFsEm5UyS/AsRqjuJSjzWzPEzTatll4R84Xi37v
         OVrNe+Um1PZ1wJZGs3+YM/LjiAofgXAtkQmIDm4fgyVfi54fc4mzxDRiWnvS1Dd5l5ni
         NjtLizEw6euqmHMndT+RGktnoKcw9lxq7x7ToXwNjl80teleZyH3K1u/XjDAOXGJMq9K
         YJPuk+7UmT//eyhhcPN3Q1imsMnfCNZaPP/vbnH43A4ZHpcdWy+WutL1utkAppueyv8x
         FUAVrp2OZYuvijViz0b9lDdY3fDRJ//PeuguORVvwB3Xamfx8WyLxEuzzV2xgqkGTX1V
         QGOQ==
X-Forwarded-Encrypted: i=1; AJvYcCXEKG34/D7GkgCSK6gvNo4iui3+//KuIFuoPr1Thz0CMxPTzVaVIqwOpMafZD+GivVvbT/sllMIHjvMIs4AEw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz6pwwfeWdt8f7USKmgBO091IZMPu7DBeEfjVOBypMHfli+oCxS
	Z+bHflp/WomnMg6syloJz9KZYLB90Zqk6qbT2YMmveIJ5IffjQqiL0XxLLmmpNNN+zwFg20eJwq
	nkHwFrtCTMAoUHjoCEB5Sy465dR20m6TxKg6B
X-Gm-Gg: ASbGncsNJg1aC6dXsxBsGEkI6FHeXip2rxnFoNOJiHGmVoPFDUA1EAuUqnWLQmyUVeL
	pqRlYmDgAi9e5NXSZ5MOCkjsRq+/UmGvz3hdv/Famcp5Z5CDOjcjYKIlo4c4j+3ruxYVH4AHqFA
	b21O6laVd81yGSbdPKLJACmKsSfkZb36L6pLXbdr44hY2K2jJe4Jve
X-Google-Smtp-Source: AGHT+IG7TvFiypkSdm6cFL8QXv7Geze56CiuyUqiMCDjIy5B3tjxrLsMvkElYIkhtHnXIN1qIRY0zGBcPAIono1A5h0=
X-Received: by 2002:a17:903:2053:b0:220:ce33:6385 with SMTP id
 d9443c01a7336-22dbdb49fd4mr181535ad.9.1745520568724; Thu, 24 Apr 2025
 11:49:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250424040301.2480876-1-almasrymina@google.com>
In-Reply-To: <20250424040301.2480876-1-almasrymina@google.com>
From: Mina Almasry <almasrymina@google.com>
Date: Thu, 24 Apr 2025 11:49:16 -0700
X-Gm-Features: ATxdqUGSuXy2A5TP0CkyPakNQ5S2ontOlQJJboyrRu9J3Ao5kJdPZ2OrP3y4P5Q
Message-ID: <CAHS8izOT38_nGbPnvxaqxV-y-dUcUkqEEjfSAutd0oqsYrB4RQ@mail.gmail.com>
Subject: Re: [PATCH net-next v11 0/8] Device memory TCP TX
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, io-uring@vger.kernel.org, 
	virtualization@lists.linux.dev, kvm@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Donald Hunter <donald.hunter@gmail.com>, Jonathan Corbet <corbet@lwn.net>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Jeroen de Borst <jeroendb@google.com>, 
	Harshitha Ramamurthy <hramamurthy@google.com>, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	Willem de Bruijn <willemb@google.com>, Jens Axboe <axboe@kernel.dk>, 
	Pavel Begunkov <asml.silence@gmail.com>, David Ahern <dsahern@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	Stefano Garzarella <sgarzare@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	sdf@fomichev.me, dw@davidwei.uk, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Victor Nogueira <victor@mojatatu.com>, Pedro Tammela <pctammela@mojatatu.com>, 
	Samiullah Khawaja <skhawaja@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 23, 2025 at 9:03=E2=80=AFPM Mina Almasry <almasrymina@google.co=
m> wrote:
>
> v11: https://lore.kernel.org/netdev/20250423031117.907681-1-almasrymina@g=
oogle.com/
>
> Addressed a couple of nits and collected Acked-by from Harshitha
> (thanks!)
>

Hello,

I made a slight mistake sending this iteration and accidentally
dropped patch 9, which contains the selftest. There is nothing wrong
with the selftest in this iteration, I just accidentally cropped the
series 1 patch too early.

I'll repost after the cooldown, and if this happens to get merged I'll
just send the selftest as a follow up patch, it's an independent
change anyway.

--=20
Thanks,
Mina
