Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39E34356748
	for <virtualization@lists.linux.dev>; Sun, 20 Sep 2026 07:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789887778; cv=none; b=nT3mlIICi77OxjyzmkhhMb+InNuWtArSPMNHYAKyt4U1KxevbLd7WVtWyTc7lYTISZJJBrOzeJrYX7odMV2NWibOEonwpu7qfeEzTk0+gJQuNqLnCml3OcpxhtPTX8HJAoeubgYjWDVSlEnLDMx2qZUJEVV4JTQhSL3twzOVEw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789887778; c=relaxed/simple;
	bh=Eqtv1XL76lNJHe/Qfl3ZKNYkGuWysEIuFqFhfgMzNSw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hNXLWvjsgq/zPjnO4cvnhmo61kh2fDQedRCXjtBK9jMh96GKmfpYCQ7Z2KcTKqVsJ8x3Ik+onr8R1NPNtlmd0juL8pvIsaHaI19J4k1IkRqDgRKb1OKEfr5JvGGJ4etk3atdoaDYY0j3fjVLcLXkvl0TcpwQAibxMyZzmRiHKMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FM2pPRx7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FM2pPRx7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 894BA1F000FF;
	Sun, 20 Sep 2026 07:02:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789887776;
	bh=E7g6WqquEeauoLDjnHzog1yMqWznMOpZlFJbw1grbFI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FM2pPRx7G9CRmLLaZf95CzScC/7Ayu868hxipXU5MYNIk7yFgA3wWuQ1P72adsuPC
	 ugDAbU2z+8CMgs6i9HBYBug1HZMn/TT9PIb63HLoE911hB/PmubaCEAExjBzdQMHm+
	 lRpvD1liX2lBF1ffem4b1xHgsxhqRqd3mV9N5fcZ12jBIsKGFGiguiFU2zf6MI5oDc
	 M4M7g8zXs1GLbRfsa49blbK8XdkS+W8tW45BgpxtYVzcmN6/vu/wQoTYcSCKQo/DOz
	 MZMryq0NH8jEsEcck6A9LrzTjqh2xlr9E6rlsxDbqYdL1SIg3AF7/yXM/I+GX70IxX
	 msnNKJDVDDxKA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] virtio_pci_modern: skip unused trailing driver feature
 words
Reply-To: sashiko-reviews@lists.linux.dev
To: "Peng Hao" <flyingpenghao@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux.dev, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20260920065746.86415-1-flyingpeng@tencent.com>
References: <20260920065746.86415-1-flyingpeng@tencent.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 20 Sep 2026 07:02:56 +0000
Message-Id: <20260920070256.894BA1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

> Since commit 69b9461512246 ("virtio_pci_modern: allow configuring
> extended features"), vp_modern_set_extended_features() writes all 128
> feature bits on every device.  Each 32-bit word requires one write to
> guest_feature_select and another to guest_feature, even when the upper
> 64 feature bits are all zero.
>=20
> Feature negotiation starts after a device reset, which clears the
> device-side driver features.  There is therefore no need to write
> trailing zero 64-bit words on the first feature finalization.
>=20
> finalize_features() can, however, be called again without an intervening
> reset when a driver's validate callback changes the negotiated features.
> Remember how many words were written since the last reset and include
> that range in the next write, so that a repeated finalization can clear
> features which were previously enabled.
>=20
> This avoids four MMIO writes for devices which negotiate no feature
> above bit 63, while preserving the full-overwrite behavior when the
> negotiated feature range shrinks.
>=20
> Signed-off-by: Peng Hao <flyingpeng@tencent.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260920065746.8641=
5-1-flyingpeng@tencent.com?part=3D1

