Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8D9E1D63DF
	for <virtualization@lists.linux.dev>; Tue, 22 Apr 2025 23:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745362856; cv=none; b=bt5+tLvyUHTEPl15tLIr4xDpbwB0zFfIu5n+xnQqCLhSQrcl6ly7G1kPJFra7dm1eQ8+Zosl0McE3nHKyuYSKDgs/jeJeh9ACh6wMuUc4sl+uQT7zhbktaBzBXSEyPUoOY2T6It6TP1h7/8+ppfI3KyWN0m1Ny1mJK1fnoeo8pY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745362856; c=relaxed/simple;
	bh=vA0x1LF+TTujtzA/a9qIyOuUZvc6uTpZ8L2xS4rCm/w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dkjgeABn6S0pWvCgSUYG+gI7awWL+Q8P1qlymIloN3KECAouLk4tL5bWi1mv+5rtPH4gU/sMrp4XiLPVtc5Ma3eRgtfV60AJ1ZAVj4nmfYCkgaD0IDHlcvsO89b+A8W5nNaV1c/7ggbuT0XQfZ4DIWA6wzzLDvMlOp2RMRF3nXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CDOXibVf; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CDOXibVf"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2240aad70f2so102605ad.0
        for <virtualization@lists.linux.dev>; Tue, 22 Apr 2025 16:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745362854; x=1745967654; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X0wkS+mYcttDoYH2cbzpbLqiayCSdu0EeV0O89OnxB4=;
        b=CDOXibVfzhsSRB56z8S9begxQncsDH3Ag8z/4uc/Xti9o7hq99QtW41YrLuzRBrEoG
         +3lGeb4phSp8yRmwgUG1IYUqTdS4v0qYgbyzswRN6S71JaZptQGE9etJI6AceBCfQYDd
         02yKKNdOdteclET4w8/MzsirqCov8W7Qvj7rheSfpL3lz2uWsX/UHA7nA1C2j/tv+Hml
         BEY34F3xcUUhlV0cAEr65lk4s4q+fahpjPUElVY6i/TArqmGlaPOe8zzP1TAbTQZqNGT
         qDE9vmPezPFw14syif5OggLqE8riHMnKg9wGOhTpMXNMZU5zCbig0MFzFKzZP1nh9/vb
         O9Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745362854; x=1745967654;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X0wkS+mYcttDoYH2cbzpbLqiayCSdu0EeV0O89OnxB4=;
        b=BF9NvmBYxOPlfTsyhHl0v44XgsY7M87IWkQXYitmMx4v5YIU+6jFTXmWFSEN6QNLDG
         VpC+GZ4GQzjOBhUrpCYx2vd0uAaqpco+EyzGgjXEYAk/yZ0ZA8jujnzgRIX1UpoZYvy2
         wOsZAbw/BKuyvrQKh/m3CYTt3fuHTS+ucWHOWD2fOuG1K5ABG2V05DzuJlNJvA9KK+KT
         A8P/0XVZcD7vCslG8Qd7TApxCqhxwHzbNbhE44uc93PYENUhlfRYAVTpsy4eP1eceHem
         LwOGP24EEyBozRp+2zM/NOEi1tvkGLeZ03g0xbAQUwoBAEW6LffRBKyQCj+FZcqZazo7
         fIJg==
X-Forwarded-Encrypted: i=1; AJvYcCUwTSG+z92YeKS/01cK0re6ohudS7CrAKB9gGXSO2/gy+3JZjov6MjW0pOqNdpdK2qGT7yw8nKHGGSfrBEJ/Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YwtTqPZKMY74cU72O6bA3hQVw/7aPbkPi2UNjRhMqslETjofDZ0
	vxAV05njuyMjDOJHTo/qGjX96Y95W6tPbk6D6PCj/lGO2xfBnYcO8WSR1gH3wreTz8k5CVK9Rpj
	DqEzNuMchBt5vEOANHY75mMHUecGdVcP28OBP
X-Gm-Gg: ASbGncvbRHIL+dDKjpmxV9ELE8W96glMzdTO9MxYzGe5edstUr1TGgdvSPDq0uK0m4v
	ZbcKJdqCJkz4XAp5hzjkWOnDxTtj0v3XQdxR1K+QoYGh9dO2jb/ZDkaReClYgUlg/R4TTUpfQVo
	l3dPGhOeGe9pRzGj9ddMLJ59bxVghfDeyP3lOmKbXXh4v/ShOmGyKECRwIevkKVSI=
