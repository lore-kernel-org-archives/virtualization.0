Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794183084;
	b=ZzYLix8G8b/6RIaAfa/X1/2AJ4DrtzHKNXwblnqa2GGbxYzpIXZqnoTEIahrudoJvZJh
	 bgJYhtXRuXSCqaeFPdEdIT9KSlQEjNBPV7hXbqjfoH4rHhvve6gy843IAjvChPMayN5yj
	 avXm1rSpeBiTTqmFvI6Q5GMs6N5lq3W8J9JWJgX6T5fY7gSYAJCfrhrqbQkoAlbH8wp5F
	 kkZuzEQOCngUDpbQTPdmFp5RNU7eCDtd6ajT/h7O3ut6up1IyirDKONWxGnevzPjHdkDK
	 1qXqochtkoi/cp+pEY2dekX39DB1Yqx+jY7qGQkmtvZ8JYqzzMY8oEe5sPCCegpSkaw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794183084;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=FChrEmFMsHKSrw4A5NiOtNEjQDOiKWYeEfQpTMm/ZFA=;
	b=aPq3UL/oqluaQ2V23027YGofOrAXPJa3Pop/Jj3VOtpPgF6r/H22cizRVZ5YzP6aefiu
	 K0K9uwI3SS7Por+YbaiFV00sm+idtIMj65lPNsEsd3HvM/XHelgh944TYwAdG+PVUIGRX
	 ir2D6us+c3OGjHt43VlDgl2f5YXCyxpqmNYUGjfkiKfwJF6b5N0LN0XOr/ui9vKFq3Uz6
	 6LOWVqkb3Wivbv6ZJclgW0lUQYjZn5CDJ0lRzx4wOnpvexVYZgcx9+1WN5bQyi1zQ2wf6
	 LWN/1XF7tPbhP8Q3qiQYgrtvODyDrMKJc/AYVHa2zwzgx2KdnNnNoUzy7Ddmhg9B6aw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d2YgZm7N;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 291FC606A31C
	for <virtualization@lists.linux.dev>; Mon,  9 Nov 2026 00:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d2YgZm7N
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BE981F0089F;
	Mon,  9 Nov 2026 00:11:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794183083;
	bh=FChrEmFMsHKSrw4A5NiOtNEjQDOiKWYeEfQpTMm/ZFA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=d2YgZm7NclJ4ChwDk8WqYoqySc+I7e5u4YI9UIuj7PA3djFiBZGwAnIukZWoxKTrp
	 sEAHb5MPrpCwpRe8KfCR3iW8JjvMNffxTqSBbBivMbChlXOaj3+0BfJJ41nY1RQybs
	 nHUer4IXAF8fqOloTn57qGBebe9IFODYfv8HOz2k8+GgLWwaH49p10Tvbf0ixTJ6h8
	 XwOVwa6+FR57hW43YKDTliZtGgKKoTR2QAcO2Can/rtiWdbTKEOpkMFFZSpZn9ib/m
	 eQ6VYLO83vVmc1vF/GTcjtm/ZnUHgJN8tKy8uJzfxQGj68Wd0ZHSCfsbLZhya3aPsG
	 YefpihcpEVpTw==
Message-ID: <sashiko-outbox-204199@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v21 12/12] docs: describe virtio-sound capture options
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261108235457.12688-13-mynameisjune111@gmail.com>
References: <20261108235457.12688-1-mynameisjune111@gmail.com>
 <20261108235457.12688-13-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 00:11:23 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> Document the five opt-in virtio_snd capture module parameters. State
> that capture_allow_empty, capture_allow_short, capture_packed_status and
> capture_pause_restart require capture_staging, and use the ALSA kernel
> parameter restriction tag for each entry.
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261108235457.1268=
8-1-mynameisjune111@gmail.com?part=3D12

