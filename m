Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A52E925E469
	for <virtualization@lists.linux-foundation.org>; Mon,  9 Jun 2025 13:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749476912; cv=none; b=tTKW9I5B55p10vNC1ZbfdbTD+k/gNUytx90l4VQviL20ClGL4OaxnzpTtrbEsFWbHlfxJJbPbarhOQ4Wx0iQGBSQhYXKljga08Tv/SIl/V3WdU8XV0nMRdsrSbYJJyb8ZyGzC9aNcJW4vzDTemOCYvJNNjNqkpKQlKU3K3fmda8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749476912; c=relaxed/simple;
	bh=mmPa5JwpqRQynk8BNAeOQDnWNY3YterlpnUM6tQkRjA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LQ53l2HzAqs8QIl4sIo1xR6GVB2pCHq99/hkQA4YcuI30tqn2cH0LwGcx554s5+NdyPcFrnKqRYeJNQJRsLj9TxXoXzTqY4HOZVI44sUasaNZXVuuNBFBcGq+f9N1MX8uVTrKlrWJRljr769C6eZdvrOhA6ILGTgwo+51TMmU0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Av0goQNG; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Av0goQNG"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 38B88417C5
	for <virtualization@lists.linux-foundation.org>; Mon,  9 Jun 2025 13:48:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.79
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GBa-dEEUZHyc for <virtualization@lists.linux-foundation.org>;
 Mon,  9 Jun 2025 13:48:29 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=stefanha@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 84F21417AA
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 84F21417AA
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Av0goQNG
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 84F21417AA
	for <virtualization@lists.linux-foundation.org>; Mon,  9 Jun 2025 13:48:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749476907;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/dBd1Rm/JzUuvHdp7PfLsxtlX0Oxan8mEvX30F3igWU=;
	b=Av0goQNGglWPdkWSgYodbwSRnojADiihLF1tAfcaFwAqlyhcWzycc760cS/k3X2bc3fp9u
	C3zxNNmEUknkabkxu8NcNZhcX31jXYNRw5NShz9HidamVDjDWFedgRNmm/POP1449wwHFq
	yypPWReXc+ciRyBSspxxUIyGfpvXNgQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-557-A_LlsthWNI6UapUAGhrWXQ-1; Mon,
 09 Jun 2025 09:48:25 -0400
X-MC-Unique: A_LlsthWNI6UapUAGhrWXQ-1
X-Mimecast-MFC-AGG-ID: A_LlsthWNI6UapUAGhrWXQ_1749476905
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id ED5701955E9D;
	Mon,  9 Jun 2025 13:48:23 +0000 (UTC)
Received: from localhost (unknown [10.2.16.92])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 47B3E18003FC;
	Mon,  9 Jun 2025 13:48:23 +0000 (UTC)
Date: Mon, 9 Jun 2025 09:48:22 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Mike Christie <michael.christie@oracle.com>
Cc: jasowang@redhat.com, mst@redhat.com, sgarzare@redhat.com,
	virtualization@lists.linux-foundation.org
Subject: Re: [PATCH] vhost-scsi: Fix log flooding with target does not exist
 errors
Message-ID: <20250609134822.GB29452@fedora>
References: <20250607171815.111030-1-michael.christie@oracle.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="+72+KjDIFd8kZPxT"
Content-Disposition: inline
In-Reply-To: <20250607171815.111030-1-michael.christie@oracle.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93


--+72+KjDIFd8kZPxT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 07, 2025 at 12:18:15PM -0500, Mike Christie wrote:
> As part of the normal initiator side scanning the guest's scsi layer
> will loop over all possible targets and send an inquiry. Since the
> max number of targets for virtio-scsi is 256, this results in 255
> error messages about targets not existing. When there's more than 1
> vhost-scsi device, then you get N * 255 log messages.
>=20
> It looks like the log message was added by accident in:
>=20
> commit 09d7583294aa ("vhost/scsi: Use common handling code in request
> queue handler")
>=20
> The patch was just making some coce common but added the vq_err call
> and I'm guessing the patch author forgot to enable the vq_err call
> (vq_err is implemented by pr_debug which defaults to off). So this
> patch removes the call since it's expected to hit this path during
> device discovery.
>=20
> Fixes: 09d7583294aa ("vhost/scsi: Use common handling code in request que=
ue handler")
> Signed-off-by: Mike Christie <michael.christie@oracle.com>
> ---
>  drivers/vhost/scsi.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--+72+KjDIFd8kZPxT
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmhG5iUACgkQnKSrs4Gr
c8gsyAf+KVl9FdLoIqEAf4VpT91sftt07b1Ks+DzdgQ2SqkpMxofnJJr1gwdO+a7
LJjOOKkOUohn0+pwylpKXb1Q3xNuHvQFKrt+SmN6Kke/8yLM1HmTIFETvmOOAWs8
042V10azYXn4/Ep/OToKXZbiO9XNUhkAwxoLCb2r9DCO1mrg7s6LkUQkI0VyIz+u
3FTUD+cMHQwSeKdjIb9MkoshdaLGhTqbWtg2rf4jl5cUPqLKlu5yC9TPeCwwSKNW
LDPeJ2HDPvA0mi9j67CbkP90Ewdo52n3k/K1XkyQt9qpZ54ka9BECOgFStJ8sIHf
vn8QqZQjxo9ouGaXLa/KhiYh7tHRfQ==
=tACw
-----END PGP SIGNATURE-----

--+72+KjDIFd8kZPxT--

