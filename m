Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0971147CA84
	for <virtualization@lists.linux.dev>; Mon, 28 Sep 2026 12:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790597395; cv=none; b=HAGO3Hei9YF1zmBuW3GbKwccmB+CWeIp1n3VocKHnAQ8CRqS8blpDZZ/bAGme99Ix/y2QDM9XA5uNCyD1uYW2xQVS9a+TC9tVI/fUke54lVAxhR051fIgbLutRgDyrkgtwe1+cPTfBjRwlW7EluglBaV64AttWMEWsKo0Z3AJEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790597395; c=relaxed/simple;
	bh=tQPX7NrYp7n3sk/0CDMu3iUwEYhp0Si/7/C63j1ntu8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Ke+dMSPGPwI8G4KzNO41nMAll2pN9lTCnUfEXYpNojVkTaAnMQ93G2qJzYQZk500f/5m/WdWGWWC5GwTDZlj1YEEB7HmKARjKXmLfeGQ7Ui011jE4dDx2g3Bb/CP3ITLesT5cEarc2JPjEv95BmRkXpK5bcZ+mS0xEh1y2S5jQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KMl4eqnc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KMl4eqnc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ED851F000FF;
	Mon, 28 Sep 2026 12:09:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790597393;
	bh=tQPX7NrYp7n3sk/0CDMu3iUwEYhp0Si/7/C63j1ntu8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KMl4eqncEmVrbewOc5n2MnX8v3KBSk/Z+lsly4tJVPLHCgR6Wc02oKBkCO7lefZBV
	 j72gPDDtGGrba8mAyigjYGMEYB+n3HkxvRYyB51/b/EXuaeQzkaHPwwLjLpeCoQthw
	 YdPXzmNbDM8vfedNAj++CYCYSTRHSEWHoLirZ165ED0RUSZf77pufjdy+Reuws7njB
	 ee4mYirTEKWuQYvOsdJXA/BIakGxZH+rgOOFlP2OBDO1JpmhA1ONDfteEYvOi1+Y3j
	 0P+fiUf6Qg+aoI4a8e6q3vorfbVS+gVZD34WlrYu5lNXctGoVhyS92b6jMw00kkcIl
	 dIwFgV1tHd3Tw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] virtio_blk: use synchronous quiesce in
 virtblk_freeze_priv()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Cong Zhang" <cong.zhang@oss.qualcomm.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux.dev, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20260928-virtblk_sync_quiesce-v3-1-a037e6e2fdf5@oss.qualcomm.com>
References: <20260928-virtblk_sync_quiesce-v3-1-a037e6e2fdf5@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 12:09:52 +0000
Message-Id: <20260928120953.6ED851F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

> blk_mq_run_work_fn() can call blk_mq_sched_dispatch_requests() through
> blk_mq_run_dispatch_ops(). The dispatcher checks QUEUE_FLAG_QUIESCED
> while the flag is clear. It can then be preempted before it gets a
> request. At that time, it has no queue usage reference, so
> blk_mq_freeze_queue() does not wait for it.
>=20
> virtblk_freeze_priv() then calls blk_mq_quiesce_queue_nowait() and
> blk_mq_unfreeze_queue(). A new request can enter the queue. The old
> dispatcher can run again, use its old flag check, get the new request,
> and call virtio_queue_rq(). At the same time, virtblk_freeze_priv() can
> reset the device, delete the virtqueues, and free vblk->vqs. The old
> dispatcher can then use a deleted virtqueue or a NULL vblk->vqs, and the
> kernel can crash.
>=20
> Fix this by using blk_mq_quiesce_queue(), which waits for dispatch code
> that was already running. Keep the existing freeze and unfreeze order.
> The queue remains quiesced until virtblk_restore_priv() calls
> blk_mq_unquiesce_queue().
>=20
> Fixes: 7678abee0867 ("virtio-blk: don't keep queue frozen during system s=
uspend")
> Cc: stable@vger.kernel.org
> Acked-by: Jason Wang <jasowangio@gmail.com>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Cong Zhang <cong.zhang@oss.qualcomm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928-virtblk_sy=
nc_quiesce-v3-1-a037e6e2fdf5@oss.qualcomm.com?part=3D1

