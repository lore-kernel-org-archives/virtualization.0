Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D4ED403AF8
	for <virtualization@lists.linux.dev>; Thu, 10 Sep 2026 16:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789058647; cv=none; b=UGlJ9/3wtVGZ7DWIxPvZmbop2Ocblua1W9Nci+DbuO9OluR1GZD+PPO/ZH2myIeuTniwb9oWhlHtWCkYnRTDTCuXiGNTJPps0zlN8SF1Iknd/+qumkChQL/uWIgK7F3fnw7p0f8pEoHimdEtbgwMDv4psfRuFFiJWDQzmdjMgxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789058647; c=relaxed/simple;
	bh=svlmw8Jl9d1nU/i21jp/XfCQ/Fc9vAzte1k/5d/p03g=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=eCG0oVFawT5HdTgT1LPaIhJmxtK1J4h9BBIfHvMAaw7EEMpHMZq2XJ1nZjRSQZb3SZmoDJ/BgUvH9qqY0xg/W6CLkCrIAyPm1jP5SB1FnrIrUFUqkaxjxvUcPI1bO9rLUSUyzmMIWnzFHhmj/jNy4d+CH3CL+Oy6rFz0fw4YC+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PROVhW6g; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PROVhW6g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DD141F000FF;
	Thu, 10 Sep 2026 16:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789058645;
	bh=svlmw8Jl9d1nU/i21jp/XfCQ/Fc9vAzte1k/5d/p03g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PROVhW6gO6AbryWBZgOkTvB0+uM0kUWzfmEKFrspGMG1gRYXffhl2Ci08oGCgrRGc
	 pWT0iK8wogUE7ntBp+n/CcSTc3m4MeQy9Wk6/o36MCX6LZjIA7wavD4ZoVilyQpDMT
	 zdTc+50/HiKX18Xr9EtVEs8dSQK9QrRD4o4fC49in7uL8tPxTWfTtcN10QcDx9osUq
	 suw+e8icxPsNiSZFEOtAeuM9hb2Fl8BDABqI56Ft8Tb6+O7J3zX5VcTlAhKOkSnqew
	 THQ47Cgo5kl/bMf8YElNuFtvonBcFyMMI6VfTbwweygQ3sCb53BDymYy5iLy/2VbeQ
	 0yAP9jhHizdMA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] virtio_blk: use synchronous quiesce in
 virtblk_freeze_priv()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Cong Zhang" <cong.zhang@oss.qualcomm.com>
Cc: "Eugenio Perez" <eperezma@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux.dev
In-Reply-To: <20260911-virtblk_sync_quiesce-v1-1-a883f8f31258@oss.qualcomm.com>
References: <20260911-virtblk_sync_quiesce-v1-1-a883f8f31258@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 16:44:05 +0000
Message-Id: <20260910164405.9DD141F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

> Replace blk_mq_quiesce_queue_nowait() with blk_mq_quiesce_queue() in
> virtblk_freeze_priv().
>=20
> Keep the existing freeze and unfreeze order. The synchronous call waits
> for dispatch code that was already running. The queue remains quiesced
> until virtblk_restore_priv() calls blk_mq_unquiesce_queue().
>=20
> Fixes: 7678abee0867 ("virtio-blk: don't keep queue frozen during system s=
uspend")
>=20
> Signed-off-by: Cong Zhang <cong.zhang@oss.qualcomm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911-virtblk_sy=
nc_quiesce-v1-1-a883f8f31258@oss.qualcomm.com?part=3D1

