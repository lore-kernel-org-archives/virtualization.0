Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793252901;
	b=xe5S2waZ6pBZ9HC6KD91xWaQpHuetX0YxN5jkSMOQa2D9FUkUauATbfnoRTgXrAnBWIF
	 wh9SoeKdVPdHxKcG4HxFR994hff9do6bSONnZUnlHp57y+JGhXLC7AYuX4P6PZgTFsIrX
	 ttcWFIIKIEeC3qabfC3gxuv2MzCW/CQBWe5gE7lgQFc/5DW9kbyuekR6o6nWjFFGP1U43
	 HudE7KVZ14kSKOKeEIXQtbeZVN1m7NP+G7NBEEDl5Nh6J2IRZaApKjgVpVLQfewVTAufw
	 1lnhV2lFfXY1sHoh41sY/ZlHwuuTr9ax9sbYMI4nTxrD3G9IZxApRmI9Ba2Jk0Ixnww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793252901;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=uCpW0i/qsDVniOpj/RjMOtOnsqzmvRMkluxtDqZ7XDE=;
	b=0CJasdfaZtaWxhK7fvpi53skgE5p49t6n7Vj/d+WwBb3YvI9OXr1F9RIrwDra5+KhWA9
	 KX4ZbM2e2xNOmgwo0DZ15iX8sAnhW1Z+8FFd04L6kLjS1Y6lnNvhDTcyxPfP2gwILzlOF
	 ePopOvaHHWaMwbppFo2PSheBWgAz/N9IzbFocbS3iWGjd8TN3xWoToYOdEAX86OsJBdoZ
	 PTvv2veMs4IgVA43C7v47TeUi+78sOpFX0e6iBHRKvLaj0Q7fCcgh7SBxUuHsoDXbL7OR
	 7PVlG0RZRF8b+yPZwOY2ektRG60Lznumjqpwb8gutPuVDdQp/GX3xIF2wPyG3pvUGsg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XOFwGeTi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C873B606A31A
	for <virtualization@lists.linux.dev>; Thu, 29 Oct 2026 05:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XOFwGeTi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D12D1F01825;
	Thu, 29 Oct 2026 05:48:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793252900;
	bh=uCpW0i/qsDVniOpj/RjMOtOnsqzmvRMkluxtDqZ7XDE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XOFwGeTis+oW4DKgWsVsSvvQuIkWYwJTYXP4ErSMQShlp650n+tJX6Y3fF79Mz4hr
	 aJvBJfuaeixqWCZRxlVWywLEpmapZB6JYMqjlu76x1lnrPlbkMud5nhffcS8hw+gEv
	 r/mtjk2XZQwcgulZFZ9WphkzMAapOGc3dCPb0DTr3Z62/MryO5Hz7BJbzAwYHdpszi
	 IZ0SMamITvuLKk4aPI2wIv0pIYRZHTm+kZmcqA0pRp+KRPBPK/68cimVC3Y3x58X56
	 gfPxpdYBMFwdbm8nHt+RfYfwfccdzKosZcdbUZpy49DdqIBL5nPPzYwpVb6VkI8CnM
	 zs9fz5KOa/c5A==
Message-ID: <sashiko-outbox-188773@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 07/14] ALSA: pcm: mark stop-threshold accesses for
 capture policy sampling
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261029054354.2931-8-mynameisjune111@gmail.com>
References: <20261029054354.2931-1-mynameisjune111@gmail.com>
 <20261029054354.2931-8-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 05:48:19 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> The staged virtio-snd capture path needs to sample stop_threshold from
> completion context to distinguish free-running capture from bounded
> capture. Software parameters can update this field while capture runs.
>=20
> Mark the runtime stop-threshold assignments with WRITE_ONCE and the proc
> status read with READ_ONCE. This pairs the assignments with the driver's
> READ_ONCE policy sampling in the following patch.
>=20
> These annotations do not provide a transaction for the entire sw_params
> update. The driver serializes its cached policy and accounting with its
> own substream lock.
>=20
> Assisted-by: LLM
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029054354.2931=
-1-mynameisjune111@gmail.com?part=3D7

