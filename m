Return-Path: <SRS0=+b5l=LW=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DATE_IN_PAST_96_XX,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,URIBL_RED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA716C2B9F4
	for <virtualization@archiver.kernel.org>; Mon, 28 Jun 2021 13:01:53 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BFC461C69
	for <virtualization@archiver.kernel.org>; Mon, 28 Jun 2021 13:01:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BFC461C69
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 10E5440387;
	Mon, 28 Jun 2021 13:01:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id aQG1sG7QvW9d; Mon, 28 Jun 2021 13:01:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 574AA40373;
	Mon, 28 Jun 2021 13:01:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 312A8C001A;
	Mon, 28 Jun 2021 13:01:51 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0603BC000E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Jun 2021 13:01:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id DC7BD6058D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Jun 2021 13:01:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PQKxbwLY0lZb
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Jun 2021 13:01:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2EF996058B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Jun 2021 13:01:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1624885307;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yN2gKWfYSS2BvZ25yeJRmT/Gg0ySnY/1p9C8SnCeINA=;
 b=OA4wX64iYjbdmkNautWRTk0RzLM5vE0kIi6uDrVajqw906sY9o3oCEcFH42vTqVY5CzdKM
 9XQK7zHpU6zrzse0arU4c8vnqsVeYFOoYjC1Wa/2Rc+1jJk1ntQEOik+7ErfDiQ63TXEGl
 ZPQlvlgJq+L7o5wGLut12twwFrWLo80=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-274-6udnZiKlNlmnouAkGCPhCg-1; Mon, 28 Jun 2021 09:01:45 -0400
X-MC-Unique: 6udnZiKlNlmnouAkGCPhCg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E7FA3804308;
 Mon, 28 Jun 2021 13:01:43 +0000 (UTC)
Received: from localhost (ovpn-112-170.ams2.redhat.com [10.36.112.170])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 30B7B5C1CF;
 Mon, 28 Jun 2021 13:01:40 +0000 (UTC)
Date: Thu, 24 Jun 2021 10:40:52 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Mike Christie <michael.christie@oracle.com>
Subject: Re: [PATCH 0/3] kthread: pass in user and check RLIMIT_NPROC
Message-ID: <YNRTJFHxSlUSEqL5@stefanha-x1.localdomain>
References: <20210624030804.4932-1-michael.christie@oracle.com>
MIME-Version: 1.0
In-Reply-To: <20210624030804.4932-1-michael.christie@oracle.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Cc: mst@redhat.com, peterz@infradead.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, akpm@linux-foundation.org,
 christian.brauner@ubuntu.com, christian@brauner.io
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
Content-Type: multipart/mixed; boundary="===============9159371617686752707=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>


--===============9159371617686752707==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="tAINK5wpSU1Wy0aE"
Content-Disposition: inline


--tAINK5wpSU1Wy0aE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 23, 2021 at 10:08:01PM -0500, Mike Christie wrote:
> The vhost driver will create a kthread when userspace does a
> VHOST_SET_OWNER ioctl, but the thread is charged to the kthreadd thread.
> We can then end up violating the userspace process's RLIMIT_NPROC. This
> patchset allows drivers to pass in the user to charge/check.
>=20
> The patches were made over Linus's current tree.

Makes sense from a vhost perspective and for future users, but I'm not
familiar with the kthread internals:

Acked-by: Stefan Hajnoczi <stefanha@redhat.com>

--tAINK5wpSU1Wy0aE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmDUUyQACgkQnKSrs4Gr
c8h3ugf/SnO91w5rQo5ExA9DoePrMOZqkuNg6cgYqUlV25038PRp49kMp9I9fUXD
JuoebkNTOpavvl1JtW8auitS2pQkvkdLb4VkmzqgGBgQROmpik5sH7H9QACCh0oh
huSYZVkw9PTEyo6fMnKr97+RoGncP/hORtADOuS8VfoMjhADfl0d/QIwBIilOmEA
72x1CQQzVhzmgOp7wK7uBgWGDzA7RoesQHpQhtOidvmwnpSIIa3GZJwn58jM/NJK
+SScwhri8pg/zUGI0wboBpX7HCbkp3U5qF84WiOksuYSFZ3ojnqao9WTdXOVSbdK
3DO/IaTA19tStIHHvcBdAiUuRohZXg==
=dvls
-----END PGP SIGNATURE-----

--tAINK5wpSU1Wy0aE--


--===============9159371617686752707==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============9159371617686752707==--

