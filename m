Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=10.30.226.211
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792421948;
	b=YUkhOiYKmxXShMSlpk7OVG6mN0ttqsucJ5Y1GYCO3qbwSlJsF/MVwkjbnWfCO5yOQJ0u
	 9ZyqcraHqVfBTsUJiPgEnnx2quonrzX7cOwsK7JuJ0NGaI+N1ZSoO96fA2fv0fJKGVgtg
	 10C5SoifcPSfle7mvQfmQuxjGRl/8mCj0TnBfw3P3Ytq5jz3A99bH5eLqt9dHgwl81xgH
	 riYHRf82RuP2pEQWjApPPJ/pCIYZLvzNpDYyd5yNwBkaX/AjpsHVtzDQPtdpgyLmh8PdW
	 ON6ewtjsUPnBr8muWuAMse9IEU0mc6fQqs5/3VDmZW4bwnL/xKXxbQNN30AsChFGMYA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792421948;
	h=Received:Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 Cc:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:
	 Date;
	bh=dYa9uSRbi3k7XD502hvfk0j8TuW1P5Snnz06aOtqYiY=;
	b=YJox+Bgoalfs5Izb29qAVzmurmo4qrw9yZLX1hzGfr+hl+O5PW5t8AygDY2LFzxS+0QD
	 DhfHxHgnEVlKvSRWZ53wYzapr/ZBL3xXkDknQ6xTfLK3lPzYplIiI1qL+Y0nZwqRp37eS
	 wrUhGx1QFvi78dv70BcZT3fBcl7weuucKctGS3E1X/E6nR2O5WZk8ydE3EsymmXwraMEB
	 bGaCFGdwFqlguFKnklhWXQHLKIDMoikaUk/bs9WqFvcxV2Y5zCFRTBTLWNCsY80GfEe7s
	 OAzeYp6Oms33y0Fusiikp1/rkB9GqNhpUqHDMlyFsr4LUiCGbpUDqAqFpDluPgQmrRw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=foYN4CPm;
	arc=pass header.oldest-pass=0 smtp.remote-ip=10.30.226.211
Received: from aws-us-west-2-korg-listserv-1.web.codeaurora.org (ip-10-30-226-211.us-west-2.compute.internal [10.30.226.211])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4603560774E2
	for <virtualization.lists.linux.dev@localhost.mlmmj>; Mon, 19 Oct 2026 14:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=foYN4CPm
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF616513C1
	for <virtualization@lists.linux.dev>; Mon, 19 Oct 2026 14:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792421948; cv=none; b=eUKgOnII6oCCw2UigtZDFlPl4G8mLipcRWdgibhdJeNyJwn/qYMz7fEcoiK0NTifRWewlKdb40dBioBDDzVZb365egoVbRtoq/ew+nYrfe5c2Z3w17DUPkfvEikUgIzgLPDKVdDcuNx4x7xlF4VpGkMRik1i+Z0wEqaxNP/UDfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792421948; c=relaxed/simple;
	bh=dYa9uSRbi3k7XD502hvfk0j8TuW1P5Snnz06aOtqYiY=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=kY7HZYtedhPxwoSJrbTw5IXVLxXWqEXvBMqsm84bbjAQsE0lacuCCJ3JKG/HIgUPJ7wrs4453kJrQKE3aDf513Xfx23JSc0tzw9+7hB5V8uYnVl+tfr7kl60sgT2fg7QnSesZzo/eAnFQWvhYeRUwL7AqavwJSnELsvFjaZNCYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=foYN4CPm; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 784C81F000C4;
	Mon, 19 Oct 2026 14:59:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792421946;
	bh=dYa9uSRbi3k7XD502hvfk0j8TuW1P5Snnz06aOtqYiY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=foYN4CPmuInwwe9NWyiVbbBuXFqgZYx1YD82dzJ1md/RqiMmE3uJznLxUHbcdMOOS
	 mdurstr+65Jra6mzByme2xLYUfeHBhWA56N1cmahjD9Xh4EEYQqOjoCDVhaW79VRuY
	 R2Wbo1SyUVRqIVEf4vL443jXc04Dm+I+oF3KRQXi2Mn60YstUzoD7JvELAjpRXVXi7
	 ftThqv/pYMA66LXlm1zNTKxEXFgYnKVMNR0DQn3zX1zWHfuyJZ+WALllAhgFt8HJPz
	 OUGQ7lI8exP+d21smFw/VouEX+mMIUdrf7Tn2uypLHPW4OIrGV7rf11QdltTl0pvO2
	 LUffMlotzveBw==
Message-ID: <sashiko-outbox-177580@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH AUTOSEL 6.18-5.10] virtio_balloon: warn on failed buffer
 add in tell_host()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sasha Levin" <sashal@kernel.org>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261019135441.1420968-356-sashal@kernel.org>
References: <20261019135441.1420968-1-sashal@kernel.org>
 <20261019135441.1420968-356-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 14:59:05 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> From: "Denis V. Lunev" <den@openvz.org>
>=20
> [ Upstream commit 198eda395067b56ee605de076f0519620f4e5d90 ]
>=20
> tell_host() ignores the return value of virtqueue_add_outbuf() and goes
> on to kick the queue and wait_event() for the host's ack. The comment
> claims "We should always be able to add one buffer to an empty queue",
> but that does not hold once the virtqueue has been broken (e.g. on
> device shutdown): the add then fails with -EIO and the following
> wait_event() would block forever on a buffer the host can never return.
>=20
> Warn and bail out on failure, mirroring virtballoon_free_page_report().
>=20
> Suggested-by: David Hildenbrand <david@kernel.org>
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> Message-ID: <20260624140846.2616797-5-den@openvz.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019135441.1420=
968-356-sashal@kernel.org?part=3D1

