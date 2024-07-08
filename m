Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3B62364A9
	for <virtualization@lists.linux.dev>; Mon,  8 Jul 2024 07:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720424719; cv=none; b=ou3GbF3KQmcriko1XhwpaTjcVFaklXFqws96C0LZcc66HNFSPqkKBB8QQ2ipanMeol5EfhIji2h9LJH4usUZtdXkHd7vWs1AQJaYhSlvNHmckp/WVzCeGz0OxNB0xoGmM8ArVg9AORsoVs/wGHwQQuZkobNA0bE5XDgYMP+dJKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720424719; c=relaxed/simple;
	bh=CIpq+tHXooEAZzxw0fF4yhNIHvERWGGg1G8htwhDg8s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kyk8F63m/+anCvaLqil457zlzjvC6WVpLxmzOUk7MlFt/zi6PS190T3gwijxWYh0WXufI+e9HFuUoncZ/lR79G+divk0zyAP0pwS5zwj0fxSAf5VnQEYJ6U+Diy7ZocVzL7eadAxrlC5qeEc+9Sie/2ZIY+ozdil/zvJiyj4+6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QZScP8oy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QZScP8oy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720424716;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bQ6oO+NBE5KmHBrK1egMaXWpdDDzquNgOi2z2wMWGCY=;
	b=QZScP8oy59Z9Gm6J4er41PHkRGEqRofb6Hu55MbFh+0r3huTtZjfr/fsD43KAITKY2k9E1
	mxqNkNpOnmZgWMBMYJ7bQ65ohg8+KoNwGgTg9F/9Y25035r70GkSxw4PefIBKoUxE9Gon8
	Iesel8zoz+TP2aRznPY9Qb4f/V46aZo=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-343-OMIDTzpzN0qtc5a682khwQ-1; Mon,
 08 Jul 2024 03:45:12 -0400
X-MC-Unique: OMIDTzpzN0qtc5a682khwQ-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A08481954229;
	Mon,  8 Jul 2024 07:45:09 +0000 (UTC)
Received: from localhost (unknown [10.39.192.131])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DB4E119560AA;
	Mon,  8 Jul 2024 07:45:07 +0000 (UTC)
Date: Mon, 8 Jul 2024 09:45:06 +0200
From: Stefan Hajnoczi <stefanha@redhat.com>
To: John Garry <john.g.garry@oracle.com>
Cc: axboe@kernel.dk, mst@redhat.com, jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	pbonzini@redhat.com, hare@suse.de, kbusch@kernel.org, hch@lst.de,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev
Subject: Re: [PATCH 4/5] virtio_blk: Don't bother validating blocksize
Message-ID: <20240708074506.GB38033@dynamic-pd01.res.v6.highway.a1.net>
References: <20240705115127.3417539-1-john.g.garry@oracle.com>
 <20240705115127.3417539-5-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="OkGs/uj0FPvoaRGC"
Content-Disposition: inline
In-Reply-To: <20240705115127.3417539-5-john.g.garry@oracle.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40


--OkGs/uj0FPvoaRGC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 05, 2024 at 11:51:26AM +0000, John Garry wrote:
> The block queue limits validation does this for us now.
>=20
> Signed-off-by: John Garry <john.g.garry@oracle.com>
> ---
>  drivers/block/virtio_blk.c | 11 +----------
>  1 file changed, 1 insertion(+), 10 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--OkGs/uj0FPvoaRGC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmaLmQIACgkQnKSrs4Gr
c8hD7wgAmE3KWfwdfsZ1kkFHXdSkQnTns0LGYPW3TJVUFza6nLhXDjMDTnrcOqHv
M7V7FEEXj23V44hk/RTx5HmhyDTSCfbOEFi2gMaOlVcJZzNDcMrEEgEcMOrEapKd
imlRGIuR6WAC4jMsd8nJ/mjI1l/oNOdh7dibQnvCUQLSjv/Orr+pAAnlDrS6Lnkn
o9aI4PUAK+5yLET/h1gTnA4I78m/Im/tGUnZeLKv4tchMpk9LowGaEe8Bp5p7VqI
meQPYlhxU5jI/1atRzE29/ICNkoMrqetnEy3mwvxUDIg074Hk/JNszHBRESHpfsi
OApRPcfaygQyrjQtlVUye2lMvE8iJg==
=5G7c
-----END PGP SIGNATURE-----

--OkGs/uj0FPvoaRGC--

