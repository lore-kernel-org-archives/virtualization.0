Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46DB0C636CC
	for <virtualization@archiver.kernel.org>; Tue,  7 Feb 2023 19:45:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id B129E40AF4;
	Tue,  7 Feb 2023 19:45:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B129E40AF4
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WJuQ/QdI
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TSzdoOJyqYGX; Tue,  7 Feb 2023 19:45:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 2FD8640186;
	Tue,  7 Feb 2023 19:45:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2FD8640186
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E96A8C0033;
	Tue,  7 Feb 2023 19:45:48 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C09F2C002B
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Feb 2023 19:45:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8E54361040
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Feb 2023 19:45:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8E54361040
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=WJuQ/QdI
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kc9_HgxM6j7C
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Feb 2023 19:45:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1731460FF4
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1731460FF4
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Feb 2023 19:45:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1675799144;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zZP7i9xnVVtdPMRLDCQK/eXEWbZlSGeq4QZ1DxHnsNA=;
 b=WJuQ/QdIYvKtO5hakA+Al03NnmnqukHi3F2iFtLFW1J1d0YoBS3cQzMK0QtRih23ob/Nts
 zRcZkt6m4joc/zuYTiwrLrkdK6O26dKyWIHITb+sP6neskv+3UewBVR4f/pvTWLe5tLD1G
 K/xQ2gUDpgdcK65wlFwxO6xWULH4+xM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-661-aBtDDDTsOKmOzyMbktAqEQ-1; Tue, 07 Feb 2023 14:45:42 -0500
X-MC-Unique: aBtDDDTsOKmOzyMbktAqEQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4EDA7811E9C;
 Tue,  7 Feb 2023 19:45:42 +0000 (UTC)
Received: from localhost (unknown [10.39.192.57])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9CC7C2026D37;
 Tue,  7 Feb 2023 19:45:41 +0000 (UTC)
Date: Tue, 7 Feb 2023 14:45:39 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Peter-Jan Gootzen <peter-jan@gootzen.net>
Subject: Re: virtio-fs: adding support for multi-queue
Message-ID: <Y+KqY3Nse0pVhd3X@fedora>
References: <2fd99bc2-0414-0b85-2bff-3a84ae6c23bd@gootzen.net>
MIME-Version: 1.0
In-Reply-To: <2fd99bc2-0414-0b85-2bff-3a84ae6c23bd@gootzen.net>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Cc: virtualization@lists.linux-foundation.org,
 Jonas Pfefferle <JPF@zurich.ibm.com>, vgoyal@redhat.com, miklos@szeredi.hu
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
Content-Type: multipart/mixed; boundary="===============3612586519428533355=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>


--===============3612586519428533355==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="T8OZR3LlbWnRP9FV"
Content-Disposition: inline


--T8OZR3LlbWnRP9FV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 07, 2023 at 11:14:46AM +0100, Peter-Jan Gootzen wrote:
> Hi,
>=20
> For my MSc thesis project in collaboration with IBM
> (https://github.com/IBM/dpu-virtio-fs) we are looking to improve the
> performance of the virtio-fs driver in high throughput scenarios. We think
> the main bottleneck is the fact that the virtio-fs driver does not support
> multi-queue (while the spec does). A big factor in this is that our setup=
 on
> the virtio-fs device-side (a DPU) does not easily allow multiple cores to
> tend to a single virtio queue.
>=20
> We are therefore looking to implement multi-queue functionality in the
> virtio-fs driver. The request queues seem to already get created at probe,
> but left unused afterwards. The current plan is to select the queue for a
> request based on the current smp processor id and set the virtio queue
> interrupt affinity for each core accordingly at probe.
>=20
> This is my first time contributing to the Linux kernel so I am here to ask
> what the maintainers' thoughts are about this plan.

Hi,
Sounds good. Assigning vqs round-robin is the strategy that virtio-net
and virtio-blk use. virtio-blk could be an interesting example as it's
similar to virtiofs. The Linux multiqueue block layer and core virtio
irq allocation handle CPU affinity in the case of virtio-blk.

Which DPU are you targetting?

Stefan

>=20
> Best,
> Peter-Jan Gootzen
> MSc student at VU University Amsterdam & IBM Research Zurich
>=20

--T8OZR3LlbWnRP9FV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmPiqmMACgkQnKSrs4Gr
c8hJngf+N4yWOPoex2wG39THqpLEU/ba4dLx9WCiXhIxJlfZlt2OXRUnKIegsShY
sq5zaQ738HwpdK4Zt38Zu46W2xYvQbxvWRjfE7Na3AemmcL0EM7HKvLljVLXzmy6
Wx56pdlKLnt8VQlxHFJkTk23baDDdtct8Mwg4/DGHX5aJFTHvUUlC9O1tbFkmniP
PVNmn/JxgTnl1sY39Vp46mGRxKUPmrBjBFSaYrTVC6h7+3cInvL3DSyQUFzyKwCH
NbRxQqoiUuzwL74jqC+UJPHT3rMtobAI4E52g63Hw7BH0GRHyP/UoQgotykudLCF
o0spVtXqaiDhRYNdy1z96PeT+mmDww==
=yaQ9
-----END PGP SIGNATURE-----

--T8OZR3LlbWnRP9FV--


--===============3612586519428533355==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============3612586519428533355==--

