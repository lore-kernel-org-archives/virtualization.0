Return-Path: <SRS0=EgWE=L6=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79B31C07E96
	for <virtualization@archiver.kernel.org>; Tue,  6 Jul 2021 10:22:55 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 311BE619A5
	for <virtualization@archiver.kernel.org>; Tue,  6 Jul 2021 10:22:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 311BE619A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E2F09403E0;
	Tue,  6 Jul 2021 10:22:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rQo9tMM8kmhC; Tue,  6 Jul 2021 10:22:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 0E075403DE;
	Tue,  6 Jul 2021 10:22:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E57F6C001A;
	Tue,  6 Jul 2021 10:22:52 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 97A21C000E
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Jul 2021 10:22:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 79E2B82ACA
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Jul 2021 10:22:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lHvyNUxfcIWv
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Jul 2021 10:22:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9C01C824A8
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Jul 2021 10:22:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1625566969;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dgg93eWae1Wvf2u2bYZ3f3yNqkz9O5G8CdOIvTgPtmk=;
 b=a9MIIbJjmYfDAm0BeVxvtIy4kaYoZ3hqAyiKGr/7se2WsZ260zjRvtjWWarnPWmtKsYpZb
 ekKcOP05MTXarobJk7/eDEadNTLzm6Wsyeq9OHRZdvHNDDyYHqwH+HrOP346w2xtP80CqT
 s6yHLP3eX+UtD9zxPWoqd53tOYd9xgY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-563-3y1_KB2RMHmhRdGAGjoVig-1; Tue, 06 Jul 2021 06:22:47 -0400
X-MC-Unique: 3y1_KB2RMHmhRdGAGjoVig-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E6A8A18D6A2A;
 Tue,  6 Jul 2021 10:22:44 +0000 (UTC)
Received: from localhost (ovpn-115-23.ams2.redhat.com [10.36.115.23])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4F78B5D9DC;
 Tue,  6 Jul 2021 10:22:42 +0000 (UTC)
Date: Tue, 6 Jul 2021 11:22:41 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Yongji Xie <xieyongji@bytedance.com>
Subject: Re: [PATCH v8 10/10] Documentation: Add documentation for VDUSE
Message-ID: <YOQu8dB6tlb9juNz@stefanha-x1.localdomain>
References: <20210615141331.407-11-xieyongji@bytedance.com>
 <YNSCH6l31zwPxBjL@stefanha-x1.localdomain>
 <CACycT3uxnQmXWsgmNVxQtiRhz1UXXTAJFY3OiAJqokbJH6ifMA@mail.gmail.com>
 <YNxCDpM3bO5cPjqi@stefanha-x1.localdomain>
 <CACycT3taKhf1cWp3Jd0aSVekAZvpbR-_fkyPLQ=B+jZBB5H=8Q@mail.gmail.com>
 <YN3ABqCMLQf7ejOm@stefanha-x1.localdomain>
 <CACycT3vo-diHgTSLw_FS2E+5ia5VjihE3qw7JmZR7JT55P-wQA@mail.gmail.com>
 <8320d26d-6637-85c6-8773-49553dfa502d@redhat.com>
 <YOL/9mxkJaokKDHc@stefanha-x1.localdomain>
 <CACycT3t-BTMrpNTwBUfbvaxTh6tLthxbo3OJwMk_iuiSpMuZPg@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACycT3t-BTMrpNTwBUfbvaxTh6tLthxbo3OJwMk_iuiSpMuZPg@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Cc: kvm <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Christian Brauner <christian.brauner@canonical.com>,
 Jonathan Corbet <corbet@lwn.net>, joro@8bytes.org,
 Matthew Wilcox <willy@infradead.org>, Christoph Hellwig <hch@infradead.org>,
 Dan Carpenter <dan.carpenter@oracle.com>, Al Viro <viro@zeniv.linux.org.uk>,
 songmuchun@bytedance.com, Jens Axboe <axboe@kernel.dk>,
 Greg KH <gregkh@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>,
 linux-kernel <linux-kernel@vger.kernel.org>, iommu@lists.linux-foundation.org,
 bcrl@kvack.org, netdev@vger.kernel.org, linux-fsdevel@vger.kernel.org,
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
Content-Type: multipart/mixed; boundary="===============4275428509054968057=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>


--===============4275428509054968057==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Pn5Pfd0OLzKU2Op2"
Content-Disposition: inline


