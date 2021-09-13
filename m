Return-Path: <SRS0=Do4E=OD=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E649CC433FE
	for <virtualization@archiver.kernel.org>; Mon, 13 Sep 2021 12:05:16 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E893610A3
	for <virtualization@archiver.kernel.org>; Mon, 13 Sep 2021 12:05:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7E893610A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 423EB40362;
	Mon, 13 Sep 2021 12:05:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id A4mN-cBRBxSf; Mon, 13 Sep 2021 12:05:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id DCF6240232;
	Mon, 13 Sep 2021 12:05:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AF9E8C000F;
	Mon, 13 Sep 2021 12:05:14 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 196A0C000D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Sep 2021 12:05:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 056A3605C8
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Sep 2021 12:05:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GCVAA-YC0kRY
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Sep 2021 12:05:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 647AC605BA
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Sep 2021 12:05:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1631534711;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Y2V1xD45BymJlhmyK56YaoVflozzkNCaUFnnSN8deNA=;
 b=DtqZsI9koHwhwaUy1H8Iw7+qd4XksLZFqW2KeNS2dFh+FMfkWm4GG1/j7mZgHjyE0MjQox
 DZT6KOTfUjPyTtC0ENxNSvD0pJFVxcxpNNJJlCme4vwwx4dPutXtLbKiKDOyUYTAvTp6bV
 G87V+zHy5D3KD5ImCCc1gpIoARvXkJM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-514-r0iJ8p1lPY20wHocXZejiA-1; Mon, 13 Sep 2021 08:05:09 -0400
X-MC-Unique: r0iJ8p1lPY20wHocXZejiA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 910A380006E;
 Mon, 13 Sep 2021 12:05:08 +0000 (UTC)
Received: from localhost (unknown [10.39.195.28])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 51A4C4180;
 Mon, 13 Sep 2021 12:05:03 +0000 (UTC)
Date: Mon, 13 Sep 2021 13:05:02 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH 1/9] virtio-blk: validate num_queues during probe
Message-ID: <YT8+bhzt5uy3PBzD@stefanha-x1.localdomain>
References: <20210913055353.35219-1-jasowang@redhat.com>
 <20210913055353.35219-2-jasowang@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20210913055353.35219-2-jasowang@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Cc: david.kaplan@amd.com, konrad.wilk@oracle.com, f.hetzelt@tu-berlin.de,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 mst@redhat.com, Paolo Bonzini <pbonzini@redhat.com>
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
Content-Type: multipart/mixed; boundary="===============1163279237475703895=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>


--===============1163279237475703895==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="TYQ9xRefSpUSapXV"
Content-Disposition: inline


--TYQ9xRefSpUSapXV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 13, 2021 at 01:53:45PM +0800, Jason Wang wrote:
> If an untrusted device neogitates BLK_F_MQ but advertises a zero
> num_queues, the driver may end up trying to allocating zero size
> buffers where ZERO_SIZE_PTR is returned which may pass the checking
> against the NULL. This will lead unexpected results.
>=20
> Fixing this by using single queue if num_queues is zero.
>=20
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  drivers/block/virtio_blk.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--TYQ9xRefSpUSapXV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmE/Pm4ACgkQnKSrs4Gr
c8iH2AgAu2/zVPkm3h8QB33TiU7b3MgZx1rNvvDlWVmPXVNk5z/ibtU893Zqbz5k
5b/ir6SryiQCzsNHJ6dWLWZkpeEb5/puRlX3TrkOIKCvRXwW99C3v+F5H7PSmsHK
suAQ3qOXr8d0wKP3abOEbuA6Kc1/IOESqt8R46x5WY/ivrSO0+Hv3T9Q8qARJDof
bS/1hEea6dVAYGCtqENC0qQn/utltrIlReSohiKgQcKWwdq+M8iSiOc4BjLHZLnm
/vBvQbyGF9bhgHavnJ4UdHHG+3rV/rIxpL/JvAtk2EldNxyWqFinm+hKTlXVt814
4YMu8qCcYN4fZrklAyED5F5xFl1wJw==
=47Nn
-----END PGP SIGNATURE-----

--TYQ9xRefSpUSapXV--


--===============1163279237475703895==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============1163279237475703895==--

