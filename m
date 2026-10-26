Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793004572;
	b=FsJBpQVAWTkjEsJdINItey0HkdlGMcGSxYd6cjUieKFQudAAeXvRPQdHXt3cLFWEQT4h
	 RQjwrTYgTgBhmv4dyGFcbuqQC/Gp8t/2Ed2V7Gw5T5LrHXA21PzGrYwpP2KE3FgGg2vlt
	 xXByUp89vICjU9Y1VHto2SHU9PchZ2iSBCEF0fWkPmcZgpJBdNxb/7/DT9ctPxM+ZkZ+J
	 fqXYTZ/3JGPZV3Hrcb3RLp4bwU1I8F/1ODaMu/2U/Xnq4392+QMrpKAijHxqG5ONoR+TC
	 PHNqgQW0HRC+fV/NOvDqadn6f3BDfxnalZdq0EinXMiZc4+aY0KAMqUrDMYZit31epw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793004572;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=pAJrULHwYmqRSlkhCUnaxX4/C5uCzRlIAGhkKrBcYSc=;
	b=fku8AC1tb/i+zfruUZU5NgghGHFepiAvI1hMENF8xFUJFDkjWyRs8QbzBJwHORhI9Ras
	 s8QYQQXaKHuKt+iVgo0/af9U7zL235y5JhtK13DNakNWWqzTQf7ngaViUFAniuvasRjhT
	 qaRF+z1iSZKbcbXSjoH/dg2lxn+pCkBJuvviKRq7LV8k1bTVAlYxVGadLt5noG093/mld
	 RNSszXkYmuo7GGYcKAJu3+1yP8eafSujynOIFR1WvfUiE9aIgVBfleC87yYQLf0QwWFHu
	 BgzMt69vr0bz5nXSo8KxHxk0BFznClTYCAdmRkSLLmj+XI92REWISwOL4VhXwEuOjgg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bnzbvaif;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3776606A32D
	for <virtualization@lists.linux.dev>; Mon, 26 Oct 2026 08:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bnzbvaif
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56C2A1F01825;
	Mon, 26 Oct 2026 08:49:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793004571;
	bh=pAJrULHwYmqRSlkhCUnaxX4/C5uCzRlIAGhkKrBcYSc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bnzbvaif/p/dnhMCgMNJ2XXrLjctO/1iSbf4Oy0/AkQKIQDaFTe8fRNVZ2BhIiNjg
	 jAN5SuogwPphaKxVu/hTPxAxGxL1Aqo3TMp+oayggVA7MAx1jtgralW9IdnZWFpQ5L
	 Pngejq1CPp7Xe1BWjpZZ6ZySkbwlsMDWeNBatv791NW68FdhJmcyLgqtGBMWAD9x+y
	 32sFAyhPLA/g311yhbHWm7Kp4WMRpARQE/STvytqV4p4yDA9SsQvPjqzlujfWEfjDS
	 SdYtd8ZqfwGa1AOAyibb+vsCLtSLeH4HE4FOvyF7r8UHUzhHqdtwQZdeu0cAJg1zbd
	 fJj7CzWBxsTwA==
Message-ID: <sashiko-outbox-184695@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v4 3/6] virtio-net: assert header sizes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steffen Trumtrar" <s.trumtrar@pengutronix.de>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261026-v6-7-topic-virtio-net-ptp-v4-3-008af03cd43b@pengutronix.de>
References: <20261026-v6-7-topic-virtio-net-ptp-v4-0-008af03cd43b@pengutronix.de>
 <20261026-v6-7-topic-virtio-net-ptp-v4-3-008af03cd43b@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 08:49:30 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> The header is cast from skb->cb and from device buffers, so its layout
> must not change silently. Add static_asserts for the offset of tstamp,
> the total size, the alignment, and that the header fits into skb->cb.
>=20
> Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261026-v6-7-topic=
-virtio-net-ptp-v4-0-008af03cd43b@pengutronix.de?part=3D3

