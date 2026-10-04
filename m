Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44C5443DEC9
	for <virtualization@lists.linux.dev>; Sun,  4 Oct 2026 13:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791119513; cv=none; b=f17kTxErCR6I5anXCgTf6VPhe+fgA9svtOatwjxHK6B4HIC00DqSSPceTN1ikJf9dAvk1Jza8LkTxFqmW6Cd1lq4EQ3miC1lOzVLR/MhPoSIy6o+eoPD10sWmLF6No/L+uUL89X6OideqFlkaXhg1/YeIYAg9Hh1/2WvQQRc284=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791119513; c=relaxed/simple;
	bh=X/rSWUefDGBR5RRG9AcWRppraADJxtthh52TXuwPh5o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qo20FoyvHiaABIKkIGtaBZ5VrjkQS8KQlkxQIxmzfkiNonGyMKOpukBrYWtij+4LSJLgLSsigPLeb9ehVTEvXzWqJW7RmqF9vIPTKk9x/eCByYjY7FUWSYmMxHYa9oLznf5SyGL64edG4d6PHzjDbcz/2i6EljC0oEwFlIkz+bA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LQV4gC5o; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LQV4gC5o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D405D1F000FF;
	Sun,  4 Oct 2026 13:11:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791119512;
	bh=pwTmf7uTLlHgMIo4juz7LuAmt2sQrSfom+s2wS7M0Ug=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LQV4gC5okaWtW1RD7HCLIfvWURrcAHZ4UD7RxXPSecaV8ou5kqgtRN88RGdL2qrkE
	 GFntQRdmUYufMDSQtyKb5NqputXCYdWsVKYii4v/EXN9MsXYFSgHkk9PL4mqaus//5
	 pwmOGzTNeYb4BFG7mUWCTG4zaiUT+wvLXCHm5l21fR9pe4Dcm0YAKxrlqAvJ6httZI
	 yrVdXUJNZqxyKicFpOMPOgeMUdq0bJDQ6SlkMZd4maC9vOQFyzxNReyb+Hawi8MXv8
	 8m1mOeChvEMz4L3lt7Ee7qEZwMyvmTHvi6U5I7V7LDev2GPZq8dn6dT0NxFRMVLEKI
	 x/PdlCo++z7hg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/6] iommu/virtio: stop queueing and draining once
 the device is removed
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anlai Lu" <agicy@qq.com>
Cc: "Eugenio Perez" <eperezma@redhat.com>, virtualization@lists.linux.dev, "Michael
 S. Tsirkin" <mst@redhat.com>
In-Reply-To: <tencent_5FCFC7891F9B565EBA65B56B951EDC219B08@qq.com>
References: <tencent_D757B544955DDC509B5DC7161F425620BA08@qq.com>
 <tencent_5FCFC7891F9B565EBA65B56B951EDC219B08@qq.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 04 Oct 2026 13:11:51 +0000
Message-Id: <20261004131151.D405D1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

> viommu_remove() resets the device and deletes the virtqueues while
> userspace may still hold domains that it maps or attaches, and nothing
> stopped a request from being queued - or a drain from walking the queue -
> on a virtqueue that was being torn down.
>=20
> Set ->removed under request_lock before the teardown - the lock a
> queueing path holds while it checks liveness and adds the request, and
> the one the drain holds for its whole run - check it in the queueing
> helper, and let the drain return early when it is set.
>=20
> A drain that returns early leaves the requests still on the queue
> behind, and the device cannot complete them either.  Detach them
> from the request virtqueue - which unmaps their DMA mappings - and
> free them after the device is reset, when it can no longer be using
> them, and before the queues are deleted, so that the objects do not
> leak.
>=20
> Fixes: edcd69ab9a32 ("iommu: Add virtio-iommu driver")
> Signed-off-by: Anlai Lu <agicy@qq.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/tencent_D757B544955=
DDC509B5DC7161F425620BA08@qq.com?part=3D4

