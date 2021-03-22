Return-Path: <SRS0=byTZ=IU=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D69C9C433DB
	for <virtualization@archiver.kernel.org>; Mon, 22 Mar 2021 15:47:55 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 704566199F
	for <virtualization@archiver.kernel.org>; Mon, 22 Mar 2021 15:47:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 704566199F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 3AFB740280;
	Mon, 22 Mar 2021 15:47:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1prni8xeDZiK; Mon, 22 Mar 2021 15:47:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id CD5AB40137;
	Mon, 22 Mar 2021 15:47:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 90287C000B;
	Mon, 22 Mar 2021 15:47:53 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4170BC0001
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Mar 2021 15:47:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1BF41827DD
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Mar 2021 15:47:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JDBrWCxBbwbe
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Mar 2021 15:47:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5D327827B5
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Mar 2021 15:47:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1616428070;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kF05X3XUjORG7bqce6qEvZk7r7MroqA/dhygkFI8iGg=;
 b=LqBZStzmGFbhydbAXSnuhoTMLTHUDz5dK4gM/Qm1s7G2EAVf8gXKNQ9DgoOtViOx/juWIA
 NdKLJv0XbJeyk7u6UHESHgdg9OjXFxNAtA8TF30P2fMmCi/LrKrqe+tkqwm2/FsAyvSPhQ
 V0wlfTfVdNrcA4tfdahl+7wXhGdYVtY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-144-QYnxL-zNOQmSnNKMTqai6Q-1; Mon, 22 Mar 2021 11:47:48 -0400
X-MC-Unique: QYnxL-zNOQmSnNKMTqai6Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A541110866A9;
 Mon, 22 Mar 2021 15:47:46 +0000 (UTC)
Received: from localhost (ovpn-114-89.ams2.redhat.com [10.36.114.89])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2CEDF10023AB;
 Mon, 22 Mar 2021 15:47:39 +0000 (UTC)
Date: Mon, 22 Mar 2021 15:47:37 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Connor Kuehl <ckuehl@redhat.com>
Subject: Re: [PATCH 2/3] virtiofs: split requests that exceed virtqueue size
Message-ID: <YFi8GYrRG/ks2BBz@stefanha-x1.localdomain>
References: <20210318135223.1342795-1-ckuehl@redhat.com>
 <20210318135223.1342795-3-ckuehl@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20210318135223.1342795-3-ckuehl@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Cc: miklos@szeredi.hu, mst@redhat.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, virtio-fs@redhat.com,
 linux-fsdevel@vger.kernel.org, vgoyal@redhat.com
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
Content-Type: multipart/mixed; boundary="===============5947768453045572499=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>


--===============5947768453045572499==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="EBlwIFYriryzFVKW"
Content-Disposition: inline


--EBlwIFYriryzFVKW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 18, 2021 at 08:52:22AM -0500, Connor Kuehl wrote:
> If an incoming FUSE request can't fit on the virtqueue, the request is
> placed onto a workqueue so a worker can try to resubmit it later where
> there will (hopefully) be space for it next time.
>=20
> This is fine for requests that aren't larger than a virtqueue's maximum
> capacity. However, if a request's size exceeds the maximum capacity of
> the virtqueue (even if the virtqueue is empty), it will be doomed to a
> life of being placed on the workqueue, removed, discovered it won't fit,
> and placed on the workqueue yet again.
>=20
> Furthermore, from section 2.6.5.3.1 (Driver Requirements: Indirect
> Descriptors) of the virtio spec:
>=20
>   "A driver MUST NOT create a descriptor chain longer than the Queue
>   Size of the device."
>=20
> To fix this, limit the number of pages FUSE will use for an overall
> request. This way, each request can realistically fit on the virtqueue
> when it is decomposed into a scattergather list and avoid violating
> section 2.6.5.3.1 of the virtio spec.
>=20
> Signed-off-by: Connor Kuehl <ckuehl@redhat.com>
> ---
>  fs/fuse/fuse_i.h    |  5 +++++
>  fs/fuse/inode.c     |  7 +++++++
>  fs/fuse/virtio_fs.c | 14 ++++++++++++++
>  3 files changed, 26 insertions(+)

Nice that FUSE already has max_pages :-).

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--EBlwIFYriryzFVKW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmBYvBkACgkQnKSrs4Gr
c8gL7Qf+MIRWqCCYkNEZwL6tftu8+lg4QxBigZvpmryZKX9xCLbLzcTZuUzPQC6I
HiFj77t2jUhUbSv9edImKSWoSYad0kT0bCsWnwghojx+ta5lIXveKMwv4qHCkF9J
CsnZqKYSW+9gCyjC/mCLLl1lHKSoSHJsDSVuJQ7gwlGg1n1Bv5IKE4ZX2+hlXGY3
FWtCTz17sqzrlCIceUnG5jN10TcXqsXSDEH3oOV6ZSWl8HTXWFyJjcRWau4u9S2R
iIZJEcByDMVqWWCHWVySksdompYzM9xFbXLebPE5Rnn9BaK5m/BdISHbS1R5dZaU
LPExG+DiEtEx/j/imqIq7YtJlXxA5g==
=KXHl
-----END PGP SIGNATURE-----

--EBlwIFYriryzFVKW--


--===============5947768453045572499==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============5947768453045572499==--

