Return-Path: <SRS0=cU2J=K5=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D03E9C47082
	for <virtualization@archiver.kernel.org>; Thu,  3 Jun 2021 14:38:15 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59E29613BA
	for <virtualization@archiver.kernel.org>; Thu,  3 Jun 2021 14:38:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59E29613BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2248B60B25;
	Thu,  3 Jun 2021 14:38:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id u0Xx4kS3cuP9; Thu,  3 Jun 2021 14:38:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id C385660811;
	Thu,  3 Jun 2021 14:38:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 99191C000D;
	Thu,  3 Jun 2021 14:38:10 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 06BFBC0001
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Jun 2021 14:38:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E5E3A60682
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Jun 2021 14:38:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PDvkfusqdYs5
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Jun 2021 14:38:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 27C0460811
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Jun 2021 14:38:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1622731082;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=awF3rK7dRpOei0bYGNfeYmW5cxqhvdc1qb6GqP+cefk=;
 b=Q+AJfK7+j6pnrg8LtTGcNuptWgSNiBBwuSL3lCpVTlFOygpBkudDQBePzfGZArBb7kYHOD
 35lsIyIABl1hyW6KNEItDuWjG+Ma87Mt0gYfzhXD5/CfvcVGM80pECpfkRb81wHunotdMn
 9F26kn3t65nnKLnSKTSa8eqP2oZw3Xk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-515-fr8FIAB6M32CRVDe3Mhacw-1; Thu, 03 Jun 2021 10:37:43 -0400
X-MC-Unique: fr8FIAB6M32CRVDe3Mhacw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 06865805EF2;
 Thu,  3 Jun 2021 14:37:42 +0000 (UTC)
Received: from localhost (ovpn-114-228.ams2.redhat.com [10.36.114.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 924535D705;
 Thu,  3 Jun 2021 14:37:38 +0000 (UTC)
Date: Thu, 3 Jun 2021 15:37:37 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Mike Christie <michael.christie@oracle.com>
Subject: Re: vhost: multiple worker support
Message-ID: <YLjpMXbfJsaLrgF5@stefanha-x1.localdomain>
References: <20210525180600.6349-1-michael.christie@oracle.com>
MIME-Version: 1.0
In-Reply-To: <20210525180600.6349-1-michael.christie@oracle.com>
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
Content-Type: multipart/mixed; boundary="===============0380628033513256850=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>


--===============0380628033513256850==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="H4b3lFVzSqimIVsY"
Content-Disposition: inline


--H4b3lFVzSqimIVsY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 25, 2021 at 01:05:51PM -0500, Mike Christie wrote:
> The following patches apply over linus's tree or mst's vhost branch
> and my cleanup patchset:
>=20
> https://lists.linuxfoundation.org/pipermail/virtualization/2021-May/05435=
4.html
>=20
> These patches allow us to support multiple vhost workers per device. I
> ended up just doing Stefan's original idea where userspace has the
> kernel create a worker and we pass back the pid. This has the benefit
> over the workqueue and userspace thread approach where we only have
> one'ish code path in the kernel during setup to detect old tools. The
> main IO paths and device/vq setup/teardown paths all use common code.
>=20
> The kernel patches here allow us to then do N workers device and also
> share workers across devices.
>=20
> I've also included a patch for qemu so you can get an idea of how it
> works. If we are ok with the kernel code then I'll break that up into
> a patchset and send to qemu-devel.

It seems risky to allow userspace process A to "share" a vhost worker
thread with userspace process B based on a matching pid alone. Should
they have ptrace_may_access() or similar?

For example, two competing users could sabotague each other by running
lots of work items on their competitor's vhost worker thread.

--H4b3lFVzSqimIVsY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmC46TEACgkQnKSrs4Gr
c8haPggAr/8lGql69lIQrCD9sUNPvVDvTO3r+S7svNqfhMUpvJ+df1CrE/hWLnzc
H++l75ZD8kBFbsem2XbZ4S7wkcOU2iF21BKNhSUu+Mw6S0kzE0Q1XXG1xDRWzmJs
rN5VguzigMJ1J/+/FqhKEjvWOgFQgQIpWWQ29qP+m91DMLZ3zB/boDfTMCYtBSGk
l0pW6WWfss5a9kie1YEkQ90I6BvIoDKUF5uDwoJvD3MweslUGDqjduJsBNlTWN1Y
ywvTkEiHAo+YJlNrQAuJkv1MR62wSoddxERu/3MGvuD/GRzYf2vSxsMFEbNL2P+O
iMKCMek0JfRa1u921sgglNbHQ9z1Wg==
=UByy
-----END PGP SIGNATURE-----

--H4b3lFVzSqimIVsY--


--===============0380628033513256850==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============0380628033513256850==--

