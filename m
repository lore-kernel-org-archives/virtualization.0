Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E671CECAAA1
	for <virtualization@archiver.kernel.org>; Mon, 24 Oct 2022 15:30:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 69AA94059E;
	Mon, 24 Oct 2022 15:30:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 69AA94059E
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=hCvoD1Xh
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id octOLxRGGIlf; Mon, 24 Oct 2022 15:30:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id D29194047C;
	Mon, 24 Oct 2022 15:30:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D29194047C
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 88F60C0032;
	Mon, 24 Oct 2022 15:30:50 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F27C5C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Oct 2022 15:30:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C011F60BD4
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Oct 2022 15:30:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C011F60BD4
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=hCvoD1Xh
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5towWRU3J6On
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Oct 2022 15:30:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0D0AC60AE8
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0D0AC60AE8
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Oct 2022 15:30:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1666625447;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=t/jSO0lqWHSQcHiF6BRMSRgd7XZaU/RYEhuGiGA3W4o=;
 b=hCvoD1XheifSit65JiSHg6/Gm6qngDcD6hPPo9GarSp7J7YWcjF8JAyiXpUReOynLbZp8w
 UXPR+596Y5TqSBBh/jnw4BoPkWlewJKDNPziMMoX6DH+hiAKTlnp/A0ZoUf1yFrBtDNdX2
 zw8mEmF1FsewbRZIV1u3jIiBvgSPUw8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-656-BD8qyXrmOD2Ly-xXM2Yriw-1; Mon, 24 Oct 2022 11:30:43 -0400
X-MC-Unique: BD8qyXrmOD2Ly-xXM2Yriw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BEA24811E87;
 Mon, 24 Oct 2022 15:30:41 +0000 (UTC)
Received: from localhost (unknown [10.39.194.177])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 28818492CA2;
 Mon, 24 Oct 2022 15:30:40 +0000 (UTC)
Date: Mon, 24 Oct 2022 11:30:39 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Ming Lei <ming.lei@redhat.com>
Subject: Re: [Bug] double ->queue_rq() because of timeout in ->queue_rq()
Message-ID: <Y1avnzv01gevnmXz@fedora>
References: <Y1EQdafQlKNAsutk@T590> <Y1GpB6Gpm7GglwO3@fedora>
 <Y1ICvUwglbxkqE+v@T590>
MIME-Version: 1.0
In-Reply-To: <Y1ICvUwglbxkqE+v@T590>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Cc: Jens Axboe <axboe@kernel.dk>, djeffery@redhat.com,
 Bart Van Assche <bvanassche@acm.org>, linux-scsi@vger.kernel.org,
 virtualization@lists.linux-foundation.org, linux-block@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>
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
Content-Type: multipart/mixed; boundary="===============4138128205470796275=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>


--===============4138128205470796275==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="p/CIZd9qse9A1PsE"
Content-Disposition: inline


--p/CIZd9qse9A1PsE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 21, 2022 at 10:23:57AM +0800, Ming Lei wrote:
> On Thu, Oct 20, 2022 at 04:01:11PM -0400, Stefan Hajnoczi wrote:
> > On Thu, Oct 20, 2022 at 05:10:13PM +0800, Ming Lei wrote:
> > > Hi,
> > >=20
> > > David Jeffery found one double ->queue_rq() issue, so far it can
> > > be triggered in the following two cases:
> > >=20
> > > 1) scsi driver in guest kernel
> > >=20
> > > - the story could be long vmexit latency or long preempt latency of
> > > vCPU pthread, then IO req is timed out before queuing the request
> > > to hardware but after calling blk_mq_start_request() during ->queue_r=
q(),
> > > then timeout handler handles it by requeue, then double ->queue_rq() =
is
> > > caused, and kernel panic
> > >=20
> > > 2) burst of kernel messages from irq handler=20
> > >=20
> > > For 1), I think it is one reasonable case, given latency from host si=
de
> > > can come anytime in theory because vCPU is emulated by one normal host
> > > pthread which can be preempted anywhere. For 2), I guess kernel messa=
ge is
> > > supposed to be rate limited.
> > >=20
> > > Firstly, is this kind of so long(30sec) random latency when running k=
ernel
> > > code something normal? Or do we need to take care of it? IMO, it looks
> > > reasonable in case of VM, but our VM experts may have better idea abo=
ut this
> > > situation. Also the default 30sec timeout could be reduced via sysfs =
or
> > > drivers.
> >=20
> > 30 seconds is a long latency that does not occur during normal
> > operation, but unfortunately does happen on occasion.
>=20
> Thanks for the confirmation!
>=20
> >=20
> > I think there's an interest in understanding the root cause and solving
> > long latencies (if possible) in the QEMU/KVM communities. We can
> > investigate specific cases on kvm@vger.kernel.org and/or
> > qemu-devel@nongnu.org.
>=20
> The issue was original reported on VMware VM, but maybe David can figure
> out how to trigger it on QEMU/KVM.

A very basic question:

The virtio_blk driver has no q->mq_ops->timeout() callback. Why does the
block layer still enable the timeout mechanism when the driver doesn't
implement ->timeout()?

I saw there was some "idle" hctx logic and I guess the requests are
resubmitted (although it wasn't obvious to me how that happens in the
code)? Maybe that's why the timer is still used if the driver doesn't
care about timeouts...

Stefan

--p/CIZd9qse9A1PsE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmNWr58ACgkQnKSrs4Gr
c8hlugf/Zm8Eno2AVQxjiXkuaB/DSkHQ20Y/6eP+D5toFYHpxDXd1VEVRNbRuM6S
kZoO6p8BAojnvB3V1nEIXX0zEtzT7Si8rwL5vN2ygFUB8zam0H/pI/JHqFRuXdqc
vJ606Eg3QBpQeNCH6hoN1z0uxth4LJdAAhiHFIGSFtz32vi9b/pAE1NgX6Ah74cP
sg1Y/PXajKux/H4nm0NZnh2I89PX3Lw1pVDccbShlbNIk3+UQvXZRRkLj8YVVk6v
TBxKmOuFMzh7iCjBRR5ruZoI+ULwodiJLYF057O8H1gMO0oGdUthqLU1YAQ8Ej0d
t9QCP3hK5W+1RYwJfEYGBFgr31CEEQ==
=+6cb
-----END PGP SIGNATURE-----

--p/CIZd9qse9A1PsE--


--===============4138128205470796275==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============4138128205470796275==--

