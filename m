Return-Path: <SRS0=We/I=EX=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AF73C2D0E4
	for <virtualization@archiver.kernel.org>; Tue, 17 Nov 2020 16:09:11 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F3ED2463D
	for <virtualization@archiver.kernel.org>; Tue, 17 Nov 2020 16:09:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DO36lTev"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F3ED2463D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 163AA20529;
	Tue, 17 Nov 2020 16:09:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EwMfQQSyp8q7; Tue, 17 Nov 2020 16:09:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 6259D20021;
	Tue, 17 Nov 2020 16:09:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5254FC0891;
	Tue, 17 Nov 2020 16:09:09 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 00BBCC07FF
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Nov 2020 16:09:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id DAEBD2047D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Nov 2020 16:09:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aaY7LovMc1qg
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Nov 2020 16:09:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by silver.osuosl.org (Postfix) with ESMTPS id 218C320021
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Nov 2020 16:09:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1605629346;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3i2vVvvOi2W9Eple+UW0eM1PUkTGmgXQgzpxOR9aJuE=;
 b=DO36lTevOwxMNrWdXK21WPU9tPC2XE3iv+GB71BWv5zkJT2DzApVj6Y8zgBrMDQUJy6+H0
 G5GVrNDi5DwNepxtAOnca0pzdycb6zhqcnTuAVA/3AvTJRiqqNowqxdX5ALtJsP0A3OT3b
 10i2UpxvxpxYbAdJy5TYa/B+9W1jMEM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-119-VpFiKt-KOiC96pjbfOimbw-1; Tue, 17 Nov 2020 11:09:01 -0500
X-MC-Unique: VpFiKt-KOiC96pjbfOimbw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 31C6B803639;
 Tue, 17 Nov 2020 16:08:59 +0000 (UTC)
Received: from localhost (ovpn-115-113.ams2.redhat.com [10.36.115.113])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A08695D9CC;
 Tue, 17 Nov 2020 16:08:55 +0000 (UTC)
Date: Tue, 17 Nov 2020 16:08:54 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Mike Christie <michael.christie@oracle.com>
Subject: Re: [PATCH 08/10] vhost: move msg_handler to new ops struct
Message-ID: <20201117160854.GQ131917@stefanha-x1.localdomain>
References: <1605223150-10888-1-git-send-email-michael.christie@oracle.com>
 <1605223150-10888-10-git-send-email-michael.christie@oracle.com>
MIME-Version: 1.0
In-Reply-To: <1605223150-10888-10-git-send-email-michael.christie@oracle.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: fam@euphon.net, linux-scsi@vger.kernel.org, mst@redhat.com,
 qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org,
 target-devel@vger.kernel.org, pbonzini@redhat.com
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
Content-Type: multipart/mixed; boundary="===============2075948831701102336=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

--===============2075948831701102336==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ZqRzwd/9tauJXEMK"
Content-Disposition: inline

--ZqRzwd/9tauJXEMK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 12, 2020 at 05:19:08PM -0600, Mike Christie wrote:
> The next patch adds a callout so drivers can perform some action when we
> get a VHOST_SET_VRING_ENABLE, so this patch moves the msg_handler callout
> to a new vhost_dev_ops struct just to keep all the callouts better
> organized.
>=20
> Signed-off-by: Mike Christie <michael.christie@oracle.com>
> ---
>  drivers/vhost/vdpa.c  |  7 +++++--
>  drivers/vhost/vhost.c | 10 ++++------
>  drivers/vhost/vhost.h | 11 ++++++-----
>  3 files changed, 15 insertions(+), 13 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--ZqRzwd/9tauJXEMK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl+z9ZYACgkQnKSrs4Gr
c8iTLAf/SIfQoFH/hado2LWXqJUBjlFoJBf3G+Xc4B9v2c6vKOYX4BYDwU3J+Pq3
qlKZK8jppabIJ78gjFaGio8UcAnhgv2ee104+8VTYttjWYArerGwkS3MaOkX+W9s
yP1Z3P0cFHVDacOvjLsnO4V5pNjLRhWLtQ3iMO0Uz5Q9ezQ/sGfZ2oifLd67WWyK
HwTJCrYeul1A7BkJOek6rSstc3B/W5Ab1mb/Ne2ecSiS/R7jfxbns7HiKYzyz6dS
KgheSYDIEDobKmsfjtN4lSktSbB0N9/mLb8gKqFslgyxgk2KHMljlu/YyXmezWOC
e79+SiNJGPuLU9uHvUonogGzkY+4uA==
=g9Qu
-----END PGP SIGNATURE-----

--ZqRzwd/9tauJXEMK--


--===============2075948831701102336==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============2075948831701102336==--

