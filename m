Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794591306;
	b=GAOufDDlf6Am8zz+RyT6aPyPONXiJjfhI5Fsaq++hvo5pcYSlULXV+9QAVoH7GgGoxuC
	 yJp+DzxDaJBIBpMmnlNLamAofp0FTGmVJexcRDCgJG50AO39zk74PyaYelcVwy2XQ8MiU
	 y3Um5em4sLWT/KFWx9mNnvgnE3BAm6c1t6Q+QoYkOJTmGkaRvRVP8irnnsNYK2Wa3obpT
	 Jq0JRbjd6ouXM8NFWBCZmiWH7COsCsvT0fkcKHzqhVtoFZHrTRaj/nHZGtWRyAc+YgvyO
	 R6ewZ3/rA96SCvL4Xh/4LMJEhvBHJBny6ZNUX5chqj7JywnKWxps7SSlFfGrs2Zj+2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794591306;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=3l49c1BzfEwOqPq31c7ThJpkYPTv0VMf5ynkdl2iIuk=;
	b=sv/wbfTyRACnuTYVObiklT0YAfPBv9OTGSjpMK558cjrlGq1d99MJ1ZAGbV6Jo72OFcD
	 lr3hIcvMadXBIvb+Qb9rafqEdb3dwT5uUaM5u2gZnHemaIyFSEMyFLAOudLd8L5yqovG2
	 tQa9hsEVLTBWqnZYsUKOZ80+df4ehQPsfLVs/FEzpuwztpDrUtqOocmAp+h2zcv91RGec
	 ghxz5lv7LNgnMmL5d5SJkHhjT9pjEnAEbyvzeqPhPF5yBo9j7v7aeTL9bSETKzEoUNGUM
	 3vAZCPw2d/vp3qbnoFViPmtdp9630HLHnihHELk4tJTUe1jaOsnq3wpnbl186PYfBpA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="L/oXXQjp";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F82E606B202
	for <virtualization@lists.linux.dev>; Fri, 13 Nov 2026 17:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L/oXXQjp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 308A91F000C6;
	Fri, 13 Nov 2026 17:35:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794591306;
	bh=3l49c1BzfEwOqPq31c7ThJpkYPTv0VMf5ynkdl2iIuk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=L/oXXQjp8l1/z+wd+QvOzHGklCeluvmRJuStWHKbJRkDPrAgdu6sutDjTHwzRGZgP
	 DucbxGpgng2VZE3nzmNzhaX/796G+fzTAIjO2Kf6RrnzQRuV8Kpnt22gxlYbU4vzHh
	 aKuU+a4we3i6kEFx70WFIcrN9bOgoV2tdP+viweFS0A/vUsBqlA2S5r5MrNXMtgCuE
	 YoB43QmEnqMW98gi/1G7+ZhBkwJaUeFYuaV5uJtQThD79VaDwhkiTwptCrLM/0huIG
	 /u2+Dg1FuDJUsbjSRik2DBxnryiObdmiDrLXo7n8l+YniSBRkgDSoV3pRtV3OAqiLq
	 TRPuDJnjU4X3A==
Message-ID: <sashiko-outbox-213328@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v3 4/8] vsock/virtio: negotiate datagram support on
 the guest
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sergio Lopez" <slp@redhat.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261113-vsock-dgram-support-v3-4-1523c8e9b27e@redhat.com>
References: <20261113-vsock-dgram-support-v3-0-1523c8e9b27e@redhat.com>
 <20261113-vsock-dgram-support-v3-4-1523c8e9b27e@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 17:35:05 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> Advertise VIRTIO_VSOCK_F_DGRAM and record whether the device
> negotiated it. Gate datagram socket initialization and destination
> checks on the negotiated feature and the transport's supported network
> namespace mode.
>=20
> Perform device capability checks at socket creation without requiring
> a remote address, which is not yet known for an unconnected datagram
> socket. The common virtio implementation provides the datagram data
> path.
>=20
> Discard received datagrams when the device has not negotiated support,
> including when a socket was initialized through another transport.
> Reject packets addressed to a different CID using the full 64-bit wire
> value before bound-socket lookup narrows it or matches a wildcard.
>=20
> Signed-off-by: Sergio Lopez <slp@redhat.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113-vsock-dgra=
m-support-v3-0-1523c8e9b27e@redhat.com?part=3D4

