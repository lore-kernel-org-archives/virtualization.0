Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFFEA1A23A9
	for <virtualization@lists.linux.dev>; Tue, 25 Feb 2025 18:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740509694; cv=none; b=QR7a8Fri/xHDiOw4Vn8lNZDQ5Ju3RQ07iqjGUvuJ9hZfS3a0lIbgGyV+OKWYNWduPGPkdx62+Z2s+Trphe3ScZw+p7Qiwu8F40MXAAKeJ3pxrGDwYuwGQ6thmDVhN7QnpwRA6Uo647t6e1md0NAvFyjh6GtGAf5Ks7iRClK/Azs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740509694; c=relaxed/simple;
	bh=5o8pizoxvzVoSdZd/O+cZXmZb2Ptzgx/7TJMpQErk40=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M3Il40CAxzqys8Oz2pS4X3DSwX1SwZabXRoByXYkjyZ6/6G4a6XgbRJlzKOJLG3DKkyG03EeyQcJznstx1SzLx8J7rsvl2l/P0zC9LEH8QLsG5PMG47yjIf4cwMeOSownM9IQUFdobOOXSz775xzBdyPEPqqITlNGpgpj7lf1Bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OYcMIwdp; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OYcMIwdp"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2212222d4cdso13955ad.0
        for <virtualization@lists.linux.dev>; Tue, 25 Feb 2025 10:54:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740509692; x=1741114492; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uMCXizc35EGrmaC85T0NiBuwZkt8Yhq5EnmRBkHr9ig=;
        b=OYcMIwdp2cO/KvYdQ3KgyFim25nqnv0TB21Vt4cOYxoqYiDY2OPSofHkPadZcmIzfB
         gxV9cz9gwl01FFmIw5x0nJVkHBKmdblu27xfZPiD4IcP+6sFUxxa1X/6zU/HG+8BnCX4
         7Zc9MjYi1wzRzMIPYyVpLeI6OxXqbPWCxFdlVn1yCn5e61oNgrgvzZXQM2Sujud8qANM
         F2/m0RH0uutf2ryNHnLjCbUAocuq8uv3X+rzxxp/nJwj3xdat0KsS8u66OhgQMlzYzix
         E6C0vH1vfacRygl2hXBk+5uBKcuZvOd2EG9L/EgdWT5XKXGm02kjjcCeG8RZV7jsMvgj
         r/+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740509692; x=1741114492;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uMCXizc35EGrmaC85T0NiBuwZkt8Yhq5EnmRBkHr9ig=;
        b=szqgKNtUwXM9o+rttGRyEUj3YuiaZdDDVGSyTPx/F70wC+RptT6TY6fCJlDbtMmMT2
         H520bV9TPCiM7Aho2OwirIHYo4pmcvNZNOsUZd9iY+nJKn+4pRuQfDsAMD3TJ6pcW7M4
         0TuZbcDKkRgGelvXofHMZn+ylHB/792irFxidKdrVMgy6SZSXBx3YtnzuPaj0GeAxsJE
         ZraV4ciUElhkAG8114ONh/rRv4aHbV/pSN4UQKKqjeHHOLqEjH5N7N50+WY0qmSwLnkY
         1tVUJGmldaAYF9QvAu8KeG80Of3gvBz29i30iUVCyAUx936T14Ng9Lo39CnbmhSfxxW9
         DdBA==
X-Forwarded-Encrypted: i=1; AJvYcCUkkbKSFRthRLIaUVh2aky1EUzd/uA36tcZHtWxMZBmsvm77eM8URSBIT15CjbV1eO9xJpLWVvV1Fd3B2EIGg==@lists.linux.dev
X-Gm-Message-State: AOJu0YweyK5YNHXGBRVst0PGD5h0O1Oyjg9N63VoUqtivQVWh70vrqKt
	SukKXtJjSRiD+AuW2M7RNaScJoySdp155U26LqxjPVidjl+DkuQstmIXi3JXCF1eA9QsYRn2fhY
	z1cE1Xm+mIBz7ssoZ+eYexHzYPwcKjRfLixIV
X-Gm-Gg: ASbGncvDkPRBBaNXPf3nIuSj0M+1qAamzA/Lb2L74rFnY2ZTgRrTr9ytmkkieEYlbYJ
	/GxmYbNjPGOs9llrg2BzVNGoW7mkzIqoFtfGFg3WNQF9ebxwu14wFuv5tw3gpux6Z+JeIBwVdzj
	+PE0SlhcnCIzUgPlqcd7mvzC3SjziA7gKZW6Tw
