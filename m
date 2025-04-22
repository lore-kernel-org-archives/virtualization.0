Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD9A51E04BD
	for <virtualization@lists.linux.dev>; Tue, 22 Apr 2025 21:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745357460; cv=none; b=nWgi9+y095fIJ85onowODRqi6X4I+ol2cQGjkMi1bJenwDaeQNQzVbwfhX2NXZadsNjGKJxKcrtekHtZN5BtR2qwGuet01JRSu3pEZiDp2GOPwP6anjTweSTOOHdTVbgNuFeotJypLsAMprg8kUMQ6OUGuHubuSvuZOP49BKzUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745357460; c=relaxed/simple;
	bh=QgWx/mGTOHW5+7tGU+2WKWru7coX4Xp6cIn7ZGTb7ls=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VBrEuswipuP5xZxLYBrQBNWQN1GD/f6UTaJ2vRYColdVnOjEpFgztbctMHjJHX/ptmqf1cCHdz8ZGtFfoA4jhexov0WVqZlqlcAp1hAnaUb6STACD8j7oH90TIb5dH4AjFrT6FqIeq3mpqk0ezQCB7K7C90h+Iv49IJ6IRi/fV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3cIUVW5L; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3cIUVW5L"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2240aad70f2so79915ad.0
        for <virtualization@lists.linux.dev>; Tue, 22 Apr 2025 14:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745357457; x=1745962257; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Svf2ygZXkmCy0ML2RTDTzsfPn2nyYFTdu9KxKlqPAMw=;
        b=3cIUVW5LEL3jKcWweER7jZVE2u79wp5LZgZQkIDqg8cK/Jf/P7U6HnN+i98zrd+LnH
         mRdlhnGU4Hu4f3fEg420FKdXPdQCuqjO5/04BcKVw7xcZ/EbsIu5MRSsbHPaMfIVkpf7
         wzMvtkjf5VsAddmC+i4Lo0hNiRtdC1LI9JY1fNjbu+eNtArSY4ryClr6I8Mp1a2kVU+4
         NweYJ51+bV0cLkJAq41Sn2zZqfwVPft8CwM/BDt8SSbnI2UbkKk+O4Y7k89JzpdTnC/y
         UeI66yrzaepkDin0qiq8L9NG7X6wQc2piiffZgQHDVoCCBwMpDW+i6QMJzH5hSPZsnm1
         BdiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745357457; x=1745962257;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Svf2ygZXkmCy0ML2RTDTzsfPn2nyYFTdu9KxKlqPAMw=;
        b=vLlpzLxhOqTBfEjB1VkOFwO+YmlTLBpZ0H3z/0ZMGqqC7IygAZV0NF26rCKyTipf5x
         YJNTDHJsqSYHpv77M13gfgbXl2b6IwZB2uXlYIhmUsHTTGNoyavzzBwPoUQVnSivbIk2
         EKULA4FQE6uwdafM2+sPBu0blGEggQLWhj4L7kjkoorbmBxrW74NEnUnr+YQ16yl39xa
         TpESzdPd+cJ7DiRkLOuDw823ZRbw+52kNVqlCJhYXXSRO9dxqXxVMgxdg0dp8bwy0oDU
         xtFBqzcD/YBWH0OOxOiAhHyZnSHnNfI45Lv4rVJ6f/NVN+B0puhuV6OPMDW/4B80rLZO
         E6ew==
X-Forwarded-Encrypted: i=1; AJvYcCVhltmmvptTNeB5gkhaQqF9iCLpGY/H+zLQ9ETCA9x/0BOSNjRvgpksv6E8XbDG+gJyqR483/xzVr5iuxvusg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx/AK+4zajbsz2p/meio/NlIV72QF6mNz5Smx9xCq/vwALmoNXu
	qnXhXhUft/uyIvypnqQ6J6AFBs1Lm7jFF9boTI6e+WxD/Eog48i1KHyr5g8rXjWW8KcH1FQ8Nou
	957o5Ndxr9Q5s53Ji/Hj+i8hiRlnD8Li5U25B
