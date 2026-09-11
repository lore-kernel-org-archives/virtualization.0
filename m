Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 269DD353A70
	for <virtualization@lists.linux.dev>; Fri, 11 Sep 2026 12:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789130666; cv=none; b=l/SanWg8puO3mX74Tynx59zXJcdgSbFkuvmfHYi0Y/qnh3cCja84+iLqBLVn5Htn6fWO+/s33T2oPbsDmu7b3d8E5/SBtNViekg2pngx3ZsxsvsnXngt1i2p45a7AOFw6/Cz/hP3iWP8/abDfot/pVCEYP0u1urVOcDNlNIM0QQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789130666; c=relaxed/simple;
	bh=RYArL/eO33IgiBNWT5JxO6n6yga5wW2S2uLaU9cotM4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XgIGKq/5Q3N/8G0PrHZm6EOC2LxbYLD1AcXjVbGV/qXYLCcL3bAwh5eO0+/41ZGxknKFBw9voYh/itnBpA+1K6IzPHJEhKeyEo+1vrftv7YuHvelPdB8KNyT+WbNHlAALYZPyiJNMgl459MFTXUl6JZW43WZFd0s3Q86lTAX3tQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jqz9vPR0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jqz9vPR0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 815E41F000FF;
	Fri, 11 Sep 2026 12:44:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789130664;
	bh=w5yw8zCn9nIkmYJKXiNFz0ktZMBpcIgGzmNNhwuAt9A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Jqz9vPR0WAqbFSZaFUBcuQ0pplkhG+xhgP4Ez3EdycNQdhYrlzOOx5vFObPKTFHen
	 tnjW31/gttNt46eNtaVcYBIfn40qZRWdEsVM8i8h+CuMjUv3W1LxKkAk9wzqTYFOvB
	 213PX67K25p5Y4jMVljJvnkx4BuxOQJv8gRFjRufJ3VXXx6ly2w5ID1iyizM3HAKyX
	 PS0khwSiyKj4FpNF9yMPLpzkD1wLXmARB6okj8mbyfwsvy7Gt9bQkD0QKN9XR+asBW
	 820N6e1gXvsSLsau5+idciz39N6YgiqeyR2NnGmo5J8XhZ3EKMq9g3b+qBMx0Zd7JM
	 z5su2NCLKm12g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] virtio: synchronize callbacks after device reset
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <8f71425918a148dcad1be993ccabd39582d246ee.1789130213.git.mst@redhat.com>
References: <8f71425918a148dcad1be993ccabd39582d246ee.1789130213.git.mst@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 12:44:24 +0000
Message-Id: <20260911124424.815E41F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

> virtio_reset_device says:
> 	Note: this guarantees that vq callbacks are not in progress
> but in practice, only virtio pci correctly synchronizes the cbs.
>=20
> On other transports, a callback that is already executing, keeps running
> while the driver tears down the state it uses.
>=20
> Add virtio_synchronize_cbs to virtio_reset_device fixing this for all
> transports that correctly implement synchronize_cbs().
>=20
> Reported-by: Karl Mehltretter <kmehltretter@gmail.com>
> Link: https://lore.kernel.org/all/20260818040433.66986-1-kmehltretter@gma=
il.com/
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/8f71425918a148dcad1=
be993ccabd39582d246ee.1789130213.git.mst@redhat.com?part=3D1

