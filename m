Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794562303;
	b=n69k5KKYq1oNHomSQxsMWyhJyiGdXdqKqj324+h4jSfF1HiDgP4dSbXn9x8tWCKEwPxK
	 ZT0vaTfHKcwg/sMD9rBbXzcsTvpfKd4CyXy5T2WlHUGQPTMqD2EUdsdILgkKdkQhTn0LQ
	 zPkCd73fJdy+pJdAVqH6f37v50h6btomq9hkaasqh4t1k5UwpdoHaO4kb5db+nFLHBrsL
	 WpIXWy8KTY7OA6teQ0G0Mwz9XLSSddXnql5z4gLPwt1VfdVPnRPZNY912w93iGJCQ7dKx
	 Hd2hd6H0HaQOjZhll3U7MwSRCjQllfUl8Gk+g9xlgTtKD+BAdsaiY/bEF/JkXADUdtQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794562303;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=CYE9WWbycIgS431amWB7I1hgRbA4TNsa3aNrZTf2uaI=;
	b=171f/vtXRdoSCIHK9N+R+cZdxaLKsCqN46i4+W1aIzTwHuc609dv1qHukwIguM8flgXa
	 YfnbO4Hx0t1HFbfND9oL87W4Mdh+B16jT6wbOt5CclD4FjEZ4asVCdnXRYfRKZK6/kHI2
	 YjvNgkCCdPJ5x+uvdOrLrPdQZcb9c7Zj+Jqm6UyenaESDNeCHAcemvk/Fiim0CPzwZ5Hs
	 wj2uZ6EOPSbNR0U1srp1EtbrvJzEe5ppzYd+JyJfz3qX7OPT6Gl9EQAaZ9l3PMK37HWEu
	 /FxMenzKWDXHSRpqbDRpFydsvLgfp/P858dPJSZO/ebIm3zL3HHh83yunfqxdsAWS/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R4ScqtCN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0820F606A32D
	for <virtualization@lists.linux.dev>; Fri, 13 Nov 2026 09:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R4ScqtCN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A553C1F000C4;
	Fri, 13 Nov 2026 09:31:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794562302;
	bh=CYE9WWbycIgS431amWB7I1hgRbA4TNsa3aNrZTf2uaI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=R4ScqtCNdTA8shiquQxDYSoA4QMpXrb0ow/6pOPr0MgsywHea1NSlIi0081YSUPuT
	 FFl5CVIFxdfZqcuNdbqaHvLeABU3a4sthOfywdW/tOllIJ0Y6Zy+uAMpDgKUWvazsG
	 cVtAbnkBnNDAt5epcupn4U59s5oLcBxJw2CYv/7lcwz9Ykvbfi8eVIzU4q59cLcaPr
	 LHdQDJB/ZFNx6ExHT5mwoyse6fbdOBbJWagS5Xub3LbJSVRaQGr7UMxt9A7x1H3n0l
	 tCJ0Sf+/JlyUZWsje2bD5W10wdqkAngcvJY3h5KFtwZzHmZLhMSF5qxws2Psaw9IeH
	 a7NY8YLzCOujw==
Message-ID: <sashiko-outbox-212549@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v33 05/18] ALSA: pcm: serialize linked buffer actions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261113-fix-virtio-snd-recovery-final-v33-5-13a934ad5ece@gmail.com>
References: <20261113-fix-virtio-snd-recovery-final-v33-0-13a934ad5ece@gmail.com>
 <20261113-fix-virtio-snd-recovery-final-v33-5-13a934ad5ece@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 09:31:42 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113-fix-virtio=
-snd-recovery-final-v33-0-13a934ad5ece@gmail.com?part=3D5

