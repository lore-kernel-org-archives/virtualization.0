Return-Path: <SRS0=fDOL=NY=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC11CC432BE
	for <virtualization@archiver.kernel.org>; Thu,  2 Sep 2021 15:00:47 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C391610F9
	for <virtualization@archiver.kernel.org>; Thu,  2 Sep 2021 15:00:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4C391610F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0EE3C614FD;
	Thu,  2 Sep 2021 15:00:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id orO-NCCKqcpP; Thu,  2 Sep 2021 15:00:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 94A566144C;
	Thu,  2 Sep 2021 15:00:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 65F93C001A;
	Thu,  2 Sep 2021 15:00:42 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1A4A5C000E
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Sep 2021 15:00:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 14EA0406D9
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Sep 2021 15:00:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yGTeo9sL9_3I
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Sep 2021 15:00:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3F7784018D
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Sep 2021 15:00:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1630594838;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NhX65RT1ifaHwGOlvzI1CW4C3zVZPOJhKK0Ufgw3iQA=;
 b=AxL6mSp6G2YR07BNKmMW+0aMcV3fCU4pvoF01XLAnVDwslKS/24892+9nkIh6twP7l8U7D
 QRLomyh0HiobW84sdNtNLsksLGzr3uGwPFC5PBRK7k/WT0YE0Xd3Ao5IPsILp/mHQOOXLA
 YJqSNNlbqqNwOBlEMevzw3UbI4Irb9Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-369-q_HuT_iJNrmGjPs7czfHew-1; Thu, 02 Sep 2021 11:00:37 -0400
X-MC-Unique: q_HuT_iJNrmGjPs7czfHew-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EC6E0100C60C;
 Thu,  2 Sep 2021 15:00:35 +0000 (UTC)
Received: from localhost (unknown [10.39.194.169])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 64D651AC7E;
 Thu,  2 Sep 2021 15:00:32 +0000 (UTC)
Date: Thu, 2 Sep 2021 16:00:31 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: Re: [PATCH 1/1] virtio-blk: remove unneeded "likely" statements
Message-ID: <YTDnD1c8rk3SWcx9@stefanha-x1.localdomain>
References: <20210830120111.22661-1-mgurtovoy@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20210830120111.22661-1-mgurtovoy@nvidia.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Cc: axboe@kernel.dk, kvm@vger.kernel.org, mst@redhat.com,
 virtualization@lists.linux-foundation.org, linux-block@vger.kernel.org,
 oren@nvidia.com
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
Content-Type: multipart/mixed; boundary="===============5617033840548461220=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>


--===============5617033840548461220==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="wVBj43Tcb8AeCyD2"
Content-Disposition: inline


--wVBj43Tcb8AeCyD2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 30, 2021 at 03:01:11PM +0300, Max Gurtovoy wrote:
> Usually we use "likely/unlikely" to optimize the fast path. Remove
> redundant "likely" statements in the control path to ease on the code.
>=20
> Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> ---
>  drivers/block/virtio_blk.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

It would be nice to tweak the commit description before merging this. I
had trouble parsing the second sentence. If I understand correctly the
purpose of this patch is to make the code simpler and easier to read:

  s/ease on the code/simplify the code and make it easier to read/

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--wVBj43Tcb8AeCyD2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmEw5w8ACgkQnKSrs4Gr
c8jUHQf/VJ5hb++9DIHpheWC7yNi4OPiAS2B/1vypNz2ryOtT/6dEWtuLPgyw/fy
eD2d5GkdqujwQvl09h4esZpK1zVAdCj5J6L4R1m5RH6DqVG2GYnNzx1AdD8w0tgG
kMlizFNxPdlU6LSbJ+CPIky0FaleRbYEKjtUTJ9rjLwEYg9gCbEfZhR8dGt3jXca
tYM81eATEMjuUSa+G6tePeTUCuGX/zljWb+IjEfLONNy4cNWCfwY1+77iLDAf62q
bARLaXudlC/tyKjQguEF8GqvkvMRnYv9uQRV6YjpY6uchBaNh+X4kBF9XnQnBvtU
Nws0aRuTL+wQcNp9/vwVW9i6e+JFCQ==
=sHMp
-----END PGP SIGNATURE-----

--wVBj43Tcb8AeCyD2--


--===============5617033840548461220==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============5617033840548461220==--

