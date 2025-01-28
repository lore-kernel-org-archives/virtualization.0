Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0A67192B85
	for <virtualization@lists.linux-foundation.org>; Tue, 28 Jan 2025 18:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738090617; cv=none; b=G9phLvuYhkkqcr4L8mnbY5uifgG+c+3+1csGYGrM1jybVu2Kx/Ay9DkWB0dCRpjrZMKXv118Dd+875/aGY5ME5ju7kwWXZ2Yo3KvgNbtZ3Q7pr3JVUK/B89/PX/NQondODgihIeqzAYWndy3/tIkSq6XTnDhHpwXKxVHsp5sPg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738090617; c=relaxed/simple;
	bh=kA/6iMxvQcrMkvhuJbymzF4nJn7aft2i6K4wCVXeNJ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=etBjIZdZspPy7u6ZffAysTweNNT7cf3iYVgBEU+/Yjgz9poXc0ZTD5uUI3g8+uAb9Nh3+QXYMfZlgpITQ8W2xA4ywb7Xw47G63sMJ5usEo87dwj2nIZiA4G+1PARh70CPUVzvkV2Fr3crMXToRFIkPP0ssGedNp2317a9q+uwmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QCLCipNP; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QCLCipNP"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5D82541147
	for <virtualization@lists.linux-foundation.org>; Tue, 28 Jan 2025 18:56:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.79
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1K49jDU_M_i9 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Jan 2025 18:56:54 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=stefanha@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org CC9DF410E6
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org CC9DF410E6
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=QCLCipNP
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp4.osuosl.org (Postfix) with ESMTPS id CC9DF410E6
	for <virtualization@lists.linux-foundation.org>; Tue, 28 Jan 2025 18:56:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738090611;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ExNnQG+lk/UWVeUvit4brzaFYeACEnAk3RmPvJafghs=;
	b=QCLCipNPTVTCQeh4+ADAge287mLQHOdXh033sst5GYh0Q/7lUMJmj399mtZ05S79vfpbj8
	q89mYQARWeyrZpnWFLRk0clR+7Wc1otWShRtx16laMBsA+vii8sj1lFQhBRXn7XSSuy+Id
	J1IjnVJnai5I4Pd5mvUul8EZjbIXonU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-67-g9Q4ImWIPA2g5ZZbYIQVAQ-1; Tue,
 28 Jan 2025 13:56:50 -0500
X-MC-Unique: g9Q4ImWIPA2g5ZZbYIQVAQ-1
X-Mimecast-MFC-AGG-ID: g9Q4ImWIPA2g5ZZbYIQVAQ
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id ACC691800360;
	Tue, 28 Jan 2025 18:56:48 +0000 (UTC)
Received: from localhost (unknown [10.2.16.195])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 74E791800348;
	Tue, 28 Jan 2025 18:56:47 +0000 (UTC)
Date: Tue, 28 Jan 2025 13:56:46 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Mike Christie <michael.christie@oracle.com>
Cc: jasowang@redhat.com, mst@redhat.com, sgarzare@redhat.com,
	pbonzini@redhat.com, wh1sper@zju.edu.cn,
	virtualization@lists.linux-foundation.org
Subject: Re: [PATCH 1/1] vhost-scsi: Fix handling of multiple calls to
 vhost_scsi_set_endpoint
Message-ID: <20250128185646.GA111681@fedora>
References: <20250121213125.140333-1-michael.christie@oracle.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="mCwxwHaANCpjLS0V"
Content-Disposition: inline
In-Reply-To: <20250121213125.140333-1-michael.christie@oracle.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111


