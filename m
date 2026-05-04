Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com [209.85.210.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8BEE3DF019
	for <virtualization@lists.linux.dev>; Mon,  4 May 2026 14:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777906637; cv=none; b=A0fJkcl/xpBXfk5Xg4G/80qkCANlzQ7JrnK/N+4nj0KY3t3i7P9l5478BB79cZlHdM679DHR1STCOpKwjBkeoHVGnJ6koyWBZ+hIppAHaZNELs6F62b4TyLOY7zlcj+YS93h6vXJ3PG/pHPoZFlgi/L8o89aXTxrQSrjUX5UWb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777906637; c=relaxed/simple;
	bh=P5AYiYaexfBJ/K3fA1q4qvJtcqVqhbY/zXL2LN0DYa8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b3RIiR4NAK6/pFKukswRVFYpWW4qZpKpkqmmL0e4fuGab+SufXT5jKhcTxCJ5w82kxMrq9PbwSenB2z2WoazZnlejXfSKi+4c4xCucg4vGwd1DwLjVIobEGK3XT7Y7w0M69hLbDTiAWVHt+W35yIrjoxb8Jjbw/6pQcBZrUFLWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ShfXHyjy; arc=none smtp.client-ip=209.85.210.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ShfXHyjy"
Received: by mail-pf1-f193.google.com with SMTP id d2e1a72fcca58-835386ff122so1479643b3a.3
        for <virtualization@lists.linux.dev>; Mon, 04 May 2026 07:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777906635; x=1778511435; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Zh0KAxFwMLTC3nMk85f7Nx2m9dqehymzX+YJyU/vwmc=;
        b=ShfXHyjy1A4RR6nRUY4FXUxX+si84MUp1gMfxnoxe2DcoHTctjz2RGT5WAUD0+8vgj
         91JWWM7DonJLGJlzXSW1TKT4sVYBgvLSFsFjZ3RUvzTp264/TJ4GJmu7BCbUbGKk9VDu
         yZGP9wvhARm4YI91fGNrQ4NQqqXyWENwYCG/rO5G+kiSMuqxfAeUZGNAhSAd/SlY2EQp
         3gElaljWv1dPK3BP6SwM14Yt0cpTmb48IZ1DVOBtGpKBmlqtXGObT2c7Jr8gCVfGvefQ
         MJJhvVN3MXrvVyAeB8U85afx4DDI8hctTd0SN/hLpsFRn6S1nf0zCorrGuKsQnB8Lgrg
         44bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777906635; x=1778511435;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zh0KAxFwMLTC3nMk85f7Nx2m9dqehymzX+YJyU/vwmc=;
        b=mxKjk1iZHe2S8yxaT+49niErTN3UXn0BsVOkBxH8U5Zsg+2RC86UcepZcUHiV5HjT1
         4rlLfmHitho7NU4rjDnpbuwXTJDiS2hYND4nVcWMN1gR+DAZoydJuHHsqIPDP+2nPDoD
         y5nEUB+Y8pmTbcbM1d2XjWn1zmXDRqT+3AhgYl7LnTSi7HRGzUdApt8ioqmWWGqGNlW0
         A68skdyxCHAju7q1/UbmfD9RA3yrnhr9fwj+ZUpXGuOx7349qkvTt+S2x7DIQb9Feyv6
         EfXMgasgoZtaV9uXKGG2fO4VthLZP1M0hamGo02VWwWExgegpbmqnRYg90zlVG+whorU
         ztcA==
X-Forwarded-Encrypted: i=1; AFNElJ+2/L+JVOpy9t7t9gD1CZCaSdCOU7v//de2KrwJd4/vTGUZpelkEMb7XJvfBs2fBsDMiH8Uu12sZJoxUEQgXw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwLA3EGkDjz/i6MtWthQsSDjH11JU/BLpaZG+piII7mr3vX+PVu
	y+5+smaluhhmRM7ZGfKmikanzE9WZyRNHAsuuV4joihW664+sHBbCOKY
X-Gm-Gg: AeBDiesrMFh7xgMSKD0qHoXqTQyIB2RqEHKkw9gXYN7gZ6CqaiBt3P4EdjNajIR3lDh
	rkZ788RoQWUvdTYLTo6Q1V7X8DpXBPV/XFunheJAFmIXn7tFBPI87JS4+oA5r93Bkqblv6WTTGl
	TzSYE6tZe9qSY9kNeo6Eh82pWyw45M6ppCU0hZ20UIUvvmFmqPP8GlBSt1f/KJNIecRO1LLrW6O
	xhDSs5N2Frj5a7snOsPKykX4qq2n0sjr+C929YuTJBJOnKOjWAfr3rI8Nod9CYUIHyH+DS4xgQU
	lhwUInsCX8fXIXXsERBarSwODchmgajCpOIB12PsTPSR8GSippB1ulAQCV3iHSLJ2ecFV9dcg/T
	+a0KaQpfcYxKxZQRiNWCSnEgMdbJQKdgBhPf5iv+dEsJyHGY8JJ9T8nGD9x6FpXly5ahHwvuHik
	WRh5ud3m296SN6JZRz0SgCxAePoA8=
X-Received: by 2002:a05:6a00:a1f:b0:821:7d7e:41cd with SMTP id d2e1a72fcca58-8352d012d24mr9616412b3a.10.1777906635168;
        Mon, 04 May 2026 07:57:15 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:49::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-837aa3e4f30sm3467508b3a.1.2026.05.04.07.57.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 07:57:14 -0700 (PDT)
Date: Mon, 4 May 2026 07:57:14 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Breno Leitao <leitao@debian.org>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux.dev, linux-kselftest@vger.kernel.org, 
	kernel-team@meta.com
Subject: Re: [PATCH net-next 3/3] net: selftests: add getsockopt_iter
 regression tests
Message-ID: <afizImGChdnDsj9S@devvm7509.cco0.facebook.com>
References: <20260501-getsock_one-v1-0-810ce23ea70e@debian.org>
 <20260501-getsock_one-v1-3-810ce23ea70e@debian.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260501-getsock_one-v1-3-810ce23ea70e@debian.org>

On 05/01, Breno Leitao wrote:
> Add a single kselftest covering the proto_ops getsockopt_iter
> conversions for AF_NETLINK and AF_VSOCK, using one fixture per protocol:
> 
> netlink:
> 
> NETLINK_PKTINFO covers the flag-style int path (exact size, oversize
> clamp, undersize -EINVAL); NETLINK_LIST_MEMBERSHIPS covers the
> size-discovery path that always reports the required buffer length back
> via optlen, even when the user buffer is too small to receive any group
> bits.
> 
> vsock:
> SO_VM_SOCKETS_BUFFER_SIZE covers the u64 path (exact size, oversize
> clamp, undersize -EINVAL).
> 
> Each fixture also exercises an unknown optname and a bogus level so
> the returned-length / errno semantics preserved by the sockopt_t
> conversion are pinned down.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>

A few nits if you happen to respin (or for similar tests in the future):
- add ASSERT_EQ(optlen, xxx), won't hurt
- christmas tree (although not sure how much we care, you'll have to move
   optlen = sizeof() assignment)

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
