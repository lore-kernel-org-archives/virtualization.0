Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FC58ECAAD3
	for <virtualization@archiver.kernel.org>; Mon, 19 Sep 2022 16:37:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9248460BFC;
	Mon, 19 Sep 2022 16:37:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9248460BFC
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Jd+MzNEr
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UEIZgl2ZGa3f; Mon, 19 Sep 2022 16:37:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id D7BAB60BF3;
	Mon, 19 Sep 2022 16:37:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D7BAB60BF3
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AD3E2C0032;
	Mon, 19 Sep 2022 16:37:01 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 83AEFC002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Sep 2022 16:37:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 50A4282BBA
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Sep 2022 16:37:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 50A4282BBA
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Jd+MzNEr
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id w3I3IhTpq-Ba
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Sep 2022 16:36:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5ED5882681
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5ED5882681
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Sep 2022 16:36:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1663605418;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Mchxf99lMev1aFGv2K+bOlvQAf7i2XmiTm89Tkqpih0=;
 b=Jd+MzNEriGTjP16ZUou8mauS7K1ZNN9pUEC6sDfqvt9SpdXWh1nmbp161ByoGb8XcRyDjJ
 dAefJ3ub49zMO+5LEBNp0xbbOt5eMp0Wlvh73dQ6UgKqwWgFi1hUNAlGRe1Fb/GUX2aJt0
 zz5oRrReUMUbXcz2pVahRa8iKZvjHHk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-168-e-vBbojmMZqRGk6nJlTDWA-1; Mon, 19 Sep 2022 12:36:52 -0400
X-MC-Unique: e-vBbojmMZqRGk6nJlTDWA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2DC3B811E67;
 Mon, 19 Sep 2022 16:36:52 +0000 (UTC)
Received: from localhost (unknown [10.39.192.144])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E3F74207B34A;
 Mon, 19 Sep 2022 16:36:50 +0000 (UTC)
Date: Mon, 19 Sep 2022 12:36:48 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Sarthak Kukreti <sarthakkukreti@chromium.org>
Subject: Re: [dm-devel] [PATCH RFC 0/8] Introduce provisioning primitives for
 thinly provisioned storage
Message-ID: <YyiaoHcueK9g5KVy@fedora>
References: <20220915164826.1396245-1-sarthakkukreti@google.com>
 <YyU5CyQfS+64xmnm@magnolia>
 <CAG9=OMNPnsjaUw2EUG0XFjV94-V1eD63V+1anoGM=EWKyzXEfg@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAG9=OMNPnsjaUw2EUG0XFjV94-V1eD63V+1anoGM=EWKyzXEfg@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Cc: Jens Axboe <axboe@kernel.dk>, Gwendal Grignou <gwendal@google.com>,
 Theodore Ts'o <tytso@mit.edu>, "Michael S . Tsirkin" <mst@redhat.com>,
 "Darrick J. Wong" <djwong@kernel.org>, Bart Van Assche <bvanassche@google.com>,
 Mike Snitzer <snitzer@kernel.org>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, linux-block@vger.kernel.org,
 dm-devel@redhat.com, Evan Green <evgreen@google.com>,
 Daniil Lunev <dlunev@google.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Andreas Dilger <adilger.kernel@dilger.ca>, linux-ext4@vger.kernel.org,
 Alasdair Kergon <agk@redhat.com>
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
Content-Type: multipart/mixed; boundary="===============3377235694250105781=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>


--===============3377235694250105781==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="FvyRLtY8FNQa7tFK"
Content-Disposition: inline


