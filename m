Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792655438;
	b=fFBDciMfRl5X16SIAeWH4znN/L8oKil2yGUf9ZV8xStMmwVXCW44p/60X1NfrMu2Wlkj
	 9aDEBBlPpUSkJP5clm+RWa7s2HG6GBBBsHg2M/dhSorYQcWjCpqiYg01oRsGnCUphnR1b
	 bPyg5Wnjsi9viXylaEq5AdSMIS1ahEFpN4EksgcAPthyDBRWzkij0XspDLUww7u7EhAlY
	 wfA6K2vk/nHSbJP9Dwdrz/dZbqAUcEpEX10Ubf2jIlNPDURXwCA3CjimUR4Tslhy1Tlib
	 8htzPIJMXZ8VZtecSR6OBxkV2g5xAwdlLJvX3VxNvgOeY1nsBgL+IYgJwCDhvZ7zmow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792655438;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=FQT3kjBXl71jSmz+aD/zjT4hFLlwOHAFRzl/o3Aeo6g=;
	b=I9ufrBE6m2AGBHa+A4QK+NH6T7OlxpmJBUh9bB3Y2U83xVFZyGQw1JstDMzNE/3j5hCG
	 bNdomddIG+0cKDKvzTOLEiv60zOpl7p1D7k5rIUT5ujw/4S2uO2db6j2Cizh23taXwbdG
	 bPydODoutAk7EoRJUfnNCZ0dSj3IUXDKdjDZJXF27WwriScKuk+2AtIXexUi+AYF8Q4eZ
	 d4jmOImaJkW7Ea6VR1lVcaB+9eCeswqg++vKXTUKkikc544ai4FE7Tdu7vwW2X8bHdDjl
	 ZapNqNYmeJfli3+6ujHRRdbZVwGIsdDcNsJvUFgR7Vb753oqGd0MKdEcavAiILT9A+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="obbd/g7g";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20C6F606A321
	for <virtualization@lists.linux.dev>; Thu, 22 Oct 2026 07:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=obbd/g7g
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B13DE1F000C1;
	Thu, 22 Oct 2026 07:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792655438;
	bh=FQT3kjBXl71jSmz+aD/zjT4hFLlwOHAFRzl/o3Aeo6g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=obbd/g7g8znx7adVhS4JlyxmNHsmbVK4P6QLJ+/YtXe9D7xof7NswD8bYb1V9q7DB
	 gO/+wCVnlzs+/A14AlN35BOaN8na6N9uH0zdleVwYoUIll0/SjHfRO1m7Spwuxf/Kj
	 9LtlBktUAB+usAMMIpjPkJZu0G+B+nuhK4G1rLRdEGgqbAK8R+LXtY1+2PB4wge8na
	 J2uG26/Cnane8i2Wky9s0UTFlISypsM+7PPZopnIBYAL0ljoihiaGhV63iGGvt3MnI
	 LgBJOe11ZMt11Ws1NO9ZtTtIJgqw3rex98MtpUQfe53DvHHQiSYCZ3pCIqUQDBPKXG
	 K/Yp27jnm2DcQ==
Message-ID: <sashiko-outbox-181138@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v4 2/7] um: vector: trim skbs before verifying the
 header
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtualization@lists.linux.dev, "Eugenio Perez" <eperezma@redhat.com>
In-Reply-To: <26741a9a64c28e8de6d13e04972d296d89e1c95d.1792565282.git.mst@redhat.com>
References: <be251d104f881a309cfef150455efa128ebb101d.1792565282.git.mst@redhat.com>
 <26741a9a64c28e8de6d13e04972d296d89e1c95d.1792565282.git.mst@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 07:50:37 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> The vector receive path over-allocates the skb and only trims it
> to the received length after the transport header is verified.
>=20
> A follow up patch will complete the packet checksum in software within
> virtio_net_hdr_to_skb so we need the packet trimmed (otherwise the
> checksum would be computed incorrectly over the unreceived tail of the
> buffer).
>=20
> Trim first, so the import sees the packet as it was received.
>=20
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.v4.git.mst@re=
dhat.com?part=3D2

