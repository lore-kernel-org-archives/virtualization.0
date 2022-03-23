Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6BE1C433F5
	for <virtualization@archiver.kernel.org>; Wed, 23 Mar 2022 13:44:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 657AF849C5;
	Wed, 23 Mar 2022 13:44:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mj4sfbLZiO2Y; Wed, 23 Mar 2022 13:44:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 0219184746;
	Wed, 23 Mar 2022 13:44:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CEF45C001A;
	Wed, 23 Mar 2022 13:44:50 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6FAC8C000B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Mar 2022 13:44:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5F8FC84950
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Mar 2022 13:44:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZYyyAkGxDy1E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Mar 2022 13:44:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id AB49A84746
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Mar 2022 13:44:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1648043087;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GSgoSaQ+JIfg7wq78quWtl1Bx2v1bqSuTJRYfSjlhrE=;
 b=W63ZKKS5zxypUZELKSrrkpNRyzIb1ATId2o7e9BL7U1T8R6YhSmgSghbiSsI7ZMw/zpD71
 glAhg5/X8+ZaFNdqZM2S7I5hH82NyCgNn79Qq8i+NCbPnlaAnno9pfLlSS9ELqYJSV7srn
 fbh7Ck8DYKQ63YB0qJcuxBmK4tYm1cE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-503-PE0IjX1kNEi9tDprSbLOhg-1; Wed, 23 Mar 2022 09:44:44 -0400
X-MC-Unique: PE0IjX1kNEi9tDprSbLOhg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8DFBE811E75;
 Wed, 23 Mar 2022 13:44:43 +0000 (UTC)
Received: from localhost (unknown [10.39.194.72])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E7E2D1400E70;
 Wed, 23 Mar 2022 13:44:42 +0000 (UTC)
Date: Wed, 23 Mar 2022 13:44:42 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH net v2 1/3] vsock/virtio: enable VQs early on probe
Message-ID: <YjskSh4PgXuDStAF@stefanha-x1.localdomain>
References: <20220323084954.11769-1-sgarzare@redhat.com>
 <20220323084954.11769-2-sgarzare@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20220323084954.11769-2-sgarzare@redhat.com>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, Asias He <asias@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Arseny Krasnov <arseny.krasnov@kaspersky.com>, Paolo Abeni <pabeni@redhat.com>,
 "David S. Miller" <davem@davemloft.net>
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
Content-Type: multipart/mixed; boundary="===============5192271922275312984=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>


--===============5192271922275312984==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Ew8YH6cjDCduveFO"
Content-Disposition: inline


--Ew8YH6cjDCduveFO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 23, 2022 at 09:49:52AM +0100, Stefano Garzarella wrote:
> virtio spec requires drivers to set DRIVER_OK before using VQs.
> This is set automatically after probe returns, but virtio-vsock
> driver uses VQs in the probe function to fill rx and event VQs
> with new buffers.
>=20
> Let's fix this, calling virtio_device_ready() before using VQs
> in the probe function.
>=20
> Fixes: 0ea9e1d3a9e3 ("VSOCK: Introduce virtio_transport.ko")
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
>  net/vmw_vsock/virtio_transport.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_tran=
sport.c
> index 5afc194a58bb..b1962f8cd502 100644
> --- a/net/vmw_vsock/virtio_transport.c
> +++ b/net/vmw_vsock/virtio_transport.c
> @@ -622,6 +622,8 @@ static int virtio_vsock_probe(struct virtio_device *v=
dev)
>  	INIT_WORK(&vsock->event_work, virtio_transport_event_work);
>  	INIT_WORK(&vsock->send_pkt_work, virtio_transport_send_pkt_work);
> =20
> +	virtio_device_ready(vdev);

Can rx and event virtqueue interrupts be lost if they occur before we
assign vdev->priv later in virtio_vsock_probe()?

Stefan

--Ew8YH6cjDCduveFO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmI7JEkACgkQnKSrs4Gr
c8iwMQf6AoKiNuvBPWS3yOCgqec8X+6LYAdNCyNKlqC9GPmHeZ6YFFfiuvTxqTNg
WujzjOLTSWdMn8IOwNfNyxtIb5dLFITwd5eaAyh8zPjWTimt0JE70MU2/ezYQBJU
0pW9hKlhUT9i2HccLdSKvMRrCJfnqFyJqGod/1AXK3Bxb307mxFydP7rjOq/nGpw
BJapVkSHZ1oNbsFiad5XZMkmEnLeJbV+NKxdmlyMIXFsnCda9QsgQ+/qDwck41jQ
pMlBjnoWhwMV0NEeWqICUSp0dNOEKMzs+lrp5DJeuqnLsApUDb9DOpvtU44ZRcVF
gQHruj4EAL/97VOo0C/f/7jE6h+f+g==
=R5CZ
-----END PGP SIGNATURE-----

--Ew8YH6cjDCduveFO--


--===============5192271922275312984==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============5192271922275312984==--

