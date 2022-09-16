Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 730DEECAAD8
	for <virtualization@archiver.kernel.org>; Fri, 16 Sep 2022 06:10:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id F15A5611DF;
	Fri, 16 Sep 2022 06:10:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org F15A5611DF
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=N7H4jCpM
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id y54jF5FV_AIb; Fri, 16 Sep 2022 06:10:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 52268611D9;
	Fri, 16 Sep 2022 06:10:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 52268611D9
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0D59AC0033;
	Fri, 16 Sep 2022 06:10:14 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 31BD4C002D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 16 Sep 2022 06:10:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0BA4B83E9B
 for <virtualization@lists.linux-foundation.org>;
 Fri, 16 Sep 2022 06:10:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0BA4B83E9B
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=N7H4jCpM
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3lUKlcZx8Kqj
 for <virtualization@lists.linux-foundation.org>;
 Fri, 16 Sep 2022 06:10:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9C4C683E75
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9C4C683E75
 for <virtualization@lists.linux-foundation.org>;
 Fri, 16 Sep 2022 06:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1663308609;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WexFcKZFirN/jM+xTeznAj7e5nDORoI0aBqRUMifb8Y=;
 b=N7H4jCpMNSI6PtRVRwp4Kow40kSjqXq1rjLogFlWjun5JZLtGRwWxc1hYmuk/ryiFNGzMl
 2Am9T/WNyiDNu9BZ+BgOwOuSTvdvOkHkomSHN49q5bWOiBCGaJlTWi7WTZwucuGb403H5H
 3NDO3ruQ1MsvxmGAz09zkhvqtauhXlA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-292-jZYnFVjgP6GqmjFBWdto1w-1; Fri, 16 Sep 2022 02:09:58 -0400
X-MC-Unique: jZYnFVjgP6GqmjFBWdto1w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7BE48882822;
 Fri, 16 Sep 2022 06:09:57 +0000 (UTC)
Received: from localhost (unknown [10.39.192.86])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 46FC3C15BA4;
 Fri, 16 Sep 2022 06:09:56 +0000 (UTC)
Date: Fri, 16 Sep 2022 07:09:55 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Sarthak Kukreti <sarthakkukreti@chromium.org>
Subject: Re: [PATCH RFC 0/8] Introduce provisioning primitives for thinly
 provisioned storage
Message-ID: <YyQTM5PRT2o/GDwy@fedora>
References: <20220915164826.1396245-1-sarthakkukreti@google.com>
MIME-Version: 1.0
In-Reply-To: <20220915164826.1396245-1-sarthakkukreti@google.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Cc: Jens Axboe <axboe@kernel.dk>, Gwendal Grignou <gwendal@google.com>,
 Theodore Ts'o <tytso@mit.edu>, "Michael S . Tsirkin" <mst@redhat.com>,
 Bart Van Assche <bvanassche@google.com>, Mike Snitzer <snitzer@kernel.org>,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 linux-block@vger.kernel.org, dm-devel@redhat.com,
 Andreas Dilger <adilger.kernel@dilger.ca>, Daniil Lunev <dlunev@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>, linux-ext4@vger.kernel.org,
 Evan Green <evgreen@google.com>, Alasdair Kergon <agk@redhat.com>
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
Content-Type: multipart/mixed; boundary="===============4862343357281960716=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>


--===============4862343357281960716==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="w/wnRFkY16cMLsvF"
Content-Disposition: inline


--w/wnRFkY16cMLsvF
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 15, 2022 at 09:48:18AM -0700, Sarthak Kukreti wrote:
> From: Sarthak Kukreti <sarthakkukreti@chromium.org>
>=20
> Hi,
>=20
> This patch series is an RFC of a mechanism to pass through provision requ=
ests on stacked thinly provisioned storage devices/filesystems.
>=20
> The linux kernel provides several mechanisms to set up thinly provisioned=
 block storage abstractions (eg. dm-thin, loop devices over sparse files), =
either directly as block devices or backing storage for filesystems. Curren=
tly, short of writing data to either the device or filesystem, there is no =
way for users to pre-allocate space for use in such storage setups. Conside=
r the following use-cases:
>=20
> 1) Suspend-to-disk and resume from a dm-thin device: In order to ensure t=
hat the underlying thinpool metadata is not modified during the suspend mec=
hanism, the dm-thin device needs to be fully provisioned.
> 2) If a filesystem uses a loop device over a sparse file, fallocate() on =
the filesystem will allocate blocks for files but the underlying sparse fil=
e will remain intact.
> 3) Another example is virtual machine using a sparse file/dm-thin as a st=
orage device; by default, allocations within the VM boundaries will not aff=
ect the host.
> 4) Several storage standards support mechanisms for thin provisioning on =
real hardware devices. For example:
>   a. The NVMe spec 1.0b section 2.1.1 loosely talks about thin provisioni=
ng: "When the THINP bit in the NSFEAT field of the Identify Namespace data =
structure is set to =E2=80=981=E2=80=99, the controller ... shall track the=
 number of allocated blocks in the Namespace Utilization field"
>   b. The SCSi Block Commands reference - 4 section references "Thin provi=
sioned logical units",
>   c. UFS 3.0 spec section 13.3.3 references "Thin provisioning".

When REQ_OP_PROVISION is sent on an already-allocated range of blocks,
are those blocks zeroed? NVMe Write Zeroes with Deallocate=3D0 works this
way, for example. That behavior is counterintuitive since the operation
name suggests it just affects the logical block's provisioning state,
not the contents of the blocks.

> In all of the above situations, currently the only way for pre-allocating=
 space is to issue writes (or use WRITE_ZEROES/WRITE_SAME). However, that d=
oes not scale well with larger pre-allocation sizes.=20

What exactly is the issue with WRITE_ZEROES scalability? Are you
referring to cases where the device doesn't support an efficient
WRITE_ZEROES command and actually writes blocks filled with zeroes
instead of updating internal allocation metadata cheaply?

Stefan

--w/wnRFkY16cMLsvF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmMkEzMACgkQnKSrs4Gr
c8hn3wgAjJDAhaMbZwpCmdUdohpKtyMia1I6OsTlcURdfUV2iu1afmfcG5c7Q2pV
ZPZC+DZhgUOEkpD1Aj5gCjpi8/1EXpmCwDGB36AgVnwzCMV9QLdW7B3xoCvJipNa
b+KGhLFliE0pBX9ZGYqCZ7a8Tuz2OGtNhpAsd/tUOMYCLzc6WTqTIeB6Wv6rYrw4
kIF+kP7pEK4INQYAav+pYDzZxqd4yrKINa6PEOZUMxzuLnH4eW8l+xrsTDIMbA+e
ummgls1ZrhgPhUJNqscmevqfJMLqMsZTxN6+B9zH+G6GrxAc1rqeRTdlMAwwYxYg
DIMeBAXmfutiQDOVF8Tj6W1p7wrNLw==
=s/zf
-----END PGP SIGNATURE-----

--w/wnRFkY16cMLsvF--


--===============4862343357281960716==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============4862343357281960716==--

