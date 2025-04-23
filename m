Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D61A289365
	for <virtualization@lists.linux.dev>; Wed, 23 Apr 2025 17:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745431173; cv=none; b=IhHAITTypcM/a6+6ovLyKv7R9hzUxbYe2Msr3iDTvFzLqy7TITlGUANMZtQr2RofQ5m6jslypl6yKeomjl2+pWd9H4ptq86MMPmsi7oKFGA6tGCG3vT6c1b8/CC9Z/y0f9zh0j8755p3CG3rfh2mlbFv0I0GUeSr0kq08M+hmC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745431173; c=relaxed/simple;
	bh=T2TBlvkxpqSt4Yg66wrWZfHI9nHaKVofCMCsYRliPm4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OaLtBzBJWA6iPZE670pJQEHvxbQ1On0BkqF0XbN0CQ/ZqRcwywveZ5XRago3AJ5ON+/WJLcGcoXlHDG4Gx1b3LLc0R9Ei1bOU747uZlCbQVLxtKqsy/qaRbCXWGxCYtwuiO27fyMYv+ck0gm9M3i/Hg9mCQKIgE4UwNaO5xFVO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hXqSOETY; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hXqSOETY"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2264c9d0295so27515ad.0
        for <virtualization@lists.linux.dev>; Wed, 23 Apr 2025 10:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745431171; x=1746035971; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+8ET6hBVRzBDqshUdhbgCvSUTaazcby/sOi3F1Bc3pI=;
        b=hXqSOETYIkU0NUSEkUDL/zw7faxIhHD6jnplEWvwXOT7E6ay9uEWKcnvPChI30FBHq
         O1DDgYtK4cZpy4L2M1kfgCvuhL73KIW7LteXHHTuhiBj3eBtQb1Bk15UqSfJ5FIj/2x+
         WYqRWEBAhlnW5meA9HbA2fz/webPnSDGSK+kr6dduh3Nm8K9Tc8wg+S7GaHMhgb4eq/N
         fYqAB1mK7gBwJQ77LCCaq1a3K7QyP8d1vCJ1XaiJNVsZdkLP7j3k2ymmnCJ194DOCkoi
         lnaHqDNvbhPi8ZUPPNJqCK0VG/iEPVdaMQnBCwKOvbW+aJr6rGkpA+FTF0zQGTlcXd8y
         FRmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745431171; x=1746035971;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+8ET6hBVRzBDqshUdhbgCvSUTaazcby/sOi3F1Bc3pI=;
        b=Rm+M+JZojn4tTABecqCknr11MtCsFUzU75Mm3Qxejzg5cfmxFtyPVWX6F+c0vd9o/3
         ZJ8ErSrN8jeMQNHrXbEekTrY2oXpu0JS7kUh8c7CztUFUQBBQjsKw1CrxfM9bq1efouD
         A2IqWiLCEf0S1DOu93gzHFVui6RLcY9LjmO6OsV5wTWs+As4Fv7gho0j6wsTcPDZvJWs
         NAqAyTifigsv1vgXbqd3xhmU8//9LwyhTmDaA+pY8WTABcVrPfxTkgC2jt4EDwU4x4Dz
         bksxj+vDE1hNJjSiJ32UFLItjzaZ01aCmFObIlcXtbRmA/cIo205hGDuqqLUNBW8cvGk
         jcLg==
X-Forwarded-Encrypted: i=1; AJvYcCX25u8cYaj442f2CGWfKsS+fqk3wizMya3NE78vbPcRiq1Qi/GFouQ3PC5XX42uQHgcFYFabsa6CqfLoCGYHg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxgp7hQYDi0o0O7RkgG43TSPWR0I1Ph0ohZLde50WBxPO9uYfiE
	6MWtNmw1LW07a7g4WzF7ZK9kLlIoWbrYGrH+npvR0i7l7+vbcdUwq8S1vx/0rfLfnV9Y67DAb9k
	Ue640fgBBlnXot0yeFLNJ3kFuxJHOisZXaFIp
X-Gm-Gg: ASbGncsWz8WjIzu6hwz+PNrI0r1l0SN3Z270M3y/kIPdE/Vn3pn9nezTJFtvdR8pkll
	xx5LWC0GBn2fhZ9vIfY/Mn7oQKpoxHgllSZ3ZEV8hOYUe81EIJM/E1woNYp4gCOdDa0hqz/NwcK
	VD604+NFZI6LKxJ/vJaTJl+Vgzu0wxylVwVubvIGTsPJw0cj8Cge0C
