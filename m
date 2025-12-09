Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE0322A7E4
	for <virtualization@lists.linux-foundation.org>; Tue,  9 Dec 2025 13:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765288766; cv=none; b=dqp5ZKwlwq2n4kNHARm1tkpqXOFGC9uTYcyeot3+Cz8ewCp/oQJObAtuLg58r2gJI9jiJL2hzTtpbcvZdw7WfucnxmUqSoaf6O5JecsYXLPrNsaiLKmbVJrZo9kwEx9u4xdlFDTH7q8fVGRF4dh2du1/rNBYa/8/ojW4qJNLZ54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765288766; c=relaxed/simple;
	bh=5PUzNxuoJacVvHqJcqBhckaZWQBgcHmBET8yvCDYCnA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i1VYic27DeksenU/0vIvLE8ZILHGOa62yhVFd4/ZdWsknObHQTd7x7ED8WjNnbeNz/qjhK1J3KL8Vef4HGI5zana27eCSdrGsgl/56HbEnxMMuELLea/yc2ibeTOzrRdm/MOb4/R+PJVsJ7EoeNJ3ckwYGxsDlc+umZnmJyR850=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ge7989c1; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ge7989c1"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id DCD8F40AF0
	for <virtualization@lists.linux-foundation.org>; Tue,  9 Dec 2025 13:59:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.795
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XaF_5AaxaJ6U for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Dec 2025 13:59:23 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=stefanha@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org CB5F540141
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org CB5F540141
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ge7989c1
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp2.osuosl.org (Postfix) with ESMTPS id CB5F540141
	for <virtualization@lists.linux-foundation.org>; Tue,  9 Dec 2025 13:59:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765288761;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=I1TTzI/96jBDU3/QsT/fLw/QvyFDm2HvFzT99h0d+y8=;
	b=ge7989c1zZ0fjiZmeLv2U0KVYSeDYqFcneqNc1VI66v2aY3SvlNgY5r5veE+XsyPA77/wC
	8LePMb5rq2kYTJtWj+EeN8jpzLcFeVpsFm9fqU8fmeTV4byWrkcVmrbCelAJc2M0Fj6C9z
	tq8gkJNKp4693F15KOu4J/vZ9TRCRqw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-649-PQjRI1tPP_SOasFq9vvTxg-1; Tue,
 09 Dec 2025 08:59:06 -0500
X-MC-Unique: PQjRI1tPP_SOasFq9vvTxg-1
X-Mimecast-MFC-AGG-ID: PQjRI1tPP_SOasFq9vvTxg_1765288744
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A555A1800675;
	Tue,  9 Dec 2025 13:59:04 +0000 (UTC)
Received: from localhost (unknown [10.2.16.91])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D6E0219560AD;
	Tue,  9 Dec 2025 13:59:03 +0000 (UTC)
Date: Tue, 9 Dec 2025 08:59:02 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Cc: mst@redhat.com, sgarzare@redhat.com,
	virtualization@lists.linux-foundation.org, oren@nvidia.com,
	aevdaev@nvidia.com, aaptel@nvidia.com
Subject: Re: [PATCH 1/1] virtio: add driver_override support
Message-ID: <20251209135902.GA1370792@fedora>
References: <20251208143925.32246-1-mgurtovoy@nvidia.com>
 <20251208155412.GB1346548@fedora>
 <7c4f605e-6faf-47e9-a920-3d7f782e9332@nvidia.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mWO8dPXYpCsW6WCv"
Content-Disposition: inline
In-Reply-To: <7c4f605e-6faf-47e9-a920-3d7f782e9332@nvidia.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12


--mWO8dPXYpCsW6WCv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 08, 2025 at 06:18:14PM +0200, Max Gurtovoy wrote:
>=20
> On 08/12/2025 17:54, Stefan Hajnoczi wrote:
> > On Mon, Dec 08, 2025 at 04:39:25PM +0200, Max Gurtovoy wrote:
> > > Add support for the 'driver_override' attribute to Virtio devices. Th=
is
> > > allows users to control which Virtio bus driver binds to a given Virt=
io
> > > device.
> > >=20
> > > If 'driver_override' is not set, the existing behavior is preserved a=
nd
> > > devices will continue to auto-bind to the first matching Virtio bus
> > > driver.
> > >=20
> > > Signed-off-by: Avraham Evdaev <aevdaev@nvidia.com>
> > > Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> > > ---
> > >   drivers/virtio/virtio.c | 34 ++++++++++++++++++++++++++++++++++
> > >   include/linux/virtio.h  |  4 ++++
> > >   2 files changed, 38 insertions(+)
> > What is the use case? Is there something missing in existing drivers
> > that cannot be added to them by extending the code?
> >=20
> > Stefan
>=20
> The main goal is to align the virtio bus with the flexibility that alread=
y exists for other buses in the Linux device model.
> On buses such as PCI and vDPA, it is possible to override or replace the =
default driver for a given device and bind it to an alternative driver.
> Allowing the selection of which driver is bound to a device can be useful=
 in both development and production environments.

There are use cases for PCI and vDPA, like binding vfio_pci to a device
that would normally use its device-specific driver.

For VIRTIO, I'm not sure what the use case would be. Is there another
driver that could bind to virtio-net devices, for example?

Giving a concrete example would be useful to help people understand why
this is necessary.

Stefan

--mWO8dPXYpCsW6WCv
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmk4KyYACgkQnKSrs4Gr
c8gp5Qf/VYr99wJv/01MAvFoNEr7Vvb82SALLAot1f4VSvG0KzKz5o5pFmcf1Ddv
1a4/8n2wSYqbspPNkfoXx4fduAZBSK2e2YjdxLsl/6unvzscn3SRcJ4OW8px8MTA
HFRi02L/M+Favks5xBYx/T2tBEbF1GYZC14HoHBEVkekTBm7qxDMy4VOQMhVnJVj
JlrJ4Fl8ILs8AFQiOz15Y1Ugvuuzo31xP35v3UGfbRNFfY8IAfc31tLkyGBJCP2y
fEo5RdHvDFXKRosE9zgjDRdRg2DbR9pMQImpcL29o3aRptAhuUADzPhG37iipJ6Q
9LPrNL6X9O+83qW8ZQqya5Yirwflng==
=aEYT
-----END PGP SIGNATURE-----

--mWO8dPXYpCsW6WCv--

