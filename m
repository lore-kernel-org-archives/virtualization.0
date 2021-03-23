Return-Path: <SRS0=L1Zq=IV=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_RED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58A7BC433DB
	for <virtualization@archiver.kernel.org>; Tue, 23 Mar 2021 08:53:22 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4038619BD
	for <virtualization@archiver.kernel.org>; Tue, 23 Mar 2021 08:53:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4038619BD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 599BB40373;
	Tue, 23 Mar 2021 08:53:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Sldcgcpdywhr; Tue, 23 Mar 2021 08:53:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id EE6C9400BF;
	Tue, 23 Mar 2021 08:53:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D2850C000B;
	Tue, 23 Mar 2021 08:53:19 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 424D8C0001
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Mar 2021 08:53:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2302F83E40
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Mar 2021 08:53:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LQMEaoMT3FZJ
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Mar 2021 08:53:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7B2E483DB5
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Mar 2021 08:53:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1616489597;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rJ6T33O8TvdbDh1NnfwpgW4awfLs4IOQbnDHgdjCAzo=;
 b=cSBXNQAIPWl+5bG2OgfZwThuC1AWAo2xnCSqVpvzeoxXyrALDqANwimJ1Lped2p8q7BYWk
 rI+0F/33fVrM2ODbt2vetKlWJhOlGSldVcjlhjIN9R/iUk+qqW2KNEp5GIguHylFD9PLR8
 fD445sjPN45RbsAmskehg2euRGmmlio=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-405-T5P3Wzz3PTaVN-R_VnOKBA-1; Tue, 23 Mar 2021 04:53:13 -0400
X-MC-Unique: T5P3Wzz3PTaVN-R_VnOKBA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A51388189C8;
 Tue, 23 Mar 2021 08:53:11 +0000 (UTC)
Received: from localhost (ovpn-114-89.ams2.redhat.com [10.36.114.89])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DACF821EC5;
 Tue, 23 Mar 2021 08:53:04 +0000 (UTC)
Date: Tue, 23 Mar 2021 08:53:03 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: "Jiang Wang ." <jiang.wang@bytedance.com>
Subject: Re: [External] Re: [RFC PATCH] virtio-vsock: add description for
 datagram type
Message-ID: <YFmsb6o82KOSml9u@stefanha-x1.localdomain>
References: <20210316215644.2254177-1-jiang.wang@bytedance.com>
 <YFIj+FQQzZmVAqWw@stefanha-x1.localdomain>
 <CAP_N_Z857fnkc4GejHt_t_nxnhXC60=S51i_XQ-AdgXO2NipFA@mail.gmail.com>
 <YFjK7MkmJOFaUvgz@stefanha-x1.localdomain>
 <CAP_N_Z-aOds0-DgSYgGLb3AG7kvf=iqmLHojMjh878j8bTBkwg@mail.gmail.com>
 <20210322190517-mutt-send-email-mst@kernel.org>
 <CAP_N_Z_g1jgQE71WLPA45w72WJ8+1WFaP3zzXH8FRpFap=jqCA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAP_N_Z_g1jgQE71WLPA45w72WJ8+1WFaP3zzXH8FRpFap=jqCA@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
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
Content-Type: multipart/mixed; boundary="===============9102685814121889867=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

--===============9102685814121889867==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="AmMEsqlmBmRPrReF"
Content-Disposition: inline

--AmMEsqlmBmRPrReF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 22, 2021 at 07:23:14PM -0700, Jiang Wang . wrote:
> Got it. Will do.

You could look at udp_sendmsg() to see how sockets compete when
transmitting to the same net device.

I'm not very familiar with this but I guess that the qdisc (like
fq_codel) decides which packets to place into the device's tx queue. I
guess sk_buffs waiting to be put onto the device's tx queue are
accounted for against the socket's sndbuf. Further sendmsg calls will
fail with -ENOBUFS when the sndbuf limit is reached.

It's not clear to me how much of the existing code can be reused since
vsock does not use sk_buff or netdev :(.

Stefan

--AmMEsqlmBmRPrReF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmBZrG8ACgkQnKSrs4Gr
c8ghywgAsafd2FeFpyEZhm4rjHm6GZZHGgHVDJZC4q02Hr4XHQBOWAD2yKbPny0f
ZWwqGptLCBekRqRa++4SZgH7lPweL8ycPO4PSDHXI/tgOEu7JOaUzrCphbS55ZDf
fcOI6qO6YLFa81ZeMWafqKqvJXFt/ZiD9WiBG8987cqTn8BDhuQ+oPhIyBX9tycD
XFkAU2ecMizcvMGYr2L+4mUl4ec7YR4In0PFaCZDYGDNWL0L6cKe9CWRzEgxM7DW
3wtUEaUwOebzqK8NgInpwxzYeBhiCuQ68h3Hiw25IsOMqsXS77lDkVItX0TcCRiU
U4KM2p+RtDBFTVmuGVaFvlFsQWx/2Q==
=Qn4N
-----END PGP SIGNATURE-----

--AmMEsqlmBmRPrReF--


--===============9102685814121889867==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============9102685814121889867==--

