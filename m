Return-Path: <SRS0=wWNv=I3=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C254C433DB
	for <virtualization@archiver.kernel.org>; Mon, 29 Mar 2021 09:26:10 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C15476193C
	for <virtualization@archiver.kernel.org>; Mon, 29 Mar 2021 09:26:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C15476193C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 6737F400EC;
	Mon, 29 Mar 2021 09:26:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UsT6IjyMcd9r; Mon, 29 Mar 2021 09:26:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id 0D7A4400CF;
	Mon, 29 Mar 2021 09:26:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D0D97C000C;
	Mon, 29 Mar 2021 09:26:07 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 11D06C000A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 29 Mar 2021 09:26:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E5DB0400E4
 for <virtualization@lists.linux-foundation.org>;
 Mon, 29 Mar 2021 09:26:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id k2UkfZSMK1Zi
 for <virtualization@lists.linux-foundation.org>;
 Mon, 29 Mar 2021 09:26:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 974E9400CF
 for <virtualization@lists.linux-foundation.org>;
 Mon, 29 Mar 2021 09:26:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1617009963;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=H5sJNIq0MDK1/UelBfkNeW9WSpFlHCW6Ux5U+kVqnjM=;
 b=g8tmDW86LDZAE5Q/kKhj7NSi4OWTlf8KBSk0rP9V40Kez3A7T2bWTbNSsyZQ10RAKJT8ta
 fEbiyqu+Ji3AODWNP2cSq6B5yOgFli0wOxI9fcVC36WkKp9PFdmCqVIYXV4+DTqshj+e0i
 lWj8q4vCDdemLSArXTK0eSLalTes7jE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-76-UdZnzdzvOJWdL4k_4ddbKQ-1; Mon, 29 Mar 2021 05:25:58 -0400
X-MC-Unique: UdZnzdzvOJWdL4k_4ddbKQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B57C2107B7C4;
 Mon, 29 Mar 2021 09:25:57 +0000 (UTC)
Received: from localhost (ovpn-114-227.ams2.redhat.com [10.36.114.227])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D89806F974;
 Mon, 29 Mar 2021 09:25:50 +0000 (UTC)
Date: Mon, 29 Mar 2021 10:25:49 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: "Jiang Wang ." <jiang.wang@bytedance.com>
Subject: Re: [External] Re: [RFC PATCH] virtio-vsock: add description for
 datagram type
Message-ID: <YGGdHfgJF45GRp5n@stefanha-x1.localdomain>
References: <20210316215644.2254177-1-jiang.wang@bytedance.com>
 <YFIj+FQQzZmVAqWw@stefanha-x1.localdomain>
 <CAP_N_Z857fnkc4GejHt_t_nxnhXC60=S51i_XQ-AdgXO2NipFA@mail.gmail.com>
 <YFjK7MkmJOFaUvgz@stefanha-x1.localdomain>
 <CAP_N_Z-aOds0-DgSYgGLb3AG7kvf=iqmLHojMjh878j8bTBkwg@mail.gmail.com>
 <20210322190517-mutt-send-email-mst@kernel.org>
 <CAP_N_Z_g1jgQE71WLPA45w72WJ8+1WFaP3zzXH8FRpFap=jqCA@mail.gmail.com>
 <YFmsb6o82KOSml9u@stefanha-x1.localdomain>
 <CAP_N_Z9g3VUeLGtC0D0EGmHk7D1RxFQvUBMzLDMkct5b=t6x3A@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAP_N_Z9g3VUeLGtC0D0EGmHk7D1RxFQvUBMzLDMkct5b=t6x3A@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
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
Content-Type: multipart/mixed; boundary="===============2822097794208759259=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

--===============2822097794208759259==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="f0w1cxGTkn6ekn/D"
Content-Disposition: inline

--f0w1cxGTkn6ekn/D
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 26, 2021 at 04:40:09PM -0700, Jiang Wang . wrote:
> I thought about this and discussed it with my colleague Cong Wang.
> One idea is to make current asynchronous send_pkt flow to be synchronous,
> then if the virtqueue is full, the function can return  ENOMEM all the wa=
y back
> to the caller and the caller can check the return value of sendmsg
> and slow down when necessary.
>=20
> In the spec, we can put something like, if the virtqueue is full, the cal=
ler
> should be notified with an error etc.
>=20
> In terms of implementation, that means we will remove the current
> send_pkt_work for both stream and dgram sockets. Currently, the
> code path uses RCU and a work queue, then grab a mutex in the
> work queue function. Since we cannot grab mutex when in rcu
> critical section, we have to change RCU to a normal reference
> counting mechanism. I think this is doable. The drawback is
> that the reference counting in general spends a little more
> cycles than the RCU, so there is a small price to pay. Another
> option is to use Sleepable RCU and remove the work queue.
>=20
> What do you guys think?

I think the tx code path is like this because of reliable delivery.
Maybe a separate datagram rx/tx code path would be simpler?

Take the datagram tx virtqueue lock, try to add the packet into the
virtqueue, and return -ENOBUFS if the virtqueue is full. Then use the
datagram socket's sndbuf accounting to prevent queuing up too many
packets. When a datagram tx virtqueue buffer is used by the device,
select queued packets for transmission. Unlike the stream tx/rx code
path there is no dependency between tx and rx because we don't have the
credit mechanism.

> btw, I will also add some SENDBUF restrictions for the dgram
> sockets, but I don't think it needs to be in the spec.

Yes, the spec doesn't need to explain implementation-specific issues.

If there are common implementation issues then the spec can explain them
in general terms (not referring to Linux internals) to help
implementors.

Stefan

--f0w1cxGTkn6ekn/D
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmBhnRsACgkQnKSrs4Gr
c8jRzggAjZuKAG5bNe1YLnjbuuKNwX/k8yT45a6+CCXzYGD7jHfP04mEvtNaUDdZ
YglNpgT1tiGnLC+EOSTan3JVo/PGUzwrnf5ivs0XKUxYfF5mr5kMgL3mJhD5NWIu
//gVVcqY9eRJxZngFAiUWjxq1C+ASKfARB/tRC6VXQeZALPTcmSWWdDWDO3UZJ8I
fNgOJq7PxovdBVfOryDpNk3RC6tt7AI1HFu+rCsy7tUro1maFWzfvZLKQD0BYo8g
Xmb1HlfZXu9Lqiys6e7xNGNaSDY5SnEs+gd177bN6pdcuplfHsVwLQhC9Jg/BtOL
44znSZFHWMDYqvE7wweVBGMAwMoETg==
=u8Uz
-----END PGP SIGNATURE-----

--f0w1cxGTkn6ekn/D--


--===============2822097794208759259==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============2822097794208759259==--

