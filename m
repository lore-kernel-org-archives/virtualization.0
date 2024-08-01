Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D0A1B4C2A
	for <virtualization@lists.linux.dev>; Thu,  1 Aug 2024 17:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722534986; cv=none; b=CEN3qdtH33obeaxAhPWggXs382wMICJ7+vfdAJ/4KLj9Fmx7X9MEwOSct1MQAmHy10EK+cpbn/hmIR2i+Txi1pxEE4f0l1O+s8C3siqIJNeuBPD0m/ggXKYcB+yTD91OTCDbpAdo2IVt5HuypVLPSemdJ69lh7MnuS8eXwmpwk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722534986; c=relaxed/simple;
	bh=C5svpa1fPsliHutAflKdjrMRwnUl28cggDEP+yfJEe4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RmkpzDwQUVUuByU/RVaZvwmVtYnD/CWNkISBSusp4eFowD++fiHJpQep4jaGQSk2cnrJ1QDWGR901/CKWvWQFzW5+kckmqxEkGIWSPmKSmQ5U597LWCfeme7RzE+9+jjGGDWZOVNoIwe/YvztELxv1YqNQaeTD3EQG5sZCRYYTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WQXPJdAp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WQXPJdAp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722534983;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=C5svpa1fPsliHutAflKdjrMRwnUl28cggDEP+yfJEe4=;
	b=WQXPJdAp2qHRtzroSnoppMmVv77VaAc9dtpqOHIndqDLw/YmCGkpHswNDxPo9jN2dDfB7V
	Cry6QF4NDDYu8Ih62Fva9sivcNvPs5kL2SmiN9P3cfhe+RIRT9LlA73sTyFTYXAg0kjBQ2
	pJCR7NjshbMviN0wa5Lc+hitcc48fcM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-414-DdLC8e1wNLmXp9KCuo5Odg-1; Thu,
 01 Aug 2024 13:56:22 -0400
X-MC-Unique: DdLC8e1wNLmXp9KCuo5Odg-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C533019560A3;
	Thu,  1 Aug 2024 17:56:19 +0000 (UTC)
Received: from localhost (unknown [10.2.16.116])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6658C19560AE;
	Thu,  1 Aug 2024 17:56:18 +0000 (UTC)
Date: Thu, 1 Aug 2024 13:56:17 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux.dev,
	axboe@kernel.dk, kvm@vger.kernel.org, linux-block@vger.kernel.org,
	oren@nvidia.com
Subject: Re: [PATCH 1/1] virtio_blk: implement init_hctx MQ operation
Message-ID: <20240801175617.GA1133773@fedora.redhat.com>
References: <20240801151137.14430-1-mgurtovoy@nvidia.com>
 <20240801111337-mutt-send-email-mst@kernel.org>
 <0888da3b-3283-405b-b1a8-a315e2623289@nvidia.com>
 <20240801112843-mutt-send-email-mst@kernel.org>
 <9400fb28-47c2-4629-af17-df2a95f2d3d8@nvidia.com>
 <20240801114205-mutt-send-email-mst@kernel.org>
 <6a8f0c72-ba77-42c3-8d85-6bb23a23f025@nvidia.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="c2XeR3n4E+7rtcIW"
Content-Disposition: inline
In-Reply-To: <6a8f0c72-ba77-42c3-8d85-6bb23a23f025@nvidia.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12


--c2XeR3n4E+7rtcIW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 01, 2024 at 06:56:44PM +0300, Max Gurtovoy wrote:
>=20
> On 01/08/2024 18:43, Michael S. Tsirkin wrote:
> > On Thu, Aug 01, 2024 at 06:39:16PM +0300, Max Gurtovoy wrote:
> > > On 01/08/2024 18:29, Michael S. Tsirkin wrote:
> > > > On Thu, Aug 01, 2024 at 06:17:21PM +0300, Max Gurtovoy wrote:
> > > > > On 01/08/2024 18:13, Michael S. Tsirkin wrote:
> > > > > > On Thu, Aug 01, 2024 at 06:11:37PM +0300, Max Gurtovoy wrote:
> > > > > > > In this operation set the driver data of the hctx to point to=
 the virtio
> > > > > > > block queue. By doing so, we can use this reference in the an=
d reduce
> > > > > > in the .... ?
> > > > > sorry for the type.
> > > > >=20
> > > > > should be :
> > > > >=20
> > > > > "By doing so, we can use this reference and reduce the number of =
operations in the fast path."
> > > > ok. what kind of benefit do you see with this patch?
> > > As mentioned. This is a micro optimization that reduce the number of
> > > instructions/dereferences in the fast path.
> > By how much? How random code tweaks affect object code is unpredictable.
> > Pls show results of objdump to prove it does anything
> > useful.
>=20
> This is the way all modern block drivers such as NVMe PCI/RDMA/TCP use the
> driver_data.
>=20
> These drivers don't have driver specific mechanisms to find the queue from
> the hctx->queue->queuedata like vblk driver has for some unknown reason.
>=20
> It is pretty easy to review this patch and see its benefits, isn't it ?
>=20
> It is not expected to provide extreme perf improvement.
>=20
> It is introduced for aligning the driver to use common MQ mechanisms and
> reduce dereferences.
>=20
> This is not "random code tweaks".

If you cannot observe a performance change, then adjusting the commit
description to explain this as a code cleanup to reduce dereferences and
local variables, improving code readability seems fine to me. I think
it's a nice cleanup when presented as such rather than a performance
optimization.

Stefan

--c2XeR3n4E+7rtcIW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmarzEAACgkQnKSrs4Gr
c8jZyQf/Z3f/9y0UpEZzE/+QHEVZJvD55lQQZOw8ARH01kX2XfoQyGqHgujocw1k
j12kKIk1PmgmjKMnV8vCxSF5s+LpPON1J0fnBm3Ke3uJuKYwcK9T0xdV0ECKc0+e
pXEYV96W9OrB9t9NN7fgSAhRXfWmefVcIn8+fG1/waltnBJMowPHlgnjVMrTT2bE
FC6z8PqbAjcTGZab4IE12ZA1AAlfmkVH7fULl6kWlLXfV+RuxkLNsRSP0nRmSBbM
WmMtinpOhSg2n0o/qxsR0LAd4mqbEAL+9PYnYKhVS5P6LuG5ENBwcvkJp0gx7Ftd
+pQ20Kc0BvzxAYosRTVY632SeZTvjg==
=n19p
-----END PGP SIGNATURE-----

--c2XeR3n4E+7rtcIW--

