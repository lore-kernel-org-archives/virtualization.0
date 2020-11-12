Return-Path: <SRS0=8i8N=ES=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6707C56201
	for <virtualization@archiver.kernel.org>; Thu, 12 Nov 2020 17:00:26 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1EA33206FA
	for <virtualization@archiver.kernel.org>; Thu, 12 Nov 2020 17:00:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d6Ra3HaJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EA33206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id A7D9F2E20C;
	Thu, 12 Nov 2020 17:00:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dPruFbg7RCr3; Thu, 12 Nov 2020 17:00:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 5E14020452;
	Thu, 12 Nov 2020 17:00:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3D049C0889;
	Thu, 12 Nov 2020 17:00:24 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 780ABC016F
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Nov 2020 17:00:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 6425386497
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Nov 2020 17:00:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Lfcf71BRA+fJ
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Nov 2020 17:00:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 211F487096
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Nov 2020 17:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1605200421;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8WtHXC8mKlk3syV9475opWWmZkifxuDIS56d7hfYA+k=;
 b=d6Ra3HaJ9oGzfNgiqLft9yujNKr52n8p2hNvX7t9vm34ZDdhAXRQu8OSxSx2xTdwIWMMnd
 2JoeBMtvNdA7yVArh2kG7laop0AAVGdYarZm3y4S4TWixopbUrmUTOYriz3R1w6yQ7yuaQ
 Q0BiomilbHLWTvvd7EtY+L5xocPuMcE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-405-m8IZqujcOuig-QSbHXoMFw-1; Thu, 12 Nov 2020 12:00:16 -0500
X-MC-Unique: m8IZqujcOuig-QSbHXoMFw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 34FA9100E349;
 Thu, 12 Nov 2020 17:00:10 +0000 (UTC)
Received: from localhost (ovpn-115-122.ams2.redhat.com [10.36.115.122])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C22525577D;
 Thu, 12 Nov 2020 17:00:09 +0000 (UTC)
Date: Thu, 12 Nov 2020 17:00:08 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Mike Christie <michael.christie@oracle.com>
Subject: Re: [PATCH 0/5 V5] vhost-scsi: IO error fixups
Message-ID: <20201112170008.GB1555653@stefanha-x1.localdomain>
References: <1604986403-4931-1-git-send-email-michael.christie@oracle.com>
MIME-Version: 1.0
In-Reply-To: <1604986403-4931-1-git-send-email-michael.christie@oracle.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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
Content-Type: multipart/mixed; boundary="===============2930820371464367949=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

--===============2930820371464367949==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="xXmbgvnjoT4axfJE"
Content-Disposition: inline

--xXmbgvnjoT4axfJE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 09, 2020 at 11:33:18PM -0600, Mike Christie wrote:
> The following patches were made over Michael's vhost branch:
>=20
> https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git/log/?h=3Dvh=
ost
>=20
> They fixe a couple issues where the guest is getting IO errors:
> 1. The admin may set num_queues and cmd_per_lun/virtqueue_size
> in a way that allows the guest to send more IO that vhost-scsi
> was coded for.
>=20
> 2. A race where vhost-scsi completes the cmd to the guest before
> it's fully completed in the target/vhost-scsi layers so if the
> guest sends a new IO too quicky we fail it.
>=20
> 3. If the real/physical storage (lio backend device) hits a transient
> error then vhost-scsi would fail commands instead of relying on
> the lower levels error recovery to do what the admin had set up.
>=20
> V5:
> - Bring back V1 but move flush patches to a separate clean up set
> - Modify test in vhost_vq_is_setup
>=20
> V4:
> - really really fix compile errors
> - dropped threading patches so we can figure that out separately.
>=20
> V3:
> - fix compile errors
> - fix possible crash where cmd could be freed while adding it to
> completion list
> - fix issue where we added the worker thread to the blk cgroup but
> the blk IO was submitted by a driver workqueue.
>=20
> V2:
> - fix use before set cpu var errors
> - drop vhost_vq_is_setup
> - include patches to do a worker thread per scsi IO vq
>=20
>=20

Acked-by: Stefan Hajnoczi <stefanha@redhat.com>

--xXmbgvnjoT4axfJE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl+tahgACgkQnKSrs4Gr
c8itSwf9GVyHTRV2sAUjFG8BDBKEP3l/jOvX8Fd3PEaYkAfmmX+WgGtTbq1JHFLU
5YpudBKY56GIhQv2gQtzy6yG0IGZLgRfgNSJMIbD3OEdRIfXiwqZXqtmPGyDG8mh
yLK98M0I1dkEV0UTtyMDizZHlJGvDierunEbtAgw0gijw2tZZ4siWtPkvHRUKPX+
vFLB14FoAOEX88ykHQYoN/AgfS4WM4FPhRZ3jy67IK5HwrS5uK/rdGy/bkVx+V0R
NQDlP1FsYGABk6rFD/yK5zFwuJNIqSS+vSxFhdcZkVYczlJkxrY38XCQZTgEmSb/
uMx/xfUfsNad2GEOLlz3rAa3gJUCwQ==
=ERi/
-----END PGP SIGNATURE-----

--xXmbgvnjoT4axfJE--


--===============2930820371464367949==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============2930820371464367949==--

