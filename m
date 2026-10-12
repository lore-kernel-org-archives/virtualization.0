Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AE6E3B42C5;
	Mon, 12 Oct 2026 23:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791846328; cv=none; b=sI3pt96WvEEURNl7aTa5fuG2eSldQ2PDjvM8S9+kEhA/xWIdLE/XhmM7pRx6gvaM4awyi9Kpj+k7nHmu2c7IYeQqgvUEWETJP+fR8zYP1OsmKqd3ale8KbXejM2xbbsLpGiLYd1e2BXOThb4SH2+Hx8tqv6YL34vccP6KCNf6IY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791846328; c=relaxed/simple;
	bh=Yxqcs7wrBk8voETRlG7tRqolrtL7kFylr+ANsQ1XlfA=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=AwPOj6xPWUrCF53NfW1M8JP52Wq4XM9CWGGbW5ZgCewhuvX9t1znyItgVBLKYl6s08KSi1grsa+74Fx4rOOotj3aH75p4NvmHHYgZYBAHuWuhthwhkKS138bFsAYgZlmTqkmR1jgnAizJx49QI5mMg7H6aHtMuKCug/4EzqNL3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jEbsad6X; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jEbsad6X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09D861F0089B;
	Mon, 12 Oct 2026 23:05:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791846321;
	bh=Yxqcs7wrBk8voETRlG7tRqolrtL7kFylr+ANsQ1XlfA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jEbsad6X1FzcMn2R7XNwB2T8PBO7bxfo/KGDZPnfrRfGsSdOQzdagnWTwH8ccYnwA
	 J/JYbmxa9MYob5ku4ZCJ0BVO4hGy5CsQWXxAcmkQyvpftO94J2SlWKDolKVoj1cq48
	 pKwoIT5JToaE2CTfVmocV6EbKPJx8H6h5IPvNZ+AJef1tnQ34Gzb0rtNJeEW6dCCnf
	 qSi4HHxRF1a10lhMnP5xm4u5rHtzbx1KmhxDTXATnLnhMFJ1kKOZtjN08mGQNrdyWo
	 37ps3v8I2hYjjidHOvzFEIVfaQeCsb+FXEc8QNTUp2XdcRLo0nYYFHnVUfqlFigqfG
	 x7ChaPErlvyNw==
Message-ID: <sashiko-outbox-168696@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v3 6/7] selftests/vsock: test the guest vsock
 device network namespace
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bobby Eshleman" <bobbyeshleman@meta.com>
Cc: "Eugenio Perez" <eperezma@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux.dev, kvm@vger.kernel.org
In-Reply-To: <20261012-vsock-guest-ns-v3-6-b32447c66b23@meta.com>
References: <20261012-vsock-guest-ns-v3-0-b32447c66b23@meta.com>
 <20261012-vsock-guest-ns-v3-6-b32447c66b23@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Oct 2026 23:05:20 +0000
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

> Add tests for guest vsock device namespace assignment, including ns
> destruction and the device moving between namespaces.
>=20
> The tests drive the device through ynl's cli.py and create guest
> namespaces with unshare, so they need python3, PyYAML and unshare. A
> missing one skips only these tests, not the whole script.
>=20
> Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012-vsock-gues=
t-ns-v3-0-b32447c66b23@meta.com?part=3D6

