Return-Path: <SRS0=We/I=EX=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02100C2D0E4
	for <virtualization@archiver.kernel.org>; Tue, 17 Nov 2020 11:36:54 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4135022240
	for <virtualization@archiver.kernel.org>; Tue, 17 Nov 2020 11:36:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="atWPUDZm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4135022240
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id A68CA20525;
	Tue, 17 Nov 2020 11:36:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iGTMVmBjXxou; Tue, 17 Nov 2020 11:36:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 9337D20427;
	Tue, 17 Nov 2020 11:36:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8463DC0800;
	Tue, 17 Nov 2020 11:36:50 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 192B8C07FF
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Nov 2020 11:36:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 0547F20465
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Nov 2020 11:36:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id umnKcB5T61qS
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Nov 2020 11:36:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by silver.osuosl.org (Postfix) with ESMTPS id 5298E20427
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Nov 2020 11:36:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1605613007;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ojbyE0PcDtW26NIEQPg/SaNisXd9lAY9pA+BqplcSlc=;
 b=atWPUDZm9JFpma9gSBXDWdRCo9KOB6NCj/auf1VTpiHTLcAKvbAGUyULEfRUFJR/M8ss/l
 LNe28taH5mxwwypffzKRjC1oBjrthewks81yf2ZcIpV4Adc6hkh91UQ1+rag62ksX2wWML
 iQoOtg54hsfs2cGaRQlL+6xe6z3YGiE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-492-XjfEPL-VPQumwALw6W0xUg-1; Tue, 17 Nov 2020 06:36:43 -0500
X-MC-Unique: XjfEPL-VPQumwALw6W0xUg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EA4501084C8B;
 Tue, 17 Nov 2020 11:36:41 +0000 (UTC)
Received: from localhost (ovpn-113-172.ams2.redhat.com [10.36.113.172])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D41295C1D0;
 Tue, 17 Nov 2020 11:36:37 +0000 (UTC)
Date: Tue, 17 Nov 2020 11:36:36 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH RFC 12/12] vdpa_sim_blk: implement ramdisk behaviour
Message-ID: <20201117113636.GG131917@stefanha-x1.localdomain>
References: <20201113134712.69744-1-sgarzare@redhat.com>
 <20201113134712.69744-13-sgarzare@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201113134712.69744-13-sgarzare@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
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
Content-Type: multipart/mixed; boundary="===============3659278277834545364=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

--===============3659278277834545364==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="NPukt5Otb9an/u20"
Content-Disposition: inline

--NPukt5Otb9an/u20
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 13, 2020 at 02:47:12PM +0100, Stefano Garzarella wrote:
> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c b/drivers/vdpa/vdpa_sim=
/vdpa_sim_blk.c
> index 8e41b3ab98d5..68e74383322f 100644
> --- a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
> @@ -7,6 +7,7 @@
>   */
> =20
>  #include <linux/module.h>
> +#include <linux/blkdev.h>
>  #include <uapi/linux/virtio_blk.h>
> =20
>  #include "vdpa_sim.h"
> @@ -24,10 +25,137 @@
> =20
>  static struct vdpasim *vdpasim_blk_dev;
> =20
> +static int vdpasim_blk_handle_req(struct vdpasim *vdpasim,
> +=09=09=09=09  struct vdpasim_virtqueue *vq)

This function has a non-standard int return value. Please document it.

> +{
> +=09size_t wrote =3D 0, to_read =3D 0, to_write =3D 0;
> +=09struct virtio_blk_outhdr hdr;
> +=09uint8_t status;
> +=09uint32_t type;
> +=09ssize_t bytes;
> +=09loff_t offset;
> +=09int i, ret;
> +
> +=09vringh_kiov_cleanup(&vq->riov);
> +=09vringh_kiov_cleanup(&vq->wiov);
> +
> +=09ret =3D vringh_getdesc_iotlb(&vq->vring, &vq->riov, &vq->wiov,
> +=09=09=09=09   &vq->head, GFP_ATOMIC);
> +=09if (ret !=3D 1)
> +=09=09return ret;
> +
> +=09for (i =3D 0; i < vq->wiov.used; i++)
> +=09=09to_write +=3D vq->wiov.iov[i].iov_len;
> +=09to_write -=3D 1; /* last byte is the status */

What if vq->wiov.used =3D=3D 0?

> +
> +=09for (i =3D 0; i < vq->riov.used; i++)
> +=09=09to_read +=3D vq->riov.iov[i].iov_len;
> +
> +=09bytes =3D vringh_iov_pull_iotlb(&vq->vring, &vq->riov, &hdr, sizeof(h=
dr));
> +=09if (bytes !=3D sizeof(hdr))
> +=09=09return 0;
> +
> +=09to_read -=3D bytes;
> +
> +=09type =3D le32_to_cpu(hdr.type);
> +=09offset =3D le64_to_cpu(hdr.sector) << SECTOR_SHIFT;
> +=09status =3D VIRTIO_BLK_S_OK;
> +
> +=09switch (type) {
> +=09case VIRTIO_BLK_T_IN:
> +=09=09if (offset + to_write > VDPASIM_BLK_CAPACITY << SECTOR_SHIFT) {

Integer overflow is not handled.

--NPukt5Otb9an/u20
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl+ztcQACgkQnKSrs4Gr
c8iolAgApTBD1PaVo9UuMIiHwUOHDFHckP5/xzilctMNmZYAzMd60k7GRTsYu0z2
eTkPw8Ik1Z5PXqgtSa8w2alDtWE7kJV6x2K+D4Xs3Y4miArXfd8NlozeFYsJCScf
b37DkWKR7sXDLWv/ITGqH5M+HjT6hIbXA4hrOtrUsF9S07OfzwwS7T0HmBxreiom
IUaloJ95O+c8WzhlHzoyxJeC/MSV4wPyivmuJZ6FzrtPMvPhAJwjWa5Xark5s3bM
A9iDFP1eikLSn0zrn03cWy7FzA14QAyO/Ppnv0sllpLDLWx5flHXnyQRIZx74JNh
yuLDV+JjZJroWZYLpKPWdZQ+xoQ/Fw==
=TgK+
-----END PGP SIGNATURE-----

--NPukt5Otb9an/u20--


--===============3659278277834545364==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============3659278277834545364==--

