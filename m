Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793367521;
	b=JQO9t3Rgsww9EuoSJeP00tSWycd6s2UuuRViHUue2wUQ2mHY2hwjZqc9Xt1TEj0AL87e
	 kwz730GgiOI7dcgLZ9GrHltxD21HTkyhz89R7YFvTCFr1JXAHFO7+g+KDj+3uX/DWpUoL
	 6YkfEKgeR3ys4YIA0zZFzaB4omB79xlRz2X340kgmE7b+olWZbn4I0iiLysIMm798Tyv/
	 ipg1e49Gpr+SYbvSWwkBweypWTWz332679uE8dh9GQuFuS9hO6LC//nWPBl4v9qZ/jurP
	 G90I93lv7JEypFt0on97SbVWPKAwdMFsOiEKj+tsdXHiSUDvdwURZXF2/nmQhM0F5KA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793367521;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=NxLXOKXO0HX/zVm5kEVMuxp1mzv9UwYV2F2N3HYwJO8=;
	b=ijf4PGAE77PIlt574o7Sp0IHQO8ySgabcwlrj3otjCI1yCFQK2YcjoRC/ejQcWo9/V3c
	 522cUz+0VcNUW611ldb7F91b5DngIxJYdZIjb1DQDEX92FawJ3ZQXDwvDpJcdRu5QVaDs
	 DEQlWP7mED1oc90S9jUCXhTdYI/R74kJ3jRflOVUNhBV2OeqNnEUr3izBvOv2fAlPhgGx
	 cLGGt9H4XEUj+Gr1G6oHN3gnI58GD8ML5GV+8AlIKmlKZL5anrSamLzIZNo6UdOwdHdq2
	 kaz5Sm2i1s6vn2SAraF2xtlfzG7t9ocMA2k1pkt++aQKBPprqbyxbMAfp2AKZ3poXBQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jDVNspyF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 590C2606A326
	for <virtualization@lists.linux.dev>; Fri, 30 Oct 2026 13:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jDVNspyF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1A5F1F0093A;
	Fri, 30 Oct 2026 13:38:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793367521;
	bh=NxLXOKXO0HX/zVm5kEVMuxp1mzv9UwYV2F2N3HYwJO8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jDVNspyFxcto951h9eZvT27xcH1kReGh+tDm211XEB+0+z+n81ft0XipDRXuDxlB9
	 oNgDsB84VL2V2y6FOF7TnlUVLBMK0tqCJChRhAdQkyv2+m7qnSj8MJACybNl4MaYIV
	 pz+kEdba8fqotpy6T3JHUFXRalZ/2JqGOv5HIqVhcNkPFPvm1ws6Y74hXsNz2W1kWW
	 ityPP3iio9OJ1TNnuFxnqdyXz6g/3fmr+UpVJNlRgwLLbaOaO/Dh8fw4cSmtL4lx/h
	 RW9RlTyLyEkt3YMORHOz0tq3yDzYDDQ92MQe/FvYfGuAl+/2rrqBcqhWccaQTuUufj
	 8RVYEwC859CPQ==
Message-ID: <sashiko-outbox-191075@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/2] rpmb: add a virtio RPMB device driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Haruka Kuze" <harukak@zohomail.eu>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261030133000.24147-3-harukak@zohomail.eu>
References: <20261030133000.24147-1-harukak@zohomail.eu>
 <20261030133000.24147-3-harukak@zohomail.eu>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 13:38:40 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> From: Haruka Kuze <harukak@zohomail.eu>
>=20
> No driver exists for virtio-rpmb devices (virtio ID 28), so OP-TEE
> running in a guest can not use them.
>=20
> This registers the virtio-rpmb devices found with the RPMB sub-system.
> Each request is done in one transfer on request queue, and for key
> programming and data writing a result read frame is appended so that
> the device can return the result.
>=20
> These frames are copied since the caller's buffers are not always
> usable for DMA.
>=20
> These frames follow the emmc definition, so that the device is
> registered as RPMB_TYPE_EMMC. The device has no identifier of own, so
> that a fixed dev_id is used for the key derivation for the device.
>=20
> Based on the virtio-rpmb driver in Alex Benn=C3=A9e's RPMB series.
>=20
> Link: https://lore.kernel.org/all/20220405093759.1126835-4-alex.bennee@li=
naro.org/
> Signed-off-by: Haruka Kuze <harukak@zohomail.eu>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261030133000.2414=
7-1-harukak@zohomail.eu?part=3D2

