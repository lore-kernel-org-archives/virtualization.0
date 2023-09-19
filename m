Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F5C8CD5BD4
	for <virtualization@archiver.kernel.org>; Tue, 19 Sep 2023 15:10:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 19EF6416C9;
	Tue, 19 Sep 2023 15:10:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 19EF6416C9
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=AQgZlAMM
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id I1vEnDqQGaDC; Tue, 19 Sep 2023 15:10:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 0712D40A8A;
	Tue, 19 Sep 2023 15:10:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0712D40A8A
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BB72DC0039;
	Tue, 19 Sep 2023 15:10:50 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C98A6C0032
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Sep 2023 15:10:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A44D781FC7
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Sep 2023 15:10:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A44D781FC7
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=AQgZlAMM
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EOzOvAZbKxTI
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Sep 2023 15:10:47 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 171FB81FC6
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Sep 2023 15:10:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 171FB81FC6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695136246;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ImvHcdkEyLGgc6MkXTIJ2A0O11w8XotKVo+5WvxB1jQ=;
 b=AQgZlAMMh8PXVRI3PyAfbmoZrAnFqLjiCzAkPbIeLcjs+GPn4nPV3Tky/auNhE9eSZVXSQ
 O0FgWkxkKxuLSbEbwc3VVby37O5d2uY3bHb/XaCV0lFaDeu8V+dt2Hz00LZ3U8/FS8X4Yt
 dFmDOIHzrcAK748Q8/seZjOBjphzNys=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-630-eL6uKDOqMhqVILVX9WDaSA-1; Tue, 19 Sep 2023 11:10:43 -0400
X-MC-Unique: eL6uKDOqMhqVILVX9WDaSA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 51B693C0BE26;
 Tue, 19 Sep 2023 15:10:43 +0000 (UTC)
Received: from localhost (unknown [10.39.192.87])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C93F1492C37;
 Tue, 19 Sep 2023 15:10:42 +0000 (UTC)
Date: Tue, 19 Sep 2023 11:10:41 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [virtio-comment] Re: virtio-sound linux driver conformance to spec
Message-ID: <20230919151041.GA1515067@fedora>
References: <ZQHPeD0fds9sYzHO@pc-79.home>
 <ed568bcf-0fc0-40f5-9cb3-14c2923f8bf7@opensynergy.com>
 <64adaae1-28a6-b175-9fb0-f4f2c26e696e@redhat.com>
MIME-Version: 1.0
In-Reply-To: <64adaae1-28a6-b175-9fb0-f4f2c26e696e@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Cc: mst@redhat.com, virtualization@lists.linux-foundation.org,
 virtio-comment@lists.oasis-open.org
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
Content-Type: multipart/mixed; boundary="===============2358804345935593205=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>


--===============2358804345935593205==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="MPRpPlfC6SRswXQp"
Content-Disposition: inline


--MPRpPlfC6SRswXQp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 19, 2023 at 08:58:32AM +0200, Paolo Bonzini wrote:
> On 9/19/23 02:35, Anton Yakovlev wrote:
> >=20
> > If the Linux virtio sound driver violates a specification, then there
> > must be
> > a conformance statement that the driver does not follow. As far as I kn=
ow,
> > there is no such thing at the moment.
>=20
> There is one in 2.7.13.3: "The device MAY access the descriptor chains the
> driver created and the memory they refer to immediately"
>=20
> And likewise for packed virtqueues in 2.8.21.1: "The device MAY access the
> descriptor and any following descriptors the driver created and the memory
> they refer to immediately"
>=20
> I think it's a mistake to use MAY here, as opposed to "may".  This is not=
 an
> optional feature, it's a MUST NOT requirement on the driver's part that
> should be in 2.7.13.3.1 and 2.8.21.1.1.
>=20
> This does not prevent the virtio-snd spec from overriding this.  If an
> override is desirable (for example because other hardware behaves like
> this), there should be a provision in 2.7.13.3.1 and 2.8.21.1.1.  For
> example:
>=20
> 2.7.13.3.1 Unless the device specification specifies otherwise, the driver
> MUST NOT write to the descriptor chains and the memory they refer to,
> between the /idx/ update and the time the device places the driver on the
> used ring.
>=20
> 2.8.21.1.1 "Unless the device specification specifies otherwise, the driv=
er
> MUST NOT write to the descriptor, to any following descriptors the driver
> created, nor to the memory the refer to, between the /flags/ update and t=
he
> time the device places the driver on the used ring.
>=20
>=20
> In the virtio-snd there would be a normative statement like
>=20
> 5.14.6.8.1.1  The device MUST NOT read from available device-readable
> buffers beyond the first buffer_bytes / period_bytes periods.
>=20
> 5.14.6.8.1.2  The driver MAY write to device-readable buffers beyond the
> first buffer_bytes / period_bytes periods, even after offering them to the
> device.
>=20
>=20
>=20
> As an aside, here are two other statements that have a similar issue:
>=20
> - 2.6.1.1.2 "the driver MAY release any resource associated with that
> virtqueue" (instead 2.6.1.1.1 should have something like "After a queue h=
as
> been reset by the driver, the device MUST NOT access any resource associa=
ted
> with a virtqueue").
>=20
> - 2.7.5.1 "[the device] MAY do so for debugging or diagnostic purposes"
> (this is not normative and can be just "may")

The spec should not make an exception for virtio-sound because the
virtqueue model was not intended as a shared memory mechanism. Allowing
it would prevent message-passing implementations of virtqueues.

Instead the device should use Shared Memory Regions:
https://docs.oasis-open.org/virtio/virtio/v1.2/csd01/virtio-v1.2-csd01.html=
#x1-10200010

BTW, the virtio-sound spec already has VIRTIO_SND_PCM_F_SHMEM_HOST and
VIRTIO_SND_PCM_F_SHMEM_GUEST bits reserved but they currently have no
meaning. I wonder what that was intended for?

Stefan

--MPRpPlfC6SRswXQp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmUJufAACgkQnKSrs4Gr
c8gClwf/cCH9P+sVA2HWuhoxsfx2HZaANGkyqRoWh74H+sbex0Ii7uwIF0TCqEZ1
Jl9FthEFC5vBq0qPcfdeZ3A0Ve8KGyNoSQ/p3blZxqffD9eVvWQ9yZ9/yKSzz1IH
u9dBCBZKlYYCSSElvMKwwnX+Pr85bvz41yxOaGHIjLsNnn33X4u0UhNlhMOAgm+T
yiAF0rrl6yix2V1C1vorge907kDGynM9VxOD6OyNdL4Vc5lr1TQKJF6hoas4Ansl
NLqjOPdelzAv6vX2MzSDeVIuo8iTmFF5XpvCv5XI19Kf1x8glNN9ElyJZi2/3Lf7
tfSM8JK/qyzk59Y2/MR/PUisektIug==
=7g9W
-----END PGP SIGNATURE-----

--MPRpPlfC6SRswXQp--


--===============2358804345935593205==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============2358804345935593205==--

