Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FBCB45FFA7
	for <virtualization@lists.linux.dev>; Thu, 24 Sep 2026 10:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790244288; cv=none; b=CmDm8tPYF/Sz01rSntWOrsMemX49QIsGL4AXV1dziRu6/0Qqhyvkd1modVth4VuPKTlCOSH3tsU1j6GIoGDuIi6EV0VDBBIvejuwmrtEahbwZkzb02GeM+hg7t2XPDLQUUi1AGDEbigHbJoBsVZi1bX4qzm83u4Yyu4BLyEx8EA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790244288; c=relaxed/simple;
	bh=zu0nkgjweQib9jicgTSO8dUt6uxmPAqflJYOqzySfAA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LApwJjAM9Ghp/YN9IHeIFpoZaOYZjzCgEF53nypWs8a7J8TQuraoZuRMwNrQu9dNbUOUdPmLXOPiuPV3Rnso3h02zCJpUCqvzYV3YsGNQIC7xCQ3Zt+FypLVU6rEe1zLT0X+JdkYLkk494YajXLHKG3UXd2GtP1hWqspkJquoiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PAQNTquA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PAQNTquA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32BF51F000FF;
	Thu, 24 Sep 2026 10:04:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790244275;
	bh=zu0nkgjweQib9jicgTSO8dUt6uxmPAqflJYOqzySfAA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PAQNTquAM13ECSH7uzVzlNYhcBXMy/zohNzRRvOGYbkJf0e4Fwsg0VfVw3uX50SBU
	 5nNiUlhTw286uSqosz7rP2h1gIer4lXTuNqY3gXQHdTHZY7rLZQBrXoPCt0uDb7yso
	 HkAS/ugVDklRxq2ZlYWAWE4Xhfljben5tNOlnp6Vp4E4/7XD1FnmkIqOdyk00oI8xP
	 Hl7Wa5U4sgL9M3Rm9OmllXUT60KueKmeUhVzM/Z1ijNs9ID0x9Gw9Xch7fFZJDoC0t
	 ATN1/bZbBun4zro2PdDtbxXV2fZHkQx4Qzo9ahufDlQo+TnspaU/51+JpKWORM3ltx
	 lebkVY28MIUwA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v9 2/4] drm/virtgpu api: add blob userptr resource
Reply-To: sashiko-reviews@lists.linux.dev
To: "Honglei Huang" <honghuan@amd.com>
Cc: "Eugenio Perez" <eperezma@redhat.com>, virtualization@lists.linux.dev, "Michael
 S. Tsirkin" <mst@redhat.com>, dri-devel@lists.freedesktop.org
In-Reply-To: <20260924095556.1326164-3-honghuan@amd.com>
References: <20260924095556.1326164-1-honghuan@amd.com>
 <20260924095556.1326164-3-honghuan@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 10:04:34 +0000
Message-Id: <20260924100435.32BF51F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

> Add a userptr address field so userspace can request a blob backed
> by an existing process mapping. A non-zero userptr selects that
> path; probe VIRTGPU_PARAM_USERPTR before using the field.
>=20
> GPU-readonly backing is requested with the virtio CREATE_BLOB wire
> flag VIRTIO_GPU_BLOB_FLAG_USE_READONLY (also
> VIRTGPU_BLOB_FLAG_USE_READONLY). The device MUST NOT write such a
> resource. The guest pins without FOLL_WRITE only when the device
> advertised VIRTIO_GPU_F_BLOB_READONLY (VIRTGPU_PARAM_BLOB_READONLY).
>=20
> Signed-off-by: Honglei Huang <honghuan@amd.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924095556.1326=
164-1-honghuan@amd.com?part=3D2

