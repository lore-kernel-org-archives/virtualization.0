Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792527583;
	b=n1dAm3zs4TpGGoMBk3sOjetxMT9gdn2W6uA3mNDVmJbEIks+03+ZAiCmp1ZMOinL6mi6
	 RtqmXolGaC/SvPaYV/eeNbb/ciLr0l1GjhXr+jhVWQxpEF/0xW4ri9p85ZZ7kt4SNZvh6
	 3woKE+KCGBBigJ6G4qRb0HWy4fF24+jOJktQ3oWzx3zF8xWi7jdU1Qf/+h1NJBM5Q8i4o
	 JSXXA96zYExFOVSJ2wQt3FiFXp2FgyeKTkkmeaUP38K3nB9ZHAa0HxEa5JmPgqe8jmH4s
	 2/2NNb0IsCwBiOL0eetQ4v1M1FYJtbvpupEWtVgQhuQNHCpGMEpKeAu9nAqIuVtp9hQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792527583;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=mSISClxN0AquiYKdkApngEQlUAzth9oYRTtKq3bxFPE=;
	b=Qpt+iCsO6bA05yY6x4JDV98m8TrM40UDBvjoXlQ9xUtmq3R63DB8pFd3+W/B3/PEpNvL
	 WUYbyr2vD50zNI89ZLbYubVeBKu36C41hhwk0ZYI/gsZv2W5I8KSIxIbFBbgsg9avbaIL
	 oG6gHMcdIww9dOqle20aTKevKL4njN3LiDJIEpdCFybDJKkApud/RcSf77adEwgsvxA1y
	 p4jsbECwwlAyFGL5/S4AC8R92bzkgKPgvr6BIpV6WEz+bIn5BQU9RWV9RKEZI8IsJJ7TM
	 FWnwzgbhAXtjGF1RUpassz2pA2SIanlmNT6Or4iIzskbeCIKV+KllhrREMcpm+kfPqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=TRApa3Xs;
	arc=none smtp.remote-ip=209.85.221.170
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0979A606A31C
	for <virtualization@lists.linux.dev>; Tue, 20 Oct 2026 20:19:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0979A606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=TRApa3Xs
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-5eac9db5905so966009e0c.0
        for <virtualization@lists.linux.dev>; Tue, 20 Oct 2026 13:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792527582; x=1793132382; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=mSISClxN0AquiYKdkApngEQlUAzth9oYRTtKq3bxFPE=;
        b=TRApa3Xsjnywp4tUHkNj4sBKWFJ3tgAK82ZEJGdvCwao3u3H63Ws9Gl1mkxInKi6Uu
         BE/AaaGC0YgukA1g69U1Tnx1rgp4NbEPCRYFMVzIe+GYdjAYlTt7BB/czAxsYsq+VPB4
         5aj08rRKe1eKp0fm+A+Sv02AVaO7jV3P8Iy8PLVHQK3Dtiw3TFFRtFrPvOWRIdha7kWJ
         7tnu+9LNcUTNioN1ACNhN8UNICOo3snqGSu/XgYVxtqCY/P3qNV138jq8sUD+PJRi7Zf
         8bcyTh/KunQrR27zSpSsat6ALaw68lPFOa4tgsH4TKsr/VoVFMaBzKvgfjldzIp/X1hp
         CV7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792527582; x=1793132382;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mSISClxN0AquiYKdkApngEQlUAzth9oYRTtKq3bxFPE=;
        b=K/YGLf9of1S3nQ4sK9EDEJ1ZCen024Nv0qJFZeSWfYBppuSyg8Ek4mZP2Bn1eCiDTM
         7e/0nfmaSwGyNpD5nXwXvUkvt0ovFj9JFZkCyQXyGodtvXKEdE8Bs9LrTXV3I9ikgWq9
         /3hQVwkjQtBRuRLgIm+U/KsihCb5EXB+Hpkve5wTLvR/rkpsFixJa+7dMEVMZguZzycE
         a0XTBK4HXHzCoYnTQZFu3OkEhs4sYRU+lVTE6rK/N5uQEeyV/T81LSt3SF1AZzvbA9WS
         ZENwcIZcHQTNoJlLY7OxAGORfJelbKAsnA2sK+R5mi1jgC8DjgEvPXkWuQEbXlqt1eA1
         GoAA==
X-Forwarded-Encrypted: i=1; AKwUvBxrBEGnRBICsISCv0UNeqyfxdI5osh+4hPQnzx8W/cPs4QGTCXF0nJNUfk58ggW12WpJV8Ex0N3cnznOzMPHw==@lists.linux.dev
X-Gm-Message-State: AFq9FYLM1aHROqe+2CO+8vP23s0781b4IHf3bPe2mbAwmH+TMO4tjh5H
	LasRSqTX0u1GDK1DD2EO5eOeAuMBxy/2HZ60oq4gzA7heUDE5IUI7Yjt
