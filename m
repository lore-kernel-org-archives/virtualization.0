Return-Path: <SRS0=HWuT=EY=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E81EBC56202
	for <virtualization@archiver.kernel.org>; Wed, 18 Nov 2020 11:24:09 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B92F2075A
	for <virtualization@archiver.kernel.org>; Wed, 18 Nov 2020 11:24:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VScJECai"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B92F2075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 0F626842FF;
	Wed, 18 Nov 2020 11:24:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lat1uGrk8xFo; Wed, 18 Nov 2020 11:24:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 77EE282397;
	Wed, 18 Nov 2020 11:24:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 63751C0891;
	Wed, 18 Nov 2020 11:24:08 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9229EC0891
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Nov 2020 11:24:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 7F472871C9
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Nov 2020 11:24:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EDg7bCSikdbZ
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Nov 2020 11:24:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by hemlock.osuosl.org (Postfix) with ESMTPS id C81518720D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Nov 2020 11:24:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1605698645;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HTlQF18sW0QIjjKgLi+gVSBcV+WwnU/qkBOsnRkLKWo=;
 b=VScJECaiH4EWkxyAZcvyD3xfQ1eVC9LPQKRA/xbjfBEPfpxgZwHY8PmOFK9S+6LzFOTQTr
 lw3FIaMRrPjVMG/z/McctlBYYGFzycSOFniulvTvr5dv7PjRM8SEl+jh4Ba/BpTnVWarTa
 pLUHtG5VJIhwlJmmQy0bkKSSHvqTn5g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-95-xdz25K6MNNuvSmtiDkflcA-1; Wed, 18 Nov 2020 06:24:01 -0500
X-MC-Unique: xdz25K6MNNuvSmtiDkflcA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 871C51084D61;
 Wed, 18 Nov 2020 11:24:00 +0000 (UTC)
Received: from localhost (ovpn-114-60.ams2.redhat.com [10.36.114.60])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3E0FF5B4BE;
 Wed, 18 Nov 2020 11:23:57 +0000 (UTC)
Date: Wed, 18 Nov 2020 11:23:55 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH RFC 04/12] vdpa: add vdpa simulator for block device
Message-ID: <20201118112355.GE182763@stefanha-x1.localdomain>
References: <20201113134712.69744-1-sgarzare@redhat.com>
 <20201113134712.69744-5-sgarzare@redhat.com>
 <20201117111121.GD131917@stefanha-x1.localdomain>
 <20201117141620.ytium7r6xpxi4and@steredhat>
 <20201117164342.GT131917@stefanha-x1.localdomain>
 <20201117173811.lw4nwicoykhnn3tt@steredhat>
MIME-Version: 1.0
In-Reply-To: <20201117173811.lw4nwicoykhnn3tt@steredhat>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Laurent Vivier <lvivier@redhat.com>, Max Gurtovoy <mgurtovoy@nvidia.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, Eli Cohen <elic@nvidia.com>
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
Content-Type: multipart/mixed; boundary="===============8192672466130021734=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

--===============8192672466130021734==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="AsxXAMtlQ5JHofzM"
Content-Disposition: inline

