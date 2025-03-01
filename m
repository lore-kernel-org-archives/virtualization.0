Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1CA21805E
	for <virtualization@lists.linux.dev>; Sat,  1 Mar 2025 01:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740792569; cv=none; b=fSpVWILITXSBAeI1pOq1gKhbRfs7MP6tx5WnFIK7ATx8Zn0dzUyijaLjWoQ9NlXn0nNQRePdmSIa3tiMLeeH65fp6pWjsbcVRV0YhxsC9+ID8cKd5zk9toJx3qDr6jwOjPZqW8ujEFp73bo/8EdcfXR3lxowq2f7mkOYeVA2zrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740792569; c=relaxed/simple;
	bh=x30Ghtnf2mwjQ7C24lb6dNTXdFIuMS5fxSzqclDeaDU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RcQDygfnl9/oMHxq7E42se/SEN2Z8czaJka7F/wBIqlxDO0q9YXRqGnRcK2R95hpQR+Y1Hn0ecwUnBvs/VPxbYszAmFVhVZQgh6UJ1QU6HBJJ+EJKxGfqqFvAIpXEjsIAualnXs2AhOEHGKLKMVfk+hFVyeM9woq3c6sBEDb0JU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=f04mQz8I; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f04mQz8I"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2237a32c03aso37875ad.1
        for <virtualization@lists.linux.dev>; Fri, 28 Feb 2025 17:29:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740792567; x=1741397367; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kc38nFBS6hSU0vji9D+YzzpAjSlnqZ5qJGUo2AO471s=;
        b=f04mQz8IIgi4vCbhR5ewKZX3fsHs6fhql16s+zQe5yLGStCUYYzOvFkX+5lheY7KpW
         pZlSkMZEzVt/is4Gi/p1Gdt0wGGf7iN6+t1tqT8eVHvU0tohz1e5+0iJ0i7FWEKuzqRO
         HczrFQLL/2+7tb7YNjb1UrBzyQTLuxfcMgIXPLLm/y5vOczaD8pzJS/Id+/BJsi2A+yV
         uKOm11q0HPk/KteDsVovTNbRPYP62S4pEyFkboWg56kuS04745G9usu0SlbE/STTLDec
         0bJbxefSQpt8X2tn9cgSacAufmcwA5TVuNti8PZD8EyfV+iaEa3hYYkb1+FNnEZbP2La
         hBmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740792567; x=1741397367;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kc38nFBS6hSU0vji9D+YzzpAjSlnqZ5qJGUo2AO471s=;
        b=MnSzU9sO2hHBPzMQi0q6SjjFN7I+7H+zM/ll/VLjTBFPdvqInFEWwFxCX86146Eos9
         g3u/6YiUr8N67TuCtHx6YRgnrWsWuDHIyLdL0TFMwA5peElQD7RSpJB5ujN9kT38/4Wu
         vpnBGK/GlwoNVLaIcDf+m8TwrEb46Eb1euLCldvPUQNOf54IH/rGk3ElodYUvr3bZ222
         hdr58q0VWTYDoKrB9Ak9yFFRhV0IEE03YBdqYCRXpvdKEr4rvF1HUYdioVizowchOkmh
         B2w3KEwCvxpsSc6F/6hUTYqTH+R/9epcrAB/XmPqV+AHG5X31rg+GrJmcNeHHdomjlHW
         ommg==
X-Forwarded-Encrypted: i=1; AJvYcCUWXo1gczLSCnXvtHln42Df3kq4inqSIuHNFRVbKvw1Giqel1IXsnd7BbrSUJ4E2g7dwdbw5HbaAvfgxD1lgg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyAZMrZdFoJWUflkNFbcI/PGBZvKga960Tmcj9HxPfaEM3oBLcJ
	dWFoBq0f5F5VFE8LCcVr71bN1garLahjJ+EbATYeyeJCSS6A1x6z/Uj9dJ3hwEcGAUCljQ6Tvsw
	rIY2ySlGsFk61lDHJeTTk7gvaserxnTUw9Lu9
