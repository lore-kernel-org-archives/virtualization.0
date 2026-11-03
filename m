Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793664820;
	b=xD9LPczgNBtF4uFq/b2/Wt4vGRAJkKhStDUc2P9m4dHxHtG/3j9uAA1YBdSk49h3s1jT
	 ANNDDiLkuS3QAyU1uwp9pHkCz/hX8ownD54BCWQ7hOhYL9FdXv2TiLwY6cQSBo4dIaF+x
	 INtN0mAKMO0xqrX+uauKnOPRIzM2J8XGVa2A99RKqyj0ORBYocyVmQYRtuspAatlE4MnK
	 yro5No+zl2ax13wY4cYOGh/YP+k37fU9Zb5M2Q6tO/vBU3jEuCbXZ/IIvfuNzYvHc1SSG
	 okPPzWbUztIeSzIeNyGoSqlNKFEqNn1bBSxUxYbaFVrbOD+/iSbpE6uQZ96+fJl3AsQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793664820;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=4BGZ13Bkvj+nY9S5laHX6suMtDSaz5EyN/MBpLH+Qy8=;
	b=SOMrAOZ609UXpdChhwp7r/b80pHb6rFBlBYkITyaK6MoZqyHnozu2YA61dXQjWglFoyt
	 upcbmuv4CarZwiy03Kby/vzWZs1/nBgJ5Ga+kdWWIF/GDvw2sPdzwdMaXqTV6nDxLz21d
	 VcLNRJp1W/+maIL29OE5uFB8uZH+GRIqukO2373Q6Ub5cRzX5lijq3ony7pUUfxRKgOHt
	 O7D1SH342E20cExPwmsEEM432XRN0+SOHiPE/ZV3IRdmYwVtRnRSUo9r5lD60dqiXyIUw
	 kpCaQoylFAmQMQ+CuNTQH0dWZyKNg2vWIybRVDVpoUh8jeWOWjsjfs5HuZZ1jb6FktQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G5yN7jo2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C648606A324
	for <virtualization@lists.linux.dev>; Tue,  3 Nov 2026 00:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G5yN7jo2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BABD61F000C1;
	Tue,  3 Nov 2026 00:13:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793664820;
	bh=4BGZ13Bkvj+nY9S5laHX6suMtDSaz5EyN/MBpLH+Qy8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=G5yN7jo20DwChUiXr6N1Wl4cF8ze02zJdsbWEGAT/Q1ZrwQxR5f+ArLGiPmQf0243
	 zZge1z4xn6WNW61uAULhUpbfpgZGvEVIbsnzyGEE1GJ35IaIbLCuSXpAyQlIb4p6uK
	 kR8iR1zAdEb4z08T3eq8qc3WV3YeT66KxgiL6B/iio/vKOSO2At4vFAMC/WFFVYCqK
	 TGnmZOmwjryY+z2Zve3kJPzu9mVAfHxHceFhgOPnnntnxWRmKF2JiSF0vEnqkrxW76
	 jrZsbLd59QtFozvtobrJpJ8F/josHATuL8HwDPUr2UODtE8V5eRtKYxJWFtVSeQvbR
	 6NoCjUAQoKFZA==
Message-ID: <sashiko-outbox-194365@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 09/12] ALSA: pcm: add an optional reset operation
 under the stream lock
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261103000403.67106-10-mynameisjune111@gmail.com>
References: <20261103000403.67106-1-mynameisjune111@gmail.com>
 <20261103000403.67106-10-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 00:13:39 +0000
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
> Zero permits the position rebase; it does not promise XRUN recovery.
> A negative return skips the core rebase, so a callback returning an error
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103000403.6710=
6-1-mynameisjune111@gmail.com?part=3D9

