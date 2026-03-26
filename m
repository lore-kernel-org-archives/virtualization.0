Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BD3733ADBC
	for <virtualization@lists.linux.dev>; Thu, 26 Mar 2026 18:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774550832; cv=none; b=WRCSEOvC7mUep/gXCA5xHnRYtb5UepyF+xzR5tTjOCfdJiXEfJbuLPpOsSMwG39IHbQ/gwWb5ReS+sKBFDa4fIXn6b9dn7d3WIlCGf9+U9KQBFeJX5Trw7Xxo+KHJ1B6YoDz6d1zlJtGoHuBATMyQaSypPORTCVm56ht7qGTL9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774550832; c=relaxed/simple;
	bh=TWRNloUI5ksdVwpJ9OmfbODDYfbcIkidacFgaKlGsUk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jG1xTCIgWEhre+sXP3kvNkXH+NsfMGdlX4ubV+VTru4EonII+EYaVbSXiCFhQnd/UDEb2pJpJlWBynAD7Buktj0XVbSiRIjhMMMRN5N7z0ZhB4RbSbVvlrjVfOFbFXZN+g2hMOzjdC7cFcKu4ICYpFUfBSepVsN5udM0uNGNE/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DUJZJXng; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DUJZJXng"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774550829;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yE8JUtvbmXHARIohIvidV3ET2MUaAUrusGqQMCjaVTE=;
	b=DUJZJXngTxwI0OOd7CqpRKz09b3GPIiU9BdH5rEVjpv6MnxVtywMq4K2KEiYkQGP0oSLpi
	BNDE8Vu8t2iVvHiJQLMWl28EWpBQF4PphYkOmGNHU61Oxb2o3CWKamK2C+hhgBndHFsuFP
	jXn7JM/NutCRiwF0bflUA6002sXs8go=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-294-yhG4m0WbMwm9kilIRKqJTQ-1; Thu,
 26 Mar 2026 14:47:06 -0400
X-MC-Unique: yhG4m0WbMwm9kilIRKqJTQ-1
X-Mimecast-MFC-AGG-ID: yhG4m0WbMwm9kilIRKqJTQ_1774550825
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E335518002D7;
	Thu, 26 Mar 2026 18:47:04 +0000 (UTC)
Received: from localhost (unknown [10.45.224.109])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7032118001FE;
	Thu, 26 Mar 2026 18:47:02 +0000 (UTC)
Date: Thu, 26 Mar 2026 14:47:01 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Li Wang <liwang@kylinos.cn>
Cc: German Maglione <gmaglione@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	virtualization@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	Yuto Ohnuki <ytohnuki@amazon.com>
Subject: Re: [PATCH] [PATCH v2] virtiofs: Strengthen FUSE protocol validation
 for server responses
Message-ID: <20260326184701.GA6926@fedora>
References: <20260323081455.38007-1-liwang@kylinos.cn>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fcP6Pyzv2wa0PELW"
Content-Disposition: inline
In-Reply-To: <20260323081455.38007-1-liwang@kylinos.cn>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93


--fcP6Pyzv2wa0PELW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 23, 2026 at 04:14:54PM +0800, Li Wang wrote:
> 1. We should not trust the length value provided by the server;
> 2. Only replies have an out header/argbuf data to parse;
> 3. Some minor refinements for performance and log throttling.
>=20
> Signed-off-by: Li Wang <liwang@kylinos.cn>
> ---
>  fs/fuse/virtio_fs.c | 28 ++++++++++++++++++----------
>  1 file changed, 18 insertions(+), 10 deletions(-)

CCing Yuto Ohnuki since this touches their recent work.

>=20
> diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
> index 2f7485ffac52..c3f7f472f517 100644
> --- a/fs/fuse/virtio_fs.c
> +++ b/fs/fuse/virtio_fs.c
> @@ -759,23 +759,31 @@ static void copy_args_from_argbuf(struct fuse_args =
*args, struct fuse_req *req)
>  }
> =20
>  /* Verify that the server properly follows the FUSE protocol */
> -static bool virtio_fs_verify_response(struct fuse_req *req, unsigned int=
 len)
> +static bool virtio_fs_verify_response(struct fuse_req *req)
>  {
> +	unsigned int num_out, cap;
> +	struct fuse_args *args;
>  	struct fuse_out_header *oh =3D &req->out.h;
> =20
> -	if (len < sizeof(*oh)) {
> -		pr_warn("virtio-fs: response too short (%u)\n", len);
> +	if (!test_bit(FR_ISREPLY, &req->flags))
>  		return false;
> -	}
> -	if (oh->len !=3D len) {
> -		pr_warn("virtio-fs: oh.len mismatch (%u !=3D %u)\n", oh->len, len);
> +	if (unlikely(oh->unique !=3D req->in.h.unique)) {
> +		pr_warn_ratelimited("virtio-fs: bad reply unique %llu (expected %llu)\=
n",
> +					oh->unique, req->in.h.unique);
>  		return false;
>  	}
> -	if (oh->unique !=3D req->in.h.unique) {
> -		pr_warn("virtio-fs: oh.unique mismatch (%llu !=3D %llu)\n",
> -			oh->unique, req->in.h.unique);
> +	args =3D req->args;
> +	num_out =3D args->out_numargs - args->out_pages;
> +	cap =3D sizeof(req->out.h);
> +	cap +=3D fuse_len_args(num_out, args->out_args);
> +	if (args->out_pages)
> +		cap +=3D args->out_args[args->out_numargs - 1].size;
> +	if (unlikely(oh->len < sizeof(*oh) || oh->len > cap)) {
> +		pr_warn_ratelimited("virtio-fs: bad reply len %u (cap %u)\n",
> +					oh->len, cap);
>  		return false;
>  	}
> +
>  	return true;
>  }
> =20
> @@ -841,7 +849,7 @@ static void virtio_fs_requests_done_work(struct work_=
struct *work)
>  		virtqueue_disable_cb(vq);
> =20
>  		while ((req =3D virtqueue_get_buf(vq, &len)) !=3D NULL) {
> -			if (!virtio_fs_verify_response(req, len)) {
> +			if (test_bit(FR_ISREPLY, &req->flags) && !virtio_fs_verify_response(r=
eq)) {
>  				req->out.h.error =3D -EIO;
>  				req->out.h.len =3D sizeof(struct fuse_out_header);
>  			}
> --=20
> 2.34.1
>=20

--fcP6Pyzv2wa0PELW
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmnFfyQACgkQnKSrs4Gr
c8hrJQf/QCbFg6idwfqN+4Z7GbtBwwNkWB00ywRad1HjSHPnlSnFMea2mkDECfWn
SAZUnFPyImvbQaaWNYE3KifeCI5QRhSxHj8qUXOvwC8FtLp10W/Wgjwfu4ouQpqG
llXpLBeln+z9kp0yKUcUmfJE8vSIdmnZS41Q+gG7g5NfXIQ2AWCISbrCNZUONDXI
82PVpLSGC93sFO9w4SeQx3KsUwyR6RkpwaU+aNC2zwhjf09I4lvUDSzKoRRiReWQ
3t/cekMGxYpCYnViUy80zNQsZV6Plq/GkR83fxdHZKY6fUH0kEGH5q85vxaJZ4zz
KBGI7EPqopOmCeuwtsLnsTdlbDMj7A==
=PUW+
-----END PGP SIGNATURE-----

--fcP6Pyzv2wa0PELW--

