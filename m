Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792537980;
	b=AbHvBF8NpPwbt0aUUC7qePWK3R6OFZ5yhKu7nA55qwZGea3bucXSigo4wUdi1leUUqNk
	 y+v8nEtlRHyxRnom9sRtMO0TFC7SKv1P0eQCyl/7hzwGysF64D9Wcgqa/jo58H2aEqZRN
	 ZmpiEKV1CKHZTckfJqg9Kc9Dqu60XS0KpDZRYRJrD203GKNbu8WUeAgzHV6YuPmoOEQ9s
	 4Fc4eHvxpjk9ulrgMcvIB0VOocA4YxdSXmQb3KBEfij9Mv+9cljZVNJ+zp9d+wjbJ9jzI
	 5WcBFepKumCzdXMuJR3+TkIwcF4DtTAalnZsls2hbGXotX5H/Hf1JGlmnJUMOr3Jq3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792537980;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=V4dEpVJ6+z1cOz8lzxIgY22zi/dH+CU6Y8aHuWhhhWA=;
	b=DZpxtYyp4S1nvofK4YshdI93dv7nAD5XtHRboDYQA7Ae2htJI9NPshisBCh8t9hYpRV/
	 T6xd8KveEW6Ixh4hRcvBxlAEEWd9eOtZWRBC6g4Npl6sy6iy0dP6Pm/mci2PJ+D7/Fm8J
	 Hi+jOILEg0/lFXG3twIEjTuNrYd83mCF5cjOZaQIn1uzDi7s/NMffOxwXnB5fKyjX/1Rq
	 3mLv61fZfPDmD1cmW1o55WeS12S1UMOWVgKD/exN5h9nzClBcQo6JfF4WVfPnyEM8PN9E
	 Jx4qG6ukLAo/+bzSwgqQLhoHhq7QdpNfVgrWGCXQK0ARL6STfG1jKP5HUUo4xMeb1Tg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=gz3Pkn6R;
	arc=none smtp.remote-ip=209.85.217.52
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 148D0606A319
	for <virtualization@lists.linux.dev>; Tue, 20 Oct 2026 23:12:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 148D0606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=gz3Pkn6R
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-7cc2bb73cd9so47816137.3
        for <virtualization@lists.linux.dev>; Tue, 20 Oct 2026 16:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792537979; x=1793142779; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=V4dEpVJ6+z1cOz8lzxIgY22zi/dH+CU6Y8aHuWhhhWA=;
        b=gz3Pkn6Ril/akOP39i56VDhsN3z8cKFDl5MtJfeJRmeV2gQbgcIH25tAWUp7WZTK5S
         I7hxc8RmQjINqVfvmSuXWwx5tuwIQRNyIswh6Y80teckPrpIE99XQGXXJcQ8aBoWAubr
         CgTUfBhFmjvznnKR7UB0Pz20IBi5OD5h86IDao1VgC/VvLfWo924Hp/EZQIIGfoJEvvv
         G9DWPaLUNrjeNTm1OXOV3wfjWYh5PMjMM/fUMJ7OVYk8u9e7+WSalFpijYnCgpP/yX/Q
         JONc4h8vjoxTABZ7uOrMDuNsUpVdygHAGXe3CzOj73q6pcJHOrrsnqoY4tLBKesq0Mll
         2bFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792537979; x=1793142779;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=V4dEpVJ6+z1cOz8lzxIgY22zi/dH+CU6Y8aHuWhhhWA=;
        b=laoXkd83V0wzom/0jwNzZ4QX1jVxHoYZtWFte/VbJteuzCEbzrCpiUoHLDOrXPJxgn
         +ssry25kZ7FkCJ2JrklaQnzyyDK4ajBW9cqysJnLC6yjyW45rvbSSLI7FGlZEcjNKWUl
         PPLqvAE0gwAwA2Upetfuq9AD60DRbEu9QGxHLCGkAQBAirdezHkT5moeHYPsb/+QYkXQ
         Y1Grw+lzEkJXGttvN5+J4+Oh7H2TR4ReShqQgU3+OxbLWDqdrk4FcNSCTyFiwRLDWFQT
         jrNMdZIjvMLBxNuEgBZpQQubGa7KGOUyxhqeQT000EJ8E+vi1hesA4LdCE1o7k0VlFUK
         iSBg==
