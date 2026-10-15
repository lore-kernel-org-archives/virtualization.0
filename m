Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3734554B1CA
	for <virtualization@lists.linux.dev>; Thu, 15 Oct 2026 16:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792080145; cv=none; b=F/1Q0rfT1XRGRTAPTdzT1jqChWns2sVLl75YfKFlWSrDFgco8syvnjOCTTkjyd6sUPCNRV1Ob9fiF3RR0Vapekva4bmMK4g3E/gufAP+UncX/KRJNm/axAaSqW3ZFKpwHqblYpl+k1n5sbGnVFaqGqDXBe/70SYjVEHoZgWUW10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792080145; c=relaxed/simple;
	bh=fMXcgK8JgITzQdTI1+5GNOAlbRY9MS7GPorFVpq2TIM=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=cf/Wda4MMhPWdtYGyK+I25JcBcx0Ga9iRRnRs7Bz3Extcw0INwDR4lBkazSjzqBTXGZ7kmpWU0fvJYx27wfUU8dgaB6HGqstNpZ5yiZwy8VKcHeAkNmNp4lLOXZ1SU5lWjgVZiheylt4fmQRifVCvIPQFDEelz+t7AVl7lWuWzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G/bi2PYK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G/bi2PYK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 379C01F000C5;
	Thu, 15 Oct 2026 16:02:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792080130;
	bh=fMXcgK8JgITzQdTI1+5GNOAlbRY9MS7GPorFVpq2TIM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=G/bi2PYKudtH+ML7jZz3x42huBCSKHsYSXabSyfn3PB7B/6+DjSLTkWoOFxuQi8h4
	 sj7sKG3NHKSR8wRpyfe3e03Ht3U1BUhXGsCeDUK7vu0/tZ1OAJDTYxUJSNdkhcWdcK
	 z2uBpjrYoGWAwy4rMbavTJYavxb8izbu4GVfE3sr3NVDZLlhxsb/Wa4wkbUmAWNajQ
	 a51HYEGp9y2hjh6jiDPRYsEENXHnZawFzFCssh1sLDlhjCoYzFXiMxDuWxtNe16tDb
	 KTtg/CFU/epezFdDVkPCO4In/8WA11GH+qOA1WLlmbktgcyzxD6fIKlvxpsnpDvxY9
	 F4uNOX18/gW1Q==
Message-ID: <sashiko-outbox-173123@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v2 1/2] vsock: support SO_INQ on stream sockets
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Carlier" <devnexen@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261015154334.3217358-2-devnexen@gmail.com>
References: <20261015154334.3217358-1-devnexen@gmail.com>
 <20261015154334.3217358-2-devnexen@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 16:02:09 +0000
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
> reads again and sees EOF, and accepted sockets inherit the setting from
> the listener. No cmsg is sent when the transport cannot report the queue
> length.
>=20
> SOCK_SEQPACKET is refused, as on AF_UNIX: its transport callback counts
> messages, not bytes.
>=20
> Signed-off-by: David Carlier <devnexen@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261015154334.3217=
358-1-devnexen@gmail.com?part=3D1

