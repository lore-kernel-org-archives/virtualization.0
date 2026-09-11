Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39FE64483AB
	for <virtualization@lists.linux.dev>; Fri, 11 Sep 2026 08:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789114869; cv=none; b=EwN2zqMpefP3yIBw9n5LxDZW7ugfJ1dzW2jzFV+mVwvaLMHqKCYO8589uJKqtPOpUl4GRBycFv1H6lZAgGDRSp/daEhuNV2zlzhpzhgrD2PHdKVRPIdlPvMz4uYfSR7HnCjYrvxxC86WfVfGdu9z8Lqe1Tll4APMWHW2Kihbw6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789114869; c=relaxed/simple;
	bh=D4Y6DZ5elql50SecTlmUNxc51hoasK2HjVQ9HwfDSfk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GctPytRtWjZRrKP4DrPzpNCSqELu2a0oEUMLA9sIM5UCetkxlrCs+qahslZTVWFDJR1IzXbIUnB/CQ2qKs3RIEtSFebkTfy8BL9KLCWRljpSlq3FBOrpRV0FlwZ2CKAaeWLhuJmnZzCN4c5DyVc3RABs/yP1T1J+02oT1B5Yp34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JGGcin70; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JGGcin70"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9191D1F000FF;
	Fri, 11 Sep 2026 08:21:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789114867;
	bh=I6zPl3vs4A3X1cJMBm5TbAtH8Nab/AustytvAreNHMU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JGGcin70o7erocN7xBtfJrBAf2g73aDx8WBnWRFTT0Ec23K2dRQ/dBafdT0TWI0g+
	 jGNQrOPEPoK3RFwvR4nfw7xw144HcE1oKtS3XbyVjZ4YJDVfCgTlpD8+XpEUtO9eSr
	 Eyr71P6HB1fJLpnUqngyajzuj2NZpkbhfw96rHHayn+p69MrStdN+f65VrSS6cmvqw
	 iZiqrOdDJdYFqWhFwd0/+QfIgLUkn16RlmzUTxKWLcAly2eElsap/7MDb9jaeNJYbX
	 VRmr+M9i/DFUSgZWpmXgpieBEACi5aN92S/Pk1k5mP1LuA0ZNiH2Z/H23Q0WbL7R81
	 0gGBMbKdiF00A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] virtio_pci_modern: fall back to 64 bits features for
 devices without an extended features space
Reply-To: sashiko-reviews@lists.linux.dev
To: "Peng Hao" <flyingpenghao@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20260911081133.16434-1-flyingpeng@tencent.com>
References: <20260911081133.16434-1-flyingpeng@tencent.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 08:21:07 +0000
Message-Id: <20260911082107.9191D1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

> From: Peng Hao <flyingingpeng@tencent.com>
>=20
> Since commit 69b9461512246 ("virtio_pci_modern: allow configuring
> extended features") the modern virtio-pci driver unconditionally
> accesses the whole 128 bits features space, i.e. it drives
> device_feature_select / guest_feature_select with the values 0..3.
>=20
> Devices predating the extended features space only implement the
> legacy 64 bits one, and what they report for the selectors above it is
> not a valid features space.  Negotiating it makes the driver and the
> device end up with different features sets: on a smart NIC exposing a
> virtio_net device the link comes up but carries no traffic, while the
> same device works with a kernel that only accesses the low 64 bits.
>=20
> Reading the features space has no side effect, so keep reading all of
> [ ... ]
> Conforming devices are unaffected: their extended words are neither
> all-ones nor an alias of the low ones, so the detection does not
> trigger.
>=20
> Signed-off-by: Peng Hao <flyingingpeng@tencent.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911081133.1643=
4-1-flyingpeng@tencent.com?part=3D1

