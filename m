Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06209C433F5
	for <virtualization@archiver.kernel.org>; Wed, 20 Apr 2022 15:04:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 86A5760591;
	Wed, 20 Apr 2022 15:04:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WjDAeOsvbAsz; Wed, 20 Apr 2022 15:04:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 182C06009C;
	Wed, 20 Apr 2022 15:04:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DA46CC0033;
	Wed, 20 Apr 2022 15:04:42 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3350CC002C
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Apr 2022 15:04:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1B1A783DEE
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Apr 2022 15:04:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3cFoqL2XEBPa
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Apr 2022 15:04:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6F68D83B07
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Apr 2022 15:04:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1650467080;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HO3i4D+trVxcNDmLhmg0KRj5BB0NScDWZoswC9YsiRI=;
 b=iVIiAbXcksuyboYwVJj9AGleA3SaT8QYjunBBjpsrT5aJazODXyQ7d4gJNhaH4F929COtq
 vphj2GHFA1jlIZmw53fF1kad/LiW7/VrHgGxhtSfmOlIap5YpoVqOLHioPZJVEkt32jov5
 r8CETsjj7b1qzwiQQgfFhQeUfHyHT88=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-60-FgEaMkRIPgaV0Z_mitIHYw-1; Wed, 20 Apr 2022 11:04:36 -0400
X-MC-Unique: FgEaMkRIPgaV0Z_mitIHYw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id ED364833972;
 Wed, 20 Apr 2022 15:04:35 +0000 (UTC)
Received: from localhost (unknown [10.39.194.99])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 62C2954E899;
 Wed, 20 Apr 2022 15:04:35 +0000 (UTC)
Date: Wed, 20 Apr 2022 17:04:33 +0200
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH 2/4] virtio-blk: don't add a new line
Message-ID: <YmAhAd3n79nDxNEA@stefanha-x1.localdomain>
References: <20220420041053.7927-1-kch@nvidia.com>
 <20220420041053.7927-3-kch@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20220420041053.7927-3-kch@nvidia.com>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
Cc: linux-block@vger.kernel.org, pbonzini@redhat.com,
 virtualization@lists.linux-foundation.org, mst@redhat.com
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
Content-Type: multipart/mixed; boundary="===============8992787080773449187=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>


--===============8992787080773449187==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="LY9BsyJbjKQX4zYs"
Content-Disposition: inline


--LY9BsyJbjKQX4zYs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 19, 2022 at 09:10:51PM -0700, Chaitanya Kulkarni wrote:
> Don't split sector assignment line for REQ_OP_READ and REQ_OP_WRITE in
> the virtblk_setup_cmd() which fits in one line perfectly.
>=20
> Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
> ---
>  drivers/block/virtio_blk.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)

There is a cost to patches: humans spend time reviewing them, CI systems
consume energy running tests, downstream maintainers deal with
backports, and git-blame(1) becomes harder to use when code changes.

What constitutes code churn is subjective. For me personally I prefer it
when patches have a clear benefit that outweighs the costs.
Nevertheless:

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--LY9BsyJbjKQX4zYs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmJgIQEACgkQnKSrs4Gr
c8hzNwf9GjKTeB69Z0b8rSUOHgifTOzRElYfNVGZx9NDvbrX1+WvGuxSkJZmpwlY
CnNhAcaJ9BT5OV49uq4HuCXW5ihawy5ytWxXea1slmQlrLbG9fKvgHodOQL+jZil
MnJOBl7+IYRJ/2lNUrJPGt/q6wkOCzzxRuSMrRAhRlY8ATg36rRxEuflq4jIwEx1
K9G/4bWMFLPi5v17LZeQw5GJfO22J/ESkMZhP0qB+L6qnkDUqUI8ww/Hxfa4z4Fw
eWVxYvggGgNlRr49+H6IrPaDoqQ1tpI7HsQgZcURAEaWvkb91rrHLpo8snv4ASIR
6xbKz11fbg3MREFRVwUGBsMALbKBJA==
=iq4N
-----END PGP SIGNATURE-----

--LY9BsyJbjKQX4zYs--


--===============8992787080773449187==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============8992787080773449187==--

