Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794269235;
	b=h7oL7IUaHykAlucCQOow1g1eKUasSQRUIF/dOqhnsDcjwXuPstW7nDtF9fQUKax5zGlg
	 3VPVa6z5xwebEC9OswHSagGflKEgavDVhnRxNUUg3teIY/VNx9EEHifTIZWnL4QKtCPmA
	 eOuvRdTTCOpNWrF+LMN5WdUHUJBCz1NHZlnjuTdZhoNOvWyrm6GogLjMRFXEhmO16P45q
	 yHKiaPVY87teBOaWDP/VwXaUV48Dx2zj+6Ug6qJYBLUqQ6HM+NNg2K5YpQmSPgyChLFIY
	 ghm5AwmXVKCtyP4AOrLOvnLeBoSaAIek9vQyffzJB3i3XjWNqpDG7tY/tne0nQnymvQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794269235;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=eghenesJj1NDJawE8Z1dFELfKM6yaT30e9CTTiJd6Wo=;
	b=QYOYQuoYCBg86aGJy7JR4arws1b9fTD0M3ktR3GprhMotk/sDvkUBynZ5nxg+ysL4RLs
	 Jw2VCzkqhTCzMAmMzhenmRfB/+aMtnlMMU3YdXoOLYrhrRGh6fgI9rBtu7jFrKHh2zj86
	 C6rE+uV3OrHPCAtjK/hQVY9iOK5zixeMKJPcUivk1vI3dEMsoONJGpN5a3nGsExCjbcC4
	 ch/mrnqb/jLlBIazegyFimVIimp7CPP3dIBFydtpNTku2/s6WSVecr1aoHCiGxeLXXw/E
	 g4uHxzcJysoNvzszjGIqDm/WkllOayJTAdbUI7FLWVK5a1W57tTXbaYOCAHwyRfbSmA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gavZopG2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A93CE606A321
	for <virtualization@lists.linux.dev>; Tue, 10 Nov 2026 00:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gavZopG2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56CAB1F008A2;
	Tue, 10 Nov 2026 00:07:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794269234;
	bh=eghenesJj1NDJawE8Z1dFELfKM6yaT30e9CTTiJd6Wo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gavZopG2XwNIvL/LmWymz2rhGsY1vng/XRGu/3uDnOU/fE7t27HeZdxu8n1uVIkIk
	 w1WWg4AXQZPL+Zfcjj4Tt8e/6pysZ0yNNdQagZUMOpTOSVT/w0N9En335rPTBTjngX
	 wSiwdHDa2TzWTFdHaKjxZd92kuc8kMo5JrU06riuYm2CrODo3weaHnuxUzPYaVyaUK
	 8BEEbUlIkn+/CE1kGQVGOydxWVhC3N+5uA3U+LyLgWWMHjlr1YceuLBxKb1NSTmwEL
	 bEWk1symK0CBmMgraCKIQZ+HVgzyewlzd/rHow6myzzm0CXa8XhDCHPYxV4i7OFwML
	 Wxc/MY6HhNasA==
Message-ID: <sashiko-outbox-205816@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v23 06/14] ALSA: virtio: propagate PCM send failures
 through ACK
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261109234049.79534-7-mynameisjune111@gmail.com>
References: <20261109234049.79534-1-mynameisjune111@gmail.com>
 <20261109234049.79534-7-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 00:07:13 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> A failed queue submission can strand earlier messages from the same ACK.
> Restore the failed message length, notify any earlier queued messages,
> and propagate the failure through the indirect transfer callback. Commit
> its private cursor only after successful submission.
>=20
> Keep ACK admission closed across the linked prepare action and publish
> the prepared state from the new prepare-completion callback. On failure,
> leave the stream unprepared and reopen admission only after the core
> reports completion.
>=20
> Once the PCM core has moved a member to XRUN, return -EBADFD from a
> later ACK so it does not request a second linked-group XRUN. ACK during
> prepare remains rejected until the completion callback.
>=20
> Fixes: fe981e67568c ("ALSA: virtio: use ack callback")
> Assisted-by: LLM
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109234049.7953=
4-1-mynameisjune111@gmail.com?part=3D6

