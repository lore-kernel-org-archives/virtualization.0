Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794356036;
	b=0FAmWYn4RLb5dwcUWjll0/DVs4uUhdrBz/C1wizJyCMiRAuSk+IgheIK6TbxNgg71d84
	 5eJktJ70mNM1ttX77zAmbUOmBhvA4INrBKjeo0apUsTxxmZod+kxLoIglCmN0PJOF3riX
	 EAY/A2vSIUawf2tuu6oq3ESs3PEteHXNzecSc/7cnqDrwXG1IQVBGLzQRHt/FEya1Amr1
	 hxHJkrdiv490JVW+GZlBCr0ZJFIeF2zbsv+BYdyAYe0sSM9fx89YNMB+zJDMbOq2ZHS2d
	 atbOnUl8c2YvxAT4CnRfQ4nczwFo2rjw3IA/7vSDfD/pnDvnzbUKMnU0gQ5+sZFVVxw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794356036;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=vhQZUBZvP65NubqN9+TbmnCaxwDZ590HxCgvgXAX4OY=;
	b=s10c/qMuJSYVpotAXeZFLE8UDADlSchNn7SnQUgLUf2CLtlQBxiqzWTKDYGSJ0Qk6WAj
	 KS4LVp2q1LsuMeq1KpjXPFVzO1+4+TeRVBHWZ6QMHQo1zpxeu8p/NZupu/5LfE+QePpPw
	 RMGn9WrcDOZlnl5deRIABeDrRTpgnMelS+DaUu377T9iurisP+rqKT+fZmfTk3EXnc+/Y
	 od+hZ6HiZI7H0cakRl2HZi51elypgc/UTxEI9CUFx+k8VLsYXBZwzyt9fxZ8WTPYwUKwq
	 xj0Tnqig2saE1+US9QJ+N0Mjjg0kwGc75kJ00K33Y7ywXbcQh0hs+YfrY8E4/YVuXkA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="PbRtb/uM";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7872F606A320
	for <virtualization@lists.linux.dev>; Wed, 11 Nov 2026 00:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PbRtb/uM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 207931F00A00;
	Wed, 11 Nov 2026 00:13:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794356036;
	bh=vhQZUBZvP65NubqN9+TbmnCaxwDZ590HxCgvgXAX4OY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PbRtb/uMBXUuL3xm9gFuWZNp9iC/zRgys+YjDd+ylfR0LaAPmWlZlVlrt1VWYnk7y
	 3ZqlEtFBdpINiThjR9i+nUzFAvBO5t+extoHfyM3RNJX+tetmUC4N3vP3P1m3SVbk9
	 hTTumU2AZuIfim31zvcL8LIXsg43aobT4BrXgJAz8LfWNgPmUsbxy6IUEW8+1zVBU5
	 rMLRkRKSyWJmmnCPYCuEVDw9+s6F2Ed30iiIAy+60fRXOMBCH301ktm0mEMpzoudch
	 kwhziTha0vQ2k4xQukBvAjjbD77iyEw7yz+VAL09qNwL9or8tknayfiRW4BbGqjByi
	 sPQX9TnZ1ELmw==
Message-ID: <sashiko-outbox-208002@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v24 05/16] ALSA: pcm: serialize linked buffer actions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261111000543.28550-6-mynameisjune111@gmail.com>
References: <20261111000543.28550-1-mynameisjune111@gmail.com>
 <20261111000543.28550-6-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 00:13:55 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> Concurrent non-atomic actions on different members of a linked PCM group
> currently lock their own buffer first, then the other members. That
> acquisition order can differ between callers. Sibling buffer mutexes
> also do not close their buffer-access admission counters.
>=20
> Close buffer access for every member before taking any buffer mutex, and
> acquire those mutexes in the stable linked-list order while group
> membership is protected. Release every access gate on success and on
> failure, including when a member already has an active buffer access.
> The group action then uses the buffers already held by its caller.
>=20
> The PCM stream and group locks are not held across sleeping driver
> prepare callbacks. Single-stream non-atomic actions keep their existing
> buffer-access locking path.
>=20
> Fixes: 3c3201f8c7bb ("ALSA: pcm: Fix races among concurrent prepare and h=
w_params/hw_free calls")
> Fixes: bc55cfd5718c ("ALSA: pcm: Fix potential AB/BA lock with buffer_mut=
ex and mmap_lock")
> Assisted-by: LLM
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111000543.2855=
0-1-mynameisjune111@gmail.com?part=3D5

