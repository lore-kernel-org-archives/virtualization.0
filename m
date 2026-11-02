Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793626880;
	b=0TlViJqqHV85b5w+273sSVNuu/fJ3wM68NsKBOwwxxQc464WfFL6Lm36PTzS7lLztJKg
	 YhUROnF6bw8UJeCgcMpfl8z+/ocVIHZHqEKMbN9POzk4bMcw7GwtypcIOLLX4G+ei7AbD
	 aIcwPgUNjmUvu8SVRJPd25qnkQ6UGDUt6x3EteLludrx4xCsQ23CTatt3XnHo86gEM6bU
	 PQbrsp/3jqkJvd8ay0TUnJ0OPhGmxaFUxHL9z0cGhOnO8xFLQYs7E3SipgqJ7xxSO6bEz
	 0XjdbJUsfmVu74+oC4BWvOAxK1Hgryd/GsdVVj3nFYWrSz1Z7SA91nZnxIVYMEKypmw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793626880;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=y0B6LtzGbR7FeJH+p0Jo6793LqVNlMQm9vu8f4ysOhc=;
	b=dnwsaYp7omsnfLF7dqgoGC8cNK7aPJe2zUvpVssux2DHGxk7HdquXqkxanaQrBSM3/Hl
	 8mZazL0jHEf6FDTUKTL3Q3oS20iBmJ/uszqt8yrQeDZ4IWilfDO+8HKe2y8EJXXCWPW7h
	 TwhbaDCGMfuzq9XHisvYmSFHkOzzvs61E1HszTYHi8YMDEwjx4iftxA69MxKIw9E+zFqf
	 J+ij0v5rovYPKWioGycHKGYtEYNfq6I676+60zQrhZWjtO87rylfuByX7b8136MawK35G
	 wJ8c8gqdmQwCS+xNX3w3PT46euGcdD/ASqsWGHAMjX6xYnfQyvIEmR4Gb63yj1h4pAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TKrVws46;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB76606A904
	for <virtualization@lists.linux.dev>; Mon,  2 Nov 2026 13:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TKrVws46
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79F3C1F00A16;
	Mon,  2 Nov 2026 13:41:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793626879;
	bh=y0B6LtzGbR7FeJH+p0Jo6793LqVNlMQm9vu8f4ysOhc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TKrVws469ufkLjAw7o9fK6+zQGSvIZub8iw4L1qULZ3+XgNZqEoeXJKoN1ZQ33+Of
	 Cly4x10j76wVu3KHyc/VL+63moPDLSTqwry+9I6bHIRLZovJqhXYE9GmXrahulp3OT
	 e2EPu+XoSLkRLXdWty40t9e8GkMIx9qjNQ6DL85owzPGmwRIqP4bwBawytqjqu3I2z
	 dPVJbIiSD4BaDj7evJl6Vb/XuiAoie0o0ntC+o/bNNObIZEqDK70Op9Pvxg+fY0gL+
	 W31ipwhabcm3YuKO5LDdIs352A5nq1YPwJcHHyOhTRicKoqJTmHSpcQ/Yzora5dG9F
	 MNCTm27pr0ekQ==
Message-ID: <sashiko-outbox-193500@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] virtio_blk: freeze the virtqueue layout at probe time
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yunye Zhao" <yunye.zhao@linux.alibaba.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261102133740.88919-1-yunye.zhao@linux.alibaba.com>
References: <20261102133740.88919-1-yunye.zhao@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 13:41:19 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> init_vq() reads the writable num_request_queues and poll_queues module
> parameters both at probe and when recreating virtqueues after suspend
> or reset. However, virtio-blk does not update the blk-mq hardware queue
> count or queue maps on restore.
>=20
> Increasing poll_queues can therefore remove the completion callback
> from a virtqueue still used for interrupt-driven I/O, leaving requests
> uncompleted. Reducing the effective request queue count through
> num_request_queues can instead leave existing hardware contexts
> indexing beyond the reallocated vblk->vqs array.
>=20
> Determine the virtqueue count and the split between interrupt-driven
> and polling queues once at probe, and reuse this layout when
> recreating the virtqueues. Changes to these module parameters then
> affect only subsequently probed devices.
>=20
> Fixes: 0989c41bed96 ("virtio-blk: add num_request_queues module parameter=
")
> Signed-off-by: Yunye Zhao <yunye.zhao@linux.alibaba.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102133740.8891=
9-1-yunye.zhao@linux.alibaba.com?part=3D1