--mCwxwHaANCpjLS0V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 21, 2025 at 03:31:25PM -0600, Mike Christie wrote:
> If vhost_scsi_set_endpoint is called multiple times without a
> vhost_scsi_clear_endpoint between them, we can hit multiple bugs
> found by Haoran Zhang:
>=20
> 1. Use-after-free when no tpgs are found:
>=20
> This fixes a use after free that occurs when vhost_scsi_set_endpoint is
> called more than once and calls after the first call do not find any
> tpgs to add to the vs_tpg. When vhost_scsi_set_endpoint first finds
> tpgs to add to the vs_tpg array match=3Dtrue, so we will do:
>=20
> vhost_vq_set_backend(vq, vs_tpg);
> ...
>=20
> kfree(vs->vs_tpg);
> vs->vs_tpg =3D vs_tpg;
>=20
> If vhost_scsi_set_endpoint is called again and no tpgs are found
> match=3Dfalse so we skip the vhost_vq_set_backend call leaving the
> pointer to the vs_tpg we then free via:
>=20
> kfree(vs->vs_tpg);
> vs->vs_tpg =3D vs_tpg;
>=20
> If a scsi request is then sent we do:
>=20
> vhost_scsi_handle_vq -> vhost_scsi_get_req -> vhost_vq_get_backend
>=20
> which sees the vs_tpg we just did a kfree on.
>=20
> 2. Tpg dir removal hang:
>=20
> This patch fixes an issue where we cannot remove a LIO/target layer
> tpg (and structs above it like the target) dir due to the refcount
> dropping to -1.
>=20
> The problem is that if vhost_scsi_set_endpoint detects a tpg is already
> in the vs->vs_tpg array or if the tpg has been removed so
> target_depend_item fails, the undepend goto handler will do
> target_undepend_item on all tpgs in the vs_tpg array dropping their
> refcount to 0. At this time vs_tpg contains both the tpgs we have added
> in the current vhost_scsi_set_endpoint call as well as tpgs we added in
> previous calls which are also in vs->vs_tpg.
>=20
> Later, when vhost_scsi_clear_endpoint runs it will do
> target_undepend_item on all the tpgs in the vs->vs_tpg which will drop
> their refcount to -1. Userspace will then not be able to remove the tpg
> and will hang when it tries to do rmdir on the tpg dir.
>=20
> 3. Tpg leak:
>=20
> This fixes a bug where we can leak tpgs and cause them to be
> un-removable because the target name is overwritten when
> vhost_scsi_set_endpoint is called multiple times but with different
> target names.
>=20
> The bug occurs if a user has called VHOST_SCSI_SET_ENDPOINT and setup
> a vhost-scsi device to target/tpg mapping, then calls
> VHOST_SCSI_SET_ENDPOINT again with a new target name that has tpgs we
> haven't seen before (target1 has tpg1 but target2 has tpg2). When this
> happens we don't teardown the old target tpg mapping and just overwrite
> the target name and the vs->vs_tpg array. Later when we do
> vhost_scsi_clear_endpoint, we are passed in either target1 or target2's
> name and we will only match that target's tpgs when we loop over the
> vs->vs_tpg. We will then return from the function without doing
> target_undepend_item on the tpgs.
>=20
> Because of all these bugs, it looks like being able to call
> vhost_scsi_set_endpoint multiple times was never supported. The major
> user, QEMU, already has checks to prevent this use case. So to fix the
> issues, this patch prevents vhost_scsi_set_endpoint from being called
> if it's already successfully added tpgs. To add, remove or change the
> tpg config or target name, you must do a vhost_scsi_clear_endpoint
> first.
>=20
> Fixes: 25b98b64e284 ("vhost scsi: alloc cmds per vq instead of session")
> Fixes: 4f7f46d32c98 ("tcm_vhost: Use vq->private_data to indicate if the =
endpoint is setup")
> Reported-by: Haoran Zhang <wh1sper@zju.edu.cn>
> Closes: https://lore.kernel.org/virtualization/e418a5ee-45ca-4d18-9b5d-6f=
8b6b1add8e@oracle.com/T/#me6c0041ce376677419b9b2563494172a01487ecb
> Signed-off-by: Mike Christie <michael.christie@oracle.com>
> ---
>  drivers/vhost/scsi.c | 20 +++++++++++---------
>  1 file changed, 11 insertions(+), 9 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--mCwxwHaANCpjLS0V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmeZKG4ACgkQnKSrs4Gr
c8h4awf/f3D9tZIIkF6oSJIg09RNQFAvvk2eECd0vJH1Y70mtmmit3qTsxPsDdrD
ibuqLhbuqSCPY3zwrzeNNW2Zz0Y9scKwMO7PMmlf6wo1h2yLJseGB+B9stLM320H
yr9eFwajh/A13OiHI4z6JGbMcjZJgo49O4jeqhMnqy4mFaB6A0N4afI+Li3wVuE9
Kt4uhg1rbVF92YiL/S9XGxM20ownlZe1UqFUJFKR2r4Le+MdvJQC/QxHGP2J4PTJ
r+UbFr42OHI4XgB7IF+NjXVk9GcLf/fuWWDacqKwJpeIU64r9oUYgKbTcGqTi+i+
HUsyICEEXYmkKdsT6s2zCtSMTs2Gxw==
=nIYt
-----END PGP SIGNATURE-----

--mCwxwHaANCpjLS0V--

