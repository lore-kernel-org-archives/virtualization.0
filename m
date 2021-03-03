Return-Path: <SRS0=2V5C=IB=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72513C433E0
	for <virtualization@archiver.kernel.org>; Wed,  3 Mar 2021 17:49:02 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E546A601FD
	for <virtualization@archiver.kernel.org>; Wed,  3 Mar 2021 17:49:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E546A601FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 945CD471E6;
	Wed,  3 Mar 2021 17:49:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0FlR5rFFp0-a; Wed,  3 Mar 2021 17:49:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id D682F46CA8;
	Wed,  3 Mar 2021 17:48:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AD075C000A;
	Wed,  3 Mar 2021 17:48:59 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 453CAC0001
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 Mar 2021 17:48:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2540046CA8
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 Mar 2021 17:48:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dMt8cBncXX25
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 Mar 2021 17:48:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D684E40174
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 Mar 2021 17:48:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1614793734;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XgGS/s/8WlRgw3FyEQZnL/peYUyqO0Kr8QQUVUAZzb8=;
 b=ftFRIBwovZRHT7TuWcyJYVGeiLx/xpZyrcH3L3+mOwrIOMrHrMNq8IBo/9pY94xO8AMWH5
 H3PRZSksOhcVxgpjq0OVOav7GdMHO+JzukejuVpBZQ5u4hxYzlar+qge3ZfA7K7TsO/bbR
 z2AIUFYOiwcMr0twLXMOPqXEQf5Afo8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-223-l-AnTYKWMH6hyIacArNycg-1; Wed, 03 Mar 2021 12:48:50 -0500
X-MC-Unique: l-AnTYKWMH6hyIacArNycg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0D9101846097;
 Wed,  3 Mar 2021 17:48:47 +0000 (UTC)
Received: from localhost (ovpn-114-24.ams2.redhat.com [10.36.114.24])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 965E37094A;
 Wed,  3 Mar 2021 17:48:40 +0000 (UTC)
Date: Wed, 3 Mar 2021 17:48:39 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v5] i2c: virtio: add a virtio i2c frontend driver
Message-ID: <YD/L9/Dj+3dSZJXa@stefanha-x1.localdomain>
References: <00f826ffe1b6b4f5fb41de2b55ad6b8783b7ff45.1614579846.git.jie.deng@intel.com>
 <CAK8P3a1ZXbodV07TTErnQunCLWOBnzRiVdLCxBD743fn-6FbXg@mail.gmail.com>
 <56fdef9a-b373-32f2-6dac-e687caa813c8@intel.com>
 <YD4KovxeoNG/c8QC@stefanha-x1.localdomain>
 <CAK8P3a23L-Y0vzJTb5w1MkumaYAJQ6Owiq6RZ2XE=i8gBMTUZw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAK8P3a23L-Y0vzJTb5w1MkumaYAJQ6Owiq6RZ2XE=i8gBMTUZw@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Cc: Sergey Semin <Sergey.Semin@baikalelectronics.ru>,
 Bjorn Andersson <bjorn.andersson@linaro.org>, loic.poulain@linaro.org,
 Tali Perry <tali.perry1@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Viresh Kumar <viresh.kumar@linaro.org>, shuo.a.liu@intel.com,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 virtualization@lists.linux-foundation.org, Wolfram Sang <wsa@kernel.org>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>, jarkko.nikula@linux.intel.com,
 Linux I2C <linux-i2c@vger.kernel.org>,
 Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
 kblaiech@mellanox.com, Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 conghui.chen@intel.com, Mike Rapoport <rppt@kernel.org>, yu1.wang@intel.com
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
Content-Type: multipart/mixed; boundary="===============6811658129050034525=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>


--===============6811658129050034525==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="0Z13hpXB9yg/SJqi"
Content-Disposition: inline


--0Z13hpXB9yg/SJqi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 02, 2021 at 11:54:02AM +0100, Arnd Bergmann wrote:
> On Tue, Mar 2, 2021 at 10:51 AM Stefan Hajnoczi <stefanha@redhat.com> wro=
te:
> > On Tue, Mar 02, 2021 at 10:42:06AM +0800, Jie Deng wrote:
> > > > > +/*
> > > > > + * Definitions for virtio I2C Adpter
> > > > > + *
> > > > > + * Copyright (c) 2021 Intel Corporation. All rights reserved.
> > > > > + */
> > > > > +
> > > > > +#ifndef _UAPI_LINUX_VIRTIO_I2C_H
> > > > > +#define _UAPI_LINUX_VIRTIO_I2C_H
> > > > Why is this a uapi header? Can't this all be moved into the driver
> > > > itself?
> >
> > Linux VIRTIO drivers provide a uapi header with structs and constants
> > that describe the device interface. This allows other software like
> > QEMU, other operating systems, etc to reuse these headers instead of
> > redefining everything.
> >
> > These files should contain:
> > 1. Device-specific feature bits (VIRTIO_<device>_F_<feature>)
> > 2. VIRTIO Configuration Space layout (struct virtio_<device>_config)
> > 3. Virtqueue request layout (struct virtio_<device>_<req/resp>)
> >
> > For examples, see <linux/virtio_net.h> and <linux/virtio_blk.h>.
>=20
> Ok, makes sense. So it's not strictly uapi but just helpful for
> virtio applications to reference these. I suppose it is slightly harder
> when building qemu on other operating systems though, how does
> it get these headers on BSD or Windows?

qemu.git imports Linux headers from time to time and can use them
instead of system headers:

  https://gitlab.com/qemu-project/qemu/-/blob/master/scripts/update-linux-h=
eaders.sh

Stefan

--0Z13hpXB9yg/SJqi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmA/y/cACgkQnKSrs4Gr
c8gvvwgAl//yH6nIM39C8033YVTMLn56fBWlMw7olnJWN4P4JpytEX5MLIkIoRrw
vkM13V7TSV0lHJKKDc8erHKfahXFJFc7vJV5cn69icEpv+HCzB8Knfk+wePViUAF
/vpfFH3K4/nutqb3eWfJ3yUQqFRrqXa4l7O+20e5H5j8REBK/R7NnOs6i3jBJ5su
eW1XJKy//Jwnyih0Bxifxxf56JIOgNz/82Zg1sF0BY6TGF9uVwyYcSzTm3dny5tI
E163vh02TFoNtMODr1aEEuQrR1gay5Cd+dE+YC+ba/Q0EBNj116O9yLid2xbipyb
B5MY41s7CLQj5ESoEgyO2pKStZ0H/w==
=2uM5
-----END PGP SIGNATURE-----

--0Z13hpXB9yg/SJqi--


--===============6811658129050034525==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============6811658129050034525==--

