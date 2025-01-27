Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F9E31DB365
	for <virtualization@lists.linux.dev>; Mon, 27 Jan 2025 22:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738018373; cv=none; b=BXDVVVVo8U6pCAwz7GB4iObEycc2+z2Pd3zDUuujuIYY5GBs8kJQBDXMoi4YzSG5tWaO0j5oNYr65df+IyyvoZ/ZKQH+x9Ndaut0xNJLjFdO2ZAuVf6wJSQ6c+iVYiUSJZKb1EuUcyl9JXlVuwi8PycOaK3p6KmR0ogwQLxYON8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738018373; c=relaxed/simple;
	bh=68yT7ctj8bEjZRs1enf6Riz6YgvO2oWyLb6AjHmiCg8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ghfvgxIlM1X74EJVECRx2wmhHiZ80o2pfLk7vTEJvdlwxPn9itUckYqG2dhf97jhTuKqh13cYYHP3/hj4jFHiSx/WsdV9aQX2+q80ObwMBR7xwMG7WSQqzDuoCoqUNGXFrp3+ZIpCnvOJ2PsDxu+chu5L8EtxclxHh9cKcLC7kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AyewJQhF; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AyewJQhF"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2163affd184so19495ad.1
        for <virtualization@lists.linux.dev>; Mon, 27 Jan 2025 14:52:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738018370; x=1738623170; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dt046zC8q+cHCBSEV8Sb8uhTY9mqKP4r1voWC0exUjg=;
        b=AyewJQhF59uKGwbq8X3uiHhhHlP90ZOtP6ce3ZVnnf1bci8aiyBMFgyz1LoH2TPluG
         iM/bLh1EJYD/q8RfI1ZqBCGaWsN+M1hjpyGpuX06zTw0frOUQyQuolSS4AbwjbmhX/bw
         RSgb4p+e09B5/rDUUc6xXMwzyLd9m936RIvshqw3Zpc2pnneo+n0pOoiJlae90S+ENPa
         B/X2ZF8PIk6APNIwHwI8J3FEu5GgFiDoHMEfavpvm1rE9vd6M5K1M1AfxXZ6lj1+DkW0
         5jyXkOtvr1qMIqgLu1lLatmo8k9RFTDX2CCAsdZnSm8W7BubFfsUOzVFfgrn860zDv7V
         a3Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738018370; x=1738623170;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dt046zC8q+cHCBSEV8Sb8uhTY9mqKP4r1voWC0exUjg=;
        b=osPNH556P1rNnm/s6Rng5QKi3XMIZ8V9skLW4klaIAPi0l5UjQ5xzSC7GfBYCma/af
         B843n5Czy4xtYOL65VI61Aj59DEJi+sYeM+gtib0McsraLovZXeyCa6IPAqGpF771n6s
         4dM8hwyKPSVuBoWOcXGerHcKwL7ySHuS0yzJEk9AF69TXbELQpRqwo78njKz/5/HlK8l
         Y80qZY4mlpOVP+Dvn5wkV5dVkYuIfouuzwGnwracZP6O6o7uZ6I/++SzHVtC8xWYI021
         jVgzxHVW+AxmvyswpzLQQLS4X3ShTDZj8wqxTKJRzpiIdk/NAPj2HMMrX0lbQux+eMHw
         cl0Q==
X-Forwarded-Encrypted: i=1; AJvYcCW2gd8h6WHa3ndxOlsNQOY79z32hN+n7ofVrN2X1YJUHSHfgrj02VIKah9z6LH1Ylk1dx0gUtW3CG0TliTPdQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx0knaydyYt4kJPR5vPRrHBv1HmyMHMS2yP8A7QUeBXAsx17vTr
	57QTRHGh81onLTDLHy7jGUIjOrz6Nx8knqGfagCA43BRByQNxORubD7Dlfvk5UR8ncqS+jY5E4d
	iATjiFQmemrnB12QbUu+YR7DIoGUztHWH6oWf
X-Gm-Gg: ASbGncuScoaUzC9vG+Yj+I0b0rkXJLllbkRjEXmZz164FsWK5pcoZKONUSClZeDsYNf
	OsLvkUkxPhNF8gvY/p7iWR2X8B8X3IZfJK+FfER4HUADb+WMHtKUU+HqPc3YHEGKAOzu7gNz97R
	GVQzOjA1aErRlffOOk4d05dgdbc0E=
