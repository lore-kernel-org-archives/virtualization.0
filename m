Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792428713;
	b=A/KC/qDDtLcoiqvQVutreYaPei5nECNglXF2nnufQnIhNCBt5Z5A+gH4JVtkl2lpaSJt
	 lmVOO9Sudg/kAABMQ+KMQ4SHwxclqYv2OisheeIcXisMwQqzKdtWoAb1sRngSXuXXXT7+
	 H49BwgMiStuzkhZkYy2ymATGU6D+GNYe0tW1ueg/plk+e8QWh463Wen6MTfOzl6rTLndf
	 3yubA+YZaFyCip010OqJX/kZVIwINsfl9A/NlgYidt/oDIrhICdnsZkNwuSipZlHCAx+S
	 x7SlERrZ+IcKHMn2HW2USofZSphLHp6v3Xux2TAZho0l4kd4KnngktG8EnquMDDC+AQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792428713;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=GGZr1o3aGctzMnwygsbHm91Fqbk3LTUuMaHfiMRf6n8=;
	b=3LeHBxaA6Q5CgeJVtrUQCEphDyS5TAm/GBcv3CYXKIB8Tm4DN9FiTW1QIxtyVKdb8u/0
	 fHgjgthHPvAG7V6T6ayzI6HFWkCAiAVkVsItGYSmpyIZixmeM3CoE7CKpcq9mGTUveS4f
	 q40+mE/hKGjOcJ2okMr22/1Ag0Eyzhfd20BULsS2mdTFN0auf3Z9OmxSM7P0pmxCstx9D
	 LJJUVpNgmY9yAazW16FgEmiSq0HvDuaOeSXT/LXvd/wFMjQjR6SnW3Xmn58dc8J8EgtNy
	 78dF8M7AtDJvnyxoaj4bA0hFGZjvHKa7Mz5VvgexnDgiGHar71OgbIWYuR3SNn4dabQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cloudflare.com;
	spf=pass smtp.mailfrom=cloudflare.com;
	dkim=pass header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=CAOOROj6;
	arc=none smtp.remote-ip=209.85.160.49
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8767F606A31C
	for <virtualization@lists.linux.dev>; Mon, 19 Oct 2026 16:51:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8767F606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=CAOOROj6
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-4877837890fso1132871fac.2
        for <virtualization@lists.linux.dev>; Mon, 19 Oct 2026 09:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1792428711; x=1793033511; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=GGZr1o3aGctzMnwygsbHm91Fqbk3LTUuMaHfiMRf6n8=;
        b=CAOOROj6KwPYxU1HNVqx01Rm+1GHe5qarE0nM+OxB4psSKfaeaiK3JxdaLqT91pq04
         QDzM0kh3oWH4kjeGije6FoIGkqSbKzQajTl9ABUnsm8a2uRjXR2E3YVrp31mqsNYWDKn
         eHbbhhgfxcoC1oerbqc7AItpM2kcXKB2v4VuB7ChUqd15U8B3e1s0j7r6aHAJj2Yt74g
         t9V6xhRF9kngpKYZ/lvd+SOeqk8/SMGZQ+3F7OrnKlwueuqXvSuFs6HlmLjxYBNONovo
         31f+0FedTlyrHTnZ2PayofSpdUvrUTB+V0Yi2ijWmVn+T2Y31dLn1bBrumTelJWI/L7s
         U0UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792428711; x=1793033511;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=GGZr1o3aGctzMnwygsbHm91Fqbk3LTUuMaHfiMRf6n8=;
        b=T46wv628FcjWDtMDUhPiFNOPWQPYhrgozml3SYUlJd0MCP9JKihY6Shb+FP8mX5bZ1
         MH3Yl60SqdOAVU5sYlGPLvUlAohBKMliCJDltBZK/ZGVGiRP0wHstyf726HQLp1NHk7l
         uLdWOQwWv1AnaGMc63Q9qi+lpGLBecXaWh4rS/edVnc1iPs6upsHzd0ye4WUekntGZPB
         mUZkuyitEhQPnksxo/MUJ4Vz1Lh25penfLmmDkrVkvOn033ZUHoLo852HM91JPpW/g3Y
         4d9g6oGgwO9/kkqG+csSC/LoiGIspIYp2GrJloRFuU9cgOzIIOK8AMkEuHkIxRpTmRxg
         KBCQ==
