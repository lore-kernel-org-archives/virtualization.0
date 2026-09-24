Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A3733C198
	for <virtualization@lists.linux.dev>; Thu, 24 Sep 2026 07:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790234373; cv=none; b=InYA9UvtcSkX5g8VAJH2JLixdjSK5LfBwdWwKbHavfTR8FGssvEar17D3BYVQ1fw9WFkq+rOGu8GD5VN3ibTLpRoLFwmB3pJMEtHwYQQGz9N9YNDC5SalrAvpfyRngNMu2v8tUSV76RCIFNqsZpFLW0AwG0U2wdDh3zGfj5c5Sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790234373; c=relaxed/simple;
	bh=GEoOWOSINkKFKV7+tDUSFfZv65WxuafQXiTykuWIiUU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DsFrm0GGhNow5r87sHHq2Oz1Odp66ix7fARYOLr5u5XQYjI4Kag5XE89Yrkk6D801MLH9bj9MvBTh+tM6fencoJzVf+f0rUoKrzdP2kChCvH6fIZ2MFwXkU6JFL+hN0IZsqxMoKvQOk3T9cz4HPWnDGKDpKtMAjknHgesfovIQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G0cEw4Pi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G0cEw4Pi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 670161F00893;
	Thu, 24 Sep 2026 07:19:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790234371;
	bh=GEoOWOSINkKFKV7+tDUSFfZv65WxuafQXiTykuWIiUU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=G0cEw4PiUi3bLsNP1FXrmc23tCaMQhZTVkNFzpfc2BY3A87mdaT4YdhDHqhw5MIWB
	 cOqIN6R/yV68+Rne3mjeEfUeUsvciax3P+HOtM0XO1mcftRBEt8tHIJR51vPkAwGaA
	 Ka4t+8DjQYZt/HmIpiz9L3U+bC2ySZqPofm5x0v8lo6aBCVSz+s8jKIwdCXLRe7pAG
	 7CjBQAaZZXeKVGRMxkWEIP7mtyfyap+gFjg15anvTJZYMsk35/BGV5Is/8iVUOW1Gi
	 u0GkKoZ5Gmrr9xxe2i0HuHJQUWSg6DFDecH4QaSLqndTHC3SeTop+lGHYp/AmMnSUp
	 YSsYeD4aTwDaA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] virtio_pci_modern: skip trailing zero feature dwords
Reply-To: sashiko-reviews@lists.linux.dev
To: "Peng Hao" <flyingpenghao@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20260924071412.6765-1-flyingpeng@tencent.com>
References: <20260924071412.6765-1-flyingpeng@tencent.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 07:19:30 +0000
Message-Id: <20260924071931.670161F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

> Since commit 69b9461512246 ("virtio_pci_modern: allow configuring
> extended features"), vp_modern_set_extended_features() writes all four
> feature dwords on every device, even when the upper ones are zero.
>=20
> Feature negotiation follows a device reset, which clears the device-side
> driver features, so trailing zero dwords need not be written at all.
> finalize_features() can be called again without an intervening reset,
> though, when a driver's validate callback narrows the features, so also
> write any dword written since the last reset, to clear what the previous
> call had enabled.
>=20
> Devices negotiating nothing above bit 63 save four MMIO writes; those
> using the 64..95 range (e.g. the UDP tunnel GSO features) save two.
> Counting dwords rather than 64-bit words is what makes the latter work:
> with VIRTIO_F_VERSION_1 at bit 32 the second dword is set on every modern
> device, so a qword count never drops below two.
>=20
> Signed-off-by: Peng Hao <flyingpeng@tencent.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924071412.6765=
-1-flyingpeng@tencent.com?part=3D1

