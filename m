Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794268311;
	b=j9WnUSFL8/jcY+MfVYxiU8B5t6LpnmrdvNZkQV8vL6+c0H3Z9Nm+e4TLZquK3iz3KWbg
	 naeSWqfXkCYCKe7Ec8TXqnTb+3X43cq40WOEBfbFhTaGQM9AyLeYGQabSYQjTBERzhguy
	 Me9dqCrBl2C23l9atBrrSxNLUyWBWFB50yyJdl77ghKHA3hPEC0rN5zzbd47379kxThnP
	 eKzLu+vI4EKLoi1qJi7/R8qFNX+WZoFjsorWC4u2Yx8eKS0dFM8iMDIl+aZGjzgmOxUSA
	 QJYodapiM35iR6xUJP0abncZVFyb4AbaPBfq86mclNMT4H4/dzVPd7304RRhvrklR3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794268311;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=1w9wuexE5rrdQMf4sORbiVQS4dwIfmsENbStgWU7p0Q=;
	b=fsNSM84k8rWuPuYvjppJjvPHkNp2mngzzdYOcyaepvlE8WMxhNZGklwLdiHT9K1wwTzm
	 NwGkxOlMYm72dFHYdGVAncn1IzKRZHQJFWcAu2De18bA9P0MwnLWe3G56St6edDvit5+Q
	 DQQIlmsR9z8Lv0RT8ZZWbxn8e3qOaB+GzovkeL412XajxsD2gxdIPXLgb2K3CVt2nHKma
	 rMZ3mgaIWfdCdZN2V5x259pnU1MC7XavTofOaEQr8DaQqoGYDuDoRKl8RPlOnAOzK8ytm
	 Olo46ukO62XxS0KaNMmSUTn0uBdLjRZBYi6U3wEu1ulW9jdZ/kIkhdUvXIzlRp666ng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GfivQY9M;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B45D606A325
	for <virtualization@lists.linux.dev>; Mon,  9 Nov 2026 23:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GfivQY9M
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 297DF1F008AB;
	Mon,  9 Nov 2026 23:51:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794268311;
	bh=1w9wuexE5rrdQMf4sORbiVQS4dwIfmsENbStgWU7p0Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GfivQY9M3U+BdbUNRMxro742/ds+mmPqG13Do3vrO7jHtyZ91GUrigu9vK0ATFHYY
	 zgRS3iVWTefJP0WO1Bv0wLHzexrL0EpwXOuJhhbbvVuTDLUDJGt21ACvu0XGz0B8tp
	 ZWyH1dpM/URzuiGTvAKvTQ0WfzYqqxJrJT0yMLOBc9e2VJ7JYH3kY8yKode3yDPbYt
	 6BfOn42KB9mjnLX9jt6Fr0LkjFel44Wn9pyu5gfNkLGVSYsDqna8Sl9If5FewmrveT
	 p6kpx4OApzmooFQYwgLwYi4Mh5rC/P4ddVf0zm9JnvoHEqxTJDV0DkMYhPhWk3tc57
	 W18aSPW5ReLag==
Message-ID: <sashiko-outbox-205798@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v23 05/14] ALSA: pcm: serialize linked buffer actions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261109234049.79534-6-mynameisjune111@gmail.com>
References: <20261109234049.79534-1-mynameisjune111@gmail.com>
 <20261109234049.79534-6-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 23:51:50 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109234049.7953=
4-1-mynameisjune111@gmail.com?part=3D5

