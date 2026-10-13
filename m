Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7CB62EB0F
	for <virtualization@lists.linux.dev>; Tue, 13 Oct 2026 00:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791849964; cv=none; b=TGHQU2CblWFafBg/AE1oVA3ySMkDf6H5w2rltIv6w2AQjzm6/9R2iiirDG/wNgFfRA1vd1vijODePIqATl+DiXchb4ZzlzlBP9Y5pE/A1d7hCO7/SrhMhj2Pn15SkXvv2RMymj6vd9E/M6jglUtrgygIr0mTSS/NlHHr4ipV3g4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791849964; c=relaxed/simple;
	bh=cMUkesZBa/OG9E/ek71oGZI0Th2mWdO/Hssd/I2JPwU=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=BNmOvYo73EZbqyemAvdPxjCDFQI6TGFER/LmZWmOZCcTMBqW32FfCv9doXLdi6Y4b/mzAXjDGwFI4VVUbS1b0trj/B+p9n1YzVvhCgNtxsXcaM0fukmO/gEn9h7ta5Drx2tICpVVb7wnqMDc7zaVmN/i6NeeTGEXjrGhEVyAzDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a9P3SEc4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a9P3SEc4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23E4A1F008A2;
	Tue, 13 Oct 2026 00:06:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791849963;
	bh=cMUkesZBa/OG9E/ek71oGZI0Th2mWdO/Hssd/I2JPwU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=a9P3SEc4B/iMfL0Bth+6VOQYAwA9xXqPZBCFGXVpPLOckqd5tLsMquAXTK+X6o2db
	 G5Zx+2mF0Zmla4HESsS4jdqHrrSYNEYvBpt9QDNv/VvwWJUyWfCKHV1jk2d2KmIvqh
	 nlHEhHwGnXrEWFPhumt4Y3LEWfdBMDBRaR7cpB+h0Xsk5go3JgFl8KtSpMDdW1SRv0
	 sDT20awE4+ymgjfu+75YLXyVLdMy/FMTEWP/Nh9cbAwY+H1e+W7kfFV2uHvNXPXIta
	 GnI/pS3CofUhX7f0aQC5UC8lhF8YDIHhU4n1MzDyj2zfMGSKwp0jnsQy/bRzFrlmh4
	 5vSvz+yqOgBHQ==
Message-ID: <sashiko-outbox-168771@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next 1/2] vsock: support SO_INQ on stream sockets
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Carlier" <devnexen@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio Perez" <eperezma@redhat.com>, virtualization@lists.linux.dev
In-Reply-To: <20261012235524.41468-2-devnexen@gmail.com>
References: <20261012235524.41468-1-devnexen@gmail.com>
 <20261012235524.41468-2-devnexen@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 00:06:02 +0000
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

> SO_INQ makes recvmsg() return the bytes left in the receive queue in an
> SCM_INQ cmsg, saving a SIOCINQ call per receive. AF_UNIX stream sockets
> support it, AF_VSOCK fails with ENOPROTOOPT.
>=20
> Add it for SOCK_STREAM, reusing the hint already computed for io_uring.
> As with TCP_INQ, 1 is reported once the stream is finished so the caller
> reads again and sees EOF. No cmsg is sent when the transport cannot
> report the queue length.
>=20
> SOCK_SEQPACKET is refused, as on AF_UNIX: its transport callback counts
> messages, not bytes.
>=20
> Signed-off-by: David Carlier <devnexen@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012235524.4146=
8-1-devnexen@gmail.com?part=3D1

