Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793864000;
	b=n3etnzchUUlv6kntAY+jBB48ymQZC50nMRZ/Drr+H8+oGJlk/d1YGwkxRuKdJ5nBRSES
	 tqAdYdSENYVazQHU/RwVS5pvESsy3g7kzYxA6B2N400z96Y/iUf5X4gZvEnCDkLqGOvPr
	 6c9eL+pq5gIyEIMgpfLFHsH6BUMwylPor7m51a9xyiHXRr6CXE29tRaA1k3RWD4kkJVPH
	 979B98Z6T7KcaxTMed8714kw+3/FotvM7HSoxgUToWgohaLqE78Lt9RQzQsw1KckH1aJy
	 +sVDifeEigQpSaMQcf9H2wtnqgpJ6hV4uVbxhnnMIAzXq9fxxkuXwLLj68c14RxepxA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793864000;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=UByIeVRAuVDuFnUw4kdEvERvj362Tqvm97rJzBo7ZG8=;
	b=bkV00iqqwtdrcazrJH8DhzLpt2zItgA8imB/r1fv3LjihMLX3fe9sOpNP7axYDOmQlqd
	 FLDonmodyd57jaHlJ72y75N2kedi5OktyVl2PfEm1fqQjJ4Hy4QyoYUzGxlbBHeUZjTpb
	 hupn7JOwxf51XzoOI4eoolpyMVUX/6IWFQCCh3/Xgv7Fk8BMTU52tKsLrdM4nH9LnJjnK
	 aXhC8RsJo7gyTwzMAU1tqIMhiy9zmdxCpkOPdP5/uOpV4UvWqdF1b74+2Rf4FGBct+znC
	 m8XMKc9ZjJTjzULTzabBCTJCfA50nLJ1OF2ILseLN97IPyJlKy1/ylGCTBUP3jVRFZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DH+Nq31N;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1434F606A31B
	for <virtualization@lists.linux.dev>; Thu,  5 Nov 2026 07:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DH+Nq31N
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FF821F000C1;
	Thu,  5 Nov 2026 07:33:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793863999;
	bh=UByIeVRAuVDuFnUw4kdEvERvj362Tqvm97rJzBo7ZG8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DH+Nq31NDm0BZHbd3JtPJ35xKq0xLg6T1ulFj7aSu1MqtP++W41I3lkXiujEzujz+
	 U4qBOkVJBgzB51LA6c3hz/HKP0LMrLC1pKlRFfLGvmQQIhopfAsjPyS4ZQrQ/xeyIU
	 O1HA6lhd6HPJYmmfZ+qplr5pqtGB2ChkLz7TJH+n/3f3jzLl2btHX75zZDbEAA8SFI
	 DKdplQ5sr8XDsmfiK09fa028/QUaIhceaJBv/FCgoypEoiHGJ91T6ML1LGxJE7tetD
	 xxtPaqYobxR68b3qmfOIf8cWQZu20CQJUKz7IpWmeGUTFRTLSK1ljKXfLdrh7YL0yw
	 mG9RR3QbNtn1g==
Message-ID: <sashiko-outbox-198677@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v17 05/12] ALSA: virtio: Recover PCM state after a
 failed start
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261105070845.6449-6-mynameisjune111@gmail.com>
References: <20261105070845.6449-1-mynameisjune111@gmail.com>
 <20261105070845.6449-6-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 07:33:19 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> Capture trigger queues I/O messages before PCM_START. If the START
> message cannot be allocated or sent, transfers may remain queued, and
> ALSA does not invoke the action undo callback for the failed trigger.
>=20
> Mark the stream stopped and disable transfers for every failed START
> path. Arm runtime->stop_operating so sync_stop releases pending I/O and
> prevents prepare, hw_params, or START retries until release succeeds.
>=20
> The stopped flag is shared with ACK callbacks that can run without the
> ALSA stream lock. Protect every stopped access with vss->lock. Read the
> pending message count under the same lock in open and hw_params. In
> sync_stop, decide whether RELEASE is needed and mark the stream stopped
> in one locked transition; leave it stopped when release or draining
> fails.
>=20
> Always cancel elapsed-period work in sync_stop, even when no RELEASE is
> needed.
>=20
> Record the RELEASE obligation after successful PREPARE and clear it as
> soon as RELEASE succeeds. If the subsequent RX wait fails, retry that
> wait without submitting RELEASE again.
>=20
> Fixes: da76e9f3e43a ("ALSA: virtio: PCM substream operators")
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105070845.6449=
-1-mynameisjune111@gmail.com?part=3D5

