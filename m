Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793212048;
	b=WN6639uIj56pfEC3MUQCmIyVsg0eiHTyosmWd5Eok9F4+VF8OZ2BbuMkXe0vAJQHXANu
	 2GW4rTSbzSitSJ4vjI1MZlflAhgmxnIgWCqcqdcdc3ko3qUh8mXybnI3ZBpxsYRkptXCd
	 bRU+9AbHFwR6G+mGsetB1bYfUjwnuA27E4uabd48Rog7kIFg1pBHVNrvQATKIgGg0i6oy
	 5KjKPKCLy8C0v0ldPygnnl7qLV9AxQW9Myhe6nfB2ElP39l0PNJIja4bSJ9p6yOPMoxK9
	 24hNo0Du6gW9kPX+6FgYZziZCXNtRipAJWVmHxMcwVCMm4vRbVIYdDVCOH1yC8D6vvA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793212048;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=z+M73baNdcIDe/c/K+0FG+gjPTM4I9OJ6U0pgiMw7Rs=;
	b=dZSAbuQDihtanDlFACCaXF5lgfie1NDwJMJHEhYHKpL9UM2xyv3SisJMYPhTHJVRvJtm
	 WnTfj+rn+TmweLq7/hff0bKuSDrHcHaX0AC8z3YOSGaqzxijw97/geWsx0vp6bOJaZY1K
	 GlezcvEPNQPJMt9GL1vyGQLKZhIvqwLmu5dU8jPPD9D3wVDqnUtehr1S/xiB66gxyL6nq
	 AtBpJsA1rGGAC3QzFDIDgnNUYKLVJ20Ib6hflf5y0zDOhTOpPw0pFYGgrbzUmcgGnXKgJ
	 0BQJiB/z8UOeDmdoaPJfRFNXEWkw90VG7hYOswkzA5iAYABgJOIsveKUS94yTAXh+EQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PKVvEIRY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E5DF606A31C
	for <virtualization@lists.linux.dev>; Wed, 28 Oct 2026 18:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PKVvEIRY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 444E71F01825;
	Wed, 28 Oct 2026 18:27:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793212048;
	bh=z+M73baNdcIDe/c/K+0FG+gjPTM4I9OJ6U0pgiMw7Rs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PKVvEIRYYGIcLLWjXYlRLK8Ilrkkk2P1CsAi+bIc2WOosQBWr736RkH+k6TG8CE6T
	 CkRcbf6gvsP3PGvAB7I/lGSMdON3Y2TmO9GAc0qAbtrBw0yMBDetxhKlcQO2t2V6IX
	 Miz7d9jm9B0HAC9M0VLL+K7ZGj5eAyp5zQrpv4U80RXcwajQQul151CLJ52h/1/rH8
	 R2JJCrPKhe+wrhkZWGzutPoV3d6tRkOseKvWJsQ6aI46Xz2IdreKdRLH6W+E5AAS9z
	 bmjqon2Npxn9d5Zc0fcgb9ApvYLUGMmssSxUuPWjZA9FoRMZRENliGebZ8xGqziZUQ
	 v0fqD7uMgDrPQ==
Message-ID: <sashiko-outbox-188284@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v2] vsock/virtio: clear vqs[] to avoid a UAF on a
 failed PM restore
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jerome Mohm" <jrmmhm.kernel@eldare.de>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261028-vsock-restore-uaf-send-v2-1-675aad6da714@eldare.de>
References: <20261028-vsock-restore-uaf-send-v2-1-675aad6da714@eldare.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Oct 2026 18:27:27 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> From: Jerome Mohm <jrmmhm.kernel@eldare.de>
>=20
> virtio_vsock_vqs_del() frees the virtqueues via del_vqs() but never
> clears vsock->vqs[]. If a later virtio_vsock_restore() fails to
> reallocate them (its error path is a bare "goto out" that only unlocks
> and returns), the driver is left bound with a dangling vqs[]. The next
> virtio_vsock_vqs_del() - on a second freeze or on remove/unbind - then
> passes a freed vring_virtqueue to virtqueue_detach_unused_buf(), a slab
> use-after-free. KASAN on a guest with a virtio-vsock device on
> virtio-pci, after a restore made to fail by fault injection:
>=20
>   BUG: KASAN: slab-use-after-free in virtqueue_detach_unused_buf
>   Read of size 4 at addr ... by task repro
>    virtqueue_detach_unused_buf
>    virtio_vsock_vqs_del (net/vmw_vsock/virtio_transport.c:785)
> [ ... ]
> CONFIG_PM_DEBUG for pm_test; it is available on request.
>=20
> Fixes: bd50c5dc182b ("vsock/virtio: add support for device suspend/resume=
")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jerome Mohm <jrmmhm.kernel@eldare.de>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261028-vsock-rest=
ore-uaf-send-v2-1-675aad6da714@eldare.de?part=3D1

