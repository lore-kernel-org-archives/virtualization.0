Return-Path: <SRS0=J7l7=KI=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46742C433B4
	for <virtualization@archiver.kernel.org>; Thu, 13 May 2021 16:04:52 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE19E613BC
	for <virtualization@archiver.kernel.org>; Thu, 13 May 2021 16:04:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE19E613BC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 6C61C403D8;
	Thu, 13 May 2021 16:04:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8hCEPz3SSPkQ; Thu, 13 May 2021 16:04:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id CF6274036F;
	Thu, 13 May 2021 16:04:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9F373C000D;
	Thu, 13 May 2021 16:04:47 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id ADAC4C0001
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 May 2021 16:04:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9B98383A95
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 May 2021 16:04:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jZyFbAkeKKzo
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 May 2021 16:04:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9D4C283A5D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 May 2021 16:04:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1620921881;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+R+hhF7QdklDaSIWvQ7qVPMo70pmJ3rx+cKdOfnkIlA=;
 b=BUGLoYaWfm3fIls10GZLqs0P3Vlc3EX7y21b7h9FmzRcDb4R+2Ws/e5nZiq/fv1Ja3/kJa
 TSIoqNXuKRw/nA/lcfGXO2uUZtnEBnmo7hDe7Mwrj2Q/XanlWaBX9KXM3Uoauiuxbvh/0M
 KEpKQY8emUJjIt0uITo37ERJ8+y0DkE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-485-lIhWKMk6Ov6uLRq_6t38Zw-1; Thu, 13 May 2021 12:04:36 -0400
X-MC-Unique: lIhWKMk6Ov6uLRq_6t38Zw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 059D46D4E0;
 Thu, 13 May 2021 16:04:35 +0000 (UTC)
Received: from localhost (ovpn-113-21.ams2.redhat.com [10.36.113.21])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 931EB6267D;
 Thu, 13 May 2021 16:04:27 +0000 (UTC)
Date: Thu, 13 May 2021 17:04:26 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: "Cong Wang ." <cong.wang@bytedance.com>
Subject: Re: [RFC PATCH] virtio-vsock: add description for datagram type
Message-ID: <YJ1OCvKkWiCkIHPG@stefanha-x1.localdomain>
References: <20210316215644.2254177-1-jiang.wang@bytedance.com>
 <YFIj+FQQzZmVAqWw@stefanha-x1.localdomain>
 <CAA68J_bQHzFXnsLpCqZ3waPW1NGz+hnu2OXfAG4XOLemLOX9DQ@mail.gmail.com>
 <YIblMHI+NplPHIDx@stefanha-x1.localdomain>
 <CAA68J_Z=1uf5rLCpQeH+m9YmsYGsbJgf2VtRJjQrBd_jTdUYuA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAA68J_Z=1uf5rLCpQeH+m9YmsYGsbJgf2VtRJjQrBd_jTdUYuA@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: =?utf-8?B?5q6154aK5pil?= <duanxiongchun@bytedance.com>,
 "jiang.wang" <jiang.wang@bytedance.com>, mst@redhat.com, cohuck@redhat.com,
 virtualization@lists.linux-foundation.org, xieyongji@bytedance.com,
 asias@redhat.com, arseny.krasnov@kaspersky.com
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
Content-Type: multipart/mixed; boundary="===============7947346586688680365=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

--===============7947346586688680365==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="azHSYEAzgbpgRn8u"
Content-Disposition: inline

--azHSYEAzgbpgRn8u
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 06, 2021 at 04:56:48PM -0700, Cong Wang . wrote:
> On Mon, Apr 26, 2021 at 9:07 AM Stefan Hajnoczi <stefanha@redhat.com> wro=
te:
> >
> > On Wed, Apr 14, 2021 at 05:43:52PM -0700, Cong Wang . wrote:
> > > On Wed, Mar 17, 2021 at 8:45 AM Stefan Hajnoczi <stefanha@redhat.com>=
 wrote:
