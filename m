Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9122C7EE23
	for <virtualization@archiver.kernel.org>; Mon,  5 Jun 2023 20:24:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 65FFC408DF;
	Mon,  5 Jun 2023 20:24:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 65FFC408DF
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=BwarFjlw
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nol_U4xnOxz6; Mon,  5 Jun 2023 20:24:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 9F7D4408D6;
	Mon,  5 Jun 2023 20:24:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9F7D4408D6
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 81574C0037;
	Mon,  5 Jun 2023 20:24:52 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 685D5C0029
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jun 2023 20:24:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4F96D60672
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jun 2023 20:24:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4F96D60672
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=BwarFjlw
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fcEIqnZpTPSt
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jun 2023 20:24:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 702A2606ED
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 702A2606ED
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jun 2023 20:24:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685996688;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pgFgSseQDjkg0Z+r27jt1fy1tNDXbe3EJFvnLTV3aHI=;
 b=BwarFjlwNd+AcIHZhwwC/qd4VsB8Tmoe2LEs+ewJoQjFwbMF9aKFMc03E3MV8MV2BN5I3B
 uPue11oumBJZbP4oJCEI5g8JeO5NwGVXe0XaCOeWuHvys0WzsFoGlXN/TlSzr4pl4RT6XO
 BjnrbG5oL5DMC3rsD1k5MGUzzB9apis=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-472-I42WB9c1NUuc32d64lbXxw-1; Mon, 05 Jun 2023 16:24:46 -0400
X-MC-Unique: I42WB9c1NUuc32d64lbXxw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 28971802355;
 Mon,  5 Jun 2023 20:24:46 +0000 (UTC)
Received: from localhost (unknown [10.39.192.51])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B434A40CFD46;
 Mon,  5 Jun 2023 20:24:45 +0000 (UTC)
Date: Mon, 5 Jun 2023 15:05:31 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Peter-Jan Gootzen <peter-jan@gootzen.net>
Subject: Re: [PATCH V3] virtio-fs: Improved request latencies when Virtio
 queue is full
Message-ID: <20230605190531.GD1861823@fedora>
References: <20230602133224.1445655-1-peter-jan@gootzen.net>
MIME-Version: 1.0
In-Reply-To: <20230602133224.1445655-1-peter-jan@gootzen.net>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Cc: miklos@szeredi.hu, vgoyal@redhat.com,
 virtualization@lists.linux-foundation.org
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
Content-Type: multipart/mixed; boundary="===============1019388564938187061=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>


--===============1019388564938187061==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="6Pq9e+GA+AqICj6e"
Content-Disposition: inline


--6Pq9e+GA+AqICj6e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 02, 2023 at 03:32:26PM +0200, Peter-Jan Gootzen wrote:
> When the Virtio queue is full, a work item is scheduled
> to execute in 1ms that retries adding the request to the queue.
> This is a large amount of time on the scale on which a
> virtio-fs device can operate. When using a DPU this is around
> 40us baseline without going to a remote server (4k, QD=3D1).
> This patch queues requests when the Virtio queue is full,
> and when a completed request is taken off, immediately fills
> it back up with queued requests.
>=20
> This reduces the 99.9th percentile latencies in our tests by
> 60x and slightly increases the overall throughput, when using a
> queue depth 2x the size of the Virtio queue size, with a
> DPU-powered virtio-fs device.
>=20
> Furthermore, the virtio-fs driver now also always lets -ENOMEM
> errors go to userspace instead of retrying the request in the
> driver.
>=20
> Signed-off-by: Peter-Jan Gootzen <peter-jan@gootzen.net>
> ---
> V3: Fixed requests falling into the void when -ENOMEM and no new
> incoming requests. Virtio-fs now always lets -ENOMEM bubble up to
> userspace. Also made queue full condition more explicit with
> -ENOSPC in `send_forget_request`.
> V2: Not scheduling dispatch work anymore when not needed
> and changed delayed_work structs to work_struct structs

Hi Peter-Jan,
I will be traveling and will try to look at this patch as soon as
possible.

If Vivek and others are happy, please don't wait for me.

Thanks,
Stefan

--6Pq9e+GA+AqICj6e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmR+MfsACgkQnKSrs4Gr
c8jC8ggArir260aKptEmDV9js9Koo/gMXoxTUjogh6iUdyq6rZEoStd3x3lAg+bG
Zy9//KjWyl1v/oVJaiPIgnu6zYqrjHhc7AXssABUH7M1mR4+OwO2eebGRETdDajk
6vLT2r/imHkMdHGFDobEiuWHPijbD1B9qVj5NF56/3aZrwidNhOXuC1ZXzC+2Jbq
emf1PAI6W9ncLQauWXYX5w8hRkPVzDPife31OL37Opue2CNSgbpdDl6IazTMNn/5
Ityo8E1D1icaFgHH9WFOnJQg6gksDvOLbVR1HUNbPuo1l2ZRUVgibHhbzkWO+Vc9
dglFU1P1zOl6p1YoE5Xv7y9504jvIg==
=9HX/
-----END PGP SIGNATURE-----

--6Pq9e+GA+AqICj6e--


--===============1019388564938187061==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============1019388564938187061==--

