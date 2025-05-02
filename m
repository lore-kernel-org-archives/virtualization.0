Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59F021F152D
	for <virtualization@lists.linux.dev>; Fri,  2 May 2025 19:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746213940; cv=none; b=fCZeCTb7jbBF5fSJ4nBUbptW7FV7NGkvGkIh5nbjgJPzn9bnpsOwNjgRAGuPcbDeYNJlLWHIpyXwwX7xg3O/tyxxR7QG1OozFc4ZOxn5GAMnOhEbKWhuJw/LBg8/cL/ICX/PhfRqW0kdGx/WbhkZBhYcXAuX6zbVUuxWwHXyNno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746213940; c=relaxed/simple;
	bh=ZOraj867pk/cuv9sGYnTnO1GOcFc4HnKNvgp4QcVTF8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TpI4RFwXAotCefme1TU8o+2NjlMnSIsOyLqeRBUnxyn4blQ+1EysPp6WNcoVNpLUWD85dieyFd2M6nqo4W3NeZqwjf2Z2tPzReQ3cjiNkPosxpqKcB99L/rE3I366I7KAWyoAOVsKqeTZ9O0rA1zJP2Ft1Gix+hYGnwMq4ttUNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uR/QIwCi; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uR/QIwCi"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2264c9d0295so31845ad.0
        for <virtualization@lists.linux.dev>; Fri, 02 May 2025 12:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746213937; x=1746818737; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZOraj867pk/cuv9sGYnTnO1GOcFc4HnKNvgp4QcVTF8=;
        b=uR/QIwCixGJL33LL5O1tWqAk8zTPQ2ZQ4JNlgsSGyi7BzgslNXfa1Sw8LQgwj02xIF
         iESuG/nWT4pe0qZy/uvodmtwH7A/ukqkVh0tqxQqCn+VnmRXdOl5WCJhSaL1xKcmZuDX
         RPviBjnzmn1mlRAphprgP/pB9tyeowpp9UtyYexz1mlOBDbFXWGp6qp4LmjbPafQDhjW
         f7t0h6D0zIpbPGiElfTjAK46GasH+CVS1z242ymlkE2bs538f4FmWS1+bZOCi7+GfIyo
         pev6wPIYLdC+0gCj2c4++iaWkiL80Qbn8asWoJ3W8IrdebcsQsRMqojoT+uU+Y79rQdv
         wkeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746213937; x=1746818737;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZOraj867pk/cuv9sGYnTnO1GOcFc4HnKNvgp4QcVTF8=;
        b=NTG8rs3EZctHKzNLM5csPkke7LPdqtmLUzmvnwO/MXfQFHpv4d0wxuNA1ezJfY5PkJ
         QOr6Q4E/xWfb94KDduzMYAPpljD5OfpMDoIXfeHxU8Zg8s7B9r1WA5WbIlI6h9ASN1Qf
         Ni3hcysJfXicyn5EJw4TG98qONCMaefn1OBA1Lisz52rPpdXvwTBjf72hDaRAIdwstnY
         gK/p1NdWOQAU0b3sjUulGdpmtuq+ZdGIUFVfKYQ+E024gjRvStpBu4N41TusuqyY43Iy
         MT0XOXnuPzhrPMebk8NoAqGjTREwRbszfI55nGZG5JTyl+b3NAoMws8AzpEVO7Naf1E9
         SqLg==
X-Forwarded-Encrypted: i=1; AJvYcCXLWgOODjkHiXFATiF+VBo/olSrMmHqolhb72CiCe2HEScpAMp3Bzcya1PBj4cGhpjf+KW0FtPuWOwUEYjSnA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz4fy5h5/i69oEmkj42axJ+523OsshkvM7p4qINEraVrqeOMHyb
	V5PjcU64AeTSbHvIc0XZe/itC8za0yN6zkiL0eguirG/F28h7FekS/7CX18ioRjFbdVwkqQ1Lx/
	qNeDfgS9Scp/5UnBP//5rUF738TRs/jPi8qEq
X-Gm-Gg: ASbGnct+tyrZkWgRELkdMu3duBjLau8RzLFrDKSg+rxbrXLr9xQNDltMvkGv7RiERHN
	9kxwBdAyLN6Y3rf07EN+sINmBpttjOzCVD5LXul1nTqEXqxO8G6oDmGVI95rt4ik17xD/UWVjCy
	xw7ieEuzYlHAhmgqxpzMsoMsfMNoggdBqdSg==
