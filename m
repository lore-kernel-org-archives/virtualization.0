Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792538492;
	b=IfhCjYKqhPpLv6Nwym3sDnu7aRYVt91ta3bw1KVG72A8JdkecGSNVMKQArEW94lIIdzK
	 tWmxq5sdMWSrcgke5JMPEjboJC4Yn/TqwLhEnAiLs/6Am2gBgO6PdUZBstodJTzno/iGX
	 xeHHarwpxKElc9q23tYYz3AIOGwG0OoBv4HpFl3pBf5TZHjahcUJ9Guvxq3z5LMkPvlxQ
	 XwsKVHtobT15JNSk4aLvSpOzbXHNn1dr8kAWi19oKIY+wjATsVflUreJhcak0cYm/mX2w
	 6bHB5+llJOnyn2JijoEURwd/0xEJ593RZu7zkYRRDnOL85pfmMl/7nVQkSB5LZRgMtA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792538492;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:In-Reply-To:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Type:Content-Disposition;
	bh=YJVYnLvaEVwucHW+x0AHb90jt4BURilSyy87F4cjKH4=;
	b=uT7HFHCP50V/anelGyWVjxdQ48GqvheA5hctNom5dMMntlOQqV0I4IjEHvbynpkaPDIH
	 ixKFb10HSfgl+PczaI8F781PWZwcesVsXyqvgc1i/+VCXEmTSQjYpU+fr6Pw+X+32Ow2r
	 aREmIOBKN3ScdMRS+0sbBorkGKQZxNsB4HgIeh7JII0bHlsO3UUo4kDzgKh311BpJNj0I
	 T2PRrMaG6d/++5MsDyxwR65S/BKYkPtBeum/4VWSoNGnjqUptGkDp/z+FsrwpTtzPgNb4
	 YwQUyDzqR9Pnr2Sb7gzHkuogz2kX6RVtURqkh20bJxmmB4z1D0edBIuI6H9INUtfwmA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WbmQNvG8;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2EE5606A324
	for <virtualization@lists.linux.dev>; Tue, 20 Oct 2026 23:21:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E2EE5606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WbmQNvG8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792538490;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YJVYnLvaEVwucHW+x0AHb90jt4BURilSyy87F4cjKH4=;
	b=WbmQNvG85ntOCZ+gXO7uM3XgJ+HO8E+vkiTVs+dBtmnyggkTWWF/N7jXCg9edNUW168lEF
	XNyJTAX52sUNvSeyEY8Gc0d8tqt/ChIDCzNh56Sk7B9bVvaZhfpTQIlbjEoZ/2xHgRg4K3
	S4fMArBe802QsFeh/WM+g651xRLwAWU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-648--arnpQ_9P9WWHjNhsFNkKw-1; Tue, 20 Oct 2026 23:21:27 +0000
X-MC-Unique: -arnpQ_9P9WWHjNhsFNkKw-1
X-Mimecast-MFC-AGG-ID: -arnpQ_9P9WWHjNhsFNkKw_1792538486
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4a1e489f97fso968485e9.0
        for <virtualization@lists.linux.dev>; Tue, 20 Oct 2026 16:21:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792538486; x=1793143286;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YJVYnLvaEVwucHW+x0AHb90jt4BURilSyy87F4cjKH4=;
        b=czWe3Wm6EmMAOg6bWhnSMkIoww7gLqMeX9jNjaaAJ9yKw3zxnOJORXj5f9WRmxYGs+
         d4fHpc41Hf5pn+9kdCSfSvbwEd5NlW1VBfrEPkEDfoOqlk0s9q/izS0FuyffgFYcyk45
         49WG/kCnFuepGlfSB0gtFeAYMzbRgCEwqPIUFKMe3BeVovGXu+slHWLVdeGd6yJCZfJe
         j1UfENsnJ0yP4Q2V25EwGKFHtKAVivto95BAR84B+wfw7DVQQeNINj8cdrrgT6clZw3S
         Ih+cBL+FUCeMV0t69f2jS1mIfSBr/WFET2SEhXovw9gZ9NKPgMK53PjsRcXGfGiXC2xq
         u8+Q==
