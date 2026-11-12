Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794463684;
	b=kUrHsH5m3VfMG465AUdnLyOu3jXPEyAhTVe75H18I1Ua4vDk5HMvgxg99VOF2scGPl2J
	 coF+FnOQFyO8nF8g6uz8zUj7lfNKJY386GbXp/PGN8pEK7gGxB6ipwicw+kE2rnHTVQeE
	 hsIWgS5hkrz2y94s3kfhdqhxVB4WUUioz2HyVORXK9RzzuCH7wmJzymhhuMd2Sd7X3y5T
	 AOdcR1/oArNjpDUJ5jr772N2Eba9CXo/xod2Y6uMxFKp5DTSdv8f1nvu2eFthbdXnuDvv
	 U4cdV2H64TTKzDWESrL6W7K1WMSMYo0fuOrO/mkhLQhTKA7MLD+alJN1fbR1XYGdtTw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794463684;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=lpzAGBkUPhTMMzHJf12pUfhcOanFfEDb+Lsklds4/0c=;
	b=bJHecz/qRD4ggF/QLqGXpySY0gFFTeq2QKovW3VC7t1KJunSGYvohpZDrm8IyZtMp/kJ
	 4R7EEzMs84lKVCAznsZ2xiguJdmAOUGUFiyyyPVo8dCG4L6JnvFoLtG9SfdtG/qJ5KbMt
	 Azu1Ks5/7vVDs1mhkAzjg1wz2gSWJ+tZVcLYYlJhAjMBLF6pAs1KAfu8ChDAOk8v63nj5
	 jl7yUy3HarN9t31ixq6/FOjyTjRXF4BQmdj/E2/qE86YZLjOO1FDIPIA+ucQWC3smwyKx
	 9H8fwmE3i55ClTAZxAugsYj4GyzdWlEGffU0QyDse7TGMXWlIQ2E4SVuax16pKy+p9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JmI6p3Oe;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA04606A31C
	for <virtualization@lists.linux.dev>; Thu, 12 Nov 2026 06:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JmI6p3Oe
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C30A1F00A05;
	Thu, 12 Nov 2026 06:08:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794463684;
	bh=lpzAGBkUPhTMMzHJf12pUfhcOanFfEDb+Lsklds4/0c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JmI6p3OeMJp0XKvI06I5p/tqB81Bvw2kDBwbRDLkRJ++TiS0eBhSDZ+peac6w//ab
	 Wge7DJEfppU2PFF8dz4jVrBoHfxbi1jXrO0zNHqG0OlO/wcjdttekVNn5xWSypWO+C
	 FizYOJUYoMwGMbNjLtYT6qjBfnc8PHcKdDsmEkmSi6UcDat1AABCNlwZGHOZ9MQPvs
	 adK5lKo2tdvHFen6SfR5L0lpoUejlofT7rYPVndo/0LruNWbHS4MdVsx0/wPuyGIoE
	 6plYofg0jUY62VdrspnWdkR1NXqrK9uABGPI2p20WPYalEc0czLbDY3B9Z2j77AyCn
	 Y8AWBJItRSk4A==
Message-ID: <sashiko-outbox-210497@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v29 12/17] ALSA: virtio: use request-owned capture and
 serialize recovery
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261112053446.73504-13-mynameisjune111@gmail.com>
References: <20261112053446.73504-1-mynameisjune111@gmail.com>
 <20261112053446.73504-13-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 06:08:03 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> Receive capture into request-owned buffers and commit completed requests
> in submission order. Append actual frame-aligned payloads contiguously
> to the ALSA ring, preserve a valid STOP tail, and retire empty requests
> without inventing data. Bound occupancy and report overflow through
> XRUN.
>=20
> Add explicit, default-off compatibility options for packed status
> decoding and capture pause using RELEASE followed by PREPARE. The
> default capture path uses request-owned buffers.
>=20
> Serialize control transitions and preparation by generation, keep
> payload and DMA ownership separate from the ALSA runtime, and stop
> admission after uncertain control completion. Preserve linked prepare
> and paused-error recovery semantics. Reject new ACK admissions after the
> core buffer-access gate closes, including linked members that have not
> [ ... ]
>=20
> Link: https://lore.kernel.org/linux-sound/sashiko-outbox-210240@kernel.or=
g/
>=20
> Assisted-by: LLM
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112053446.7350=
4-1-mynameisjune111@gmail.com?part=3D12

