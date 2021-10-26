Return-Path: <SRS0=tl6X=PO=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0575EC433EF
	for <virtualization@archiver.kernel.org>; Tue, 26 Oct 2021 16:37:16 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B32160EC0
	for <virtualization@archiver.kernel.org>; Tue, 26 Oct 2021 16:37:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9B32160EC0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 66FC38176C;
	Tue, 26 Oct 2021 16:37:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id veOSt7ehzYDZ; Tue, 26 Oct 2021 16:37:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 219D381765;
	Tue, 26 Oct 2021 16:37:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DBF97C0012;
	Tue, 26 Oct 2021 16:37:13 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C6130C000E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Oct 2021 16:37:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B5351608CE
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Oct 2021 16:37:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id L-otWppXXbpA
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Oct 2021 16:37:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id BAAE160774
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Oct 2021 16:37:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1635266228;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Az0qkUpjldfbOLg6I432oCB5a4nNHQuU76umLMMYadU=;
 b=duN2nvMp4mudD4Hmz2y0wFGcehnQvXZI5nI83DM8FOytskhKQtw4zLlGj3ME5AMghXUf2h
 xNbbRdDiwoJnZDDXgOZo9paSZUqPU9fAyEwyBfqDc30Pu5dfjqSDGTg2CkIP9XXQpDvC5e
 TqgxjOYpEdNWgtmu3jXLwZNJtyBwaF8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-578-ofjAw7OzNPiZ9ZDYuJ9RoA-1; Tue, 26 Oct 2021 12:37:06 -0400
X-MC-Unique: ofjAw7OzNPiZ9ZDYuJ9RoA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AF0C3806688;
 Tue, 26 Oct 2021 16:37:05 +0000 (UTC)
Received: from localhost (unknown [10.39.195.43])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 53A785FC13;
 Tue, 26 Oct 2021 16:36:57 +0000 (UTC)
Date: Tue, 26 Oct 2021 17:36:56 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH V3 11/11] vhost: allow userspace to create workers
Message-ID: <YXguqJmsWVEnrgA7@stefanha-x1.localdomain>
References: <20211022051911.108383-1-michael.christie@oracle.com>
 <20211022051911.108383-13-michael.christie@oracle.com>
 <8aee8f07-76bd-f111-bc5f-fc5cad46ce56@redhat.com>
 <20211026090923-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20211026090923-mutt-send-email-mst@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Cc: linux-scsi@vger.kernel.org, virtualization@lists.linux-foundation.org,
 target-devel@vger.kernel.org, pbonzini@redhat.com
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
Content-Type: multipart/mixed; boundary="===============5645717856936566971=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>


--===============5645717856936566971==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="1ineXJazAgcBuxtr"
Content-Disposition: inline


--1ineXJazAgcBuxtr
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 26, 2021 at 09:09:52AM -0400, Michael S. Tsirkin wrote:
> On Tue, Oct 26, 2021 at 01:37:14PM +0800, Jason Wang wrote:
> >=20
> > =E5=9C=A8 2021/10/22 =E4=B8=8B=E5=8D=881:19, Mike Christie =E5=86=99=E9=
=81=93:
> > > This patch allows userspace to create workers and bind them to vqs. Y=
ou
> > > can have N workers per dev and also share N workers with M vqs.
> > >=20
> > > Signed-off-by: Mike Christie <michael.christie@oracle.com>
> >=20
> >=20
> > A question, who is the best one to determine the binding? Is it the VMM
> > (Qemu etc) or the management stack? If the latter, it looks to me it's
> > better to expose this via sysfs?
>=20
> I think it's a bit much to expect this from management.

The management stack controls the number of vqs used as well as the vCPU
and IOThread CPU affinity. It seems natural for it to also control the
vhost worker CPU affinity. Where else should that be controlled?

Stefan

--1ineXJazAgcBuxtr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmF4LqgACgkQnKSrs4Gr
c8iD5wgAsuJ8yfTtumt6et4Z9rKxpsJsIoaFnmQPbxkXAOBMuTqZ2viOvqn1dIfo
niOTLg4+L9z5Gns9Lhew9DfnZZit0SQqra+DAwswoUxBw6vxuzhO7ZkBfzK7H59m
fQj/yd//kENNW/sTpnMaYk13FpvtXSMhWmm93Kp2hBExvrJoXoqf9UF4Cc06KDjf
rBtXEbSifXixOEdboxaQTDD3a5aycpYdpm7DtaBlIw7698jymOY/uR0lQ6AfeHj5
qbskHy+VKwOwPvmQtk41QHz4rT8BsZSLpJQ24ZFzUDr7sJisbBM1Ula0NkI16GPZ
sd1S1pC5t+Ke/8RvzSXeB26xaBbOuw==
=EGIY
-----END PGP SIGNATURE-----

--1ineXJazAgcBuxtr--


--===============5645717856936566971==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============5645717856936566971==--

