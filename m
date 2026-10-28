Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793203831;
	b=lrx6vlYMEJxWtOW3ZLqQf/l/Mq1f8csla3P9AqI+UHPP6bNejP03XM1IGrUEv/DKu5cW
	 M5xRtgOj8k6kNthGUmSgRDHQmQ7ytr3IBzJNDLPVhGMCh7LGUw+Eblkc+f3JR3GJsRdv5
	 v3DCmUoVBuG/Rg+VnnH7vp1gFj+dtUE8HkrokOXD0zy3KNaqp6SmVjO+pFpKEC43cGAAR
	 HSpELlvw8VDrEEJmkTFNrVKqnfyR6Ss4XhP0Jn7JXUat+Y2RVQdQcJPaKQ2HSdv5ztFl7
	 pN3yW/qPI+6E0tSOBqB1E4+zlMaP7rwoZsABJ8iPNdjgPqT3Ld58/Dxm6IR7QQkIeqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793203831;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=TY86ebr7vvoC+jsUytv1515xtJYhUjIljcY8Ma5sVL8=;
	b=XfjODttCnAQfxzlcgHNN1qytUVA+gewJVJtc6tk6/PSofbJplFs5aD15mWqvjUL4yv0H
	 zV89NsFyrrYQoJ4GGoAT9KsZsVjrSFM7CrabvFbAUmMtBsQDEwuskbM2vTcQM5TVCiRhP
	 oeGFc7muWYHXNmTppA1w7dsbpBD8Vh0gKSRm64swARtJn02Z03Sa/cT+mXxJ0k98KnGhj
	 HHXWuSYRwgz/bdo3YILIaF3AyNytiGY8rsSRvbgR+sgKIIkCQcqcZ70rTTKqcswuQ3yKh
	 kcNkgfH8ni64AsRj6+RC9ddbW0sz03B6EilAz8d9nv+FjGNMVdLpIDpjrP68W9RKg3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Wp2HJ67o;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A97F606A31A
	for <virtualization@lists.linux.dev>; Wed, 28 Oct 2026 16:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Wp2HJ67o
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 094001F01300;
	Wed, 28 Oct 2026 16:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793203831;
	bh=TY86ebr7vvoC+jsUytv1515xtJYhUjIljcY8Ma5sVL8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Wp2HJ67oMOauukaYmCdPoDqtepR+Kxc7bvhkgo01OMAiwAWdOscuWFfLIqE7F7omR
	 k58NWZ2geMZIXAIyTWaU8KofbISLH4LmRKM00w/7gDnTBenMOE1uvmLhi1onehJQmF
	 ncwPNApFj7n6Fdzk7fWMhF2vknUN/6NDbX3Y/suu55jwNYi6QUFwnDW30zN/ClQh+2
	 HnlkVzq4pNGKsqPRt7OnCHxwP0rDccAd0ZwGC9Dwa6o7I3rd3qQMPDGxq0yW6d0Djm
	 tAL9e5qyD2j+syIsew3MWvFwhtOCq7UJbtGlwoFPosGezAlMGwJfXIWpRMZLleyY6F
	 L2HWmGRefLCXQ==
Message-ID: <sashiko-outbox-188120@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 1/8] vsock: expose the core port allocator to
 transports
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sergio Lopez" <slp@redhat.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261028-vsock-dgram-support-v1-1-e457cf7cee78@sinrega.org>
References: <20261028-vsock-dgram-support-v1-0-e457cf7cee78@sinrega.org>
 <20261028-vsock-dgram-support-v1-1-e457cf7cee78@sinrega.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Oct 2026 16:10:30 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> The core port allocator is currently private to connection-oriented
> sockets. Virtio datagrams need the same bound-socket lookup tables and
> port allocation, while VMCI datagrams must keep their own endpoint
> creation and port namespace.
>=20
> Export vsock_bind_common() with the bound-table locking inside the
> helper, and use it for stream and SEQPACKET binds. Keep datagram binds
> delegated to the transport so a transport can opt into the core
> allocator without changing other transports' binding behavior.
>=20
> Signed-off-by: Sergio Lopez <slp@redhat.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261028-vsock-dgra=
m-support-v1-0-e457cf7cee78@sinrega.org?part=3D1

