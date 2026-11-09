Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794267986;
	b=cNN53yLSnMs5Wu9W/hXGEDjUyxtW6jzHO/QRWYlRP3P3pKztKIgSfedcTETSBHUpf6SN
	 p0FmSDko2Y/BIV7CH17UrFViWHh0pXXHN0pIe5+a5Ut5dibbMkQXAlptm0IyqWi9Jkx9p
	 CUi5tGLfqF+qazMldtuH+LC1OMtHySF7bcWaxFS07w+oV0MuJvG5mR62e1Po9xKH7w5jg
	 VcEN695AMwKd4PWktrTYfg3eBIymvN9FaIUsooYDMukakB6uYsG2A2KH9ATnSQ6LLu+Fh
	 gthtC9vjvsyDxItLkZGGJgLVaONk7zrtVPGClFEA8bMWoFEAxz35M57eHaqG/kzW9Kg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794267986;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=vkD3SvcaBjzCO+8AAj44RVilhDSe/lqn5orGXU7UINg=;
	b=FypNYcVjbtjIFa6istpn4WHh0lIAD+59Ft9K0ptsDrSomZK02aLYC0yHw8Jt8iTXhrOc
	 RVIe9S92i6XVAATPuUmdO4mbSUk6N1ocS1mQzi3C+9QFRGFoE7NdNgy3cY8QxPlYkuQUL
	 3zqHKe3pRKW64GJsGFQf8hfT3xebnN9QG11loPksnDwpm3hs35b/CTDZMJ7oTnVlI2SkG
	 YIWS5OIQqb6AXv/apI6XnB000ZUJPG0x7zh575iJOlSHiUNEEDuLXM+Omh2rRyB+0LouI
	 jGRbH/dRlVpg/jv/AofQWsawxDpRDkn7ZutirCnqqMk7b9iJlj2qvsJP+ChzTy4iDhg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e4m8dDT6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03E31606A31C
	for <virtualization@lists.linux.dev>; Mon,  9 Nov 2026 23:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e4m8dDT6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E5101F0089F;
	Mon,  9 Nov 2026 23:46:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794267985;
	bh=vkD3SvcaBjzCO+8AAj44RVilhDSe/lqn5orGXU7UINg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=e4m8dDT6J1aUhFSctJt8ZRj1l5Jfu/T7Tl+2JAeZRFtfnTIZzjf9Ltu5JoiR/ajVX
	 kdRO9JKQMIpzWttmPJgs9Q53PIDTz4cFqG88zxIJf06/9V6jZ8XNVjv8fXZloL5gxP
	 2C7PCde0ngK6F3bRzHr/EF15I/o1WEOJAuWCCrw5OiGOnwSktgOpDFYzANpLYlQRdL
	 rp6cB4GFLchfbLxzAPrIs9Zblxp97Vh9kMZHBunRQRI5W5ncSn4e+SPsdoFsNAjYfM
	 1Ak7XeTkJ+CCYnF070WB2Alr1HoC26SA5MFrQWNiifHtOr7aEd7JmHwZcqL3MMknby
	 WpSbPcOr0m9zQ==
Message-ID: <sashiko-outbox-205791@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v23 02/14] ALSA: pcm: report partial progress under the
 stream lock
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261109234049.79534-3-mynameisjune111@gmail.com>
References: <20261109234049.79534-1-mynameisjune111@gmail.com>
 <20261109234049.79534-3-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 23:46:24 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> Staged capture can make readable data available before a complete period
> has elapsed. Skipping notification leaves a blocked reader asleep, while
> using the period-interrupt path for this event can infer a false ring
> wrap when the notification is delayed.
>=20
> Add snd_pcm_progress_under_stream_lock() to update the hardware pointer
> through the non-interrupt path and notify readers and fasync listeners.
> It runs under the caller's PCM stream lock and does not tick the PCM
> timer. The driver must release its pointer and trigger locks before
> calling it. Existing period notification callers keep their current
> behavior.
>=20
> Assisted-by: LLM
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109234049.7953=
4-1-mynameisjune111@gmail.com?part=3D2

