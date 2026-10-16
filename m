Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86BB148DB51
	for <virtualization@lists.linux.dev>; Fri, 16 Oct 2026 18:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792174636; cv=none; b=KvCR0V977iqhrWfpGtqJiZHjBpAScy3QMKOzyHO/Z9YLH+RKROZn88QljxeMJQCl8CI7AHUMc7khU5k8xWYs1M1Nm3vuDhvDWHtiKQbs9x7cOa8emF6bW4ZTY1W9i6nlt1TAEBkBqomWXIbxArJnV6si1YmRCQ/k1+Uq0TPNYSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792174636; c=relaxed/simple;
	bh=SBCt/eBXMWQ8dCo0YSEHtUPDvD40Qpw86uvOcqNS834=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=j5mYzj7JY6kG8wjQBvbytiec2gX4x/6/EpniOcFSdVBRN6x/m73Dyi7drzcu4gFD89l5L/wbIeKMfakDDX+g8k7H05K/NecK858bI577zaVE4fdQFVJVHbc3SgJ/cOUPR7A9mkOYbVR7MzEVMkav8pwN50S5xsAlGlvMhW9oWmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ka05QOPr; arc=none smtp.client-ip=209.85.217.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ka05QOPr"
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-7c3b6e8225dso101968137.2
        for <virtualization@lists.linux.dev>; Fri, 16 Oct 2026 11:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792174633; x=1792779433; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Y8u6hYFXZk0LfN+Hez4/Z5m0bA/NCutshHV861wnw+M=;
        b=ka05QOPrJsB9R0DsGwd7BXYaR2m9oN8HpucZAKvAWIVsB+iR/Pi9Oawxx1/8exYzBE
         R/WHXN7zs/gxrcFeX5mOd98byMFQxOcy0/MIjIl5Pm1P8UUj+wfF+Efk8EwVWgBeR//D
         0z6K3FFMZ7kXILP9nd8MWRJzWqNYAfFA06+GlbLznFrpEkR/R/gblfbWKAuQ4hUwq0LP
         UDELLARcyfBFEPGyD7AxQF3AEyCV+GAhLfSSjvpqrOlAPfcKKFnBb417YY9t+kvccVX9
         WtHjIHZLYs1cgxNucwXPBAhwbxslpml5KrW/Aq0Hs0YoBAOmgVyNlksirDQN+1o4Ov7E
         SoPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792174633; x=1792779433;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Y8u6hYFXZk0LfN+Hez4/Z5m0bA/NCutshHV861wnw+M=;
        b=IDIqaCH9eS5S+vdbV9GLjeE2MPLGZ+VL06jG7FAgtDnaTysMyZguDBlvH826Tq4MUE
         PIQNgvKl7nfUiXHCIER1jWsnTMzZPY/tzBTYEdoV8dcq5P6Hc7j+0O5PaIvfX/uv4/83
         sQ2huOYoe0OsMuDs7X9Ewq/avcfOlVTvWXQipEW6C70x0QAElRL+VWsv/nYrM2X3b/Hk
         nOwzi63cFJiqtiW5DLzoDgo4rHnrCcYcEaq1XABJf97UFI0DCZlPhzSQtrWIQoEUwWzc
         LWF8OrXJUQaiIOBbZH3JbM79vB5syE+krzVreyoVvRcWIQbyw/2kh38TwvdnD52pAYm/
         2KKg==
X-Forwarded-Encrypted: i=1; AKwUvBya6QcKL348Hm9rrp3I2pDUJ5AWTQkelKzOGz+tlb6Twd/b4JMd4CeBTFkw22rLGZ78bJ46ke2/xTtVwawS1w==@lists.linux.dev
X-Gm-Message-State: AFq9FYLNTQHszHG+EhHIC2D4QaTAG25xJjyc7Szz/4ZaBpXw5Qioa/82
	o7ESsKMSNCZGr0Z4PgGe5W4bJtpnR+qhHGPjsFDOlPmVKr8C9WtCZgQ+
X-Gm-Gg: AYBFou0ndi2z0UpG6o4200hJEgk5sqC71s0qRg6nH9p5JlsN4eWITfgVuXBvntSLK+/
	IShrUyiZkv3uIitdxJT31w1ef6EQ48QyHg6wmmLVxAX9xwzRnI+tQkgpO0KAd/Ej357/plM3ncb
	Xr87oVwtHtGgY7Sp4fdsXL4tI7Jl+yQ/a/zycVP5dnuLA/pFpXJU7oe5qx6XpIlykQWuGLh3Ab0
	bCLbeuLLwWRVmnq5jrugu+UvdgcGqDehW0BgAIeK9sapn6BDjR/PQJPMUH8+5CvBnw3WaUlm7VT
	5z6P2ElGMkHEeNRCvTvlkboa3l1mw+85xJzsGU2ZvNOOZRGMvQMiwji5VxxsSsEuMYN7xHvT8DV
	i9Bt3XlayCxO09HD8V5DP/uNpwUrxHfx0CjZ35yizTlR/LQ+g8daSYPQfIEG7afSBc4OcB7M+p4
	T9tUikMUc0wTRqloB7yJ8fWnb/Q/k6hbQZL5gGxkLeMJIvxgJfhjyeJMhTmFA1JRdhG64FzeLPV
	cMXYsjPArrgSFbcDJt2N1Ijoh/mvxB6dpK/ELffDlQZdPwhBRy8zJ7GC7QjZ+LPW9BKkEvtcfg2
	N5SX7oznJPheyUcmLBquhZAks4UP14YzKbE5pUsG5uEKoPkC
