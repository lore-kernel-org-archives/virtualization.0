Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1D6D4EC66E
	for <virtualization@lists.linux.dev>; Tue, 13 Oct 2026 11:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791890125; cv=none; b=nDmyHPJHaPFUMM5lKI+wer+j89bPkwgkrFxy2Ake4Wj2cJDsEwzLaVWkuv3ij8nDcRvGWaW2r+s0/mmZdy03U6Vt3nBD0J4DSKhnP2T2Zy0JvMiVF/2fEhxnmQbfOxZe3tR0bAVKqrKQEbbR9YwN1DRWtCfa1GvPhui8TBHbMdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791890125; c=relaxed/simple;
	bh=k26YO+XUY5NCPxkI4md+OfCttnCQ9Anq0xycQW2+P94=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=K4302NdqUfIxm7tlMCOw2MmcMKhMsPxqFFNIyEePYvzo4DxCS4EcdJ4LDgyYiRm7y7+EAf0zmteRZSinLsSXP9ltyRcMfQKH7M6elC3KPT60/haZN+DKM5H66sxb305Pcu4MGuErK1tyyuK0lLSle1sSws4NQUNBhz1JOT2nHZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eYd7vbaE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eYd7vbaE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABCCF1F00893;
	Tue, 13 Oct 2026 11:15:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791890124;
	bh=1kq5OHnnSXgmugQ2x2V4wJcfHdHGbE2pfwEI7HnmAEU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eYd7vbaEFk9XzY6rDymsF1ZikYHF0Bcn9bRgZGKhFk6tCFSaKmhp0ns6CasYzhe7Y
	 B/QML7rQrcYH0kPz67+/tpVSZm8fCEdqBNeI8/7f4dp7Ssv9oCS3ihrz/AEnQ/EO+U
	 uLUDIl+EjttWR2uVbwtSkXukNNa3IAsFUYm2H8ElFFij9VWL+hnIG1K9mGf4ptZvRz
	 mO6kx8Juf6QV15TtR33czLrY94w7K1CTljKgf8VjkeWNie1bb0cZFQUyrrpLKRDM8Y
	 mJpDRWQxcuMkAU2PS+ebIt0gnrkWUxa5xd2vgi3HkrVo4nRdBJYAaweuZXN07/fOvc
	 GwxcZFEL/iGpw==
Message-ID: <sashiko-outbox-169597@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next 4/4] net: account for ingress-resolved virtio
 net hdr state
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtualization@lists.linux.dev, "Eugenio Perez" <eperezma@redhat.com>
In-Reply-To: <d82518764906d3b552fd3ade65b96ac741197d4e.1791887415.git.mst@redhat.com>
References: <cover.1791887415.git.mst@redhat.com>
 <d82518764906d3b552fd3ade65b96ac741197d4e.1791887415.git.mst@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 11:15:24 +0000
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

> Ingress resolution of uncommon virtio net hdr checksum metadata
> (software checksum completion at ingress) adds performance overhead but
> is currently invisible: no counter tracks it, so a hypothetical workload
> relying on uncommon metadata cannot be distinguished from none at all,
> and packets quietly pay the host-CPU checksum overhead instead of offload.
>=20
> Have virtio_net_hdr_to_skb() return 1 when it completes an uncommon
> checksum in software, and flip every converter call site to test for
> negative errno.  Have tun count these events per device as
> rx_csum_sw and expose the counter via ethtool -S.
>=20
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1791887415.gi=
t.mst@redhat.com?part=3D4

