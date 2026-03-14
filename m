Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AD3E171CD
	for <virtualization@lists.linux.dev>; Sat, 14 Mar 2026 07:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773472841; cv=none; b=U01BOjlrsF5wi5MLYJsnrd0D6TtB1CcOCLlHrve7bWbGEZitmiZlCgQlZ6uPW36QjBWcVy6+fMoNGMsVU/m2iALqw/X5b0TSoY8kQfP0UB0NwDBNKT0JGW6b1Bwyk7C0nvvj6xU0pkwmkGuC0enl4PTmKM1voK6WUQOE09Jog8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773472841; c=relaxed/simple;
	bh=t/PTsRRpIExApp4uv3dKuJwh4n2QEvtlwiiSJkVsAh4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GbMvWqSYi1QWpIcdJxy1w2H+h4JjdYZQK/g/FuX2paznunBB2/fnXjJI3/wTLsopGfCQHH/oJkgzYj/eGQ0SrTOmUchLtIMvMnUH8keCukNqy7FMUN1BRh402LhFNOPlfx4OIEJ03rhpCVNWrSu5ycJhVmywbNhbmXi2TazcfwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dfiLNbB+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dfiLNbB+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773472839;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rXdKo12x/Jr6Fll11RDNXkcPZxIehzNuFjxN4eQSKIA=;
	b=dfiLNbB+fdmn6lvF+eqbWMdcUCx8b9xf4KjofFUcYpwNTwJPVFaHQyZYluYVV60ebPqACJ
	6MqqC6DLRX61z1RNs/7Pzo9CTc5A76FQ/8EClgh7F4dMRL5XPKT3wK/ErGcsoOtjn6IL2Y
	YICYxpqJOimZBtPWlEu5tmAMVZkrRJ8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-350-lvRvehhkN9GdXxWPP98OSQ-1; Sat,
 14 Mar 2026 03:20:37 -0400
X-MC-Unique: lvRvehhkN9GdXxWPP98OSQ-1
X-Mimecast-MFC-AGG-ID: lvRvehhkN9GdXxWPP98OSQ_1773472835
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4EF0C1955E7B;
	Sat, 14 Mar 2026 07:20:35 +0000 (UTC)
Received: from localhost (unknown [10.44.32.10])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C86B519560B7;
	Sat, 14 Mar 2026 07:20:33 +0000 (UTC)
Date: Sat, 14 Mar 2026 15:10:14 +0800
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Joshua Daley <jdaley@linux.ibm.com>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev, mst@redhat.com, jasowang@redhat.com,
	pbonzini@redhat.com, eperezma@redhat.com,
	James.Bottomley@hansenpartnership.com, martin.petersen@oracle.com,
	mjrosato@linux.ibm.com, farman@linux.ibm.com, frankja@linux.ibm.com
Subject: Re: [PATCH v2 0/3] scsi: virtio_scsi: move INIT_WORK calls to
 virtscsi_init
Message-ID: <20260314071014.GC228741@fedora>
References: <20260312174256.1557045-1-jdaley@linux.ibm.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="WYTOjO8ZzIyK8bAe"
Content-Disposition: inline
In-Reply-To: <20260312174256.1557045-1-jdaley@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12


--WYTOjO8ZzIyK8bAe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 12, 2026 at 06:42:53PM +0100, Joshua Daley wrote:
> Changelog v1 -> v2:
>=20
> - Added 2 additional patches:
>   - [PATCH v2 1/3] scsi: virtio_scsi: kick event_list unconditionally
>     - Removes the conditions surrounding event_list operations (suggested=
 by Stefan Hajnoczi <stefanha@redhat.com>)
>   - [PATCH v2 2/3] scsi: virtio_scsi: remove unnecessary fn declaration
>     - Removes virtscsi_handle_event() prototype (suggested by Eric Farman=
 <farman@linux.ibm.com>)
>=20
> - [PATCH 1/1] -> [PATCH v2 3/3] scsi: virtio_scsi: move INIT_WORK calls t=
o virtscsi_init
>   - Removed the condition surrounding INIT_WORK calls
>=20
> -----
>=20
> v1 cover letter:
>=20
> This patch avoids a kernel warning that may occur if a virtio_scsi
> controller is detached immediately following a disk detach. See the
> commit message for details. The following are instructions to
> produce the warning (without the proposed patch).
>=20
> Timing matters--if all event work items call INIT_WORK before they are
> flushed by cancel_work_sync, then the warning will not occur.
>=20
> The warning will occur consistently if a sleep is added in
> virtscsi_kick_event before the INIT_WORK call, like so:
>=20
> #include <linux/delay.h>
>=20
> static int virtscsi_kick_event(struct virtio_scsi *vscsi,
> 			       struct virtio_scsi_event_node *event_node)
> {
>     int err;
>     struct scatterlist sg;
>     unsigned long flags;
>=20
>  -> msleep(1000);
>     INIT_WORK(&event_node->work, virtscsi_handle_event);
> =09
>     ...
> }
>=20
> Then, just detach a disk and its controller in quick succession:
>=20
> virsh detach-device --domain <domain> disk.xml; \
> virsh detach-device --domain <domain> controller.xml
>=20
> where disk.xml and controller.xml are text files containing the XML
> of the disk and controller.
>=20
> Or, with the libvirt python module:
>=20
> domain.detachDevice(str(disk_xml))
> domain.detachDevice(str(controller_xml))
>=20
> Joshua Daley (3):
>   scsi: virtio_scsi: kick event_list unconditionally
>   scsi: virtio_scsi: remove unnecessary fn declaration
>   scsi: virtio_scsi: move INIT_WORK calls to virtscsi_init
>=20
>  drivers/scsi/virtio_scsi.c | 17 ++++++-----------
>  1 file changed, 6 insertions(+), 11 deletions(-)
>=20
> --=20
> 2.34.1
>=20

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--WYTOjO8ZzIyK8bAe
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmm1CdYACgkQnKSrs4Gr
c8h9KAf/QCbuxUeaie7jggLTGXKUAfQYQXGXCBY+zRxNU/KYrd5bEHAiSLCAsGLB
hfBghN3pzBBAcRxMyBKSzt1e5dRWHuEMi4dQcYbTuNqmkSAO0bR4mpJOGuqTr3kG
dmcGzKqifIyO4rJKgaKqxOChr5JZ8EQzDzb3pzr5CkJhUezNJXROIMXxRP42rmeN
gZ2WMWpRM32Uy/tv3WB7naNZ4zJGFww4gUXjsUuB7ouCRqYydPwlCfVIUJ9iQQes
GIT3MfeUV+kCv630UHOHyMRA66887jGn86oPJBuuDx0yQK/hUqfG7F2o+Lbm9MAy
8cXuCVNd6cxLKENws2dLeA8V7FPIgA==
=43XC
-----END PGP SIGNATURE-----

--WYTOjO8ZzIyK8bAe--

