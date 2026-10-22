Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792678452;
	b=IZQ6I96DEH2l8fRaRSJkwmuBPPtxyrvZ8LSglqeHW9ZpWi9gpqjFU1amX2FwjbaPafbC
	 koS4KY7I0PssG33bcdK61vjyz7z6fSlX1ZPBQyEqO2WHevU7vk+cQxxBuY166gq1tcVQc
	 MzGOBd+90jDsC5G0jydvtfZPEJwATGsBpmPC4p1biP2fp2O2BOE+YywqRqbiQyRBS1unP
	 ryhnFxN+uHDhhiJXOG/fQ0pPH7MsahwBb+XDF/e73UScU/L8cnfqt63lmEJFJ+Mw3oP85
	 Vc/dEPYwPT+JoRwnSKoC/HolnCXWPRo7KEB1gNAI8qijqJA0APKiduvxieaOR3mFEMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792678452;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=ar1E8sP3jvEI9uhwbxm9hO7paRp/1SObcXepAZxmBtQ=;
	b=ANUoy0vBwtGz8gX3z9A0z9Tu5HolLn6fSYY2nRnsr8uOghKgqSZOaS/0V+JUyDqx+Z6p
	 mBaef3Y0+yXG/8+kXX8pynHiHDoKazTMADRNmaDKFFX0jra8Mvow3wTrycsxHonV49bbS
	 dJQ9xfyRWn1U1gpgKCMfJBrBAIXF2qWmFDs4G3bn95LaXP2VXp+zq4M7S1ui9QstCKOWW
	 XodEF1uQUr5nwPptiu8cy+NUDKZO6jqWwzDRbgY8LW7AWCUoHhbsSwPPf4ZyArgBSvvVg
	 6iyRgNm1XmnlpqMrSzBRXHlKYQeAoFeFDdrjfmBGzTkADQGp38eSXPMqaW8F3+B1o8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Zv51UqSL;
	arc=none smtp.remote-ip=209.85.222.53
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 515C1606A31D
	for <virtualization@lists.linux.dev>; Thu, 22 Oct 2026 14:14:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 515C1606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Zv51UqSL
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-97ca72f2cd9so1277874241.2
        for <virtualization@lists.linux.dev>; Thu, 22 Oct 2026 07:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792678451; x=1793283251; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ar1E8sP3jvEI9uhwbxm9hO7paRp/1SObcXepAZxmBtQ=;
        b=Zv51UqSLN+eeyN4IjgID5j8BsnLP8O2OCAUA4w/OeQvEOQybxDubCSLrB1ya9Oti1z
         Rp+huhbYIRsa6c1oQhaz88Nqnq37ii9aCdrpSGhBhsAhFiOx1p9stAK3G1kYyYF5KNPs
         n0Gbon88MjmehxDN7rLagU9ulKz8yPzlpgSRLEVpE4t1KVjLPTYv42+q3hfNB/v4SuIa
         QLrr2NCGvrNfvH9pEb+oJUEhLaEx4Y0Z/KJlNEd0twZyDRtqTg0DPi3BVTxy2SoiSzFq
         AxXSyhx/6k3B3Ykt8h8YLIkVYpfsQmrcGMfs4wa2iWzrt4rFs2DjxBlCu9On7MeFmMJl
         Sdxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792678451; x=1793283251;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ar1E8sP3jvEI9uhwbxm9hO7paRp/1SObcXepAZxmBtQ=;
        b=zq/EI4aJn8VuhAqvyqZDUHsFoCSRgvTADwa0fRuhllvX9RCcNEI1frTcOWnxnKGXPL
         vtts1CaCbS+jpu/nDsh3GuM36U5R8tnhZERapxOnbf/2de6tLcwP3GNMQEeL9PaQW831
         jgpJkkf5NcTCDYrniv4Rsk8JD+dUugoks6fOuJuRdyteVs+TqnupNWzVjt2s1+B0xAnV
         2SnnRmJ2gT8nb2/qAD7sKFSTbBFLfXDH50p5yrdj8Abp30K/jgI+LwBMWvd02xSFBK2h
         2LwWXGRJ0ObOqB/v9rrDGwAGgiVAj1Ixn6846aMSpnWVYv5oOgWbxNDVpD/T4g9BtsZQ
         DX1g==
X-Forwarded-Encrypted: i=1; AKwUvByZ0PhVpxAF2BgG7A1g1OiE77ViCO/2ubm1B5o6RbsHwFc8xUC34HrjSPxfs/C76OKUjo23g9BdH5d40PmAjQ==@lists.linux.dev
X-Gm-Message-State: AFq9FYKJegUAwfnt9mpjFLkFzEyqbk8j1ZhF3A5jTp6IAH62p17O0Bpb
	tfnEeZXD5r00lYNcn/lMdz1xFkR44r0n1NqLHJpQXmo+xBMSnFBSEHJl
