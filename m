Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBEA652FE59
	for <virtualization@lists.linux.dev>; Thu, 15 Oct 2026 19:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792092110; cv=none; b=q4SD+wxegxxIGNRcqJlI8bagDRBY9sT55uQiXu5DdT019bOVv/pQOU+eP+k/GlhhpVrBbfb7yz1rTV9dnRfR0mWh5VSy5oFU++bFc+Pd7fDVR5jjXvmfU3v5hqACxUWqGLEYakDXPZimx+tbylmeApqnwT96dSq7UsJ0C1hOiGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792092110; c=relaxed/simple;
	bh=bWDcTUXKRCpKArq8mJguYgOf7WaUeTmsb/woHD2+h/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T57utGqyw3/8B6LKDAqf3EFsbo3jYUf53/17DE0q/xWZACWw7DeLQaCvK4fRF1ploRhVMErBbXkRpG1KN6txihubsDthuRpFXNs/H+kcw8gSLUpHe3CEfzr1+8yF+jtZL1ZXaF7rc9sDip98kgL/Pfxy02OaO4ZfhtWy5vkk/w0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=GIPLnaXB; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="GIPLnaXB"
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-823545ce223so1845828a34.2
        for <virtualization@lists.linux.dev>; Thu, 15 Oct 2026 12:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1792092106; x=1792696906; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=rbjX2NuExPWvz07RGXa2HRp0BDpTUBaueEzzQnIB3cM=;
        b=GIPLnaXB7XlamNKPPDxivwf+lVca/DXaKZNdjWA1xGHXtMufTvmg5880FXwXRevdgg
         Qp7svxKrzVxutTUtqQBLkFFl2r1Ma1G1tW+tGCfYCR33TpuOYbcXK1HH6syqdESd4zFk
         Bd7DgBcus2zZpmbQwpj3OLXNO8UXV3RFvf+G7HXJT95pF6MoIFu/wSgMhuPeLOGqpPQQ
         1RFC6J9syRLkmUeNO3mUmAaP3MmU/l8wi63bclETJiIG/v3bFuoF7MuIxCXz157+IZpn
         HT8dSRg9XzzkfOSivJYnZn438pwM+tY1otDTfZKeuEDDD8CIs0UDazzTgpKf9ZiwJfVl
         5avg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792092106; x=1792696906;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=rbjX2NuExPWvz07RGXa2HRp0BDpTUBaueEzzQnIB3cM=;
        b=QFZRDqnstYVxXB083SB8YD/MQCjhK6QIUDMS/W4KuENJK7LIwkK0YBVM8FsT1XQQj7
         mUoT9aekg6DF1Y6r9lVAjXQG2LaK4C81wVVg0Vui0vGj6BQ1cYzjI/fBH5YtFlb3FiF4
         BJCnreqZaMqwtcga5d7udyXzFa+FLI7wfWTGCl0Yhblcp570Q1DGsGgdbqtk9Yh4+Hg6
         JKfXrGkXFkYAwiGpuf6SosQsZsZ4NAbUVAc26043dZiUBr4/DuENk1K3sZmqjUfMEnCe
         ZsKMHs4pdNayEsC1FyWO2Ji0KO1XykBUJKAGl32PBE6iCflLMcRZWI/2JEn4w4xFMpdP
         AeEQ==
X-Forwarded-Encrypted: i=1; AKwUvBx0zAy6LO1r3o1mZoopOUpGlnvLD7z5QVxMhcNlmk4FlWLl+lh1zZmtvYgYU3e/Kf5t+Tk4obuigs4NjuH43A==@lists.linux.dev
X-Gm-Message-State: AFq9FYL92DutlpZuABDMYIuvUstGUH7ngppluaZj+L5VIwWEOX9qngtI
	MMGYJpDujEN4cTap4pmlduxhrhfBmMjVre2Mbe6pnEs95EKYFq0rXujVL+WEydOxsCY=
