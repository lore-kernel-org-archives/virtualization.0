Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0735155335
	for <virtualization@lists.linux.dev>; Wed,  5 Feb 2025 19:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738785223; cv=none; b=tGhT2/lcgerrYRl2KMPCrFeeM0Knaj03TlBUgwA5k+fpe/ktqsuLRBtZti76rRcyKt8pdRMeN+kjhOoqeXCsyu5EoVyXqHefonAHVD4x6gyRYrVAzNSY0P4Z2z6lINBFVMSfeL0hyVH9ye6dlS463wrH6VCKgIwXJ4peRR1W5Jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738785223; c=relaxed/simple;
	bh=6q5v84lcktHrl3Z/XuzQ2h/3k5A/dQfZvkx4mZLUD3I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WTWzTu4ZqKG1WvTpabYfwilrMkY5zliAi12suxCgHuL7P7uSrDdESCnM8LEudxJ5qHJqJqK7SIb6tj5JuerFC+PvW4F9TM1nyGw9+2OG/icoh0h2WUrZrHtHbhG44WAsSTpXup8lbdSC/nJlM+FyLzfV2G7km3KJ22VXsF1gieM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IP1we2iH; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IP1we2iH"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-21625b4f978so24395ad.0
        for <virtualization@lists.linux.dev>; Wed, 05 Feb 2025 11:53:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738785221; x=1739390021; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6q5v84lcktHrl3Z/XuzQ2h/3k5A/dQfZvkx4mZLUD3I=;
        b=IP1we2iH2TndBBltcE1HiC5fLdVg/tgWKzLJdjajlC8W/kSyrYoT+Fx0PdHTegZYBW
         7O6xLWn93RyRgbeSkLSW8voybDttkO9nVf7HMJdUp8rlYzS5ayYlkkUXICa0oykACM9V
         dfnotVtXYQYyzLRMnXeHfPvGTnDXqo7fC1W8jQJFM95NkbVrQnyp28lMVx/dZHxBHiEY
         56oYgvTU1UzYJ8zdR74ufprBFlmUcFrp1aGB6YPPO5M+LiPwjVPhWLmbWBs2wq4tcV4K
         fPkbaBqSLUNsIm01rMgis1w7gtBkEpy4NhU84IG/oycfe05tjyPIOssK+PnBf+mqFAWA
         YddA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738785221; x=1739390021;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6q5v84lcktHrl3Z/XuzQ2h/3k5A/dQfZvkx4mZLUD3I=;
        b=N5TfP3fJW7YONjN1ytMpTSYDI9008ppyuW+3doc3TYtfUDunMN42PNiAY4O9MzaL5o
         ssnAtMD/FOAGkon1Nxbo6U61RyHlh9zEGUmhX8Lvk4PMqN67Qpws2TipXi7+njfL/Hi4
         JADcv3U/hOwnRDCQW05N4X8Eh5jQvhvs8QkCQrG9mVrBdiIELiMnmoBBMQcofLMrJLb7
         qY/MEbF7Ks7yTv02LBw0ZQoOWu53RjbgLIaRextFMnTzB/lNx4CwOWIEdmCLZT8ctLDR
         dBVR2HQBDv/7fceB44Cw3jMEjspoz/fCGdMadEvTyqwtpH90qeCARYOrXq6bNwlbCwn6
         t7qA==
X-Forwarded-Encrypted: i=1; AJvYcCVfkT6D37OJqWs2RjSphKHAfWE9rIFYl+yxJ3jQ+xI2RiG8JKAUFa66U7g/T2QT3WSlQeJWsYEEpCKb2OE0OA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzNP7WBSIjpbz3aPhToV5xnqvXzLPnEUQD5G3SfB8XVaUqZCkyl
	ECYH6D6c6BX6Hr4+a+IMJhNIQKcwTgj5589Xzhc604GIR+jI1GIWtrt15Jy8PCxogTsW9UC2203
	Y046lzoDgn7wld+oTDSv7K4hAaMZlfcFcdmCc
X-Gm-Gg: ASbGncv7FvbJ4S96OJrWkmBBAH04SzqbVBbob6N8FHal4iSXZ3eHzRl3iuWASTrtBpV
	Qo0Iw6184Qf9/O39BEq6+u7Rv6q5GpKyJlmKXKfgD2+TJvBCbTEPqzd2r5s6bYk+E0RGrofE8
X-Google-Smtp-Source: AGHT+IFDcob/TSEuYMXb3hSVO++9mpu4Se8Bnl44BpJBOAaoFodhFrUGSu2xVB4BmBZwjRYxoARZ3TUatoE/oCz5blg=
X-Received: by 2002:a17:902:a9c3:b0:21a:87e8:3897 with SMTP id
 d9443c01a7336-21f3022831bmr337775ad.4.1738785220998; Wed, 05 Feb 2025
 11:53:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250203223916.1064540-1-almasrymina@google.com>
 <a97c4278-ea08-4693-a394-8654f1168fea@redhat.com> <CAHS8izNZrKVXSXxL3JG3BuZdho2OQZp=nhLuVCrLZjJD1R0EPg@mail.gmail.com>
 <Z6JXFRUobi-w73D0@mini-arch> <60550f27-ea6a-4165-8eaa-a730d02a5ddc@redhat.com>
 <CAHS8izMkfQpUQQLAkyfn8=YkGS1MhPN4DXbxFM6jzCKLAVhM2A@mail.gmail.com>
 <Z6JtVUtsZL6cxsTO@mini-arch> <20250204180605.268609c9@kernel.org>
In-Reply-To: <20250204180605.268609c9@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Wed, 5 Feb 2025 11:53:28 -0800
X-Gm-Features: AWEUYZmMVG6gb-GClyYhPSsDJYW5WzEYrdAHF0Dz0FhMB9-YcVD_emeIkz00f9E
Message-ID: <CAHS8izNPxqUHNcE-mtnLSMEpD+xH9yNCxEAkvn01dLekkuvT_Q@mail.gmail.com>
Subject: Re: [PATCH net-next v3 0/6] Device memory TCP TX
To: Jakub Kicinski <kuba@kernel.org>
Cc: Stanislav Fomichev <stfomichev@gmail.com>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-kselftest@vger.kernel.org, 
	Donald Hunter <donald.hunter@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Neal Cardwell <ncardwell@google.com>, 
	David Ahern <dsahern@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	sdf@fomichev.me, asml.silence@gmail.com, dw@davidwei.uk, 
	Jamal Hadi Salim <jhs@mojatatu.com>, Victor Nogueira <victor@mojatatu.com>, 
	Pedro Tammela <pctammela@mojatatu.com>, Samiullah Khawaja <skhawaja@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 4, 2025 at 6:06=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Tue, 4 Feb 2025 11:41:09 -0800 Stanislav Fomichev wrote:
> > > > Don't we need some way for the device to opt-in (or opt-out) and av=
oid
> > > > such issues?
> > > >
> > >
> > > Yeah, I think likely the driver needs to declare support (i.e. it's
> > > not using dma-mapping API with dma-buf addresses).
> >
> > netif_skb_features/ndo_features_check seems like a good fit?
>
> validate_xmit_skb()

I was thinking I'd check dev->features during the dmabuf tx binding
and check the binding completely if the feature is not supported. I'm
guessing another check in validate_xmit_skb() is needed anyway for
cases such as forwarding at what not?

--=20
Thanks,
Mina