X-Forwarded-Encrypted: i=1; AKwUvBwZcyrDXIsoXHaJmQMHDmjspupTzF6ZbJvaM59f/J3FfoBHgeVLG9nAyvpIS7o7ecytLDcUbwrZFItmekLqEw==@lists.linux.dev
X-Gm-Message-State: AFq9FYI0R/nzo0cHNBbQr8RXKMMliW8Lb68DwN0Vos1WswsY173phY0a
	2LO/Ho+trjFdM+PNHKO1zrdCNM0BvOzad0A6xEYz1w/1+EOsajz8a3L4Fp+ZsuWCJ1coqmXI6HL
	KYULltv/5ty9IUh+c2sp59bWyvZexhTi7DBdm0rC3fN3Nb9rNuMPZSzjOpKw58RNbCfOb
X-Gm-Gg: AYBFou1N/+xOj7NArIme2wiMPOiizCiT94iUnfymOO0/dfOfRIx4ASd9mn/kqK7YyGk
	c1B6ID72JHi+ggGq6gqkXS5eMCv6hTb2tzhUpCxhWuf9YgfTBCkbQSCZ7zrWEbzgrzFoU2eELTB
	o/5ZKWWcD6YJeVgfD0zYrS/d2Nwlm/x4J+78DAsTxKJNWCz5phTVfs+ZuzDpy9ruRx7BJtC9x4z
	EhiZIfDzK6EtRZf2a0KJdnW3UVPPDyKev9mGLvOsvPaXhXcb7vlY1fElIAWZpajMEfv3ZADNeR/
	/MYF7yHv8EQAHvdXozIDi1NQzimpHtVhcxbxJT8c4GIS09DlQNVzeJK3is+b0eiJdB8C5Q==
X-Received: by 2002:a05:600c:3548:b0:4a1:e774:370c with SMTP id 5b1f17b1804b1-4a1fdd145edmr3979805e9.30.1792538486068;
        Tue, 20 Oct 2026 16:21:26 -0700 (PDT)
X-Received: by 2002:a05:600c:3548:b0:4a1:e774:370c with SMTP id 5b1f17b1804b1-4a1fdd145edmr3979245e9.30.1792538485547;
        Tue, 20 Oct 2026 16:21:25 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:3fd7:5300:3d6b:52a4:a23f:9d0b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1fcd2eff9sm12797555e9.4.2026.10.20.16.21.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 16:21:24 -0700 (PDT)
Date: Tue, 20 Oct 2026 19:21:21 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: linux-kernel@vger.kernel.org, Chris Arges <carges@cloudflare.com>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
	Phil Sutter <phil@nwl.cc>, Jason Wang <jasowangio@gmail.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, virtualization@lists.linux.dev,
	Max Krasnyansky <maxk@qualcomm.com>,
	Rusty Russell <rusty@rustcorp.com.au>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Simon Horman <horms@kernel.org>, linux-doc@vger.kernel.org
Subject: Re: [PATCH net v3 6/8] net: add a sysctl to opt out of virtio net
 hdr checksum validation
