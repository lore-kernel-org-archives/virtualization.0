Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11F764E36C9
	for <virtualization@lists.linux.dev>; Wed, 14 Oct 2026 12:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791980116; cv=none; b=hH7hWEYMsVVJZXWl8Bf+mF5nHyoaGc/Mj8Xr+RUxoFItCMEzqSgVMm+g4+tEQ58Bj9P+sSyw0So+L7zY4Bg9NOTY7f7yGrK7OjV5J8+/hpqTF2ENGlFBKcZ7Q5LbwOIAHggsdek6Zswa138diU4X9n3Y/HhCq4dLQRfyXWn+hsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791980116; c=relaxed/simple;
	bh=MaS+nLOnQZfsl7vhrj84HuEoO2DA+/+BPixJ/YTJB4k=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=hyzScvJlVoHll1fR62P7YvVH3LDkHgYFQXtHW9YcCfMD3HK+wlFosg/AxpGMGoTcKgTfujfOIjeGXZUc279GJ6Y+DjIgVKD7KbL5suIyEQGr4SrfallehqAkS2a2+2Sxf1QdqCFUPVLS+xfapBuDE3WoyZQg6JKyFvTXQY12UJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TOTgG2iV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TOTgG2iV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B51211F00893;
	Wed, 14 Oct 2026 12:15:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791980115;
	bh=MaS+nLOnQZfsl7vhrj84HuEoO2DA+/+BPixJ/YTJB4k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TOTgG2iVDP5Ucu0AmwCCPf3Id3bhipv1PM2Xy8A/0B+b5ovvtG5f3v7PR045v8Bh4
	 uTN1JAalHZOQpHIOviPNnP0dx8vou6eaCELvZkvIoRv0/A6yJbMehXH+8wZ13vPUQc
	 iwoWAvBkd1Yaled6tUrRF7T7uDCr5Uvdr9aK1lHrKinLBrHH9VlEQr5LvrehtCp1db
	 47Lg70i/kFgsmYripHMfdctn8GmeHodETj3vmvDuoLeKkfpZSW3oCRFRNl5dvCs+mK
	 N+OImqFUWPevveYGgbU2cZY4RMkNDtzglBa9hbaj4pND02eyRRDnWky526/BVSyJY5
	 V3R8MzASYXp2w==
Message-ID: <sashiko-outbox-171252@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v4 1/4] vsock/virtio: split socket lookup from
 locked RX processing
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jia Jia" <physicalmtea@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261014115640.184286-2-physicalmtea@gmail.com>
References: <20261014115640.184286-1-physicalmtea@gmail.com>
 <20261014115640.184286-2-physicalmtea@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 14 Oct 2026 12:15:14 +0000
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

> Split virtio_transport_recv_pkt() so socket lookup is separate from
> receive state machine processing under the socket lock. This prepares the
> receive path to keep a looked-up socket across multiple packets in a later
> change.
>=20
> Keep virtio_transport_recv_pkt() on its existing per-packet locking path.
> The locked helper obtains packet-specific addresses from the skb and uses
> the matched socket namespace for reset replies. Preserve source validation
> and failure handling.
>=20
> No functional change intended.
>=20
> Signed-off-by: Jia Jia <physicalmtea@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261014115640.1842=
86-1-physicalmtea@gmail.com?part=3D1

