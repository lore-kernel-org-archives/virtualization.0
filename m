Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 392542209B
	for <virtualization@lists.linux.dev>; Mon,  3 Jun 2024 13:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717422276; cv=none; b=MDekZ75rbsodLJvZfUYPC5PHIRhfiK+4tFZxl9pRsRj5wGOTxcUOMb6DEdlgCIZIGBfozrvfXzOPyuuG4SMGpoBGnsWT2QMyDV2l2SnY1ZK1fFScZLHy5s+5z6ZOzDi3Bz6GKZMW30ajLm/E9uL81iGQM6+hWDLIwNMl1ta/5B4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717422276; c=relaxed/simple;
	bh=OGYYT4aVNYM2tWfVMoDcUtFwbRfNH7eAQrhxgzdp1qM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EheVllAT4U7cWrnenINurKKt/W5nyRnkaHHqVW1A2rZX/LrhftxwmVtdRvPSKTNehJPE5NtCOpelgkQrKn41a/TRJ/hWBznMR9K87FJXNS6UCmVIjPXo0+rAA+pthqovcpqqPU7Y7TvurJtcw8L/+A5oOuyfCNuVww2c0UZJcks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RZ0CM/ld; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RZ0CM/ld"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717422274;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8jdv+ECwxRJxFhTMGmQ1KqQnmmX5QOjTHqbjqi1D+WM=;
	b=RZ0CM/ldh24r7V4v4duambio6GUuCdV+qV2Suet0ebP44S3JKl43lQkhVjqwOS95Hyi+VH
	Si97qB+Qiv8II8BpvYKSKZp74WR/4NWZY/cqstmdrAPStHFRAS6NISlnmziG10VwgswOMt
	VztgFqNCV7ArLLvqZ2wNV/pgZ1iCqWA=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-21-4Ch3gP0XM12UZRKLutKkfA-1; Mon,
 03 Jun 2024 09:44:31 -0400
X-MC-Unique: 4Ch3gP0XM12UZRKLutKkfA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AD7343C025AD;
	Mon,  3 Jun 2024 13:44:30 +0000 (UTC)
Received: from localhost (unknown [10.39.193.136])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 5CB9FC15C04;
	Mon,  3 Jun 2024 13:44:28 +0000 (UTC)
Date: Mon, 3 Jun 2024 09:44:27 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Peter-Jan Gootzen <pgootzen@nvidia.com>, Idan Zach <izach@nvidia.com>,
	Yoray Zack <yorayz@nvidia.com>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
	Parav Pandit <parav@nvidia.com>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"bin.yang@jaguarmicro.com" <bin.yang@jaguarmicro.com>,
	Max Gurtovoy <mgurtovoy@nvidia.com>,
	"mszeredi@redhat.com" <mszeredi@redhat.com>,
	Eliav Bar-Ilan <eliavb@nvidia.com>,
	"mst@redhat.com" <mst@redhat.com>,
	"lege.wang@jaguarmicro.com" <lege.wang@jaguarmicro.com>,
	Oren Duer <oren@nvidia.com>,
	"angus.chen@jaguarmicro.com" <angus.chen@jaguarmicro.com>
Subject: Re: Addressing architectural differences between FUSE driver and fs
 - Re: virtio-fs tests between host(x86) and dpu(arm64)
Message-ID: <20240603134427.GA1680150@fedora.redhat.com>
References: <SI2PR06MB53852C83901A0DDE55624063FFF32@SI2PR06MB5385.apcprd06.prod.outlook.com>
 <b55cb50b3ecf8d6132f8633ce346b6adc159b38c.camel@nvidia.com>
 <CAJfpegsppbYbbLaECO+K2xpg8v0XZaQKFRZRTj=gJc9p7swdvQ@mail.gmail.com>
 <bbf427150d16122da9dd2a8ebec0ab1c9a758b56.camel@nvidia.com>
 <CAJfpegshNFmJ-LVfRQW0YxNyWGyMMOmzLAoH65DLg4JxwBYyAA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Y8uNWZsMC5ooxXDF"
Content-Disposition: inline
In-Reply-To: <CAJfpegshNFmJ-LVfRQW0YxNyWGyMMOmzLAoH65DLg4JxwBYyAA@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8


--Y8uNWZsMC5ooxXDF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 03, 2024 at 11:06:19AM +0200, Miklos Szeredi wrote:
> On Mon, 3 Jun 2024 at 10:53, Peter-Jan Gootzen <pgootzen@nvidia.com> wrot=
e:
>=20
> > We also considered this idea, it would kind of be like locking FUSE into
> > being x86. However I think this is not backwards compatible. Currently
> > an ARM64 client and ARM64 server work just fine. But making such a
> > change would break if the client has the new driver version and the
> > server is not updated to know that it should interpret x86 specifically.
>=20
> This would need to be negotiated, of course.
>=20
> But it's certainly simpler to just indicate the client arch in the
> INIT request.   Let's go with that for now.

In the long term it would be cleanest to choose a single canonical
format instead of requiring drivers and devices to implement many
arch-specific formats. I liked the single canonical format idea you
suggested.

My only concern is whether there are more commands/fields in FUSE that
operate in an arch-specific way (e.g. ioctl)? If there really are parts
that need to be arch-specific, then it might be necessary to negotiate
an architecture after all.

Stefan

>=20
> Thanks,
> Miklos
>=20

--Y8uNWZsMC5ooxXDF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmZdyLsACgkQnKSrs4Gr
c8g4Tgf8COEJi4kzlMDChTuLm+fsLcHV41ng+vGBfzzxoJKQjIotpIKxRKkPkm11
nEDf2EO1SomgzkQCDuVymDviTC8C+Dzd4xKsBqaVMWjV0RkGMYhZY+oe21ckRz97
yz31bftIz+STEi3FQ3a/U3Swgy04XZ2GwCJkNxUpdVLHb37yZOCA6N9K/PSu9ZVs
SdmesUwl7p2joB/zQJJt+42Q+VE+MEF0TXzrNe1CG+XWCugN29dbW9FghUZ97zJb
0t/x4N4uoFKnTUuPFkLw2RUxfyaeSxbzKdGiX2KF9DL7dTZjgno/NCnjohQfb2LL
akcutpV3LucF5xmkwOH1ACZoNCV6CA==
=cv8W
-----END PGP SIGNATURE-----

--Y8uNWZsMC5ooxXDF--

