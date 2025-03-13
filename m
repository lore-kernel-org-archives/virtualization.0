Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65CA226739D
	for <virtualization@lists.linux.dev>; Thu, 13 Mar 2025 15:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741880296; cv=none; b=jLBDYAQMUx0/XGZeiAvru+ph3Pw4mybFIaGWEt7gUrxaXHThlCIZRgEEiBFAtO90KZ7/J5gqZhoz31xkkd6IEf+7jBLx/QOLpPODehGogBRz5ZD276RicOHatHo1HC3EK4T3IDi8hgFz5xZHBXYDv7+8u9zzU8SmJML9D+W+yCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741880296; c=relaxed/simple;
	bh=e0igfCTK9/hzb01DEL2PKJuifzTCiu9TjzJhL9w9tCo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e4LkVwp9X+nsRPJjlchRXEgr7BCPukMrVcT2Yg789dNieoyIDjGw19IuxFkXb2cQHJYnzDWTwZ22IO/K1v2N4uIIBhtFJLA7ZwYpcg3TqJGNILNMrRivqvg7JHuczbCdnbJ9/lKmVTY/WwbHdnLr/6X8kBIngWdMZukFxG7pPAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ly0YOpS4; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ly0YOpS4"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2240aad70f2so190705ad.0
        for <virtualization@lists.linux.dev>; Thu, 13 Mar 2025 08:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741880293; x=1742485093; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QjT6YyAXUn5VTwVWHShjFFHYQBmkQMKGYi0zBc0+AWA=;
        b=ly0YOpS4WyjoUR/vEvh+4QM9KysOucUCyiSU7rID1E8zu6JMhXfaCND9cIt0w8pRMI
         tgs13vFoOVL+mD9NgDaUTyZjtD3AVdkX27h2LoWaorKMwgduxzhJdOcED44ls4Ezsil1
         fGVRlx4juaz0leZifQcrSSBAu+Ol8R/v1FkuoFKKYRdApFDpa5Zm4idIaNCWVW8bVjal
         Sydpd6zGQ38qOE2Dl3Fp5DexsDMgqRwB6GU96u+gv8Cx7gEAH02iSfX5dLNOGo5oTbpF
         H6CKx6E9kMd10vmgQx1nZelnvWSiB6nZUwe1WHG+ECXqw4og1cuCFsSZEB+urAKBor71
         W8tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741880293; x=1742485093;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QjT6YyAXUn5VTwVWHShjFFHYQBmkQMKGYi0zBc0+AWA=;
        b=dV6gizfulGzZQKHrLNlNycGL89VweBcEGiww+xgjDXo4cng1r84HKKol6clXAkc/g/
         d39h7NrJ84sySSyXIZZk3igMRcbQ/zsGNPnIcAVcPQ9mRVlo2wpScObyGBnZGedLOb2m
         FGwHaXllHjGZiEpeJc87u0THgIJcMjiOBbOZdyII96WXOgIUglUQj5wFumZoY8Dm2IGl
         pZSf2UZ8Gi/ZG/OMXn31qSzvnAq2OyxhqB1CL9vllhJ5n6MPGMGpKI6epyBuuArewYan
         Z6c6vSWU6gPiRqiQs4VFj6MhOufZRdSo5tezIkzxhEu9XKLuTW9KWw5H/0X8uHkrtNLa
         qRYg==
X-Forwarded-Encrypted: i=1; AJvYcCXVmCuiicrw2N9nJKH/w3E2HegyFcZiUzgjkyEhK5dWN9oiRCNWfhV37/1ljDhXwsmrHz9utxQd81wl7bEXbg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzmQarBLi9upJM5GQVSt6PNLx9vrDS8O/UzXZF0iz+AvjIMCJ4n
	fUgqSZPDJfcBjyGe1N3wf4z1NwnlAc2A6QU7y7XjECGnuzaRLnVklakgV1S6Fak2uEUpkmuW0Ef
	7c47B8xI5TQm/pNHfOh0pQXrqi5zcCEjsHi3O
X-Gm-Gg: ASbGncspm4XgWOaGhmHAnbPGj4IsoJTdPf40HZCSdqjkTAVwBsTPpzXZllLYdvwBPap
	hLDQ8jCPl2qBMzsH5RBh5gtXkpcdmXvP43P4qwEUSUrOyqCzyfI/b25LKjbpugfIoZOSDsR8NDS
	mtxgG4/un7cNCvu5fCS8egNjFEVZQ=
