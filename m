Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794562433;
	b=5K6ZoC0w9dEESAqXxeUVkwChb5ggQ/gwrokz3bCeX6p+0l0aRwEH9SQeKgEAYaedtZT/
	 fX9adgbJJSAkqIKxXwtfsR2q2XPFf/QS+VUCZX0k8AKpJTcJper8jLnkTj3oEDl44/Sxw
	 QGtCZa1rEcWFMPU4TFWrdXIaqA9SH1A0fNUExwWuFSad+3gkSY10Gue31hAvuVbewuAsv
	 qqQqDE2dHkiNrEbnr+lq95YpwgdSjxHGkbgTV0wdcnUEEOOBooFBsjqhjrEFaSn+KFupo
	 jCcQ4hp61yta1ZCVSpdw5DHcuhJ5IqAJOyFEmcv6OMwI1Pxz4QOt11swpJNfoKnZYLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794562433;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=u9UFtvVlkp0c4dud67YGrH4eblOj6xGwpvDzcfH5aiw=;
	b=UomekBbVD01aQavF3/d5rv6w9IQIqKCp0icHBSd0jhMA2dbHS1ExsQAR0OXEh0z588o4
	 GAObA6PP425BiqtbLtWszdRxGjP0vRKLAcyqoKg9xdiHn53Wy1nsIB7fDMkSgSHUZcDG0
	 KMsRFBunVIDeFeK9xtnbwJnmH3TGPT+PIF/7OekHaxh6Cxyo8X2ENTJIor1dGWCuQcyau
	 8zZcKlyRh5ZXVTww4RTDpu0g/qo3UmTkuxgzjRjk9gCA3BPz6I1Kod0tpXxOBOFA/HSc9
	 VmMB26/Ov4I8CkF8tnScyb5gnlgKpVQ14Mnm9yQkNimVywNclk/89r9Oso8+wdvJQ7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TQJeSwTP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF572606A31C
	for <virtualization@lists.linux.dev>; Fri, 13 Nov 2026 09:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TQJeSwTP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F11C1F000C4;
	Fri, 13 Nov 2026 09:33:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794562433;
	bh=u9UFtvVlkp0c4dud67YGrH4eblOj6xGwpvDzcfH5aiw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TQJeSwTPO6kFCSA5b3kx90KagsTqnqlz8IdSxt6V51d+Sk4kq6H3YTQ6p4+z0Hg/8
	 aZJIhgq1lekZtdudqR+AIPH5TrNohF+fFQCJJgOlvPNSSSOr2xZ53388EF7jC2jY26
	 a6jSfRV2Ytg7InnG2obdVDE1eP0/Ef8v34g46y9nTMPrnfwrCtaWOLWZvsLzpoKmhH
	 SrDZ7b3qyM+kkdbWYTj3cqzo/bZ/SajgUBwCiEMqjHLWqcG2pNLExkJuL6LBj+dFmH
	 G1dAD5rCHrqBF0DbKSohoWnl7877T3BkfvxMmAfVoAUafCjIyxDDNw4DR5uW4WfrvF
	 k5QncciPYRf9w==
Message-ID: <sashiko-outbox-212550@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v33 13/18] ALSA: virtio: prioritize capture period work
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261113-fix-virtio-snd-recovery-final-v33-13-13a934ad5ece@gmail.com>
References: <20261113-fix-virtio-snd-recovery-final-v33-0-13a934ad5ece@gmail.com>
 <20261113-fix-virtio-snd-recovery-final-v33-13-13a934ad5ece@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 09:33:52 +0000
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
> Use system_highpri_wq for capture progress notifications. Capture now
> always uses request-owned storage. Playback keeps the ordinary
> workqueue. This preserves the priority proposal separately from recovery
> and accounting. It provides no hard real-time guarantee and cannot
> prevent reader overruns.
>=20
> Assisted-by: LLM
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113-fix-virtio=
-snd-recovery-final-v33-0-13a934ad5ece@gmail.com?part=3D13

