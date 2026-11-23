Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795461917;
	b=I+mi2/LF1gOFMdInH8iYJH3NZkjebWmw1rmeGRHwlaD+ModrQf3vCJfnL7QoPHt7d8Qr
	 3swRrQqroZpNfxkRA3lIudSYwmsWApB/SEtGUCGGAX2kURHciw/8JUPYyrVUx5LJ9tnOm
	 LysxuzspFCHpPLn+y3AggjQGJ7uWgdfDUlldtAeSGcKChyMCd8K8ikCSu+6gz83Dci7Lb
	 HIcaahqU8IV1A8EClggqbfwKmkdbzSrF3lXn581avH6uQOjjwRrs4oT9bjFeKSv/26sNa
	 5pqQGIpjWkLqTSfOALjPsvuV7YU7YvO38I2vC8mjDd+dwunpE8ZaYftod556AHjgVXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795461917;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=QOlc9reKdDN1tdthGxrRUKdrX1sxgdh/fPgBhwe8FL4=;
	b=j2TjTLTMCr+942U5qMavB9QrEx5Ilw0gIl7Egi2d/m/SvSWrnsDqQVBS8ORMRctN2VmL
	 XI/apKpSKIFoXoAyRB7j1EqE3+YkoXf7A1apDuh2VEy2MaA7DJ72mAVzI+r8xl44XJqP/
	 mQb5DuCpUcf0h/jkd+Kn9bGcr8tDBf9YypuenaHBojAb8iXmJ0Ds+oEC22SIIP3EmZXfw
	 5gGMghG4zVZ2TuPodQK8EX164N7LidI6QYyLX0iE6AcVRWrHwos54XLThOodMnPf7/FG0
	 c6Ns+Z+TPfSgXCqLPkwE2fsYioXuQejAkFRYhjA4CZ83F7nveYgade0R0rtCQtuGDgA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mTKzLNS9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB623606A31A
	for <virtualization@lists.linux.dev>; Mon, 23 Nov 2026 19:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mTKzLNS9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1528F1F000D4;
	Mon, 23 Nov 2026 19:25:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795461917;
	bh=QOlc9reKdDN1tdthGxrRUKdrX1sxgdh/fPgBhwe8FL4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mTKzLNS9P5ctx/aw+7RjdzOb7T7pcZQ3B0tcVXW17qNBwbD2ta572zIyGsymoT0Jr
	 WrfWwABzHmyBXuay2EJAosh0wUExMeLOcNHndRHOZMRek8+H0WcqR+NyiidBx7aT6o
	 yRsn/ULPQYtWS90E9k3rAX1IjvCYmCH0mxm568FdYE7IwrL6LSUDcYmGI/uaCwdF6+
	 XBTWkyZTtFK9PqiGxlWp2Op68Zt8MEip+xhrof8DvuWh6UWAONBOj9bumymhbmRN2P
	 J4vZKgddwhqky8e1tOGXyqP3xCpId0TCwI8WbzNkNPZa70R1428LmilhZPvZ40B+Ri
	 CzsQsJV1W5q5g==
Message-ID: <sashiko-outbox-229930@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next] virtio_net: use page_private() accessors for
 the big-packets page chain
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nilay Vaish" <nilayvaish@google.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261123192220.4013325-1-nilayvaish@google.com>
References: <20261123192220.4013325-1-nilayvaish@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 23 Nov 2026 19:25:16 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> Big packets mode chains its receive pages through page->private, reading
> and writing the field directly.
>=20
> struct page is being shrunk as part of the memdesc work, and its private
> field is one of those that will move. Direct users have to go through
> the accessors before that can happen.
>=20
> Use page_private() and set_page_private() instead, like the rest of the
> kernel, so that the driver no longer depends on where struct page keeps
> the field.
>=20
> No functional change.
>=20
> This patch was written with the help of an AI coding assistant (Gemini).
>=20
> Signed-off-by: Nilay Vaish <nilayvaish@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261123192220.4013=
325-1-nilayvaish@google.com?part=3D1
