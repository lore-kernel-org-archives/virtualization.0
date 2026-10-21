Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792599249;
	b=gcqXVP8cmenGqJL55gvr8AmgPLo5vXLBPCLCCWItDRpQtk2G7R1bKzl3bwY5d34fEjeJ
	 +CoLcNd9PEpk2gGnsmtfXy3QDLjnu/YNu36IBjk1yEBSU7rAVap7scFY0agvaWkL+Nd6E
	 uL0n6jxVNBL2pIeLdW6b0N1Yak3+nElbbd8Uf3+DBODt/8T9wnBdOVKcq3hx7zfhbfthl
	 mhuUDca3Fw7BcpE09nqXVHSuJLexj3YmiyiZ+bdy0+GrdW/4DXGga4GGMeYd+Ju9Mf+dB
	 XnLsZ7TFysRXEGYEjIAZQtzZazaASooOUTybm/2SHjSA4ERsmAA+1IWu2vVupg+8mgA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792599249;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=q0CCx5zBhN0UXD1LzII8NwADZSGCTEpTQppyCBNHFl0=;
	b=BbDBUo/mkq0su8mIebxT3SkmdlydEIX34VsJSaHn1nQmeIqfV6kcjYK2+FLeEfe+YnhL
	 f25KYT+PFaMMI1iFqEFsV28BjBOWJz97Y6v+Ux7ZEM/QXRC5E62arrd9ju2+9GLtc7IlD
	 f7IN2NsPOwl8HiURbeyRGkjn4x7ivJpH9pGYgK1NyUHwdY5PzRKX3KdawYUu7EuiKSZPI
	 0ZISUlC+HqfNeZDj7AcUb34j4RtovGv4w+0CTRWIhwXA9d2Bru/q/LirxpQ5pwG7HkulO
	 NFCOqBNtyjqNO3nSqBfXI3Hcmbff0i7gCnEmpow4v5rXp/sTIunuhtV0xlm0q+rkS1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=s1zy7ptG;
	arc=none smtp.remote-ip=209.85.217.52
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B236D606A578
	for <virtualization@lists.linux.dev>; Wed, 21 Oct 2026 16:14:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B236D606A578
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=s1zy7ptG
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-7cbbb7b90efso334138137.2
        for <virtualization@lists.linux.dev>; Wed, 21 Oct 2026 09:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792599248; x=1793204048; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=q0CCx5zBhN0UXD1LzII8NwADZSGCTEpTQppyCBNHFl0=;
        b=s1zy7ptGphPks8uIZ8yehRLYG7+u3wj8dkCAOYjnQtHmo7ZaBMHWMiLza7OQbpbkRI
         wdflMbeShlNtgj2fziy0sAJMIBhTwmIwYrySpZ5WZvT8WnMp/xXWGqiguDD+pNqIijjJ
         CggIwl6qidgynT1yAuWDd77y0DgNFVy44SVy4KpT1Lem6XS/S5z6aXyKG4s1D5TV8O4Z
         Wa9bQ2H8akZZqS2NlXAMrEkeI697R0nvHOUO3Uh5+JjXrqo10izaJ4TkDQWGnmd5CA8E
         eY9mD66Dhqq7twb23PncQwx8BhJDo0ZdgXK0Sv7JXwR9zxjq2Uqrkxv9KN9tnTffG/FX
         meBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792599248; x=1793204048;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=q0CCx5zBhN0UXD1LzII8NwADZSGCTEpTQppyCBNHFl0=;
        b=pgtmOUxYVf3roNCs/3ksf6JNxTUoz5GWxe3LDwd5094M6vDEfY9a4ezNMGFvP4iqdB
         lyMhwRGGZEjM65bch/K60XpH4XHXRGVr/BWYDp+8RXnt4xDwmkSsS2tDgARg107cSWz9
         ENcdaptp9mspSecqxXYJhFGLAgv7yWHPNOfRdEizo8Gv2M+ZVj4kKX431/wCSA4ayLs0
         7EeMMVDoqi1btWgYCgRVIx8dDTmneXYLh05+7NYdodnLArqqPSgOkuIwnrEf1vzkgJbb
         ZNih6kGwd9NZmiQvsvSAtTFVHhLw5r/BCi8YqceYcN67renY700Q9bXJg5e+4VAfv0+4
         8avQ==
