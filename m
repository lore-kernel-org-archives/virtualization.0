Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B465263F54
	for <virtualization@lists.linux.dev>; Mon, 24 Feb 2025 17:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740417570; cv=none; b=SdE5FzNzZN3JehIRHOxX/wwvH/fVbCFN8MeMzmzVPlrH28TtxGFZ2Mn62YEuTBVIrFxtpLvpbYdRrVjxjJYCyaH/f7OAmsNcwH2iD1mh8quCWHoMzHuNC4YU3NcTr+08PzKHVXZL6TaGDu2iCC7WTDE/bC0mI2yFob4Gnb222nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740417570; c=relaxed/simple;
	bh=YkGfGRHPFOGIrjt7CW0/60RcoF2CYhgcQyUVsVMlKsk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=geOg6NhEpOAJiNC5U2F6gX0Vq0vrjNj6NNc03ADjQqWyWt6uUvzAqBmMQmV3m6qgGpXtQY5Fauuehe1zFlM4Zbayo1bqGpkenT3HnIriqnhl0zkUAJviY0SrcY38yRRLcSt29yKnc9AfzfYYUYvIBIV6rxk++8efnVbJ1wL00kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4Iq7JHTZ; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4Iq7JHTZ"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-22117c396baso376395ad.1
        for <virtualization@lists.linux.dev>; Mon, 24 Feb 2025 09:19:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740417568; x=1741022368; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YkGfGRHPFOGIrjt7CW0/60RcoF2CYhgcQyUVsVMlKsk=;
        b=4Iq7JHTZpDEUWCzAzVy+RlA397tgMpcyl5d+lSwz6lj7bV6GTHXjSa7va/qmM6zs/2
         eWq77dUKUc3O1V/2niQYRV0okxCXT338DG3tOOuuH1u/tO57+N1KVvKnGcMR91l7l88e
         XK6iV44pWrzN4GUoLBAXC0hrkTLYL74I2mLOmm7CErxFcgvnQ3N7cB+bdT6aS/cM+20Y
         DPhVU3qtzT+8gtl4pqaXmIEIP1g99bw+O/IyVAEAbUe3kaPeoF5y98sgffv9Ag5coNq4
         FMBs6TENJE/eq82ZF5B2OibGlYDbVlJaGxUzGdnei0AO/M9WiNIyX1tmI3Mq3MwO/nSx
         QdXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740417568; x=1741022368;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YkGfGRHPFOGIrjt7CW0/60RcoF2CYhgcQyUVsVMlKsk=;
        b=LHIqXffayWiHr5tZMp0hXiWxyVejSutHsTfAFwECKi0hSgrrSYAy0Y4ZJFm7l1Acjt
         IbgojB7E6UeWO00qWnDCrAshmx1fsL7MqbJMcUbB75EL6bB+8JyWv/mqOgADTi+AnX10
         5CCqI0OaA6M9wvANNs61GrKK/G7B7MNFWaDgYB+5rNa62q6PBCL0o/VefakO6ZfNs+Vu
         VBtdSnFqqcF3CJ+tU9cgLWVYfFlGJimwRdj8QjaqJIJjPJRUkUxgTVVO8d5rHXOxrmit
         Njtlgywdfk1OuhftKqOC0B0IFHNw2dwMo0CTIiIICcOhO/5QFuCRQ9TVCODUi4UVI5KE
         e8/Q==
X-Forwarded-Encrypted: i=1; AJvYcCX/JwcWTDecRmH4JE6iMoXtXbMcszsmg6kSj7tNgye/f5HJhQUhjsWB/7eFl+Gn8YLD7rqT9JHU8SA06WWh5w==@lists.linux.dev
X-Gm-Message-State: AOJu0YzCgkgt+rgud3Qx1pHadmAG6G+AEPy1hOwKtJx6DQStA/+oQ4r6
	06aenpwlmYH8qOlLqi0SBnB6g7v2EDgm24Qq+47knXbTVHLqedKo8t1/g7D1cWLrklH3aDd3dHq
	vcE5pUGhOIfDsRdgAU7LvYh2GjPWowuh4/WM2
X-Gm-Gg: ASbGncs5Mj6hmcfQbHW4KLX7gBp4m9qffiL6OmzzvQyrnCN3iJaaQ4W9SK60Sagu2J8
	0HbhnNNmVpnyuuq7qV4DZLcKZ63X19r3E/rKQG1rc0malabOYslhAA63SwGNd/HVfAtPCIWAsmW
	7sRLVkbRc=
X-Google-Smtp-Source: AGHT+IHTAwfAEIHfGaanz2ImJIv6TFBo6hJ0pV+jmXwD7kT/u4LNJh///oPwcVt2cEUyOMZ5KobtdpSb6LmndtBex80=
X-Received: by 2002:a17:902:db0f:b0:216:7aaa:4c5f with SMTP id
 d9443c01a7336-22307a2f1ccmr89755ad.3.1740417568009; Mon, 24 Feb 2025 09:19:28
 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250222191517.743530-1-almasrymina@google.com>
 <20250222191517.743530-10-almasrymina@google.com> <Z7ypMjORvm99q6L0@mini-arch>
In-Reply-To: <Z7ypMjORvm99q6L0@mini-arch>
From: Mina Almasry <almasrymina@google.com>
Date: Mon, 24 Feb 2025 09:19:13 -0800
X-Gm-Features: AWEUYZkSIiPtvI8VObRXZQvcc3R--20e8PUb_X-ZIgU5euHjlp4NxpuUlOVfZXU
Message-ID: <CAHS8izM9xMqWnJB5Cm=DMMBV1BuUemFjKSv9So8V_xQ8ToTRqA@mail.gmail.com>
Subject: Re: [PATCH net-next v5 9/9] selftests: ncdevmem: Implement devmem TCP TX
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, virtualization@lists.linux.dev, 
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Donald Hunter <donald.hunter@gmail.com>, Jakub Kicinski <kuba@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Jeroen de Borst <jeroendb@google.com>, 
	Harshitha Ramamurthy <hramamurthy@google.com>, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	Willem de Bruijn <willemb@google.com>, David Ahern <dsahern@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	Stefano Garzarella <sgarzare@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, sdf@fomichev.me, asml.silence@gmail.com, dw@davidwei.uk, 
	Jamal Hadi Salim <jhs@mojatatu.com>, Victor Nogueira <victor@mojatatu.com>, 
	Pedro Tammela <pctammela@mojatatu.com>, Samiullah Khawaja <skhawaja@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 24, 2025 at 9:15=E2=80=AFAM Stanislav Fomichev <stfomichev@gmai=
l.com> wrote:
>
> On 02/22, Mina Almasry wrote:
> > Add support for devmem TX in ncdevmem.
> >
> > This is a combination of the ncdevmem from the devmem TCP series RFCv1
> > which included the TX path, and work by Stan to include the netlink API
> > and refactored on top of his generic memory_provider support.
> >
> > Signed-off-by: Mina Almasry <almasrymina@google.com>
> > Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
>
> Acked-by: Stanislav Fomichev <sdf@fomichev.me>
>
> We need exit_wait=3DTrue for check_rx as well, but I'll send this change
> separately.

Yes, I discovered the same thing, and I have that change locally along
with some other fix ups I'm readying up for review in a separate
series.

Thanks for the reviews!

--=20
Thanks,
Mina
