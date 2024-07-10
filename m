Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F4B19580F
	for <virtualization@lists.linux.dev>; Wed, 10 Jul 2024 17:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720632522; cv=none; b=ICRLZUrdOYtqtTz78HT+NfdwkmaPG0wmGaqCAiiahbnwlYpy1urARWKtgRXTe+2t2MbD1sQexhCVknoGMtPKqABYBgRXY+o5Rdp536GzZoc+x0D5/UyT4nOL8aS5HMR1nz5mSZtB47JOzTwSR+mXcl8LI89NGRDqYKS/NeMjOWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720632522; c=relaxed/simple;
	bh=RwBkRnspfY067bb6ognTwxNjNjflmlXmo/mSTueNUYA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BeYCdd8EP262fzWRM+CoM/vNMazgW4Carg85+um7h/yT7UmWIK9PBvIVaYj2QT9vR+i534rgfwCaFZEuCiwXkZk4J8KvLffqEatiTrtae7U7wZiSL+eAFYQt41p6dD6aHwTE2+lYCd6Ufnj/V9wGksUu3fvXHzIJcoyOPHtKzPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SrcHDuLR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SrcHDuLR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720632519;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wreloBAAo/tU+/q8kHI1jlzRZShfnjQFT0OfmHDhVRY=;
	b=SrcHDuLRawBEufA2pnBKDXvU2Odor8zqX79vR31SKaEmrr7e4NNktCIHR8vYwkf3zQUVwE
	E7wYwV5FxP+VafGygYGxDuEZuq4NlNm7F0bfpSnkqs+adg1p5UQ+ApAJzxQ4yAPLB9o4QL
	tBwcTRuelSZlSVP39ADH18oyJnOaftI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-118-dAGoerbrN0WOYbV4KrMO1A-1; Wed,
 10 Jul 2024 13:28:33 -0400
X-MC-Unique: dAGoerbrN0WOYbV4KrMO1A-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C5C2B1944D30;
	Wed, 10 Jul 2024 17:28:31 +0000 (UTC)
Received: from localhost (unknown [10.39.192.5])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id AA8C319560AA;
	Wed, 10 Jul 2024 17:28:30 +0000 (UTC)
Date: Wed, 10 Jul 2024 19:28:28 +0200
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Hanna Czenczek <hreitz@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-doc@vger.kernel.org, virtualization@lists.linux.dev,
	Miklos Szeredi <mszeredi@redhat.com>,
	German Maglione <gmaglione@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>, Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH 0/2] virtio-fs: Add 'file' mount option
Message-ID: <20240710172828.GB542210@dynamic-pd01.res.v6.highway.a1.net>
References: <20240709111918.31233-1-hreitz@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ljOl8xcTJy+dyx2L"
Content-Disposition: inline
In-Reply-To: <20240709111918.31233-1-hreitz@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40


--ljOl8xcTJy+dyx2L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 09, 2024 at 01:19:16PM +0200, Hanna Czenczek wrote:
> Hi,
>=20
> We want to be able to mount filesystems that just consist of one regular
> file via virtio-fs, i.e. no root directory, just a file as the root
> node.
>=20
> While that is possible via FUSE itself (through the 'rootmode' mount
> option, which is automatically set by the fusermount help program to
> match the mount point's inode mode), there is no virtio-fs option yet
> that would allow changing the rootmode from S_IFDIR to S_IFREG.
>=20
> To do that, this series introduces a new 'file' mount option that does
> precisely that.  Alternatively, we could provide the same 'rootmode'
> option that FUSE has, but as laid out in patch 1's commit description,
> that option is a bit cumbersome for virtio-fs (in a way that it is not
> for FUSE), and its usefulness as a more general option is limited.
>=20
>=20
> Hanna Czenczek (2):
>   virtio-fs: Add 'file' mount option
>   virtio-fs: Document 'file' mount option
>=20
>  fs/fuse/virtio_fs.c                    | 9 ++++++++-
>  Documentation/filesystems/virtiofs.rst | 5 ++++-
>  2 files changed, 12 insertions(+), 2 deletions(-)
>=20
> --=20
> 2.45.1
>=20

Looks good to me. Maybe add the 'file' option to FUSE as well to keep
them in sync (eventually rootmode could be exposed to virtiofs too, if
necessary)?

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--ljOl8xcTJy+dyx2L
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmaOxLwACgkQnKSrs4Gr
c8iirgf+OVAaFjj58l9FRT8id/lUnMYW7PCddnI/WfoYIHzPrjjFu6gLJ6YdJfhF
k7CaZKtDu/cN51Gu6prqyUs07/87lNpwcPxtD5xejWye4LqBk729w6AIrz7TgKfO
0sGr9o/Q9PCFLw66q2E0r7uOWADgg319kek4mEIxzy/bjlg51rxyO2f1PKb/vU4c
F24bqKhKkct3CUN0q12wCnTC0KIwLe6xozvsAm2gEJMRWoGROD3fuht1RZVpsFSY
UY489HiwxcGY0RPJfre0yAMvMhCGnoYyjWSjDeCuIv0fyYGX6KWglzpqukPVd05L
ZxbxnKhoLmjURpujEXj0e+flsWmIug==
=YMpw
-----END PGP SIGNATURE-----

--ljOl8xcTJy+dyx2L--

