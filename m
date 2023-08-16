Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BB10C001B0
	for <virtualization@archiver.kernel.org>; Wed, 16 Aug 2023 12:30:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6B8AC41F5F;
	Wed, 16 Aug 2023 12:30:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6B8AC41F5F
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=JXvrtRbH
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KE-xSg9OYKjt; Wed, 16 Aug 2023 12:30:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id BB97541F44;
	Wed, 16 Aug 2023 12:30:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BB97541F44
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 948D7C0071;
	Wed, 16 Aug 2023 12:30:39 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D7A24C0032
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Aug 2023 12:30:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B2286403F8
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Aug 2023 12:30:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B2286403F8
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=JXvrtRbH
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fms8NzdKzd0Y
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Aug 2023 12:30:37 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 064F9403E7
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Aug 2023 12:30:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 064F9403E7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692189035;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gJm0s/M+Kg1YF5GxLN6JBJXmw6ZG4JEwhaw6y9Y9T1I=;
 b=JXvrtRbHGTo3RArDCNGn0ZqYSp0QUGRrMNuLQ1+m4N3vbAH0moTboqC3jnCrlvYnHJg6Wj
 RF70vOO+wItVX65JRgH+tSXopuYIomA2lQQTLd5IbhM1ZS9E0Xxqt3jI8X1tBcnpo6CI9C
 S4Khhhk/OXYfyOsEV5wXxBvxw7yk190=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-654-S8WR71diNvaEOdM6fFO7yA-1; Wed, 16 Aug 2023 08:30:32 -0400
X-MC-Unique: S8WR71diNvaEOdM6fFO7yA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D07CD1C0691E;
 Wed, 16 Aug 2023 12:30:31 +0000 (UTC)
Received: from localhost (unknown [10.39.193.154])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3943B40C207A;
 Wed, 16 Aug 2023 12:30:30 +0000 (UTC)
Date: Wed, 16 Aug 2023 08:30:29 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Peter-Jan Gootzen <peter-jan@gootzen.net>
Subject: Re: [PATCH V4] virtio-fs: Improved request latencies when Virtio
 queue is full
Message-ID: <20230816123029.GA3425284@fedora>
References: <20230703191457.1847740-1-peter-jan@gootzen.net>
MIME-Version: 1.0
In-Reply-To: <20230703191457.1847740-1-peter-jan@gootzen.net>
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
Content-Type: multipart/mixed; boundary="===============3079266178494018503=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>


--===============3079266178494018503==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="pKdks2p52MVefYqy"
Content-Disposition: inline


--pKdks2p52MVefYqy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 03, 2023 at 09:14:59PM +0200, Peter-Jan Gootzen wrote:
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
> Signed-off-by: Peter-Jan Gootzen <peter-jan@gootzen.net>
> ---
> V4: Removed return value on error changes to simplify patch,
> that should be changed in another patch.
> V3: Fixed requests falling into the void when -ENOMEM and no new
> incoming requests. Virtio-fs now always lets -ENOMEM bubble up to
> userspace. Also made queue full condition more explicit with
> -ENOSPC in `send_forget_request`.
> V2: Not scheduling dispatch work anymore when not needed
> and changed delayed_work structs to work_struct structs
>=20
>  fs/fuse/virtio_fs.c | 32 +++++++++++++++++---------------
>  1 file changed, 17 insertions(+), 15 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--pKdks2p52MVefYqy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmTcwWUACgkQnKSrs4Gr
c8gwmggAjDDSTmwhKnH2Z5UFrC2kTCpUhEKeRg6A/OP9yr9Tp93ibbzd3xLqj+pD
kmCM/K3326pROSsEHF9NfQlPgr9VlABkYuxYhXu6Gdcba/LWsd9awyQNcwsutyjF
rc5e7N7/rpHwoPrQ5Atk+XV3wphDGZR5ziDGaojXVu8TGNvr0RHrXSEks373g3ys
U0FTFc5eFdIQwPllMrpB8lWfZNWNImvTfz7jskJuKzMV1LTr+1cIvr7nc9P04i+e
Ffsu0B9yxwTBMrGJXZp1zp1cym0TLt78pvPOQbNm7XmLX1iJqiA0ddoNv8F1YWYM
VSyRGaON4GUUjl9xbTYishlcWifypw==
=SxuU
-----END PGP SIGNATURE-----

--pKdks2p52MVefYqy--


--===============3079266178494018503==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============3079266178494018503==--