X-Google-Smtp-Source: AGHT+IGJAXZPJwYtCYE1bwu7PfpLXhz2HdoG/Tco2Xx2kSrvJEpgKAwhhVDmJx6nzuZRXrJN0XJtv6Oed3xhRIh49X0=
X-Received: by 2002:a17:902:f549:b0:21f:631c:7fc9 with SMTP id
 d9443c01a7336-225c4cc8b48mr3034115ad.0.1741880292423; Thu, 13 Mar 2025
 08:38:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250308214045.1160445-1-almasrymina@google.com>
 <20250308214045.1160445-3-almasrymina@google.com> <87e8bde7-b05e-4a1b-bcef-f6bb3a12315a@redhat.com>
In-Reply-To: <87e8bde7-b05e-4a1b-bcef-f6bb3a12315a@redhat.com>
From: Mina Almasry <almasrymina@google.com>
Date: Thu, 13 Mar 2025 08:37:59 -0700
X-Gm-Features: AQ5f1Jph-1jzVMznweflaH2GTTsjHi97dpZrZmSTIYAsEqCVMDjRyvtUSvvjsmI
Message-ID: <CAHS8izPbWVXS9gPBbuR4EisT806+3woqD=njDHj8hNJLcDU4DA@mail.gmail.com>
Subject: Re: [PATCH net-next v7 2/9] net: add get_netmem/put_netmem support
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-kselftest@vger.kernel.org, 
	Donald Hunter <donald.hunter@gmail.com>, Jakub Kicinski <kuba@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Jeroen de Borst <jeroendb@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Willem de Bruijn <willemb@google.com>, David Ahern <dsahern@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	Stefano Garzarella <sgarzare@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, sdf@fomichev.me, asml.silence@gmail.com, dw@davidwei.uk, 
	Jamal Hadi Salim <jhs@mojatatu.com>, Victor Nogueira <victor@mojatatu.com>, 
	Pedro Tammela <pctammela@mojatatu.com>, Samiullah Khawaja <skhawaja@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 13, 2025 at 3:47=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On 3/8/25 10:40 PM, Mina Almasry wrote:
> > Currently net_iovs support only pp ref counts, and do not support a
> > page ref equivalent.
> >
> > This is fine for the RX path as net_iovs are used exclusively with the
> > pp and only pp refcounting is needed there. The TX path however does no=
t
> > use pp ref counts, thus, support for get_page/put_page equivalent is
> > needed for netmem.
> >
> > Support get_netmem/put_netmem. Check the type of the netmem before
> > passing it to page or net_iov specific code to obtain a page ref
> > equivalent.
> >
> > For dmabuf net_iovs, we obtain a ref on the underlying binding. This
> > ensures the entire binding doesn't disappear until all the net_iovs hav=
e
> > been put_netmem'ed. We do not need to track the refcount of individual
> > dmabuf net_iovs as we don't allocate/free them from a pool similar to
> > what the buddy allocator does for pages.
> >
> > This code is written to be extensible by other net_iov implementers.
> > get_netmem/put_netmem will check the type of the netmem and route it to
> > the correct helper:
> >
> > pages -> [get|put]_page()
> > dmabuf net_iovs -> net_devmem_[get|put]_net_iov()
> > new net_iovs ->       new helpers
> >
> > Signed-off-by: Mina Almasry <almasrymina@google.com>
> > Acked-by: Stanislav Fomichev <sdf@fomichev.me>
> >
> > ---
> >
> > v5: https://lore.kernel.org/netdev/20250227041209.2031104-2-almasrymina=
@google.com/
> >
> > - Updated to check that the net_iov is devmem before calling
> >   net_devmem_put_net_iov().
> >
> > - Jakub requested that callers of __skb_frag_ref()/skb_page_unref be
> >   inspected to make sure that they generate / anticipate skbs with the
> >   correct pp_recycle and unreadable setting:
> >
> > skb_page_unref
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > - callers that are unreachable for unreadable skbs:
> >
> > gro_pull_from_frag0, skb_copy_ubufs, __pskb_pull_tail
>
> Why `__pskb_pull_tail` is not reachable? it's called by __pskb_trim(),
> via skb_condense().
>

I meant to say "the skb_page_unref call from __skb_pull_tail is not
reachable for unreadable skbs". This is because __skb_pull_tail early
returns on unreadable skbs.

--=20
Thanks,
Mina
