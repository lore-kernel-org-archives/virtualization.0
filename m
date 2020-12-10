Return-Path: <SRS0=lZ9m=FO=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EC22C4361B
	for <virtualization@archiver.kernel.org>; Thu, 10 Dec 2020 11:51:09 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0ED7523D56
	for <virtualization@archiver.kernel.org>; Thu, 10 Dec 2020 11:51:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0ED7523D56
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 7587C871FB;
	Thu, 10 Dec 2020 11:51:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QOu8qLQjsnl4; Thu, 10 Dec 2020 11:51:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id B992D871B4;
	Thu, 10 Dec 2020 11:51:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9A1E6C0FA7;
	Thu, 10 Dec 2020 11:51:07 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 08E48C013B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Dec 2020 11:51:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 03C5487769
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Dec 2020 11:51:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id X6urp53mlEXC
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Dec 2020 11:51:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id F1C5B8776A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Dec 2020 11:51:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1607601063;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=b5optel2eyRRXedLE/2kpzuTAJZaDhtuqBft0UNvIsQ=;
 b=hVCpFmwX1BCYvHB2yCF1HKZTJoFI7SBqc7eTa0CNuIXunze+woL/WJrsoiDod9F0mU5G2a
 Ff36MReOifC+l4QJEzosbVJwnntP1/mOuDNY3zUWoEU+E6w4E5ANrqyzc5gwVRakxbRfdP
 c0LIRcCdre9+YJyqp8bya2rpnLTBzZo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-349-zv8SJdC7P1GfV_dS9nrbFw-1; Thu, 10 Dec 2020 06:51:01 -0500
X-MC-Unique: zv8SJdC7P1GfV_dS9nrbFw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F1E67180A092;
 Thu, 10 Dec 2020 11:50:57 +0000 (UTC)
Received: from localhost (ovpn-113-62.ams2.redhat.com [10.36.113.62])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E67AD19C78;
 Thu, 10 Dec 2020 11:50:53 +0000 (UTC)
Date: Thu, 10 Dec 2020 11:50:52 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Eugenio Perez Martin <eperezma@redhat.com>
Subject: Re: [RFC PATCH 07/27] vhost: Route guest->host notification through
 qemu
Message-ID: <20201210115052.GG416119@stefanha-x1.localdomain>
References: <20201120185105.279030-1-eperezma@redhat.com>
 <20201120185105.279030-8-eperezma@redhat.com>
 <20201207174233.GN203660@stefanha-x1.localdomain>
 <CAJaqyWfiMsRP9FgSv7cOj=3jHx=DJS7hRJTMbRcTTHHWng0eKg@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAJaqyWfiMsRP9FgSv7cOj=3jHx=DJS7hRJTMbRcTTHHWng0eKg@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
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
Content-Type: multipart/mixed; boundary="===============5281355636901416283=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

--===============5281355636901416283==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="w2JjAQZceEVGylhD"
Content-Disposition: inline

--w2JjAQZceEVGylhD
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 09, 2020 at 06:08:14PM +0100, Eugenio Perez Martin wrote:
> On Mon, Dec 7, 2020 at 6:42 PM Stefan Hajnoczi <stefanha@gmail.com> wrote=
:
> > On Fri, Nov 20, 2020 at 07:50:45PM +0100, Eugenio P=E9rez wrote:
> > > +{
> > > +    struct vhost_vring_file file =3D {
> > > +        .index =3D idx
> > > +    };
> > > +    VirtQueue *vq =3D virtio_get_queue(dev->vdev, idx);
> > > +    VhostShadowVirtqueue *svq;
> > > +    int r;
> > > +
> > > +    svq =3D g_new0(VhostShadowVirtqueue, 1);
> > > +    svq->vq =3D vq;
> > > +
> > > +    r =3D event_notifier_init(&svq->hdev_notifier, 0);
> > > +    assert(r =3D=3D 0);
> > > +
> > > +    file.fd =3D event_notifier_get_fd(&svq->hdev_notifier);
> > > +    r =3D dev->vhost_ops->vhost_set_vring_kick(dev, &file);
> > > +    assert(r =3D=3D 0);
> > > +
> > > +    return svq;
> > > +}
> >
> > I guess there are assumptions about the status of the device? Does the
> > virtqueue need to be disabled when this function is called?
> >
>=20
> Yes. Maybe an assertion checking the notification state?

