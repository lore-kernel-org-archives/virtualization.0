Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793227397;
	b=uOqHmHBcBhpMkdBL6/TGnKGWKZPdcLkGXfI+pxVclEU20h+JpTq37qwLogreu1BFUm+w
	 Ip23NL6UpqYjq+GLKuVkis+TpAF6WSvRhsxW9/8LRrr+vZr19kDbnErKDYjN8XYNrJSB8
	 iKjZIlO6VmG4449FCGmXpJNDsZQjGXT1RZtpO3B5PHNuMWTsg011ChBwGJfqD7hirS4GI
	 EAVTrOIyASzUQBCzKaFv+cmHsfuAretDTOYhsbbPEpfxKyfnX3o/E1GAA7C6awaNCwK/y
	 Wf1r0K7mhQx2ZkT3cYLwJSfroxZ0RKQogfg3a5ah/62B38QFksVRKEy6gznIhlg7bsg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793227397;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=eqVVJFeJnbQ+zzZ8jfFA+lZorIfCEgmpfZFGduBn4xA=;
	b=uBuQ3zRWjfnZpkIx1QaHsE4knPHg9sJSk8q3J5U7AaiA4DX5U2SNUoStloi8XnDia0V4
	 zbySPczyT3HoZ1lPLOC3yhNLZk2+flrKJtr6KOrlj88tN4DfZiWdr5FNa70pgL4eYZeT8
	 r2jklcCBG227DZnHPmKQzYgjIpN7YF6MnBqlhRgCfmUilDMgd6c6f44yNLG5JtczuMQ+y
	 xZj/A/7OYA2vJ53gQ2Rjso4Z/xPDMUjHN9jE0pkuqg7EYNAIedJRXa8VR9TtVKOrMX57G
	 Kt0tOYxv9tv3L5A9jAfbxi7TMH1Rq2qdasLT3XNdC+U+I4DdWbNwmPK21fxyOuqjTJg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=b2yzSQh9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6FAD606A31C;
	Wed, 28 Oct 2026 22:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=b2yzSQh9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2DBA1F01825;
	Wed, 28 Oct 2026 22:43:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793227396;
	bh=eqVVJFeJnbQ+zzZ8jfFA+lZorIfCEgmpfZFGduBn4xA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=b2yzSQh9/ObulIP0c9ObMSCqk3LxNuMxg1pcROA+zuHuRKwc9T9NOJQakpG3rvWWy
	 7q2b1HcedbNjPL6H2wPG+Vsm5+0iEU3AFpy7qX77REOc7s6AiPbyp2fjHHocU713dS
	 usc7RgtrBobb7x7ZmIUUAPAcaxnmF+pXBkL38Uy1cbFwoSK1Ng4z9e9XC7e1fAp4AD
	 cOaHSykhfyb00xXAV8W3dqM81vrOgZo9RInEpZyLfdyQrBOJI/5suhvF1KripuFVUv
	 nfMriYZJeHVs/g0r5C76VDdEptiR2ozQBxc664UdXHQMDvxP/LlkhpePqdUojF6ui6
	 TSBJpqWWJxNmA==
Date: Wed, 28 Oct 2026 15:43:15 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, Willem de Bruijn
 <willemdebruijn.kernel@gmail.com>, Chris Arges <carges@cloudflare.com>,
 =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, Phil Sutter
 <phil@nwl.cc>, Jason Wang <jasowangio@gmail.com>, Eugenio =?UTF-8?B?UMOp?=
 =?UTF-8?B?cmV6?= <eperezma@redhat.com>, Xuan Zhuo
 <xuanzhuo@linux.alibaba.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 virtualization@lists.linux.dev, Max Krasnyansky <maxk@qualcomm.com>, Rusty
 Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH net v6 0/5] more virtio-net csum hardening
Message-ID: <20261028154315.4b9f3077@kernel.org>
In-Reply-To: <20261025094449-mutt-send-email-mst@kernel.org>
References: <cover.1792768096.git.mst@redhat.com>
	<20261025094449-mutt-send-email-mst@kernel.org>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 25 Oct 2026 09:50:24 -0400 Michael S. Tsirkin wrote:
> > Apologies for reposting so frequently, I know netdev bot will be unhappy
> > with that.  But Paulos's report made a lot of publicity, there is a lot
> > of people looking into this, so I feel there's value in defending
> > against all this class of issues sooner rather than later.
> > 
> > The issues were mostly found by code inspection, but all reproduced by
> > me in a VM.  
> 
> Ok, I looked at netdev bot review, and there's another issue.
> 
> If a tunnel inner packet happens to have a valid header at
> inner_nh_offset, it will pass all checks, but the transport header can
> in fact overlap e.g. the real TCP header and checksum will overwrite
> that.

Sorry for boring process stuff but FWIW the last patch also does not
apply?
-- 
pw-bot: cr
