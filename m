Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F42430E82D;
	Wed, 23 Sep 2026 01:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790126322; cv=none; b=EJHEF32/cJpa/tu5FopxRndFNaEQ5hlrOTOqbE2oP6snt7qxqR969ki8W0Sxgr5bDCw3GDrCFQtwncgtu3nBe2COv1oseM/4xsf4v2ibaIqHE7fTQnWcqhAes21dVWSGTUpdvb46QjB/65OhHRqL8u3sbIB1zWBkv0drQvWwLeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790126322; c=relaxed/simple;
	bh=SqzGSL/IQnadFbghym76dJLJaXgsoYrlyc9TAgg5g9Y=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ESsmfxKU5jgw9cdY7HHtn21qyxQ+LyANUpijNJxa3mr/8Dl5Q3UtG7OnSU+hWJxWIkM4tChpCpR+OMARORnfFS3ES8/AKB8yWDdPYbfGZCFw/e1S0bTcHUquGKLkOl8BVSoAoa7FpkEd2GOkUoFwugO801gVQ5h6DbEtg8O9wXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ut+OnYcZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ut+OnYcZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC2691F00893;
	Wed, 23 Sep 2026 01:18:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790126321;
	bh=SqzGSL/IQnadFbghym76dJLJaXgsoYrlyc9TAgg5g9Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ut+OnYcZQ89Y0ct3j+ZuQyxTXN1JQLTTX9/eiR8boqyWft0DkE/mOXPhwdIElfquN
	 VNkSjVASkr74I0TbhFysI29OPklzQI9MEqUPTyvIywb5fWgs726VNWqAUyvDOytI+v
	 JzHoJzQJdK5oUw2c004DCH9nPXL/JYacTjLIn/FGlQYX7rGfiA0x6c8xe9ePmqBvRy
	 s3jP/SXhLWPHl9wx6CMjNcVzJo/sjopDysnXaZ48EPOsF/QhD7ErAxthgEdRo4NeGn
	 0G1fHwbnvOVdhvKOwWtP//jrCo0ylYMQxcepY6GJZYOksbrKP79Mbmgpwt8Dzezs5O
	 LFxAxnDButmWg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v2 2/6] vsock: rename the vsock pernet
 operations
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bobby Eshleman" <bobbyeshleman@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>, kvm@vger.kernel.org
In-Reply-To: <20260921-vsock-guest-ns-v2-2-693bd78fde9e@meta.com>
References: <20260921-vsock-guest-ns-v2-0-693bd78fde9e@meta.com>
 <20260921-vsock-guest-ns-v2-2-693bd78fde9e@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 01:18:40 +0000
Message-Id: <20260923011840.EC2691F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

> From: Bobby Eshleman <bobbyeshleman@meta.com>
>=20
> vsock_sysctl_ops and its two callbacks are named for the sysctl tables
> they register, but the init callback already does more than that: it
> also initialises the per-namespace vsock state through vsock_net_init().
>=20
> Rename them to vsock_pernet_ops, vsock_pernet_init and
> vsock_pernet_exit, so that later per-namespace work has somewhere to go
> that does not read as sysctl handling.
>=20
> No functional change.
>=20
> Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921-vsock-gues=
t-ns-v2-0-693bd78fde9e@meta.com?part=3D2