X-Google-Smtp-Source: AGHT+IGnMwtsrtnKydiBNAxNPRr5z5y9ziqP6BqEtfZ64TIOYQJqCWiD2gAFKLfpOjZiYf94dEFeLv3VKxqstm1f4LE=
X-Received: by 2002:a17:902:f611:b0:215:44af:313b with SMTP id
 d9443c01a7336-21dccd2833dmr925035ad.0.1738018370394; Mon, 27 Jan 2025
 14:52:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241221004236.2629280-1-almasrymina@google.com>
 <20241221004236.2629280-6-almasrymina@google.com> <Z2ZNlGCbQXMondI7@mini-arch>
 <Z22qCznFSWWyjyyq@mini-arch>
In-Reply-To: <Z22qCznFSWWyjyyq@mini-arch>
From: Mina Almasry <almasrymina@google.com>
Date: Mon, 27 Jan 2025 14:52:36 -0800
X-Gm-Features: AWEUYZnm6s4cike1pxqq6gw1uBcZE5P6ce8F2RNXnwtoS-1NKohoiPC1TO6Djb0
Message-ID: <CAHS8izNQYj4z-8vjMk8ttv85Q0HbdTrguLZewUt=4K8+5=6g_g@mail.gmail.com>
Subject: Re: [PATCH RFC net-next v1 5/5] net: devmem: Implement TX path
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, virtualization@lists.linux.dev, 
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Donald Hunter <donald.hunter@gmail.com>, Jonathan Corbet <corbet@lwn.net>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, David Ahern <dsahern@kernel.org>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Kaiyuan Zhang <kaiyuanz@google.com>, Pavel Begunkov <asml.silence@gmail.com>, 
	Willem de Bruijn <willemb@google.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Joe Damato <jdamato@fastly.com>, dw@davidwei.uk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 26, 2024 at 11:10=E2=80=AFAM Stanislav Fomichev
<stfomichev@gmail.com> wrote:
>
> On 12/20, Stanislav Fomichev wrote:
> > On 12/21, Mina Almasry wrote:
> > >  void netdev_nl_sock_priv_init(struct list_head *priv)
> > > diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> > > index 815245d5c36b..eb6b41a32524 100644
> > > --- a/net/core/skbuff.c
> > > +++ b/net/core/skbuff.c
> > > @@ -1882,8 +1882,10 @@ EXPORT_SYMBOL_GPL(msg_zerocopy_ubuf_ops);
> > >
> > >  int skb_zerocopy_iter_stream(struct sock *sk, struct sk_buff *skb,
> > >                          struct msghdr *msg, int len,
> > > -                        struct ubuf_info *uarg)
> > > +                        struct ubuf_info *uarg,
> > > +                        struct net_devmem_dmabuf_binding *binding)
> > >  {
> > > +   struct iov_iter *from =3D binding ? &binding->tx_iter : &msg->msg=
_iter;
> >
> > For tx, I feel like this needs a copy of binding->tx_iter:
> >
> >       struct iov_iter tx_iter =3D binding->tx_iter;
> >       struct iov_iter *from =3D binding ? &tx_iter : &msg->msg_iter;
> >
> > Or something similar (rewind?). The tx_iter is advanced in
> > zerocopy_fill_skb_from_devmem but never reset back it seems (or I'm
> > missing something). In you case, if you call sendmsg twice with the sam=
e
> > offset, the second one will copy from 2*offset.
>
> Can confirm that it's broken. We should probably have a mode in ncdevmem
> to call sendmsg with the fixed sized chunks, something like this:
>

Thanks for catching. Yes, I've been able to repro and I believe I
fixed it locally and will include a fix with the next iteration.

I also agree using a binding->tx_iter here is not necessary, and it
makes the code a bit confusing as there is an iteration in msg and
another one in binding and we have to be careful which to
advance/revert etc. I've prototyped implementation without
binding->tx_iter with help from your series on github and seems to
work fine in my tests.

> @@ -912,7 +916,11 @@ static int do_client(struct memory_buffer *mem)
>                                 line_size, off);
>
>                         iov.iov_base =3D NULL;
> -                       iov.iov_len =3D line_size;
> +                       iov.iov_len =3D line_size <=3D 4096 ?: 4096;
>
>                         msg.msg_iov =3D &iov;
>                         msg.msg_iovlen =3D 1;
> @@ -933,6 +941,8 @@ static int do_client(struct memory_buffer *mem)
>                         ret =3D sendmsg(socket_fd, &msg, MSG_ZEROCOPY);
>                         if (ret < 0)
>                                 error(1, errno, "Failed sendmsg");
> +                       if (ret =3D=3D 0)
> +                               break;
>
>                         fprintf(stderr, "sendmsg_ret=3D%d\n", ret);
>
> I can put it on my todo to extend the selftests..

FWIW I've been able to repro this and extended the tests to catch
this; those changes should come with the next iteration.

--=20
Thanks,
Mina
