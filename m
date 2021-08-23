Return-Path: <SRS0=r7vL=NO=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1F62C4338F
	for <virtualization@archiver.kernel.org>; Mon, 23 Aug 2021 10:05:18 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8813561378
	for <virtualization@archiver.kernel.org>; Mon, 23 Aug 2021 10:05:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8813561378
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5033160609;
	Mon, 23 Aug 2021 10:05:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id p3Qe-4XC27TM; Mon, 23 Aug 2021 10:05:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 36D11605BE;
	Mon, 23 Aug 2021 10:05:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EB008C001A;
	Mon, 23 Aug 2021 10:05:12 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4DB22C000E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 Aug 2021 10:05:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2F73E605E2
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 Aug 2021 10:05:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id G8KNrItefcbR
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 Aug 2021 10:05:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A9BDB605BE
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 Aug 2021 10:05:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1629713105;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vt2o0y6T/PidcpWu/Q2Vn+bKqtgu+iFP1bn5zMbE4Wo=;
 b=ekylQ098+bIncmL81SG6rhbZaiv5jeEyjpBjZFkeaG7wURRC3RV/+L8+jCoJUXgTskTQ9U
 dTubv0+OAeRpQ/6cKnShQbUkkocSSjLMv4r57IEbYsEue1tFapKvuYoKRiDKxlmo6D1M9m
 nSFQv4NWyhCA2VF5ahL/dmINYhxK+DA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-567-SQxE48x9NB-gP2eBAC56NA-1; Mon, 23 Aug 2021 06:04:34 -0400
X-MC-Unique: SQxE48x9NB-gP2eBAC56NA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E19C0801A92;
 Mon, 23 Aug 2021 10:04:32 +0000 (UTC)
Received: from localhost (unknown [10.39.194.67])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1D1F15D9D3;
 Mon, 23 Aug 2021 10:04:29 +0000 (UTC)
Date: Mon, 23 Aug 2021 11:04:23 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Cai Huoqing <caihuoqing@baidu.com>
Subject: Re: [PATCH] vhost scsi: Convert to SPDX identifier
Message-ID: <YSNyp3VpgEgX/53I@stefanha-x1.localdomain>
References: <20210821123320.734-1-caihuoqing@baidu.com>
MIME-Version: 1.0
In-Reply-To: <20210821123320.734-1-caihuoqing@baidu.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Cc: kvm@vger.kernel.org, mst@redhat.com,
 virtualization@lists.linux-foundation.org, pbonzini@redhat.com,
 nab@daterainc.com
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
Content-Type: multipart/mixed; boundary="===============0142111833185071145=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>


--===============0142111833185071145==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="6h2eKcyYkGGKJcwh"
Content-Disposition: inline


--6h2eKcyYkGGKJcwh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 21, 2021 at 08:33:20PM +0800, Cai Huoqing wrote:
> use SPDX-License-Identifier instead of a verbose license text
>=20
> Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
> ---
>  drivers/vhost/scsi.c | 14 +-------------
>  1 file changed, 1 insertion(+), 13 deletions(-)

I have CCed Nic.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

> diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
> index 46f897e41217..532e204f2b1b 100644
> --- a/drivers/vhost/scsi.c
> +++ b/drivers/vhost/scsi.c
> @@ -1,24 +1,12 @@
> +// SPDX-License-Identifier: GPL-2.0+
>  /***********************************************************************=
********
>   * Vhost kernel TCM fabric driver for virtio SCSI initiators
>   *
>   * (C) Copyright 2010-2013 Datera, Inc.
>   * (C) Copyright 2010-2012 IBM Corp.
>   *
> - * Licensed to the Linux Foundation under the General Public License (GP=
L) version 2.
> - *
>   * Authors: Nicholas A. Bellinger <nab@daterainc.com>
>   *          Stefan Hajnoczi <stefanha@linux.vnet.ibm.com>
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License as published by
> - * the Free Software Foundation; either version 2 of the License, or
> - * (at your option) any later version.
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - * GNU General Public License for more details.
> - *
>   ***********************************************************************=
*****/
> =20
>  #include <linux/module.h>
> --=20
> 2.25.1
>=20

--6h2eKcyYkGGKJcwh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmEjcqcACgkQnKSrs4Gr
c8huGgf9EGXjN0ece/7icZoSIWIeooKpfRYrOTF35aW6dhXKXoXO2NYFlTqmwI6b
nl3jRY4jGk3htjwg1Axp9Yvd781YY16jqkEOSHJ9jaq7TpC9H65EKDUMlmzKzIYK
LZnsQltlwjnksFZxZQas/oX6RyE6K27xaKGOA0wYRDrIzdo3rOlWJyY+m6VLnPVt
Qs6bV39ZGVnRZgM49LmBHZw/MMq8hcrpjacCTPzno1T5HS/1KjISVgIpBCg6nxUL
5DzKB+3UnW8M0ow8OOmxz+8WsuTq+dSmCYE2WSoYHPEjL+Rjci76RUIiXhHAguIO
m2dVbB4tYyR+rrFytQrORTOSVVMrxA==
=LmNU
-----END PGP SIGNATURE-----

--6h2eKcyYkGGKJcwh--


--===============0142111833185071145==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============0142111833185071145==--

