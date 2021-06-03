Return-Path: <SRS0=cU2J=K5=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB8A5C47082
	for <virtualization@archiver.kernel.org>; Thu,  3 Jun 2021 10:16:47 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70634613EE
	for <virtualization@archiver.kernel.org>; Thu,  3 Jun 2021 10:16:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70634613EE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 347A4400D0;
	Thu,  3 Jun 2021 10:16:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ll-VN_2wGPDi; Thu,  3 Jun 2021 10:16:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id D6C96400A7;
	Thu,  3 Jun 2021 10:16:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A1F53C000D;
	Thu,  3 Jun 2021 10:16:45 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7237CC0001
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Jun 2021 10:16:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5C157400C8
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Jun 2021 10:16:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zlnrCRF1_VGk
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Jun 2021 10:16:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B5B52400A7
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Jun 2021 10:16:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1622715402;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5q6zye8jgaP4kJLBUCQQtBp65dRFCpe6nc6ebA8ldZo=;
 b=Lz3Vtg0cQJyZUsxPUHgTDjfpS24WGdI2YQH5CvIUmAS9FkLrgvr0/W6eOT0pRy9eIJar25
 KT37y3/7jHjnvVlEOZ2vldhNgnFVMyHbmTKCywvKbN5lwY+nqO5GyP9oeHf/Y2Xrmwnzlg
 nSlCnnvUDnKSfNbJEAy/vjojzT7eq5A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-504-ap08A-feNfSxrnRV67tYHw-1; Thu, 03 Jun 2021 06:16:39 -0400
X-MC-Unique: ap08A-feNfSxrnRV67tYHw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 31E3A180FD6D;
 Thu,  3 Jun 2021 10:16:38 +0000 (UTC)
Received: from localhost (ovpn-114-228.ams2.redhat.com [10.36.114.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CD0E061140;
 Thu,  3 Jun 2021 10:16:34 +0000 (UTC)
Date: Thu, 3 Jun 2021 11:16:33 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Mike Christie <michael.christie@oracle.com>
Subject: Re: [PATCH 1/9] vhost: move worker thread fields to new struct
Message-ID: <YLisAZ9rbEYsubwI@stefanha-x1.localdomain>
References: <20210525180600.6349-1-michael.christie@oracle.com>
 <20210525180600.6349-2-michael.christie@oracle.com>
MIME-Version: 1.0
In-Reply-To: <20210525180600.6349-2-michael.christie@oracle.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Cc: linux-scsi@vger.kernel.org, mst@redhat.com,
 virtualization@lists.linux-foundation.org, target-devel@vger.kernel.org,
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
Content-Type: multipart/mixed; boundary="===============2648099732721572408=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>


--===============2648099732721572408==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="X8EHBs5SNGaS5/wR"
Content-Disposition: inline


--X8EHBs5SNGaS5/wR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 25, 2021 at 01:05:52PM -0500, Mike Christie wrote:
> This is just a prep patch. It moves the worker related fields to a new
> vhost_worker struct and moves the code around to create some helpers that
> will be used in the next patches.
>=20
> Signed-off-by: Mike Christie <michael.christie@oracle.com>
> ---
>  drivers/vhost/vhost.c | 94 +++++++++++++++++++++++++++++--------------
>  drivers/vhost/vhost.h |  9 ++++-
>  2 files changed, 70 insertions(+), 33 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--X8EHBs5SNGaS5/wR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmC4rAEACgkQnKSrs4Gr
c8iIiwgAysz30R4KsMZziyBEl+84TYFQ/urwez3XYLdllPTZPcAwMCED2HhiXcjd
gT4TAnqiTg0ysoReB9qEOsFGH0uNzbZev+F/gRGc1eo5qpx6ZFR2y8AwGrr+ydBf
h3xs4CTctrb+DHfObfkkjPcd5pbQekyEUbzEbZHQAKCmQk+LsNGY3PFVQdwodErA
CVnAJFYPKkxt5vPkYoR3CmYRj/9A1++7W/Egs1Lbb0DGcfpk2GTSdOyK7fRGzN5+
LOyGg51GQoR1j5RaBFSfpRmt6JicZte0C//NjJbvb4PptYbNdxSQwlCe2ddIhI5X
4Qfl2znad0AlqIMvYdxhEyeU2ECFag==
=fCDC
-----END PGP SIGNATURE-----

--X8EHBs5SNGaS5/wR--


--===============2648099732721572408==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============2648099732721572408==--

