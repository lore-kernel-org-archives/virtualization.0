Return-Path: <SRS0=k93m=FM=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85EEDC4361B
	for <virtualization@archiver.kernel.org>; Tue,  8 Dec 2020 09:03:04 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F69923A9B
	for <virtualization@archiver.kernel.org>; Tue,  8 Dec 2020 09:03:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F69923A9B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 823DE203FD;
	Tue,  8 Dec 2020 09:03:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3UVcJ8FicfDj; Tue,  8 Dec 2020 09:03:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id C9617203AB;
	Tue,  8 Dec 2020 09:03:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AA14EC0893;
	Tue,  8 Dec 2020 09:03:00 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D0029C013B
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Dec 2020 09:02:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id A8226203CF
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Dec 2020 09:02:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FKNSC8+e9lje
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Dec 2020 09:02:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ej1-f65.google.com (mail-ej1-f65.google.com
 [209.85.218.65])
 by silver.osuosl.org (Postfix) with ESMTPS id 56504203AB
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Dec 2020 09:02:56 +0000 (UTC)
Received: by mail-ej1-f65.google.com with SMTP id lt17so23609284ejb.3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 08 Dec 2020 01:02:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=heOnO8xtoXTUu7nkg7Tr0zoCny6XJ7I7y8VFkwKx3YI=;
 b=NAcUA4g6FpMBOE1Xlxt2Q1ElVyu7anh6kb/qyZlxlLM2F5boiqCY7XXrG73lLkjkTO
 G24s2g422BaJZe7uWJWbXmCoKCwFQGB7nP3ln4yb+t0aO74TxgVEvBrAK+i6Lg6p4ZRx
 4o+Nc01KscoeDYfhWOgT8Jke8eZgxT/e8fyJ9To8vxOA6OyyIKLwsBuznaAOAmwlcGmo
 1BePba9ADIsphBcP16NjyMjxqjyGLJLp4qwcAPlebCigeVxX5uR6f5HANjd0HIzTIgBH
 veF5YLY0e8cNXIPT+nO7CAqZ86TDl6IKWGH5eimx+JDkHCnAQWSJJQMO9G74fjFcjVhX
 t/GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=heOnO8xtoXTUu7nkg7Tr0zoCny6XJ7I7y8VFkwKx3YI=;
 b=EJBZQb88HYcvbdcfQjPlGl1kxQE06mF5y4jjzNwEMpyFjioxBLP6MTxKv825IntJAO
 XUh3gLRIsEB/Gjv0SE09fZXfEMsUwbQMC50dLYEfU2mPldqtDYENvx2u1ao0dT2mKWLY
 I+6Bd9m/QoOxpjYA5gk2VOptE0qY1h3SmeQ2kMrKGSTdApEAovvUAZ1zrGd0ATzgdQiN
 DQ8crYB89+ANP6hxACqo9ejsALizk20NQtqmdMtZGrNB+mu8DtxHbZOZgy2crXb4tOZ7
 P/zfbpeyAhNfehlKBlKi0/RoL733Cew/lYcCZ94w37IqfHORwC3yQXAbvR1Xn5pBQQHc
 lUaw==
X-Gm-Message-State: AOAM530loAPofDiNi1KMwLsH8smRuC0u3Ai2CQrEa5sy/ixfHBs9idYW
 KOurKIl39CwoPkOkNgxkoBg=
X-Google-Smtp-Source: ABdhPJwwqplxjiYTxGvk+CUu6nv9Om15+cCcDhpuWLQyJld3SKfxflSD8GOU2YNR5fW6/sN9mUvT0g==
X-Received: by 2002:a17:906:4d52:: with SMTP id
 b18mr21499156ejv.405.1607418174634; 
 Tue, 08 Dec 2020 01:02:54 -0800 (PST)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id x16sm6694407ejb.38.2020.12.08.01.02.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Dec 2020 01:02:53 -0800 (PST)
