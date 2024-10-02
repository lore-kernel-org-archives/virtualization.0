Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 668711D0436
	for <virtualization@lists.linux-foundation.org>; Wed,  2 Oct 2024 13:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727876550; cv=none; b=T/Se5FqgpAkMmJ+JGhvi/fDrxDHjNr7MJ0oTwabw/iaJGQYgMVRorQ7ogEdgMe6h7dBDq80LwfyHDPDJVe2ucQLUPzIpzmtLPldM1XA60Iq5SW72KBMbwkgf+T1BSuEkygrEfwxhngsJuYaWiT088qHOyfNQ4ZLKAoHbCsNTgIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727876550; c=relaxed/simple;
	bh=vdAKlYOM3etBiXRue4uJvjZIi/kLJzu/QfNFqhk9ZBQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uGBgfGuFoai0XG+VZWpLgsNQ//ecvC1u/P6nTzW7TI4sIAjRkM6JYGehG9TsGoyc1jkgvbNlgdRzh3lsxmSi4+YeUVsrrXMgnu5RpTrf4x3whvq0M9tB6nDVyQHWgMpdojtJ8SyevzcdRJD85JH2JxHMyidWUWxMOd5D9R4XfM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d47MNorH; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d47MNorH"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 087ED81397
	for <virtualization@lists.linux-foundation.org>; Wed,  2 Oct 2024 13:42:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.79
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6ZnMw9ASkcs4 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Oct 2024 13:42:28 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=stefanha@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 1508380E77
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1508380E77
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=d47MNorH
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 1508380E77
	for <virtualization@lists.linux-foundation.org>; Wed,  2 Oct 2024 13:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727876545;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vdAKlYOM3etBiXRue4uJvjZIi/kLJzu/QfNFqhk9ZBQ=;
	b=d47MNorHD2ybiu+k37Z7e5xXbahpr34VfBj8Z/HmRFiEZC73egnCe+suQAKa1e6rrCkNAK
	NuJ9dd+vt5I9r3wM1Jvcs7W6Ysghnzhnsa12Q5VnPzgzobCIcJ0TxjW9CXrMdjLQm4CreY
	9WyfAixVplSYpdS8J2IK5j9EnC6S7Ow=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-338-2d7h7rZBMfSDFeQxRVUrYQ-1; Wed,
 02 Oct 2024 09:42:22 -0400
X-MC-Unique: 2d7h7rZBMfSDFeQxRVUrYQ-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 545621955F3C;
	Wed,  2 Oct 2024 13:42:20 +0000 (UTC)
Received: from localhost (unknown [10.2.16.122])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 417931956088;
	Wed,  2 Oct 2024 13:42:19 +0000 (UTC)
Date: Wed, 2 Oct 2024 09:42:17 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Daniel Verkamp <dverkamp@chromium.org>
Cc: Max Gurtovoy <mgurtovoy@nvidia.com>, mst@redhat.com,
	virtualization@lists.linux-foundation.org,
	virtio-dev@lists.linux.dev, oren@nvidia.com, parav@nvidia.com
Subject: Re: [PATCH 1/1] virtio-blk: Add description for blk_size field
Message-ID: <20241002134217.GA1362405@fedora.redhat.com>
References: <20240925145228.27953-1-mgurtovoy@nvidia.com>
 <CABVzXAntBt+5L4a1ntud_7j_EHiB4yG6FuskNaPBirOfLJ7i6w@mail.gmail.com>
 <ca954af2-4c61-41f5-8cf0-69a1233704ba@nvidia.com>
 <CABVzXAma4T+=meTSRNKhq70w4imc=A5imy2zofX2ndJz-XVByg@mail.gmail.com>
 <adf195c4-6d7e-47ff-ac62-dc4c0f463f21@nvidia.com>
 <CABVzXA=wov8OgADXbDiVVnhncc=zgET4MAGd3H1pr26XS38JBw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="/GfPDIWRVRf+fPhY"
Content-Disposition: inline
In-Reply-To: <CABVzXA=wov8OgADXbDiVVnhncc=zgET4MAGd3H1pr26XS38JBw@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15


--/GfPDIWRVRf+fPhY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 30, 2024 at 06:45:23PM -0700, Daniel Verkamp wrote:
> From my point of view, it would be fine to clarify a few things:
> - blk_size should (not must) be the logical block size of the
> underlying storage device
> - data should (not must) be a multiple of blk_size for best performance
>=20
> And maybe:
> - devices may choose to return IOERR if a driver submits an I/O
> request that does not conform to the above recommendations (but this
> conflicts with the "performance"-related wording that exists now)

QEMU's virtio-blk implementation returns IOERR when the driver submits
VIRTIO_BLK_T_IN/VIRTIO_BLK_T_OUT requests that are not aligned to the
logical block size:
https://gitlab.com/qemu-project/qemu/-/blob/master/hw/block/virtio-blk.c#L3=
67

Although I interpret the virtio-blk spec in the same way as you
(blk_size is just a hint for optimal performance), I guess in practice
drivers align requests to blk_size.

Adding a note that devices may return IOERR is worthwhile. It will tell
driver authors not to expect device implementations to accept misaligned
requests.

Stefan

--/GfPDIWRVRf+fPhY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmb9TbkACgkQnKSrs4Gr
c8hVXwf/XRz+4IQYbND7w3zKaqA2UAKcd0tOkCNArVI/HjDh9w2iwGRJbpJYyfU7
5uU4pebhzlOU4jXQ1lpeYUgC5cCOa6bqb7SgGkJi1eDlgCNP1nTfSdo+6t9GfNe9
yo7Ue+E/2GsyyPDRJOheDuZ9J4CuZke3nSegR9+HwoVYYrPcbN4OaW53KwAtA45v
epkUJwfkKgqvPtwH98Y3bz9ZH/6t/AnC86OMrmUcMYnIFQAGO3kkY56uUWpdy7AL
bDFt3TjGf4D9EqtNPPZ2upoU0OBg0sxrmV6Fx0LUhUbZVgSA31U2DnQ+Ns32FT6h
x/kJlNxseGdYlOs4RuG5cKqACAQ5UA==
=wAnB
-----END PGP SIGNATURE-----

--/GfPDIWRVRf+fPhY--

