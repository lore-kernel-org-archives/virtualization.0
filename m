Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FCF648DB5B
	for <virtualization@lists.linux.dev>; Fri, 16 Oct 2026 18:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792174783; cv=none; b=m+2Pyi0O2RIGt1Bou6QhsjKCHusHgOAaYlZrhjZ+x4jSu0MP5BsDzVzrlV2gN4JkwUQFE/zl+50TNJKxPwFyI8f7Q3/jzqaP9uXeH4PKwGjl9cHTC1qdxcP+kRqEpQw0uvkJvq6usJiLaUAHZmO04CWQpD34/J+rZQWnZbDUUKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792174783; c=relaxed/simple;
	bh=7oz8HPvheVIvTGYESdpSdhYdJVJsRJpxnpOPaR0bQ90=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=oh7j7HfGjwa2UY3y07VOrr+hs6ugkqmb0cmJMWbKwCwkgW23XDK2QE5SmQJLQp5JYMGztSCN8CvGjVkipRuIDPlJs6g3aw7deLM6MBuUtsc+XIxepOAI+rykU8LKzv6Y/FMTMp8mAe2fm9eSdQXyMWkoTvbLZ8KYs0m0ftT5tww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XgRrzJOE; arc=none smtp.client-ip=209.85.217.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XgRrzJOE"
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-7c03744ef27so50801137.1
        for <virtualization@lists.linux.dev>; Fri, 16 Oct 2026 11:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792174781; x=1792779581; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=RVF+KNTB3PtvNAoY46w+x0vdrM5zplysVyH1LA9K07M=;
        b=XgRrzJOE5jbYyhMa8uF4wzTEwDIkBSzXSUdMt3wgRNX2H/ZdNCaKv9VdV4Ilam7gvm
         vlFL0BG/2zseSV5sNGot2psWGItufeCZZH2hBcwcWQuCPhoEda7TBXrvzXRN7As5oTyt
         WVIl6Ahh32svL460837CrHrhxBJ9317yASwQR5PfW2LaUHUkc/22agN8uzwhpWZrNW1W
         QUJ788SMo+1p7dPYvDWZ0tPR4Hzbbd2J493k9GDEAlcjcHFffZO7wPKNajtPe6pLhNPn
         xyw3kqkb/9RrGOFp8auYUF9YvVBgtdRcHBmZUbsjD2DsmcVi8dcO5BojSpwuFMvGJeZR
         pG5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792174781; x=1792779581;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RVF+KNTB3PtvNAoY46w+x0vdrM5zplysVyH1LA9K07M=;
        b=c+XF3ACjKhuHTe/aqi5U+RyQYUkw1mwr7AbJH14DLY80fvNJAuPkOtFPx6skvZBVYk
         AA429amyijLfjCd8Uv7xdchrHjsnnUUN4MgbBlUAFJYMTr4qaGkbFXO0UoFcWhOMDxgS
         P0Hf+NUw3NdNmTMIJVNuPucLD+QITorD7JBB7NJ12YExPLES5OnySRRVW+GUG88vo/MD
         2PHZBQpzDH33/q0CWczYRpxd8+igcLbPbMN3GShsac9xaK60zSZ2MMbpymPebAav29f+
         Xw15w1uFUHJrZKQS2FCk0Y+g1eSRwHvgEla1asdsOCsXrgZkVszEPOaITjkur6bu33Lp
         xkEA==
X-Forwarded-Encrypted: i=1; AKwUvBy0XYoVKDnQ2tcEG1PlLRhtB3p62yC43ddbidfurFuvvM6Y1rzhCk8pTUnw/Y7lM1FELFjk5/i6N7Hw1Ms/Lw==@lists.linux.dev
X-Gm-Message-State: AFq9FYLP9d57JPxVOktvMAMZUA1avnELt3OpLNU6KAQ/ACTaHwfWujAn
	oufg3O05EBkvWN4RiBzOhlnYxFfRmsa5WULIFi1qBMUafPoVyG+y4Zw9
