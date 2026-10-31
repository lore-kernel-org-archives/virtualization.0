Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793447289;
	b=YHnHejLD00jBH6c4FV7qCRkgy+NuYphpWkW4kKi0Unq5B6vsEnWD3zVOrCpQDv3gT1Ul
	 KzQfeWIWR2KMGG/D1/VGuhYx00QHrwOJfgPmoEGEZsGYPYUzVWPC0gmOHiK1AN5s6JW5v
	 hmiyzQxvisHLYgmDOe8XJC4Hvxl4cS83Med9+OiYP6ze2NVPQuuCrSO8ZE1GM75z1y8HP
	 D0jaI7Z4AgNwnathzgM5uewvnQVSvlpRBc00f+GJ/x5G0ZqnVUsuV5DgADP/bFkKs/npI
	 K78YlbeWDSuL2hGCXyOYLjny60748FjJdkH2+9RulpDBb4j++X9tN7Fe2G5+RHXqy6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793447289;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=XxzjpYnb+YKYXODZSvP3XN7ppJnV1wEB0mO01a2Jxyo=;
	b=MP9i5b7t95mVnrKXpFeZZmEKBAsbmuC/HrfUNH/O7u+p0nX9jkpsCuG9d1Mw9foQhxiG
	 Y0TFxOrjtMPEj5w6MJuAJuCrrpVcHCz9FkWnlRuY9zDuCw+m7XSZKhVl7B4e5uYlwI9ka
	 IdPxQPGNZn4DFXz0SWu2Sy9uc452bvjSv6G0sR4281/h/9JgquuTUIzF/Dps1sdhx2qXr
	 iUyAlLIbgkTIWmvRngScKXTEEC2tRmeVd0jgOUdBW9LOZ8TfIwQ5UTR0YjPjQ0SAEuBV6
	 yGRuKyBIO42c4WCGQlBY88NlgSIRk/yI6v4R6VduUf32+XqaGYVYId9HaPgJ/7e8F2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MpyyEHnK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55706606A320
	for <virtualization@lists.linux.dev>; Sat, 31 Oct 2026 11:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MpyyEHnK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5B521F000C1;
	Sat, 31 Oct 2026 11:48:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793447288;
	bh=XxzjpYnb+YKYXODZSvP3XN7ppJnV1wEB0mO01a2Jxyo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MpyyEHnKDnu//bfI2KgzWC6cdn1C8aG+LYDes9g1yh0Wp6HTwinS7+Dmaa5DYXExW
	 ZmUehNND73GrSPlAdvEoMAOkH3aUIIZ+9cfarUgJrOqZ/G5s9RQigqAO+AOqAffT2I
	 rjhPfmEX+kBl2mnvgPT3KSAO4UR6embIvIvsH8vx5fPUVel30LzN7P82aTq50wEup9
	 rUINd0GT4REnUNZuk9DSVR0Gxkjc3SQN4BE9qnjtUWG6ayHZfyBe93hBLbB0JWI17N
	 9WvB8IkqxCHnidpeqJuwZE2yJLGI1YMV2VumOIJLop5oy6WpDutWfTjrwrSjZeRTGZ
	 g2slqcD1DgZ5Q==
Message-ID: <sashiko-outbox-191925@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net 1/2] net: pass the XDP action to generic_xdp_tx()
 for tracing
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vladimir Oltean" <vladimir.oltean@nxp.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261030114753.185281-1-vladimir.oltean@nxp.com>
References: <20261030114753.185281-1-vladimir.oltean@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 31 Oct 2026 11:48:08 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> When generic_xdp_tx() fails to transmit an skb, it reports the drop
> through trace_xdp_exception() with the action hardcoded to XDP_TX.
> That was right when generic XDP was added, and XDP_TX was the only
> caller. Since then, two XDP_REDIRECT paths have started to transmit
> through generic_xdp_tx() as well:
>=20
> - xdp_do_generic_redirect(), for a redirect to an ifindex
> - dev_map_generic_redirect(), for DEVMAP and DEVMAP_HASH redirects,
>   including broadcast
>=20
> Drops on those paths are reported as XDP_TX, an action which the
> program never returned. Tools which count xdp:xdp_exception events per
> action, such as the samples/bpf programs built on xdp_sample, therefore
> attribute generic XDP redirect drops to the wrong action. Drivers with
> native XDP already report XDP_TX and XDP_REDIRECT drops separately.
>=20
> Add an "act" argument to generic_xdp_tx(), and have each caller pass
> the action that led to the transmission: XDP_TX from do_xdp_generic(),
> XDP_REDIRECT from the two redirect paths. generic_xdp_tx() is not
> exported, so these are all of its users.
>=20
> Fixes: 6103aa96ec07 ("net: implement XDP_REDIRECT for xdp generic")
> Fixes: 6d5fc1957989 ("xdp: Fix handling of devmap in generic XDP")
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261030114753.1852=
81-1-vladimir.oltean@nxp.com?part=3D1

