Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E798E16F262
	for <virtualization@lists.linux.dev>; Tue,  7 May 2024 18:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715105262; cv=none; b=PjxK1TjAGl6UJ0O7y7K75CES7aEWkApEl8lGB98w7bOFLmE2z5vNFtQxD0hcX6KbgexiELE9zc1m2lMLG+MscldxmY2724Opcv93lqQ1DTD8MuZ00PQ6zNW9yeWOaPRfmgiv0kR73bou2ZPztkYk2neVh9jfOdlI66is9LT4eWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715105262; c=relaxed/simple;
	bh=8XkkMQaSxAxBxGs3XnxWMFi2CPlh+TIHyxTZwhGgbwI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o20o5VhOURwCE2L9G1PnZr7FzgUfYixlR6DN+zZPqAOR1ujOtEbnKqQOy1blcZC7Kprw2gdIBbcZpFQArTdFnDiUH/R0gGxlu/+KiU6mqK42xlsw1oj9byWxwPWpOmLgGER3+fSzpbEyF38A0IGtunZYv7O/6F95fKBdmmqvayg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FaVRG4+m; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FaVRG4+m"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715105260;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lrBHbu4v12LhfFPSVMEbM2jDeVfuGV9hs0g8Bz91gLw=;
	b=FaVRG4+ml/snrp48WbuUi2l9zFkIqw23o5DBhY5ZGQwoPiBZNJ8In3fs3ZdcA9ZqNlu28x
	XTh1hN+fiJymGhskp+OIRpwcn/3GC+qPno3LBbfvss0y4h2cAYHu5EFDtV6C7+YvqP5B/A
	P9jW7oP5gUJ2qtVmpEOBIad53JYZYPc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-396-7B_Hd5kAPNOtlGQI38jzQA-1; Tue, 07 May 2024 14:07:36 -0400
X-MC-Unique: 7B_Hd5kAPNOtlGQI38jzQA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C16898007BC;
	Tue,  7 May 2024 18:07:35 +0000 (UTC)
Received: from localhost (unknown [10.39.192.114])
	by smtp.corp.redhat.com (Postfix) with ESMTP id B4ED81C066AB;
	Tue,  7 May 2024 18:07:34 +0000 (UTC)
Date: Mon, 6 May 2024 15:10:45 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Peter-Jan Gootzen <pgootzen@nvidia.com>
Cc: virtualization@lists.linux.dev, vgoyal@redhat.com, miklos@szeredi.hu,
	mst@redhat.com, dgilbert@redhat.com, yorayz@nvidia.com,
	gurtovoy@nvidia.com, Yoray Zack <yorayz@nvidia.com>,
	Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: Re: [PATCH 1/2] virtio-fs: limit number of request queues
Message-ID: <20240506191045.GD7375@fedora.redhat.com>
References: <20240501153817.540855-1-pgootzen@nvidia.com>
 <20240501153817.540855-2-pgootzen@nvidia.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="tiETGeEEHKLzEbfB"
Content-Disposition: inline
In-Reply-To: <20240501153817.540855-2-pgootzen@nvidia.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7


--tiETGeEEHKLzEbfB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 01, 2024 at 05:38:16PM +0200, Peter-Jan Gootzen wrote:
> Virtio-fs devices might allocate significant resources to virtio queues
> such as CPU cores that busy poll on the queue. The device indicates how
> many request queues it can support and the driver should initialize the
> number of queues that they want to utilize.
>=20
> In this patch we limit the number of initialized request queues to the
> number of CPUs, to limit the resource consumption on the device-side
> and to prepare for the upcoming multi-queue patch.
>=20
> Signed-off-by: Peter-Jan Gootzen <pgootzen@nvidia.com>
> Signed-off-by: Yoray Zack <yorayz@nvidia.com>
> Suggested-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> ---
>  fs/fuse/virtio_fs.c | 3 +++
>  1 file changed, 3 insertions(+)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--tiETGeEEHKLzEbfB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmY5KzUACgkQnKSrs4Gr
c8inxwgAg0fLHQdiKDGQLI/YY2/9ZVDpkKvSNRKbSKvVaTwvWfMcVtLaNQsL+IN+
32Ow1mVM5KyEQDKNcmp8jnM3HWDGworb2VeB/DY8ddjxA98tlKbRp89QZgcjN9YX
yOi9wwjy+1LGnRK2bq8asGl9mROwiEdaQg0Jj8ZzK05ENGU1bKCnVNm/wyR5mpwT
uth7/f+I5CN4PaTdnrcDvU2qETDmVnTVsSzqTJvpcgTeho4JLsRefSBcm1+hJoul
jZDF7NMbOUHGPDrx4b8J7X0n+whuOV79ygiQ5X1dS5lMgQ+Q8gZiXLc5xUhD3dQA
tYoFokz3w5lnaToZSDzhZiQkqXKBlw==
=426g
-----END PGP SIGNATURE-----

--tiETGeEEHKLzEbfB--

