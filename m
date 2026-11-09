Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794268692;
	b=KbAP4s8vJ8eDu7tQ0qDCECnGyxHBvB8jp9d8ou1acYBhAVcQtwJNZfRZLoMD7UrJHj1p
	 xVL8R3b3NDD+dNwhUw1pIQG3hdNohpM0NQoNnmGCzpc2UgqXxvFpbL1NJy19tCs9pV06B
	 7sr1O9PKI28rtdDkXmZ6+6YdSEX3wQd7LEc52WvOOQvwWwlKZE3+fPhDaUln9xVvDYXU2
	 lah9EQcbACyiyVxKuvF9vOeyIJW9RKom+ec6eh3RRSnPnBxEJ4b2sB4iR0+JLtR1kvDtv
	 njQTs/KEeSvDLXCYhvS/bPQyTpyXZQ9tKFZMJcDE2wTo8DDUmbJ7ZXNFi3lxrl3Nz/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794268692;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ludFu8zg/ObqlNpVqi0yxDQMv0tHX8kJbcRSr4p7PlA=;
	b=kDPb4p/sHPKvtCQ5REA1cfMwlaP3DGs3dLdHAQToqbWquiaO8wC+leC7sKY3N9+kUQNu
	 ETjYwmBwXAsL39GrwqMLgUfv0nGjdHqrNZgCAzfR2oL1PFK5O43fnVM9ccxHmrzuE5AW6
	 6W2ofbCHJqROstvCq3rlBl9g4WlnyDc6cG4cGdipKgp0MrHZl+zajn1Al7NzYg5/5p1IX
	 hFQGo6NABWmpf2G/n/ej9QO3N2GvCeLr+JmSWtjNsuQoN7pIPniShZV8cxB5Nwog66kvW
	 JZYvBz74vz6JRnciNkC4Lj1Dg19TtEH2n1P/FvwSoA/MQ4mSPDt6HpDggvY1ETAxVyA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cer0iwIy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A67E8606A321
	for <virtualization@lists.linux.dev>; Mon,  9 Nov 2026 23:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cer0iwIy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B818E1F0089F;
	Mon,  9 Nov 2026 23:58:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794268690;
	bh=ludFu8zg/ObqlNpVqi0yxDQMv0tHX8kJbcRSr4p7PlA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cer0iwIyp4aolACxtWdkqv9hE3HfoO+iWQz0Ex6EhubUmXR8bXX3PMplkw2oHl+Oe
	 Mhky/hu4aMjN/PruArdspcMjdV5vaD19mLv/U5GarqGYUflgc19+9vBLiMigXPQtRU
	 gaut+8z+WZzBlbmMPs+kN4Xw+LRqrKOOdeNuwtxj9w/bFT7pjwd7VH3gmRQ7MhhRbs
	 WyAkXbhw9t/Tt+eC08z5UY4w3DmdL7YqI+MK4K2J+i+y9BovgEGRknZ0/eFYYywefj
	 Gp9gPMx204NRx3rrKjh7MvRvrmHyxTd/BqlGwzVkDD4/uethXc17xGRyvjQk29Te3J
	 xOWF4HuaIXsRg==
Message-ID: <sashiko-outbox-205803@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v23 11/14] ALSA: virtio: wait through signals for PCM
 teardown
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261109234049.79534-12-mynameisjune111@gmail.com>
References: <20261109234049.79534-1-mynameisjune111@gmail.com>
 <20261109234049.79534-12-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 23:58:10 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> A signal can end the interruptible wait while a STOP or RELEASE request
> is still pending. A later teardown may then submit another RELEASE
> before the first request completes.
>=20
> Keep both waits non-interruptible and use the existing message timeout.
> Other control requests remain interruptible. Device reset still cancels
> the pending request and wakes the waiter.
>=20
> Keep timeout and wait results in the types returned by the kernel wait
> APIs.
>=20
> Assisted-by: LLM
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109234049.7953=
4-1-mynameisjune111@gmail.com?part=3D11

