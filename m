Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6BB23FDC04
	for <virtualization@lists.linux.dev>; Mon, 15 Jun 2026 14:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781535186; cv=none; b=i9946G69Mg71kuQgqkg9S2tLcgux7qaZXNBlzp3Wj9oQ6a2WYI5dfeG901SNQRb0nuW3Z39lgUnwaL1EawqmGSemQykcqbZ1t7TMxtD46LolaA+aJXXid4llSF0u23FJJGnMctqzyl6mq9xfG08gs43MSmPef2sQo8pAEELg3z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781535186; c=relaxed/simple;
	bh=FufpY6m8LYjL6hzb1N0QB92mo8HHNnJndS3rAEcI+nM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gDkYvwqwjy3UsNimQjg+homsq/keBzPyBwOUD2c6ZuYB3n6NEv0GMAG7QwW4x399Jv7xdi8u/LPoYq6h6zXzU5EL2rd89CCGxuyjirEWXJFunexiFDtlWc9wAed/9jwLtLar4RI3ShwAVJWHKzBDf7CQGtv5ixRMhG597Wdljic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OKAFtX2Y; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OKAFtX2Y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781535184;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=D2U/rVXVdMp49YF1Mi2vsTuL7+1i+LvINM+38VWReC0=;
	b=OKAFtX2Ya0z7W9uGP0B2HMKJvkyr2iD2+SneUjoA2hE5eTCeehMKzd6qgXPIipbpxSfEKh
	7/YA1kkuNSrUkfSq/BZbzwYN+EOBzx5/jNh38Rs1hmG3gCWBHQko+GMmccPTnlTYPKPKQO
	qaKutVogExoW1haF+FnhVnfva8eUZLM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-68-2MkfMIgzO42hbt2o6bB03g-1; Mon,
 15 Jun 2026 10:52:59 -0400
X-MC-Unique: 2MkfMIgzO42hbt2o6bB03g-1
X-Mimecast-MFC-AGG-ID: 2MkfMIgzO42hbt2o6bB03g_1781535177
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 74F8F1800581;
	Mon, 15 Jun 2026 14:52:56 +0000 (UTC)
Received: from localhost (unknown [10.2.16.187])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3DBA719541B2;
	Mon, 15 Jun 2026 14:52:54 +0000 (UTC)
Date: Mon, 15 Jun 2026 10:52:53 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Xixin Liu <liuxixin@kylinos.cn>
Cc: linux-block@vger.kernel.org, virtualization@lists.linux.dev,
	mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, pbonzini@redhat.com, axboe@kernel.dk,
	linux-kernel@vger.kernel.org, Parav Pandit <parav@nvidia.com>
Subject: Re: [PATCH v1 0/2] virtio: PCI ERS permanent failure teardown for
 virtio-blk
Message-ID: <20260615145253.GA448916@fedora>
References: <cover.virtio-blk-ers-v1.1780449274.git.liuxixin@kylinos.cn>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rDjPuhbpsEQh05PT"
Content-Disposition: inline
In-Reply-To: <cover.virtio-blk-ers-v1.1780449274.git.liuxixin@kylinos.cn>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17


--rDjPuhbpsEQh05PT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 15, 2026 at 10:00:00AM +0800, Xixin Liu wrote:
> Hi,
>=20
> This series adds proper PCI AER error recovery handling for virtio-pci and
> completes virtio-blk teardown when ERS reports pci_channel_io_perm_failur=
e.

CCing Parav because he previously looked at surprise removal:
https://lore.kernel.org/virtualization/20250822091706.21170-1-parav@nvidia.=
com/

>=20
> virtio-pci only registered reset_prepare/reset_done.  The recovery core
> treats devices without error_detected as NO_AER_DRIVER and does not
> deliver perm_failure to the driver after a failed recovery.  When bus
> reset fails (reproduced on QEMU with DLLLA not set within 100 ms after
> secondary bus reset), virtio-blk disks stay live even though virtqueues
> may already have been torn down during the frozen phase.
>=20
> Patch 1 registers error_detected (frozen quiesce + perm_failure notify).
> Patch 2 calls the virtio driver shutdown hook from virtio-pci on
> perm_failure, implements virtio-blk shutdown with blk_mark_disk_dead(),
> and fail-fast guards in virtio_queue_rq.
>=20
> Thanks,
> Xixin Liu
>=20
> ---
>=20
> Xixin Liu (2):
>   virtio-pci: add error_detected for PCI AER recovery
>   virtio-blk: mark disk dead on ERS permanent failure
>=20
>  drivers/block/virtio_blk.c         | 39 +++++++++++++++++++++++++++++++
>  drivers/virtio/virtio_pci_common.c | 47 ++++++++++++++++++++++++++++++++=
++
>  2 files changed, 85 insertions(+)
>=20
> --=20
> 2.43.0
>=20

--rDjPuhbpsEQh05PT
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmowEcUACgkQnKSrs4Gr
c8i72AgApJ/ZOOsKjhY+6etWszyoXg4UHVtUMfpo9KefImYgFeCUbW4oryCmQwPU
jYsDMDkgj6aZVYgeIEoMUMJaUQRO0ZhPska/ce2nttNr+/uMEtSmCqPVDV0Yk1Wl
qOmtu2NAR/5kRRdA795tGCfmRm0FyFnZqR+ZuRnuJqzMvgS4uB087kEUqwd7X1KE
kWtf+tbt9UwshgXtaT/yJGH3oH8s5l9PVWJGpzOXJN30xBvS4I7zGtnFG0jGba5c
H695VZfVJlFYyMERJRkJxnaesIYG9vuOESzacM8GHwm9dosyYfbNWhX4RHy3nBPP
QGsCvLuNxwzdrUXH1L/IeCYTx/f9Fg==
=zDKi
-----END PGP SIGNATURE-----

--rDjPuhbpsEQh05PT--

