Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B8561ADC85
	for <virtualization@lists.linux.dev>; Thu, 23 Jan 2025 20:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737662416; cv=none; b=pUEGjymrZhtm0GrKZ4VMRgsC5sYvRa48aIPzv/V3fetFIiA5/ZGpIoBXCJFC9W99dRtBMmGPjSU9M4ZDY3pX3VyAjMEXNBSBB1iTqM7EPLewPJCz8B4Q3Bj8+iMR5hnPwead2n/iAbDG0PiZ2PSxUuD33B4OMTAMwreQRAI7Agc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737662416; c=relaxed/simple;
	bh=ccchkg54xM3AXV7CPGq2n8b881J16v+c23V9c8T46xk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VyNzisxawtUhvnupdcvC2wXmxu7mBPNkCzWVTf23B2rg/t6chOBErsjn9Tq3n0SHyTJkBuNZR8yhgRftFrAl8jtfG6x8N3MAtt16xff0p6wKftB87aJJMQkfptbTyNl17+PcCwb3VU3EWRfKWL0XJu2uujqqlEdlajue4Dj022E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Bd/mPboq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bd/mPboq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737662413;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ccchkg54xM3AXV7CPGq2n8b881J16v+c23V9c8T46xk=;
	b=Bd/mPboqzq917oG/ZiQ74CbKEnfHua/flcpphsWTub+nGLTzzGsa7GFGP5YGdRYwcFyU0a
	jQwuBcsA8DngYEai1fh7hYypRFpR4OxYsoMboriRIbPQ4phuBzG92mC15purtp1PLPNflz
	xu1pKSHbXsS3Pb7cZwlai22AXEVTpCI=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-57-r3vJYF2kOt2oRZDC08iwcw-1; Thu,
 23 Jan 2025 15:00:09 -0500
X-MC-Unique: r3vJYF2kOt2oRZDC08iwcw-1
X-Mimecast-MFC-AGG-ID: r3vJYF2kOt2oRZDC08iwcw
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 800821955DCB;
	Thu, 23 Jan 2025 20:00:08 +0000 (UTC)
Received: from localhost (unknown [10.2.17.59])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 274853003E7F;
	Thu, 23 Jan 2025 20:00:06 +0000 (UTC)
Date: Thu, 23 Jan 2025 15:00:06 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, mst@redhat.com,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	Hanna Reitz <hreitz@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	German Maglione <gmaglione@redhat.com>
Subject: Re: [PATCH] vduse: add virtio_fs to allowed dev id
Message-ID: <20250123200006.GB238888@fedora>
References: <20250121103346.1030165-1-eperezma@redhat.com>
 <20250122154908.GB178738@fedora>
 <CACGkMEtdMzr1chpneCTnpjHFKaN5YSZbsVjSLtHSt+ULpUHG4g@mail.gmail.com>
 <CAJaqyWdC-Tte+ao6pk22fq-mUym8C9guQFThSnG5gMxWNqWyXw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="eIh4olyubDqwvDA0"
Content-Disposition: inline
In-Reply-To: <CAJaqyWdC-Tte+ao6pk22fq-mUym8C9guQFThSnG5gMxWNqWyXw@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4


--eIh4olyubDqwvDA0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 23, 2025 at 08:26:57AM +0100, Eugenio Perez Martin wrote:
> On Thu, Jan 23, 2025 at 2:50=E2=80=AFAM Jason Wang <jasowang@redhat.com> =
wrote:
> >
> > On Wed, Jan 22, 2025 at 11:49=E2=80=AFPM Stefan Hajnoczi <stefanha@redh=
at.com> wrote:
> > >
> > > On Tue, Jan 21, 2025 at 11:33:46AM +0100, Eugenio P=C3=A9rez wrote:
> > > > A VDUSE device that implements virtiofs device works fine just by
> > > > adding the device id to the whitelist.
> > >
> > > The virtiofs DAX Window feature might require extra work. It is not
> > > widely enabled though, so must virtiofs devices will work fine with j=
ust
> > > virtqueue and configuration space support.
> >
> > +1.
> >
> > The DAX Window may help to reduce the bounce buffer copying and fit
> > for the case where an AI application just accesses one single large
> > file.
> >
> > We need to consider implementing this via VDUSE.
> >
> > Thanks
> >
> >
>=20
> I thought DAX can only be applied in the VM case. Is it possible to
> apply it using virtio_vdpa?

Hardware could implement the DAX Window feature. In virtio-pci it's
implemented as a range within a BAR on the PCI device.

> Is it possible to detect that the device is trying to use DAX so it
> fails the negotiation?

Yes, DAX is optional. It's only available when the device reports a
Shared Memory Region with ID 0:
https://github.com/oasis-tcs/virtio-spec/blob/master/device-types/fs/descri=
ption.tex#L233

Just to let you know, the QEMU vhost-user implementation of the DAX
Window is not complete. In the past David Gilbert had out-of-tree
patches to enable it in QEMU.

The guest driver support is in Linux.

Stefan

--eIh4olyubDqwvDA0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmeSn8UACgkQnKSrs4Gr
c8ihVAf+JTUE11Fdx20jO2oLb9js62qQg2RyGp4HLBFVTrTNfIThk9oxBLYmqJUd
FfcPXKaOei/ildxs/afpNFPPLYYDLxSmcs2EqyxU9UArVcN7DnEb+EqjUvph9NA9
qPhhZh/vULjFQB+3hTUSFSdIlOsKqFuvmdGfH4/vUxMs9eGYbrr0iDcr3tauRV7Y
nyPoRz1HprUQLVb5gQ78JBunjqVcOQ5mhiKERxwBGDRCmYEbZ3KVqWvHVUNEwyR0
rlFaFClKUZuPhU7MbIYGbnTevzDUx2X9R+6avN3kYVOnhLUU9+1ZDqQrx9M2noIg
hF2LOX7mM4oHR1sNfebn5ehArAIvHA==
=3Yyv
-----END PGP SIGNATURE-----

--eIh4olyubDqwvDA0--

