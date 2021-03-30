Return-Path: <SRS0=i4sF=I4=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3326AC433DB
	for <virtualization@archiver.kernel.org>; Tue, 30 Mar 2021 10:42:25 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC48761985
	for <virtualization@archiver.kernel.org>; Tue, 30 Mar 2021 10:42:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC48761985
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2CD914044E;
	Tue, 30 Mar 2021 10:42:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3ZQtqiN-n6nX; Tue, 30 Mar 2021 10:42:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id 828C1403FE;
	Tue, 30 Mar 2021 10:42:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3C2CDC000B;
	Tue, 30 Mar 2021 10:42:22 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7E4B8C000A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 30 Mar 2021 10:42:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 56FB840407
 for <virtualization@lists.linux-foundation.org>;
 Tue, 30 Mar 2021 10:42:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PFe3CqXPk3Hg
 for <virtualization@lists.linux-foundation.org>;
 Tue, 30 Mar 2021 10:42:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id DB328403FE
 for <virtualization@lists.linux-foundation.org>;
 Tue, 30 Mar 2021 10:42:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1617100937;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7qUHKZxxwcdtx9Ee60NY93WcyUojSFIx95nak+E50h4=;
 b=aasCR/Fk8klXzt/RnbjKloLIkyr/ydrtD4FJxzOSI4gcdbYDdHaLaZl14nkJmOqe90wmkV
 fu/poM7Hb3AUvBjbJD/nwA3a36vXB2fZQBPjmDzlboAzQk8wVmun5b609gwKSuBhvqyF+M
 eRaheMG1jcEHgbRgfZ58qWRCNCyAJ+k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-327-fUVaMqRwPDm3zOgx3aU5-w-1; Tue, 30 Mar 2021 06:42:14 -0400
X-MC-Unique: fUVaMqRwPDm3zOgx3aU5-w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 698431018F64;
 Tue, 30 Mar 2021 10:42:13 +0000 (UTC)
Received: from localhost (ovpn-115-22.ams2.redhat.com [10.36.115.22])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C7D726E71A;
 Tue, 30 Mar 2021 10:42:05 +0000 (UTC)
Date: Tue, 30 Mar 2021 11:42:04 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: "Jiang Wang ." <jiang.wang@bytedance.com>
Subject: Re: [External] Re: [RFC PATCH] virtio-vsock: add description for
 datagram type
Message-ID: <YGMAfBLzcaCMwLJK@stefanha-x1.localdomain>
References: <YFIj+FQQzZmVAqWw@stefanha-x1.localdomain>
 <CAP_N_Z857fnkc4GejHt_t_nxnhXC60=S51i_XQ-AdgXO2NipFA@mail.gmail.com>
 <YFjK7MkmJOFaUvgz@stefanha-x1.localdomain>
 <CAP_N_Z-aOds0-DgSYgGLb3AG7kvf=iqmLHojMjh878j8bTBkwg@mail.gmail.com>
 <20210322190517-mutt-send-email-mst@kernel.org>
 <CAP_N_Z_g1jgQE71WLPA45w72WJ8+1WFaP3zzXH8FRpFap=jqCA@mail.gmail.com>
 <YFmsb6o82KOSml9u@stefanha-x1.localdomain>
 <CAP_N_Z9g3VUeLGtC0D0EGmHk7D1RxFQvUBMzLDMkct5b=t6x3A@mail.gmail.com>
 <YGGdHfgJF45GRp5n@stefanha-x1.localdomain>
 <CAP_N_Z-v5ZFKO0SNeZre=F6q_+aQohHVQ1fg9oXbfboZgv_xeQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAP_N_Z-v5ZFKO0SNeZre=F6q_+aQohHVQ1fg9oXbfboZgv_xeQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: cong.wang@bytedance.com, Xiongchun Duan <duanxiongchun@bytedance.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, cohuck@redhat.com,
 virtualization@lists.linux-foundation.org, xieyongji@bytedance.com,
 Arseny Krasnov <arseny.krasnov@kaspersky.com>, asias@redhat.com
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
Content-Type: multipart/mixed; boundary="===============7675409214079544138=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

--===============7675409214079544138==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="SwMgZT8kFdZR7EWX"
Content-Disposition: inline