X-Gm-Gg: AYBFou0hGbDzDpqFbg3+qcIxw97suzBeO0d4K6DnCJnXJeIbYVedw8W3Ly4IijjvOM4
	phztYvGfc+3NHjnyfy+Zr7goGpPH4chpP9juPLdzOmCd99TujrMdJnyR4OS64h+VM0DGDdq9H7H
	atHr/fVNHMi3mvK5z1XpE/KwlhnrjLVPaaAbfcfVqpVdCszJminkOElAhthiEQX4+yx4pRP1XBc
	iS9ff1/esu/1qIehHMki242QSeN9wbVoQWdhknM/AsPqKzolxkkmYwNpEuUowDMFh1wpZ3ThUU8
	vpnwWpQ7amrSCY6jKJUMhngBELqw64Db25RBaH0Gs8W8tosIZqlSwg5FuGtxHtlsVa7Xec8C3Z4
	8tYdhZsnAb4EWzIOkJhlFgDGb36ZHe60HQ7U4hB0ihB7VXbXxPia92zkla7RmeToeL1MwNpt5Vy
	18t9iyZyMBm0uiPyLswmjfL62Ipe6KGM+hDtAARpxLOvUCD4w4BPvWCA==
X-Received: by 2002:a05:6808:3204:b0:4d6:9153:2962 with SMTP id 5614622812f47-50c58bd58abmr17672455b6e.51.1792092106515;
        Thu, 15 Oct 2026 12:21:46 -0700 (PDT)
Received: from 20HS2G4 ([2a09:bac6:bf21:3737::580:5a])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-537b247b19asm295516b6e.3.2026.10.15.12.21.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 12:21:45 -0700 (PDT)
Date: Thu, 15 Oct 2026 14:21:40 -0500
From: Chris Arges <carges@cloudflare.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jason Wang <jasowangio@gmail.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, virtualization@lists.linux.dev,
	Rusty Russell <rusty@rustcorp.com.au>,
	Max Krasnyansky <maxk@qualcomm.com>
Subject: Re: [PATCH net-next v2 0/7] more virtio-net csum hardening
Message-ID: <atEnxBYUQNkjUXfA@20HS2G4>
References: <cover.1792067836.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1792067836.git.mst@redhat.com>

On 2026-10-15 08:41:12, Michael S. Tsirkin wrote:
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
>   net: account for ingress-resolved virtio net hdr state
> 	- accounting, not the fix itself, dependency of the next one
>   net: resolve uncommon partial checksums at ingress
> 	- fix itself
>   net: add a sysctl to opt out of virtio net hdr checksum validation
> 	- reducing risk of the fix by adding a sysctl to disable it
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
> Michael S. Tsirkin (7):
>   net: account for ingress-resolved virtio net hdr state
>   um: vector: honor virtio net hdr conversion failures
>   um: vector: trim skbs before verifying the header
>   net: resolve uncommon partial checksums at ingress
>   net: add a sysctl to opt out of virtio net hdr checksum validation
>   net: add ip4_parse()
>   virtio_net: cleanup protocol calculation
> 
>  Documentation/admin-guide/sysctl/net.rst |  15 ++
>  arch/um/drivers/vector_kern.c            |   6 +-
>  arch/um/drivers/vector_transports.c      |   4 +-
>  drivers/net/tap.c                        |   4 +-
>  drivers/net/tun.c                        |  41 +++-
>  drivers/net/virtio_net.c                 |   2 +-
>  include/linux/ip.h                       |  24 +++
>  include/linux/virtio_net.h               | 249 ++++++++++++++++++++++-
>  include/net/netns/core.h                 |   1 +
>  net/bridge/br_netfilter_hooks.c          |  15 +-
>  net/core/dev.c                           |   6 +
>  net/core/net_namespace.c                 |   1 +
>  net/core/sysctl_net_core.c               |  54 +++++
>  net/ipv4/ip_input.c                      |  13 +-
>  net/ipv4/netfilter/nf_reject_ipv4.c      |  13 +-
>  net/packet/af_packet.c                   |   4 +-
>  16 files changed, 404 insertions(+), 48 deletions(-)
> 
> -- 
> MST
>

Aside from the KASAN issue described in the other thread, I was able to
test this series and it fixes my local testcases.

Tested-by: Chris Arges <carges@cloudflare.com>
