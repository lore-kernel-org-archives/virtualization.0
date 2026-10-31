Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793413234;
	b=PPGwzlsTIdMMZb42mw/t6LOVv/vltFLj5aqJAKloB3EWoryh1q7kFP+R7efGKVlDJuX4
	 2MOk/X2cPlqbnoTRO6I46uspDAcgJybePc8K3ZuVKkndvL+VurJWM0SFByf8MIjpRZO4L
	 nFCE0TtXNl3Yo1rbE2MiawgzOH/Ip0IHyB9bZMsCblPSVJ/nyuwmNrcgRlNgMMacZckhp
	 29qRoAzgDAQ+9NvsWSzSJ+dREvmgbR1lHEV99tfKnAATkktcyKN0B28PdsCvZwvKBb2ip
	 C5sgYoYTrZQmRreClir3/nlULgXshThyDdTRRt3HltcByMQg70rG4ikU1CmKUk3+ufQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793413234;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=c2VtzJZ9uDML+UDE1zC9Au7uNn1mdyJtHQ10xOz+7cI=;
	b=prxfx0Uuj6lWvsNDLuPgihyrmt4n6kIYPg2TeMP1LvakH9Aj8ZMrHtZizc/RvZzYktDB
	 1Cp7le47QKHMOwHpBlo99ZFw+4ql9RPb3TTL4Ld05TxQUm8UqVE82Mlg7HrRudnhOicSt
	 1FhD/Zz6M/jKCMnAl74Bvo+XGrqZLxh/FpnuCY7kUyeX+XNZj10vmBjlzOB/cUNfZJA+U
	 VNxVa5w9BcfAIhG6himSF+EDrig7kLsOtPa6LqZ9QguHka7hPTGOJHp5/LikRjb3UUfHR
	 Ie3dXrLf9XznH1DVKtKa5hxZSmdxtbSmVj7cWMdhYHFCBav6XlRUmjeR9/FATKyLrtQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eS4gTjE+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 089A1606A322
	for <virtualization@lists.linux.dev>; Sat, 31 Oct 2026 02:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eS4gTjE+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C8B51F000C1;
	Sat, 31 Oct 2026 02:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793413233;
	bh=c2VtzJZ9uDML+UDE1zC9Au7uNn1mdyJtHQ10xOz+7cI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eS4gTjE+TtITPKCu0b+LTWUWenCb11t1KQTjJ6zieEuwWPVRGG3SeTksdlOn94CcO
	 xVPYnQNRVtuxBR7id+PhKh+Y1j2aIHtc+WNnV2206LNL4F/KBakL/TYe3ktgpz2ZzF
	 y+8tPujA5e6spalDmdsVAY8q5lRd7z3QK8SsjFSOo3CQlrISDWU1i+T0WKvhIViuvP
	 T7tkVQ8jStSuleobzBkfxJfabKBzX7v8f1636PGcQwdqhtpz4mKzKgSm9OWokc+hvg
	 FIK121peCl+gN1tjRFwbZSbTHR0Se1Xu3re4g5VCot8XKVCyLchuk2wbs8ihP3EO9r
	 nR1QSxnZ/6qVg==
Message-ID: <sashiko-outbox-191704@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 05/14] ALSA: virtio: Keep control payloads alive
 through DMA completion
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261031020855.2402-6-mynameisjune111@gmail.com>
References: <20261031020855.2402-1-mynameisjune111@gmail.com>
 <20261031020855.2402-6-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 31 Oct 2026 02:20:33 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> Control requests can expose caller-owned payloads to the device after a
> synchronous send times out. Keep request and response headers and payloads
> in the reference-counted message so caller cleanup cannot invalidate DMA.
>=20
> Keep the queue reference until device completion or post-reset cleanup,
> even when the caller times out or is interrupted. Consume the caller's
> reference on every send path, and let response readers retain an extra
> reference through copyout. Check payload sizes and allocation arithmetic
> before building the scatterlists.
>=20
> A control value payload is also read by the CPU as a typed structure. DMA
> cacheline alignment alone does not guarantee the structure's CPU alignmen=
t.
> Align regions to the greater of the DMA cacheline and control-value type
> alignment, and reserve prefix slack from the buffer base so typed accesses
> remain aligned while scatterlist regions stay on cacheline boundaries.
>=20
> Keep response values in a separately allocated aligned response buffer
> so INTEGER64 control accesses are aligned from this patch onward.
>=20
> Fixes: 9d45e514da88 ("ALSA: virtio: handling control messages")
> Assisted-by: LLM
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261031020855.2402=
-1-mynameisjune111@gmail.com?part=3D5

