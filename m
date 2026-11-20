Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795194843;
	b=WzU9B2TxGsW/xtxdF94udBrcEKdiUUcn5sml8AcWv6iYpSQMkEI+dsN/eX7dA24PJMWS
	 uNLmLPQkAXNoAvsl4Dg2b5I/D96VYUnxHd6yf044J6cNF0qcB3LSOnYpBs6gf4FL4Oaf9
	 mKeVs9HXU2YR54Gr17L09nyGNxT/9avHcrC2gqwDu9CIGrqC5ucWYUANR4KSomwMgOb7T
	 ySzqlrykHL2Inrzjtz5rpbvSzSRbX/ieK8EmAfRYJb2OLsoBgXyutw8fhTkn6GN6QjuCG
	 0D7FqCKofxXiqr7TM3UXR13h+JzAjmcqpeOooD4B6FXCSGwccQZ4nCttOnE7CfLRLAg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795194843;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=4lUGIdqf+y/AjzniiorfoVs7bmuFft7kTE/l+I5RQLk=;
	b=GyudNJtAKpDx9+QaGINvoLaiNROEzi5x/uoQ9F2Q/MNKTiPM4Y15B0WNdVbMYM3J3N4V
	 JWKlerrXteHzNyisBgiDbSarU1l8RFGlpU4xmeGQEll9PfTC6AnemKO0B8w9or5CkgPxb
	 GsUHP/geJWzti0r+MX/QRv6ecyi3OHhBASQ2I5mqPg9CpiSa/6n3+3i3JejPkNfEE54UN
	 ZZkokhspR7bpkPTkv/s8+Tolj+GfSKo9hQlzdiGfx8GYEWO2zL61uKE9wCGR9t64Tv2tB
	 OGw+4a/qfCQl96z4IFyJaQNxeO1peOpV815pBqA60bADOuab524yX9eleARtN85N/sg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=b297rWup;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E9DE606A320
	for <virtualization@lists.linux.dev>; Fri, 20 Nov 2026 17:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=b297rWup
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E01B91F000D0;
	Fri, 20 Nov 2026 17:14:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795194843;
	bh=4lUGIdqf+y/AjzniiorfoVs7bmuFft7kTE/l+I5RQLk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=b297rWuplPaHYqa51v9jqXcwHVTPz7/21MFXyNpFJhKFXozA2FcX32lXlpIQ9fyRu
	 0I+c1ynoK7mu0si2AvtQVqOrZNirvVAJDkjtvYanGu0vqet1IzvHTnrxfHVTt4zrQU
	 7Ik6zUn2uPsrZc1Gp+nbN02EVOi/DbOjARqjDUrs8NXZndYUmE6tjkDoJt9zX79+Wo
	 Kl8EO5YuOH65EPhFhagbOkrA7z7qaF88yMSRHjaLrXAAjgTzOOCd0/cO0Uo37vr+HT
	 ui0BszYLdqMgRfJeRyMjfdMIBy18yP188RuC8Eg+zhVj1SZr+pQxeeScLaqdT4YRZ/
	 2QvVGdhO6CY9w==
Message-ID: <sashiko-outbox-225627@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net] virtio_net: mask callbacks before handing off NAPI
 ownership
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtualization@lists.linux.dev, "Eugenio Perez" <eperezma@redhat.com>
In-Reply-To: <ad74886a8429a862c00d1e42f1dc746f2924b75f.1795108341.git.mst@redhat.com>
References: <ad74886a8429a862c00d1e42f1dc746f2924b75f.1795108341.git.mst@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 17:14:02 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [High] virtio_net: missing Signed-off-by trailer in commit message
--

commit bb6f10cf4a15461d1ade131fedc7d9fe20a241f3
Author: Michael S. Tsirkin <mst@redhat.com>

> virtio_net: mask callbacks before handing off NAPI ownership
>
> Virtio is special in that enabling or disabling callbacks (interrupts)
> accesses shared virtqueue state and must be serialized with polling. It
> therefore enables callbacks before completing NAPI, and disables them
> again if completion returns false.
>
> With napi_complete_done(), that false return can come after ownership has
> passed to another poll. The first poll can then disable callbacks after
> its successor has enabled them, leaving RX stalled. Virtio therefore
> needs to disable callbacks before handing off NAPI ownership.
>
> Add a prepare/finish NAPI completion API so virtio-net can mask interrupts
> before handing ownership off.
>
> Reported-by: Congjie Zhou <zcjie0802@qq.com>
> Closes: https://lore.kernel.org/netdev/tencent_D0650F8CA2AAE4C258BFE5BCE8=
05CDB4CA0A@qq.com/
> Fixes: 6f8b12d661d0 ("net: napi: add hard irqs deferral feature")
> Message-ID: <20261119064843-mutt-send-email-mst@kernel.org>
> Assisted-by: LLM
> Tested-by: Congjie Zhou <zcjie0802@qq.com>

[Severity: High]
The commit message is missing a Signed-off-by trailer.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/ad74886a8429a862c00=
d1e42f1dc746f2924b75f.1795108341.git.mst@redhat.com?part=3D1
