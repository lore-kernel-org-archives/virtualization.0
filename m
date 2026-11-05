Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793846454;
	b=xAE/JvIomz76qfPgYYPgLyKtQ/d/9OqkiCFBg8KkHdG4jPJ3QdLyFVLbK9a2QOstFZdr
	 Mw07I8A+ZJtgFgHVN/7xAVPjwHNGALygBY6C02vXr3XxiU6yUivgSfbxFJ+5lfcP3c0HP
	 REPgEd7g4tcPMKTloXUwirlTP2EKbgpxYZi5V1hzJExHsrUSsyHGdNsboxa5jNFhjIare
	 ZikAmUk9Gc0rM1BDP00ub934BjvMzJaja+UjwPw19RBbo7SFLs+PNpypEInno1XfzJBpU
	 56F0iIcDWiQTkvTO/eU56aT1uADiMVMIFNMQXvorZ5CoO4RD9CGuGJ25JFjkmxGKAJA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793846454;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=itg6LujndvcZKvcIkQ5L/Dj+lICRIvs8pVU9fAHLa98=;
	b=4cDMeO+1rIQymUVCYKW5l5jMrDYMkiVaSlQQ2iC2dpsM29q0ig+YpXfgz5oR7auIpNlb
	 OGfxVIkDTe1JTJLD91zj+uA8XDq8qXQmfLUOKuoUhcpdaXI72CKn+ciyRgEY6oJ/DwTH6
	 KkbrI05XKLZQ+gP7IaxSARRlKhlDOpl9kIzi5ggl/7tyryHkFqygDF2semyxzmqPnSN9t
	 uHSrZ8NWUu+xV02PEscG4+1o6iBtyTVKwhxIKUqhIG7yEi+XZ+/WsyKuI2EvwmJI4Hjbs
	 vM/vbYfhPFRL3u35XTMA6nqBd30oB76m8t3fw+mRrq26kMbkntdrhzA8qlp1NrpFdyg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OQXiWXkx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E21D606A326
	for <virtualization@lists.linux.dev>; Thu,  5 Nov 2026 02:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OQXiWXkx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A1401F000C1;
	Thu,  5 Nov 2026 02:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793846453;
	bh=itg6LujndvcZKvcIkQ5L/Dj+lICRIvs8pVU9fAHLa98=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OQXiWXkxr/r69YyGp1frEwxzXdmn12IDzNhJDDjpR8nZiuvi6oaJVX3y3VNhPZOA/
	 d3lcM37QMoi6S3IXJ/vqo4i97wFXS9aNssxWLd6I2y54fzvLI7bTVFoIQY5o7vHI3v
	 zl9Ptf5cSWH3Pi1Znwp2zsqdbVCRKozepBJPyqdSX8r4ZJn0hJHMvYm/uRHQ0CuSqb
	 CubeHn3n5nqjpd9l6VpI0nkrG+wWCsLUseGSNGbVBnZ0I8wjPyX/fN7CB9z+rOBCFj
	 Dhq+70MHPH67ExBiO1YugQK9iD8K8dlNKNM4JdL7kJza7HGdcRScd+B8gkFxB8AacY
	 BVNvNCJsfjH2g==
Message-ID: <sashiko-outbox-198473@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v16 03/12] ALSA: pcm: add an optional reset operation
 under the stream lock
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261105023140.18373-4-mynameisjune111@gmail.com>
References: <20261105023140.18373-1-mynameisjune111@gmail.com>
 <20261105023140.18373-4-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 02:40:53 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> A driver may need to synchronize private capture accounting with the
> common RESET pointer observation and the core's position rebase.
>=20
> Add an optional reset operation called under the member's stream lock.
> Expose snd_pcm_lib_reset() so the callback can retain common pointer and
> time handling. On zero return the core completes that member's rebase
> before unlocking it. Drivers without the callback retain the ioctl path.
> The operation is also used after a successful prepare.
>=20
> Zero permits the position rebase; it does not promise XRUN recovery. A
> negative return skips the core rebase, so a callback returning an error
> must leave coherent pointer state even after partial work.
>=20
> Linked RESET and prepare stop at the first error without rollback.
> Earlier callback members may already have completed. Legacy members keep
> [ ... ]
> callback retained an acknowledged appl_ptr of 64, and finite-silence
> playback kept the written prefix while clearing the rewound tail.
>=20
> Assisted-by: LLM
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105023140.1837=
3-1-mynameisjune111@gmail.com?part=3D3

