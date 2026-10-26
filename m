Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793008470;
	b=j67ZHbz4B+Hn7AjUeC3DDngZH6rYhvKAyF1CAg4vZyiRPahqVqOCy7e/ylOQzoqAvvSW
	 5CMmgCLR9BpKSnYGjVbV6UcpR/4VPFXUHtaJ49Ng5GIZuqWOal6WYSRksyvYJshiBt0XV
	 A79AEzqk46P6nVFxeq7+4AruATOHDlBBOerKzvVDunMifx/VActtWe8sr9qrMchl/78Js
	 EXp4UlY3UmRaEcE3Ek0tW6NamvyxF+K5aMc+ngTQDbZ3lCVg5lEsDNSMwqpf1iLoHp1K+
	 /9xVV3dRqFPTL0kwK+DReSgE9PKIKdgO5TIXdrJp+7VL1iLTh+zbfH3xlT1Hq9eMrCg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793008470;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=BowmWKnUlQkT5fZnVcVXpYE0dpV6mT21Q4FtvNifUXI=;
	b=t9DCpMevvPgSsShfh7twsrT5tasdv0+mwegQRwQzBclXkjPd9tYyHSv4LuomAhkgZWiA
	 SnTsAu4wWy8xQKYyIVRGADXFIoHonupkumCNc/LIfFxJYzFgwyLXRKcFFaQVT6yDrpgqO
	 dFfLeAIV9At/oLwi1fnf83liAOxJpStLvAmAQz86YxqUhFW173/N3lDRkvlYy4L/G8+XW
	 6hIjW/LoHCAHOV8ybZyF17KEk6mHcD0f5NKPRezIB+CVygcoJKyQIif/orYAp0N8ZJbp9
	 UG0XMmRGQEZQN8Q58IXofR3/NbtNC65GGF0hvC3LedeownRLBTFAOfwbDYEpnWS+qGQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IZy8Jfpd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45C4B606A323
	for <virtualization@lists.linux.dev>; Mon, 26 Oct 2026 09:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IZy8Jfpd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B04A01F01825;
	Mon, 26 Oct 2026 09:54:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793008470;
	bh=BowmWKnUlQkT5fZnVcVXpYE0dpV6mT21Q4FtvNifUXI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IZy8JfpdGru6uJPwKcTGZq7fZyvHAJDmsggwW1kl2kSGHfTHfNPNdt25pJ5dNEc4J
	 qQbwIoCCU/mYeqzJ8WjhCIpySNZni8DslsxOAFqhlatwevpNVRUDvALsXsyLaIJfXq
	 spOroEWMdIS4zymcRZsyaosyMUWmgh236reBPwD2aoUjshW1QsESgyx1Y8RqIrZ2rh
	 vojezjlpUybqOUTLjm1S6HD7H6OPHlSanS8f4fpZUkrKlKSUJ7J+dZ/ZWO1yHWM7Nr
	 fEIPw5AGgtTrVCwmpcYNOy/oLswvwa9umriHoMjqdRviWWmHUfhOHKgRMtTP9o81DC
	 fVICD7R7JAyaw==
Message-ID: <sashiko-outbox-184849@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 05/23] drm/msm/dcp: Add HFI panel definitions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jayant Shekhar" <jayant.shekhar@oss.qualcomm.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261026-jshekhar-dcp-hlos-v2-5-7cf014efdee1@oss.qualcomm.com>
References: <20261026-jshekhar-dcp-hlos-v2-0-7cf014efdee1@oss.qualcomm.com>
 <20261026-jshekhar-dcp-hlos-v2-5-7cf014efdee1@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 09:54:29 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> Define the HFI panel protocol required to initialize DSI panels and
> issue DCS transfers through DCP firmware. Without these definitions,
> the DSI path cannot describe panel modes or panel commands to firmware.
>=20
> Describe panel commands, timing and panel data structures, and property
> identifiers used by panel initialization and DCS transfer helpers.
>=20
> Assisted-by: LLM
> Signed-off-by: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261026-jshekhar-d=
cp-hlos-v2-0-7cf014efdee1@oss.qualcomm.com?part=3D5

