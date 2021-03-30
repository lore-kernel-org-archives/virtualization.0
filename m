Return-Path: <SRS0=i4sF=I4=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C071BC433C1
	for <virtualization@archiver.kernel.org>; Tue, 30 Mar 2021 13:57:59 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E41061998
	for <virtualization@archiver.kernel.org>; Tue, 30 Mar 2021 13:57:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E41061998
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 17F76401CB;
	Tue, 30 Mar 2021 13:57:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ViFI8vM7hc4M; Tue, 30 Mar 2021 13:57:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id 53673401B9;
	Tue, 30 Mar 2021 13:57:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 296F0C000C;
	Tue, 30 Mar 2021 13:57:57 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A937CC000A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 30 Mar 2021 13:57:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8F04D83E69
 for <virtualization@lists.linux-foundation.org>;
 Tue, 30 Mar 2021 13:57:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IPEEI5y5bIiA
 for <virtualization@lists.linux-foundation.org>;
 Tue, 30 Mar 2021 13:57:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 52D5F83E67
 for <virtualization@lists.linux-foundation.org>;
 Tue, 30 Mar 2021 13:57:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1617112673;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ubaZev7RrQRH5Ep3AzjoTkowf5nKByLfTB8L6mxB/WY=;
 b=CeK/zhhbPeCHj5HOXx+6/TG7Es4L28SuxHoLu6v3Nj42WieG8ywjD1LcyHLXNM5UApS0O6
 OLS4o1iVA+wX2kpDfkOocL/kqnnw89lUWqTd1nK+gdK1CVA99V68QydHRxeylKlSadDlp8
 2kiIPqAa0V+m36dvVmmBspDhnteG0WM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-280-RKXoDc-ONnaQnyVzX0azIg-1; Tue, 30 Mar 2021 09:57:49 -0400
X-MC-Unique: RKXoDc-ONnaQnyVzX0azIg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D47041922021;
 Tue, 30 Mar 2021 13:57:47 +0000 (UTC)
Received: from localhost (ovpn-115-22.ams2.redhat.com [10.36.115.22])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8CD771002388;
 Tue, 30 Mar 2021 13:57:42 +0000 (UTC)
Date: Tue, 30 Mar 2021 14:57:41 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Arseny Krasnov <arseny.krasnov@kaspersky.com>
Subject: Re: [virtio-comment] Re: [MASSMAIL KLMS] Re: [virtio-comment] [RFC
 PATCH v4 2/2] virtio-vsock: SOCK_SEQPACKET description
Message-ID: <YGMuVWL1waLpTkFI@stefanha-x1.localdomain>
References: <20210326090154.1144100-1-arseny.krasnov@kaspersky.com>
 <20210326090254.1144486-1-arseny.krasnov@kaspersky.com>
 <YGH8IqLRdh5JCZyT@stefanha-x1.localdomain>
 <230d95fd-29e8-465b-0ab2-b406d614c11b@kaspersky.com>
 <20210329212818.qdeprjhep745yeur@steredhat>
 <d6d92105-f7d4-74a3-4acc-fcfb40872b76@kaspersky.com>
 <YGLnfAxvy83jLkmG@stefanha-x1.localdomain>
 <2061f2ab-f3fc-c059-7cfc-a34b06f061fe@kaspersky.com>
MIME-Version: 1.0
In-Reply-To: <2061f2ab-f3fc-c059-7cfc-a34b06f061fe@kaspersky.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
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
Content-Type: multipart/mixed; boundary="===============9190463952425456636=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

--===============9190463952425456636==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="jM1+QQW1BZA1AWHV"
Content-Disposition: inline