Sounds good.

> > > +
> > > +static int vhost_sw_live_migration_stop(struct vhost_dev *dev)
> > > +{
> > > +    int idx;
> > > +
> > > +    vhost_dev_enable_notifiers(dev, dev->vdev);
> > > +    for (idx =3D 0; idx < dev->nvqs; ++idx) {
> > > +        vhost_sw_lm_shadow_vq_free(dev->sw_lm_shadow_vq[idx]);
> > > +    }
> > > +
> > > +    return 0;
> > > +}
> > > +
> > > +static int vhost_sw_live_migration_start(struct vhost_dev *dev)
> > > +{
> > > +    int idx;
> > > +
> > > +    for (idx =3D 0; idx < dev->nvqs; ++idx) {
> > > +        dev->sw_lm_shadow_vq[idx] =3D vhost_sw_lm_shadow_vq(dev, idx=
);
> > > +    }
> > > +
> > > +    vhost_dev_disable_notifiers(dev, dev->vdev);
> >
> > There is a race condition if the guest kicks the vq while this is
> > happening. The shadow vq hdev_notifier needs to be set so the vhost
> > device checks the virtqueue for requests that slipped in during the
> > race window.
> >
>=20
> I'm not sure if I follow you. If I understand correctly,
> vhost_dev_disable_notifiers calls virtio_bus_cleanup_host_notifier,
> and the latter calls virtio_queue_host_notifier_read. That's why the
> documentation says "This might actually run the qemu handlers right
> away, so virtio in qemu must be completely setup when this is
> called.". Am I missing something?

There are at least two cases:

1. Virtqueue kicks that come before vhost_dev_disable_notifiers().
   vhost_dev_disable_notifiers() notices that and calls
   virtio_queue_notify_vq(). Will handle_sw_lm_vq() be invoked or is the
   device's vq handler function invoked?

2. Virtqueue kicks that come in after vhost_dev_disable_notifiers()
   returns. We hold the QEMU global mutex so the vCPU thread cannot
   perform MMIO/PIO dispatch immediately. The vCPU thread's
   ioctl(KVM_RUN) has already returned and will dispatch dispatch the
   MMIO/PIO access inside QEMU as soon as the global mutex is released.
   In other words, we're not taking the kvm.ko ioeventfd path but
   memory_region_dispatch_write_eventfds() should signal the ioeventfd
   that is registered at the time the dispatch occurs. Is that eventfd
   handled by handle_sw_lm_vq()?

Neither of these cases are obvious from the code. At least comments
would help but I suspect restructuring the code so the critical
ioeventfd state changes happen in a sequence would make it even clearer.

--w2JjAQZceEVGylhD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl/SC5wACgkQnKSrs4Gr
c8gmTQgAhfOO28RHUnmj9f9/sxGLUrPxhmK76LXN0VHNwqhOW8QjD6e/tIABEw5p
EOtcGYWQXWANtjwVxefQcMg3gXztF8w3V84NKGKAb2UDRNkt4vLc9tek4btoxGS8
CaEpCs/jZKxFDgcUsDVIkdecBAM94CjxJYNdADglVZpcUUWH47kvzFLQV8FhD1nd
q7HbHaS6AVHd1DWVKsgm7aunJkBZb69T3Y1AvSvCSkIrRp/HICmzagnklpgYG6j4
MLIypTEEX6yr40127PZ2p3z63QUkp5okVFUkPLXuLr3nJOmc0+H29alXZjx0NHoR
vAlFre145jUFn3uWEm8FV8jdbzYccA==
=94ib
-----END PGP SIGNATURE-----

--w2JjAQZceEVGylhD--


--===============5281355636901416283==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============5281355636901416283==--

