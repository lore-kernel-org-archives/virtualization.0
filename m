Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794563316;
	b=Wua6tZ6Z8qEhNig2aCzPdhhsZvjdYA9tuV3VkN1+ScNZ5UXZ7VUSfQS8iAqgusqliVvK
	 Z5AdwA9iXbVejXn9SpZhwuqfWoivtwM13tYiAb+gCsoDIgBhAKMpVYKMgKU8wV776ouNK
	 PjrK/81WxRkCtIWJWW9RAH7hUnXca1lgaHSRJqK7Rz0j2IwEEYnAQJOludj96iZ4FIY1N
	 4WQ1/jgIL/fDFZb7glSu0xwVzJihzy+iOEpWI2oDS19oh7COMEW5G0+GnxxMEfiSCcsab
	 q7iD1cnYEB7+fj+76k0KVcPqw0BIBbcxKqnaCYb250XvrrVhMLUyOuFInB184+b7AmA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794563316;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=tRh6iBsXauDCf8W2ea0MgkB8RNWv7PAxU1IE0DGEOw8=;
	b=zxwuba4+EEd+aQkWfa1lMVdYuTlVXmHKg8JJq0ZT48hkpWMZTxhrZnvjG2VeNDOT87Ky
	 eVYPZBqWOBs1ygBMc93KPxSwSVGBZwyTNF7RGAtXXi8lQSnWRts/IXWdrAYoF7I3aQlpn
	 BPZDQeJau52+qHMqA+m3fc/l4/MrAcOT3Z0ECixTLQaXec6EIA8Bf33pfLNOoBdFb1Y0j
	 j96+qUDIxjWwp/jKqGSxDMm6o8Gq0Yy9cXmD+/TLXqAjp4glUpCpEXlhkDia2Mc8Z73pu
	 YQyXQ2RbC4ppTlPGDe8eobl0a6FO00gGD1gnYTkiIA4TeKGygMdCxUOvysBusKZYKww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DfNe79iB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1FF2606A323
	for <virtualization@lists.linux.dev>; Fri, 13 Nov 2026 09:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DfNe79iB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E7181F000C4;
	Fri, 13 Nov 2026 09:48:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794563316;
	bh=tRh6iBsXauDCf8W2ea0MgkB8RNWv7PAxU1IE0DGEOw8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DfNe79iBLncwHT96NRWhuoSBGUzuJHiz6uWtHTfZOM0QP9XIUkTpWNu9lHgSqYNcP
	 jEVubfFlqd3k3mq6/wWkkMab/rBpOzTEyAWYxGix0YHTrbDkTVxjFX8mWEOd1eoXLz
	 u5+5jk5tm+neVSgPjFTUCkdO0QK9kDAbG5DQq9TSejOI7mxoblw0+R97befLU8bvjH
	 FDNOJST3VlVHM1tt6AIz/fvKgTtfnyiEfR2ui3S2Anu3u5EmDIHTuIa7DLEGU65Yvn
	 Gqcg9DSHqqdzPRGCKLkpPXewbPmgk3Zi2waLzgxEIDWsdPUiSIIW6ObO9VsZMKPDU+
	 h36Hv6GfPJAqg==
Message-ID: <sashiko-outbox-212572@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v33 17/18] ALSA: virtio: preserve playback progress
 across pause and buffer access
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261113-fix-virtio-snd-recovery-final-v33-17-13a934ad5ece@gmail.com>
References: <20261113-fix-virtio-snd-recovery-final-v33-0-13a934ad5ece@gmail.com>
 <20261113-fix-virtio-snd-recovery-final-v33-17-13a934ad5ece@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 09:48:35 +0000
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
> TX completions can arrive after PAUSE closes transfer admission.
> Preserve that progress and schedule catch-up when the stream resumes or
> a rejected pause restores RUNNING. Cache device latency in stream-owned
> state so a late completion does not need to dereference the ALSA
> runtime. Clear both the cache and runtime delay on prepare and before
> RESET observes the hardware pointer.
>=20
> A playback pointer callback can also invoke ACK while the core has
> closed buffer-access admission, after the pointer helper has already
> accounted for completed hardware bytes. Track that callback context and
> refill only previously committed data using pcm_indirect.appl_ptr. Keep
> rejecting other ACKs while the gate is closed, and use the
> snd_pcm_indirect_playback_transfer_appl_ptr() for the refill. If
> [ ... ]
> mutation used a test-only kernel hook because ARM64 control-page mmap is
> unsupported. KASAN and lockdep reported no diagnostics.
>=20
> Assisted-by: LLM
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113-fix-virtio=
-snd-recovery-final-v33-0-13a934ad5ece@gmail.com?part=3D17

