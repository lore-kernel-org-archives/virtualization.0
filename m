Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795507387;
	b=5QYlmbsBKcacFFy4AH+ApITJJPexHzawQinVrNzovhDnmGeuBY+sP0Pdh31OPISIwNON
	 JTmmizkkAM8tez88EajGDT9b+NykTuGB4QWQm1jQ+QxszVldIbTi4R+AAEg6e0XSvU/oG
	 F8aOewmv63G/KbfS9Uvva+vxdBXyqkIH9vbq5rcDPgI4TUEQN97iAcyNvky4z8xZ6GtRl
	 uwy7r2LYjoAjrZR5WZ2eysHGjYuV0PW5sVeVZ+JdbV1qRVewe6g6VpCreZySKzHZu58zl
	 oRmFTDsziTwRzIMZEqYpsEXQOKDylnkj2j50PlhJ4mLgcNERIXEI9j6ZvWzhDhj5RZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795507387;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Q/vD2yd0Ktu8qhLr+1dLJmuK7ZkIazzqbNKiH/pmZuU=;
	b=lq7Jh/AnW9rcGYBE5vXQ9NDOAleCOQN/s1J0u1KBxSJuozGE15+KpmEWq2L9byLpKsrE
	 MYVCxD9VWgZCXRaLT7m59UEkW4A6hKtbJ8k4WZLBEzOanjWW33FPQcQ+7RpyTWF/URNHm
	 OLuj19TdcJvb1f8jtg0sm+Tg5M+tYnCZwuIyYdtD/N82+ehA5lv6493NlGQ/3k8SRChMq
	 Blujv/8H0E9XpQAS3MH+TIb9xf7BdqMmaYKs/xI5P7lUh7PSZQcn2TXHf3kqc4/Yv2DEZ
	 RUUAjV/3MJmt0qJgFjn8+M6t2DfX0BbfadaEEuPIVt1zV6w3UNSBnp/GSv2qZMoIWhg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kH+8b7W7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B97B3606A31E
	for <virtualization@lists.linux.dev>; Tue, 24 Nov 2026 08:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kH+8b7W7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DD331F000C4;
	Tue, 24 Nov 2026 08:03:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795507387;
	bh=Q/vD2yd0Ktu8qhLr+1dLJmuK7ZkIazzqbNKiH/pmZuU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kH+8b7W7+l9fqvjiZlyRbr1TC1Rn2c6LExFa3ymNskoyFU6ckJmLT5Pl02gfTi0A/
	 j8YnlOGMe8Z7v0OdpGPBkPJug+yFncrvlfbOJO3Bo8EMTyCM2tGQEa4k3PFDfbbajB
	 h1WveC/5OoUVvTiNXirTb9/j1k/MM0R2GPbjr9wbU/gqFsk7mmTmknJZCVw6rdjMeY
	 wS/1Y2hrDWjURfzqNGizJeRpmSJKapiOjHs1RQCZrd5vZtpWkjONFq583rzS9ZmTq4
	 +0Ae6HuREy1y7O3Ge/pXdYx/f/jlN6Jhkb9kh5QF6Ad5g3hh7gf3jeJtktQMsPpkH4
	 cpyRemEG5PC/w==
Message-ID: <sashiko-outbox-230700@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] vfio/virtio: read migration buffers and f_pos under
 migf->lock
Reply-To: sashiko-reviews@lists.linux.dev
To: "Qican Ma" <goonsomeway@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <179550684893.38679.618538654837589800@gmail.com>
References: <179550684893.38679.618538654837589800@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 24 Nov 2026 08:03:06 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> virtiovf_resume_write() reads migf->buf and migf->buf_header and checks
> filp->f_pos against vhca_buf->start_pos before taking state_mutex and
> migf->lock. Because virtiovf_pci_resume_device_data() opens the file via
> stream_open(), FMODE_ATOMIC_POS is cleared and concurrent writes through
> duplicated file descriptors are not serialized by f_pos_lock. A racing
> writer in VIRTIOVF_LOAD_STATE_PREP_HEADER_DATA can free and reallocate
> migf->buf_header under migf->lock while another writer still holds the
> stale pointer captured before the lock.
>=20
> Move the buffer pointer reads and start_pos check under migf->lock after
> checking VIRTIOVF_MIGF_STATE_ERROR.
>=20
> Found with an LLM-assisted code review tool and verified by inspection on
> v7.4-rc4 (b6a9fa34ce4). Build-tested only due to lack of virtio VF
> live-migration hardware.
>=20
> Fixes: 0bbc82e4ec79 ("vfio/virtio: Add support for the basic live migrati=
on functionality")
> Cc: stable@vger.kernel.org
> Signed-off-by: Qican Ma <goonsomeway@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/179550684893.38679.=
618538654837589800@gmail.com?part=3D1
