Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794201688;
	b=jk3+KyMqBI1oF7qVFd4ieivH7fNzu2IECvjupBKG/UsslL42/gKNdRe1kWKQIt8QpX1E
	 AXYxIgMOCrTWX6byMYdQmGoF4jA/ihzPTSFMU6THZ3DkWRPdGLOheVg8QxyFd58vXWORd
	 ULFASO/jPlOO3nYw1RBgxYxQyY8BNdhcuGwYKxxhoCx0ZDQ/o6M41luY9LdLpxuPWXh/+
	 r0S6XV8mEmdpdGSiRvknf0J8/qd68+JQpI24EY24lOVBAlrXqb2uswBJEQuuAhvDpOvF6
	 3GjLCMydjsqQsFgT8aKL4HLbmHAT7q5VZ0WmpnpVanjW/3Y4h47QIemdvFgt3Ky3z/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794201688;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=tX7xCXQwgdVrC59wm229PwEzk/jmCfZ4vJgrWC2vcDo=;
	b=OQ8TJvt6aHMsd12n2OQ2vDKV1plYGip659t+3jTb6Bf0TfPT1m/ahXBqE2GYrUwVf7Im
	 zkuIsfhR6UiUrxuy1A+2rlUJYS87rpqL1flT7h4OeaojxlaX+liDrs/AoFTKhQns8XSwo
	 S09Hcvwvfo/VUNVrTuMc5IhK8w16aT1+fK6GGdxBdYM4iv2UCZpRhOhExJVDxioGoIH6H
	 ABrekHUQ+yqh6auc5nJn2I74lAGa12gmTE8A/FPvg0uQpaPRpJVdpdTtPMWSjMhRPOtVk
	 fq+/3sKoy82xhWXA0pIMxWZo04ZCtAtbWAryes0qfFJHMPqG2Gr+EHVaICNsGGccghQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O32clObE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E75E606A321
	for <virtualization@lists.linux.dev>; Mon,  9 Nov 2026 05:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O32clObE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C23911F0089F;
	Mon,  9 Nov 2026 05:21:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794201688;
	bh=tX7xCXQwgdVrC59wm229PwEzk/jmCfZ4vJgrWC2vcDo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=O32clObETjynSN1/ytvHc7CZZDGhIcd7sLkn+A3Mr9ZupO5k1tGXpbrazBlPk1n2r
	 oSx3BAnAj7S0rGFig/8abO2iOQDxw5QK6xKiXZX+hu/fRXPPKas+lNuH2n4oxGXEpR
	 cMIyuNqHByj+MK876vOHKTZd5UfoRmHFqTxKezFMaUC9OrBKmoFI4Wudg3IRf+4ff4
	 9P9pV96yjCpyLy0dHD/MhJxmVH6gByoVJn5i9OaPiY1QJw4RjdbcyBFm1flWBpZZM4
	 pjBhLNHTVwJsjlwpKY/AVzRzhIs0Obw0NpNv9a3dsb7c/wXUDqmYTHQnOKZhELV+Ky
	 x76sKHj7u4d+Q==
Message-ID: <sashiko-outbox-204430@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v22 01/13] ALSA: pcm: mark stop-threshold accesses for
 capture policy sampling
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261109051618.22506-2-mynameisjune111@gmail.com>
References: <20261108235457.12688-1-mynameisjune111@gmail.com>
 <20261109051618.22506-1-mynameisjune111@gmail.com>
 <20261109051618.22506-2-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 05:21:27 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109051618.2250=
6-1-mynameisjune111@gmail.com?part=3D1

