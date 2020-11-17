Return-Path: <SRS0=We/I=EX=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BF0CC56202
	for <virtualization@archiver.kernel.org>; Tue, 17 Nov 2020 11:27:19 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA2E8221FF
	for <virtualization@archiver.kernel.org>; Tue, 17 Nov 2020 11:27:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="beD2L1Gp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA2E8221FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 37767853FC;
	Tue, 17 Nov 2020 11:27:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rJkrf0ce4u01; Tue, 17 Nov 2020 11:27:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 610BC83B2F;
	Tue, 17 Nov 2020 11:27:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2CF02C0800;
	Tue, 17 Nov 2020 11:27:17 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 66DA9C07FF
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Nov 2020 11:27:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 4D961203A9
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Nov 2020 11:27:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id P3DtHp0BVkYE
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Nov 2020 11:27:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by silver.osuosl.org (Postfix) with ESMTPS id 69F0D20029
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Nov 2020 11:27:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1605612433;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=A2JFewxKry8whthCDMxr2NfywJCIm21teU8xW5CsAu4=;
 b=beD2L1GpG4ZPoYL6dZ26cYBieNFHD3Fion5Zohx+BpgJzv7q5QeGJSXy87XHTpL8TRLT9Z
 A7Wp/WtfPj7F0P4XetreNSoSqgspV+bQwxwCISQYi3WBy5GcFwwG8GLHB5D1hP8I7FHN0v
 kipy/QD+WeH6HkFU62WC6LkGYhk6uGA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-266-JskOsdioPQGvNIKGQgGEBQ-1; Tue, 17 Nov 2020 06:27:09 -0500
X-MC-Unique: JskOsdioPQGvNIKGQgGEBQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 190D284639C;
 Tue, 17 Nov 2020 11:27:08 +0000 (UTC)
Received: from localhost (ovpn-113-172.ams2.redhat.com [10.36.113.172])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BB3BC10013D0;
 Tue, 17 Nov 2020 11:27:04 +0000 (UTC)
Date: Tue, 17 Nov 2020 11:27:03 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH RFC 10/12] vdpa_sim: split vdpasim_virtqueue's iov field
 in riov and wiov
Message-ID: <20201117112703.GF131917@stefanha-x1.localdomain>
References: <20201113134712.69744-1-sgarzare@redhat.com>
 <20201113134712.69744-11-sgarzare@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201113134712.69744-11-sgarzare@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Laurent Vivier <lvivier@redhat.com>, Max Gurtovoy <mgurtovoy@nvidia.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, Eli Cohen <elic@nvidia.com>
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
Content-Type: multipart/mixed; boundary="===============7158911690198133162=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

--===============7158911690198133162==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="NGIwU0kFl1Z1A3An"
Content-Disposition: inline

--NGIwU0kFl1Z1A3An
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 13, 2020 at 02:47:10PM +0100, Stefano Garzarella wrote:
> vringh_getdesc_iotlb() manages 2 iovs for writable and readable
> descriptors. This is very useful for the block device, where for
> each request we have both types of descriptor.
>=20
> Let's split the vdpasim_virtqueue's iov field in riov and wiov
> to use them with vringh_getdesc_iotlb().

Is riov/wiov naming common? VIRTIO uses "in" (device-to-driver) and
"out" (driver-to-device). Using VIRTIO terminology might be clearer.

Stefan

--NGIwU0kFl1Z1A3An
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl+zs4cACgkQnKSrs4Gr
c8gyXQf/ZimGDuF+KQ6wdqffxElUTSDfmEi9aKo+s0ffWcLS2VRhi2BrEplJZCkF
/e2hIuJt+kVvvSuXHWaIwtK25DSyVpFjo2TvV9DeYz5tnB8O+LPArPneLLThCqnF
56EE7/utit0+PmFCTn+gmhGCZh6uzfYcIv702qtuQ6UHhbcAZFETgidYhp+fbFsv
5NhbNG+rZZzWVzW4YU/UaDe69qY/YuHFHGmH+ekAG8WuBzd9IVCcvFwDZa6VccIL
ezMgtfIHKO0CSQpjlA6tMU9L7A/Vc+49e3oYtif4m+7DwjtpENk7KEOX8Wsp4ikG
pxGcS3eDQXYxDl1HduDoG5jb3Bzz/g==
=w7yP
-----END PGP SIGNATURE-----

--NGIwU0kFl1Z1A3An--


--===============7158911690198133162==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============7158911690198133162==--