X-Google-Smtp-Source: AGHT+IFcA8eNct2OIuHlbOvxzm3T6NVzaOSOXt3ivEIqSJ8wke0kgYVfmjCEtUHN4nE+IsPWRgGhH+7fhESmeCiNRMo=
X-Received: by 2002:a17:902:ef07:b0:215:86bf:7e46 with SMTP id
 d9443c01a7336-22da4ebcff9mr256305ad.7.1745362853731; Tue, 22 Apr 2025
 16:00:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250417231540.2780723-1-almasrymina@google.com>
 <20250417231540.2780723-8-almasrymina@google.com> <CAEAWyHckGSYEMDqVDT0u7pFCpO9fmXpEDb7-YV87pu+R+ytxOw@mail.gmail.com>
 <CAHS8izNZXmG0bi15DpmX2EcococF2swM83Urk19aQBvz=z3nUQ@mail.gmail.com>
In-Reply-To: <CAHS8izNZXmG0bi15DpmX2EcococF2swM83Urk19aQBvz=z3nUQ@mail.gmail.com>
From: Harshitha Ramamurthy <hramamurthy@google.com>
Date: Tue, 22 Apr 2025 16:00:42 -0700
X-Gm-Features: ATxdqUGxkrayoAGMPm_qgEhKu-sQHz14vjXf4E7ZJdbEqvqiDvu9MHtNVHd91NA
Message-ID: <CAEAWyHf7Qzi8CDBeRMB5nMvvNawrFrUCh52k4JevbSHX1Y=zcw@mail.gmail.com>
Subject: Re: [PATCH net-next v9 7/9] gve: add netmem TX support to GVE DQO-RDA mode
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, io-uring@vger.kernel.org, 
	virtualization@lists.linux.dev, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Donald Hunter <donald.hunter@gmail.com>, 
	Jonathan Corbet <corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Jeroen de Borst <jeroendb@google.com>, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	Willem de Bruijn <willemb@google.com>, Jens Axboe <axboe@kernel.dk>, 
	Pavel Begunkov <asml.silence@gmail.com>, David Ahern <dsahern@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	sdf@fomichev.me, dw@davidwei.uk, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Victor Nogueira <victor@mojatatu.com>, Pedro Tammela <pctammela@mojatatu.com>, 
	Samiullah Khawaja <skhawaja@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 22, 2025 at 2:30=E2=80=AFPM Mina Almasry <almasrymina@google.co=
m> wrote:
>
> On Tue, Apr 22, 2025 at 10:43=E2=80=AFAM Harshitha Ramamurthy
> <hramamurthy@google.com> wrote:
> >
> > On Thu, Apr 17, 2025 at 4:15=E2=80=AFPM Mina Almasry <almasrymina@googl=
e.com> wrote:
> > >
> > > Use netmem_dma_*() helpers in gve_tx_dqo.c DQO-RDA paths to
> > > enable netmem TX support in that mode.
> > >
> > > Declare support for netmem TX in GVE DQO-RDA mode.
> > >
> > > Signed-off-by: Mina Almasry <almasrymina@google.com>
> > >
> > > ---
> > >
> > > v4:
> > > - New patch
> > > ---
> > >  drivers/net/ethernet/google/gve/gve_main.c   | 4 ++++
> > >  drivers/net/ethernet/google/gve/gve_tx_dqo.c | 8 +++++---
> > >  2 files changed, 9 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net=
/ethernet/google/gve/gve_main.c
> > > index 8aaac9101377..430314225d4d 100644
> > > --- a/drivers/net/ethernet/google/gve/gve_main.c
> > > +++ b/drivers/net/ethernet/google/gve/gve_main.c
> > > @@ -2665,6 +2665,10 @@ static int gve_probe(struct pci_dev *pdev, con=
st struct pci_device_id *ent)
> > >
> > >         dev_info(&pdev->dev, "GVE version %s\n", gve_version_str);
> > >         dev_info(&pdev->dev, "GVE queue format %d\n", (int)priv->queu=
e_format);
> > > +
> > > +       if (!gve_is_gqi(priv) && !gve_is_qpl(priv))
> > > +               dev->netmem_tx =3D true;
> > > +
> >
> > a nit: but it would fit in better and be more uniform if this is set
> > earlier in the function where other features are set for the
> > net_device.
> >
>
> Thanks for taking a look. I actually thought about that while trying
> to implement this, but AFAIU (correct if wrong), gve_is_gqi and
> gve_is_qpl need priv to be initialized, so this feature set must be
> performed after gve_init_priv in this function. I suppose this feature
> checking maybe can be put before register_netdev. Do you prefer that?

Ah yes, you are right. Thanks for checking. That would be preferable.
Another option is to move it inside gve_init_priv() after the mode has
been set. Either is okay.

Thanks,
Harshitha
>
>
> --
> Thanks,
> Mina