X-Gm-Gg: AYBFou3mc64rsjawu+2Ea1vWby1ZNBvF9oxvepnWhMUpnddeWYj6z4p2upXHvgfak8s
	k0+QxYS1Tovq3LdobWUhK4TzS+EwanzTPe6N7z0tfTV3XXaOugv9IsRbyXvryosPIqHPGlNMWv1
	wzP3FTHAwwMu7IsRK6GVJFzhnzN6o86p0zCAr4ob8zTleP9ohinDBatpvIWzhhL3zxlWpOY6qVC
	XLqojs97zfzp7734yFESgg+1q3HPKDDime1D8oBFjtfRo70CrLgXjMwYtLypGx11cseZmb+Ce8G
	XSYoQa7sVrf6Ye4dwcpgJvitS1yXN5COt7NMi8cejVQUicSWkyt/ZxARVQo3M+x82DTczYF0PR/
	SpcY3l05cDoDSOZlP8/Ij/GYdSIIbPJNU4T8QdFGeb0QMnds4aPIRExReECz6+UF6TYwExdbtjQ
	zGqsuYNTHvP5YCeBjaLg86in1Aalr3G2Wqgq1OaIpKC4IgkBu/7qyugbBd4yv9oK1lY5qSzgocB
	vayHkJsN5LQCUjxMF9tpkbsO6iNoUJuFaszzUpdpeOgsagt7EQELPV1g6cquGFyh86YrhI5ZFau
	kj7ECFDQXud+l6uIMx3R1+pGiwe9z7LsvF3vfCxn4vaXkOAqZQ==
X-Received: by 2002:a05:6102:419e:b0:7c3:2f33:54bb with SMTP id ada2fe7eead31-7cc36aa3d6bmr96424137.28.1792174780679;
        Fri, 16 Oct 2026 11:19:40 -0700 (PDT)
Received: from gmail.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-990835c253csm2173395241.5.2026.10.16.11.19.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 11:19:40 -0700 (PDT)
Date: Fri, 16 Oct 2026 14:19:39 -0400
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
Message-ID: <willemdebruijn.kernel.2deaddfb31bd9@gmail.com>
In-Reply-To: <20261016134823-mutt-send-email-mst@kernel.org>
References: <cover.1792067836.git.mst@redhat.com>
 <ad05a40681719a579691a1da6413f0dd7064f2a0.1792067836.git.mst@redhat.com>
 <willemdebruijn.kernel.3a7d04e1c306e@gmail.com>
 <20261016051827-mutt-send-email-mst@kernel.org>
 <willemdebruijn.kernel.1d7ce6b64753a@gmail.com>
 <20261016134823-mutt-send-email-mst@kernel.org>
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
> > 
> > Not pretty, I'll admit. So fine to keep as is too if you prefer.
> > But I do foresee more changes in this area, if history is a guide.
> >  
> > > 
> > > > Even if per-netns, most likely do not want it writable by netns root
> > > > with user namespaces.
> > > >
> > > > That is the equivalent of ns_capable(CAP_NET_RAW), which is the cause
> > > > of many crashes due to bad packets ingested by, e.g., a packet socket.
> > > 
> > > Hmm, yes i get that. Two knobs? a. verify b. the per netns value ro? Both
> > > on by default?
> > 
> > A single system wide field is simplest.
> > 
> > Is there a benefit to making this configurable on a per netns basis?
> 
> As I tried to explain: a specific container breaks, you decide to trust it,
> you do not need to trust all.

Ok

> > If so, that's fine too. As long as root-in-namespace cannot modify it,
> > so readonly indeed.
> 
> 
> Right. So I envision along the lines of:
> 
> net.core.virtio_net_hdr_validate_all - validate packets from any netns,
> netns root can not change it, only host root
> 
> net.core.virtio_net_hdr_validate - per netns

Then skip the global option, as it's just a convenience: the same can be
achieved by iterating over all the per-netns settings.

Per netns validation, but only settable by root, not by root-in-namespace.