X-Forwarded-Encrypted: i=1; AKwUvBx5viCKQJHmL/I/yiQvX8/mV/12m4G8zo8IVglWgxsM8338UeKUlDwPOyiZVz1CJDMKVIw09mMNdJiabLyMWw==@lists.linux.dev
X-Gm-Message-State: AFq9FYJzAuc6ZuNF0Jm2+tZtgUa0j4NhSdSjb8p7SaGXbfIogUA/3Qg0
	sYHnEWvoN+ixmlVyUTkGDAf8Ecob4UvILjoW5STfYfjM3UbMnq2fb8oh
X-Gm-Gg: AYBFou036BJPFEgd5wt1sad2YsRnddPJ6fch2yXtJPIUBSd6VN54jX5r7pDboFfEnGO
	e5Q5T+Prk9YX3k3a2ccaJxixfuUTioiYJiXlnuHiAV+nYdLNeDA8LZ66iJ7a1av6BG+BxdTDs/u
	oPWcdSAeH3xfDCELuJmvNBtAj2qynO8s7/XYPPmN2Jpwgl4xIB3OeQGuAsFoi+VfKLR8AqLj/Xe
	CUkMRiyU4IuItX81/2VX+aIf+MmxJ2xojAQc8MT5l1GRbS9DpWDJzSJzoM/su02SSs+QTX8eFcJ
	tDr7pCIZ+6nQm12PBEYsu+mrwjPrTVm+pwrsXA4pRut3jqdvkUsNMWD5DF9bPXs1IcXiWTD72A4
	/mZxa7vs1K8QH+ckL0P4n4DQsg2fib5X70LmPH8two7myT3Z8O+0W9dFmal8oM1aHTa7E630gP7
	AHjj98xkjrrHzzJyNCMAyPxJB6k6qx3N3SF/dRdhIxR0ld2qg8SuFDFeyKmMdGImh0CpkgLgtcN
	VD5fKyWZ4yM9SSmpQ9kzhJSJNemQ2JDVv6rOYKpiRigHspUKStm6c57N1aUPGI4/RCBiDwRYQnW
	1KM6fduME8B9ON4JqqgF3dkvCni4XWhs3V9slQ==
X-Received: by 2002:a05:6102:a145:b0:7cc:95ed:3147 with SMTP id ada2fe7eead31-7cc95edaf07mr37812137.34.1792537978890;
        Tue, 20 Oct 2026 16:12:58 -0700 (PDT)
Received: from gmail.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-990d108ff73sm1235667241.7.2026.10.20.16.12.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 16:12:58 -0700 (PDT)
Date: Tue, 20 Oct 2026 19:12:57 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: linux-kernel@vger.kernel.org, 
 Chris Arges <carges@cloudflare.com>, 
 =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
 Phil Sutter <phil@nwl.cc>, 
 Jason Wang <jasowangio@gmail.com>, 
 =?UTF-8?B?RXVnZW5pbyBQw6lyZXo=?= <eperezma@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 netdev@vger.kernel.org, 
 virtualization@lists.linux.dev, 
 Max Krasnyansky <maxk@qualcomm.com>, 
 Rusty Russell <rusty@rustcorp.com.au>, 
 Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, 
 Simon Horman <horms@kernel.org>, 
 linux-doc@vger.kernel.org
Message-ID: <willemdebruijn.kernel.2eabbddbe6528@gmail.com>
In-Reply-To: <20261020162048-mutt-send-email-mst@kernel.org>
References: <cover.1792411304.git.mst@redhat.com>
 <6f23c55c6eba3e3ec6b2c7e3a80728a326ed58af.1792411304.git.mst@redhat.com>
 <willemdebruijn.kernel.187d58ff2bce5@gmail.com>
 <20261020155917-mutt-send-email-mst@kernel.org>
 <willemdebruijn.kernel.2c9decc16892@gmail.com>
 <20261020162048-mutt-send-email-mst@kernel.org>
