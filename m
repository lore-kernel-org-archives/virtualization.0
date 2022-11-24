Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32A07C43219
	for <virtualization@archiver.kernel.org>; Thu, 24 Nov 2022 20:39:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CA11E81E82;
	Thu, 24 Nov 2022 20:39:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CA11E81E82
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=iIQ/6+nY
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iida6pN_MszG; Thu, 24 Nov 2022 20:39:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 171F081DBF;
	Thu, 24 Nov 2022 20:39:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 171F081DBF
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DA2B3C0033;
	Thu, 24 Nov 2022 20:39:04 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E2D46C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Nov 2022 20:39:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B5BBE417B8
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Nov 2022 20:39:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B5BBE417B8
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=iIQ/6+nY
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CVuAPgk47vq6
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Nov 2022 20:39:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 87F9A416FF
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 87F9A416FF
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Nov 2022 20:39:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1669322341;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=l8Tp9a2X+QCaqWwpSYc9cvX4BhcUfbNNV1To+jiqviM=;
 b=iIQ/6+nYbvZKDKQfSIEPsyfN4la8P3E7hxlYMJ5HZlgB40FYyJqjb81wCEbQMR1W3EWxW4
 K6RfwZqruX4dboCm2KJiDQ4MTFXSGSkz3TPOH+phicGNOy8J4Igp9gGPewKdQ7kLV7C3Jn
 TLXesNpd45mnQxvqymB+Nx5cpsy6DoY=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-218-Cy3xqPwKNCKuKn52FGNXaQ-1; Thu, 24 Nov 2022 15:38:57 -0500
X-MC-Unique: Cy3xqPwKNCKuKn52FGNXaQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4507338012DD;
 Thu, 24 Nov 2022 20:38:57 +0000 (UTC)
Received: from localhost (unknown [10.39.194.58])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A77E14B3FC6;
 Thu, 24 Nov 2022 20:38:56 +0000 (UTC)
Date: Thu, 24 Nov 2022 15:38:53 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v2] virtio_blk: add VIRTIO_BLK_F_LIFETIME feature support
Message-ID: <Y3/WXWoV1jcJnohR@fedora>
References: <20221121085923.2717501-1-alvaro.karsz@solid-run.com>
 <1bd1c77e-d8c3-b04a-4fbc-bbc85391e630@nvidia.com>
 <20221124013830-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20221124013830-mutt-send-email-mst@kernel.org>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Cc: Jens Axboe <axboe@kernel.dk>, Chaitanya Kulkarni <chaitanyak@nvidia.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============8096896553994819912=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>


--===============8096896553994819912==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="1R/+1jVyJuymF3eM"
Content-Disposition: inline


