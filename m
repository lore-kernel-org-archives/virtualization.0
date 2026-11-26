Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795709235;
	b=iizoqbtbeUgBDoSGORdRMtXa44Djh1CjB+nhoukswBG3QFzPdO05CkKsI6wFHDNgqLv0
	 P/6l1kM+3WWOanv7/phtvCBrAiXlTk6fngeI/pXVxk1/svGSzykb5pOAP5PhGHa0YUX4P
	 9RhnGd2KV9yc8Dl35wlaKt4QSQMwBaeLLyQtgtuZamuxj3BqRKwFJCSup/HAMV21mJJGY
	 HCGQ/Jadsau781TGu4vpS+uSSu7g88NJ+Y7KrUx6QQfzptQx4ge1RqpfNwuOzwya/7vHc
	 cTwCj3IhwfagRxZakF11PtVCantfXyAkmg4PoeO1ltK8+cbCipNmRirDonvlaQHl/yQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795709235;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Wjiv+BymgDkhOkUobrwjXUWYoNHGDSv9+Dh+kTmPen8=;
	b=R4bk5itFYOSosB6XI4rukvgmSmTWj+RUOutEjih03RWDpy/JmfR+rt5gkn0cmiEegv8v
	 V6Tb2YU/cIU2eTwdPoNgWzGsb2U6Svmz+aE9xH1zHj68sjPCRjZCElfpAFg75vizSnURi
	 xQvJP7ssp34Y7GIFwCvqYgWXVJAkTJRBTd7hNn+ItTYp36rWQFKONFTfyJ1nrh5u89sC6
	 9wUBrj/NfKztw+8w9ucLu8mOF3zEkJQfbMs3eu2iWG64UF0p8FGPmfDJAkwsvNp9hYM5F
	 gGu3Z6jM8Cp9b8EnzQp+i848ybqI0qRWYJNzBkSnChElp30nt1hUeUPDBAFE/Or/y9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AWTsxiQd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECCE6606A333
	for <virtualization@lists.linux.dev>; Thu, 26 Nov 2026 16:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AWTsxiQd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A01071F000C6;
	Thu, 26 Nov 2026 16:07:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795709234;
	bh=Wjiv+BymgDkhOkUobrwjXUWYoNHGDSv9+Dh+kTmPen8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AWTsxiQd83zRgLkj9kpp0tJWNlffIPc1/7+bgGJkCV6fRQlnkUNzDEh/piHCTZZeF
	 GgYGSO4QCdY3HU23OfQd52KmstJeLjjoGCt0DVpC6i0nQspuZCQfJa0V2X1RQpYdSo
	 yvXrRGbB7MsBGkdtGnGCpqpUPXVz4ExgUP3FdRrgpSdO59FYm380vY6v7/GKhe42ik
	 PYCgs0QUHxPjM2pa6rKNS1erQV72rYsywXwqHEiIs9BiHP1kV3bhr2rdGWHVnDpBCu
	 s01IcMlOSdKfoQUygIPt0SyvKt2cAyu3CSXOOSLdFQOyVJQZqFaI3r2o1jgkTqgx5X
	 JYPfmzLXktwLQ==
Message-ID: <sashiko-outbox-235880@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC net v8 0/6] more virtio-net csum hardening
Reply-To: sashiko-reviews@lists.linux.dev
To: "Showta Ishizaki" <zakinko@snowrabbit.org>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261126.rfcv8.99797.0.zakinko@snowrabbit.org>
References: <20261126.rfcv8.99797.0.zakinko@snowrabbit.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Nov 2026 16:07:14 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

Sashiko has finished reviewing this 6-patch series:

- Patches 1-3, 5, and 6: no issues found.
- Patch 4 ("net: resolve uncommon partial checksums at ingress"): 2
  potential issues (2 Medium)

A detailed review has been sent as a separate reply to patch 4.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261126.rfcv8.9979=
7.0.zakinko@snowrabbit.org