X-Gm-Gg: ASbGncsxQK6o4/h9LOnHIgW8AseBSP2rRx4qkRO9gNl/kyZfRN5wOhQ/2OLto+Z7lMC
	kp5k2pIGWzZ+7gOuRp0oCJWrCONxSWmBuf/+Wxust63UI4u49QABSp7a2bH5acg28KH/N5MBBNH
	I3SYQ++4Q9UyRELoZcfJcysOuZQg==
X-Google-Smtp-Source: AGHT+IGncPbBhrhz7q7nYtSkG3NCU3eJmen24UIv0X8fbRWFxDMMC/F2mnfn4/23C53PdlyFhZfhFGySOLAkJbQVaoI=
X-Received: by 2002:a17:902:ccca:b0:220:c905:689f with SMTP id
 d9443c01a7336-22385a2665emr571665ad.25.1740792566772; Fri, 28 Feb 2025
 17:29:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250227041209.2031104-1-almasrymina@google.com>
 <20250227041209.2031104-2-almasrymina@google.com> <20250228163846.0a59fb40@kernel.org>
In-Reply-To: <20250228163846.0a59fb40@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Fri, 28 Feb 2025 17:29:13 -0800
X-Gm-Features: AQ5f1JqnucwSW-6yoUTgklaGGj9zlmp1rtei3-w0QbA66_zGizdQVdrhRtrAPr0
Message-ID: <CAHS8izNQnTW7sad_oABtxhy3cHxGR0FWJucrHTSVX7ZAA6jT3Q@mail.gmail.com>
Subject: Re: [PATCH net-next v6 1/8] net: add get_netmem/put_netmem support
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-kselftest@vger.kernel.org, 
	Donald Hunter <donald.hunter@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Jeroen de Borst <jeroendb@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Willem de Bruijn <willemb@google.com>, David Ahern <dsahern@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	sdf@fomichev.me, asml.silence@gmail.com, dw@davidwei.uk, 
	Jamal Hadi Salim <jhs@mojatatu.com>, Victor Nogueira <victor@mojatatu.com>, 
	Pedro Tammela <pctammela@mojatatu.com>, Samiullah Khawaja <skhawaja@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 28, 2025 at 4:38=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Thu, 27 Feb 2025 04:12:02 +0000 Mina Almasry wrote:
> >  static inline void __skb_frag_ref(skb_frag_t *frag)
> >  {
> > -     get_page(skb_frag_page(frag));
> > +     get_netmem(skb_frag_netmem(frag));
> >  }
>
> Silently handling types of memory the caller may not be expecting
> always worries me.

Sorry, I'm not following. What caller is not expecting netmem? Here
we're making sure __skb_frag_ref() handles netmem correctly, i.e. we
were not expecting netmem here before, and after this patch we'll
handle it correctly.

> Why do we need this?
>

The MSG_ZEROCOPY TX path takes a page reference on the passed memory
in zerocopy_fill_skb_from_iter() that kfree_skb() later drops when the
skb is sent. We need an equivalent for netmem, which only supports pp
refs today. This is my attempt at implementing a page_ref equivalent
to net_iov and generic netmem.

I think __skb_frag_[un]ref is used elsewhere in the TX path too,
tcp_mtu_probe for example calls skb_frag_ref eventually.

> In general, I'm surprised by the lack of bug reports for devmem.

I guess we did a good job making sure we don't regress the page paths.

The lack of support in any driver that qemu will run is an issue. I
wonder if also the fact that devmem needs some setup is also an issue.
We need headersplit enabled, udmabuf created, netlink API bound, and
then a connection referring to created and we don't support loopback.
I think maybe it all may make it difficult for syzbot to repro. I've
had it on my todo list to investigate this more.

> Can you think of any way we could expose this more to syzbot?
> First thing that comes to mind is a simple hack in netdevsim,
> to make it insert a netmem handle (allocated locally, not a real
> memory provider), every N packets (controllable via debugfs).
> Would that work?

Yes, great idea. I don't see why it wouldn't work.

We don't expect mixing of net_iovs and pages in the same skb, but
netdevsim could create one net_iov skb every N skbs.

I guess I'm not totally sure something is discoverable to syzbot. Is a
netdevsim hack toggleable via a debugfs sufficient for syzbot? I'll
investigate and ask.

--
Thanks,
Mina
