Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794563693;
	b=zy9N+pNE8drmCd8OTOTVYlg0c4w4NZ56hslIp9SP0FncGOMCeSKUFKSmX55dJAQ/ldS7
	 Y5k5TTt9ZPSzX+ZFhIa1tLGTG59fh6QrAKItOfau7H/8Ix98dtxfxg8yyXty8UaWKZ+CU
	 xU5H6VrGsYew433z99F9KZa6iK96pRjKtQVTK3q2X3AL8GB8Uxv06UZPbhdUidIhz2nw5
	 zQOr6CPnvzrduYvxFngZAwmKMs1p0PacIGLhDNSjFxwuW81yqsVw0vvE5EGLIfxzLY6Fk
	 xcwtM/OkC2/dimiweGJYL8SUF1/22AT+h/UWu0XnVMvl3T1ulLsQ4+vTCvm4E3T1zZg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794563693;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=FxVx0vL3RkyXCz75WWP9szZHKTKi3vf/vlhctvHg7CQ=;
	b=nL/19N2m1RVqeEe+rj3PFBVjKULGbaru8GAb/xOf6Zj9RqqR8g1m7ZoR8bd41z5xurA+
	 TEkwvfebR2Vv6vkbl0R9mC8xI3l/tMVXjH6s/5N/GuHKgqmUnktg6IlOo2ub8sd+r/Z1a
	 HH6pPimGsQ2yGDGaYV28NCBSp4pB+vs/qXANHvgIYbfXct/wa/iBCKJOMG6wYtx7XW1dG
	 MhQZwc61tF9aCgCZX50sQzC42zgL3TeDQfEBnhsQ9VYfs4MEmX8FZthQ79gKXD4s2sO8o
	 ETnLOC0DTeU8gd1qL1nU26krCd05W6jC5OOK16FtbyeQqCiwD7JVVuY6fg+Qp18EoIg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="cFbH/b+o";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DCDA606A32A
	for <virtualization@lists.linux.dev>; Fri, 13 Nov 2026 09:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cFbH/b+o
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8289E1F000C5;
	Fri, 13 Nov 2026 09:54:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794563692;
	bh=FxVx0vL3RkyXCz75WWP9szZHKTKi3vf/vlhctvHg7CQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cFbH/b+oIlzgeQUG6H2x9wg5YLob1p0rpWNhK+q6FWXbE56JnNFoZY4Ia38WcQ0Ao
	 SJC6xA2KwYYY6ukIgxtOlLeRSDX0ws5nb0CBgSHjWxOMjRdEQo/9OVcKGdFUeg+CfV
	 enfkluKTMg4GpItVBr7LgKRwLqXBMVXPLjS3K2wUOCPutg61UlogDboEO+lk9HqGkv
	 Rtp6Y2S2nYnHeqHzhXh7drcJxYMGJCsvFFYBCdEkVSV+99YRxqBBbW8hA95qHbVSSX
	 jM1qMf4jAb/hTgAgcGawroZQu+0GFfPyPApNzrpq1B+XSbj2VnRUO02vvOXDypvfq0
	 /3Ly5heuusq+g==
Message-ID: <sashiko-outbox-212588@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v33 09/18] ALSA: virtio: bound PCM transfers and retain
 DMA buffers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261113-fix-virtio-snd-recovery-final-v33-9-13a934ad5ece@gmail.com>
References: <20261113-fix-virtio-snd-recovery-final-v33-0-13a934ad5ece@gmail.com>
 <20261113-fix-virtio-snd-recovery-final-v33-9-13a934ad5ece@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 09:54:52 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> From: Joonho Lee <mynameisjune111@gmail.com>
>=20
> Validate ACK geometry, conversion bounds and queued-byte accounting
> before submitting transfers. Retain the backing DMA pages until message
> retirement. Check RX status and upper payload bounds while accepting
> bounded short responses, including at STOP and PAUSE. Preserve the
> legacy RX completion and ACK policy until the request-owned conversion,
> including the legacy handling of empty PAUSE returns. The fixed-offset
> layout still has short-response data gaps; request-owned capture and its
> queue/accounting contract arrive together in patch 12. Non-MMU copies
> use only the validated returned payload length.
>=20
> Fixes: f40a28679e0b ("ALSA: virtio: handling control and I/O messages for=
 the PCM device")
> Assisted-by: LLM
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113-fix-virtio=
-snd-recovery-final-v33-0-13a934ad5ece@gmail.com?part=3D9

