Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF9FB238C36
	for <virtualization@lists.linux.dev>; Sun,  4 Oct 2026 12:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791115496; cv=none; b=HYo+rbAHrq5Jmr+EmLug2L7TnV7CTzAka+usWMw9CZLblyyv/9Zn3DADQJVGVKkjFQUIkWYqwfluD0Bq/iTxIRldT4CsEHFdbRdw1xsikRVzNFkWjEJhzLdx+Rojg43IBNI68tlJtZKnKkvD9cSfkTBBVms3JzLu/BxX+dZC21c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791115496; c=relaxed/simple;
	bh=e1IMZTIaFYS6L83r7tpJDK2FKaJtk9KG9L+T/rmjK8c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=usqv7VgSz+/PJnszts1HsvPWUWcWxXxjLcA393tP9zsi7u4D7SCEv51QOx2gI/3bCKWOE99iTZ5AuPtP3laJfUd7QL+NBWJMzEt4wcrqlE0HsD9YOgYiDhoLhJBbRdWj35MruB8N3iSJZbrJEAOqt2NzRDTAPANPVK9HjUoJPZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EJP8QInv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EJP8QInv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F2F71F000FF;
	Sun,  4 Oct 2026 12:04:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791115495;
	bh=e1IMZTIaFYS6L83r7tpJDK2FKaJtk9KG9L+T/rmjK8c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EJP8QInvwq4Qqd1u05XaCTAGhOr1vJm3dWMAct/ikbFFLLoZpwWDeybz4QH2irVch
	 BYGa1V4NYTMXpI96Eu3JSYqWqkv/LYFc8clf2Jk97nZyXFnJL0znFLz6XNcnGvurzx
	 vuYZ7STtFtadUTzdFhUlGd7RwED01Aq9zGWiTCuVMSA4rvoMe+pyz9/3ZXrmvLP5b6
	 H1i/9ZBu0+LIuQEbwtO8L+RGlWD22GDXfmgGltO3W5GFWW9NEM9AmvZiJpWBeNnroH
	 NG8voUcgDVRmS4PC+3CTVf0S/OjJML0GbkrVJvElj64RCUxnpC60gjQH5AzZmfHCWS
	 DOd5nBBqwO9dQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5/6] iommu/virtio: read the endpoint count under the
 lock in the iotlb paths
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anlai Lu" <agicy@qq.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <tencent_C7BA3FB54A956BDCEC9B48C7741F06566708@qq.com>
References: <tencent_85AC6E749F6A912B7BB9FF360F8ECB3F5C09@qq.com>
 <tencent_C7BA3FB54A956BDCEC9B48C7741F06566708@qq.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 04 Oct 2026 12:04:54 +0000
Message-Id: <20261004120455.3F2F71F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

> viommu_iotlb_sync_map() and viommu_flush_iotlb_all() read nr_endpoints
> without the lock its writers take: the one place left after the endpoint
> helpers were introduced. Order a sync only when the device holds the
> domain, and read the count under the same lock as the writers.
>=20
> Signed-off-by: Anlai Lu <agicy@qq.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/tencent_85AC6E749F6=
A912B7BB9FF360F8ECB3F5C09@qq.com?part=3D5

