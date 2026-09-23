Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7A4D41F357
	for <virtualization@lists.linux.dev>; Wed, 23 Sep 2026 18:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790189225; cv=none; b=I3i4XkgfdUF1XCH+FasHVbrbpji3umdVV+84uxTwxwDPUx58UmAqXGarkwqo2Ynnxh+CXbDlkjYso4yAX/IpuShV1+G+eKrUU1yYD1k8XWuxwaCGMpjgCFoG2EAfj5VKGzri6UgzmOPmtq3CzqSMLLN9ihdZewik08HKGupJQQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790189225; c=relaxed/simple;
	bh=BQD3GwMF1raWsP/beZg3DtdvqRb0fwIzCo4Ril/BS0s=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HSzHYFDd325kIyK/5tcR7aItF/JBDSaw2qS1fsO0sJHvyVzimtRo0MHjdUHo/X0I+YGvTzJ/8ywCb5nSEpvQFxlCfTMr7Y6imUjOxgbwO6rEmZ0+nG0pcgJB59ZQcfRHjQ3zUAvbZXGfNyb7gkvzO+OEE/sXINnRXBblf6nIDoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=adO/qgGL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="adO/qgGL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31D671F000FF;
	Wed, 23 Sep 2026 18:46:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790189215;
	bh=BQD3GwMF1raWsP/beZg3DtdvqRb0fwIzCo4Ril/BS0s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=adO/qgGLOCzYGEXXSHIKryMp4x2VD7J36BjBXan33PvjqoUFfIc/Je+D+mtIoLgG/
	 NMQgQMWbgfOqXMtrMWaPZ2CWSOvZ6H3uVgkuk99oD/K7EQngcS25X97Z4Svmwk6L31
	 Vfz9rvMg2eqkSfhwyH1gPtn8OsySdkcPazWS1gWDBhoNlnlbes38hhvvmcCi3v8Ps6
	 9xIHxeR/M7ehg2qKo+btlcHThgCrGbVCfDgrLMHlntrcWBLIsSamP+t4zR7Dwo8Lop
	 QlnLd4UUubAcogZSveDlnZfvdTylCDj6jCl9gGW3kpu11HcIfIk5xxr4P8GXyCkpLL
	 bO1ebpqyFzCRQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v2 1/2] vsock: report pending receive data to
 io_uring
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Carlier" <devnexen@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio Perez" <eperezma@redhat.com>, virtualization@lists.linux.dev
In-Reply-To: <20260923184008.153541-2-devnexen@gmail.com>
References: <20260923184008.153541-1-devnexen@gmail.com>
 <20260923184008.153541-2-devnexen@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 18:46:54 +0000
Message-Id: <20260923184655.31D671F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

> AF_VSOCK stream receives never fill msghdr.msg_inq, so io_uring cannot set
> IORING_CQE_F_SOCK_NONEMPTY and retries a multishot receive even after the
> queue has been drained.
>=20
> Fill the hint at the common receive exit using the transport callback that
> SIOCINQ already uses, and report 1 once the connection is finished so the
> caller performs the receive which observes EOF, as TCP does after a FIN.
>=20
> A vsock loopback ping-pong with io_uring multishot receive drops entries
> into __vsock_connectible_recvmsg from 1.97 to 1.00 per delivered message,
> and receiver CPU time by about 3% (25 runs of 50000 messages, p=3D0.006).
>=20
> Signed-off-by: David Carlier <devnexen@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923184008.1535=
41-1-devnexen@gmail.com?part=3D1

