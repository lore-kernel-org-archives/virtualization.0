Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0797C15B990
	for <virtualization@lists.linux.dev>; Wed, 29 May 2024 18:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717007560; cv=none; b=gNMMPIv3ZNTjY465yflfRt6kln2ZNDVXZjSIfPTH+dYOfaA79dJSNiMpKrFsPHyZq+aLsWBj0Q1P09U/tOVKMhQhi66Fc9gHm1cf1JXatvgYqOnD5WF8FIBvptaff1DTvKwJXXB4aEAgestQ8MgZ1cyqn261drl9ZpIbRr8qlBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717007560; c=relaxed/simple;
	bh=52yBtlsfttwJOD8PKsZF4fgxkYqipcJnrVtlHXgQQYw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NiCa+MnDhprYQNVpxEueIh33N0B2/hG+lUMDEyCb4aMNAzEYiq1/JP9MUStWHDOMiAgRZea+jpyGQQzjgzx4jJjG3G1sy30Wd3071uRZTmT63368lzX7A1xJLeV+t4twek9StJ1ZDqxv2Zi1jgMfDO5pchNbVTntdSuRROWT5YU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ImiwoqP4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ImiwoqP4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717007557;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oVayNWdyUAGQz4y/jxiAjETz9WQzUuYKs0dHZ7/y+zE=;
	b=ImiwoqP47WI6W10UKYOr1N+KMfXeHNc5IotFBQoZG/QjBhORHFZx1IAVf0hNO/F9/FHZQ9
	KrqCjiG7OldwOmqvsy30EXE80EPIUn+3MNHdeKiV2D9AMhQaw94gNekuqLRgNH08XZ/ddd
	lWpooHNG/MFgjJ1F2f+zxjlFoNxtXyg=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-175-V7me-cd4N32vApkD4oDtuw-1; Wed,
 29 May 2024 14:32:34 -0400
X-MC-Unique: V7me-cd4N32vApkD4oDtuw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C77E829AA384;
	Wed, 29 May 2024 18:32:33 +0000 (UTC)
Received: from localhost (unknown [10.39.192.15])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 43BEA36EC;
	Wed, 29 May 2024 18:32:33 +0000 (UTC)
Date: Wed, 29 May 2024 14:32:31 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Miklos Szeredi <mszeredi@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, Peter-Jan Gootzen <pgootzen@nvidia.com>,
	Jingbo Xu <jefflexu@linux.alibaba.com>,
	Yoray Zack <yorayz@nvidia.com>, Vivek Goyal <vgoyal@redhat.com>,
	virtualization@lists.linux.dev
Subject: Re: [PATCH] fuse: cleanup request queuing towards virtiofs
Message-ID: <20240529183231.GC1203999@fedora.redhat.com>
References: <20240529155210.2543295-1-mszeredi@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="6oV0VDCxVhgLbHjS"
Content-Disposition: inline
In-Reply-To: <20240529155210.2543295-1-mszeredi@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1


--6oV0VDCxVhgLbHjS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 29, 2024 at 05:52:07PM +0200, Miklos Szeredi wrote:
> Virtiofs has its own queing mechanism, but still requests are first queued
> on fiq->pending to be immediately dequeued and queued onto the virtio
> queue.
>=20
> The queuing on fiq->pending is unnecessary and might even have some
> performance impact due to being a contention point.
>=20
> Forget requests are handled similarly.
>=20
> Move the queuing of requests and forgets into the fiq->ops->*.
> fuse_iqueue_ops are renamed to reflect the new semantics.
>=20
> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> ---
>  fs/fuse/dev.c       | 159 ++++++++++++++++++++++++--------------------
>  fs/fuse/fuse_i.h    |  19 ++----
>  fs/fuse/virtio_fs.c |  41 ++++--------
>  3 files changed, 106 insertions(+), 113 deletions(-)

This is a little scary but I can't think of a scenario where directly
dispatching requests to virtqueues is a problem.

Is there someone who can run single and multiqueue virtiofs performance
benchmarks?

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--6oV0VDCxVhgLbHjS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmZXdL8ACgkQnKSrs4Gr
c8hpgAf/TbBXZJlqAq5OzMWZIMAbeDhg6QQ7EHTeANq8Vd9mu/AtUuPe52sLxhC7
Jb3pQ1BDzCcAYFhjzpJdpIHgynPqKNiwFc3lTrOE6esYp7IzEVRJzjQRfcm2WbyF
vUEUXCkguB5d6SCQ5X1NSgxCK2JFoYHBZBqLE8uPn7ICrWP0Vh8FODufpnVBYOEZ
WjMvOaKPiddO2PYBnVRQMBKqDpPST9jxqQYV2hhcKwAW1TGLsN2vZXNtLFq9uGpf
UvG+gKHod4zfL4rqOjpSNJKOSi6EIvc2zhcwhOUpnLqkS9UIqSjrqUA1J+UacG7u
Q/5yn5AZhYjoB7/MLOPVgORqD7leKA==
=+/Z1
-----END PGP SIGNATURE-----

--6oV0VDCxVhgLbHjS--