--FvyRLtY8FNQa7tFK
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 17, 2022 at 12:46:33PM -0700, Sarthak Kukreti wrote:
> On Fri, Sep 16, 2022 at 8:03 PM Darrick J. Wong <djwong@kernel.org> wrote:
> >
> > On Thu, Sep 15, 2022 at 09:48:18AM -0700, Sarthak Kukreti wrote:
> > > From: Sarthak Kukreti <sarthakkukreti@chromium.org>
> > >
> > > Hi,
> > >
> > > This patch series is an RFC of a mechanism to pass through provision
> > > requests on stacked thinly provisioned storage devices/filesystems.
> >
> > [Reflowed text]
> >
> > > The linux kernel provides several mechanisms to set up thinly
> > > provisioned block storage abstractions (eg. dm-thin, loop devices over
> > > sparse files), either directly as block devices or backing storage for
> > > filesystems. Currently, short of writing data to either the device or
> > > filesystem, there is no way for users to pre-allocate space for use in
> > > such storage setups. Consider the following use-cases:
> > >
> > > 1) Suspend-to-disk and resume from a dm-thin device: In order to
> > > ensure that the underlying thinpool metadata is not modified during
> > > the suspend mechanism, the dm-thin device needs to be fully
> > > provisioned.
> > > 2) If a filesystem uses a loop device over a sparse file, fallocate()
> > > on the filesystem will allocate blocks for files but the underlying
> > > sparse file will remain intact.
> > > 3) Another example is virtual machine using a sparse file/dm-thin as a
> > > storage device; by default, allocations within the VM boundaries will
> > > not affect the host.
> > > 4) Several storage standards support mechanisms for thin provisioning
> > > on real hardware devices. For example:
> > >   a. The NVMe spec 1.0b section 2.1.1 loosely talks about thin
> > >   provisioning: "When the THINP bit in the NSFEAT field of the
> > >   Identify Namespace data structure is set to =E2=80=981=E2=80=99, th=
e controller ...
> > >   shall track the number of allocated blocks in the Namespace
> > >   Utilization field"
> > >   b. The SCSi Block Commands reference - 4 section references "Thin
> > >   provisioned logical units",
> > >   c. UFS 3.0 spec section 13.3.3 references "Thin provisioning".
> > >
> > > In all of the above situations, currently the only way for
> > > pre-allocating space is to issue writes (or use
> > > WRITE_ZEROES/WRITE_SAME). However, that does not scale well with
> > > larger pre-allocation sizes.
> > >
> > > This patchset introduces primitives to support block-level
> > > provisioning (note: the term 'provisioning' is used to prevent
> > > overloading the term 'allocations/pre-allocations') requests across
> > > filesystems and block devices. This allows fallocate() and file
> > > creation requests to reserve space across stacked layers of block
> > > devices and filesystems. Currently, the patchset covers a prototype on
> > > the device-mapper targets, loop device and ext4, but the same
> > > mechanism can be extended to other filesystems/block devices as well
> > > as extended for use with devices in 4 a-c.
> >
> > If you call REQ_OP_PROVISION on an unmapped LBA range of a block device
> > and then try to read the provisioned blocks, what do you get?  Zeroes?
> > Random stale disk contents?
> >
> > I think I saw elsewhere in the thread that any mapped LBAs within the
> > provisioning range are left alone (i.e. not zeroed) so I'll proceed on
> > that basis.
> >
> For block devices, I'd say it's definitely possible to get stale data, de=
pending
> on the implementation of the allocation layer; for example, with dm-thinp=
ool,
> the default setting via using LVM2 tools is to zero out blocks on allocat=
ion.
> But that's configurable and can be turned off to improve performance.
>=20
> Similarly, for actual devices that end up supporting thin provisioning, u=
nless
> the specification absolutely mandates that an LBA contains zeroes post
> allocation, some implementations will definitely miss out on that (probab=
ly
> similar to the semantics of discard_zeroes_data today). I'm operating und=
er
> the assumption that it's possible to get stale data from LBAs allocated u=
sing
> provision requests at the block layer and trying to see if we can create a
> safe default operating model from that.

Please explain the semantics of REQ_OP_PROVISION in the
code/documentation in the next revision.

Thanks,
Stefan

--FvyRLtY8FNQa7tFK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmMomqAACgkQnKSrs4Gr
c8g4vQf/TYZDC6JT8LCVfsDWkwegZYqhX4pz86cryayWYFUYe3u9UmLPrY/TuE1y
XQwzM9jsI+LdCcQtLZtvre/JsJB6esC/LGv+FTGOSju2n0FLXTS7v80LujcoHnKE
7RZ0eliz4XGK/X1Q6rLVgNFhFUcQIM4yYNKsAklXpSApXwgQ5W8mKI7GVqi+rhds
UynMkkK2XKPIeBVRJg7gNCx4vTnwas+AQ5QCuAoGpRxvTcPmKlP9krCi0owiGZKR
08ORDLnl4g8uxmkJQoYR6Ep6bnJY4mq9XSeNMYwOEWAd63h3aYO27kxvClgMo0mV
wb0jbsC1V0Qd8XvrdufP80ym3TVKCg==
=HyVg
-----END PGP SIGNATURE-----

--FvyRLtY8FNQa7tFK--


--===============3377235694250105781==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============3377235694250105781==--

