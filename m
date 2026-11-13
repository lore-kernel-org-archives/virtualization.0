Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794552407;
	b=qM+ZScYzZE/K5yQl2m+Dsa6RnM86512u8mbSIe3Kcz0YCMuFcbKr4uUZDCQjonGGHmBg
	 b0lsvehmHOtTYmdfd5FNqptdwSNG2F1nSbrkrVs0dVcj6+7OKTC1fPHN/9dLtxG/G1KSv
	 7BAxqmJzwaOBlKEWpQMMMKPtCdl4ZRNCQyBgnKfSjSO3it3otGzgIWF2/q8erBy2Fp5qk
	 fzlTxMumesxu9LAep+dG6bUmdEHGHkBTkJFgaNevk3auSdlxfjNqkxVX28SPY0zErb/ak
	 eiTOgEUcg2ghV3+fCLT1f0xz40UV+G5wxILGunRXS83IjxSMvyXBqA++DlytJxlRBUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794552407;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=hbKPRlXHbyXTIUWvulGuZO8RcOZKOLiRC83eLgMLBFo=;
	b=UGVd8Z4+AtBZ40UfRls5B519VOCyr12pljNAYATY4+KGx+n/kHDlue29xC9LQMfnzUy8
	 bdRL4YlOQsD8HxVTv18KX89eZ3n5ZVO4hetcnaz6ZNf9kmOcjgduwFv7XbSDTqSfpGIqH
	 LESPVrP8oge7EZXwgD0kcLbcqAZBQDEHOK3Uue8Dk6fNFLU6xbaZaPaadowhBV28nvXPp
	 bDhSNkXc4EMt6fDiY3wWOHM8OUNT4ahjnidOgiH+MWwV94NCXXp3QFS9cmxZI7szd4LZI
	 WwhGuZalht3JGzuvkhEDPwVygG7NVYd5F380pk5WhXjSx3UcEPFI+su75IH/bV3SRmg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GfHi2FXc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E43606A332
	for <virtualization@lists.linux.dev>; Fri, 13 Nov 2026 06:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GfHi2FXc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E5911F000D0;
	Fri, 13 Nov 2026 06:46:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794552407;
	bh=hbKPRlXHbyXTIUWvulGuZO8RcOZKOLiRC83eLgMLBFo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GfHi2FXcjsVSCh68bjh1hl4tgfeOeZXqoeVBtMFj+pxNlqhYiWQTQhnGEQk3aIdnE
	 CEDYRDGs1VmVGHCu9FaS407JYsqhcfUCl6Hj7P7l6/JycTR75TyXhZUQS8aiJHRMQS
	 THHqTH6dddLxGcvBMU56lkAwDeHUcKNqF+EJItpdFeBlart4lse0lRYvY/Y+N4imPW
	 /yAqjqwbEzM+pNaaJjyokfmQXFaZhfHiH/nEXuVNOF7fAIXtapN/t5XBMYyPfi5IW8
	 1swXC1K13V+Bv5B0UoDvs3ugTCuZINByMn4qMvlqwyCvJlfER0LJou1qauyWxHDKkc
	 ew8b6CcbPisxA==
Message-ID: <sashiko-outbox-212282@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v32 01/20] ALSA: pcm: mark stop-threshold accesses for
 capture policy sampling
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261113-fix-virtio-snd-recovery-final-v32-1-4e95979e312c@gmail.com>
References: <20261113-fix-virtio-snd-recovery-final-v32-0-4e95979e312c@gmail.com>
 <20261113-fix-virtio-snd-recovery-final-v32-1-4e95979e312c@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 06:46:46 +0000
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
> The staged virtio-snd capture path needs to sample stop_threshold from
> completion context to distinguish free-running capture from bounded
> capture. Software parameters can update this field while capture runs.
>=20
> Mark the runtime stop-threshold assignments with WRITE_ONCE and the proc
> status read with READ_ONCE. This pairs the assignments with the driver's
> staged-capture policy sampling.
>=20
> These annotations do not provide a transaction for the entire sw_params
> update. The driver serializes its cached policy and accounting with its
> own substream lock.
>=20
> Assisted-by: LLM
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113-fix-virtio=
-snd-recovery-final-v32-0-4e95979e312c@gmail.com?part=3D1

