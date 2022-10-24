Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 211F3ECAAA1
	for <virtualization@archiver.kernel.org>; Mon, 24 Oct 2022 15:44:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9266160C17;
	Mon, 24 Oct 2022 15:44:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9266160C17
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=MLcB+pgz
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nA3X3c-Ls6dl; Mon, 24 Oct 2022 15:44:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 9331060BFB;
	Mon, 24 Oct 2022 15:44:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9331060BFB
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 64BD6C0032;
	Mon, 24 Oct 2022 15:44:24 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6BB04C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Oct 2022 15:44:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 37C9F40332
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Oct 2022 15:44:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 37C9F40332
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=MLcB+pgz
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Vz8bHa6U4P9c
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Oct 2022 15:44:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4C89140319
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4C89140319
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Oct 2022 15:44:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1666626261;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=92rC7vra5jhLWtogZY2kc9h+cj7t9VuLWZS8/0qi9VI=;
 b=MLcB+pgz2uA25GWB84jkOR6AVUiXfKTjApmEHs+6A6/1VUupd6pYTzxuqWhiRBU3uzm0qj
 u9UwnL3cPxgz4uU9HYe7ZamVbEhT6713DJii/uSVyr4YeMKd+iATpVkdNQzpLoQ/LYcYGc
 km95RPrYjLUzBN3ztOe/7Ab2BHiuW9o=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-106-7b7FQSphNy-BQfdUC9UndQ-1; Mon, 24 Oct 2022 11:44:19 -0400
X-MC-Unique: 7b7FQSphNy-BQfdUC9UndQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E40BA858F17;
 Mon, 24 Oct 2022 15:44:18 +0000 (UTC)
Received: from localhost (unknown [10.39.194.177])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 627801415114;
 Mon, 24 Oct 2022 15:44:18 +0000 (UTC)
Date: Mon, 24 Oct 2022 11:44:16 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Rafael Mendonca <rafaelmendsr@gmail.com>
Subject: Re: [PATCH] virtio_blk: Fix signedness bug in virtblk_prep_rq()
Message-ID: <Y1ay0NMQ7p03hgxu@fedora>
References: <20221021204126.927603-1-rafaelmendsr@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20221021204126.927603-1-rafaelmendsr@gmail.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Cc: Jens Axboe <axboe@kernel.dk>, "Michael S. Tsirkin" <mst@redhat.com>,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 linux-block@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
 Suwan Kim <suwan.kim027@gmail.com>
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
Content-Type: multipart/mixed; boundary="===============3025015920343552372=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>


--===============3025015920343552372==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="H+myidrQ2SNzoh0X"
Content-Disposition: inline


--H+myidrQ2SNzoh0X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 21, 2022 at 05:41:26PM -0300, Rafael Mendonca wrote:
> The virtblk_map_data() function returns negative error codes, however, the
> 'nents' field of vbr->sg_table is an unsigned int, which causes the error
> handling not to work correctly.
>=20
> Fixes: 0e9911fa768f ("virtio-blk: support mq_ops->queue_rqs()")
> Signed-off-by: Rafael Mendonca <rafaelmendsr@gmail.com>
> ---
>  drivers/block/virtio_blk.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--H+myidrQ2SNzoh0X
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmNWstAACgkQnKSrs4Gr
c8jYegf9FWI4IHxGcvMocCCgVz2xC4vCDXutBT1DcO/mwG8nFliPMNR10l8zwwTO
VgkOzVoed8mckPmnWXNyePLJB68ZeOmRvWRuExPwqZNMNHx8Nq/xtTG2NmYWR1qm
gfMJeRmaXxEdSy4Ah7NFx4y7LMRk2SodlFzQMzb4vcQOww0p+GCTyl5gDWYeGPCV
wbKCqdaKCnu85W9Z8cgjVPX6ACqdnIsy2X6Kik3mKUjQr389my9HODEI+7hOrWuR
8Yode18jCQX8uR0gi1IriIso3vh7lNYyfGrCK2fpkwX1tlG1fFfDjhdftGwD5frR
VkZXHYhphTdDZp+CcFRo7j2dO1mGLA==
=nNPq
-----END PGP SIGNATURE-----

--H+myidrQ2SNzoh0X--


--===============3025015920343552372==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============3025015920343552372==--

