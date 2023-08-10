Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CDF6C04A6A
	for <virtualization@archiver.kernel.org>; Thu, 10 Aug 2023 14:15:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1A124612F2;
	Thu, 10 Aug 2023 14:15:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1A124612F2
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=axWcCqIS
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7dalndBG90AC; Thu, 10 Aug 2023 14:15:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 96B98612D0;
	Thu, 10 Aug 2023 14:15:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 96B98612D0
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6E54EC0072;
	Thu, 10 Aug 2023 14:15:53 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DE232C0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Aug 2023 14:15:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B2367612E3
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Aug 2023 14:15:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B2367612E3
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0OfTxiTiet9u
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Aug 2023 14:15:50 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A0242612D0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Aug 2023 14:15:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A0242612D0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691676949;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6X6xqYIfAo9/bJdWrxBUbwK7Qqf1rpvlgj3R7/3n4wk=;
 b=axWcCqISxKUMFjiDVzy6v4tHPt5Sb5zLTuat0u7ux5gkUe63qPiHExjg4rK//1a0neZI14
 ZGnwVW7MoXm9fo+HVb/wXop9cfeU5ST0ODqIrIPApAipqqdV7yAjTSX/8ZT+BSvQXJ+bsW
 RzPgsKGg0HGTmJODhHQXUIkEWDh7XR8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-553-_AembJuJOZeATngtYZsS_g-1; Thu, 10 Aug 2023 10:15:46 -0400
X-MC-Unique: _AembJuJOZeATngtYZsS_g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 551D98015AB;
 Thu, 10 Aug 2023 14:15:46 +0000 (UTC)
Received: from localhost (unknown [10.39.194.92])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C2C2540C6F4E;
 Thu, 10 Aug 2023 14:15:45 +0000 (UTC)
Date: Thu, 10 Aug 2023 10:15:44 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: Unbinding virtio_pci_modern does not release BAR4 in Linux
 6.5.0-rc4
Message-ID: <20230810141544.GB2931656@fedora>
References: <20230803143718.GA2330143@fedora>
 <CACGkMEvjrs17TMH2=b+mwm7qGFqEWV3jHydLyK7=Aj8spBNthw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEvjrs17TMH2=b+mwm7qGFqEWV3jHydLyK7=Aj8spBNthw@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 virtualization@lists.linux-foundation.org
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
Content-Type: multipart/mixed; boundary="===============5581690033074973027=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>


--===============5581690033074973027==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="R58kpV3n2S5j16/l"
Content-Disposition: inline


--R58kpV3n2S5j16/l
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 10, 2023 at 11:08:52AM +0800, Jason Wang wrote:
> On Thu, Aug 3, 2023 at 10:37=E2=80=AFPM Stefan Hajnoczi <stefanha@redhat.=
com> wrote:
> >
> > Hi,
> > After running "driverctl --nosave set-override 0000:01:00.0 vfio-pci" on
> > a virtio-blk-pci device, /proc/iomem shows that BAR4 is still owned by
> > virtio_pci_modern even though the vfio-pci driver is now bound to the
> > PCI device.
> >
> > This regression was introduced after 6.4.7 but I don't see the culprit
> > in the git logs.
> >
> > Unfortunately I don't have time to investigate further right now but
> > I've included instructions on how to reproduce this below.
> >
> > Can anyone else reproduce this and can we still fix it for the upcoming
> > Linux 6.5?
>=20
> This seems to be fixed by:
>=20
> https://lore.kernel.org/lkml/20230720131423-mutt-send-email-mst@kernel.or=
g/T/

Awesome, thanks for letting me know!

Stefan

>=20
> Thanks
>=20
> >
> > Thanks,
> > Stefan
> > ---
> > $ qemu-system-x86_64 \
> >     -M q35,accel=3Dkvm,kernel-irqchip=3Dsplit \
> >     -cpu host \
> >     -m 1G \
> >     -device intel-iommu,intremap=3Don,device-iotlb=3Don \
> >     --blockdev file,filename=3Dtest.img,cache.direct=3Don,node-name=3Dd=
rive0 \
> >     --device virtio-blk-pci,drive=3Ddrive0 \
> >     -blockdev file,filename=3Dtest2.img,cache.direct=3Don,node-name=3Dd=
rive2 \
> >     --device ioh3420,id=3Dpcie.1,chassis=3D1 \
> >     --device virtio-blk-pci,disable-legacy=3Don,disable-modern=3Doff,dr=
ive=3Ddrive2,iommu_platform=3Don,ats=3Don,bus=3Dpcie.1
> >
> > (guest)# driverctl --nosave set-override 0000:01:00.0 vfio-pci
> > (guest)# cat /proc/iomem
>=20

--R58kpV3n2S5j16/l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmTU8RAACgkQnKSrs4Gr
c8hrhQf/U2ROo+Sb1Kf5YYJCuWHXUnGBsxJ4JZ+jd8/EV3Ysv5SiclBMsv6c1xtf
KciT4eWDX3lhJ0ktJPj1nxbc11En7tNV6w0srYopvGCXIhIVpEVyT07i3U+qrsxS
BXSYUxpaNivsTTDzOWuuCHa3ep8G7KKqIq1JLge5hg8AMPC7CBVOFWl1Ti5eahu8
gGU2lZgEmjNdsJikyl8Y+vr3J1pLBzoDvj+wUTIVG6cfRtamLO9tfPI+OQZyFdtm
9JJsMxOOh1LMZxz7LDin5QHycf6qNzcNwuuZx7NUOtbFZly2TkeruFngM1Ou4Nul
KLHOXOE/9nTwSVCiqlP0TMEhsmyzFw==
=e1X7
-----END PGP SIGNATURE-----

--R58kpV3n2S5j16/l--


--===============5581690033074973027==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============5581690033074973027==--

