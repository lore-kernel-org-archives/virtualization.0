Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792655441;
	b=l2y5q5MbwJzuTRd9jnjzBDsNlSUeNFpXBvntgw0VWe2hzTlo9HrRqvUQkFLzjjr6UKyT
	 A4boN0cMKPnRlWN9MZVtsh/d1mDrf+1/r8b7EDed9NP4pBPO4fFkXc5INiw+7r/NqsSBj
	 PdCAK7ISLPNGe7wjQHlUVY+71KD+rFc6G2d35brPB5E64Rifj6YOgM/7SGWmfKP5DfaPM
	 gP5UNYuTNxea0ULdqyr7I9Xt7GU8lsM1yLJVW5aFB3QDILln+wo4mIWKFfYjVj1F+e91w
	 y2hRf0VAKq4wnXom4vmoMGvYlw7sQ4CLjutK7wFSk1FhusvlwgwpN2WUA9hN6xpgUHA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792655441;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=eNhBHdoyD7VmMdARvcE1bL6GBQ2iTy3arPkx+SYyzNU=;
	b=z2dD8JzX4o/WlHfr2lUyQjZ20aUwkIDp+biegxXh0/7GfifB//gZfFGCr68VjSSyKzFf
	 lZI5o8h7io7SmJwpuj1PxFCJxDpTdfm4+I1Umekd0KdlnCs6X1LijKCbymoyAl+x/4crB
	 3PrCJCTi394vM/bdt6gNsrDvAtdk99fIAx6rkLUuyimonWcR3YFwvg6zwFZjn9ruSe//j
	 itbHrmb86RaIGEWBByWUrfe/ZFFgL0txJ76VTHRe2SXG8272xRV3JCOhKZvDCPzaPZpAZ
	 fjPv7W9iz/X7V9UKf9xiTPN+yrMUSnRebmRppFk+eaqvmDv0tsXlAPBB2EQTWDPiP/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Z/tur3XM";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD493606A31A
	for <virtualization@lists.linux.dev>; Thu, 22 Oct 2026 07:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z/tur3XM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C1DD1F000C5;
	Thu, 22 Oct 2026 07:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792655440;
	bh=eNhBHdoyD7VmMdARvcE1bL6GBQ2iTy3arPkx+SYyzNU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Z/tur3XMhZxlclneQ2dNAXJZSi8jnmNcyAyV0TuNzNQlVLMfMmXSLEDj8vCC3Zag2
	 2TRzxtBH31Kii3uqF2tMTEkjXBJAZKmc4PI4ylYofMYvln5aou95ogekSuvbadmK6w
	 B58I3uWz1rFrhRc89wzSx1E7rqD1z3YUXaMC1IJa1bEk8SreyUV9QS9ae9FUjuy1e1
	 J49T4RvRzgcYGMEBtdGLGICMv4920F36jEYXpIFTNvv6l/6QxREkMeOfR26mbKmXvz
	 t7QxGsbZ9UuPhxozVxYQFXCUlqTDDL5OJel9FfXFxvZ7sgnDEci2B3NFZwcKjZleIP
	 riMHRELXe+RQA==
Message-ID: <sashiko-outbox-181142@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v4 6/7] net: add ip4_parse()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtualization@lists.linux.dev, "Eugenio Perez" <eperezma@redhat.com>
In-Reply-To: <aa1551c0357a149a84d01761872cb4d3b489d1af.1792565282.git.mst@redhat.com>
References: <be251d104f881a309cfef150455efa128ebb101d.1792565282.git.mst@redhat.com>
 <aa1551c0357a149a84d01761872cb4d3b489d1af.1792565282.git.mst@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 07:50:40 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> Multiple places in the net stack open-code the same minimal IPv4 header
> validation: pull the fixed header, check version 4 and IHL >=3D 5 (where 5
> is the fixed header size in 32-bit units) - and locate the transport
> header at IHL * 4 past the network header.
>=20
> Add a helper for doing that: it returns the validated header and
> the transport header offset, or NULL if truncated or malformed.
>=20
> As noted by Phil Sutter, there are more places that could use this
> helper, e.g. ip_mc_check_iphdr(). They will be converted in a follow-up
> patch.
>=20
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.v4.git.mst@re=
dhat.com?part=3D6

