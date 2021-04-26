Return-Path: <SRS0=15y9=JX=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_RED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1792CC433ED
	for <virtualization@archiver.kernel.org>; Mon, 26 Apr 2021 16:07:28 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D3D161139
	for <virtualization@archiver.kernel.org>; Mon, 26 Apr 2021 16:07:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D3D161139
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id ED7384034C;
	Mon, 26 Apr 2021 16:07:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id aeP1qwqAlsfe; Mon, 26 Apr 2021 16:07:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id 396BC403A9;
	Mon, 26 Apr 2021 16:07:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 131C0C000F;
	Mon, 26 Apr 2021 16:07:25 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 11EA4C000B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Apr 2021 16:07:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id F21A2403A9
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Apr 2021 16:07:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8YtC4-tmhNhk
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Apr 2021 16:07:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9B5D04034C
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Apr 2021 16:07:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1619453241;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=w8ARcdpqOgfCuIUeSk+PamPbLk+Y8nRnfPwYAExLG7E=;
 b=bFaN9a/d9WU9kqeb6tCaypCXHdTcob8yoswKHWD1lagBiI9/93iLbq6bcj+gIJNFkKA7Of
 npaF9t2piA4XvqcdW8kMLzddgVOVZtdmJ/mrMIoW/tgUUavnICoFsxBlDFqYIPs6ON2tXk
 zVW1Eai+XTKwYJg5lteo6EZwjcL8Zl0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-202-xkVx03zuMRKQZhm_iMY8mw-1; Mon, 26 Apr 2021 12:07:17 -0400
X-MC-Unique: xkVx03zuMRKQZhm_iMY8mw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5A0B479EDB;
 Mon, 26 Apr 2021 16:07:15 +0000 (UTC)
Received: from localhost (ovpn-114-158.ams2.redhat.com [10.36.114.158])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 788E25F9C5;
 Mon, 26 Apr 2021 16:07:14 +0000 (UTC)
Date: Mon, 26 Apr 2021 17:07:12 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: "Cong Wang ." <cong.wang@bytedance.com>
Subject: Re: [RFC PATCH] virtio-vsock: add description for datagram type
Message-ID: <YIblMHI+NplPHIDx@stefanha-x1.localdomain>
References: <20210316215644.2254177-1-jiang.wang@bytedance.com>
 <YFIj+FQQzZmVAqWw@stefanha-x1.localdomain>
 <CAA68J_bQHzFXnsLpCqZ3waPW1NGz+hnu2OXfAG4XOLemLOX9DQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAA68J_bQHzFXnsLpCqZ3waPW1NGz+hnu2OXfAG4XOLemLOX9DQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
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
Content-Type: multipart/mixed; boundary="===============1002675110810829981=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

--===============1002675110810829981==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="huzhqS+G+JMi+zPD"
Content-Disposition: inline

--huzhqS+G+JMi+zPD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 14, 2021 at 05:43:52PM -0700, Cong Wang . wrote:
> On Wed, Mar 17, 2021 at 8:45 AM Stefan Hajnoczi <stefanha@redhat.com> wro=
te:
> >
> > Please stick to UDP semantics as much as possible so that applications
> > can be ported easily and developers aren't surprised by unexpected
> > behavior. UDP packets sent to a destination that has no listen socket
> > result in a Connection Refused error. vsock dgrams should behave in the
> > same way.
>=20
> There is no connection refused error for UDP, as it is clearly connection=
less.
> What you suggested might be an ICMP unreachable error, however, vsock doe=
s
> not have anything equivalent. So, I think there is no error returned
> in this scenario
> for vsock datagram.

Yes, exactly. UDP uses ICMP unreachable:

  16:55:40.380292 IP 127.0.0.1.41519 > 127.0.0.1.1234: UDP, length 5
  16:55:40.380308 IP 127.0.0.1 > 127.0.0.1: ICMP 127.0.0.1 udp port 1234 un=
reachable, length 41

This is mentioned a bit here:
https://tools.ietf.org/html/rfc8085#section-5.2

Here is how Python's socket module produces an ConnectionRefused
exception:

  socket(AF_INET, SOCK_DGRAM|SOCK_CLOEXEC, IPPROTO_IP) =3D 3
  sendto(3, "hello", 5, 0, {sa_family=3DAF_INET, sin_port=3Dhtons(1234), si=
n_addr=3Dinet_addr("127.0.0.1")}, 16) =3D 5
  getsockname(3, {sa_family=3DAF_INET, sin_port=3Dhtons(41519), sin_addr=3D=
inet_addr("0.0.0.0")}, [16]) =3D 0
  getpeername(3, 0x7ffc43c99a20, [16])    =3D -1 ENOTCONN (Transport endpoi=
nt is not connected)

UDP itself may not carry this information but applications do rely on
the ICMP information as shown above.

The Linux network stack implementation is here:
net/ipv4/udp.c:__udp4_lib_err().

Please take a look and decide how vsock dgrams can have similar
semantics.

Stefan

--huzhqS+G+JMi+zPD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmCG5TAACgkQnKSrs4Gr
c8iXzggAovmsIWfllKGC1aPAIr2syH1XK3A1IS5MMLpOYQEl904lk02cj1K1Zrbp
Ns3+gx6SFeHOWtLRf05HHnNdXyAxhgCiKosEFV4CjoexZRU/SBUl6XCSdZmJ/lq/
bhyen+lzvl544Lj6IeQmIOR5xCU4DbN6tE6rQLnRxp4GMBgxo4cA1I6sDKx3KiRA
YrV154I6tnuH7eBEd1GmG8Cm6i//2WKaBdDXJJPWV+70Ju7LTNxQX6g8/UHYa8TT
okqA7q0IeNH1IgtCxRMMXkxqJFn9RrQR2gfU0cVwDTj0wsR/CCvMeeerv98HRtfx
7FYHVV9ZlrauF2xM0m5aDdja98Bpjw==
=EFLX
-----END PGP SIGNATURE-----

--huzhqS+G+JMi+zPD--


--===============1002675110810829981==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============1002675110810829981==--