X-Gm-Gg: AYBFou3RhfpRuUxpB7RmfyILI1dHsxn5E8WN5Jz1RSsgmo1juVMUElEIHCyAhFcDb7N
	GbeZhaSNh+WjQ4NfJigsdiJjNc+Lq1TrlhZmZv8JQjdU1VrSZEVxiCy0Zx6493OzyZMz7ZINL+e
	u+0EUeuL7vmeslvxw43pfIhnbDW0SJb/RCiLFTRgM18WBMV827apCW07x5QVCYt4edpd3vKdp/F
	m76WQ+KeXTR3HmP2t5E6zQF47kpMIvIRmnPtDUl2EYU44qqjG9+qKkvadkoRThMbvDqQgZmkqs1
	Ob5qjGt04wuGrUuGksFBMLbIIjo93H3FrO+u0tG0Qk2anBu2VVwM4TH5EA3pmVAq6IvfGTKM7Xc
	fIFaUX1ITPeZVuplokDT4arXWNzE74+zFWNQVIZOSeKNQkiDibSlKmvPC2xY6Ukl2TExaPKDTJf
	t767HvVnVObAPqj4/AWAL6kn9VnUYAVlLMXAwaZMqy2xQvXWPBsCwbY4VSN+6vZEp4H+XML+s7K
	/D9ciShO0nuxYGttSHFK1NtLenCDkvLmt1paBX7qaQgobf5JQdDXxgQnyQqLbo09BkPz6rRPUtr
	nxxG5sMlO4usnCBUv38FA+OjlC6lTZUAbuKM+Q==
X-Received: by 2002:ac5:c00e:0:20b0:5ea:389c:520b with SMTP id 71dfb90a1353d-5eaaa3a4e95mr3071748e0c.8.1792527581939;
        Tue, 20 Oct 2026 13:19:41 -0700 (PDT)
Received: from gmail.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5eae983efe8sm587906e0c.17.2026.10.20.13.19.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 13:19:41 -0700 (PDT)
Date: Tue, 20 Oct 2026 16:19:41 -0400
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
Message-ID: <willemdebruijn.kernel.2c9decc16892@gmail.com>
In-Reply-To: <20261020155917-mutt-send-email-mst@kernel.org>
References: <cover.1792411304.git.mst@redhat.com>
 <6f23c55c6eba3e3ec6b2c7e3a80728a326ed58af.1792411304.git.mst@redhat.com>
 <willemdebruijn.kernel.187d58ff2bce5@gmail.com>
 <20261020155917-mutt-send-email-mst@kernel.org>
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
> On Tue, Oct 20, 2026 at 03:54:23PM -0400, Willem de Bruijn wrote:
> > Michael S. Tsirkin wrote:
> > > The ingress validation as implemented by the previous
> > > patch is stricter than what it replaced: GSO
> > > packets whose checksum metadata matches no transport header are
> > > dropped, and non-GSO ones get their checksum completed in place.
> > > Such packets used to pass with the metadata unvalidated,
> > > and with no overhead.
> > > 
> > > I judge that this should not affect any deployments, but there is still
> > > some risk that it does.  In case a deployment depends on them anyway,
> > > provide a per-netns switch to get the old behavior back:
> > > 
> > > echo 0 > /proc/sys/net/core/virtio_net_hdr_csum_check
> > > 
> > > The default is validating.
> > > 
> > > Assisted-by: LLM
> > > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > > ---
> > >  Documentation/admin-guide/sysctl/net.rst | 19 ++++++++
> > >  include/linux/virtio_net.h               | 23 +++++++++
> > >  include/net/netns/core.h                 |  1 +
> > >  net/core/dev.c                           |  6 +++
> > >  net/core/net_namespace.c                 |  1 +
> > >  net/core/sysctl_net_core.c               | 60 ++++++++++++++++++++++++
> > >  6 files changed, 110 insertions(+)
> > > 
> > > diff --git a/Documentation/admin-guide/sysctl/net.rst b/Documentation/admin-guide/sysctl/net.rst
> > > index e586e17fc7a5..b1a1c4714b22 100644
> > > --- a/Documentation/admin-guide/sysctl/net.rst
> > > +++ b/Documentation/admin-guide/sysctl/net.rst
> > > @@ -246,6 +246,25 @@ processes are dropped unless socket option SOF_TIMESTAMPING_OPT_TSONLY is set.
> > >  Default: 1 (on)
> > >  
> > >  
> > > +virtio_net_hdr_csum_check
> > > +-------------------------
> > 
> > virtio_net_hdr_validate? In case we do have to add more validation
> > later.
> 
> If you insist. My worry would be what if that validation is again
> user-visible somehow and we need to distinguish users who want
> to disable that future thing and users who want to disable
> just this current thing.
> 
> Hard to predict the future. But I will go with your intuition.

Thanks, but definitely feel free to ignore my suggestions.

My intuition would be to define as

0: off
1: everything one
2+: sadly needed fudge values because we keep having to tighten,
    but some crazy workloads need to opt-out to avoid breakage.