--AsxXAMtlQ5JHofzM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 17, 2020 at 06:38:11PM +0100, Stefano Garzarella wrote:
> On Tue, Nov 17, 2020 at 04:43:42PM +0000, Stefan Hajnoczi wrote:
> > On Tue, Nov 17, 2020 at 03:16:20PM +0100, Stefano Garzarella wrote:
> > > On Tue, Nov 17, 2020 at 11:11:21AM +0000, Stefan Hajnoczi wrote:
> > > > On Fri, Nov 13, 2020 at 02:47:04PM +0100, Stefano Garzarella wrote:
> > > > > +static void vdpasim_blk_work(struct work_struct *work)
> > > > > +{
> > > > > +=09struct vdpasim *vdpasim =3D container_of(work, struct vdpasim=
, work);
> > > > > +=09u8 status =3D VIRTIO_BLK_S_OK;
> > > > > +=09int i;
> > > > > +
> > > > > +=09spin_lock(&vdpasim->lock);
> > > > > +
> > > > > +=09if (!(vdpasim->status & VIRTIO_CONFIG_S_DRIVER_OK))
> > > > > +=09=09goto out;
> > > > > +
> > > > > +=09for (i =3D 0; i < VDPASIM_BLK_VQ_NUM; i++) {
> > > > > +=09=09struct vdpasim_virtqueue *vq =3D &vdpasim->vqs[i];
> > > > > +
> > > > > +=09=09if (!vq->ready)
> > > > > +=09=09=09continue;
> > > > > +
> > > > > +=09=09while (vringh_getdesc_iotlb(&vq->vring, &vq->iov, &vq->iov=
,
> > > > > +=09=09=09=09=09    &vq->head, GFP_ATOMIC) > 0) {
> > > > > +
> > > > > +=09=09=09int write;
> > > > > +
> > > > > +=09=09=09vq->iov.i =3D vq->iov.used - 1;
> > > > > +=09=09=09write =3D vringh_iov_push_iotlb(&vq->vring, &vq->iov, &=
status, 1);
> > > > > +=09=09=09if (write <=3D 0)
> > > > > +=09=09=09=09break;
> > > >
> > > > We're lucky the guest driver doesn't crash after VIRTIO_BLK_T_GET_I=
D? :)
> > >=20
> > > The crash could happen if the simulator doesn't put the string termin=
ator,
> > > but in virtio_blk.c, the serial_show() initialize the buffer putting =
the
> > > string terminator in the VIRTIO_BLK_ID_BYTES element:
> > >=20
> > >     buf[VIRTIO_BLK_ID_BYTES] =3D '\0';
> > >     err =3D virtblk_get_id(disk, buf);
> > >=20
> > > This should prevent the issue, right?
> > >=20
> > > However in the last patch of this series I implemented VIRTIO_BLK_T_G=
ET_ID
> > > support :-)
> >=20
> > Windows, BSD, macOS, etc guest drivers aren't necessarily going to
> > terminate or initialize the serial string buffer.
>=20
> Unfortunately I discovered that VIRTIO_BLK_T_GET_ID is not in the VIRTIO
> specs, so, just for curiosity, I checked the QEMU code and I found this:
>=20
>     case VIRTIO_BLK_T_GET_ID:
>     {
>         /*
>          * NB: per existing s/n string convention the string is
>          * terminated by '\0' only when shorter than buffer.
>          */
>         const char *serial =3D s->conf.serial ? s->conf.serial : "";
>         size_t size =3D MIN(strlen(serial) + 1,
>                           MIN(iov_size(in_iov, in_num),
>                               VIRTIO_BLK_ID_BYTES));
>         iov_from_buf(in_iov, in_num, 0, serial, size);
>         virtio_blk_req_complete(req, VIRTIO_BLK_S_OK);
>         virtio_blk_free_request(req);
>         break;
>     }
>=20
> It seems that the device emulation in QEMU expects that the driver
> terminates the serial string buffer.
>=20
> Do you know why VIRTIO_BLK_T_GET_ID is not in the specs?
> Should we add it?

It's about to be merged into the VIRTIO spec:
https://github.com/oasis-tcs/virtio-spec/issues/63

Stefan

--AsxXAMtlQ5JHofzM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl+1BEsACgkQnKSrs4Gr
c8iCzgf+MQ+2r8v8e14Ettix74PLbceOdl1s1ruXCeKEWWwegoM/UZ1X0HviTaHO
jy/txmM7MpqE/QXAY+ODeiHjArVWKRDI/L8oWQiLXJKF8/Xm6ZXApG9Ca188w6Z5
JZ7+Awr7KHqdLkWgGG5d3jk0/TKin+l8g19PsiucyhpifYpHI5MNPKyhk3reXD/8
VcrVSWyWHrHjVON+kj8f1K6F8D0CDVPhT/+aJOWCjXGVRePEeGp5qNJTJMCC22Ix
OeoLj0OzncGzeX/2uaDIpNHOFPgFLSGg58kVK/HTduSPJrUZb4srRlh5HO6ajUQ0
+u6h5f9GBGkqOkbfNiondE4XYTOG3A==
=N5O5
-----END PGP SIGNATURE-----

--AsxXAMtlQ5JHofzM--


--===============8192672466130021734==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============8192672466130021734==--

