Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E8E5424D79
	for <virtualization@lists.linux.dev>; Sun,  4 Oct 2026 13:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791119317; cv=none; b=hss3PgKmt6PSN7FiSLx9oBixA+cXZzIiRYd82c449BOX0k3Oyop//rvQeKgIq8erIO7Qk0M7SAacffKVYBL8ZNrdQwTW5nQIk+L1SqRjhLUxPQnZGm/4bNiDgCqLM21dmnhL92EkPu6l2/9tkUDcinfiEwtM5r2+XUQ/ri258hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791119317; c=relaxed/simple;
	bh=hEoCRxHp2GZ1ng3C6JxWd2mQXCo+vl3ID1KZMJLGFe8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GWXnyDU1HamYjUR4bVp3IZRk85IUGlCOAWDVgccE76hHmlq8ScbdB58dSV7HEZ+tuB7QNaFuh2OcgPPpYbzWVh1WVVSfoGL+5Q9m/tUhv3RBtMJSuxUBlxZkhEptgySBPZfXRPW0JC0Uoh9rgOv3tO8a18M4lRlg6PEYsA9umUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GNQmr4vj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GNQmr4vj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70BB81F00893;
	Sun,  4 Oct 2026 13:08:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791119314;
	bh=hEoCRxHp2GZ1ng3C6JxWd2mQXCo+vl3ID1KZMJLGFe8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GNQmr4vjlqTCqQHX6KT5lio9Aoowyrn8qlK0YXbcDY5eq6kxJsIkV+4SbNZHJyuki
	 iwjAZm9rcAPbKoFbBsoumXY8+t+hha09yeixdi2MfqYTbbUB9SJ/nryYj5L2ZnW8Gn
	 QseWQRN7if98e9Hi0mUGkSkIUQ7FacR4p2YxwJTU9K6V4Pt9sKj9iRhjJLX8dk4gJd
	 wvtJ0SAGfHGCKuIxiDPYyUyuHr3XpWSyZsYfSAncu3rGMEv9ru28j+WgJk005H5B6p
	 ZQZl1UN3VuC7I+f2FKNCaoYFNCBkmRsOASiE1z1BRLLb4Nn02bk7YPJO8D1wHIJZX+
	 gnwtNNz3NO00A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 6/6] iommu/virtio: batch the mapping replay on domain
 attach
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anlai Lu" <agicy@qq.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio Perez" <eperezma@redhat.com>, virtualization@lists.linux.dev
In-Reply-To: <tencent_7A12897B7DF3E958E903DD2A4557A8F6BC05@qq.com>
References: <tencent_D757B544955DDC509B5DC7161F425620BA08@qq.com>
 <tencent_7A12897B7DF3E958E903DD2A4557A8F6BC05@qq.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 04 Oct 2026 13:08:34 +0000
Message-Id: <20261004130834.70BB81F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

> viommu_replay_mappings() sent every mapping of a domain to the device
> with a synchronous request, holding mappings_lock - and with it
> interrupts - across the whole walk, so the IRQ-off window grew with the
> number of mappings: 233 ms for 8192 4K mappings, 29 s for a million.
>=20
> Queue them instead and wait once. One mapping per mappings_lock section,
> so that a full virtqueue - the only wait in there - bounds a single lock
> hold rather than the whole walk; the walk is a single pass, because the
> endpoint was published before it (a mapping inserted while it runs is
> queued by map_pages() itself) and a mapping removed meanwhile has its
> UNMAP queued in the section that removed it. The requests carry the
> device's errno back - the first error it reported - so a rejected replay
> fails the attach with the device's own status, and a device that goes
> away fails it with -ENODEV rather than reporting a replay that never
> happened; a duplicate MAP, which a replay can legitimately produce, is
> answered S_INVAL - the spec says a duplicate MAP SHOULD be rejected and
> MUST NOT change the existing mapping - and is not treated as a rejection.
> A rejected MAP on the map path is still ignored, as before.
>=20
> Measured, N=3D8192 4K mappings: max IRQ-off window 233.7 ms -> 1.4-2.5 ms,
> and no longer growing with N (1.4-2.5 ms from N=3D64 to 32768, against
> 3.6/45/233 ms on the unpatched driver); attach ioctl 218.9/249.0 ->
> 50.3/48.8 ms (48-67 ms across runs); viommu_send_req_sync() calls 8193 ->
> 1; the device receives exactly the same MAPs (8244).
>=20
> Signed-off-by: Anlai Lu <agicy@qq.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/tencent_D757B544955=
DDC509B5DC7161F425620BA08@qq.com?part=3D6

