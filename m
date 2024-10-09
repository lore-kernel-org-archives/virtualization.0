Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5FAC1E32DC
	for <virtualization@lists.linux-foundation.org>; Wed,  9 Oct 2024 15:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728486641; cv=none; b=Gox5A+233Kg/FSlrNOeuGDKTaq7uq1LgDPDQJRumhU+r7fKfU7yk2zxTmivuQz3uvG3m5KuLEOcdGuzKhSK0Jz1KS3AJO89cT037vD/TqZyDRCdfBPjAUpJjGFegj4JUKTuGLqg2bLnQ8r9irrvaqUCESc5AMYH74FNj65zc15o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728486641; c=relaxed/simple;
	bh=wWb76VitBSStfqv1z9LLk+iqqyYHXd2+1MYeZq9n/Fw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FSRplvyt1xlRSpbE/XTlwANwvnU/s9LHcCXFdmJ6RzV9+iFefiTms72QSIQedHPctbHftGDHdUZQu0V7RqOwIfcZZVFGuhL9KTT8wl/8fGL3CqI5iwh22CpbS1cBiTkh4CDfC64rwNF67N55Uqe5eGY+84PqVmnMJGkpdn5L3/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Lk9MFlw9; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lk9MFlw9"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5277740720
	for <virtualization@lists.linux-foundation.org>; Wed,  9 Oct 2024 15:10:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.79
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Drc6FIdzJTDr for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Oct 2024 15:10:38 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=stefanha@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 17743406D0
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 17743406D0
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Lk9MFlw9
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 17743406D0
	for <virtualization@lists.linux-foundation.org>; Wed,  9 Oct 2024 15:10:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728486636;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9m/alfM29a3UUcEhOir6FOHIK40dS3QONXOJymAw7CU=;
	b=Lk9MFlw9UkJZMDq2XqMT8bGulBsz3ffzq9zIBSrB3DNJhw9k12vOxqvSe88Ulq49jOnmU9
	2/nZAA3VbqHRTrdjRPB4KmvTyCo4Jy/tnYoTOupS+yD5unxwwiMiMQqWssImXWwc0LnW/B
	n7GsvwqFC7B8eg+SBU3yJCSrROwfOh0=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-622-w3kpA6exOhmd_Phw6w4sbQ-1; Wed,
 09 Oct 2024 11:10:34 -0400
X-MC-Unique: w3kpA6exOhmd_Phw6w4sbQ-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4044319560BF;
	Wed,  9 Oct 2024 15:10:32 +0000 (UTC)
Received: from localhost (unknown [10.2.16.253])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 64D7819560A2;
	Wed,  9 Oct 2024 15:10:31 +0000 (UTC)
Date: Wed, 9 Oct 2024 11:10:24 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Cc: dverkamp@chromium.org, mst@redhat.com,
	virtualization@lists.linux-foundation.org,
	virtio-dev@lists.linux.dev, oren@nvidia.com, parav@nvidia.com
Subject: Re: [PATCH v2 1/1] virtio-blk: Add description for blk_size field
Message-ID: <20241009151024.GB45445@fedora.redhat.com>
References: <20241006165609.34953-1-mgurtovoy@nvidia.com>
 <20241008201502.GB22682@fedora.redhat.com>
 <1389ad0b-89b0-4e50-b07d-02bd6141fc7d@nvidia.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="vDnmv+mMksfPPYWs"
Content-Disposition: inline
In-Reply-To: <1389ad0b-89b0-4e50-b07d-02bd6141fc7d@nvidia.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12


--vDnmv+mMksfPPYWs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 09, 2024 at 01:46:17AM +0300, Max Gurtovoy wrote:
>=20
> On 08/10/2024 23:15, Stefan Hajnoczi wrote:
> > On Sun, Oct 06, 2024 at 07:56:09PM +0300, Max Gurtovoy wrote:
> > > This field is only valid when the VIRTIO_BLK_F_BLK_SIZE feature bit is
> > > offered by the device.
> > >=20
> > > The blk_size field actually represents the logical block size of the
> > > device. It is always a power of two and typically ranges from 512 byt=
es
> > > to larger values such as 4 KB.
> > >=20
> > > Add description for this field to provide clarity on its constraints.
> > >=20
> > > Signed-off-by: Max Gurtovoy<mgurtovoy@nvidia.com>
> > > ---
> > >=20
> > > changes from V1:
> > >   - Addressed Stefan's and Daniel's comments:
> > >         1. use SHOULD instead of MUST
> > >         2. Add a note that devices may return IOERR upon misaligned IO
> > >   - Add a note that devices may return IOERR if IO size is not follow=
ing
> > >     the block size granularity.
> > > ---
> > >   device-types/blk/description.tex | 34 +++++++++++++++++++++++++++++=
+++
> > >   1 file changed, 34 insertions(+)
> > Reviewed-by: Stefan Hajnoczi<stefanha@redhat.com>
>=20
> I'll add both yours and Daniel's Reviewed-by signatures and fix a small
> comment from Daniel.
>=20
> Can you please remind me the next step I should do ?
>=20
> Should I open an issue at the oasis github and mention it as "Fixes: " in
> the commit message ?

The GitHub repo is here:
https://github.com/oasis-tcs/virtio-spec

The instructions for requesting a vote on a spec patch are:

  To request a TC vote on resolving a specific comment:

  1. Create a github issue, or edit an existing issue, with a short summary=
 of the comment. The issue MUST specify the link to the latest proposal in =
the TC mailing list archives. Note: the link MUST be in the issue descripti=
on itself - not in the comments.
  2. Reply by email to the comment email, requesting that the TC vote on re=
solving the issue. The mail requesting the vote should include the followin=
g, on a line by itself:

    Fixes: https://github.com/oasis-tcs/virtio-spec/issues/NNN
    (NNN is the issue number)
  3. Please make sure to allow time for review between posting a comment an=
d asking for a vote.

Thanks,
Stefan

--vDnmv+mMksfPPYWs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmcGnOAACgkQnKSrs4Gr
c8gU8AgAjFIH6XzL/B9NQvcoUTRC73DB4sC89GA4oNVmv8t/G2nNNChX6Q6zfIpV
tqUmVOOedXmgnRm6Ni4lotxZH8Rz7pzAGfMuc0/YxQHbRzvm/yrAOMp7EJJSnbJB
BqkNR221dJbggHprzlbiVYIprMjtYChMXRNv8+1S70zUJ2Q8eO54K+Ohqhz2cI76
s79EBZOTdpa9vYGnyRBmlmlVRC1MoSTWMLS4/Ztz6rTcc8zGT5LbfKwtB/36Ps+H
AlOCChxjRuQBtmvDWdKnt3ut5GQJPBFALnEPPA/5UqW/z2vvLCHL2+qx9hfB2eVW
PzocjzeQmkajgq+N22E77woNBgqHAw==
=F0Qh
-----END PGP SIGNATURE-----

--vDnmv+mMksfPPYWs--