--Pn5Pfd0OLzKU2Op2
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 06, 2021 at 11:04:18AM +0800, Yongji Xie wrote:
> On Mon, Jul 5, 2021 at 8:50 PM Stefan Hajnoczi <stefanha@redhat.com> wrot=
e:
> >
> > On Mon, Jul 05, 2021 at 11:36:15AM +0800, Jason Wang wrote:
> > >
> > > =E5=9C=A8 2021/7/4 =E4=B8=8B=E5=8D=885:49, Yongji Xie =E5=86=99=E9=81=
=93:
> > > > > > OK, I get you now. Since the VIRTIO specification says "Device
> > > > > > configuration space is generally used for rarely-changing or
> > > > > > initialization-time parameters". I assume the VDUSE_DEV_SET_CON=
FIG
> > > > > > ioctl should not be called frequently.
> > > > > The spec uses MUST and other terms to define the precise requirem=
ents.
> > > > > Here the language (especially the word "generally") is weaker and=
 means
> > > > > there may be exceptions.
> > > > >
> > > > > Another type of access that doesn't work with the VDUSE_DEV_SET_C=
ONFIG
> > > > > approach is reads that have side-effects. For example, imagine a =
field
> > > > > containing an error code if the device encounters a problem unrel=
ated to
> > > > > a specific virtqueue request. Reading from this field resets the =
error
> > > > > code to 0, saving the driver an extra configuration space write a=
ccess
> > > > > and possibly race conditions. It isn't possible to implement those
> > > > > semantics suing VDUSE_DEV_SET_CONFIG. It's another corner case, b=
ut it
> > > > > makes me think that the interface does not allow full VIRTIO sema=
ntics.
> > >
> > >
> > > Note that though you're correct, my understanding is that config spac=
e is
> > > not suitable for this kind of error propagating. And it would be very=
 hard
> > > to implement such kind of semantic in some transports.  Virtqueue sho=
uld be
> > > much better. As Yong Ji quoted, the config space is used for
> > > "rarely-changing or intialization-time parameters".
> > >
> > >
> > > > Agreed. I will use VDUSE_DEV_GET_CONFIG in the next version. And to
> > > > handle the message failure, I'm going to add a return value to
> > > > virtio_config_ops.get() and virtio_cread_* API so that the error can
> > > > be propagated to the virtio device driver. Then the virtio-blk devi=
ce
> > > > driver can be modified to handle that.
> > > >
> > > > Jason and Stefan, what do you think of this way?
> >
> > Why does VDUSE_DEV_GET_CONFIG need to support an error return value?
> >
>=20
> We add a timeout and return error in case userspace never replies to
> the message.
>=20
> > The VIRTIO spec provides no way for the device to report errors from
> > config space accesses.
> >
> > The QEMU virtio-pci implementation returns -1 from invalid
> > virtio_config_read*() and silently discards virtio_config_write*()
> > accesses.
> >
> > VDUSE can take the same approach with
> > VDUSE_DEV_GET_CONFIG/VDUSE_DEV_SET_CONFIG.
> >
>=20
> I noticed that virtio_config_read*() only returns -1 when we access a
> invalid field. But in the VDUSE case, VDUSE_DEV_GET_CONFIG might fail
> when we access a valid field. Not sure if it's ok to silently ignore
> this kind of error.

That's a good point but it's a general VIRTIO issue. Any device
implementation (QEMU userspace, hardware vDPA, etc) can fail, so the
VIRTIO specification needs to provide a way for the driver to detect
this.

If userspace violates the contract then VDUSE needs to mark the device
broken. QEMU's device emulation does something similar with the
vdev->broken flag.

The VIRTIO Device Status field DEVICE_NEEDS_RESET bit can be set by
vDPA/VDUSE to indicate that the device is not operational and must be
reset.

The driver code may still process the -1 value read from the
configuration space. Hopefully this isn't a problem. There is currently
no VIRTIO interface besides DEVICE_NEEDS_RESET to indicate configuration
space access failures. On the other hand, drivers need to handle
malicious devices so they should be able to cope with the -1 value
anyway.

Stefan

--Pn5Pfd0OLzKU2Op2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmDkLvEACgkQnKSrs4Gr
c8ixbggAg14mm0zlZMb0rxwzWppmsIJSjV7mHSefxDiIfWBRZcioci9QPSFBFYiR
QfLj7B4ecMS0znXnAllOG2ik7JBoFnYEsiQUyKzzjPtlv9NzdRWbls4mtXpdZxz2
l0vojVgJvpLHJcajROmnDPyRR0NCwFASkLIw0qJaICOK8yVEQt/zyegr0dBTV8M7
TdJUhls34j99hQp21YymI7oq2wbvYEAORzrOmZbGYxU1olf4tONkQEs5ZBrKct4C
fdEC0+kWKj+iQXO0DFCequFabbrt3CfBg03px1bEiMgbo1ejJ3KytSlx+n8QESMJ
wNP4YRO2hAtBl0HSUUF//ns2yKBsAg==
=Vok0
-----END PGP SIGNATURE-----

--Pn5Pfd0OLzKU2Op2--


--===============4275428509054968057==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============4275428509054968057==--

