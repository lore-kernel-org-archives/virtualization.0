Return-Path: <SRS0=GMN+=KG=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4276C43460
	for <virtualization@archiver.kernel.org>; Tue, 11 May 2021 10:23:26 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38D1C6192C
	for <virtualization@archiver.kernel.org>; Tue, 11 May 2021 10:23:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38D1C6192C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 90B2640EA2;
	Tue, 11 May 2021 10:23:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8XqpitoFtx4N; Tue, 11 May 2021 10:23:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id F224540EAB;
	Tue, 11 May 2021 10:23:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C4ED4C000E;
	Tue, 11 May 2021 10:23:23 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DD193C0001
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 May 2021 10:23:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D7DAE84532
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 May 2021 10:23:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Zelpm8mPuIyd
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 May 2021 10:23:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C745584527
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 May 2021 10:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1620728600;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=G0adrujpDKweoPEjP1QQ9qf3v1VudDZ63lGTmNiMcrI=;
 b=XIwT+5IOqNPtHwJocydOTitvF8vbFuON6hWMvGJVznM4bRVDnGznjL/meoV/+RkJ3MwA4e
 8aJ4N5OXDIV4qQJV1gDPd/SLEQ8jAJwmS8pjqkeJkI0/gCnxHL+9/bceW//IkvC1Rnjzwu
 CoS1yPOgHBRnqrulKAPk6DIVH1R6DiY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-360-Rsk5ItyUN_-KF78s2Vmb2g-1; Tue, 11 May 2021 06:23:17 -0400
X-MC-Unique: Rsk5ItyUN_-KF78s2Vmb2g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EAB8A1006C84;
 Tue, 11 May 2021 10:23:16 +0000 (UTC)
Received: from localhost (ovpn-112-6.ams2.redhat.com [10.36.112.6])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 557D2100164C;
 Tue, 11 May 2021 10:23:13 +0000 (UTC)
Date: Tue, 11 May 2021 11:23:12 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Connor Kuehl <ckuehl@redhat.com>
Subject: Re: [PATCH] virtiofs: Enable multiple request queues
Message-ID: <YJpbEMePhQ88EWWR@stefanha-x1.localdomain>
References: <20210507221527.699516-1-ckuehl@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20210507221527.699516-1-ckuehl@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, virtio-fs@redhat.com,
 linux-fsdevel@vger.kernel.org, Vivek Goyal <vgoyal@redhat.com>
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
Content-Type: multipart/mixed; boundary="===============1722881103763958927=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>


--===============1722881103763958927==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="A7V9ozvfxmSnLtjw"
Content-Disposition: inline


--A7V9ozvfxmSnLtjw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 07, 2021 at 05:15:27PM -0500, Connor Kuehl wrote:
> @@ -1245,7 +1262,8 @@ __releases(fiq->lock)
>  		 req->in.h.nodeid, req->in.h.len,
>  		 fuse_len_args(req->args->out_numargs, req->args->out_args));
> =20
> -	fsvq =3D &fs->vqs[queue_id];
> +	fsvq =3D this_cpu_read(this_cpu_fsvq);

Please check how CPU hotplug affects this patch. If the current CPU
doesn't have a vq because it was hotplugged, then it may be necessary to
pick another vq.

Stefan

--A7V9ozvfxmSnLtjw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmCaWxAACgkQnKSrs4Gr
c8gaYQf/ZbGTh/PBCw1PB2OJDsg9sJ/qLNSeJAXsrq1soajsgMZNL5qaCxFxca96
7Ct1XtEelrvOEivymGbnjYFnL3kDuTeYhPzlyPBwG9heVxBReVxmKaC18hm5GwKk
Qd481XSuaAF2gVk1B55pgfK4NwX/smvCgHpWvkP8vakZttXFUgMYcXM7Mi7V9XcJ
4f3EWA0m0iaWAkVJY2R+luPJtvc403igrv4QpUrw0kgn7iYw424W9O819g+Na4dO
8QdFtUmFHQsgwNVy6hKMnbhc7V0m3Hdwr2JVNXb2cd+yXqwVX+8xP3KeZOvBb5gX
hUibZHl+yf0GfluxoJUfjT8JXVtBDg==
=VnK4
-----END PGP SIGNATURE-----

--A7V9ozvfxmSnLtjw--


--===============1722881103763958927==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============1722881103763958927==--

