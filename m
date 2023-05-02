Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB918C77B73
	for <virtualization@archiver.kernel.org>; Tue,  2 May 2023 20:14:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 65189405C4;
	Tue,  2 May 2023 20:14:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 65189405C4
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=HL9MOHKc
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WxeoEtPGTzMw; Tue,  2 May 2023 20:14:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id B2F3D400C8;
	Tue,  2 May 2023 20:14:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B2F3D400C8
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 87F43C0036;
	Tue,  2 May 2023 20:14:32 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 34003C002A
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 May 2023 20:14:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 07CEC60E89
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 May 2023 20:14:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 07CEC60E89
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=HL9MOHKc
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id l23ePeGNkuW8
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 May 2023 20:14:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B457060AD6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B457060AD6
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 May 2023 20:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1683058467;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nAEd+ThcQWINJlvJtJN4h1Ebf0jhOxf5fjR+jlzpGuE=;
 b=HL9MOHKcu2PX+DnWFD9jMDJ1NPUQokvj7C/WVx4ESEpewPv6Ma2j5cvRYrNZGgYl/vJrpF
 Ol7DjHUag5Cft3Sjc9mIl4Al9sp7huCVxdkyrqKLGBt/dP7Ydzc4ppkiIxWtRM6g8KdkO4
 vlQQfFs58LNhsdZPVDgg8IQumVXO3cA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-656-aYlCX5tFMCCM8wy3KwFEfA-1; Tue, 02 May 2023 16:14:21 -0400
X-MC-Unique: aYlCX5tFMCCM8wy3KwFEfA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EAEA0102F22D;
 Tue,  2 May 2023 20:14:20 +0000 (UTC)
Received: from localhost (unknown [10.39.192.230])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1DDB92026D25;
 Tue,  2 May 2023 20:14:19 +0000 (UTC)
Date: Tue, 2 May 2023 16:14:18 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Cong Wang <xiyou.wangcong@gmail.com>
Subject: Re: [Patch net] vsock: improve tap delivery accuracy
Message-ID: <20230502201418.GG535070@fedora>
References: <20230502174404.668749-1-xiyou.wangcong@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20230502174404.668749-1-xiyou.wangcong@gmail.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Cc: Cong Wang <cong.wang@bytedance.com>,
 Bobby Eshleman <bobby.eshleman@bytedance.com>, kvm@vger.kernel.org,
 netdev@vger.kernel.org, virtualization@lists.linux-foundation.org
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
Content-Type: multipart/mixed; boundary="===============8249203870817375449=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>


--===============8249203870817375449==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="0Dc6VZ7ve/w9MZyR"
Content-Disposition: inline


--0Dc6VZ7ve/w9MZyR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 02, 2023 at 10:44:04AM -0700, Cong Wang wrote:
> From: Cong Wang <cong.wang@bytedance.com>
>=20
> When virtqueue_add_sgs() fails, the skb is put back to send queue,
> we should not deliver the copy to tap device in this case. So we
> need to move virtio_transport_deliver_tap_pkt() down after all
> possible failures.
>=20
> Fixes: 82dfb540aeb2 ("VSOCK: Add virtio vsock vsockmon hooks")
> Cc: Stefan Hajnoczi <stefanha@redhat.com>
> Cc: Stefano Garzarella <sgarzare@redhat.com>
> Cc: Bobby Eshleman <bobby.eshleman@bytedance.com>
> Signed-off-by: Cong Wang <cong.wang@bytedance.com>
> ---
>  net/vmw_vsock/virtio_transport.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>=20
> diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_tran=
sport.c
> index e95df847176b..055678628c07 100644
> --- a/net/vmw_vsock/virtio_transport.c
> +++ b/net/vmw_vsock/virtio_transport.c
> @@ -109,9 +109,6 @@ virtio_transport_send_pkt_work(struct work_struct *wo=
rk)
>  		if (!skb)
>  			break;
> =20
> -		virtio_transport_deliver_tap_pkt(skb);
> -		reply =3D virtio_vsock_skb_reply(skb);
> -
>  		sg_init_one(&hdr, virtio_vsock_hdr(skb), sizeof(*virtio_vsock_hdr(skb)=
));
>  		sgs[out_sg++] =3D &hdr;
>  		if (skb->len > 0) {
> @@ -128,6 +125,8 @@ virtio_transport_send_pkt_work(struct work_struct *wo=
rk)
>  			break;
>  		}
> =20
> +		virtio_transport_deliver_tap_pkt(skb);
> +		reply =3D virtio_vsock_skb_reply(skb);

I don't remember the reason for the ordering, but I'm pretty sure it was
deliberate. Probably because the payload buffers could be freed as soon
as virtqueue_add_sgs() is called.

If that's no longer true with Bobby's skbuff code, then maybe it's safe
to monitor packets after they have been sent.

Stefan

--0Dc6VZ7ve/w9MZyR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmRRbxoACgkQnKSrs4Gr
c8h/hAgAq4kkdU23+bhb7SJMTwFS13v3myHk2VwR1yoo45K747CJ4JrcQ/WPElFK
DfAoVseMWpQD036gdRWJ/PEaKwKNubb4gdi++tcjAaVkpzGF1U94YazwqmUWQhdj
+WQOQdoubxhrAJabeE6CWgSDv2i8CcDkb9ExbePPJ/uwCAlRFcfAjxeIg2+KIPv1
+Gbbc2D5M98u+1TJWVg+uiHmE/MOF1EgEVxf/K5pdV/K/a28Oi5F4rqDQ+pm2o2X
+HLs2N3AO+9k46TdSiAsBLsYkFHwqigogXUUk00tNnlLPS4CZ0qpurC3VetfOIjU
/P2y23AuIY3C0hJIQp6K7HQz/Yjc6A==
=EShQ
-----END PGP SIGNATURE-----

--0Dc6VZ7ve/w9MZyR--


--===============8249203870817375449==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============8249203870817375449==--

