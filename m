Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 773003A6B85
	for <virtualization@lists.linux.dev>; Mon, 20 Apr 2026 17:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776706442; cv=none; b=gm75Pk3/xenb2jMnMDQFS/UPu/IO+l02+BrP3jVLibWGSmUYwxYSLSTxDMHIK750pzangu1ucJGZ8RHrm+r4Eo2ZVztI9XomtNcpotThAlhIfgTOvPVUsBhQtVOeQ3M8Hezj9OCUZbemm6YtbWJrpieFVkT6cbPH1Ijy1+cMHYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776706442; c=relaxed/simple;
	bh=yXRXa49ii7EMtQpnop2c+sFR3fyXPbmJPIrsey3pv50=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z5f8UIqlQ9vLVGDMnC4/SKDgC/+An3jceCjk711m8dVOkij/dOBKxsy18KNRHHfIY0cTDYKp+dNXsx0Hvgt/iNeNGDxs14vMZYfahgOCEqFyun3Aqj60qtPDcwI9tPTZr7/nmTcWNHqNkPfo5uU38/s6c+s5EUYg5K3jsZXZnSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b3PnCP7f; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b3PnCP7f"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776706440;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yXRXa49ii7EMtQpnop2c+sFR3fyXPbmJPIrsey3pv50=;
	b=b3PnCP7f6/XHI2Mn1l1m9FQLYQpdGC3D2u6FRXZB6q2ZjiteP3yoIuvAIdVPq1R13EqBPq
	0DtuUh5426Pvv6Uj4YGzFAurrXL41etdJUPxwOuf8FhPrZee+Pm4l1DWUCj5JfvrfwufxE
	QqAZRHm5r1ciLB0VZ8i7sW8vu5EHo3Y=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-270-cI8A8w63OKmBYpXpBmnZYg-1; Mon,
 20 Apr 2026 13:33:57 -0400
X-MC-Unique: cI8A8w63OKmBYpXpBmnZYg-1
X-Mimecast-MFC-AGG-ID: cI8A8w63OKmBYpXpBmnZYg_1776706435
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 75A7118004AD;
	Mon, 20 Apr 2026 17:33:55 +0000 (UTC)
Received: from localhost (unknown [10.44.48.35])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 531E21800370;
	Mon, 20 Apr 2026 17:33:54 +0000 (UTC)
Date: Mon, 20 Apr 2026 13:33:52 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Mike Christie <michael.christie@oracle.com>
Cc: martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
	james.bottomley@hansenpartnership.com,
	virtualization@lists.linux.dev, mst@redhat.com, pbonzini@redhat.com,
	eperezma@redhat.com
Subject: Re: [PATCH 0/4] scsi: Support devices that don't have a cmd_per_lun
 limit
Message-ID: <20260420173352.GB405461@fedora>
References: <20260417230751.117836-1-michael.christie@oracle.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="KaAzs6/QIPBWgyu3"
Content-Disposition: inline
In-Reply-To: <20260417230751.117836-1-michael.christie@oracle.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93


--KaAzs6/QIPBWgyu3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 17, 2026 at 05:57:20PM -0500, Mike Christie wrote:
> The following patches were made over Linus's and Martin's 7.1 trees.
> They fix an issue where for virtio-scsi we export a lot of non-scsi
> devices but are getting throttled by the cmd_per_lun_limit too early.
> For example we export 1 or more NVMe or block devices and would like
> to just pass command to them in way where virtio-scsi's hw queue
> limits match the physical hardware. Or in some cases we are doing
> cgroup based throttling on the host side, and we don't want the guest
> to block IO when the host knows we have extra bandwidth.
>=20
> The patches add a new cmd_per_lun value so drivers can indicate
> when to avoid tracking queueing at the device wide level. They
> then rely on just the block layer hw queue limits. And the patches
> convert virtio-scsi. They also fix some can_queue related issues
> discovered while testing/reviewing.

Hi Mike,
Is there a difference between setting cmd_per_lun to U32_MAX with your
patches versus setting cmd_per_lun to the virtqueue size without your
patches (this can already be done today without code changes in the
driver)?

Thanks,
Stefan

--KaAzs6/QIPBWgyu3
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmnmY4AACgkQnKSrs4Gr
c8gWQggAih11OwTFLYPwIEPZH1UoehTgpAOlQUsDBxyaxZCSkkcVN/d4+9/Hbs4A
dIczEZdYWOmzAHeefxcR3HUWWVU29v5ZpoeKY9eWb/JEhNujh8U6bx6GoMn3jVq4
PIfqU8p4YKZRhpRg4VR/JZbN9LEydANb53rOStyCrp8CAy+8nCvQ2gQrxHyyTeSH
mSAEjLuLNGBw5tjO5SqfHkQR8WTzDLW5G3ErW+goMtDaQ6zR4ezVuq9JKn72RLAV
VAVjWnRsXjgvhUVr3zzoHwdfj2fH0U7TNZ1RI9//BvC/lpzSKqsNuvdY/hxtT+8U
XObCdlBmXMXApDvpnKYliXxm8MRLbA==
=F1XH
-----END PGP SIGNATURE-----

--KaAzs6/QIPBWgyu3--

