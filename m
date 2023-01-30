Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1C2CC54EAA
	for <virtualization@archiver.kernel.org>; Mon, 30 Jan 2023 19:33:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7B0F581EAB;
	Mon, 30 Jan 2023 19:33:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7B0F581EAB
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WWy6zbdA
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 43UB08UJHnLi; Mon, 30 Jan 2023 19:33:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id B182A81EA3;
	Mon, 30 Jan 2023 19:33:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B182A81EA3
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 885C1C0032;
	Mon, 30 Jan 2023 19:33:30 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4DC6DC002B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Jan 2023 19:33:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id EB79841862
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Jan 2023 19:33:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org EB79841862
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=WWy6zbdA
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Ek5-iCl0tSql
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Jan 2023 19:33:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org CFA8941814
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id CFA8941814
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Jan 2023 19:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1675107205;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=B3zRnSLp2ynUX7qdmnYkoyQsTORE3q5pAz8/tYex2W8=;
 b=WWy6zbdAUUFvwRycDC13jNFpv2qNuwxzd/ezpdXLhtOYpxat1uEWkG4XIsGWRI9xAqaoPy
 P0WOP8DPTnbN1tVjQipmTdOggY1LK8y12JgmAlTeWmCSG9L6W0f7xj7DD2iONXZHXH6kLI
 tFdHUrGzXGChTBJCqE5/gTe+Q5ReEME=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-631-x27mjU13MBiDmS4SpAKpeg-1; Mon, 30 Jan 2023 14:33:18 -0500
X-MC-Unique: x27mjU13MBiDmS4SpAKpeg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5481E1C07548;
 Mon, 30 Jan 2023 19:33:18 +0000 (UTC)
Received: from localhost (unknown [10.39.195.80])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AC7EE2026D4B;
 Mon, 30 Jan 2023 19:33:17 +0000 (UTC)
Date: Mon, 30 Jan 2023 14:33:15 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Bo Liu <liubo03@inspur.com>
Subject: Re: [PATCH] vhost-scsi: convert sysfs snprintf and sprintf to
 sysfs_emit
Message-ID: <Y9gbe+Pr5AcGbcta@fedora>
References: <20230129091145.2837-1-liubo03@inspur.com>
MIME-Version: 1.0
In-Reply-To: <20230129091145.2837-1-liubo03@inspur.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Cc: kvm@vger.kernel.org, mst@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
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
Content-Type: multipart/mixed; boundary="===============2930199684921385391=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>


--===============2930199684921385391==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="zXZMPvM7BUyVfKwq"
Content-Disposition: inline


--zXZMPvM7BUyVfKwq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 29, 2023 at 04:11:45AM -0500, Bo Liu wrote:
> Follow the advice of the Documentation/filesystems/sysfs.rst
> and show() should only use sysfs_emit() or sysfs_emit_at()
> when formatting the value to be returned to user space.
>=20
> Signed-off-by: Bo Liu <liubo03@inspur.com>
> ---
>  drivers/vhost/scsi.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--zXZMPvM7BUyVfKwq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmPYG3sACgkQnKSrs4Gr
c8hxvwf7B5Mbqo82xgBpjBde9q1dmi1tzl28i35KjgqCpyf6DNJNI7r+MrkPyIuw
mGOZjZ3icMd82hcJVEi0XIP8A6eUOsqKPzob4h6w28sRV0kfqmvgSPh9zpRXf8PR
G43mj1UArMtXj2mPqW4NTF3sgTLXJl+sZiDWvIVQIUuNjbtkxZ89fSZ5cH8AwdRy
Yb3EQ8TRhb5xpfcYj0EPIM/nFUpyQPZxIKZpg2OeTpv0QZ6ZSo+2kiXYQSE1Cljl
j2F8xN8OsOhzS2JTCBr777dn7JIHWjKvQvz0u2d4WBqkWw5O2P9Ea90IU5rPK28X
K8iZ3SXmteQjQsroywTO/jHtYylj8g==
=EEEC
-----END PGP SIGNATURE-----

--zXZMPvM7BUyVfKwq--


--===============2930199684921385391==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============2930199684921385391==--

