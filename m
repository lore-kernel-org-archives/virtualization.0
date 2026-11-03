Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793703098;
	b=pDftDBtWtZw54rn98Wso1SanzZqh+cfo0uk2HIKFXSFTQ+rawTV1Lo8nJVW4+dklLxrc
	 agCLS7KffyFar/oXUQg5HEW9gtc+sIXgtuw6NzuMBEBIXDmGgJzpaC2kHDeDOMYbjubr5
	 d1i/3AdnFVqoav/BmnzwN2fPU8+wx24jhe2TwVQpBpk4EHNps3xXkZMISP51+BbLQXfRh
	 cKzonBbJAiIhUjDhUf+fStgByGrgtJzS3KtA5cYRDa355Avs+PZzRJVuqgdLj4wY4MXxN
	 OqiR+3zRQKGKugQbb3E1qKSSHhba5DLY33zz65EAUuqGOsVaF75a6ARE+IEND6YMDxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793703098;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ShS2sKoYZUPrDou1wr/VsE7ZmAyYrcMqw3f6nj6wr50=;
	b=mxHpIAhIMWmUPdi2IC2I0mQQ//Ozx8/I0aqxRgY3Dq+tXTTauF4zzlo9O9eFktGq2IWi
	 PihV0k3lbTJ+JJVklJqok+CJjgGa86J8C5b79YfK4yVz+XtOjhawBVbbb1zBeX+33ZAWT
	 r7Dl202lniGENgG4EL8sY7o3cHLv40Grf6p9Ny1lk4bspcBM/7wZFxg91BdCSlx08BFS+
	 4Z/hIkl3b4HyR9P6EOpYtg/Rle4fiQWcnXFTRXZwhZL0O8dLOK/AgWVwwezaNWV+Gte/Y
	 SuFe+lglBMJHwBRwUZQgfnWej/HRV0VbnrlTo6TYwLlrQJzVFtKg+gr9NCqao/4D4Fw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eirNIlb8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0606606B11B
	for <virtualization@lists.linux.dev>; Tue,  3 Nov 2026 10:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eirNIlb8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 604661F000C1;
	Tue,  3 Nov 2026 10:51:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793703097;
	bh=ShS2sKoYZUPrDou1wr/VsE7ZmAyYrcMqw3f6nj6wr50=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eirNIlb8pbuy8x85dVxugkdRAUMxlVM3L1boirYr4+qa/Lew+o3Pv6P/bhMXEpwLB
	 8nIEaO2F9FKXluwWxJVsYMk4zhMVUqQADMW9mEwdlpHiuoBsBIJkDwdjJ1w7ZfNhR0
	 lRPFo93JqSpu2Mu0Q/Dfuw4ir0qgBXn4pKV6lAAeebRYnG//ZeJVc8E18AF3haDXmx
	 Don9BH3NZObwYFJIF76FYtH3SJV6KscSWFR0Kywv0OkJCVyGyxrbaaG8ewVoiYYd+K
	 pF6ijpLCFaQS1e8hXPljwuhlefeVQUSmLEuooczzByeBpqHi/dw8+Ae3cU28p+pJTT
	 hFFudBSKlWWxw==
Message-ID: <sashiko-outbox-195073@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RESEND v3] virtio_blk: use synchronous quiesce in
 virtblk_freeze_priv()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Cong Zhang" <cong.zhang@oss.qualcomm.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261103-virtblk_sync_quiesce-v3-1-f40233f9bdd9@oss.qualcomm.com>
References: <20261103-virtblk_sync_quiesce-v3-1-f40233f9bdd9@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 10:51:36 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

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

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103-virtblk_sy=
nc_quiesce-v3-1-f40233f9bdd9@oss.qualcomm.com?part=3D1

