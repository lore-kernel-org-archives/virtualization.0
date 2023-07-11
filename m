Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02217EB64DC
	for <virtualization@archiver.kernel.org>; Tue, 11 Jul 2023 20:23:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 8A3B2402A7;
	Tue, 11 Jul 2023 20:23:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8A3B2402A7
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=U4lzZAPd
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kF0mta6PHwZ9; Tue, 11 Jul 2023 20:23:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 25DCB40452;
	Tue, 11 Jul 2023 20:23:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 25DCB40452
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E2CCDC0071;
	Tue, 11 Jul 2023 20:23:41 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D6E08C0032
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Jul 2023 20:23:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9D7DB837AC
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Jul 2023 20:23:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9D7DB837AC
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=U4lzZAPd
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kLal2SkzrdOH
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Jul 2023 20:23:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E3DAB835A6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E3DAB835A6
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Jul 2023 20:23:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689107018;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eV9C9jx9h9D9C/vRLVaKfj87oGBUqvV6SKP1MNBlpZ0=;
 b=U4lzZAPdRPqxAJbDf1HJCqoQdjCb6igo9hdLIbATB4m2hhWv9zxE6ncIOHioPF/ajYyFGm
 i3QPRD9M+smKXRyD7auvi41CiQMN/hZxQDdNdf3e/0SC7IttSPuQVBhd/X59Raqj6RNX6z
 g0BMHZFVZEZlGWoTiY2gKOksCnSsAeM=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-499-CQGI8oDENLqN45CGV-iXJg-1; Tue, 11 Jul 2023 16:23:36 -0400
X-MC-Unique: CQGI8oDENLqN45CGV-iXJg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 778FC1C09052;
 Tue, 11 Jul 2023 20:23:36 +0000 (UTC)
Received: from localhost (unknown [10.39.192.40])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D0662200AD6E;
 Tue, 11 Jul 2023 20:23:35 +0000 (UTC)
Date: Tue, 11 Jul 2023 14:34:38 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Mike Christie <michael.christie@oracle.com>
Subject: Re: [PATCH v2 0/2] vhost-scsi: Fix IO hangs when using windows
Message-ID: <20230711183438.GA154686@fedora>
References: <20230709202859.138387-1-michael.christie@oracle.com>
MIME-Version: 1.0
In-Reply-To: <20230709202859.138387-1-michael.christie@oracle.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
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
Content-Type: multipart/mixed; boundary="===============4604076109128330473=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>


--===============4604076109128330473==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="4bkaegDfbP/o4tRg"
Content-Disposition: inline


--4bkaegDfbP/o4tRg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 09, 2023 at 03:28:57PM -0500, Mike Christie wrote:
> The following patches were made over Linus's tree and fix an issue
> where windows guests will send iovecs with offset/lengths that result
> in IOs that are not aligned to 512. The LIO layer will then send them
> to Linux's FS/block layer but it requires 512 byte alignment, so
> depending on the FS/block driver being used we will get IO errors or
> hung IO.
>=20
> The following patches have vhost-scsi detect when windows sends these
> IOs and copy them to a bounce buffer. It then does some cleanup in
> the related code.

Hang on, virtio-scsi is a SCSI HBA and READs/WRITEs submitted must
follow the usual constraints on SCSI block limits. Would Windows send
mis-aligned I/O to a non-virtio-scsi SCSI HBA?

Are you sure this is not a bug in the Windows guest driver where block
limits are being misconfigured?

Stefan

--4bkaegDfbP/o4tRg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmStoL4ACgkQnKSrs4Gr
c8jxZQgArLxrWAt/8uuBoonrckaOR/crd2onBaPgO7hRYNaZJYNJyn1BzrJMCYpO
LbkQ7P+iamfwYfA3M49anhxLpfLYfCgGAOma3qCrNll+bUgOZyFIGLn9Wy8KSsh8
EHnpWtGE9kRMXujv1J6ks7JDUIT/8v9A64KP6sX/D/YvAF4yWPEEsZP9NnaDT/61
2uC55lMrUHPQ3E85FFlwaJN4y7X+4GsO2LnA4yYwmlG/+Z1AnHKAGdD6B2ug5d9V
vvTWUWZVT4FtuT/FjdYY6F59oKOtkQEeotj0Y74jMo+uxsEuPcRZ02VRA52rpU/5
LtoQvuVKM4dLV8jw8tXlicUBpOHGtg==
=0k/W
-----END PGP SIGNATURE-----

--4bkaegDfbP/o4tRg--


--===============4604076109128330473==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============4604076109128330473==--

