Return-Path: <SRS0=lZ9m=FO=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9011C4361B
	for <virtualization@archiver.kernel.org>; Thu, 10 Dec 2020 11:31:41 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7088823C8D
	for <virtualization@archiver.kernel.org>; Thu, 10 Dec 2020 11:31:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7088823C8D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id A78DA876F7;
	Thu, 10 Dec 2020 11:31:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id R0_Agj62P5v4; Thu, 10 Dec 2020 11:31:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 24DC4876DA;
	Thu, 10 Dec 2020 11:31:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 066DFC0FA7;
	Thu, 10 Dec 2020 11:31:40 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D2040C013B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Dec 2020 11:31:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id C020B8701A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Dec 2020 11:31:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id X+XNaqHhxwu9
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Dec 2020 11:31:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 0E5B687018
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Dec 2020 11:31:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1607599897;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0vpeFoxvipiFfHjrK3SmcHRfsuQ3JzQdub6tkzQBRZk=;
 b=Q6al0xrUQUAl2OiNHSpxbSaWIdcHwo6D06pJ84r3GgVqIi9Q3yE59sOJ5Yi2K0jRELBLQG
 d66Yl2oznFlA0vbQIOPEN0vwwhNFGI3VvESMpMqymT8nKoYw6KI10mhChHFjrUvY4Jy+yy
 e5WRxMCuPB2cIT9QU9HDUI+7cJT48HU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-41-IPyTpgFpPWuti1cYkS4kHA-1; Thu, 10 Dec 2020 06:31:33 -0500
X-MC-Unique: IPyTpgFpPWuti1cYkS4kHA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0353810CE7BC;
 Thu, 10 Dec 2020 11:30:53 +0000 (UTC)
Received: from localhost (ovpn-113-62.ams2.redhat.com [10.36.113.62])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 380665D9DD;
 Thu, 10 Dec 2020 11:30:52 +0000 (UTC)
Date: Thu, 10 Dec 2020 11:30:51 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Eugenio Perez Martin <eperezma@redhat.com>
Subject: Re: [RFC PATCH 05/27] vhost: Add hdev->dev.sw_lm_vq_handler
Message-ID: <20201210113051.GF416119@stefanha-x1.localdomain>
References: <20201120185105.279030-1-eperezma@redhat.com>
 <20201120185105.279030-6-eperezma@redhat.com>
 <20201207165216.GL203660@stefanha-x1.localdomain>
 <CAJaqyWfSUHD0MU=1yfU1N6pZ4TU7prxyoG6NY-VyNGt=MO9H4g@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAJaqyWfSUHD0MU=1yfU1N6pZ4TU7prxyoG6NY-VyNGt=MO9H4g@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: kvm list <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-level <qemu-devel@nongnu.org>, Daniel Daly <dandaly0@gmail.com>,
 virtualization@lists.linux-foundation.org, Liran Alon <liralon@gmail.com>,
 Eli Cohen <eli@mellanox.com>, Nitin Shrivastav <nitin.shrivastav@broadcom.com>,
 Alex Barba <alex.barba@broadcom.com>,
 Christophe Fontaine <cfontain@redhat.com>, Lee Ballard <ballle98@gmail.com>,
 Lars Ganrot <lars.ganrot@gmail.com>, Rob Miller <rob.miller@broadcom.com>,
 Howard Cai <howard.cai@gmail.com>, Parav Pandit <parav@mellanox.com>,
 vm <vmireyno@marvell.com>, Salil Mehta <mehta.salil.lnk@gmail.com>,
 Stephen Finucane <stephenfin@redhat.com>, Xiao W Wang <xiao.w.wang@intel.com>,
 Sean Mooney <smooney@redhat.com>, Jim Harford <jim.harford@broadcom.com>,
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
Content-Type: multipart/mixed; boundary="===============6319510717984419397=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

--===============6319510717984419397==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="wtjvnLv0o8UUzur2"
Content-Disposition: inline

--wtjvnLv0o8UUzur2
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 09, 2020 at 04:02:56PM +0100, Eugenio Perez Martin wrote:
> On Mon, Dec 7, 2020 at 5:52 PM Stefan Hajnoczi <stefanha@gmail.com> wrote=
:
> > On Fri, Nov 20, 2020 at 07:50:43PM +0100, Eugenio P=E9rez wrote:
> > > diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> > > index 9179013ac4..9a69ae3598 100644
> > > --- a/hw/net/virtio-net.c
> > > +++ b/hw/net/virtio-net.c
> > > @@ -2628,24 +2628,32 @@ static void virtio_net_tx_bh(void *opaque)
> > >      }
> > >  }
> > >
> > > -static void virtio_net_add_queue(VirtIONet *n, int index)
> > > +static void virtio_net_add_queue(VirtIONet *n, int index,
> > > +                                 VirtIOHandleOutput custom_handler)
> > >  {
> >
> > We talked about the possibility of moving this into the generic vhost
> > code so that devices don't need to be modified. It would be nice to hid=
e
> > this feature inside vhost.
>=20
> I'm thinking of tying it to VirtQueue, allowing the caller to override
> the handler knowing it is not going to be called (I mean, not offering
> race conditions protection, like before of starting processing
> notifications in qemu calling vhost_dev_disable_notifiers).

Yes, I can see how at least part of this belongs to VirtQueue.

Stefan

--wtjvnLv0o8UUzur2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl/SBusACgkQnKSrs4Gr
c8iLwgf/aaGiY0DHn8I8FYdQGoreiYRr1SK+yJ4QWre7tvYsACl3EXz8Uq2PKZRo
+7NkNHIwhXEpcb1usOfH5PrUw4pRoMH78oQckxlnJtoQOdKiYi1SikAQKxOrooRs
Cn4E2SA9vVnDyCa0ZFs83GkRJyhnsLfs/AOYtWk/t2JdxzXWZhbewHgI3lUhy5qN
nLo/wINyWrndWt1HoI7HFbe82IDwhpwh5ACBxlb5579HaSwJsI/HX4k+jcHEJGAl
S7wSdufuVz9xzQ07r3fIWjTh9GsVJRJhHS3cfUcYmL/7CbmkGxYOiHPveHLEPogL
0G812OH8HJc+Hde+Ce/yAwlHGjXPFw==
=/sJb
-----END PGP SIGNATURE-----

--wtjvnLv0o8UUzur2--


--===============6319510717984419397==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============6319510717984419397==--

