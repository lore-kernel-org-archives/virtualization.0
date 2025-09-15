Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF53337688
	for <virtualization@lists.linux.dev>; Mon, 15 Sep 2025 14:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757947584; cv=none; b=rKNRiyp1wyBLjutVx3HCKg4rNLtaC/RzIkut4ej9Z4wactdsHe0wARXamEXvRsAKnG2zUnxlDnxS+IeFxCEthpKg5dQlqlqa6Rbxez314TBs1/5dYGvz6K3scWFUwcaq8PaskFIMAEnTuRC5uEuEX9fWWHbvT6ZwnyMCrn8FWXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757947584; c=relaxed/simple;
	bh=QogwhwhBD5taaEL6aCDgXYigQV/BHUcgx7Lnh5InvFY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HKrwl7PzpNQ++wJ1yWQCY0osC78uWvgfjT0h4b3O6q1QnrhYZulq5Tftbf1mpA6csNsiEPV1P1WOhlc5pm+mKdVJcC9u3UO6qPO6kO+s7iGvP8FZfil1O5qZrewvuTkD8kdiq4WvYFqlPJmD3b3YNBVFHjfjNwOYAwvgG7iZ/Ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C7DJLb2z; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C7DJLb2z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757947581;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3iixl02GzJIIwECrAzAC57LmNMnKyHUtSXw03OUCFmM=;
	b=C7DJLb2zFck++PlzrEGc9lZEKdk6se/u/1nr2OPAa8BiPSvOc02sBiiRwXAjXv8Qm4pdHo
	iRemf0e+0wNOCw4jf2B8xDAEtz4ej0gBL1HR2uoXDtzOKNERk7lvYzFxAZzWNBDZ+QlLx7
	AcEDhpMPv14PEOtACJn6XGsY3g9dlgQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-646-9kcutvW4Nvy3mbSTWzaeHQ-1; Mon,
 15 Sep 2025 10:46:17 -0400
X-MC-Unique: 9kcutvW4Nvy3mbSTWzaeHQ-1
X-Mimecast-MFC-AGG-ID: 9kcutvW4Nvy3mbSTWzaeHQ_1757947574
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D88391944EB8;
	Mon, 15 Sep 2025 14:46:13 +0000 (UTC)
Received: from localhost (unknown [10.2.16.109])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 272FF300021A;
	Mon, 15 Sep 2025 14:46:12 +0000 (UTC)
Date: Mon, 15 Sep 2025 10:46:11 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Alok Tiwari <alok.a.tiwari@oracle.com>
Cc: michael.christie@oracle.com, pbonzini@redhat.com, eperezma@redhat.com,
	mst@redhat.com, jasowang@redhat.com, virtualization@lists.linux.dev,
	kvm@vger.kernel.org
Subject: Re: [PATCH] vhost-scsi: fix argument order in tport allocation error
 message
Message-ID: <20250915144611.GD69944@fedora>
References: <20250913154106.3995856-1-alok.a.tiwari@oracle.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="buCaxy2ziw9aWrHk"
Content-Disposition: inline
In-Reply-To: <20250913154106.3995856-1-alok.a.tiwari@oracle.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4


--buCaxy2ziw9aWrHk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 13, 2025 at 08:40:53AM -0700, Alok Tiwari wrote:
> The error log in vhost_scsi_make_tport() prints the arguments in the
> wrong order, producing confusing output. For example, when creating a
> target with a name in WWNN format such as "fc.port1234", the log
> looks like:
>=20
>   Emulated fc.port1234 Address: FCP, exceeds max: 64
>=20
> Instead, the message should report the emulated protocol type first,
> followed by the configfs name as:
>=20
>   Emulated FCP Address: fc.port1234, exceeds max: 64
>=20
> Fix the argument order so the error log is consistent and clear.
>=20
> Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
> ---
>  drivers/vhost/scsi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--buCaxy2ziw9aWrHk
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmjIJrMACgkQnKSrs4Gr
c8izxwf/R/xwOmhkjkGkZz7x1ehAMd48ucU2Ajg550ORHbJdg4bxD2zcmtTURNMZ
cJFYhSL+x9Q0KcjDowpoLyfV4y1gIJSCQADeDUG6XHnBEIm2Gd+ZoGxwyOhcDQ2q
KO30vVro4W6ziKyQ3gimVj3V3N3UH4dPUUzbNpG3AYAac5IpG9yECQYuZt7p7Dt1
rabFcKpyHqLCvTeVj01EdaYvLTSw0giSiUijLUaZHGqfI5ogbD89VR75VIdS/T5E
/SM4LKNJXPifq7pYNd3aEPQsS0GvZAZAWQvH33nCyKMYIwnofBEVOeGfuax5hwnn
XVg8m34f3qRyVZo6AIowlqeCsCOBTg==
=ZXKb
-----END PGP SIGNATURE-----

--buCaxy2ziw9aWrHk--

