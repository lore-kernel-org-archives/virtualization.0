Return-Path: <SRS0=uiEo=LE=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93896C48BD1
	for <virtualization@archiver.kernel.org>; Thu, 10 Jun 2021 08:06:42 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A78D613CB
	for <virtualization@archiver.kernel.org>; Thu, 10 Jun 2021 08:06:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A78D613CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 0EA5B4014B;
	Thu, 10 Jun 2021 08:06:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8L6zBDmYhqrA; Thu, 10 Jun 2021 08:06:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 8CB0D400C9;
	Thu, 10 Jun 2021 08:06:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 454B8C000E;
	Thu, 10 Jun 2021 08:06:40 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AAD1EC000B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Jun 2021 08:06:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 86406405B4
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Jun 2021 08:06:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Ilz5cBq8eoUg
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Jun 2021 08:06:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 07686405B0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Jun 2021 08:06:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1623312395;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IPnBtwHVsxTEGxlAHkETtzkbihoyU00inj0Cc3YSw0Y=;
 b=a8dlYw6OW2+y7S1ZYK+y4lmK12kH8nW3ckoD7Mx7IUHUmIpkhbNSSqeizi/XJmzNdmgnhu
 CAiRlWTDTwuJgrxiXuSo7RMRvbi5Zo5k4rwLsff5g4mVabPh8IFobTy5OwrmgwRxiJs+3i
 I9FWE9ibDMkRYrM95I06L5AnG5Iff3k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-282-DZJ-woXwOAiu5yg1c0Zz4g-1; Thu, 10 Jun 2021 04:06:23 -0400
X-MC-Unique: DZJ-woXwOAiu5yg1c0Zz4g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C3685803622;
 Thu, 10 Jun 2021 08:06:22 +0000 (UTC)
Received: from localhost (ovpn-114-58.ams2.redhat.com [10.36.114.58])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0B4F15D6AD;
 Thu, 10 Jun 2021 08:06:18 +0000 (UTC)
Date: Thu, 10 Jun 2021 09:06:17 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Mike Christie <michael.christie@oracle.com>
Subject: Re: [PATCH 7/9] vhost: allow userspace to create workers
Message-ID: <YMHH+das0nmMBbt5@stefanha-x1.localdomain>
References: <20210525180600.6349-1-michael.christie@oracle.com>
 <20210525180600.6349-8-michael.christie@oracle.com>
 <YLjnk5GpFaCCOqCU@stefanha-x1.localdomain>
 <0c1aef53-4850-8c46-0706-9b7276716e68@oracle.com>
 <YL45CfpHyzSEcAJv@stefanha-x1.localdomain>
 <6882ef4d-8382-5b0d-272e-779e6fa9e7da@oracle.com>
MIME-Version: 1.0
In-Reply-To: <6882ef4d-8382-5b0d-272e-779e6fa9e7da@oracle.com>
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
Content-Type: multipart/mixed; boundary="===============4744516271042060463=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>


--===============4744516271042060463==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="WkdUzt4415XdCfLw"
Content-Disposition: inline


--WkdUzt4415XdCfLw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 09, 2021 at 04:03:55PM -0500, Mike Christie wrote:
> On 6/7/21 10:19 AM, Stefan Hajnoczi wrote:
> > My concern is that threads should probably accounted against
> > RLIMIT_NPROC and max_threads rather than something indirect like 128 *
> > RLIMIT_NOFILE (a userspace process can only have RLIMIT_NOFILE
> > vhost-user file descriptors open).
> >=20
>=20
> Ah ok, I see what you want I think.
>=20
> Ok, I think the options are:
>=20
> 0. Nothing. Just use existing indirect/RLIMIT_NOFILE.
>=20
> 1. Do something like io_uring's create_io_thread/copy_process. If we call
> copy_process from the vhost ioctl context, then the userspace process that
> did the ioctl will have it's processes count incremented and checked agai=
nst
> its rlimit.
>=20
> The drawbacks:
> - This gets a little more complicated than just calling copy_process thou=
gh.
> We end up duplicating a lot of the kthread API.
> - We have to deal with new error cases like the parent exiting early.
> - I think all devs sharing a worker have to have the same owner. kthread_=
use_mm
> and kthread_unuse_mm to switch between mm's for differrent owner's devs s=
eem to
> be causing lots of errors. I'm still looking into this one though.
>=20
> 2.  It's not really what you want, but for unbound work io_uring has a ch=
eck for
> RLIMIT_NPROC in the io_uring code. It does:
>=20
> wqe->acct[IO_WQ_ACCT_UNBOUND].max_workers =3D
> 					task_rlimit(current, RLIMIT_NPROC);
>=20
> then does:
>=20
> if (!ret && acct->nr_workers < acct->max_workers) {
>=20
> Drawbacks:
> In vhost.c, we could do something similar. It would make sure that vhost.=
c does
> not create more worker threads than the rlimit value, but we wouldn't be
> incrementing the userspace process's process count. The userspace process=
 could
> then create RLIMIT_NPROC threads and vhost.c could also create RLIMIT_NPR=
OC
> threads, so we end up with 2 * RLIMIT_NPROC threads.

Yes, in that case we might as well go with Option 0, so I think this
option can be eliminated.

> 3. Change the kthread and copy_process code so we can pass in the thread
> (or it's creds or some struct that has the values that need to be check) =
that
> needs to be checked and updated.
>=20
> Drawback:
> This might be considered too ugly for how special case vhost is. For exam=
ple, we
> need checks/code like the io_thread/PF_IO_WORKER code in copy_process for=
 io_uring.
> I can see how added that for io_uring because it affects so many users, b=
ut I can
> see how vhost is not special enough.

This seems like the most general solution. If you try it and get
negative feedback then maybe the maintainers can help suggest how to
solve this problem :).

Stefan

--WkdUzt4415XdCfLw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmDBx/kACgkQnKSrs4Gr
c8hLZAgAjb6u+fG0CjpUwqxso7DnJpytbBfDy4wzRVp0110EZ7wdQ96FXcWGzgiq
TNdFfZMLHLzV6EmCZxdLGe6hmDvgO3Xmm+SV998QGty0mXDAu7VMqkuRHfw4+Jp2
4NbR9yxhNwtH/R9ZV6E4fXLcbWaBXtkjmZNXpBgYtcFGEcILKf6zUpzilb5gNQT4
zRWd5YWNkubtsCM6mETxD7bJR8V4xTNrM7ct3ESxNyA+B1svPAvqqinURb01GbQ/
L4Fjkh+0wAj1y/QJzmej+6atPVZ0MdiMRiq4JnZLbpHCVpsFGxnyPD5gPj6UeFKQ
Ap5rFMZOnLQZkvWLVGvSK01LkqpSYg==
=oEH5
-----END PGP SIGNATURE-----

--WkdUzt4415XdCfLw--


--===============4744516271042060463==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============4744516271042060463==--