X-Gm-Gg: AYBFou1g7xMt+IxgHRl9CYxvkYIJbiIYYNvCzeGMwumyp3qCog8WGL1J9ZQC+59lW/p
	AQFk4TnZQn1LxG+oKh7Gv0NI6IhcECngH9fGbs3T0Tg4HW5CIXeazXVGlnn27rXU8r7nUoqJSp/
	lHjfMeWIEZseZ72+zVEZc5BLZm+NJAry4/viE82cYVU16rFG98WC4rpfF1tKSh5P7vEKNyImmTP
	/Z400/hWF+JRukNx4+SCIp/2qgUdXxguh0jWe1CMWTES8cXNtN415Lkp0dLnyhDZ6DawAe8+6Cx
	MFs10D0yibCFLyGVydaX5Q8oZIhH1CuI5lhcnh2nlCqHH6cPwf6etNh/MJDQQoOz5BPDgdaFg4k
	lpKGl3A3BrgdsKJcy8HfPYTLHudFc7VJGcYZD4hiywrlv6ZZYHyITtF05yNIt8BhHJtBRjQ/qhv
	5zifS6E18Op88W4kNWhlKwMn7o2u5V6WqCOjS/l2mFsnVS+qVcVIHHGCpfKfA7Ecf5aoy1KJkdo
	o8flbH/ZHbm03F0fzNwsLz6J7Z0ElFKii1cafSdFERvVqUA9dyD3fxyvWzOFCAv1HE3tgZUFPns
	ZRkf6bFLNOvBnwN8ggrIgvcm+CeybPVyG0xx+hjoPH1UOl84r+zUwMHadqUU2PA+UuemKU67yZ0
	+rHIoZsTs+nphVwGH/T0=
X-Received: by 2002:a05:6102:160e:b0:7c3:f07c:f49c with SMTP id ada2fe7eead31-7cc9264273fmr2170632137.11.1792678451117;
        Thu, 22 Oct 2026 07:14:11 -0700 (PDT)
Received: from gmail.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7ccb8fd4dfbsm1074530137.10.2026.10.22.07.14.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 07:14:10 -0700 (PDT)
Date: Thu, 22 Oct 2026 10:14:10 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>, 
 Cheng Yongkang <teel4res@gmail.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Jason Wang <jasowangio@gmail.com>, 
 "Michael S . Tsirkin" <mst@redhat.com>, 
 Eugenio Perez <eperezma@redhat.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S . Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, 
 netdev@vger.kernel.org, 
 virtualization@lists.linux.dev, 
 kvm@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Message-ID: <willemdebruijn.kernel.78222817ba37@gmail.com>
In-Reply-To: <9756cf25-6951-4330-959b-3260f4760c3e@redhat.com>
References: <20261022091847.3654028-1-teel4res@gmail.com>
 <9756cf25-6951-4330-959b-3260f4760c3e@redhat.com>
Subject: Re: [BUG] net: tun: zero-copy path can expose uninitialized packet
 data
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

Paolo Abeni wrote:
> On 10/22/26 11:18, Cheng Yongkang wrote:
> > The experimental vhost-net TX zero-copy path can hand TUN a user buffer
> > whose effective vhost virtio header size is smaller than the TUN
> > device's configured vnet_hdr_sz.  TUN computes an skb copylen that
> > remains larger than the bytes actually available after stripping its
> > configured header, publishes skb->len from that copylen, and
> > zerocopy_sg_from_iter() initializes only the real payload.
> > 
> > The resulting frame contains an uninitialized tail.  The tail can be
> > read by userspace from the TAP peer through normal forwarding.
> > 
> > Observed on Linux v7.3, commit
> > 08ab31164c55f20c7a2653de3186ae333470e2c1, with:
> > 
> >    init_on_alloc=0
> >    vhost_net.experimental_zcopytx=1
> >    TAP vnet_hdr_sz=200
> >    vhost TX total length=256
> >    real payload length=56
> >    TUN copylen / skb len=128
> > 
> > The exact control with vnet_hdr_sz=10 delivered the expected 246-byte
> > frame.  The corrected trigger delivered 128 bytes after submitting only
> > 56 payload bytes.
> > 
> > Sixteen of sixteen corrected triggers produced the overlong skb.
> > Eleven of sixteen had nonzero bytes in the 72-byte uninitialized tail.
> > Several contained recognizable stale kernel allocation content from
> > previous skbuff_small_head users, including fragments of environment
> > entries.  Those bytes were never supplied in the virtio TX buffer.
> > 
> > This is a userspace-observable kernel-memory disclosure on a
> > network-forwarding path.  It is configuration-gated by experimental
> > zero-copy and an enlarged TAP vnet header, but the overlong skb occurs
> > regardless of init_on_alloc; init_on_alloc=0 is needed to observe the
> > stale tail in this test build.
> > 
> > This is distinct from candidate BR-023/BR-025, which exercise
> > IFF_NAPI_FRAGS.  This reproducer uses the non-frags tun_alloc_skb() /
> > zerocopy_sg_from_iter() branch.
> > 
> > I found no direct upstream fix or CVE.
> > 
> > The vhost ring reproducer and complete program/console logs are
> > available on request.
> > 
> > This was found with a multi-agent workflow; the
> > information disclosure was reproduced in QEMU/KVM.
> Please stop this AI-generated test-walls dump: it's not very helpful
> except for other agents consumption.
> 
> Really, please stop now.
> 
> Please instead ask your LLMs to try to generated fixes for each of them,
> manually review the generate code if you have the skills, and share
> the patches on the ML, at a very limited rated (no more than a couple
> of series in flight at any given time, with no more than an handful of
> patches overall).
> 
> Please consider collaborating with other already in place projects
> (i.e. nebusec) to make you finding available to the community in a
> responsible way.

+1, see the documentation on how to report and help address potential
vulnerabilities at

    https://docs.kernel.org/process/security-bugs.html 

Do not just send reports of unfixed bugs to a public list.