Date: Tue, 8 Dec 2020 09:02:52 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>
Subject: Re: [RFC PATCH 24/27] vhost: iommu changes
Message-ID: <20201208090252.GW203660@stefanha-x1.localdomain>
References: <20201120185105.279030-1-eperezma@redhat.com>
 <20201120185105.279030-25-eperezma@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201120185105.279030-25-eperezma@redhat.com>
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-devel@nongnu.org, Daniel Daly <dandaly0@gmail.com>,
 virtualization@lists.linux-foundation.org, Liran Alon <liralon@gmail.com>,
 Eli Cohen <eli@mellanox.com>, Nitin Shrivastav <nitin.shrivastav@broadcom.com>,
 Alex Barba <alex.barba@broadcom.com>,
 Christophe Fontaine <cfontain@redhat.com>, Lee Ballard <ballle98@gmail.com>,
 Lars Ganrot <lars.ganrot@gmail.com>, Rob Miller <rob.miller@broadcom.com>,
 Howard Cai <howard.cai@gmail.com>, Parav Pandit <parav@mellanox.com>,
 vm <vmireyno@marvell.com>, Salil Mehta <mehta.salil.lnk@gmail.com>,
 Stephen Finucane <stephenfin@redhat.com>, Xiao W Wang <xiao.w.wang@intel.com>,
 Sean Mooney <smooney@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Jim Harford <jim.harford@broadcom.com>,
 Dmytro Kazantsev <dmytro.kazantsev@gmail.com>, Siwei Liu <loseweigh@gmail.com>,
 Harpreet Singh Anand <hanand@xilinx.com>, Michael Lilja <ml@napatech.com>,
 Max Gurtovoy <maxgu14@gmail.com>
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
Content-Type: multipart/mixed; boundary="===============2119017071689334537=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>


--===============2119017071689334537==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="pEAjBjStGYT6H+Py"
Content-Disposition: inline


--pEAjBjStGYT6H+Py
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 20, 2020 at 07:51:02PM +0100, Eugenio P=E9rez wrote:
> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> index eebfac4455..cb44b9997f 100644
> --- a/hw/virtio/vhost.c
> +++ b/hw/virtio/vhost.c
> @@ -1109,6 +1109,10 @@ static int vhost_sw_live_migration_start(struct vh=
ost_dev *dev)
> =20
>      assert(dev->vhost_ops->vhost_set_vring_enable);
>      dev->vhost_ops->vhost_set_vring_enable(dev, false);
> +    if (vhost_dev_has_iommu(dev)) {
> +        r =3D vhost_backend_invalidate_device_iotlb(dev, 0, -1ULL);
> +        assert(r =3D=3D 0);
> +    }
> =20
>      for (idx =3D 0; idx < dev->nvqs; ++idx) {
>          struct vhost_virtqueue *vq =3D &dev->vqs[idx];
> @@ -1269,6 +1273,19 @@ int vhost_device_iotlb_miss(struct vhost_dev *dev,=
 uint64_t iova, int write)
> =20
>      trace_vhost_iotlb_miss(dev, 1);
> =20
> +    if (dev->sw_lm_enabled) {
> +        uaddr =3D iova;
> +        len =3D 4096;
> +        ret =3D vhost_backend_update_device_iotlb(dev, iova, uaddr, len,
> +                                                IOMMU_RW);

It would be nice to look up the available memory so
vhost_backend_update_device_iotlb() can be called with a much bigger
[uaddr, uaddr+len) range. This will reduce the number of iotlb misses.

Will vIOMMU be required for this feature? If not, then the vring needs
to be added to the vhost memory regions because vhost will not send QEMU
iotlb misses.

--pEAjBjStGYT6H+Py
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl/PQTwACgkQnKSrs4Gr
c8g3Ggf/ezALRa8CClAoD8oR71XoA1kVIcse2cg110kSgP3P6FQZ4K8P3eagY4KQ
MZOEBk/dhIcMAMUhqDGhKvCOgFzp4rxXGLJWWpVRqWXnyt+3pbt+qbRN1K6Mnw5m
yYr0IR/vdzG0tDl7Oy5n5igf8gbTiNAiO82jgonHy6KLiw8vhEqB/fdBVQOjorQn
4QbiOck2C58BSE+8G7iXFHCJWtoQd0O3zIgxDGsecDrDZYIP3RKcpd3EQfXUKDgc
8pESaRJsNfEfiM485waNw2fA9C4cV9tkWe9qup607f1Hgj6qw+1/Wboy+y4A86B2
0RfBLz7wh4oXLsoYnD1JLzTW2e3qXw==
=ebuW
-----END PGP SIGNATURE-----

--pEAjBjStGYT6H+Py--

--===============2119017071689334537==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============2119017071689334537==--
