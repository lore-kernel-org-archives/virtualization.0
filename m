Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31DFAC433F5
	for <virtualization@archiver.kernel.org>; Wed, 23 Mar 2022 13:45:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id CDB31400FE;
	Wed, 23 Mar 2022 13:45:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ydl0Fvl37sjw; Wed, 23 Mar 2022 13:45:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 4A03E40545;
	Wed, 23 Mar 2022 13:45:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 23142C001A;
	Wed, 23 Mar 2022 13:45:24 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5697CC000B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Mar 2022 13:45:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 374AB849C7
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Mar 2022 13:45:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id imuvSt8w9xA1
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Mar 2022 13:45:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id DFBAD849B4
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Mar 2022 13:45:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1648043120;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=D9p4dT9tmB1MqpunWPOj0g10DavGp6R613Fb41aTrE0=;
 b=dBMT9i32R5owLMwHNElyRoipAyQFK5L4TqiH+8C4hMFw0FlsWeJs4+7kIM+j27pXaeMc/Q
 r3aXSeilP/FZPUY7g1VeNSEFehFmuwlTXFb9rLVx4Yhf2XMSEunvByOQVhNiANzSntjH9y
 jEO3kF/lKv/3l6skkxu8ObvPMaW10H8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-19-5PcxbFsuPcq5fgDPt_Xe0Q-1; Wed, 23 Mar 2022 09:45:17 -0400
X-MC-Unique: 5PcxbFsuPcq5fgDPt_Xe0Q-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B3A0E804184;
 Wed, 23 Mar 2022 13:45:16 +0000 (UTC)
Received: from localhost (unknown [10.39.194.72])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6AE7A401E7B;
 Wed, 23 Mar 2022 13:45:16 +0000 (UTC)
Date: Wed, 23 Mar 2022 13:45:15 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH net v2 2/3] vsock/virtio: initialize vdev->priv before
 using VQs
Message-ID: <Yjska4v9QaRS2pJQ@stefanha-x1.localdomain>
References: <20220323084954.11769-1-sgarzare@redhat.com>
 <20220323084954.11769-3-sgarzare@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20220323084954.11769-3-sgarzare@redhat.com>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
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
Content-Type: multipart/mixed; boundary="===============2364449915951191720=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>


--===============2364449915951191720==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="3R3JLtwl44kUF4kA"
Content-Disposition: inline


--3R3JLtwl44kUF4kA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 23, 2022 at 09:49:53AM +0100, Stefano Garzarella wrote:
> When we fill VQs with empty buffers and kick the host, it may send
> an interrupt. `vdev->priv` must be initialized before this since it
> is used in the virtqueue callback.
>=20
> Fixes: 0deab087b16a ("vsock/virtio: use RCU to avoid use-after-free on th=
e_virtio_vsock")
> Suggested-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
>  net/vmw_vsock/virtio_transport.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_tran=
sport.c
> index b1962f8cd502..fff67ad39087 100644
> --- a/net/vmw_vsock/virtio_transport.c
> +++ b/net/vmw_vsock/virtio_transport.c
> @@ -622,6 +622,7 @@ static int virtio_vsock_probe(struct virtio_device *v=
dev)
>  	INIT_WORK(&vsock->event_work, virtio_transport_event_work);
>  	INIT_WORK(&vsock->send_pkt_work, virtio_transport_send_pkt_work);
> =20
> +	vdev->priv =3D vsock;
>  	virtio_device_ready(vdev);

Doh, patch order got me. :)

Stefan

--3R3JLtwl44kUF4kA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmI7JGsACgkQnKSrs4Gr
c8jGEgf+NmY84WZKJt4M3ASm6YsR7skYma09Y+u6pulwtzHks6OpAZzjoXQHGIBS
/VimYO8GzZLJQXM7ZawAR82ynLRJR/fD4c574cymhwYyEucPvzhc6bWD/d0Wxlye
CuDUZ5ogWrl03SkA2Z7qE9hlGMxHXG9alh+uU+riRlLxRfWlxl3UQiuRwYxV9sij
v3VpMkTj4qD0IFb+BJUHCeBaTZYIufDqSExT1dAkOtfZxzsVhbK2aT7kVQT8LgoB
yZUPLgDZ83kCAsVqZfWG2Pxfi91XADhSg31ymOPAKx3Fva+7P2eRIKVXy8wT3yDi
V39sZSRcKgm9AJ/09faSF2UCwrfUKw==
=yTw0
-----END PGP SIGNATURE-----

--3R3JLtwl44kUF4kA--


--===============2364449915951191720==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============2364449915951191720==--

