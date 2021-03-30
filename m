Return-Path: <SRS0=i4sF=I4=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FCE9C433DB
	for <virtualization@archiver.kernel.org>; Tue, 30 Mar 2021 08:55:42 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5F756195D
	for <virtualization@archiver.kernel.org>; Tue, 30 Mar 2021 08:55:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5F756195D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 6AECD40137;
	Tue, 30 Mar 2021 08:55:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DSchiQYyp-PS; Tue, 30 Mar 2021 08:55:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id 01E3B400AB;
	Tue, 30 Mar 2021 08:55:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C30C6C000B;
	Tue, 30 Mar 2021 08:55:39 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D0125C000A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 30 Mar 2021 08:55:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id BE4BF6073A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 30 Mar 2021 08:55:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zI-CiHzwyuDP
 for <virtualization@lists.linux-foundation.org>;
 Tue, 30 Mar 2021 08:55:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D4DC260725
 for <virtualization@lists.linux-foundation.org>;
 Tue, 30 Mar 2021 08:55:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1617094536;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FfDSaWPi6W83+JmpuupUJlWepDk9Pfcmxch5BwHNtQI=;
 b=NqC3CtJVFDL8lf4TWilHU//YhOM4nSBV+sPqdo2k2ZY92K+ifSsIQBkr1R8WTDn9VoONEd
 12OrXh2XyKuFiOlQsZynKQxbfvriMtKxMs0zKKlfw7nBUWUNrnFOMvz1K29pqcHpWiJg3L
 EFeC7aJCcNpdtsGDSrBdB95OP6MTUfc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-145-EaIHxcrXPI67Rsz6CQdBbw-1; Tue, 30 Mar 2021 04:55:32 -0400
X-MC-Unique: EaIHxcrXPI67Rsz6CQdBbw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 22EC58189C6;
 Tue, 30 Mar 2021 08:55:30 +0000 (UTC)
Received: from localhost (ovpn-115-22.ams2.redhat.com [10.36.115.22])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 901E56A8FD;
 Tue, 30 Mar 2021 08:55:25 +0000 (UTC)
Date: Tue, 30 Mar 2021 09:55:24 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Arseny Krasnov <arseny.krasnov@kaspersky.com>
Subject: Re: [virtio-comment] Re: [MASSMAIL KLMS] Re: [virtio-comment] [RFC
 PATCH v4 2/2] virtio-vsock: SOCK_SEQPACKET description
Message-ID: <YGLnfAxvy83jLkmG@stefanha-x1.localdomain>
References: <20210326090154.1144100-1-arseny.krasnov@kaspersky.com>
 <20210326090254.1144486-1-arseny.krasnov@kaspersky.com>
 <YGH8IqLRdh5JCZyT@stefanha-x1.localdomain>
 <230d95fd-29e8-465b-0ab2-b406d614c11b@kaspersky.com>
 <20210329212818.qdeprjhep745yeur@steredhat>
 <d6d92105-f7d4-74a3-4acc-fcfb40872b76@kaspersky.com>
MIME-Version: 1.0
In-Reply-To: <d6d92105-f7d4-74a3-4acc-fcfb40872b76@kaspersky.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Andra Paraschiv <andraprs@amazon.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, "cohuck@redhat.com" <cohuck@redhat.com>,
 Colin Ian King <colin.king@canonical.com>,
 Norbert Slusarek <nslusarek@gmx.net>,
 "oxffffaa@gmail.com" <oxffffaa@gmail.com>,
 "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
 Jakub Kicinski <kuba@kernel.org>, Alexander Popov <alex.popov@linux.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "David S. Miller" <davem@davemloft.net>, Jorgen Hansen <jhansen@vmware.com>
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
Content-Type: multipart/mixed; boundary="===============0249477394160720376=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

--===============0249477394160720376==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="6deGiYCe1WgmvBoX"
Content-Disposition: inline

