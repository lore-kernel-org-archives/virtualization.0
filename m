Return-Path: <SRS0=DeSX=HE=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DATE_IN_PAST_03_06,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07597C433E0
	for <virtualization@archiver.kernel.org>; Tue,  2 Feb 2021 14:59:53 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D8D464F5D
	for <virtualization@archiver.kernel.org>; Tue,  2 Feb 2021 14:59:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D8D464F5D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 5B04285797;
	Tue,  2 Feb 2021 14:59:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fdMV2jhkui8x; Tue,  2 Feb 2021 14:59:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id F3AF78584A;
	Tue,  2 Feb 2021 14:59:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DC0CEC0FA7;
	Tue,  2 Feb 2021 14:59:51 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7C32CC013A
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Feb 2021 14:59:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 6B7D0860BF
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Feb 2021 14:59:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tfXfemoYT484
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Feb 2021 14:59:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id E1113860BE
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Feb 2021 14:59:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1612277988;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/nqgkmwEUBwFXFP1lcLQvcaHEBrgIYTBqrD9vTkcUJA=;
 b=HwHT1vsezS286M4X9t14W8sfSWBrYx4p7zgnwukWo8qA8hd23Faj67u0USfgea0FK6iE3j
 8Kc7BxujEMUZ3kQ8+hR1i7H91uU0dtlbS4Y4Dq0dv+bMuRexKYcf4zsmlCqYKcPQx0fmzd
 jCkQBVJdnuIoyp0KQCrevKroXpTgEXQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-62-6s0xieiNOxuNgw70t6dwzA-1; Tue, 02 Feb 2021 09:59:44 -0500
X-MC-Unique: 6s0xieiNOxuNgw70t6dwzA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B155BAFA82;
 Tue,  2 Feb 2021 14:59:43 +0000 (UTC)
Received: from localhost (ovpn-115-185.ams2.redhat.com [10.36.115.185])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 660F219C71;
 Tue,  2 Feb 2021 14:59:40 +0000 (UTC)
Date: Tue, 2 Feb 2021 09:41:57 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH RFC v2 09/10] vdpa_sim_blk: implement ramdisk behaviour
Message-ID: <20210202094157.GB243557@stefanha-x1.localdomain>
References: <20210128144127.113245-1-sgarzare@redhat.com>
 <20210128144127.113245-10-sgarzare@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20210128144127.113245-10-sgarzare@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Cc: Laurent Vivier <lvivier@redhat.com>, Max Gurtovoy <mgurtovoy@nvidia.com>,
 kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Xie Yongji <xieyongji@bytedance.com>
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
Content-Type: multipart/mixed; boundary="===============3254711509342254741=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>


--===============3254711509342254741==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="XOIedfhf+7KOe/yw"
Content-Disposition: inline


--XOIedfhf+7KOe/yw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 28, 2021 at 03:41:26PM +0100, Stefano Garzarella wrote:
> The previous implementation wrote only the status of each request.
> This patch implements a more accurate block device simulator,
> providing a ramdisk-like behavior.
>=20
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
> v2:
> - used %zd %zx to print size_t and ssize_t variables in dev_err()
> - removed unnecessary new line [Jason]
> - moved VIRTIO_BLK_T_GET_ID in another patch [Jason]
> - used push/pull instead of write/read terminology
> - added vdpasim_blk_check_range() to avoid overflows [Stefan]
> - use vdpasim*_to_cpu instead of le*_to_cpu
> - used vringh_kiov_length() helper [Jason]
> ---
>  drivers/vdpa/vdpa_sim/vdpa_sim_blk.c | 164 ++++++++++++++++++++++++---
>  1 file changed, 146 insertions(+), 18 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--XOIedfhf+7KOe/yw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmAZHmQACgkQnKSrs4Gr
c8i2cwgAnejUJEOfV7h1JLqKBGsbMZ8G/rYq5Tpn2NYeHH+hHKUzJuYhhiy6A/dc
ApoMhiK73jMGntzRVlchJ9EzLdG3mWp1fV7nDHb3jfSefPaMn/+sqHpRte3gAtp5
6qRPQg86qq2acmxReSwEuLADmwkQ9IEfUobw+9Eh8eaL8Fam79/brxgeAi+jyTUi
Y6fHt/8yCLtpz+gp2FqWtmN0COcu6C6/I9yDwfIyhmn1jUtO7O8MUBDTEmOuY+TC
41AXprR3YIHGnEzaDphoqwmSN7NyWTmvQScwFA2HPDgVWe4VksizaICwg/Iz0IWD
lND4h139qSBuLPJKWi/2ReukfLcOjw==
=DBTx
-----END PGP SIGNATURE-----

--XOIedfhf+7KOe/yw--


--===============3254711509342254741==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============3254711509342254741==--

