Return-Path: <SRS0=cU2J=K5=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FFDBC47082
	for <virtualization@archiver.kernel.org>; Thu,  3 Jun 2021 14:33:43 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0B91613D6
	for <virtualization@archiver.kernel.org>; Thu,  3 Jun 2021 14:33:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0B91613D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A7BF860820;
	Thu,  3 Jun 2021 14:33:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BmrAOJnXMtvJ; Thu,  3 Jun 2021 14:33:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id C1C92608DC;
	Thu,  3 Jun 2021 14:33:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 951B4C000D;
	Thu,  3 Jun 2021 14:33:37 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 62546C0001
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Jun 2021 14:33:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4F55F405B5
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Jun 2021 14:33:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GoD4ntIfqU-H
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Jun 2021 14:33:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 78224405BE
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Jun 2021 14:33:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1622730810;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ffqU2pTHvgdCYPe0Q2G5XamulxR8bjf1k2Ncp4K3ymc=;
 b=MZQiGvmzBomnEpoO0kmTp/9rzmiqo+45q9eCvyx+5mnPIuTK+lgo5i/NEz2v6kgkLvyakz
 tGPoqDqtEOa3iRInDoyHXy/WRGZlbjK4RIDxqqWLmu7SUJLdC67ytdLLltU2KAfNqA/BKk
 iYvHTd9s0fjaGyN+dNll8LL1OXkZFwo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-435-ixezL8r6NLerul-0h_8Tvg-1; Thu, 03 Jun 2021 10:32:53 -0400
X-MC-Unique: ixezL8r6NLerul-0h_8Tvg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E6FC319251AF;
 Thu,  3 Jun 2021 14:32:51 +0000 (UTC)
Received: from localhost (ovpn-114-228.ams2.redhat.com [10.36.114.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F05EF10023AB;
 Thu,  3 Jun 2021 14:32:47 +0000 (UTC)
Date: Thu, 3 Jun 2021 15:32:46 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Mike Christie <michael.christie@oracle.com>
Subject: Re: [PATCH 9/9] vhost: support sharing workers across devs
Message-ID: <YLjoDjas6ga3Ovad@stefanha-x1.localdomain>
References: <20210525180600.6349-1-michael.christie@oracle.com>
 <20210525180600.6349-10-michael.christie@oracle.com>
MIME-Version: 1.0
In-Reply-To: <20210525180600.6349-10-michael.christie@oracle.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
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
Content-Type: multipart/mixed; boundary="===============2750852010909408383=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>


--===============2750852010909408383==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Z17amfYzuCxbaWBX"
Content-Disposition: inline


--Z17amfYzuCxbaWBX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 25, 2021 at 01:06:00PM -0500, Mike Christie wrote:
> This allows a worker to handle multiple device's vqs.
>=20
> TODO:
> - The worker is attached to the cgroup of the device that created it. In
> this patch you can share workers with devices with different owners which
> could be in different cgroups. Do we want to restict sharing workers with
> devices that have the same owner (dev->mm value)?

Question for Michael or Jason.

--Z17amfYzuCxbaWBX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmC46A4ACgkQnKSrs4Gr
c8gPmgf/Vvk8j1U+cTELBrRn7FiW5F0i56uYi7uGSqGO7nC1ceRKUTl4kdOEdCJh
M7CtuhHM4rGFqReb68IKB6isGdJbobo9RA42azy4Jz60BZu1fPRzdF9Hqts+cAnW
2a74nuPIpys+Sr6QWcOOzayd7SJCYGIQqhPKEE3WmMMLMGfZqB3KDhPrBUSZGmf8
A6vCH6KhCv6NytVOsvlqNmHr2UHN+sxm91igFwIqajYwlbpZIo/4KI64Ttw+98RF
VfqHxb1QlVbLOIQyvrRAvbUcK/HdmyRezFPZ6gxGQkdIykvOAJnRXHujxYX4VzsI
V0rDVjKF3kmoDcSjt25mI9po/PHYbQ==
=7Wkj
-----END PGP SIGNATURE-----

--Z17amfYzuCxbaWBX--


--===============2750852010909408383==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============2750852010909408383==--

