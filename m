Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792631780;
	b=iVKHA/g4S/1lWCPV9UPKHkD+dvqL+AnKqC1Tc7IXgi82cdLrjik2vr7MwxS18cyKfKIz
	 ywbcInwAS2HEjeC93zutPDwJq1I3G4YqIGNNCZSBIi/AQ9a3TAp55wgHjIjBBwvuLM0oy
	 mPa9pzyW+VdKTMF1zIqqbASSwrmWSS8T1w2szrUevBS0g59yoNYARWS1FJQ6HyXijB+Py
	 XyrdhNcCngSSDieVs2g7w1Hu6CIPrzp31zb9JOzPyGyO+tMB6YhfL4Hnun2JHVNXsJhd9
	 d1n3D0F1Xk7SKd1cZVilc1gsK5kR4dp5jpQ8EGwHEclZ0KxjDOiUgiLNdgjNDX+swYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792631780;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=B2sWjT9cL8bI653zgKgi+ymBJCjJfFJqBXHIuOWQ2o8=;
	b=nbAOkwn0lVjFoew2a4mkH5kL/D6OCEKzpXHMQnNc1wbEZH204JjrnuAeYlAsBWNLN4+K
	 QiHv+aKKuabocmD546+o1t3GeFBfrvGcDbMhkMG9tVfgAl+yqjE6UZo9WO8EaWFo4Q69/
	 C8V3Qvq6Kw/xJSZ3b0zdwr4PRuawlJmIe9Jl567yPUYGQ9VMEA9WY0dE8lW9Zt4TPiRfT
	 e7jkXbab2dgW2r9qrgspfeE40kitopMFPzcl1YGkga9epMNHjsLVZGSbo3fRvuCzHZMLM
	 VrpyNRpBkAn9NOfZPCIcx9WV7kjqVyRwicH/54JtxJgT2PpfkfY5kiyU3+wOLH0rtqg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AeB2sTdg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82725606A319
	for <virtualization@lists.linux.dev>; Thu, 22 Oct 2026 01:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AeB2sTdg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC1201F000C2;
	Thu, 22 Oct 2026 01:16:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792631780;
	bh=B2sWjT9cL8bI653zgKgi+ymBJCjJfFJqBXHIuOWQ2o8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AeB2sTdgZS8ZDz0AO7sPM9+6Ve9IR04wVzpKLNPfEhBpQXvzggLNRXbjynKKzkObi
	 xtnhT/8P5bFsqsYYtsDnSCNUvrwme+N7/9nxz7C22muAj/ynism6jbnOR1Bl/yWax7
	 nzcHISO9FsBIqB8xYaD84t8fr5VMv5L+wdeaxa0bj/1ZW5BamM3/NO4LaMkFZy9Wdc
	 HGPKuoMFBDOZDBKXot+lU/IJTNB8FKINTMGC6DW1BTgDnNCnAjGYDp1y0sV80xGmqg
	 7K42tOfZdT9CORRDj0fwdfEHGHi9rMdG1JpkSTWRXJsdZU/TC2pVsTuKnQ947Au5+k
	 VfmgEgl5wwlTw==
Message-ID: <sashiko-outbox-180839@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v4 2/7] vsock: rename the vsock pernet
 operations
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bobby Eshleman" <bobbyeshleman@meta.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261020-vsock-guest-ns-v4-2-047527cfccfc@meta.com>
References: <20261020-vsock-guest-ns-v4-0-047527cfccfc@meta.com>
 <20261020-vsock-guest-ns-v4-2-047527cfccfc@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 01:16:19 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> vsock_sysctl_ops and its two callbacks are named for the sysctl tables
> they register, but the init callback already does more than that: it
> also initialises the per-namespace vsock state through vsock_net_init().
>=20
> Rename them to vsock_pernet_ops, vsock_pernet_init and
> vsock_pernet_exit, so that later per-namespace work can be placed here
> too.
>=20
> No functional change.
>=20
> Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261020-vsock-gues=
t-ns-v4-0-047527cfccfc@meta.com?part=3D2