> > > >
> > > > Please stick to UDP semantics as much as possible so that applicati=
ons
> > > > can be ported easily and developers aren't surprised by unexpected
> > > > behavior. UDP packets sent to a destination that has no listen sock=
et
> > > > result in a Connection Refused error. vsock dgrams should behave in=
 the
> > > > same way.
> > >
> > > There is no connection refused error for UDP, as it is clearly connec=
tionless.
> > > What you suggested might be an ICMP unreachable error, however, vsock=
 does
> > > not have anything equivalent. So, I think there is no error returned
> > > in this scenario
> > > for vsock datagram.
> >
> > Yes, exactly. UDP uses ICMP unreachable:
> >
> >   16:55:40.380292 IP 127.0.0.1.41519 > 127.0.0.1.1234: UDP, length 5
> >   16:55:40.380308 IP 127.0.0.1 > 127.0.0.1: ICMP 127.0.0.1 udp port 123=
4 unreachable, length 41
> >
> > This is mentioned a bit here:
> > https://tools.ietf.org/html/rfc8085#section-5.2
> >
> > Here is how Python's socket module produces an ConnectionRefused
> > exception:
> >
> >   socket(AF_INET, SOCK_DGRAM|SOCK_CLOEXEC, IPPROTO_IP) =3D 3
> >   sendto(3, "hello", 5, 0, {sa_family=3DAF_INET, sin_port=3Dhtons(1234)=
, sin_addr=3Dinet_addr("127.0.0.1")}, 16) =3D 5
> >   getsockname(3, {sa_family=3DAF_INET, sin_port=3Dhtons(41519), sin_add=
r=3Dinet_addr("0.0.0.0")}, [16]) =3D 0
> >   getpeername(3, 0x7ffc43c99a20, [16])    =3D -1 ENOTCONN (Transport en=
dpoint is not connected)
>=20
> Yes, we are all aware of these UDP behaviors.
>=20
> >
> > UDP itself may not carry this information but applications do rely on
> > the ICMP information as shown above.
> >
> > The Linux network stack implementation is here:
> > net/ipv4/udp.c:__udp4_lib_err().
>=20
> Sure, but applications using UDP when porting to vsock dgram, they
> must be aware AF_VSOCK has totally different protocols from AF_INET,
> hence behaves differently from AF_INET. Therefore, it is not necessary
> to do everything UDP does here, particularly not necessary to mimic ICMP
> in vsock. In short, I don't think there is any standard to enforce what
> dgram sockets must behave, each address family should have its right
> to behave reasonably differently.

They can behave differently but at the cost of making it harder to port
applications. Sending a RST packet in vsock is easy and allows
applications to get the same behavior as with UDP/ICMP. I don't see a
reason to avoid it.

Stefan

--azHSYEAzgbpgRn8u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmCdTgoACgkQnKSrs4Gr
c8iRYwgAtCAMcgrVf3AvYv2kZG2jRPZ7jIkLztNDgyh+Fclb9Defvcs2dPsZepDe
EN1CnUqoWUYwVIPXgdkmFuLtHD3iDFAk16awKPJDFBaGuQ4UvnVFhsl4222jNTkF
CF8lvw7vODTMI9KDupwH+WQAvCTWbOAaDOPDmcBxzMRL8R2u9j8VGAQPGTSisgx9
bwG8xHmOyxOnQoT/y6dtANK49hnANP38I8RScZ58lfJXPAzW5Jf0JKW+SlPyr8uu
TL2720/JLmeVrBChL/Z85aR3h9zxxXKh4xLDmMMYBFO9Fty+3ZxHdJwb/BlbFbcU
+ecvLVzCMNaNYpYprQAEdf77SJ76MQ==
=MQ8P
-----END PGP SIGNATURE-----

--azHSYEAzgbpgRn8u--


--===============7947346586688680365==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============7947346586688680365==--

