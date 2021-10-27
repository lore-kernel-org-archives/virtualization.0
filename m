Return-Path: <SRS0=5D8L=PP=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72D07C433EF
	for <virtualization@archiver.kernel.org>; Wed, 27 Oct 2021 09:02:01 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E2E560D43
	for <virtualization@archiver.kernel.org>; Wed, 27 Oct 2021 09:02:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1E2E560D43
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D4FDD6075B;
	Wed, 27 Oct 2021 09:02:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id l2P4WNkup0Lb; Wed, 27 Oct 2021 09:02:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 8D387607DC;
	Wed, 27 Oct 2021 09:01:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 517DEC0019;
	Wed, 27 Oct 2021 09:01:59 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E802DC000E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Oct 2021 09:01:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C8B2880CE4
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Oct 2021 09:01:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Js0dtaGDjiNI
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Oct 2021 09:01:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5A36980CD5
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Oct 2021 09:01:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1635325315;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wauAe2a13htRLUou8eOus0V9+ON8mGohpili1PfUnLw=;
 b=WU5oSqFxsH7McH5rXLzZdb9MspE+7Hb8E1S3uspCY4afZQ0QGde8oYBgI97q5FjOBiifAW
 jKCy6yngMG45idtVHahSMYB6oOuJn67K+dNLKXZP2BX13rjgx7FyxEbS1z8p+MVp5oL861
 NVr5CZZSBk/X/xxzsYLnzYy2JiEMKhI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-126-lYaDzzYRPyafPQ7MRBjptQ-1; Wed, 27 Oct 2021 05:01:51 -0400
X-MC-Unique: lYaDzzYRPyafPQ7MRBjptQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8A72F19200CB;
 Wed, 27 Oct 2021 09:01:50 +0000 (UTC)
Received: from localhost (unknown [10.39.195.83])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2595779450;
 Wed, 27 Oct 2021 09:01:49 +0000 (UTC)
Date: Wed, 27 Oct 2021 10:01:49 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH V3 11/11] vhost: allow userspace to create workers
Message-ID: <YXkVfbdOEKTPnY+t@stefanha-x1.localdomain>
References: <20211022051911.108383-1-michael.christie@oracle.com>
 <20211022051911.108383-13-michael.christie@oracle.com>
 <8aee8f07-76bd-f111-bc5f-fc5cad46ce56@redhat.com>
 <YXgiYFIUTKtoRJWW@stefanha-x1.localdomain>
 <CACGkMEsD=JwjWgTM4XpcKVy+ZKs6siW_1Q=3zzB8jZ3vq1CyZA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEsD=JwjWgTM4XpcKVy+ZKs6siW_1Q=3zzB8jZ3vq1CyZA@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Cc: linux-scsi@vger.kernel.org, mst <mst@redhat.com>,
 virtualization <virtualization@lists.linux-foundation.org>,
 target-devel@vger.kernel.org, pbonzini <pbonzini@redhat.com>
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
Content-Type: multipart/mixed; boundary="===============6074169775916468122=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>


--===============6074169775916468122==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="zhj4RK4pWGOqEvNg"
Content-Disposition: inline


--zhj4RK4pWGOqEvNg
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 27, 2021 at 10:55:04AM +0800, Jason Wang wrote:
> On Tue, Oct 26, 2021 at 11:45 PM Stefan Hajnoczi <stefanha@redhat.com> wr=
ote:
> >
> > On Tue, Oct 26, 2021 at 01:37:14PM +0800, Jason Wang wrote:
> > >
> > > =E5=9C=A8 2021/10/22 =E4=B8=8B=E5=8D=881:19, Mike Christie =E5=86=99=
=E9=81=93:
> > > > This patch allows userspace to create workers and bind them to vqs.=
 You
> > > > can have N workers per dev and also share N workers with M vqs.
> > > >
> > > > Signed-off-by: Mike Christie <michael.christie@oracle.com>
> > >
> > >
> > > A question, who is the best one to determine the binding? Is it the V=
MM
> > > (Qemu etc) or the management stack? If the latter, it looks to me it's
> > > better to expose this via sysfs?
> >
> > A few options that let the management stack control vhost worker CPU
> > affinity:
> >
> > 1. The management tool opens the vhost device node, calls
> >    ioctl(VHOST_SET_VRING_WORKER), sets up CPU affinity, and then passes
> >    the fd to the VMM. In this case the VMM is still able to call the
> >    ioctl, which may be undesirable from an attack surface perspective.
>=20
> Yes, and we can't do post or dynamic configuration afterwards after
> the VM is launched?

Yes, at least it's a little risky for the management stack to keep the
vhost fd open and make ioctl calls while the VMM is using it.

> >
> > 2. The VMM calls ioctl(VHOST_SET_VRING_WORKER) itself and the management
> >    tool queries the vq:worker details from the VMM (e.g. a new QEMU QMP
> >    query-vhost-workers command similar to query-iothreads). The
> >    management tool can then control CPU affinity on the vhost worker
> >    threads.
> >
> >    (This is how CPU affinity works in QEMU and libvirt today.)
>=20
> Then we also need a "bind-vhost-workers" command.

The VMM doesn't but the management tool does.

Stefan

--zhj4RK4pWGOqEvNg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmF5FXwACgkQnKSrs4Gr
c8jO1wgAtIXGYe1wRi8nwef0ov+cUVVVhMWYzrRpJBtIQlvn8M4oMTBBlAAeaBZP
QzHjuCcS3mcx0Ab4Q/wDJDwNbgm6GW9ucaGWkWUsu2htgZcWg2pYm2xE3jWeavR7
AoDJlLUbC8fmI9hbOMtTqDpsAUXAuiEfw3ht3DAN2mS09w/6Qxnd5/ATLz1vfg1h
0uZesc1w+bfikB2Wg6KtaveBtEPJbzMUHI0alpyevi0Y2oswUZ9FKmLSsaDXmQAm
9Y8vwP0TZZW/G2868ilGJLMy5w66eUcSC6Mixiylhe/7SvieSmTK81Bp6vgZur3z
Fmfyjq6XCgDGA2aGgqbIaDAZbWiBNg==
=rfJ4
-----END PGP SIGNATURE-----

--zhj4RK4pWGOqEvNg--


--===============6074169775916468122==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============6074169775916468122==--