X-Gm-Gg: ASbGncv4LU5wi8nBkY7arpLINpIhX1SWdwBlmeSqTHs8/wLJtIi/p9ipD25PcX+ApKA
	WUviN/3kc7m2M8DabWHIQgZmXKJvvSe602VSPs73mGKSEp/kwWrIIFJAf5pm7QUuMmo+dBdbVwY
	EpovRmpDLYCmnIoE898ZsSgpGM5eKgQ6zuwFey/BDWCWkn0T071Uj3
X-Google-Smtp-Source: AGHT+IEsxPoKV42ELz4r3PlLIa9B44ITOq/P7IHVyPrE3pHPM2hSBs7ANYJO9Qlwme81VQmpCIMF5XJigErG9Bs9itA=
X-Received: by 2002:a17:903:f8b:b0:21f:3c4a:136f with SMTP id
 d9443c01a7336-22da2c11b3emr916085ad.28.1745357456832; Tue, 22 Apr 2025
 14:30:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250417231540.2780723-1-almasrymina@google.com>
 <20250417231540.2780723-8-almasrymina@google.com> <CAEAWyHckGSYEMDqVDT0u7pFCpO9fmXpEDb7-YV87pu+R+ytxOw@mail.gmail.com>
In-Reply-To: <CAEAWyHckGSYEMDqVDT0u7pFCpO9fmXpEDb7-YV87pu+R+ytxOw@mail.gmail.com>
From: Mina Almasry <almasrymina@google.com>
Date: Tue, 22 Apr 2025 14:30:44 -0700
X-Gm-Features: ATxdqUF6FGOZDMaVY4FPxfYTFEWH1OIzJQfd7hMv2NVJ5VM5o9Gd234gao1kzAo
Message-ID: <CAHS8izNZXmG0bi15DpmX2EcococF2swM83Urk19aQBvz=z3nUQ@mail.gmail.com>
Subject: Re: [PATCH net-next v9 7/9] gve: add netmem TX support to GVE DQO-RDA mode
To: Harshitha Ramamurthy <hramamurthy@google.com>
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

On Tue, Apr 22, 2025 at 10:43=E2=80=AFAM Harshitha Ramamurthy
<hramamurthy@google.com> wrote:
>
> On Thu, Apr 17, 2025 at 4:15=E2=80=AFPM Mina Almasry <almasrymina@google.=
com> wrote:
> >
> > Use netmem_dma_*() helpers in gve_tx_dqo.c DQO-RDA paths to
> > enable netmem TX support in that mode.
> >
> > Declare support for netmem TX in GVE DQO-RDA mode.
> >
> > Signed-off-by: Mina Almasry <almasrymina@google.com>
> >
> > ---
> >
> > v4:
> > - New patch
> > ---
> >  drivers/net/ethernet/google/gve/gve_main.c   | 4 ++++
> >  drivers/net/ethernet/google/gve/gve_tx_dqo.c | 8 +++++---
> >  2 files changed, 9 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/e=
thernet/google/gve/gve_main.c
> > index 8aaac9101377..430314225d4d 100644
> > --- a/drivers/net/ethernet/google/gve/gve_main.c
> > +++ b/drivers/net/ethernet/google/gve/gve_main.c
> > @@ -2665,6 +2665,10 @@ static int gve_probe(struct pci_dev *pdev, const=
 struct pci_device_id *ent)
> >
> >         dev_info(&pdev->dev, "GVE version %s\n", gve_version_str);
> >         dev_info(&pdev->dev, "GVE queue format %d\n", (int)priv->queue_=
format);
> > +
> > +       if (!gve_is_gqi(priv) && !gve_is_qpl(priv))
> > +               dev->netmem_tx =3D true;
> > +
>
> a nit: but it would fit in better and be more uniform if this is set
> earlier in the function where other features are set for the
> net_device.
>

Thanks for taking a look. I actually thought about that while trying
to implement this, but AFAIU (correct if wrong), gve_is_gqi and
gve_is_qpl need priv to be initialized, so this feature set must be
performed after gve_init_priv in this function. I suppose this feature
checking maybe can be put before register_netdev. Do you prefer that?


--=20
Thanks,
Mina