--6deGiYCe1WgmvBoX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 30, 2021 at 09:15:39AM +0300, Arseny Krasnov wrote:
> On 30.03.2021 00:28, Stefano Garzarella wrote:
> > On Mon, Mar 29, 2021 at 08:33:27PM +0300, Arseny Krasnov wrote:
> >> On 29.03.2021 19:11, Stefan Hajnoczi wrote:
> >>> On Fri, Mar 26, 2021 at 12:02:50PM +0300, Arseny Krasnov wrote:
> >>>> @@ -98,6 +102,10 @@ \subsection{Device Operation}\label{sec:Device T=
ypes / Socket Device / Device Op
> >>>>  #define VIRTIO_VSOCK_OP_CREDIT_UPDATE  6
> >>>>  /* Request the peer to send the credit info to us */
> >>>>  #define VIRTIO_VSOCK_OP_CREDIT_REQUEST 7
> >>>> +/* Message begin for SOCK_SEQPACKET */
> >>>> +#define VIRTIO_VSOCK_OP_SEQ_BEGIN      8
> >>>> +/* Message end for SOCK_SEQPACKET */
> >>>> +#define VIRTIO_VSOCK_OP_SEQ_END        9
> >>> The struct virtio_vsock_hdr->flags field is le32 and currently unused=
.
> >>> Could 24 bits be used for a unique message id and 8 bits for flags? 1
> >>> flag bit could be used for end-of-message and the remaining 7 bits co=
uld
> >>> be reserved. That way SEQ_BEGIN and SEQ_END are not necessary. =20
> >>> Pressure
> >>> on the virtqueue would be reduced and performance should be comparabl=
e
> >>> to SOCK_STREAM.
> >> Well, my first versions of SOCK_SEQPACKET implementation, worked
> >> something like this: i used flags field of header as length of whole
> >> message. I discussed it with Stefano Garzarella, and he told that it=
=20
> >> will
> >> be better to use special "header" in packet's payload, to keep some
> >> SOCK_SEQPACKET specific data, instead of reusing packet's header
> >> fields.
> > IIRC in the first implementation SEQ_BEGIN was an empty message and we=
=20
> > didn't added the msg_id yet. So since we needed to carry both id and=20
> > total length, I suggested to use the payload to put these extra=20
> > information.
> >
> > IIUC what Stefan is suggesting is a bit different and I think it should=
=20
> > be cool to implement: we can remove the boundary packets, use only 8=20
> > bits for the flags, and add a new field to reuse the 24 unused bits,=20
> > maybe also 16 bits would be enough.
> > At that point we will only use the EOR flag to know the last packet.
> >
> > The main difference will be that the receiver will know the total size=
=20
> > only when the last packet is received.
> >
> > Do you see any issue on that approach?
>=20
> It will work, except we can't check that any packet of message,
>=20
> except last(with EOR bit) was dropped, since receiver don't know
>=20
> real length of message. If it is ok, then i can implement it.

The credit mechanism ensures that packets are not dropped, so it's not
necessary to check for this condition.

By the way, is a unique message ID needed? My understanding is:

If two messages are being sent on a socket at the same time either their
order is serialized (whichever message began first) or it is undefined
(whichever message completes first). I wonder if POSIX specifies this
and if Linux implements it (e.g. with AF_UNIX SOCK_SEQPACKET messages
that are multiple pages long and exceed sndbuf)?

Depending on these semantics maybe we don't need a unique message ID.
Instead the driver transmits messages sequentially. RW packets for
different messages on the same socket will never be interleaved.
Therefore the unique message ID is not needed and just the MSG_EOR flag
is enough to indicate message boundaries.

What do you think?

Stefan

--6deGiYCe1WgmvBoX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmBi53wACgkQnKSrs4Gr
c8ifHQf8CKnbLpRILKG1ZVpNXsVCthEv1thsDIjNenxUvXs97ghmwYpXjbDx+YKD
mjVbuORgW2HjfjJ5NBdvr+lPVBQS35I9FeVwtAKNeVkkIn2Vpnrc8nzrFKFpriGK
/wcGo1VGcIqJo4GHfhjYB0s/dc3N7FyFpDy+egS7Mdkjju/79fjGJCvy/U50fVA/
3TidGRbFp4n7IcIQSRVcdX/6Fdfr+r76rI/kRtoz/72IMwj3VA/PyerKB14O3A6F
pU4EO+hIp47hJBUXjpdM7a5p+GdgJfLopO26OX7OTRZx0ljB3DcCz4s1h9Jefshy
LyHLjg7MdDZVKes0R+R74u5VxVJLxQ==
=+7lq
-----END PGP SIGNATURE-----

--6deGiYCe1WgmvBoX--


--===============0249477394160720376==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============0249477394160720376==--