--jM1+QQW1BZA1AWHV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 30, 2021 at 12:50:06PM +0300, Arseny Krasnov wrote:
>=20
> On 30.03.2021 11:55, Stefan Hajnoczi wrote:
> > On Tue, Mar 30, 2021 at 09:15:39AM +0300, Arseny Krasnov wrote:
> >> On 30.03.2021 00:28, Stefano Garzarella wrote:
> >>> On Mon, Mar 29, 2021 at 08:33:27PM +0300, Arseny Krasnov wrote:
> >>>> On 29.03.2021 19:11, Stefan Hajnoczi wrote:
> >>>>> On Fri, Mar 26, 2021 at 12:02:50PM +0300, Arseny Krasnov wrote:
> >>>>>> @@ -98,6 +102,10 @@ \subsection{Device Operation}\label{sec:Device=
 Types / Socket Device / Device Op
> >>>>>>  #define VIRTIO_VSOCK_OP_CREDIT_UPDATE  6
> >>>>>>  /* Request the peer to send the credit info to us */
> >>>>>>  #define VIRTIO_VSOCK_OP_CREDIT_REQUEST 7
> >>>>>> +/* Message begin for SOCK_SEQPACKET */
> >>>>>> +#define VIRTIO_VSOCK_OP_SEQ_BEGIN      8
> >>>>>> +/* Message end for SOCK_SEQPACKET */
> >>>>>> +#define VIRTIO_VSOCK_OP_SEQ_END        9
> >>>>> The struct virtio_vsock_hdr->flags field is le32 and currently unus=
ed.
> >>>>> Could 24 bits be used for a unique message id and 8 bits for flags?=
 1
> >>>>> flag bit could be used for end-of-message and the remaining 7 bits =
could
> >>>>> be reserved. That way SEQ_BEGIN and SEQ_END are not necessary. =20
> >>>>> Pressure
> >>>>> on the virtqueue would be reduced and performance should be compara=
ble
> >>>>> to SOCK_STREAM.
> >>>> Well, my first versions of SOCK_SEQPACKET implementation, worked
> >>>> something like this: i used flags field of header as length of whole
> >>>> message. I discussed it with Stefano Garzarella, and he told that it=
=20
> >>>> will
> >>>> be better to use special "header" in packet's payload, to keep some
> >>>> SOCK_SEQPACKET specific data, instead of reusing packet's header
> >>>> fields.
> >>> IIRC in the first implementation SEQ_BEGIN was an empty message and w=
e=20
> >>> didn't added the msg_id yet. So since we needed to carry both id and=
=20
> >>> total length, I suggested to use the payload to put these extra=20
> >>> information.
> >>>
> >>> IIUC what Stefan is suggesting is a bit different and I think it shou=
ld=20
> >>> be cool to implement: we can remove the boundary packets, use only 8=
=20
> >>> bits for the flags, and add a new field to reuse the 24 unused bits,=
=20
> >>> maybe also 16 bits would be enough.
> >>> At that point we will only use the EOR flag to know the last packet.
> >>>
> >>> The main difference will be that the receiver will know the total siz=
e=20
> >>> only when the last packet is received.
> >>>
> >>> Do you see any issue on that approach?
> >> It will work, except we can't check that any packet of message,
> >>
> >> except last(with EOR bit) was dropped, since receiver don't know
> >>
> >> real length of message. If it is ok, then i can implement it.
> > The credit mechanism ensures that packets are not dropped, so it's not
> > necessary to check for this condition.
> >
> > By the way, is a unique message ID needed? My understanding is:
> >
> > If two messages are being sent on a socket at the same time either thei=
r
> > order is serialized (whichever message began first) or it is undefined
> > (whichever message completes first).
>=20
> If we are talking about case, when two threads writes to one socket at th=
e same time,
>=20
> in Linux it is possible that two message will interleave(for vsock). But =
as i know, for example
>=20
> when TCP socket is used, both 'write()' calls will be serialized. May be =
it is bug of vsock: when
>=20
> first writer goes out of space, it will sleep. Then second writer tries t=
o send something, but
>=20
> as free space is over, it will sleep too. Then, credit update is received=
 from peer. Both sender's
>=20
> will be woken up, but sender which grab socket lock first will continue t=
o send it's message.
>=20
> So may be we can add something like semaphore to new/vmw_vsock/af_vsock.c=
 which will
>=20
> serialize two 'write()' calls: second sender enters 'write()' path, only =
when first left this path.
>=20
> My implementation doesn't care about that, because i wanted to add semaph=
ore later, by another
>=20
> patch.

Yes, that is definitely an issue that the driver needs to take care of
if we don't have unique message IDs. Thanks for explaining!

Stefan

--jM1+QQW1BZA1AWHV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmBjLlUACgkQnKSrs4Gr
c8j6gQf/V0sfdvdDu0QFpdxzpG3TZeTN7q+Dbj47t8+dPhalzM1N9TN2K6UBIVB7
TU+Dpj3MVaoYB2qwrPcTIw/nU7SyVGgzXy6klyRWyUlCd3l6MJ8zvYhwd0uwEmkQ
B6CcgZV+0Dw/OGSoxAxK+PrK7akF7kKmmr5cQ/VNSxZFImlV8fJXRLXNEEA5i2cX
RLxrJc/2oKOxswiHF8JoEgy6sX0yJTL+vwY7WB2kncodmizbPNaJb8uKWvbGaify
G3zq7IPkiIj15qDGscnwUndZn7oKHoPhJNGpT/WgoPX886j5mQuBUYBSaRI5q16g
qUaqFY3sRnIB8PgUgSVx1RWt5TdxRA==
=I4oG
-----END PGP SIGNATURE-----

--jM1+QQW1BZA1AWHV--


--===============9190463952425456636==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============9190463952425456636==--

