Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794474532;
	b=fSPsNYBKbPalGjadr2jwnoA+LWfG5xYPt5wBo6HYR6JZ2o4IPSDAMTyhGqwxx4PXK4Qa
	 vtN7l5BLK5r5s5PfYJRTC0OWXMYT7X8tZZZXnDtYgP1GyNBhrPi1r7tGAHMibIbXH1qpQ
	 IFn53wYXTNU03kSUVEfMgZd/PfiZrBVZG02lMtzjJ1SpZXtIIM2rx+prTOVDQ1V0a2cg1
	 TvaoBw3hhqmJc8vUAns5WtwRKirIlZZKDAqmQAcix67x6VUNoM1K1NHblSgShJGKo1q/V
	 luQXm40Q3GbhryaOjdUnEQ9cyjtEPU/pyCWoaK2ihcyRu3PpHd4livVMKmg0KlNU58w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794474532;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=jfur0JwGPP3YhrPF4AKl6ftPcUevfDuDAlgHaqXSrB0=;
	b=QI0FYB/oK2+pFPhl9Vf8amNpBa1LT/Dzy625qipXBjGEqSixHQbCnkU4L+HaWXC75p2I
	 f2SkrL3fkabOzM08F3K/XDkwqBPvD03uz0vNrFKylORRpMfTwkWCM1s/597Il3G4VJzJl
	 WK5RldBjoEEr/Twyd+NQAx4moeHPRTjovwELMRlOLNSdkqjiWiPwSliAt01CkmSf3KKcM
	 VQ9BFVuyygj6ARv2mzVWAl/SnR/9EHg8iMuE5sgf7GGmIHG1JSuE4pKKybhfuiUxuEjnS
	 MeR2f1PN6gNIHsHAR2sQ0h0Pb4+XV5z5SGE+V1mKTCvqabEaUmQVhKex0lkwWarXZ1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iAKKtC7T;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D0E606A331
	for <virtualization@lists.linux.dev>; Thu, 12 Nov 2026 09:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iAKKtC7T
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BD891F00A05;
	Thu, 12 Nov 2026 09:08:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794474532;
	bh=jfur0JwGPP3YhrPF4AKl6ftPcUevfDuDAlgHaqXSrB0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iAKKtC7Tk8zdMDnrzzK6hEJGXxx/k/U7LYMClyBC/57swnvQrEKeTc9wWG0KuloP6
	 JgyPmFrTpIs1aGA9Mw7DTNzgwlFVC2czV/GGrwgBlMOCdD9m0yUVqBHx8Aj+OE8EHQ
	 9M5Qes3wXih/2CRiFerhaX9BUAv4WJCTF7bMBN3v7jMvQ+cOp/3QSKKN+wVmS22IR5
	 zTj440twWbkfO03X1hipmFHfR2eDa45qsBRLTpeneBjA3gwvbpRbuxPjpgOZ2sJEbU
	 x4Jl6ZZBKOSBmLqaHwFyEw3lhIO/uyvlqCCK3vyY5onBYFJSEtHRcfxJGdF67c0pp+
	 KCqf4Op170zNg==
Message-ID: <sashiko-outbox-210826@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] vhost: set dirty log bits without pinning pages on
 x86
Reply-To: sashiko-reviews@lists.linux.dev
To: zhaoguohan@kylinos.cn
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261112085631.128819-2-zhaoguohan@kylinos.cn>
References: <20261112085631.128819-1-zhaoguohan@kylinos.cn>
 <20261112085631.128819-2-zhaoguohan@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 09:08:51 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> From: Khan Zhao <zhaoguohan@kylinos.cn>
>=20
> set_bit_to_user() pins the log page with pin_user_pages_fast(), maps it
> with kmap_atomic(), sets one bit and then unpins the page and marks it
> dirty. This runs for every bit set in the dirty log, e.g. on each used
> ring update while logging is enabled for live migration.
>=20
> log_write() always passes a byte address and a bit number in [0, 7], so
> the update can be done as a byte-sized cmpxchg on the user address. On
> x86, try that first using unsafe_try_cmpxchg_user() inside a
> user_access_begin()/user_access_end() section with page faults disabled.
> If the access faults (page not present, read-only or needing COW), or
> the cmpxchg loses to concurrent updates of the same byte four times in
> a row, fall back to the existing pin/kmap/set_bit path, which can fault
> the page in.
>=20
> unsafe_try_cmpxchg_user() is only implemented on x86, so other
> architectures keep using the existing path.
>=20
> On an x86_64 KVM guest (i7-12800HX host), a synthetic used-ring
> workload with logging enabled went from 243.60 to 171.11 ns per
> descriptor, averaged over five alternating runs. This is the
> end-to-end cost per descriptor, not live migration performance.
>=20
> Signed-off-by: Khan Zhao <zhaoguohan@kylinos.cn>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112085631.1288=
19-1-zhaoguohan@kylinos.cn?part=3D1