--1R/+1jVyJuymF3eM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 24, 2022 at 01:42:37AM -0500, Michael S. Tsirkin wrote:
> On Wed, Nov 23, 2022 at 10:41:46PM +0000, Chaitanya Kulkarni wrote:
> >=20
> > > +/* Get lifetime information from device */
> > > +static int virtblk_ioctl_lifetime(struct virtio_blk *vblk, unsigned =
long arg)
> > > +{
> > > +	struct request_queue *q =3D vblk->disk->queue;
> > > +	struct request *req =3D NULL;
> > > +	struct virtblk_req *vbr;
> > > +	struct virtio_blk_lifetime lifetime;
> > > +	int ret;
> > > +
> > > +	/* The virtio_blk_lifetime struct fields follow virtio spec.
> > > +	 * There is no check/decode on values received from the device.
> > > +	 * The data is sent as is to the user.
> > > +	 */
> >=20
> > Odd comment style, why not :-
> >=20
> > 	/*
> > 	 * The virtio_blk_lifetime struct fields follow virtio spec.
> > 	 * There is no check/decode on values received from the device.
> > 	 * The data is sent as is to the user.
> > 	 */
>=20
> most of virtio blk is like this. I don't really care much.
>=20
> > > +
> > > +	/* This ioctl is allowed only if VIRTIO_BLK_F_LIFETIME
> > > +	 * feature is negotiated.
> > > +	 */
> >=20
> > above comment is redundant to the below code as following code is
> > self explanatory.,..
>=20
> i find it helpful personally - this point is important enough to
> stress at cost of some duplication.
>=20
> > > +	if (!virtio_has_feature(vblk->vdev, VIRTIO_BLK_F_LIFETIME))
> > > +		return -ENOTTY;
> > > +
> > > +	memset(&lifetime, 0, sizeof(lifetime));
> > > +
> > > +	req =3D blk_mq_alloc_request(q, REQ_OP_DRV_IN, 0);
> > > +	if (IS_ERR(req))
> > > +		return PTR_ERR(req);
> > > +
> > > +	/* Write the correct type */
> >=20
> > same here for above comment...
>=20
> it's pretty harmless though
>=20
> > > +	vbr =3D blk_mq_rq_to_pdu(req);
> > > +	vbr->out_hdr.type =3D cpu_to_virtio32(vblk->vdev, VIRTIO_BLK_T_GET_=
LIFETIME);
> > > +
> > > +	ret =3D blk_rq_map_kern(q, req, &lifetime, sizeof(lifetime), GFP_KE=
RNEL);
> > > +	if (ret)
> > > +		goto out;
> > > +
> > > +	blk_execute_rq(req, false);
> > > +
> > > +	ret =3D virtblk_ioctl_result(blk_mq_rq_to_pdu(req));
> > > +	if (ret)
> > > +		goto out;
> > > +
> > > +	/* Pass the data to the user */
> > > +	if (copy_to_user((void __user *)arg, &lifetime, sizeof(lifetime))) {
> > > +		ret =3D -EFAULT;
> > > +		goto out;
> >=20
> > there nothing here to "goto out" following is sufficient I guess :-
> >=20
> > if (copy_to_user((void __user *)arg, &lifetime, sizeof(lifetime)))
> > 	ret =3D -EFAULT;
>=20
> error handling with goto seems cleaner, easier to add code down
> the road.
>=20
> > > +	}
> > > +
> > > +out:
> > > +	blk_mq_free_request(req);
> > > +	return ret;
> > > +}
> > > +
> >=20
> > [...]
> >=20
> >    };
> > >  =20
> > > +/* Get lifetime information struct for each request */
> > > +struct virtio_blk_lifetime {
> > > +	/*
> > > +	 * specifies the percentage of reserved blocks that are consumed.
> > > +	 * optional values following virtio spec:
> > > +	 * 0 - undefined
> > > +	 * 1 - normal, < 80% of reserved blocks are consumed
> > > +	 * 2 - warning, 80% of reserved blocks are consumed
> > > +	 * 3 - urgent, 90% of reserved blocks are consumed
> > > +	 */
> > > +	__le16 pre_eol_info;
> > > +	/*
> > > +	 * this field refers to wear of SLC cells and is provided in increm=
ents of 10used,
> > > +	 * and so on, thru to 11 meaning estimated lifetime exceeded. All v=
alues above 11
> > > +	 * are reserved
> > > +	 */
> > > +	__le16 device_lifetime_est_typ_a;
> > > +	/*
> > > +	 * this field refers to wear of MLC cells and is provided with the =
same semantics as
> > > +	 * device_lifetime_est_typ_a
> > > +	 */
> > > +	__le16 device_lifetime_est_typ_b;
> > > +};
> > > +
> >=20
> > are you sure there won't be any new members ever be added in future ?
> > to make it is futuresafe I'd add padding to this structure and keep
> > the reserve bytes to the meaningful size...
> >=20
> > -ck
>=20
>=20
> virtio has feature bits for this kind of thing, we don't do padding.

The struct defined in the VIRTIO spec is being reused in the ioctl
userspace ABI. While feature bits are used by VIRTIO, padding is common
in the Linux UAPI.

Adding padding would require decoupling the VIRTIO spec struct from the
ioctl struct. That's probably a good idea because I noticed endianness
is left to userspace due to the __le fields in the VIRTIO spec struct
and that's likely to cause userspace bugs/confusion.

I suggest defining a separate UAPI struct for this ioctl.

Stefan

--1R/+1jVyJuymF3eM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmN/1lwACgkQnKSrs4Gr
c8g3vgf/dR8m5tlo6+5w9frmlodZFEtp1SIlF2apQ4EwBW498lBx26R+1LV4oWVj
7+LueArbre8EFWleU7ScO34yxzcfexN8qTTeqD3P5es7aPk04XvKaAfLB2Ch8oLW
3lmYuYuzu7jWuAA4ABsXIU1NOP6CnXlGSzq9+9eqGD/QirDrmV5ivCsHrb5eMiDp
t8l44DtdRb5Ml/0T66L+UEuE9gc+I/Gtd1A7UlHUgC9oFmQITgoaX5Qk+3QoW3ot
q8zFB9I92zrfvliquageLyuzMpc7mJj7DJd5wfasZ93rHzG0R66C4r0CyWjVlboz
3XpdtqVNXeZo/pLKZExp8AaJgTrnOg==
=zkqF
-----END PGP SIGNATURE-----

--1R/+1jVyJuymF3eM--


--===============8096896553994819912==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============8096896553994819912==--

