Return-Path: <SRS0=AynT=JM=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3734FC433B4
	for <virtualization@archiver.kernel.org>; Thu, 15 Apr 2021 14:18:08 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD27B6113D
	for <virtualization@archiver.kernel.org>; Thu, 15 Apr 2021 14:18:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD27B6113D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id A67DF40129;
	Thu, 15 Apr 2021 14:18:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id b11B-YTGZMww; Thu, 15 Apr 2021 14:18:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id 60F344021C;
	Thu, 15 Apr 2021 14:18:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2E119C000C;
	Thu, 15 Apr 2021 14:18:06 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7B966C000A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Apr 2021 14:18:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 661C084719
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Apr 2021 14:18:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CdknReooU1zU
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Apr 2021 14:18:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E5FD78473D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Apr 2021 14:17:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1618496278;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IOewNMfPKKreZaktQJpTbBLLtYdk3yANsE5YR8AZsrE=;
 b=KXSgGbCegOEB8+S8PQg6Q9BiIdiDhoxkQATj9FDdYGC3QeFRsarGybnicop9QwVNifkk1O
 qjBtGh1+1W+3XrAvyITku+Kh+fbKvEqSGsGn95917QJaDF7meAB/7IW8iuwUTX3T0bfUu2
 QCicWAMMr7VT3rA/6kd43yWqpoVdo6Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-130-zPBktbWMNaCxZdXJ3ywBsA-1; Thu, 15 Apr 2021 10:17:55 -0400
X-MC-Unique: zPBktbWMNaCxZdXJ3ywBsA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5981D801814;
 Thu, 15 Apr 2021 14:17:52 +0000 (UTC)
Received: from localhost (ovpn-114-209.ams2.redhat.com [10.36.114.209])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4D7495D723;
 Thu, 15 Apr 2021 14:17:47 +0000 (UTC)
Date: Thu, 15 Apr 2021 15:17:47 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Yongji Xie <xieyongji@bytedance.com>
Subject: Re: Re: Re: [PATCH v6 10/10] Documentation: Add documentation for
 VDUSE
Message-ID: <YHhLCyF/2VYzrL3g@stefanha-x1.localdomain>
References: <20210331080519.172-1-xieyongji@bytedance.com>
 <20210331080519.172-11-xieyongji@bytedance.com>
 <YHb44R4HyLEUVSTF@stefanha-x1.localdomain>
 <CACycT3uNR+nZY5gY0UhPkeOyi7Za6XkX4b=hasuDcgqdc7fqfg@mail.gmail.com>
 <YHfo8pc7dIO9lNc3@stefanha-x1.localdomain>
 <CACycT3tRN1n_PJm1mu3=s1dK941Pac15cpaysqZZKLR6xKaXSg@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACycT3tRN1n_PJm1mu3=s1dK941Pac15cpaysqZZKLR6xKaXSg@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Cc: Jens Axboe <axboe@kernel.dk>, Jonathan Corbet <corbet@lwn.net>,
 kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 netdev@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
 Matthew Wilcox <willy@infradead.org>,
 virtualization@lists.linux-foundation.org,
 Christoph Hellwig <hch@infradead.org>,
 Christian Brauner <christian.brauner@canonical.com>, bcrl@kvack.org,
 viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
 Dan Carpenter <dan.carpenter@oracle.com>,
 Mika =?iso-8859-1?Q?Penttil=E4?= <mika.penttila@nextfour.com>
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
Content-Type: multipart/mixed; boundary="===============3882930713040546328=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>


--===============3882930713040546328==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="MPbHG8vrrTTLxD+q"
Content-Disposition: inline


--MPbHG8vrrTTLxD+q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 15, 2021 at 04:33:27PM +0800, Yongji Xie wrote:
> On Thu, Apr 15, 2021 at 3:19 PM Stefan Hajnoczi <stefanha@redhat.com> wro=
te:
> > On Thu, Apr 15, 2021 at 01:38:37PM +0800, Yongji Xie wrote:
> > > On Wed, Apr 14, 2021 at 10:15 PM Stefan Hajnoczi <stefanha@redhat.com=
> wrote:
> > > > On Wed, Mar 31, 2021 at 04:05:19PM +0800, Xie Yongji wrote:
> > It's not obvious to me that there is a fundamental difference between
> > the two approaches in terms of performance.
> >
> > > On the other
> > > hand, we can handle the virtqueue in a unified way for both vhost-vdpa
> > > case and virtio-vdpa case. Otherwise, userspace daemon needs to know
> > > which iova ranges need to be accessed with pread(2)/pwrite(2). And in
> > > the future, we might be able to avoid bouncing in some cases.
> >
> > Ah, I see. So bounce buffers are not used for vhost-vdpa?
> >
>=20
> Yes.

Okay, in that case I understand why mmap is used and it's nice to keep
virtio-vpda and vhost-vdpa unified. Thanks!

Stefan

--MPbHG8vrrTTLxD+q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmB4SwsACgkQnKSrs4Gr
c8iNcgf/SlAcQNeAhYZD3E8EAxA7kj75HWb2bs314xQK1UuM8yPecd9e468z8oN6
e0lS0+RDTiPjrV+Nlpgs6+xVqLAjatBXGWiauZeed+q6kMlAlt9OiZApRG3/AACc
spwkoFaL9mPKBS5lAaGAEiJqd3ZjA1EpKbXq8klSFDVYLXkfD8qyxxsAUlREsH6t
s0yoJqiZlLqcDPcfPw4aCEOZteP3MNSinotRCHDDQ6X0cDpcqCyInpClclxd507Z
fxz/hu7w1vEbPIGcp6O5VsaUolPr74X0HS4lkDRN32vh8OkDnGsoDiNQg0sduQ5u
FV/ND4nsUIUTsXxlBnLOcX2Cj1V4/w==
=wUKZ
-----END PGP SIGNATURE-----

--MPbHG8vrrTTLxD+q--


--===============3882930713040546328==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============3882930713040546328==--