X-Google-Smtp-Source: AGHT+IHKtkzfqoDq/aFKOFQr1ERgcAbcEK4IFsBn5K00z2a2QK3glh0MNqMaWd3X+U0cJKGz5XG2Nx9VjUfKKSOn5L8=
X-Received: by 2002:a17:903:32c8:b0:21f:3f5c:d24c with SMTP id
 d9443c01a7336-22307990990mr4177415ad.0.1740509691634; Tue, 25 Feb 2025
 10:54:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250222191517.743530-1-almasrymina@google.com>
 <20250222191517.743530-4-almasrymina@google.com> <a814c41a-40f9-4632-a5bb-ad3da5911fb6@redhat.com>
 <CAHS8izNfNJLrMtdR0je3DsXDAvP2Hs8HfKf5Jq7_kQJsVUbrzg@mail.gmail.com> <a003b144-0abf-4274-abff-a6e391a3e20b@kernel.org>
In-Reply-To: <a003b144-0abf-4274-abff-a6e391a3e20b@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Tue, 25 Feb 2025 10:54:39 -0800
X-Gm-Features: AWEUYZm9ddJufTmC5t011zUcER-Yc8Z8hhKJRb2CSFMpmWrFXAHePyW-LPIzaHw
Message-ID: <CAHS8izMc0NCMPvCGg-uAOeWaf+K-_EfHnK7+4i205dPUy9JBFA@mail.gmail.com>
Subject: Re: [PATCH net-next v5 3/9] net: devmem: Implement TX path
To: David Ahern <dsahern@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, virtualization@lists.linux.dev, 
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Donald Hunter <donald.hunter@gmail.com>, Jakub Kicinski <kuba@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Jeroen de Borst <jeroendb@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Willem de Bruijn <willemb@google.com>, 
	Neal Cardwell <ncardwell@google.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	Stefano Garzarella <sgarzare@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, sdf@fomichev.me, asml.silence@gmail.com, dw@davidwei.uk, 
	Jamal Hadi Salim <jhs@mojatatu.com>, Victor Nogueira <victor@mojatatu.com>, 
	Pedro Tammela <pctammela@mojatatu.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Kaiyuan Zhang <kaiyuanz@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 25, 2025 at 10:03=E2=80=AFAM David Ahern <dsahern@kernel.org> w=
rote:
>
> On 2/25/25 10:41 AM, Mina Almasry wrote:
> > On Tue, Feb 25, 2025 at 5:04=E2=80=AFAM Paolo Abeni <pabeni@redhat.com>=
 wrote:
> >>
> >> On 2/22/25 8:15 PM, Mina Almasry wrote:
> >> [...]
> >>> @@ -119,6 +122,13 @@ void net_devmem_unbind_dmabuf(struct net_devmem_=
dmabuf_binding *binding)
> >>>       unsigned long xa_idx;
> >>>       unsigned int rxq_idx;
> >>>
> >>> +     xa_erase(&net_devmem_dmabuf_bindings, binding->id);
> >>> +
> >>> +     /* Ensure no tx net_devmem_lookup_dmabuf() are in flight after =
the
> >>> +      * erase.
> >>> +      */
> >>> +     synchronize_net();
> >>
> >> Is the above statement always true? can the dmabuf being stuck in some
> >> qdisc? or even some local socket due to redirect?
> >>
> >
> > Yes, we could have have netmems in the TX path in the qdisc or waiting
> > for retransmits that still have references to the dmabuf, and that's
> > fine here I think.
>
> skbs with references to netmem from a dmabuf can get stuck in retransmit
> queues for a long time. The comment should at least acknowledge that.
>

Will do, although I think maybe I'll add that comment above the
refcount_t definition in net_devmem_dmabuf_binding, if that's OK with
you. That was meant to explain how the refcounting on the binding
works.

Maybe worthy of note, this is not that new, in fact something similar
is happening in the RX path. In the RX path each skb waiting in the
receive queue to be recvmsg()'d will hold a reference on the
underlying page_pool, which in-turn holds a reference on the
underlying dmabuf. It's just that a similar thing is happening in the
TX path.

--=20
Thanks,
Mina
