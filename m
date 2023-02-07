Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72D72C64ED8
	for <virtualization@archiver.kernel.org>; Tue,  7 Feb 2023 21:32:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DCEE94171E;
	Tue,  7 Feb 2023 21:32:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org DCEE94171E
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Jl8a+4Mz
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0GZGXL6m0J27; Tue,  7 Feb 2023 21:32:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 2BF86416ED;
	Tue,  7 Feb 2023 21:32:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2BF86416ED
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 05098C0033;
	Tue,  7 Feb 2023 21:32:13 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 80314C002B
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Feb 2023 21:32:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5AA5D61044
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Feb 2023 21:32:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5AA5D61044
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Jl8a+4Mz
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jgMX6Ro6IkEc
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Feb 2023 21:32:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4C17761042
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4C17761042
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Feb 2023 21:32:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1675805528;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=k3k1fen54zftZrOy46HBwu2Sbu6PqY4Tuz4A1LMJQ5g=;
 b=Jl8a+4Mzn7fWroTFm5q+q+Y6vUcN44dM9jqJONxd5sap1p537xo05C5B4zfFp5yFkIlArr
 ObNV7rAV1aYP1e2X+zt8rJeKZEWha6lLEiiNiGTwUusmMTKIVGVhU2+Tms60bMsvR3JRw8
 lrqSzksV9AeUeemF+q7FKDtirZJ/ejo=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-339-vgrehFlGMeezwvXT_aOPMw-1; Tue, 07 Feb 2023 16:32:06 -0500
X-MC-Unique: vgrehFlGMeezwvXT_aOPMw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C98331C426A0;
 Tue,  7 Feb 2023 21:32:05 +0000 (UTC)
Received: from localhost (unknown [10.39.192.15])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8ACB040398A0;
 Tue,  7 Feb 2023 21:32:04 +0000 (UTC)
Date: Tue, 7 Feb 2023 16:32:02 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: virtio-fs: adding support for multi-queue
Message-ID: <Y+LDUmWyXCdPIriB@fedora>
References: <2fd99bc2-0414-0b85-2bff-3a84ae6c23bd@gootzen.net>
 <Y+KqY3Nse0pVhd3X@fedora> <Y+KsVhIR9aEoSdRu@redhat.com>
MIME-Version: 1.0
In-Reply-To: <Y+KsVhIR9aEoSdRu@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Cc: German Maglione <gmaglione@redhat.com>,
 virtualization@lists.linux-foundation.org,
 Jonas Pfefferle <JPF@zurich.ibm.com>, miklos@szeredi.hu
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
Content-Type: multipart/mixed; boundary="===============8954147259806209082=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>


--===============8954147259806209082==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="faGnl+fV3hCw5ZpB"
Content-Disposition: inline


--faGnl+fV3hCw5ZpB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 07, 2023 at 02:53:58PM -0500, Vivek Goyal wrote:
> On Tue, Feb 07, 2023 at 02:45:39PM -0500, Stefan Hajnoczi wrote:
> > On Tue, Feb 07, 2023 at 11:14:46AM +0100, Peter-Jan Gootzen wrote:
> > > Hi,
> > >=20
>=20
> [cc German]
>=20
> > > For my MSc thesis project in collaboration with IBM
> > > (https://github.com/IBM/dpu-virtio-fs) we are looking to improve the
> > > performance of the virtio-fs driver in high throughput scenarios. We =
think
> > > the main bottleneck is the fact that the virtio-fs driver does not su=
pport
> > > multi-queue (while the spec does). A big factor in this is that our s=
etup on
> > > the virtio-fs device-side (a DPU) does not easily allow multiple core=
s to
> > > tend to a single virtio queue.
>=20
> This is an interesting limitation in DPU.

Virtqueues are single-consumer queues anyway. Sharing them between
multiple threads would be expensive. I think using multiqueue is natural
and not specific to DPUs.

Stefan

--faGnl+fV3hCw5ZpB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmPiw1IACgkQnKSrs4Gr
c8jy5Af+POLyRhJ/CiB2V3bUQsWchUrS15jIxidYhrtze6LlG0ZQcxPPCAynNIH/
lM7MYVZgJFt8Au1lNUTQRRxjYKJRrmdgvmCGoEv40Yd+OXsD7QkzFOG5KakETAgf
6TWqVI0OwEQSfke85heuMqrnBs+Q7asI1leOREv8xsdjccfS0XxUfi9j6+p7ZICN
2kRN0VeHmiC3Zf9mjAx9WB4jfA3QrzRVcr0uvlU/X6zM+EgtTHNVlWq8Ch/qH5Nk
AWCFvZ6spMZNEaskN6lS7DmUhghJ0P47jQGYkNOtYP7tdGeZzKFAsk8TVH6NXQfg
J3u7uCf231qVaEAVq9VXwnP3SvM8Sw==
=aWYG
-----END PGP SIGNATURE-----

--faGnl+fV3hCw5ZpB--


--===============8954147259806209082==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============8954147259806209082==--