Subject: Re: [PATCH net v3 6/8] net: add a sysctl to opt out of virtio net hdr
 checksum validation
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Michael S. Tsirkin wrote:
> On Tue, Oct 20, 2026 at 04:19:41PM -0400, Willem de Bruijn wrote:
> > Michael S. Tsirkin wrote:
> > > On Tue, Oct 20, 2026 at 03:54:23PM -0400, Willem de Bruijn wrote:
> > > > Michael S. Tsirkin wrote:
> > > > > The ingress validation as implemented by the previous
> > > > > patch is stricter than what it replaced: GSO
> > > > > packets whose checksum metadata matches no transport header are
> > > > > dropped, and non-GSO ones get their checksum completed in place.
> > > > > Such packets used to pass with the metadata unvalidated,
> > > > > and with no overhead.
> > > > > 
> > > > > I judge that this should not affect any deployments, but there is still
> > > > > some risk that it does.  In case a deployment depends on them anyway,
> > > > > provide a per-netns switch to get the old behavior back:
> > > > > 
> > > > > echo 0 > /proc/sys/net/core/virtio_net_hdr_csum_check
> > > > > 
> > > > > The default is validating.
> > > > > 
> > > > > Assisted-by: LLM
> > > > > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > > > > ---
> > > > >  Documentation/admin-guide/sysctl/net.rst | 19 ++++++++
> > > > >  include/linux/virtio_net.h               | 23 +++++++++
> > > > >  include/net/netns/core.h                 |  1 +
> > > > >  net/core/dev.c                           |  6 +++
> > > > >  net/core/net_namespace.c                 |  1 +
> > > > >  net/core/sysctl_net_core.c               | 60 ++++++++++++++++++++++++
> > > > >  6 files changed, 110 insertions(+)
> > > > > 
> > > > > diff --git a/Documentation/admin-guide/sysctl/net.rst b/Documentation/admin-guide/sysctl/net.rst
> > > > > index e586e17fc7a5..b1a1c4714b22 100644
> > > > > --- a/Documentation/admin-guide/sysctl/net.rst
> > > > > +++ b/Documentation/admin-guide/sysctl/net.rst
> > > > > @@ -246,6 +246,25 @@ processes are dropped unless socket option SOF_TIMESTAMPING_OPT_TSONLY is set.
> > > > >  Default: 1 (on)
> > > > >  
> > > > >  
> > > > > +virtio_net_hdr_csum_check
> > > > > +-------------------------
> > > > 
> > > > virtio_net_hdr_validate? In case we do have to add more validation
> > > > later.
> > > 
> > > If you insist. My worry would be what if that validation is again
> > > user-visible somehow and we need to distinguish users who want
> > > to disable that future thing and users who want to disable
> > > just this current thing.
> > > 
> > > Hard to predict the future. But I will go with your intuition.
> > 
> > Thanks, but definitely feel free to ignore my suggestions.
> > 
> > My intuition would be to define as
> > 
> > 0: off
> > 1: everything one
> > 2+: sadly needed fudge values because we keep having to tighten,
> >     but some crazy workloads need to opt-out to avoid breakage.
> 
> yes you said i just do not get how it will work for userspace,
> maybe u can explain?
> 
> and what specifically is needed right now, while we
> just have 1.

Right now the sysctl is boolean.

If we define it as a narrow, very precisely defined sysctl, then its
exact behavior is set in stone.

If we then add additional validation later, that can similarly have
unintended breakage of weird users, we need to add another sysctl.

And if that validation is not entirely independent, i.e., builds on
this, you get a weird set of interdependent sysctls.

While in general systems will run with all validation enabled, unless
they do something weird that gets hit by validation.

A single broadly defined sysctl ("validate input at the source") can
be refined over time, including to expand to validation of other
virtio_net_hdr fields or protocol combinations.

Even if defining it more broadly we can still leave it a boolean:
all validation on or off.

Or, optionally, we can also define additional validation levels,
e.g, 0:off, 1:everything-on, 2:validate-csum-only.




