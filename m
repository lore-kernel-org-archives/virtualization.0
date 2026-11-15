Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794712875;
	b=2s3CXKSYJbpN445URVaIDzxAAdSc4gQ6ul94X6RS5unTvwN1u8lTzc9zwnyxyeCcG7wf
	 FWZA70Ip69vdKS+o54YZuRGgA7av14oGerM5QmGhJ96LRmpftZakjYvZTbSyMencW/rB/
	 6QIIIE5Pe4b7H2mQsxQVivLlZnOc21fqlW5bsIGVCzUDKJFIxQDclVndDoou1dk1UzApq
	 zlKXqylgkmlKaYn0GykUI7zQuRaM3M62nt95o22qtOFIn0IE0x3gqjl+W9gnm/aqJAfGp
	 8Uai3pMc1qf48OqatjE8TIQPDwR2aDfqI21BjrutnLw1M7O06KXQ9rJGOgpHeWg8bDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794712875;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=AfFWGlC2a4s0rIlp/BTWifjVtPFquFbptDvmcihANu4=;
	b=YN0qLxNph2W22b9V1aRzG02OfKk3Vvg5B2Tf/5IVojVA8fg0o9OVIBRjvf7YMGJk5nSD
	 Aj9T18wEVyuA7BXIfldmhRGlHPRG4iO7ejl9huq9K8+sGGXfU1flXpE+6bznO4kHHzxjK
	 4ls3sD5etsAZThrlyfpLJZUIA2dJ0/mSQjUU6n6juwFpc5GX3wAX4ITKwF3YrRhbKJxa0
	 h6MSiki+9sRGrBDlplNstmvj18RCGQnpyKZWd508zgH3dP06katHzSnm4cc2lfyInDNvK
	 doXExcUIt1o3h0Ok/IIvqHzHE7rtbJrcfHrua3IojCaCypxrWg+7fFEqUgcX8LN5O4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=On9y9qSj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E7DD606A8AA
	for <virtualization@lists.linux.dev>; Sun, 15 Nov 2026 03:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=On9y9qSj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 008D81F000C6;
	Sun, 15 Nov 2026 03:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794712875;
	bh=AfFWGlC2a4s0rIlp/BTWifjVtPFquFbptDvmcihANu4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=On9y9qSjvETfr08IAa+Z8dPGGTo0P2ABNCLp9wPMf/ZmjnLuaE+zkq162e9Nw9xbM
	 qNYThQHvY/F+CpMbL67uByg6ISWAkuXXsMBILGn+r1NwSv8aVv+FawJt0pjRNqGo5O
	 NZQWGHQIeiyLW/Y0RZ6Hr8avvO7fobVlelWV450e988cOa27075Y+7XYiZO493waRy
	 V3Kt16aZzF7HC0s5xtMuxF4lhNrcKDYCoCwwgieTqQXbF1eQZW8f2tQimJvKufHgUu
	 v6C4EhnvP35fYYedvqIOnpTAO9TsWvtbTP+J5XmdBO4AXLddDOnLlDjCuqvomSi78G
	 T0x/a+b9D0hFw==
Message-ID: <sashiko-outbox-215200@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v6 7/8] selftests/vsock: test the guest vsock
 device network namespace
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bobby Eshleman" <bobbyeshleman@meta.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261113-vsock-guest-ns-v6-7-3737ce4673c0@meta.com>
References: <20261113-vsock-guest-ns-v6-0-3737ce4673c0@meta.com>
 <20261113-vsock-guest-ns-v6-7-3737ce4673c0@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 15 Nov 2026 03:21:14 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> Add tests for guest vsock device namespace assignment, including ns
> destruction and the device moving between namespaces.
>=20
> The tests drive the device through ynl's cli.py and create guest
> namespaces with unshare, so they need python3, PyYAML and unshare. A
> missing one skips only these tests, not the whole script.
>=20
> Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113-vsock-gues=
t-ns-v6-0-3737ce4673c0@meta.com?part=3D7

