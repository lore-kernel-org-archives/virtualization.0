Return-Path: <SRS0=a9bH=ML=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A15CC07E95
	for <virtualization@archiver.kernel.org>; Mon, 19 Jul 2021 14:14:22 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86EB96113A
	for <virtualization@archiver.kernel.org>; Mon, 19 Jul 2021 14:14:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86EB96113A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 49489605CF;
	Mon, 19 Jul 2021 14:14:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Vrjt93oItgD0; Mon, 19 Jul 2021 14:14:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id B2C9B600C5;
	Mon, 19 Jul 2021 14:14:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9627AC0010;
	Mon, 19 Jul 2021 14:14:19 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 82F10C000E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Jul 2021 14:14:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 64AF740135
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Jul 2021 14:14:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NeN9hu8JaTq2
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Jul 2021 14:14:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A371F4012D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Jul 2021 14:14:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1626704056;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Byjg2YuMIYuiu94sOcTN8FOOfmIWMHsMr13Iy2QTbpU=;
 b=hhFY0BYgBndOEAjBohaFJjpML5b75J63FvE4PIpzYtKBPQ8fV7/eWiHIdETySV3P/L58X4
 g7+pw21LvlFitznKu4WBnb+APZQvDUgkOVskQi8ZWfsMdMmqCv6I2q+QkZ+9XBOAsSbdyS
 XoApzpiq713Cdpm4spBsnQtgAtlC18A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-430-oLeyMsKCNc25MfgWn-xpgA-1; Mon, 19 Jul 2021 10:14:14 -0400
X-MC-Unique: oLeyMsKCNc25MfgWn-xpgA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 46BD78015C6;
 Mon, 19 Jul 2021 14:14:13 +0000 (UTC)
Received: from localhost (ovpn-112-70.ams2.redhat.com [10.36.112.70])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7D02E5D9DC;
 Mon, 19 Jul 2021 14:14:08 +0000 (UTC)
Date: Mon, 19 Jul 2021 15:13:37 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [RFC v3 00/29] vDPA software assisted live migration
Message-ID: <YPWIkRLSd7/wj11k@stefanha-x1.localdomain>
References: <20210519162903.1172366-1-eperezma@redhat.com>
 <20210524053144-mutt-send-email-mst@kernel.org>
 <CAJaqyWcVm55qjaDpQsuLzaY0FCzjW2ARyvOWCdfS9RJNoOM7Aw@mail.gmail.com>
 <20210524072739-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20210524072739-mutt-send-email-mst@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Parav Pandit <parav@mellanox.com>, qemu-level <qemu-devel@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>,
 Eugenio Perez Martin <eperezma@redhat.com>,
 Harpreet Singh Anand <hanand@xilinx.com>, Xiao W Wang <xiao.w.wang@intel.com>,
 Eli Cohen <eli@mellanox.com>, virtualization@lists.linux-foundation.org,
 Eric Blake <eblake@redhat.com>, Michael Lilja <ml@napatech.com>
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
Content-Type: multipart/mixed; boundary="===============1795145736769365396=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

--===============1795145736769365396==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="vZ5ERPfs+/Rz0sHU"
Content-Disposition: inline

--vZ5ERPfs+/Rz0sHU
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 24, 2021 at 07:29:06AM -0400, Michael S. Tsirkin wrote:
> On Mon, May 24, 2021 at 12:37:48PM +0200, Eugenio Perez Martin wrote:
> > On Mon, May 24, 2021 at 11:38 AM Michael S. Tsirkin <mst@redhat.com> wr=
ote:
> > >
> > > On Wed, May 19, 2021 at 06:28:34PM +0200, Eugenio P=E9rez wrote:
> > > > Commit 17 introduces the buffer forwarding. Previous one are for
> > > > preparations again, and laters are for enabling some obvious
> > > > optimizations. However, it needs the vdpa device to be able to map
> > > > every IOVA space, and some vDPA devices are not able to do so. Chec=
king
> > > > of this is added in previous commits.
> > >
> > > That might become a significant limitation. And it worries me that
> > > this is such a big patchset which might yet take a while to get
> > > finalized.
> > >
> >=20
> > Sorry, maybe I've been unclear here: Latter commits in this series
> > address this limitation. Still not perfect: for example, it does not
> > support adding or removing guest's memory at the moment, but this
> > should be easy to implement on top.
> >=20
> > The main issue I'm observing is from the kernel if I'm not wrong: If I
> > unmap every address, I cannot re-map them again. But code in this
> > patchset is mostly final, except for the comments it may arise in the
> > mail list of course.
> >=20
> > > I have an idea: how about as a first step we implement a transparent
> > > switch from vdpa to a software virtio in QEMU or a software vhost in
> > > kernel?
> > >
> > > This will give us live migration quickly with performance comparable
> > > to failover but without dependance on guest cooperation.
> > >
> >=20
> > I think it should be doable. I'm not sure about the effort that needs
> > to be done in qemu to hide these "hypervisor-failover devices" from
> > guest's view but it should be comparable to failover, as you say.
> >=20
> > Networking should be ok by its nature, although it could require care
> > on the host hardware setup. But I'm not sure how other types of
> > vhost/vdpa devices may work that way. How would a disk/scsi device
> > switch modes? Can the kernel take control of the vdpa device through
> > vhost, and just start reporting with a dirty bitmap?
> >=20
> > Thanks!
>=20
> It depends of course, e.g. blk is mostly reads/writes so
> not a lot of state. just don't reorder or drop requests.

QEMU's virtio-blk does not attempt to change states (e.g. quiesce the
device or switch between vhost kernel/QEMU, etc) while there are
in-flight requests. Instead all currently active requests must complete
(in some cases they can be cancelled to stop them early). Note that
failed requests can be kept in a list across the switch and then
resubmitted later.

The underlying storage never has requests in flight while the device is
switched. The reason QEMU does this is because there's no way to hand
over an in-flight preadv(2), Linux AIO, or other host kernel block layer
request to another process.

Stefan

--vZ5ERPfs+/Rz0sHU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmD1iJEACgkQnKSrs4Gr
c8gzBgf/YoLVCEyoNfmTzz77IqZwXuHgT5R778j5Ofg9MNulsBhsb/Q5umpJHkBU
oi9saB9Czxr30YQQmbRoAueVoehSxHprOAV1PRXuKqrOB2mDR7C9Fe8nWW0dP5zj
+Vclo7KToxH+WSNUCnydN+1dpXYNZ2tApcy3G8KAtEhpSbqH/3Bu0fQ7LMV1FaQ7
7kr/45jx9ylnRohq/fqKGuDpO07GtRJ0JAuXPq1MNc4KAj4krzt2HN07SWGONkZa
ahuFsc4rc42GmHFPKLfuQsHsuPIHRKIc9L6EMd2pW9z8b4JDN3QQ/x3DTPLZ6IIC
aUT7fHUX1rcSjvgQ8Ew58JRp5fQ8Mg==
=e1sj
-----END PGP SIGNATURE-----

--vZ5ERPfs+/Rz0sHU--


--===============1795145736769365396==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============1795145736769365396==--