X-Google-Smtp-Source: AGHT+IHUOjgBbVOP8EhCotYEtz1xj8om994DHh63iGGlYgne8/oHskra7BjgsemS01jDY9TsbdDObHSsJ810l2GltBI=
X-Received: by 2002:a17:902:ce07:b0:21f:4986:c7d5 with SMTP id
 d9443c01a7336-22e18a3edccmr455755ad.8.1746213937102; Fri, 02 May 2025
 12:25:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250429032645.363766-1-almasrymina@google.com>
 <20250429032645.363766-5-almasrymina@google.com> <53433089-7beb-46cf-ae8a-6c58cd909e31@redhat.com>
 <fd7f21d9-3f45-4f68-85cb-dd160a0a95ca@redhat.com>
In-Reply-To: <fd7f21d9-3f45-4f68-85cb-dd160a0a95ca@redhat.com>
From: Mina Almasry <almasrymina@google.com>
Date: Fri, 2 May 2025 12:25:23 -0700
X-Gm-Features: ATxdqUFE7sBpQ0aEoZkfu-r1bro_WuWZDP8nLd_pOK-7HB7CvYHcAcfjkOn9v8E
Message-ID: <CAHS8izPr_yt+PtG5Q++Ub=D4J=H7nP0S_7rOP9G7W=i2Zeau3g@mail.gmail.com>
Subject: Re: [PATCH net-next v13 4/9] net: devmem: Implement TX path
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, io-uring@vger.kernel.org, 
	virtualization@lists.linux.dev, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, 
	Donald Hunter <donald.hunter@gmail.com>, Jonathan Corbet <corbet@lwn.net>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Jeroen de Borst <jeroendb@google.com>, 
	Harshitha Ramamurthy <hramamurthy@google.com>, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	Willem de Bruijn <willemb@google.com>, Jens Axboe <axboe@kernel.dk>, 
	Pavel Begunkov <asml.silence@gmail.com>, David Ahern <dsahern@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	sdf@fomichev.me, dw@davidwei.uk, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Victor Nogueira <victor@mojatatu.com>, Pedro Tammela <pctammela@mojatatu.com>, 
	Samiullah Khawaja <skhawaja@google.com>, Kaiyuan Zhang <kaiyuanz@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 2, 2025 at 4:51=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wrot=
e:
>
> On 5/2/25 1:47 PM, Paolo Abeni wrote:
> > On 4/29/25 5:26 AM, Mina Almasry wrote:
> >> Augment dmabuf binding to be able to handle TX. Additional to all the =
RX
> >> binding, we also create tx_vec needed for the TX path.
> >>
> >> Provide API for sendmsg to be able to send dmabufs bound to this devic=
e:
> >>
> >> - Provide a new dmabuf_tx_cmsg which includes the dmabuf to send from.
> >> - MSG_ZEROCOPY with SCM_DEVMEM_DMABUF cmsg indicates send from dma-buf=
.
> >>
> >> Devmem is uncopyable, so piggyback off the existing MSG_ZEROCOPY
> >> implementation, while disabling instances where MSG_ZEROCOPY falls bac=
k
> >> to copying.
> >>
> >> We additionally pipe the binding down to the new
> >> zerocopy_fill_skb_from_devmem which fills a TX skb with net_iov netmem=
s
> >> instead of the traditional page netmems.
> >>
> >> We also special case skb_frag_dma_map to return the dma-address of the=
se
> >> dmabuf net_iovs instead of attempting to map pages.
> >>
> >> The TX path may release the dmabuf in a context where we cannot wait.
> >> This happens when the user unbinds a TX dmabuf while there are still
> >> references to its netmems in the TX path. In that case, the netmems wi=
ll
> >> be put_netmem'd from a context where we can't unmap the dmabuf, Resolv=
e
> >> this by making __net_devmem_dmabuf_binding_free schedule_work'd.
> >>
> >> Based on work by Stanislav Fomichev <sdf@fomichev.me>. A lot of the me=
at
> >> of the implementation came from devmem TCP RFC v1[1], which included t=
he
> >> TX path, but Stan did all the rebasing on top of netmem/net_iov.
> >>
> >> Cc: Stanislav Fomichev <sdf@fomichev.me>
> >> Signed-off-by: Kaiyuan Zhang <kaiyuanz@google.com>
> >> Signed-off-by: Mina Almasry <almasrymina@google.com>
> >> Acked-by: Stanislav Fomichev <sdf@fomichev.me>
> >
> > I'm sorry for the late feedback. A bunch of things I did not notice
> > before...
>
> The rest LGTM,

Does this imply I should attach your Reviewed-by or Acked-by on follow
up submissions if any? I'm happy either way, just checking.

> and my feedback here ranges from nit to corner-cases, so
> we are probably better off with a follow-up than with a repost, other
> opinions welcome!
>

Agreed a follow-up is better, but up to you and other maintainers.
There is some mounting urgency on my side (we're in the process of
optimistical backports and migrating the devmem TCP userspace that we
previously open sourced to the upstream UAPI), but we'll oblige either
way.

--=20
Thanks,
Mina
