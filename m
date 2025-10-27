Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C569A2DF14A
	for <virtualization@lists.linux.dev>; Mon, 27 Oct 2025 13:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761572863; cv=none; b=lpLCrdtXhiFJb1JpdYeKkpfAAGHC71eyCjdqOJ8rVnhCgNQv22k1FczqJbvMVI1WBHelgikNrC0ZlI+IZaszYPI8B3llUVB3AN7oQKz2SA657uyCnOo57pkLQ/FEW15lQCGijODaS/iDFGKl+pjO9qvR6aBrokUj4d6rgQDamBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761572863; c=relaxed/simple;
	bh=LOkZFXZ3ZELJ35KG0nvYUexkDEzKnAuOzNylQjxm22Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ef6OfjdLjEF1mVGGpGnGF+9MUVunqMPjjL+s4g1pqfYThkJeAe+HQ4nMPZqURQr+XEft66WRjrnQ8HcWaEw50Ek+xSa9tBxFZ9seIWsGxEc2aywJbgInU7HA51vXyFf/OunqXQ5TAQB2wOfrox27Xx6/KV9Q204KcmNtmhaaS2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MC60JA64; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MC60JA64"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761572860;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rlMGVCW3NO++j4IeyaSGAHEC2AmkaTuwxwXk983vVMs=;
	b=MC60JA64z83/nvLzYy5ycb0n5Q0w4DYixf23PnZccusoN5mdYo4dAKP8/WwT4gDBQaNIIu
	rvE4Em0IAlwUm45M+I9UQVt0fQB7oab2hkJchy+Vwh/5RBO95tvGreSxEukoo0nJd62sjO
	c9dCah3jOwhH55KmAA5vbwmKJ96p8uI=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-461-GHNye4dHP9-514ujb-r4-w-1; Mon,
 27 Oct 2025 09:47:35 -0400
X-MC-Unique: GHNye4dHP9-514ujb-r4-w-1
X-Mimecast-MFC-AGG-ID: GHNye4dHP9-514ujb-r4-w_1761572854
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 79C8319539A3;
	Mon, 27 Oct 2025 13:47:33 +0000 (UTC)
Received: from localhost (unknown [10.2.16.54])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 592AD1955F01;
	Mon, 27 Oct 2025 13:47:32 +0000 (UTC)
Date: Mon, 27 Oct 2025 09:47:31 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Alok Tiwari <alok.a.tiwari@oracle.com>
Cc: mgurtovoy@nvidia.com, izach@nvidia.com, smalin@nvidia.com,
	vgoyal@redhat.com, miklos@szeredi.hu, eperezma@redhat.com,
	mst@redhat.com, jasowang@redhat.com, virtualization@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, alok.a.tiwarilinux@gmail.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] virtio-fs: fix incorrect check for fsvq->kobj
Message-ID: <20251027134731.GA11774@fedora>
References: <20251027104658.1668537-1-alok.a.tiwari@oracle.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="irdcpZZIdkIBl6wD"
Content-Disposition: inline
In-Reply-To: <20251027104658.1668537-1-alok.a.tiwari@oracle.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12


--irdcpZZIdkIBl6wD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 27, 2025 at 03:46:47AM -0700, Alok Tiwari wrote:
> In virtio_fs_add_queues_sysfs(), the code incorrectly checks fs->mqs_kobj
> after calling kobject_create_and_add(). Change the check to fsvq->kobj
> (fs->mqs_kobj -> fsvq->kobj) to ensure the per-queue kobject is
> successfully created.
>=20
> Fixes: 87cbdc396a31 ("virtio_fs: add sysfs entries for queue information")
> Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
> ---
>  fs/fuse/virtio_fs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--irdcpZZIdkIBl6wD
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmj/d/IACgkQnKSrs4Gr
c8g4VQgAqhNd1hjJGhM4ivPxRFday+L3RXLtrGjXhYmGDNNkN8OQX47mOjkUSJue
4bzETLFsBBzj1qXzmfLxCAv5W/6YmNArHk7Z1AuNWi30E3Jf15CNz0pdrba27qAE
9Ggmr/mI3Jo3vad4fnIN+jHgMDkPh2j+IKq700pdS7BZZZGsayc2uSje8zYyunXj
pAa0dpxtwaW/HmL4D1skL9q46GeupsN87xjkjnzolm2RwtzyljHMgxYrvFqB9DPG
//k2Hje8HUY8n9sXt2mQvxeayl1mbjJjfYb8eXsHxQwQb3JvuV82gDpa8jW465eT
xbmwVYW9XpQuE1O4RxuCnz4X+y2IRA==
=Og4O
-----END PGP SIGNATURE-----

--irdcpZZIdkIBl6wD--