--SwMgZT8kFdZR7EWX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 29, 2021 at 04:22:28PM -0700, Jiang Wang . wrote:
> On Mon, Mar 29, 2021 at 2:26 AM Stefan Hajnoczi <stefanha@redhat.com> wro=
te:
> >
> > On Fri, Mar 26, 2021 at 04:40:09PM -0700, Jiang Wang . wrote:
> > > I thought about this and discussed it with my colleague Cong Wang.
> > > One idea is to make current asynchronous send_pkt flow to be synchron=
ous,
> > > then if the virtqueue is full, the function can return  ENOMEM all th=
e way back
> > > to the caller and the caller can check the return value of sendmsg
> > > and slow down when necessary.
> > >
> > > In the spec, we can put something like, if the virtqueue is full, the=
 caller
> > > should be notified with an error etc.
> > >
> > > In terms of implementation, that means we will remove the current
> > > send_pkt_work for both stream and dgram sockets. Currently, the
> > > code path uses RCU and a work queue, then grab a mutex in the
> > > work queue function. Since we cannot grab mutex when in rcu
> > > critical section, we have to change RCU to a normal reference
> > > counting mechanism. I think this is doable. The drawback is
> > > that the reference counting in general spends a little more
> > > cycles than the RCU, so there is a small price to pay. Another
> > > option is to use Sleepable RCU and remove the work queue.
> > >
> > > What do you guys think?
> >
> > I think the tx code path is like this because of reliable delivery.
> > Maybe a separate datagram rx/tx code path would be simpler?
>=20
> I thought about this too.  dgram can have a separate rx/tx
> path from stream types. In this case, the the_virtio_vsock
> will still be shared because the virtqueues have to be in one
> structure. Then the_virtio_vsock will be protected by a rcu
> and a reference counting ( or a sleepable RCU ).
>=20
> In vhost_vsock_dev_release, it will wait for both rcu and another
> one to be finished and then free the memory. I think this is
> doable. Let me know if there is a better way to do it.
> Btw, I think dgram tx code path will be quite different from
> stream, but dgram rx path will be similar to stream type.
>=20
> > Take the datagram tx virtqueue lock, try to add the packet into the
> > virtqueue, and return -ENOBUFS if the virtqueue is full. Then use the
> > datagram socket's sndbuf accounting to prevent queuing up too many
> > packets. When a datagram tx virtqueue buffer is used by the device,
> > select queued packets for transmission.
>=20
> I am not sure about the last sentence. In the new design, there will
> be no other queued packets for dgram (except those in the virtqueue).
> When dgram tx virtqueue is freed by the device, the driver side
> just needs to free some space. No need
> to trigger more transmission.

This approach drops packets when the virtqueue is full. In order to get
close to UDP semantics I think the following is necessary:

1. Packets are placed directly into the tx virtqueue when possible.
2. Packets are queued up to sndbuf bytes if the tx virtqueue is full.
3. When a full tx virtqueue gets some free space again there is an
   algorithm that selects from among the queued sockets.

This is how unreliably delivery can be somewhat fair between competing
threads. I thought you were trying to achieve this (it's similar to what
UDP does)?

Stefan

--SwMgZT8kFdZR7EWX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmBjAHwACgkQnKSrs4Gr
c8ivDwf/RknuDiG1LAwxbelupXxuAJeg3ivpvazmqitpv+7wvewSfBZlM2B64Ioc
HqDWh0kDLNdkQSovxQFetaVpLNv/V6W//rErkNNydHHcdR7mCvN+tqIHqx/Pso0u
QRtVQRfpaLI1LbsKvU6IYEFVEnva2jUgHC40ME4977D/yoY8Sxyqha4Ne/nW8UJW
59emnihwJOSgCmS7nRFUSBKPCJbCcjQKCWLwwzIfM2T3ZVE1C0lb2asEmwk5r/rv
nEBUbPkGZbQfA3RZKg/YLiQLRUYnAB0/wNRZ0FOKuM636GyzTnHuHPmbIbvVX6Ne
0ijFgNrJT8YiinlVfLSnYHASSKEdYQ==
=11Ed
-----END PGP SIGNATURE-----

--SwMgZT8kFdZR7EWX--


--===============7675409214079544138==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============7675409214079544138==--

