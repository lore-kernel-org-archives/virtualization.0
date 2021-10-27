Return-Path: <SRS0=5D8L=PP=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 200BFC433EF
	for <virtualization@archiver.kernel.org>; Wed, 27 Oct 2021 09:03:57 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B959F60EB4
	for <virtualization@archiver.kernel.org>; Wed, 27 Oct 2021 09:03:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B959F60EB4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7CF6A40207;
	Wed, 27 Oct 2021 09:03:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xHqxQcxE66Nk; Wed, 27 Oct 2021 09:03:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 2806A401F0;
	Wed, 27 Oct 2021 09:03:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E4040C0019;
	Wed, 27 Oct 2021 09:03:54 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4E377C000E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Oct 2021 09:03:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 31D5C40238
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Oct 2021 09:03:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8t1MiJrTeLUa
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Oct 2021 09:03:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 49A5A401D6
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Oct 2021 09:03:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1635325432;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HiJPaiuyZPbcdwIA9KdMWyKh2jI2bcomXoBjA/5KsHk=;
 b=JrKZ7qbTv3O/kcTpfaXjaMGfCaXIS97lxYuqpTmBelBoJm8+cJ7opdF8GDhpPe2s1rxnyh
 bRTPSHPaRuENQV2qxZyfKCv11UCekj8/Bh9T8BkW0HfTL/kk946XuUXrSvPZq2xA4PIdZL
 oWEGfOy2XCQT/ZGl+spMoFzZoFXXwu4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-324-2IE4rjOqM8SdmhK3Pzt2HQ-1; Wed, 27 Oct 2021 05:03:48 -0400
X-MC-Unique: 2IE4rjOqM8SdmhK3Pzt2HQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A90189126B;
 Wed, 27 Oct 2021 09:03:47 +0000 (UTC)
Received: from localhost (unknown [10.39.195.83])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6FCDD5F4EE;
 Wed, 27 Oct 2021 09:03:44 +0000 (UTC)
Date: Wed, 27 Oct 2021 10:03:43 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: michael.christie@oracle.com
Subject: Re: [PATCH V3 11/11] vhost: allow userspace to create workers
Message-ID: <YXkV73jK7fNGzcoX@stefanha-x1.localdomain>
References: <20211022051911.108383-1-michael.christie@oracle.com>
 <20211022051911.108383-13-michael.christie@oracle.com>
 <8aee8f07-76bd-f111-bc5f-fc5cad46ce56@redhat.com>
 <4d33b7e1-5efb-3729-ee15-98608704f096@oracle.com>
MIME-Version: 1.0
In-Reply-To: <4d33b7e1-5efb-3729-ee15-98608704f096@oracle.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Cc: linux-scsi@vger.kernel.org, mst@redhat.com,
 virtualization@lists.linux-foundation.org, target-devel@vger.kernel.org,
 pbonzini@redhat.com
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
Content-Type: multipart/mixed; boundary="===============6082121303299843387=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>


--===============6082121303299843387==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="7VOiUeZYb/rbOPB5"
Content-Disposition: inline


--7VOiUeZYb/rbOPB5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 26, 2021 at 11:49:37AM -0500, michael.christie@oracle.com wrote:
> On 10/26/21 12:37 AM, Jason Wang wrote:
> > Do we need VHOST_VRING_FREE_WORKER? And I wonder if using dedicated ioc=
tls are better:
> >=20
> > VHOST_VRING_NEW/FREE_WORKER
> > VHOST_VRING_ATTACH_WORKER
>=20
>=20
> We didn't need a free worker, because the kernel handles it for userspace=
=2E I
> tried to make it easy for userspace because in some cases it may not be a=
ble
> to do syscalls like close on the device. For example if qemu crashes or f=
or
> vhost-scsi we don't do an explicit close during VM shutdown.
>=20
> So we start off with the default worker thread that's used by all vqs lik=
e we do
> today. Userspace can then override it by creating a new worker. That also=
 unbinds/
> detaches the existing worker and does a put on the workers refcount. We a=
lso do a
> put on the worker when we stop using it during device shutdown/closure/re=
lease.
> When the worker's refcount goes to zero the kernel deletes it.

Please document the worker (p)id lifetime for the ioctl. Otherwise
userspace doesn't know whether a previously created worker is still
alive.

SSTefan

--7VOiUeZYb/rbOPB5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmF5Fe8ACgkQnKSrs4Gr
c8jfMwf/WNxR+7YZbmsVZ+oUXAYb2qAG6sPNc4zPOt3GHye/2a0FuI59d6dKn/R9
aNuf1C/a5YMTigcqOSnV3pHjLEjQP7hHElDGJJIePNJqHTRf8rgRHX/+ORalRu24
HH6CkCfGvwKkfztFa1jjwc9e6YNjtSVXBsPcD9EV3WQ7ZO5BaRBL8fiEcoHWmhRJ
8YUO6TCv+aSZFltkM+9G3DBf90SPrcwixImuesvbP8J455/zAwBg4tYns0YLZvW5
4PcbVP56MyoThHzbfA7g8FFLct9zDr4cFGYjuq+q8YX2da+dILEY/5PHkjPzWKcp
ahFfycIxAyGsIcgqEtpcu7WC0HIFVg==
=87xD
-----END PGP SIGNATURE-----

--7VOiUeZYb/rbOPB5--


--===============6082121303299843387==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============6082121303299843387==--

