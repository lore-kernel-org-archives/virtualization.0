Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793414025;
	b=c4BAxsR5qVPcBdM6yRzQ0EFqVoRyUnPC7N/rspjiJ9Lr0e1FXdovY2jc6FCp+5rkgGO4
	 35Vp6UXvx9YYyyu9hAJu5q/1Ghr5rf/tCjaFLsI/GLnTdGvo2PzkZt0pwtCMPWWVyRi4s
	 vWIqd/itoxSv1MKfPw0WCvHOk3zSKZCC1neMx6SZ0mgUFg6TQGtaVe/gPVnjCyq5q4nHN
	 K37lMFu7dShWesPGffBdeK4hsjkX0xVeQSkXZQj1YM9AwIXEXcctN/Vg5vOaXKqvxSIcs
	 jVr6h1ZA90JdSqJmTF4BjMrM8XyD05b/C2vBmaesDKbmFpa5/1yMIcJQM/bxeoz5K/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793414025;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=+2YmNgTxUCd1mmnoHN9f3XT+yj7v2pBZQwwAbdhD1OY=;
	b=HnPlqFiGKzXKbfD0MRor4muEciv+uDlQGIM/1VdDXMOdwNVHrJRZWg+t6ahKR+zzZ9k6
	 1WmOXipPTDZ4uOSSO9ThMdXZLD4XNwgZaKJMHmss887BKvKzKjFcgyHuiQ17P41o8hss1
	 eTc3L6INJYJYic37ODv9BQrVLN5jfVXuSVCjsFkXipkdHSjC45OODLLlrkPHmnkM3VPtY
	 Zel7on0So4h5vzSHtKUQW+qGSqR0mU7rtfHJzlbwnyY4JPlVPzSaTyRX9+tqSmY3czhK8
	 hHV95Zdt18beLjUsreHW4WtPV0UyaoS9hqq/x5oHjCPyk2DbjRUZ/WOv1KK+AUBNsAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UQhSXSLC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A973606A31A
	for <virtualization@lists.linux.dev>; Sat, 31 Oct 2026 02:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UQhSXSLC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31FEF1F000C1;
	Sat, 31 Oct 2026 02:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793414024;
	bh=+2YmNgTxUCd1mmnoHN9f3XT+yj7v2pBZQwwAbdhD1OY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UQhSXSLCwTj+pN+vbBh9tgKMaZ7umaftNJ3w+u6IMlODBxcEH7j8qbJGTzBFzzuBW
	 qD1mbbNb+PX42+FAN+gNrAHzj+Y8RJ1JHPHftsQShPILKTdO3YVTm+KgxTm1rVu/lM
	 z+gMxzSrNOXkXr1UJ4Cs7Kti33In3wG/JWrcGj49ZmqNVpALE8JGZEmerYD+wh2dn/
	 WBLuzw58ySvisxlUmcSP0mgMIsWSlg+CDVrJpvpknobc33oHdG4wTzs1qRkV1VX+Uu
	 a3HMH6K3X+QGewVhye4KpB0MPB2vQFJT4sWkVBPgWvr8AgYOARIMa6GfJS0TLHdf45
	 qcmocLxowYdVA==
Message-ID: <sashiko-outbox-191712@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 04/14] ALSA: virtio: Keep PCM DMA buffers alive
 through device ownership
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261031020855.2402-5-mynameisjune111@gmail.com>
References: <20261031020855.2402-1-mynameisjune111@gmail.com>
 <20261031020855.2402-5-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 31 Oct 2026 02:33:43 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> Retain references to the pages backing ALSA's vmalloc buffer until its
> queued I/O messages are freed. On NOMMU systems, use driver-owned memory
> for DMA and copy playback data before submission and capture data after
> completion, so ALSA buffer release cannot invalidate an active request.
>=20
> Validate the PCM buffer and each period before building scatterlists.
> Clamp device-reported capture lengths to the message capacity before
> advancing the hardware pointer, preventing an oversized completion from
> accounting bytes beyond the buffer actually submitted.
>=20
> Require whole-byte periods whose total matches the negotiated buffer.
> Check offset, length and the final message index before indexing the
> message array, including empty transfers and arithmetic wraparound.
>=20
> Seed the ordinary capture ring once per prepare. Native STOP preserves
> queued requests and unread samples, so PAUSE_RELEASE must retain their
> ownership. Re-enqueuing the entire ring adds another period to pending
> message lengths and exposes unread DMA slots to the device. Return
> consumed space through the existing indirect ACK path.
>=20
> Fixes: f40a28679e0b ("ALSA: virtio: handling control and I/O messages for=
 the PCM device")
> Assisted-by: LLM
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261031020855.2402=
-1-mynameisjune111@gmail.com?part=3D4