X-Forwarded-Encrypted: i=1; AKwUvBzIgdjWtADFPcfLao4kbnqa04R6H9BBEcXSeJx4u2kjOlSlMK91kCkX0eoAOEANLmTPFG+TuJ/pDk1agIZSZw==@lists.linux.dev
X-Gm-Message-State: AFq9FYIeOYBsRDnybsQgDRfn5GNbNMOGM6dFMlBbIxZoXkiBww25rNrJ
	Nqt5rsSTbtca92YRQzah83toiR9Tcct7qGhdaBgrpqpULRLtQQxFjy7ZI2VdVrn+jJE=
X-Gm-Gg: AYBFou3gbItmWOyjauu7qrh4LQSpCUGd9hSyrHMJRi1dVmaRBBAQZapSUQUjtlkcVPZ
	UR/wKrbuiK39EESDIinArNm9zQizx3hK7NJM2z3VYFT3YPPkvI386Gx0yMUVbPo1nNbG/CBgVUQ
	nTnHcLxyusPnvK9OvjzfXvl58AC8PBtXQAn4qsgBMliUHzwgg5V4nArLUuH8noQ5a0L59KQLOK5
	avgRD4scqYGtDe+qTdwo7jxF2o+wHzR1dE8k8dXFebJqOCgR1CmjaCFtNPIz96djSDUcMd5vBvT
	gRLcNONFzB2uM6vwnBxmE5US3136kMK+Sw/zfRn/TLElyfQ2qwVvQbKz0A4mibxjh/nEeKY8pCA
	VnNig5npB3gZxi7qQ9y5vPbEsp5/kzG0bV74ZPVjkWMXD+kkUIU3VP1BuzB9mnx3JFFWXlgttgA
	iOvhD25xaxotDHq82tDCoN0TIx1gt432eWnA5AKgxn1G4ALSY39MBDn9RyIBZ1ol8ygibVGa+5u
	5BeKBUrATu2FhZAeZsirjgUZ5ASvXShi73x9Sk=
X-Received: by 2002:a05:6870:3c13:b0:494:b8f4:9a22 with SMTP id 586e51a60fabf-4a757917efemr6305805fac.28.1792428710995;
        Mon, 19 Oct 2026 09:51:50 -0700 (PDT)