Message-ID: <20261020192040-mutt-send-email-mst@kernel.org>
References: <cover.1792411304.git.mst@redhat.com>
 <6f23c55c6eba3e3ec6b2c7e3a80728a326ed58af.1792411304.git.mst@redhat.com>
 <willemdebruijn.kernel.187d58ff2bce5@gmail.com>
 <20261020155917-mutt-send-email-mst@kernel.org>
 <willemdebruijn.kernel.2c9decc16892@gmail.com>
 <20261020162048-mutt-send-email-mst@kernel.org>
 <willemdebruijn.kernel.2eabbddbe6528@gmail.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <willemdebruijn.kernel.2eabbddbe6528@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: T0ZDn-dRvL4cqmNrhw4jMpcn7ucuXnPRuAUVYcVIwNo_1792538486
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 20, 2026 at 07:12:57PM -0400, Willem de Bruijn wrote:
> Michael S. Tsirkin wrote:
> > On Tue, Oct 20, 2026 at 04:19:41PM -0400, Willem de Bruijn wrote:
> > > Michael S. Tsirkin wrote:
> > > > On Tue, Oct 20, 2026 at 03:54:23PM -0400, Willem de Bruijn wrote:
> > > > > Michael S. Tsirkin wrote:
> > > > > > The ingress validation as implemented by the previous
> > > > > > patch is stricter than what it replaced: GSO
> > > > > > packets whose checksum metadata matches no transport header are
> > > > > > dropped, and non-GSO ones get their checksum completed in place.
> > > > > > Such packets used to pass with the metadata unvalidated,
> > > > > > and with no overhead.
> > > > > > 
> > > > > > I judge that this should not affect any deployments, but there is still
> > > > > > some risk that it does.  In case a deployment depends on them anyway,
> > > > > > provide a per-netns switch to get the old behavior back:
> > > > > > 
> > > > > > echo 0 > /proc/sys/net/core/virtio_net_hdr_csum_check
> > > > > > 
> > > > > > The default is validating.
> > > > > > 
> > > > > > Assisted-by: LLM
> > > > > > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > > > > > ---
> > > > > >  Documentation/admin-guide/sysctl/net.rst | 19 ++++++++
> > > > > >  include/linux/virtio_net.h               | 23 +++++++++
> > > > > >  include/net/netns/core.h                 |  1 +
> > > > > >  net/core/dev.c                           |  6 +++
> > > > > >  net/core/net_namespace.c                 |  1 +
> > > > > >  net/core/sysctl_net_core.c               | 60 ++++++++++++++++++++++++
> > > > > >  6 files changed, 110 insertions(+)
> > > > > > 
> > > > > > diff --git a/Documentation/admin-guide/sysctl/net.rst b/Documentation/admin-guide/sysctl/net.rst
> > > > > > index e586e17fc7a5..b1a1c4714b22 100644
> > > > > > --- a/Documentation/admin-guide/sysctl/net.rst
> > > > > > +++ b/Documentation/admin-guide/sysctl/net.rst
> > > > > > @@ -246,6 +246,25 @@ processes are dropped unless socket option SOF_TIMESTAMPING_OPT_TSONLY is set.
> > > > > >  Default: 1 (on)
> > > > > >  
> > > > > >  
> > > > > > +virtio_net_hdr_csum_check
> > > > > > +-------------------------
> > > > > 
> > > > > virtio_net_hdr_validate? In case we do have to add more validation
> > > > > later.
> > > > 
> > > > If you insist. My worry would be what if that validation is again
> > > > user-visible somehow and we need to distinguish users who want
> > > > to disable that future thing and users who want to disable
> > > > just this current thing.
> > > > 
> > > > Hard to predict the future. But I will go with your intuition.
> > > 
> > > Thanks, but definitely feel free to ignore my suggestions.
> > > 
> > > My intuition would be to define as
> > > 
> > > 0: off
> > > 1: everything one
> > > 2+: sadly needed fudge values because we keep having to tighten,
> > >     but some crazy workloads need to opt-out to avoid breakage.
> > 
> > yes you said i just do not get how it will work for userspace,
> > maybe u can explain?
> > 
> > and what specifically is needed right now, while we
> > just have 1.
> 
> Right now the sysctl is boolean.
> 
> If we define it as a narrow, very precisely defined sysctl, then its
> exact behavior is set in stone.
> 
> If we then add additional validation later, that can similarly have
> unintended breakage of weird users, we need to add another sysctl.
> 
> And if that validation is not entirely independent, i.e., builds on
> this, you get a weird set of interdependent sysctls.
> 
> While in general systems will run with all validation enabled, unless
> they do something weird that gets hit by validation.
> 
> A single broadly defined sysctl ("validate input at the source") can
> be refined over time, including to expand to validation of other
> virtio_net_hdr fields or protocol combinations.
> 
> Even if defining it more broadly we can still leave it a boolean:
> all validation on or off.
> 
> Or, optionally, we can also define additional validation levels,
> e.g, 0:off, 1:everything-on, 2:validate-csum-only.
> 
> 
> 

So I will just rename it to validate, we will see down the road
how it plays out?

-- 
MST