X-Forwarded-Encrypted: i=1; AKwUvBzaMSVBuPbO6x7HHYiGRttwsKK3XHDuIDJnlVuJ2QBMXVX6lrJeZE60DLECahhL227yZUHEpOE2pjhZqHxjBw==@lists.linux.dev
X-Gm-Message-State: AFq9FYKshYYNEid/I98BDQaIXWPci7GJC0HfY2RiTD2XPCwIbtKTPO9u
	CLuURS0qRHsX9ZCWyx8xNtE/IFmUYCdZ7l5wRz122+0I6CcskekccBXE
X-Gm-Gg: AYBFou10mGiCByYq4XaLfNtvao8XvKdeX+zaw6c0buUs2twILZAdgUwEK5hyFzh+Edu
	DmOAhHdIfOq7DIijkxX7bBsCX2Yhcht9lwlusUSN5bizwmXYfAjVOeQTMxgOiLwlx5HbggT3dAF
	xJPGgXROCFqCMf5DHLJSPbzfHWSOWrfxz2m4358iXAgVunysbMdHIhrFlITyutgO+Nd2v889Wig
	iBF/jJaN4rlFqnMx6mvLa/RJWZM4L49xkA1MYx6ZP5v9T436Yj+7pzgkw+VIFaoK7lrfFIHtVKW
	4ZFlMVMMbFAGnL1EMpENb/ZlM5nsH7+u5I7k+FS0kQHikux6UvA0yvr/IQTX34pWEUkUfQg++AD
	yZIdnlwrYGWBBsGYU/Ijd+SKwlSvMLjLiPxYb2M6rAMT7nK+rRo0cN70vU67HOp9ZiJFyZcPXrg
	uLV2WlFYxi+8k12V5rnLPH135oAWG5/KcBHvnp41uX4oznyNpJAiOElMkETLMyLX7ww47yskZov
	q+nF+WnB5R1EKaAZRslzUBzbIfIy1oJLgGikxY1Cqmak7tWWjk28B2S9eTcniJY8R80EvXHK06h
	USvOKyj/3Fp9ff2HVNHXnAOYzR2jX6WEwS1LZTMinMct1oiRE+CDpIqn2zPdQPsoM70de60QYAy
	FOtBE6vCpP1ZicnznXQqT
X-Received: by 2002:a05:6102:3fa8:b0:7c3:9a14:cfdb with SMTP id ada2fe7eead31-7cc926820ccmr912621137.17.1792599247553;
        Wed, 21 Oct 2026 09:14:07 -0700 (PDT)
Received: from gmail.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7cc92327896sm3196621137.4.2026.10.21.09.14.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 09:14:07 -0700 (PDT)
Date: Wed, 21 Oct 2026 12:14:06 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, 
 linux-kernel@vger.kernel.org
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
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
Message-ID: <willemdebruijn.kernel.311d7bcc5fba0@gmail.com>
In-Reply-To: <595385b672b5411849d1defc78b68b25a908a77a.1792565282.git.mst@redhat.com>
References: <be251d104f881a309cfef150455efa128ebb101d.1792565282.git.mst@redhat.com>
 <595385b672b5411849d1defc78b68b25a908a77a.1792565282.git.mst@redhat.com>
Subject: Re: [PATCH net v4 5/7] net: add a sysctl to opt out of virtio net hdr
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
Content-Transfer-Encoding: quoted-printable

Michael S. Tsirkin wrote:
> The ingress validation as implemented by the previous
> patch is stricter than what it replaced: GSO
> packets whose checksum metadata matches no transport header are
> dropped, and non-GSO ones get their checksum completed in place.
> Such packets used to pass with the metadata unvalidated,
> and with no overhead.
> =

> I judge that this should not affect any deployments, but there is still=

> some risk that it does.  In case a deployment depends on them anyway,
> provide a per-netns switch to get the old behavior back:
> =

> echo 0 > /proc/sys/net/core/virtio_net_hdr_validate
> =

> The default is validating.
> =

> Reviewed-by: Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>
