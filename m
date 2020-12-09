Return-Path: <SRS0=MC01=FN=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5813C433FE
	for <virtualization@archiver.kernel.org>; Wed,  9 Dec 2020 16:09:16 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37BE623A22
	for <virtualization@archiver.kernel.org>; Wed,  9 Dec 2020 16:09:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37BE623A22
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id D274C204DF;
	Wed,  9 Dec 2020 16:09:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nrYHomsZ6yLK; Wed,  9 Dec 2020 16:09:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 17D9A204B0;
	Wed,  9 Dec 2020 16:09:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D301AC0FA7;
	Wed,  9 Dec 2020 16:09:12 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F272CC013B
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Dec 2020 16:09:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id E02B2861F1
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Dec 2020 16:09:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HbHEA2yqVAaL
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Dec 2020 16:09:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 0DBDC86168
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Dec 2020 16:09:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1607530148;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fOS/4HJ6CdAMgJzGnNDCHYvTBIuYNCc44EVO6kOzhSI=;
 b=gc6Csu8rpi6qW9fNP7zYdoTe+G5+V2PTMytmvw2FUFMPlfKqkG/8CSqti4aTKi5O/khg50
 Xas4g1LNGo3nOE5/PGzfH95ji4EwH+220JBgSs+LX+RpkEd8Db/hKC4CO/HVb8CS9gWHuR
 5/SjF+OX7IVDH6MmCxtnPxY1V3CH3mE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-278-rVoJ1VpoO0KvyhUnBjsi5w-1; Wed, 09 Dec 2020 11:09:05 -0500
X-MC-Unique: rVoJ1VpoO0KvyhUnBjsi5w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 127241005504;
 Wed,  9 Dec 2020 16:09:02 +0000 (UTC)
Received: from localhost (ovpn-115-48.ams2.redhat.com [10.36.115.48])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3AC6B60BF1;
 Wed,  9 Dec 2020 16:08:58 +0000 (UTC)
Date: Wed, 9 Dec 2020 16:08:57 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Eugenio Perez Martin <eperezma@redhat.com>
Subject: Re: [RFC PATCH 04/27] vhost: add vhost_kernel_set_vring_enable
Message-ID: <20201209160857.GC396498@stefanha-x1.localdomain>
References: <20201120185105.279030-1-eperezma@redhat.com>
 <20201120185105.279030-5-eperezma@redhat.com>
 <20201207164323.GK203660@stefanha-x1.localdomain>
 <CAJaqyWd5oAJ4kJOhyDz+1KNvwzqJi3NO+5Z7X6W5ju2Va=LTMQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAJaqyWd5oAJ4kJOhyDz+1KNvwzqJi3NO+5Z7X6W5ju2Va=LTMQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
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
Content-Type: multipart/mixed; boundary="===============7302584693836108562=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

--===============7302584693836108562==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Bu8it7iiRSEf40bY"
Content-Disposition: inline

