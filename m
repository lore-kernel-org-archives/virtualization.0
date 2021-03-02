Return-Path: <SRS0=LnXi=IA=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FDA5C433DB
	for <virtualization@archiver.kernel.org>; Tue,  2 Mar 2021 09:51:50 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82C1C60295
	for <virtualization@archiver.kernel.org>; Tue,  2 Mar 2021 09:51:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82C1C60295
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2208B414F4;
	Tue,  2 Mar 2021 09:51:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id psGgfyWILtzs; Tue,  2 Mar 2021 09:51:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8658A4ECD1;
	Tue,  2 Mar 2021 09:51:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6227AC000B;
	Tue,  2 Mar 2021 09:51:47 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 634E7C0001
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Mar 2021 09:51:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 450AF430A0
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Mar 2021 09:51:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id I9qe62H9ynOu
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Mar 2021 09:51:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 788A043083
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Mar 2021 09:51:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1614678704;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YFm4L6wDlmBpBp9jYOTr6fIaGFcMBM9PSJDWBsVlZjw=;
 b=eGhRadjpyoWchGXuBvcxa9F69Z4BWW16gKcExenXr7jwG4gavGZnn/GUPV4Ek8eGedgxdv
 nRFj8LElJJAEARyUcoolCVC15voEGD6t8qFt69bFm01sDpNskmyI4ZLZvZ2nhg8+3RiyZR
 jtI/KF0l1mALjN/OTMnPj37JwMH+nlM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-480-NosW96qGP9Gpg8C-jeDm1w-1; Tue, 02 Mar 2021 04:51:40 -0500
X-MC-Unique: NosW96qGP9Gpg8C-jeDm1w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 601AA801995;
 Tue,  2 Mar 2021 09:51:36 +0000 (UTC)
Received: from localhost (ovpn-114-138.ams2.redhat.com [10.36.114.138])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DD0586F991;
 Tue,  2 Mar 2021 09:51:31 +0000 (UTC)
Date: Tue, 2 Mar 2021 09:51:30 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Jie Deng <jie.deng@intel.com>
Subject: Re: [PATCH v5] i2c: virtio: add a virtio i2c frontend driver
Message-ID: <YD4KovxeoNG/c8QC@stefanha-x1.localdomain>
References: <00f826ffe1b6b4f5fb41de2b55ad6b8783b7ff45.1614579846.git.jie.deng@intel.com>
 <CAK8P3a1ZXbodV07TTErnQunCLWOBnzRiVdLCxBD743fn-6FbXg@mail.gmail.com>
 <56fdef9a-b373-32f2-6dac-e687caa813c8@intel.com>
MIME-Version: 1.0
In-Reply-To: <56fdef9a-b373-32f2-6dac-e687caa813c8@intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Cc: Sergey Semin <Sergey.Semin@baikalelectronics.ru>,
 Bjorn Andersson <bjorn.andersson@linaro.org>, loic.poulain@linaro.org,
 Tali Perry <tali.perry1@gmail.com>, yu1.wang@intel.com,
 Arnd Bergmann <arnd@arndb.de>, "Michael S. Tsirkin" <mst@redhat.com>,
 Viresh Kumar <viresh.kumar@linaro.org>, shuo.a.liu@intel.com,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 virtualization@lists.linux-foundation.org, Wolfram Sang <wsa@kernel.org>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>, jarkko.nikula@linux.intel.com,
 Linux I2C <linux-i2c@vger.kernel.org>,
 Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
 kblaiech@mellanox.com, Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 conghui.chen@intel.com, Mike Rapoport <rppt@kernel.org>
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
Content-Type: multipart/mixed; boundary="===============9139398509111299733=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>


--===============9139398509111299733==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="OcANLzSOtjrbOSo2"
Content-Disposition: inline


--OcANLzSOtjrbOSo2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 02, 2021 at 10:42:06AM +0800, Jie Deng wrote:
>=20
> On 2021/3/1 23:19, Arnd Bergmann wrote:
> > On Mon, Mar 1, 2021 at 7:41 AM Jie Deng <jie.deng@intel.com> wrote:
> >=20
> > > --- /dev/null
> > > +++ b/include/uapi/linux/virtio_i2c.h
> > > @@ -0,0 +1,56 @@
> > > +/* SPDX-License-Identifier: GPL-2.0-or-later WITH Linux-syscall-note=
 */

The uapi VIRTIO header files are BSD licensed so they can be easily used
by other projects (including other operating systems and hypervisors
that don't use Linux). Please see the license headers in
<linux/virtio_net.h> or <linux/virtio_blk.h>.

> > > +/*
> > > + * Definitions for virtio I2C Adpter
> > > + *
> > > + * Copyright (c) 2021 Intel Corporation. All rights reserved.
> > > + */
> > > +
> > > +#ifndef _UAPI_LINUX_VIRTIO_I2C_H
> > > +#define _UAPI_LINUX_VIRTIO_I2C_H
> > Why is this a uapi header? Can't this all be moved into the driver
> > itself?

Linux VIRTIO drivers provide a uapi header with structs and constants
that describe the device interface. This allows other software like
QEMU, other operating systems, etc to reuse these headers instead of
redefining everything.

These files should contain:
1. Device-specific feature bits (VIRTIO_<device>_F_<feature>)
2. VIRTIO Configuration Space layout (struct virtio_<device>_config)
3. Virtqueue request layout (struct virtio_<device>_<req/resp>)

For examples, see <linux/virtio_net.h> and <linux/virtio_blk.h>.

> > > +/**
> > > + * struct virtio_i2c_req - the virtio I2C request structure
> > > + * @out_hdr: the OUT header of the virtio I2C message
> > > + * @write_buf: contains one I2C segment being written to the device
> > > + * @read_buf: contains one I2C segment being read from the device
> > > + * @in_hdr: the IN header of the virtio I2C message
> > > + */
> > > +struct virtio_i2c_req {
> > > +       struct virtio_i2c_out_hdr out_hdr;
> > > +       u8 *write_buf;
> > > +       u8 *read_buf;
> > > +       struct virtio_i2c_in_hdr in_hdr;
> > > +};
> > In particular, this structure looks like it is only ever usable between
> > the transfer functions in the driver itself, it is shared with neither
> > user space nor the virtio host side.

I agree. This struct is not part of the device interface. It's part of
the Linux driver implementation. This belongs inside the driver code and
not in include/uapi/ where public headers are located.

Stefan

--OcANLzSOtjrbOSo2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmA+CqIACgkQnKSrs4Gr
c8gEYQf/SkwOouoLMamDCEw2Sy3MNu4tjAtBfi8upE6rayO9k9KfFtOUq6S4oct9
mLjJDftIwDsJpNeTI9qjLqtwLKsyJa4ZIQ9EFCyiY69Fyf28MdcNZ1exQdmvHoKD
8BdJIsugcZidzDJDSEzU7JMdqXx72rp7x+ZeXdsh6HV74shf2kjNy7aIL3pYT2gN
M1+VVwD/2tbGO8W5Dza64x/2rbqU+vdFCbSXUZTlOLvhzMstmwimEe5YKjGYgJtD
oLWHYQtvkd+1rFRcUeFjhewq0XtyQ4XdFOuwHVjukjfFCwUPg9gO21P4wJNNokG2
K6vKRdDW+3yQzhulzaWhoPS+K6Dh3w==
=zjby
-----END PGP SIGNATURE-----

--OcANLzSOtjrbOSo2--


--===============9139398509111299733==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============9139398509111299733==--

