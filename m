Return-Path: <SRS0=RKVt=P5=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9949FC433EF
	for <virtualization@archiver.kernel.org>; Wed, 10 Nov 2021 09:34:49 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 446EA61077
	for <virtualization@archiver.kernel.org>; Wed, 10 Nov 2021 09:34:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 446EA61077
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 09998403FA;
	Wed, 10 Nov 2021 09:34:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mQnwxQWP3Xm1; Wed, 10 Nov 2021 09:34:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 9772A403FE;
	Wed, 10 Nov 2021 09:34:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6B401C0019;
	Wed, 10 Nov 2021 09:34:47 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F2569C000E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Nov 2021 09:34:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id DBAC1403FE
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Nov 2021 09:34:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SpBci4jvpVPl
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Nov 2021 09:34:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id BF6E9403FA
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Nov 2021 09:34:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1636536884;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LxMV4iFPRrUOhxosXQa0hRM/ty1+W5Q/Tq2s1HhpRhc=;
 b=PSklBW93+xTypo00/c7uqJQZWky5enhQuOpAP4CrXC4D3+iIThdVMKRgyLr1lndSbhZBqc
 BczTacuzhM59OfLIJJrF3G00EHgIiCHYFNy0inqgm1A6b3DxhU2H8R8+twKwesIJdVK/kW
 56Z0EVdo9zb/+Wk5fI2Bd7lHpS/3umY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-84-6K9XdtpxPVKtVRrmf2mo3w-1; Wed, 10 Nov 2021 04:34:39 -0500
X-MC-Unique: 6K9XdtpxPVKtVRrmf2mo3w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A2E2419253C2;
 Wed, 10 Nov 2021 09:34:37 +0000 (UTC)
Received: from localhost (unknown [10.39.193.165])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6EA6960843;
 Wed, 10 Nov 2021 09:34:33 +0000 (UTC)
Date: Wed, 10 Nov 2021 09:34:32 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: "Wang, Wei W" <wei.w.wang@intel.com>
Subject: Re: [RFC] hypercall-vsock: add a new vsock transport
Message-ID: <YYuSKEqj3UMLNAfw@stefanha-x1.localdomain>
References: <71d7b0463629471e9d4887d7fcef1d8d@intel.com>
MIME-Version: 1.0
In-Reply-To: <71d7b0463629471e9d4887d7fcef1d8d@intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Cc: "Yamahata, Isaku" <isaku.yamahata@intel.com>,
 Andra Paraschiv <andraprs@amazon.com>, "mst@redhat.com" <mst@redhat.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Kleen, Andi" <andi.kleen@intel.com>,
 "kuba@kernel.org" <kuba@kernel.org>,
 "davem@davemloft.net" <davem@davemloft.net>
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
Content-Type: multipart/mixed; boundary="===============2604682149232354907=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>


--===============2604682149232354907==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="6kCy5STPFCJ1ef5p"
Content-Disposition: inline


--6kCy5STPFCJ1ef5p
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 10, 2021 at 07:12:36AM +0000, Wang, Wei W wrote:
> We plan to add a new vsock transport based on hypercall (e.g. vmcall on I=
ntel CPUs).
> It transports AF_VSOCK packets between the guest and host, which is simil=
ar to
> virtio-vsock, vmci-vsock and hyperv-vsock.
>=20
> Compared to the above listed vsock transports which are designed for high=
 performance,
> the main advantages of hypercall-vsock are:
>=20
> 1)       It is VMM agnostic. For example, one guest working on hypercall-=
vsock can run on
>=20
> either KVM, Hyperv, or VMware.
>=20
> 2)       It is simpler. It doesn't rely on any complex bus enumeration
>=20
> (e.g. virtio-pci based vsock device may need the whole implementation of =
PCI).
>=20
> An example usage is the communication between MigTD and host (Page 8 at
> https://static.sched.com/hosted_files/kvmforum2021/ef/TDX%20Live%20Migrat=
ion_Wei%20Wang.pdf).
> MigTD communicates to host to assist the migration of the target (user) T=
D.
> MigTD is part of the TCB, so its implementation is expected to be as simp=
le as possible
> (e.g. bare mental implementation without OS, no PCI driver support).

AF_VSOCK is designed to allow multiple transports, so why not. There is
a cost to developing and maintaining a vsock transport though.

I think Amazon Nitro enclaves use virtio-vsock and I've CCed Andra in
case she has thoughts on the pros/cons and how to minimize the trusted
computing base.

If simplicity is the top priority then VIRTIO's MMIO transport without
indirect descriptors and using the packed virtqueue layout reduces the
size of the implementation:
https://docs.oasis-open.org/virtio/virtio/v1.1/cs01/virtio-v1.1-cs01.html#x=
1-1440002

Stefan

--6kCy5STPFCJ1ef5p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmGLkigACgkQnKSrs4Gr
c8iPyAf8COmUtjvTHk5gX6zSZeAiKXrfyy3bnkP9NrNwxXTHGg7f6dECVUz9Gg73
+YqbL+Li11VWyTGCltsAWVkcVmmeuW+vdAUhuxBRRoWw8VCoLKbMUif/rJV48Ms8
KQN5ZEoGSMVFpNj6P7V6qlPMC8MRGLfeqouNZpbL5z/gTfef+vQvKGjR7NF3CegG
CtVR2NXN+sE+bOPHB9VY11YzBlSLNcuivqb4k288LkTqemVcMQloN2w6bYkzaUP5
IwdGx3PP13yFkDDKYv4PnJ3VJPDYVrL0Y1mxNAlFhtQ2bBnk8l3DapR/Z906kVYb
bG7G+2Sb/uf0m34bQgrAokLNk8nWGA==
=bN/Z
-----END PGP SIGNATURE-----

--6kCy5STPFCJ1ef5p--


--===============2604682149232354907==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============2604682149232354907==--

