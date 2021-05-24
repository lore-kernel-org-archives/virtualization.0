Return-Path: <SRS0=LFKT=KT=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02650C04FF3
	for <virtualization@archiver.kernel.org>; Mon, 24 May 2021 13:24:55 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 851B3613B0
	for <virtualization@archiver.kernel.org>; Mon, 24 May 2021 13:24:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 851B3613B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 482BF40383;
	Mon, 24 May 2021 13:24:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SMUgL09GpxZa; Mon, 24 May 2021 13:24:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id 454C4402BE;
	Mon, 24 May 2021 13:24:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0CEB0C000E;
	Mon, 24 May 2021 13:24:52 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EEDBAC0001
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 May 2021 13:24:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C530B82CEA
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 May 2021 13:24:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5XFCX1hTBKZj
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 May 2021 13:24:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1877382BFD
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 May 2021 13:24:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1621862688;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4XLlEUkhiAcP2K4ZB+J18mgQ/icUCahgsIUqJqs8aT8=;
 b=NIg44lUGidCRZOcNejC8oB5ljEjITNdrA0bmylfmpnUDXrGXYZqZI+XXFaXoHJz+fDfnmt
 S5kLb0Cxqnu+NG1Sk8Zdh0p4Nyq4nFRNNhrXINV4Yaaf2G+qIKeEOZPiUp7a2uboeO5JGt
 s7nzwrTxG6TrRqGoStLb90t/xZ9s/Rs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-525-jomfIlbHN1CH-3P2nYiTDA-1; Mon, 24 May 2021 09:24:46 -0400
X-MC-Unique: jomfIlbHN1CH-3P2nYiTDA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B747B100A241;
 Mon, 24 May 2021 13:24:44 +0000 (UTC)
Received: from localhost (ovpn-113-244.ams2.redhat.com [10.36.113.244])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D599E50233;
 Mon, 24 May 2021 13:24:38 +0000 (UTC)
Date: Mon, 24 May 2021 14:24:37 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Hannes Reinecke <hare@suse.de>
Subject: Re: [RFC] virtio_scsi: to poll and kick the virtqueue in timeout
 handler
Message-ID: <YKupFeOtc6Pr5KS2@stefanha-x1.localdomain>
References: <20210523063843.1177-1-dongli.zhang@oracle.com>
 <ac161748-15d2-2962-402e-23abca469623@suse.de>
MIME-Version: 1.0
In-Reply-To: <ac161748-15d2-2962-402e-23abca469623@suse.de>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Cc: srinivas.eeda@oracle.com, martin.petersen@oracle.com,
 linux-scsi@vger.kernel.org, mst@redhat.com, joe.jin@oracle.com,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 linux-block@vger.kernel.org, pbonzini@redhat.com, junxiao.bi@oracle.com,
 jejb@linux.ibm.com
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
Content-Type: multipart/mixed; boundary="===============6324169128583891426=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>


--===============6324169128583891426==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="S/KzmU9AGl0WrRAq"
Content-Disposition: inline


--S/KzmU9AGl0WrRAq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, May 23, 2021 at 09:39:51AM +0200, Hannes Reinecke wrote:
> On 5/23/21 8:38 AM, Dongli Zhang wrote:
> > This RFC is to trigger the discussion about to poll and kick the
> > virtqueue on purpose in virtio-scsi timeout handler.
> >=20
> > The virtio-scsi relies on the virtio vring shared between VM and host.
> > The VM side produces requests to vring and kicks the virtqueue, while t=
he
> > host side produces responses to vring and interrupts the VM side.
> >=20
> > By default the virtio-scsi handler depends on the host timeout handler
> > by BLK_EH_RESET_TIMER to give host a chance to perform EH.
> >=20
> > However, this is not helpful for the case that the responses are availa=
ble
> > on vring but the notification from host to VM is lost.
> >=20
> How can this happen?
> If responses are lost the communication between VM and host is broken, and
> we should rather reset the virtio rings themselves.

I agree. In principle it's fine to poll the virtqueue at any time, but I
don't understand the failure scenario here. It's not clear to me why the
device-to-driver vq notification could be lost.

Stefan

--S/KzmU9AGl0WrRAq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmCrqRUACgkQnKSrs4Gr
c8ja+gf9GSHdRkmM60mxLZ82ONQ0mRq3/yKUUtqLg3POUVan4p1AT+T6YazetRxA
1ux2OmVeDXzAfe9mawQXQLZ5ArlNGYGR+hfi30ECCfXGMkmdhJN42JO57bzYhyfM
ezn5v4l8Dk6d6sdTwQbqaj0KJ8MGS3OqZ4Sd/zanTVlOEi3fuiY0NRYRRQG8xWkr
TFB8ZqPqQvFfdtrjZQHufl9GaZr/pn3xP3bKNXwKWTGCO4zUsgNzddvjGjcAsDh8
a9dX8ujl+N2xQYcp/EpWbeg3H8S/kyMv2834ZHaBH9FEG2K/Z25HfXTzInOSZiRs
vyysHy57N24AFAeVx11lAKTqkkvxcQ==
=8nHX
-----END PGP SIGNATURE-----

--S/KzmU9AGl0WrRAq--


--===============6324169128583891426==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============6324169128583891426==--

