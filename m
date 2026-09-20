Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BB56367B97
	for <virtualization@lists.linux.dev>; Sun, 20 Sep 2026 19:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789932668; cv=none; b=FAwFKvAK3j2MK/by1WHrEnkpDSlAmm0AfF6R/ikzdGcHl1ciQMtJyR4+jdj9SQY9IaobOxDdepk3WKv8QiSpVSPUhukWp7ePO52/yaULFdI/y5hsiVXkiTxTESoydwDxq9ShqTbo9zIhuzD4URIEwfumu4XKJ1Mp5pWM6psTfXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789932668; c=relaxed/simple;
	bh=XCNtvDG5JB87xvFn9dFADwIRyOll6bbGaUwiajtCl74=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=l1LgiSUNPsBwKRGatZxPXlQeuya4wQVLL0t1rYJm2mRyH+MvU3dXDKbDifSvZGBIV9jHHgNTCBANt+1jhk7t+8EkXaTe2FnjrEebHbBXwB8EzKFf/LPRQCDeX+CpRDB9Vyz9tFVXzp+IKkz05OPuxvh6LRfau31Of9fA23JLrCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=On/s1MOg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="On/s1MOg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A66201F00893;
	Sun, 20 Sep 2026 19:31:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789932667;
	bh=XCNtvDG5JB87xvFn9dFADwIRyOll6bbGaUwiajtCl74=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=On/s1MOgtIL/ur5NM6UUWiY4+VwJQPBloN/s9hIABNii9DaogjpMn2oB26LIkA5FR
	 K9kRsy12nvnTQGdSrpe32mgxoQj7JXvI4dPv10IxMW2u8ExYfzFPYKdrefvviKdJEx
	 ze6GE+otKzlMLqe2fjY5kEsooWpkoEC/TA/zDqPIX93rFrN7hwuMLw+1jfE7RYh3uL
	 53JIjW5SwmHOfoJPr1y8e4efMLV8zaOT7+VJhO0jclY1XCA95d2VGp9xPjJP5d2vGw
	 oW8gbUdEBfCBknQt9MMdbn8UBJv0mZyT7EYtkXPRHMD0432H1oZd64D/nLYHrq7FEj
	 Ntr2e00bjSC6Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] drm/virtio: Propagate drm_encoder_init() errors
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sebastian von Arx" <linux@sebastianvonarx.ch>
Cc: "Eugenio Perez" <eperezma@redhat.com>, virtualization@lists.linux.dev, dri-devel@lists.freedesktop.org, "Michael
 S. Tsirkin" <mst@redhat.com>
In-Reply-To: <20260920184244.464343-3-linux@sebastianvonarx.ch>
References: <20260920184244.464343-1-linux@sebastianvonarx.ch>
 <20260920184244.464343-3-linux@sebastianvonarx.ch>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 20 Sep 2026 19:31:06 +0000
Message-Id: <20260920193106.A66201F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

> vgdev_output_init() ignores errors from drm_encoder_init(), so output
> setup continues even when encoder initialization fails, for example
> because of an allocation failure.
>=20
> Check the return value and propagate the error to the caller.
>=20
> Assisted-by: LLM
> Signed-off-by: Sebastian von Arx <linux@sebastianvonarx.ch>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260920184244.4643=
43-2-linux@sebastianvonarx.ch?part=3D2

