Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CBD0C8C7
	for <virtualization@lists.linux.dev>; Thu,  5 Sep 2024 14:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725545878; cv=none; b=JV4NOTTfkLP1M51Nah1xbtJKbdFt2OyIDpjCov7DXBuwyFbkvhpd8vLkpUcOukNhnDCfIU+ZRTKsrxgotvP82tTZyLH6HWVd9P7TZEEHJChtU7SYv7zzDdBUsj50z3fq2LCQFXtYvV9FlC4SIvA2n76MQAD1rKZh68yqAvp9KzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725545878; c=relaxed/simple;
	bh=K+l9mMxcfSbXEO7japsfxlObUe3Pdx0hdSfrik3j3ag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ejkUZchqV10K0ajc6vdUkGBxioPN0WlJDte21JNRfq368OXYrrfUn8prxickUpzPsCfwCxCwfAi+KsUkTu/tSnYMXBMom5CXQDXzZzgLich2rE8U9gLaTlAR3noZABuBokYcBvzge/ZzG0VkqeWrUN2jTz4KlFMQgOaWYzE6/9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G8XEziJ6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G8XEziJ6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725545874;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aI4n4X4EeQia228ZkrTYWhYjJj0SeU3OGZPxnQ2jneY=;
	b=G8XEziJ6hSS9Nd4vC7qEI3Er7SFiiER/t1ypTYfGCcMx6QQFyvjxdY6X3MRVyrpLIbz/ju
	eVYlcOYmDVkZiFVn/ikjHZ1G02bl99fBmuSLHGv0dQQmZGHj+NfIqJSN563jInu/nRrNaL
	310KCxTZOflO24UrgXF8fg4aTaEQRps=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-258-ae0AT1hMM2OsKvJhcI_BTg-1; Thu,
 05 Sep 2024 10:17:50 -0400
X-MC-Unique: ae0AT1hMM2OsKvJhcI_BTg-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 72CDF195E93C;
	Thu,  5 Sep 2024 14:17:46 +0000 (UTC)
Received: from localhost (unknown [10.2.16.181])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B292D195608A;
	Thu,  5 Sep 2024 14:17:45 +0000 (UTC)
Date: Thu, 5 Sep 2024 10:17:44 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Cc: virtualization@lists.linux.dev, mst@redhat.com,
	Miklos Szeredi <mszeredi@redhat.com>,
	Vivek Goyal <vgoyal@redhat.com>, kvm@vger.kernel.org,
	Jingbo Xu <jefflexu@linux.alibaba.com>, pgootzen@nvidia.com,
	smalin@nvidia.com, larora@nvidia.com, ialroy@nvidia.com,
	oren@nvidia.com, izach@nvidia.com
Subject: Re: [PATCH v1 1/2] virtio_fs: introduce virtio_fs_put_locked helper
Message-ID: <20240905141744.GB1922502@fedora>
References: <20240825130716.9506-1-mgurtovoy@nvidia.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="PmPZWAVlJaaoA0L+"
Content-Disposition: inline
In-Reply-To: <20240825130716.9506-1-mgurtovoy@nvidia.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15


--PmPZWAVlJaaoA0L+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 25, 2024 at 04:07:15PM +0300, Max Gurtovoy wrote:
> Introduce a new helper function virtio_fs_put_locked to encapsulate the
> common pattern of releasing a virtio_fs reference while holding a lock.
> The existing virtio_fs_put helper will be used to release a virtio_fs
> reference while not holding a lock.
>=20
> Also add an assertion in case the lock is not taken when it should.
>=20
> Reviewed-by: Idan Zach <izach@nvidia.com>
> Reviewed-by: Shai Malin <smalin@nvidia.com>
> Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> ---
>  fs/fuse/virtio_fs.c | 17 +++++++++++------
>  1 file changed, 11 insertions(+), 6 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--PmPZWAVlJaaoA0L+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmbZvYgACgkQnKSrs4Gr
c8gFJQf/dfAOvhA3E79RBsBGd6CmuOQagcK6ixD60cMHKFI/C2WM8VhBWyW9fVIm
FhQcYJRgxOPy9IkDGED3jbi+i9UFbKulo81tT/7kwEgHbTXxB9xMUJF/kKk24ls4
QbG+jkoeYnV98Dr/sJsHDXTntRVmYmSYdB/VRV5zmD9cmxBis3ixNIfjFA7Si9pi
Lmy8YdUuwSPK9BKRpzOGqJkQB/BEmMtcsiV/SxWpzppZIt97Cxcqn182ecETJMk1
KbmEwKGeyYHOqaU3bQQk337vwK/fzc+xi78T0ZzEaeEWwsXm+uvvtVb9ZpyWm4Y8
Qql3XQNfedb9NEh5boqMn8CuXy+nFw==
=UAVw
-----END PGP SIGNATURE-----

--PmPZWAVlJaaoA0L+--