X-Google-Smtp-Source: AGHT+IHvMK0SV6VtztVj+YoeYQ5/i4hvqsncQiTOPb2g+BToFdj7TZ78J3grFAhStRy75jc6hEr26BgE749DHVAlZwc=
X-Received: by 2002:a17:902:ce08:b0:21f:3f5c:d24c with SMTP id
 d9443c01a7336-22db2089754mr282595ad.0.1745431171080; Wed, 23 Apr 2025
 10:59:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250423031117.907681-1-almasrymina@google.com>
 <20250423031117.907681-4-almasrymina@google.com> <m2y0vrtd5i.fsf@gmail.com>
In-Reply-To: <m2y0vrtd5i.fsf@gmail.com>
From: Mina Almasry <almasrymina@google.com>
Date: Wed, 23 Apr 2025 10:59:17 -0700
X-Gm-Features: ATxdqUHq-n2Ogx9j37-VJ8KU3c5QgjU5O-8PAbfORQ_YtioEYEuiwEUpYsuISUQ
Message-ID: <CAHS8izNUOO-X0WHFTMd3_yEjCDu4sPYADE1oDEtWTYFNNMB5wQ@mail.gmail.com>
Subject: Re: [PATCH net-next v10 3/9] net: devmem: TCP tx netlink api
To: Donald Hunter <donald.hunter@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, io-uring@vger.kernel.org, 
	virtualization@lists.linux.dev, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Jeroen de Borst <jeroendb@google.com>, 
	Harshitha Ramamurthy <hramamurthy@google.com>, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	Willem de Bruijn <willemb@google.com>, Jens Axboe <axboe@kernel.dk>, 
	Pavel Begunkov <asml.silence@gmail.com>, David Ahern <dsahern@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	Stefano Garzarella <sgarzare@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, sdf@fomichev.me, dw@davidwei.uk, 
	Jamal Hadi Salim <jhs@mojatatu.com>, Victor Nogueira <victor@mojatatu.com>, 
	Pedro Tammela <pctammela@mojatatu.com>, Samiullah Khawaja <skhawaja@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 23, 2025 at 5:11=E2=80=AFAM Donald Hunter <donald.hunter@gmail.=
com> wrote:
>
> Mina Almasry <almasrymina@google.com> writes:
>
> > From: Stanislav Fomichev <sdf@fomichev.me>
> >
> > Add bind-tx netlink call to attach dmabuf for TX; queue is not
> > required, only ifindex and dmabuf fd for attachment.
> >
> > Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
> > Signed-off-by: Mina Almasry <almasrymina@google.com>
> >
> > ---
> >
> > v3:
> > - Fix ynl-regen.sh error (Simon).
> >
> > ---
> >  Documentation/netlink/specs/netdev.yaml | 12 ++++++++++++
> >  include/uapi/linux/netdev.h             |  1 +
> >  net/core/netdev-genl-gen.c              | 13 +++++++++++++
> >  net/core/netdev-genl-gen.h              |  1 +
> >  net/core/netdev-genl.c                  |  6 ++++++
> >  tools/include/uapi/linux/netdev.h       |  1 +
> >  6 files changed, 34 insertions(+)
> >
> > diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/ne=
tlink/specs/netdev.yaml
> > index f5e0750ab71db..c0ef6d0d77865 100644
> > --- a/Documentation/netlink/specs/netdev.yaml
> > +++ b/Documentation/netlink/specs/netdev.yaml
> > @@ -743,6 +743,18 @@ operations:
> >              - defer-hard-irqs
> >              - gro-flush-timeout
> >              - irq-suspend-timeout
> > +    -
> > +      name: bind-tx
> > +      doc: Bind dmabuf to netdev for TX
>
> nit: maybe add "for RX" to the bind-rx doc.
>

Thanks, will pull this with the next iteration.

> > +      attribute-set: dmabuf
>
> The bind-rx op has "flags: [ admin-perm ]", should bind-tx also?
>

The omission of admin-perm for tx is intentional.

Binding a dmabuf to an rx queue should and is a privileged operation,
because basically the application doing the binding is taking
ownership of this rx queue. For TX, no such queue ownership is being
taken. The TX binding just gives the netdevice access to the dmabuf
dma-addresses so the netdevice can send from there. It's very similar
to a normal dma-map with normal memory. There is no need for privilege
checks.

--=20
Thanks,
Mina