--Bu8it7iiRSEf40bY
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 09, 2020 at 01:00:19PM +0100, Eugenio Perez Martin wrote:
> On Mon, Dec 7, 2020 at 5:43 PM Stefan Hajnoczi <stefanha@gmail.com> wrote=
:
> >
> > On Fri, Nov 20, 2020 at 07:50:42PM +0100, Eugenio P=E9rez wrote:
> > > Signed-off-by: Eugenio P=E9rez <eperezma@redhat.com>
> > > ---
> > >  hw/virtio/vhost-backend.c | 29 +++++++++++++++++++++++++++++
> > >  1 file changed, 29 insertions(+)
> > >
> > > diff --git a/hw/virtio/vhost-backend.c b/hw/virtio/vhost-backend.c
> > > index 222bbcc62d..317f1f96fa 100644
> > > --- a/hw/virtio/vhost-backend.c
> > > +++ b/hw/virtio/vhost-backend.c
> > > @@ -201,6 +201,34 @@ static int vhost_kernel_get_vq_index(struct vhos=
t_dev *dev, int idx)
> > >      return idx - dev->vq_index;
> > >  }
> > >
> > > +static int vhost_kernel_set_vq_enable(struct vhost_dev *dev, unsigne=
d idx,
> > > +                                      bool enable)
> > > +{
> > > +    struct vhost_vring_file file =3D {
> > > +        .index =3D idx,
> > > +    };
> > > +
> > > +    if (!enable) {
> > > +        file.fd =3D -1; /* Pass -1 to unbind from file. */
> > > +    } else {
> > > +        struct vhost_net *vn_dev =3D container_of(dev, struct vhost_=
net, dev);
> > > +        file.fd =3D vn_dev->backend;
> > > +    }
> > > +
> > > +    return vhost_kernel_net_set_backend(dev, &file);
> >
> > This is vhost-net specific even though the function appears to be
> > generic. Is there a plan to extend this to all devices?
> >
>=20
> I expected each vhost backend to enable-disable in its own terms, but
> I think it could be 100% virtio-device generic with something like the
> device state capability:
> https://lists.oasis-open.org/archives/virtio-comment/202012/msg00005.html
> .

Great, thanks for the link!

> > > +}
> > > +
> > > +static int vhost_kernel_set_vring_enable(struct vhost_dev *dev, int =
enable)
> > > +{
> > > +    int i;
> > > +
> > > +    for (i =3D 0; i < dev->nvqs; ++i) {
> > > +        vhost_kernel_set_vq_enable(dev, i, enable);
> > > +    }
> > > +
> > > +    return 0;
> > > +}
> >
> > I suggest exposing the per-vq interface (vhost_kernel_set_vq_enable())
> > in VhostOps so it follows the ioctl interface.
>=20
> It was actually the initial plan, I left as all-or-nothing to make less c=
hanges.
>=20
> > vhost_kernel_set_vring_enable() can be moved to vhost.c can loop over
> > all vqs if callers find it convenient to loop over all vqs.
>=20
> I'm ok with it. Thinking out loud, I don't know if it is easier for
> some devices to enable/disable all of it (less syscalls? less downtime
> somehow?) but I find more generic and useful the per-virtqueue
> approach.

That's an interesting question, the ability to enable/disable specific
virtqueues seems like it could be useful. For example, guests with vCPU
hotplug may want to enable/disable virtqueues so that multi-queue
adapts as the number of vCPUs changes. A per-vq interface is needed for
that.

I'm a little worried that some device types might not cope well with
quiescing individual vqs. Here "quiesce" means to complete in flight
requests. This would be where two or more vqs have a relationship and
disabling one vq could cause a deadlock when trying to disable the other
one. However, I can't think of a case where this happens.

virtio-vsock is the closest example but luckily we don't need complete
in flight requests, we can just stop the vq immediately. So although
there is a dependency on the other vq it won't deadlock in this case.

Stefan

--Bu8it7iiRSEf40bY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl/Q9pkACgkQnKSrs4Gr
c8iMSwgAuQkVy+8P+reUkH3zK4kRMJP39XJyEVGBk4XKwPzrKZMdOaUjfCdmtrS5
8mdhYb/M4pl2/kvGRgIMZFL/6fF+FqPl2awpYD7fWDQvMuUmg6Ky2czgPERekkjy
awjY044CskD0euoaLLbF8NawY+5/vkm65diOPvwhSVu9w/2ZPhAmEX8I+kL1w/8H
RfFdptKdp8+U24zVbF/Deb8i0aTC0SCpOlkdMzhXuK+KIVtz71I68T/bFgIgkThM
J/SvDM0FkIxRP4+BKY5fkxgNidAqWA3CnNZZxLNBZEhFeApizydASnYZyur+asYH
2WuQ+zP5DcEQTL5ehLWnwkSYdndt9A==
=VK9G
-----END PGP SIGNATURE-----

--Bu8it7iiRSEf40bY--


--===============7302584693836108562==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============7302584693836108562==--

