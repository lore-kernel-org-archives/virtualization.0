Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793020363;
	b=ULMEBhEPWWvztfmCh4Ohb9l4wBZHXgmwpji0bm9kYKEkLNXMLu8L5t0Ov3y2TwjzqUip
	 O8K/wGfZCw/hn8X99YH7OYDehpgb70fDiNwtdgXwVleQ+MC/hjj0vZ87ppn0vyo6aHB3G
	 I4mZtTVfuE9sF2b92zwBGWVIQVAWsb/H+E2wpVNFkV+3nTOJirAvQ2Y97L6m/xN4eN0xx
	 DK8BiXaYbIS1VYVcPiQHQ2ovgQrA5Yan5gufkLYJqAbD4OeR9PedkODYW4yWz26pV1HUR
	 g6Gpw1L2aMBTCGyAeaOr8R0efW3RnFIM6XMOOakret+lTUVT4wVp9uGq51UuUaZ1k/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793020363;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=cUJ7SeDnK0oFDIQW/9D6uHH+SGtqUuGxKKl9fAo8Skc=;
	b=WM3MiYL9JvJzg+efi7SF7h3YfArCfQihx7mQ4lQHxPdruWbifui6fmf/RRJIHotd3q9f
	 XDOl8SBzlofOV1r+a+AZFEGCM0BIf6r5S3jA3zTmuCL3tToS9+LtAom7R8sbh1DkYDp7w
	 1MxkKZ3CpANtKxWBmShI4if2h6vljm8prHp25NPHkVVlz5u6HJnnmBfq+xCUEZxsJiDyT
	 8zs+z2n/kmfmSaBE70rBVhX1UI4qN4zFWMeEkbt5D4XsavQhHbftQcwKuKFh2r2eSzjuv
	 DIKkbuq4Hd8p9JCqHMRMcK53+1FRLOS/3RBiFBYlwkYV57VIJKN8EagB4VKf0F41fSQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UkCXydXO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 094D3606A31A
	for <virtualization@lists.linux.dev>; Mon, 26 Oct 2026 13:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UkCXydXO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D34A1F01828;
	Mon, 26 Oct 2026 13:12:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793020362;
	bh=cUJ7SeDnK0oFDIQW/9D6uHH+SGtqUuGxKKl9fAo8Skc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UkCXydXOQZ8joCrWq6XO/AOaXutNFgTHogzU/R1vnCEVBY/tscweDSDUDz3PVok0b
	 iM4BddChj3K7cBQoxPJdUkYra9XYtnftJf6JBn5hCyZiZmPILnRn4mKdK5Pk3gOIDz
	 W7P+XZKkSFDh88U0/6Gfn0h73VQN12R+hhMxl9eXkSrhdb8z+FGsjwbD7G/y+e6nCe
	 sYyEtatR/sdFVgTcOZNCqLVL8aJJsugF30Pm8xHIadF4afKjxd+KUBdHMnUpCafkgW
	 fZBPOUJw0Q3s+fr8C3dK7H/ayE9ucMZQpv6PqGI1KlaLmpxpMUxFqjtQiY3N5gK+EO
	 HomRUYl5rhr0g==
Message-ID: <sashiko-outbox-185285@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 10/12] x86/msr: Remove rdmsr()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Juergen Gross" <jgross@suse.com>, virtualization@lists.linux.dev
Cc: "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio Perez" <eperezma@redhat.com>
In-Reply-To: <20261026130223.773129-11-jgross@suse.com>
References: <20261026130223.773129-1-jgross@suse.com>
 <20261026130223.773129-11-jgross@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 13:12:42 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> rdmsr() has no users left. Delete it.
>=20
> Signed-off-by: Juergen Gross <jgross@suse.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261026130223.7731=
29-1-jgross@suse.com?part=3D10

