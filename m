Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE173002B9
	for <virtualization@lists.linux.dev>; Wed, 12 Aug 2026 18:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786560536; cv=none; b=MXsQD7m1h0W9wLKQceKW9t/fysYE/kD9mLgBg9EM/JwJTKqVbcUY2CGWeHgCTzp/DfMqkdGiiSqD9I8A+BWiHNyfX+MuPxNp39b4MWUcnUrEehJAmDGIbkX43fB43IfKa+mKG4LF8gmBDXfabJzCXQS2ILLZZjZxnN7kpsh1e9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786560536; c=relaxed/simple;
	bh=bjNZqx7xPYsvFKEQ3VqkFi7d8GnMq1tCvPz1WqU87Jc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gVpzeWmVVMHwb4sg4Zhr7k/gtiXq9K7zQZyjtHcZtZfeN+txpunvu7EtjET4hFmOPrPsOhI/4AGC3WW2/qctIsY6gtK7UHTjNsIYIH+g9AXYCxRGZ4Y29oEkTrcguUPfbRMJoyXXNraAPxYcu5Wnbzkjq0c3zaXqKkVOe4ndczs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OxFBCrsk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OxFBCrsk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786560534;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ion7zsM1wuwj8v0X2H7I2jwkGAjdwsZsd5vjRG/Ldx0=;
	b=OxFBCrsk+lDUt1tBBqb83BqLgvAmXbXVJRS5LSmkhAm+yxQEwTUt6QEyHBM5yUUk1jpFA1
	eMbVcG/CBWSIUvdSSlhL/QYZJgbpXDUhd7SH13VPJcOnd43ECZuBTDVf8cJ8DtR7cl/nRa
	aGqfKHDjfP6aQt+HWXg+LDIYvU33nOc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-642-u1vxOzhdNkS-PUrf-N4Saw-1; Wed,
 12 Aug 2026 14:48:51 -0400
X-MC-Unique: u1vxOzhdNkS-PUrf-N4Saw-1
X-Mimecast-MFC-AGG-ID: u1vxOzhdNkS-PUrf-N4Saw_1786560530
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B8943180035C;
	Wed, 12 Aug 2026 18:48:49 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id ECB37422;
	Wed, 12 Aug 2026 18:48:48 +0000 (UTC)
Date: Wed, 12 Aug 2026 14:48:45 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Jia Jia <physicalmtea@gmail.com>
Cc: mst@redhat.com, jasowang@redhat.com, michael.christie@oracle.com,
	pbonzini@redhat.com, eperezma@redhat.com,
	virtualization@lists.linux.dev, kvm@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] vhost-scsi: serialize completion notification with
 callfd updates
Message-ID: <20260812184845.GA259475@fedora>
References: <20260806065143.55584-1-physicalmtea@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nes+HIqLeHiA28pN"
Content-Disposition: inline
In-Reply-To: <20260806065143.55584-1-physicalmtea@gmail.com>
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

--nes+HIqLeHiA28pN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 06, 2026 at 02:51:43PM +0800, Jia Jia wrote:
> vhost_scsi_complete_cmd_work() drops the virtqueue mutex before calling
> vhost_signal(). VHOST_SET_VRING_CALL replaces call_ctx.ctx and releases t=
he
> old eventfd_ctx while holding the same mutex. vhost_signal() reads the ca=
ll
> context before and after vhost_notify(), so a concurrent callfd update can
> make it signal a freed context or NULL.
>=20
> KASAN reported the use through:
>=20
> 	eventfd_signal_mask
> 	vhost_signal
> 	vhost_scsi_complete_cmd_work
>=20
> The context was released through:
>=20
> 	eventfd_ctx_put
> 	vhost_vring_ioctl
> 	vhost_scsi_ioctl
>=20
> Keep the mutex held through vhost_signal() so completion notification and
> callfd updates are serialized.
>=20
> Fixes: 057cbf49a1f0 ("tcm_vhost: Initial merge for vhost level target fab=
ric driver")
> Link: https://lore.kernel.org/r/20260720085306.1519294-1-physicalmtea@gma=
il.com
> Signed-off-by: Jia Jia <physicalmtea@gmail.com>
> ---
> Changes since RFC:
> - Send as a non-RFC v2.
> - Add Fixes and Link tags.
>=20
>  drivers/vhost/scsi.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--nes+HIqLeHiA28pN
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmp8wA0ACgkQnKSrs4Gr
c8gS9wf7B5UusKdqG9SmB9caKbFt9+tVhCHTHHu5YqHL1TrUkssemsA+b/2grmt5
No+sYQ/zGeyoYPvFLrNQm+2r49/Pz+kq84KbovRe4BzRRtISWicqPDALsChD+wsU
RxCYfkfB3gelfgBTZrWzr+hycIPWnDv/36OBE+jwMTf6ZkWR7riu1enH0NS76Qow
5omHltl0cMxd1egdTOa6ZxrTldw3rv1Cdey31sbaYmqiBZMnSb2AHp1lCTqfSq7q
D9+ftvlRHr0I8xbWQsrEbChZK48PQtTCJr5KFgnNCZ1wQM/Fo+L0Lt7ppeRPlih1
PcZ1owKQzZ6OeedAyzQkHPq5jEGB8w==
=7yPr
-----END PGP SIGNATURE-----

--nes+HIqLeHiA28pN--