X-Received: by 2002:a05:6102:4187:b0:7c1:94eb:d72b with SMTP id ada2fe7eead31-7cc36b23993mr155186137.34.1792174633433;
        Fri, 16 Oct 2026 11:17:13 -0700 (PDT)
Received: from gmail.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-9908366328dsm2092409241.12.2026.10.16.11.17.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 11:17:12 -0700 (PDT)
Date: Fri, 16 Oct 2026 14:17:11 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: linux-kernel@vger.kernel.org, 
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
 Rusty Russell <rusty@rustcorp.com.au>, 
 Max Krasnyansky <maxk@qualcomm.com>, 
 Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, 
 Simon Horman <horms@kernel.org>, 
 linux-doc@vger.kernel.org
Message-ID: <willemdebruijn.kernel.1150b0c0fbbbe@gmail.com>
In-Reply-To: <20261016135328-mutt-send-email-mst@kernel.org>
References: <cover.1792067836.git.mst@redhat.com>
 <ad05a40681719a579691a1da6413f0dd7064f2a0.1792067836.git.mst@redhat.com>
 <willemdebruijn.kernel.3a7d04e1c306e@gmail.com>
 <20261016051827-mutt-send-email-mst@kernel.org>
 <willemdebruijn.kernel.1d7ce6b64753a@gmail.com>
 <20261016135328-mutt-send-email-mst@kernel.org>
Subject: Re: [PATCH net-next v2 5/7] net: add a sysctl to opt out of virtio
 net hdr checksum validation
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Michael S. Tsirkin wrote:
> On Fri, Oct 16, 2026 at 11:30:17AM -0400, Willem de Bruijn wrote:
> > Michael S. Tsirkin wrote:
> > > On Thu, Oct 15, 2026 at 01:50:54PM -0400, Willem de Bruijn wrote:
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
> > > > >  Documentation/admin-guide/sysctl/net.rst | 15 +++++++
> > > > >  include/linux/virtio_net.h               | 23 ++++++++++
> > > > >  include/net/netns/core.h                 |  1 +
> > > > >  net/core/dev.c                           |  6 +++
> > > > >  net/core/net_namespace.c                 |  1 +
> > > > >  net/core/sysctl_net_core.c               | 54 ++++++++++++++++++++++++
> > > > >  6 files changed, 100 insertions(+)
> > > > > 
> > > > > diff --git a/Documentation/admin-guide/sysctl/net.rst b/Documentation/admin-guide/sysctl/net.rst
> > > > > index e586e17fc7a5..7f230929c37e 100644
> > > > > --- a/Documentation/admin-guide/sysctl/net.rst
> > > > > +++ b/Documentation/admin-guide/sysctl/net.rst
> > > > > @@ -246,6 +246,21 @@ processes are dropped unless socket option SOF_TIMESTAMPING_OPT_TSONLY is set.
> > > > >  Default: 1 (on)
> > > > >  
> > > > >  
> > > > > +virtio_net_hdr_csum_check
> > > > > +-------------------------
> > > > 
> > > > Make more generic, virtio_net_hdr_validate?
> > > > 
> > > > In case we add more validation in the future (as we have in the past),
> > > > without having to introduce multiple such knobs.
> > > 
> > > But it's uapi, are you sure we'll be able to change the meaning
> > > of an existing knob, even if we keep the name vague?
> > > 
> > > > > +
> > > > > +When processing packets with a virtio net header (through tun, tap, a
> > > > > +packet socket or a virtio network device) that request checksum offload
> > > > > +(VIRTIO_NET_HDR_F_NEEDS_CSUM), validate the packet: complete the checksum
> > > > > +in software, or drop the packet where the header does not match it.
> > > > > +
> > > > > +When disabled, the header is trusted not to corrupt the packet, and the
> > > > > +checksum is offloaded to hardware (or not verified if it never reaches
> > > > > +hardware). This is only safe if no protocol is processing the packets.
> > > > > +
> > > > > +Default: 1 (on)
> > > > > +
> > > > > +
> > > > >  wmem_default
> > > > >  ------------
> > > > >  
> > > > > diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
> > > > > index 357115ff0ec2..aa2f8ac4657c 100644
> > > > > --- a/include/linux/virtio_net.h
> > > > > +++ b/include/linux/virtio_net.h
> > > > > @@ -5,6 +5,7 @@
> > > > >  #include <linux/if_vlan.h>
> > > > >  #include <linux/ip.h>
> > > > >  #include <linux/ipv6.h>
> > > > > +#include <linux/jump_label.h>
> > > > >  #include <linux/netdevice.h>
> > > > >  #include <linux/udp.h>
> > > > >  #include <net/gso.h>
> > > > > @@ -78,6 +79,19 @@ static inline struct iphdr *virtio_net_ip4_parse(struct sk_buff *skb,
> > > > >  	*thoff = nhoff + iph->ihl * sizeof(u32);
> > > > >  	return iph;
> > > > >  }
> > > > > +/* Defined in net/core/dev.c, enabled while any network namespace
> > > > > + * has net.core.virtio_net_hdr_csum_check set to 0.
> > > > > + */
> > > > 
> > > > Should this be a global sysctl, rather than per netns?
> > > 
> > > 
> > > For customers I work with, it would be much less useful.
> > 
> > Third option: make it an integer rather than a boolean.
> > 
> > 0: no validation
> > 1: current level of validation
> > 2 and beyond: if we have to extend it later
> 
> 
> Oh that's an interesting idea. Issue: userspace learns about 1, then
> someone sets it to 1 thinking this is the highest level and in fact
> disables some security.

True. If concerned about that we could change the interpretation,
keep 1 the highest, subsequent for legacy.
