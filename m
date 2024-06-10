Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99BF68F6D
	for <virtualization@lists.linux.dev>; Mon, 10 Jun 2024 17:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718041158; cv=none; b=FyBIrmkgc9MHpbSUJAoXhNNr0irSDD5pl4fGYdwjNYlHIAl4IwJe92kJMGSeGffb5+xb2C0GJV162oBV4Nc+2OGTyncX36/FF4lPd3f6QaEV5yZPmdXLSnbPN/uKTMwcu0kiUSF8bQGEzVl9F8cYQd4Z9y0JJ0oKXbwvGqAVeXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718041158; c=relaxed/simple;
	bh=gYn5ThmtsS7mr67KhDPaq+PQqVO6F8ApXUk64E+UyM8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fI5lXTjmSAd4nfoktAoMEeD8kWxbpRfcMls2gYj5oKoU75fbkq5S3o7tqAunzbeQe/8hUR6i4TV/NAa0Xe1jSDmP3qVvYM1umomJ944WONH3tScULuiSf6XCJmuLW9JoRAfRUemvA4F60WSv2oRyWIIHthgp42ZeMqiLnOmvSEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hjEIj9VD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hjEIj9VD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718041155;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4erCarrIyR2PznMxWy2osancnsDLG/qu3A8gBhzKfNU=;
	b=hjEIj9VDV+yg4i8IY6mJM1auUTIILNreaByCwXJTlBnzZX3xUUr5rJRvdLYFPYLRF2bi/g
	u37rcZmdCOWYFdvEet9yN50ULEIT9Hso3tbevMIubirI4xx23yZbRDsfkaHSiqeAbuc00Y
	SVvfE4+KTDOOm3OFP7paJXVKxamwpMo=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-246-Fzqn9hYbMw-AzZj7jk8WEA-1; Mon,
 10 Jun 2024 13:39:10 -0400
X-MC-Unique: Fzqn9hYbMw-AzZj7jk8WEA-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AFA4E19560B2;
	Mon, 10 Jun 2024 17:39:08 +0000 (UTC)
Received: from localhost (unknown [10.39.195.112])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 01B0019560AB;
	Mon, 10 Jun 2024 17:39:06 +0000 (UTC)
Date: Mon, 10 Jun 2024 13:39:04 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Peter-Jan Gootzen <pgootzen@nvidia.com>
Cc: virtualization@lists.linux.dev, vgoyal@redhat.com, miklos@szeredi.hu,
	mst@redhat.com, dgilbert@redhat.com, yorayz@nvidia.com,
	mgurtovoy@nvidia.com
Subject: Re: [PATCH 0/2] virtio-fs: change handling of failure at request
 enqueue
Message-ID: <20240610173904.GA346990@fedora.redhat.com>
References: <20240517190435.152096-1-pgootzen@nvidia.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Kob+GNVT7oJxrsjl"
Content-Disposition: inline
In-Reply-To: <20240517190435.152096-1-pgootzen@nvidia.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12


--Kob+GNVT7oJxrsjl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 17, 2024 at 09:04:33PM +0200, Peter-Jan Gootzen wrote:
> This patch set aims to improve the latencies of virtio-fs requests when
> the system is under high load, namely when the application's IO depth
> is greater than the size of the Virtio queue.
>=20
> We found that the handling of -ENOMEM when enqueueing requests is
> inconsistent with other parts of the kernel (e.g. FUSE) and also
> obstructs optimizing the enqueueing behavior.
>=20
> It is important to first remove the -ENOMEM behavior as the new style of
> retrying virtio-fs requests in patch 2/2 is only correct in case of
> -ENOSPC. With -ENOMEM the failed enqueue might never be retried as there
> might not be another completion to trigger retrying the enqueue.
>=20
> Note that this patch series is a revival of my patch that was last
> discussed in the mailing list on 2023-08-16.
>=20
> Peter-Jan Gootzen (2):
>   virtio-fs: let -ENOMEM bubble up or burst gently
>   virtio-fs: improved request latencies when Virtio queue is full
>=20
>  fs/fuse/virtio_fs.c | 40 ++++++++++++++++++++++------------------
>  1 file changed, 22 insertions(+), 18 deletions(-)
>=20
> --=20
> 2.34.1
>=20

This is a nice improvement, thank you!

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--Kob+GNVT7oJxrsjl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmZnOjgACgkQnKSrs4Gr
c8jNfwgAgl0SZW15ukfeIlL6QUXzJoUgWyd+ShK7gfj76jx0inIwxBTUtFepYUoa
gY2TUnjucKD/2SbQJx2vXreuIjzrY9GMCucKV7Cg6YwS2isI0hHkGrmjnm/t1XLc
1vBsS2YGipw01/SUKyarKECJQiCjP0qi4bkkMN+JhZj3qCSFHNQPLMIy4hU9I+Wq
u0b3rGGApgztUzzr4abUIkaElokfivYEXr7cEskzJTsqX4A2hBersqme3/Uluocp
GekIR1+W/9niToFGSWSaT50SjSyEarRWlCaBm+tDb6PUdmnk1uAesOog+ie9Q5Ad
ue2Ab3KGANNPcG7uS/TxSRiGa9itUw==
=Kn8p
-----END PGP SIGNATURE-----

--Kob+GNVT7oJxrsjl--