Received: from 20HS2G4 ([2a09:bac6:bf21:1c64::2d4:c2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4a73b640adesm8785424fac.10.2026.10.19.09.51.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 09:51:49 -0700 (PDT)
Date: Mon, 19 Oct 2026 11:51:46 -0500
From: Chris Arges <carges@cloudflare.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
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
	Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH net v3 0/8] more virtio-net csum hardening
Message-ID: <atZKogiEAkStdgQ2@20HS2G4>
References: <cover.1792411304.git.mst@redhat.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1792411304.git.mst@redhat.com>

On 2026-10-19 08:03:00, Michael S. Tsirkin wrote:
> 
> As reported first by Paulos Yibelo <habte.yibelo@gmail.com> (after which
> others, credited below, found more ways the bug can affect users):
> 
> allowing untrusted hardware to specify csum start/offset for
> CHECKSUM_PARTIAL was not a good idea, because, if it edits the packet
> outside the actual checksum, and depending on the setup, the networking
> stack could be looking at the packet both before and after the edit, and
> seeing different results.
> 
> Previously, commit 6785011f8b16 ("ipv4: validate checksum_start before
> completing checksum") validated all known instances where this
> causes the most grief, but the real fix is to make sure
> that either only actual checksum fields are ever edited,
> or the checksum is completed before the net stack looks at it,
> so it is always consistent.
> 
> 
> This basically goes back to
> what we did before f43798c27684 ("tun: Allow GSO using virtio_net_hdr"),
> except in a narrow list of specified known good cases.
> 
> 
> Summary of the patchset:
> 
> These are definitely net material (and seem to be too big for stable,
> or I would recommend backporting there, too):
> 
>   net: account for ingress-resolved virtio net hdr state
> 	- accounting, not the fix itself, dependency of the next one
>   net: resolve uncommon partial checksums at ingress
> 	- fix itself
>   net: add a sysctl to opt out of virtio net hdr checksum validation
> 	- reducing risk of the fix by adding a sysctl to disable it
> 
> These are cleanups, can be deferred to net-next, too:
> 
>   net: add ip4_parse()
>   virtio_net: cleanup protocol calculation
> 	- cleanup resulting code duplication
> 	 (kept separate to simplify backporting)
> 
> Fixes: f43798c27684 ("tun: Allow GSO using virtio_net_hdr")
> 
> Changes since v1:
> 	- reorder patches to fix bisectability, addressing
> 	  a comment by Björn Töpel.
> 	- code refactoring, different patch splitup,
> 	  a sysctl knob to disable as suggested by Willem de Bruijn.
> 	- fix a bunch of minor issues spotted by LLMs
> 
> 
> Changes since v2:
> 
> virtio_net: parse tunnel csum_start little-endian
>   - new patch. correctly parsing the header is a dependency
>     of validating it, otherwise i do not know what to validate
> 
> net: account for ingress-resolved virtio net hdr state
>   - make rx_csum_sw counter 64 bit so it won't wrap
>     (spotted by LLM review)
> 
> net: resolve uncommon partial checksums at ingress
>   - tunnel fixes to bugs noticed by Willem de Bruijn and
>     Chris Arges
>   - restore the csum_offset checks as suggested by Willem
>   - parse csum_start in the tunnel header little-endian like
>     the rest of it (spotted by LLM review)
> 
> net: add a sysctl to opt out of virtio net hdr checksum validation
>   - the knob is no longer writable by root inside a user
>     namespace: changing it now requires capable(CAP_NET_ADMIN)
>     suggested by Willem de Bruijn
> 
> net: add ip4_parse()
>   - comment converted to kernel-doc format (Willem de Bruijn)
> 
> um: vector: honor virtio net hdr conversion failures
>   - commit log tweaks
> 
> New patch:
>   um: vector: trim skbs before verifying the header
> 	found by code review
> 
> Somewhat tested, tunnel also tested now, um part compiled only
>

I was able to run my tests and can confirm no more KASAN errors. I did
not test the um patches.

Tested-by: Chris Arges <carges@cloudflare.com>

> 
> Michael S. Tsirkin (8):
>   net: account for ingress-resolved virtio net hdr state
>   um: vector: honor virtio net hdr conversion failures
>   um: vector: trim skbs before verifying the header
>   virtio_net: parse tunnel csum_start little-endian
>   net: resolve uncommon partial checksums at ingress
>   net: add a sysctl to opt out of virtio net hdr checksum validation
>   net: add ip4_parse()
>   virtio_net: cleanup protocol calculation
> 
>  Documentation/admin-guide/sysctl/net.rst |  19 ++
>  arch/um/drivers/vector_kern.c            |   6 +-
>  arch/um/drivers/vector_transports.c      |   4 +-
>  drivers/net/tap.c                        |   4 +-
>  drivers/net/tun.c                        |  41 +++-
>  drivers/net/virtio_net.c                 |   2 +-
>  include/linux/ip.h                       |  27 +++
>  include/linux/virtio_net.h               | 272 ++++++++++++++++++++++-
>  include/net/netns/core.h                 |   1 +
>  net/bridge/br_netfilter_hooks.c          |  15 +-
>  net/core/dev.c                           |   6 +
>  net/core/net_namespace.c                 |   1 +
>  net/core/sysctl_net_core.c               |  60 +++++
>  net/ipv4/ip_input.c                      |  13 +-
>  net/ipv4/netfilter/nf_reject_ipv4.c      |  13 +-
>  net/packet/af_packet.c                   |   4 +-
>  16 files changed, 445 insertions(+), 43 deletions(-)
> 
> -- 
> MST
> 
