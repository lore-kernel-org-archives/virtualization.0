Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86F6B443E41
	for <virtualization@lists.linux.dev>; Tue, 11 Aug 2026 13:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786456306; cv=none; b=kwJwosVbc7uvM6p3E8uWQc+x7SnuR5OLzZnQ+jAR3GORDXqU35PbXriLG5exGr36Emq5UTZrgTgdIgnxsg6zhLPrVdvYde8AlpsX3ayqWCtAljiWbx/DrqwpJpweh3r8Ocu0nzi7FRkqIlIBPU1e3Wtuz6ciGCH1cwstaWFnEAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786456306; c=relaxed/simple;
	bh=gh4qooKwtBh4pXP1HuhO7SNZ2QHesiKmlW85AkLL7k4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rJcy7uH491DzNVtACnex30CKNoMjGbQBhtXTu6VDRkZecm9uQfwChB3WsOWAzF6Z0U7do9bCu2MAMbqTtr+TaEG3LgoI0fY1hB3ZxNBA+B6dMaVJPyhcMTrib7XqXCMv05HJovB/QuKRf7Y4qGJqs583attDwez8TWr9KMduVYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P1qIzvw9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P1qIzvw9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786456297;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Tl8SQZP7QuWQD14IYawC7RVsu+VvCBZakb6MHFjDTMs=;
	b=P1qIzvw9Tpf2iOqTaGCtHwGf/+ol2BIa3G5buPh4tdHUcx9jElU0xkDNqSswAohkNKUe4g
	cDzyRKpgNuJGOn8H88ZTAVoRooQFk6bM1qSmxuV14X6bUnWCngx+ZlMmk1sAWsqkaImT+9
	bCqoT2BovdTIVDCaCm8u4J4E/3ULtVA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-615-FEGQGM-cNFuP8tph7d38Ng-1; Tue,
 11 Aug 2026 09:51:33 -0400
X-MC-Unique: FEGQGM-cNFuP8tph7d38Ng-1
X-Mimecast-MFC-AGG-ID: FEGQGM-cNFuP8tph7d38Ng_1786456292
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 34A3819560AA;
	Tue, 11 Aug 2026 13:51:32 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5814E423;
	Tue, 11 Aug 2026 13:51:31 +0000 (UTC)
Date: Tue, 11 Aug 2026 09:51:27 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Dongli Zhang <dongli.zhang@oracle.com>
Cc: virtualization@lists.linux.dev, mst@redhat.com, jasowangio@gmail.com,
	michael.christie@oracle.com, pbonzini@redhat.com,
	eperezma@redhat.com, kvm@vger.kernel.org, joe.jin@oracle.com
Subject: Re: [PATCH v2 0/2] vhost-scsi: fix max_io_vqs handling
Message-ID: <20260811135127.GB111558@fedora>
References: <20260802172534.260047-1-dongli.zhang@oracle.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nRJ8aU5O/ZHyisF6"
Content-Disposition: inline
In-Reply-To: <20260802172534.260047-1-dongli.zhang@oracle.com>
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

--nRJ8aU5O/ZHyisF6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 02, 2026 at 10:24:54AM -0700, Dongli Zhang wrote:
> Avoid high-order kmalloc() allocations for the vhost-scsi virtqueue array,
> and clamp out-of-range max_io_vqs updates so the stored value remains
> within the supported range.
>=20
> v1->v2:
>   - Access vhost_scsi_max_io_vqs with READ_ONCE().
>   - Clamp out-of-range max_io_vqs values instead of rejecting them.
>=20
> Dongli Zhang (2):
>   vhost-scsi: use kvzalloc for vq array allocation
>   vhost-scsi: vhost-scsi: clamp max_io_vqs module parameter
>=20
>  drivers/vhost/scsi.c | 49 ++++++++++++++++++++++++++++++++++-------------
>  1 file changed, 36 insertions(+), 13 deletions(-)
>=20
> base-commit: 2d2338c93da79b3bfe4b6099a931d9468d539952
>=20
> Thank you very much!
>=20
> Dongli Zhang
>=20

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--nRJ8aU5O/ZHyisF6
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmp7KN8ACgkQnKSrs4Gr
c8jvCQf9HiJAU4bwdawrjnhcxSCHUZMJhWY+MVdLPAvvOSoelfyU+dw9O7fvuEML
Z8OczANuafEbDrxUC6/9vqpEau/is7eC90IuL3slA+4fjiuzZlWXpfN8NWhjzQCC
i6CxCTRPstLWmUdDWKAq1ve4/Fz1whZ3xQJ9Rh1AwdNpi2Mnv8bDIU8RzCnERMlU
P8YJ8E1gCj/YgKbmFEtx3drGwj2Z2szfCOONjvsvgwq0YGNNDMrVMlY1qWF8h5FA
p6xvuKUj4SxM3u8UfDs8b8Tv5URIsGiLkNMozXeazoY0essTJuzVafeoSsHWSax+
VcZhy+jOE5nlg6n7BWLFHUsLPSut1A==
=aMFK
-----END PGP SIGNATURE-----

--nRJ8aU5O/ZHyisF6--

