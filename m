Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 905F01FC4
	for <virtualization@lists.linux.dev>; Tue, 22 Sep 2026 05:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790053747; cv=none; b=OEqMgJwcTWAfqfmDdjxGmks6FvTeexrWsy8y8E83b45dSjX5StppSW0uHEr9dNi83X0LWnxhlt1pIeGpH4BZhdtFdXKy8hQwABfv/pLqepV1/YY4sFts9GjW32ENeAarYUNFqsQZ5/M9K5zshK1XQFiPyBuqZNNIRhJozQKKKig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790053747; c=relaxed/simple;
	bh=Og10SFGDUs8SuzeHpW92cHq8rKQ9+ir+flrKpy43ssw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kT/z2y3oQxsgyLisJsqW21aqj3T96e4RUVorPOUQZCvmY/UN56ZMhBtMKQoTRJN+IPPO3xg0+VCl+dYy0/yE5OqSQOomBbf6WuWpllzqcwazgYc2GzpyvTGogo9M/4jk94+iVfaW3aDFF3ulaIQq3rNXlEw+tcWNhOqOkdzxb/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GA7El/8k; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GA7El/8k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36B211F00893;
	Tue, 22 Sep 2026 05:09:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790053746;
	bh=4lkMDukgPNjMra5Qo8xXtuR7om9eDJod949q21RGdYg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GA7El/8kMOVBHeC7df08ESSPnrGQzGLbGPnTRljKMATBMhzzyZhan4D7InBg+sRh5
	 uxrVA37/kYwtw1Xv4Yj30D1wmb5g9V3rAHFq6ff5PoJxydejAbeF0+zdcTFzz3ez59
	 sc7tWMakbAKAAc0ZMvcYVR1P2K13MDRkxOr7MCLKw21peREPP/UZGA17BXGl+hYPq3
	 bFQaDq6d/N0OBc5YDgqMcOnO0ZecFmF/V4o0c/bpD0iQBVL5WBJ7fdhLX/WcLl9IrI
	 DLsOjELnij+FLt5WfDeltDF3McQIHd7UW8RtY1RHlISzvAftFCv76oGDDA/iswxrRG
	 z4WZrgs4wuMaw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1] Revert "i2c: virtio: Avoid hang by using
 interruptible completion wait"
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yuho Choi" <oss.patchbox@gmail.com>
Cc: "Eugenio Perez" <eperezma@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux.dev
In-Reply-To: <20260922050251.403857-1-oss.patchbox@gmail.com>
References: <20260922050251.403857-1-oss.patchbox@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 05:09:05 +0000
Message-Id: <20260922050906.36B211F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

> This reverts commit a663b3c47ab10f66130818cf94eb59c971541c3f.
>=20
> When a transfer is interrupted by a signal, virtio_i2c_complete_reqs()
> stops waiting for the remaining requests and virtio_i2c_xfer() frees the
> reqs array while the virtqueue descriptors are still in flight on the
> device.  The backend can then write into freed memory, and
> virtio_i2c_msg_done() calls complete() on already-freed requests.
>=20
> Commit 84e1d0bf1d71 ("i2c: virtio: disable timeout handling") removed the
> exact same failure mode caused by timeouts, concluding there was no simple
> fix because the buffers must be held until the device returns them.  A ha=
ng
> due to an unresponsive backend is preferable to guest memory corruption.
> Restore the unconditional wait until request lifetime can be decoupled
> safely.
>=20
> Fixes: a663b3c47ab1 ("i2c: virtio: Avoid hang by using interruptible comp=
letion wait")
> Cc: stable@vger.kernel.org
> Signed-off-by: Yuho Choi <oss.patchbox@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260922050251.4038=
57-1-oss.patchbox@gmail.com?part=3D1

