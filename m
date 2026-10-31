Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793412845;
	b=gPUxnSX8ujkjRb+uZGqAdrt+rhEwxISsfUcJ5clhqoUMygfgzg7kcGrA1Zdw3gc/MAgJ
	 ig2xGjjeN/0FSTv5jpko+Y7NtRQkUNyIzpJzYsiTteLO5HWtimsj4o+G3jBT+wnU4Sm4M
	 umx867AJvVwRDDKlKGvjUDlFeW2/SO1Q0CwiI9N9m+hnzDR6msDpjDOHqZ//DIALmCL1+
	 edtVoWTCf6FAHctko/tcn2qCq8Qm+wCk9ZRi8dLF7bqYGLaTtHLfR9p+PzIeazMuiA0e+
	 EdiPEGNsEbGN+fNgrTd8qqkmYEB2wixiuZX3xAgyIcYNC+R7Qw2ijQYReLGwtGVBgQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793412845;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=1F8BA/y9geUT8BcEw5G5H31/mrpkeoTDPeB4gMH2g6Y=;
	b=2Ba9VUm3p93Ap1l+V2gCArNdt9EC75anHY0tilyDMPO+I2ehG7plwLf9iUxN9ZGh2/6d
	 HgEqYwmns610WVrU8VceEOVmPnJHeR3musfUYK24f9icfIFpVnFZs0DR3ZSCI4w0+nYQh
	 z7YCkgUTPN/ENU6fpUBxYHgF6j3pkD86b/lWK0vKjT07HaDMDEtMAXC2KXW6JvT+AaQTF
	 UqpmKquTh8jPu/ccSaxzKrNgZAyO3KdJqFn/xxlblyvHab/TIl3TSsrxDT8Hi8Xlswhhf
	 OmdqLcY2TUKoghwM5fKVPPtHq6LFeuaWpVMlXrIS+r9sGZLLLgbRFk1GptN1exeBcgw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X8WOCP8o;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E34CB606A31A
	for <virtualization@lists.linux.dev>; Sat, 31 Oct 2026 02:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X8WOCP8o
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5050A1F000C1;
	Sat, 31 Oct 2026 02:14:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793412844;
	bh=1F8BA/y9geUT8BcEw5G5H31/mrpkeoTDPeB4gMH2g6Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=X8WOCP8o+7H0AeI8Qkg9W/XpbLchTSwp/422uiahuYI7ETmINPBL6asKilk/o5/Da
	 4Oq0pFQR6o0CSiT1w2C08RAeM2LNnh4ALCRlri5Q4y/iiUqRxfJNWHajl9xikKIKlx
	 cBtbTE0eH9PUBSP1Jyjk4/kqJp2GuDl/XaM5UcTQ/nnLOMTVGbbvYHWICxSa9jefsL
	 56npYxM2go0BvWWibUFZW8rXCsyF+WT6GrGfjom0HwRcyMZEQCNn99TKQbWUkXUp2y
	 IZA5hoBrqMSu43qymMZySReLOnAIwcva4Iv0A9dZ3VbZ2286jyc8MZYxRPjEk4cOr+
	 n0a7PWieeIIFg==
Message-ID: <sashiko-outbox-191700@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 07/14] ALSA: pcm: mark stop-threshold accesses for
 capture policy sampling
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261031020855.2402-8-mynameisjune111@gmail.com>
References: <20261031020855.2402-1-mynameisjune111@gmail.com>
 <20261031020855.2402-8-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 31 Oct 2026 02:14:03 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> The staged virtio-snd capture path needs to sample stop_threshold from
> completion context to distinguish free-running capture from bounded
> capture. Software parameters can update this field while capture runs.
>=20
> Mark the runtime stop-threshold assignments with WRITE_ONCE and the proc
> status read with READ_ONCE. This pairs the assignments with the driver's
> READ_ONCE policy sampling in patch 9.
>=20
> These annotations do not provide a transaction for the entire sw_params
> update. The driver serializes its cached policy and accounting with its
> own substream lock.
>=20
> Assisted-by: LLM
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261031020855.2402=
-1-mynameisjune111@gmail.com?part=3D7

