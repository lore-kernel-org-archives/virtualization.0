Return-Path: <SRS0=X+k7=HK=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80916C433E0
	for <virtualization@archiver.kernel.org>; Mon,  8 Feb 2021 10:48:25 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0A3D64EC9
	for <virtualization@archiver.kernel.org>; Mon,  8 Feb 2021 10:48:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0A3D64EC9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 5BEF885BE4;
	Mon,  8 Feb 2021 10:48:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ogZPvXIFbtTz; Mon,  8 Feb 2021 10:48:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id DEF5285A6A;
	Mon,  8 Feb 2021 10:48:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C4A3DC0891;
	Mon,  8 Feb 2021 10:48:23 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 61A8FC013A
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Feb 2021 10:48:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 48F0685A6A
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Feb 2021 10:48:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dS8oB3ywVEu8
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Feb 2021 10:48:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id A228685A57
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Feb 2021 10:48:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1612781300;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iNzlRFhQZaxFEKuPUnwd+9/Xj6+WqNNpq8/o5MV2DOw=;
 b=A354WLf0M53wcfaG8YqPlIeGxbyqYTav03ilDeu7XIsn+kfmulTHxwlHubeGwyV8SiW09H
 GLJp1xWQx06r60EYHx8g5awgmWsngyNYg1WZ25EhCoNPL1X6cz/hnFOGvZhHcrASEnHdHH
 GO1scRvTgC7fdd0HCIoE9sgSB/bTGsU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-567-p3m4eQSOMi266MvNmx7SQQ-1; Mon, 08 Feb 2021 05:48:18 -0500
X-MC-Unique: p3m4eQSOMi266MvNmx7SQQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B3A87801A97;
 Mon,  8 Feb 2021 10:48:16 +0000 (UTC)
Received: from localhost (ovpn-115-153.ams2.redhat.com [10.36.115.153])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1AAF51A863;
 Mon,  8 Feb 2021 10:48:15 +0000 (UTC)
Date: Mon, 8 Feb 2021 10:48:14 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Mike Christie <michael.christie@oracle.com>
Subject: Re: [PATCH 00/11] target: fix cmd plugging and completion
Message-ID: <20210208104814.GA4349@stefanha-x1.localdomain>
References: <20210204113513.93204-1-michael.christie@oracle.com>
MIME-Version: 1.0
In-Reply-To: <20210204113513.93204-1-michael.christie@oracle.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Cc: martin.petersen@oracle.com, linux-scsi@vger.kernel.org, mst@redhat.com,
 virtualization@lists.linux-foundation.org, target-devel@vger.kernel.org
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
Content-Type: multipart/mixed; boundary="===============0523715495259788532=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>


--===============0523715495259788532==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="TB36FDmn/VVEgNH/"
Content-Disposition: inline


--TB36FDmn/VVEgNH/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 04, 2021 at 05:35:02AM -0600, Mike Christie wrote:
> The following patches made over Martin's 5.12 branches fix two
> issues:
>=20
> 1. target_core_iblock plugs and unplugs the queue for every
> command. To handle this issue and handle an issue that
> vhost-scsi and loop were avoiding by adding their own workqueue,
> I added a new submission workqueue to LIO. Drivers can pass cmds
> to it, and we can then submit batches of cmds.
>=20
> 2. vhost-scsi and loop on the submission side were doing a work
> per cmd and on the lio completion side it was doing a work per
> cmd. The cap on running works is 512 (max_active) and so we can
> end up end up using a lot of threads when submissions start blocking
> because they hit the block tag limit or the completion side blocks
> trying to send the cmd. In this patchset I just use a cmd list
> per session to avoid abusing the workueue layer.
>=20
> The combined patchset fixes a major perf issue we've been hitting
> where IOPs is stuck at 230K when running:
>=20
>     fio --filename=3D/dev/sda  --direct=3D1 --rw=3Drandrw --bs=3D4k
>     --ioengine=3Dlibaio --iodepth=3D128  --numjobs=3D8 --time_based
>     --group_reporting --runtime=3D60
>=20
> The patches in this set get me to 350K when using devices that
> have native IOPs of around 400-500K.
>=20
> Note that 5.12 has some interrupt changes that my patches
> collide with. Martin's 5.12 branches had the changes so I
> based my patches on that.

For vhost-scsi:

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--TB36FDmn/VVEgNH/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmAhFuwACgkQnKSrs4Gr
c8i9fggAxfNpzkdi1bqBFj4YY9e2IC1HyxNIRjrtAAPSooPVaY+tv01MPVM3htRJ
OuMToi1R0kjYsjxMfxJ4nfaY3iCBHNsEf+LAwuRYxFRFnXR+iEbhR804bxak9epk
QwIClSa432iA8GMvah7xzr0+HQVxEIwGezl45l8Gn408z0KmB5MQjGGK2+ARE7QS
IYRUr2J7ny3hOpWJ+roj4812Oka+iEOgdjc3ijOpDd9bETMobZ0f9qlJN+OSyB2Q
gpzx6tyHxTN9uzBNSqF+81y00EKqJhT6AQY+vh6MIXXFEz5diunGBOo+uQRIKG/j
4e/Qytom81tfCAdDf2bxX8LC8kg8IA==
=DOyd
-----END PGP SIGNATURE-----

--TB36FDmn/VVEgNH/--


--===============0523715495259788532==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============0523715495259788532==--

