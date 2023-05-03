Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB437C77B75
	for <virtualization@archiver.kernel.org>; Wed,  3 May 2023 15:57:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 3F4FF41D04;
	Wed,  3 May 2023 15:57:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3F4FF41D04
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=VnDtV3Ii
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 291dQ2guXF27; Wed,  3 May 2023 15:57:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 977D340518;
	Wed,  3 May 2023 15:57:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 977D340518
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6FD3BC0036;
	Wed,  3 May 2023 15:57:27 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A19D6C002A
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 May 2023 15:57:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 691D56152D
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 May 2023 15:57:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 691D56152D
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=VnDtV3Ii
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Rk0SzSSFqg7x
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 May 2023 15:57:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8C29460DED
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8C29460DED
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 May 2023 15:57:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1683129444;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EsRGaMSxZjGqbf3q0iORiAelbSECfaHX9TLV8VF714c=;
 b=VnDtV3Iiv/P+pA+TkrIioldI0a0VmRaCRxHnsmDmaW64bIaeDUJFVAUXRZUYg15lIEjLEF
 RJW0SKwE46pvgO1J9oSjt/aXYDBU8Hqbf8v6F9L7pdKH1p5TDXbfz2SaDsyn5/hBAlWuaH
 Ce/+N2ZDGdSqyXCz+fAdd+Xj0V8yKuw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-192-Y74Qo4mXOkq_L3_B2qHs3Q-1; Wed, 03 May 2023 11:57:20 -0400
X-MC-Unique: Y74Qo4mXOkq_L3_B2qHs3Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 053FB18E5372;
 Wed,  3 May 2023 15:57:20 +0000 (UTC)
Received: from localhost (unknown [10.39.193.0])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 770804020962;
 Wed,  3 May 2023 15:57:19 +0000 (UTC)
Date: Wed, 3 May 2023 09:39:13 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Subject: Re: [Patch net] vsock: improve tap delivery accuracy
Message-ID: <20230503133913.GF757667@fedora>
References: <20230502174404.668749-1-xiyou.wangcong@gmail.com>
 <20230502201418.GG535070@fedora> <ZDt+PDtKlxrwUPnc@bullseye>
MIME-Version: 1.0
In-Reply-To: <ZDt+PDtKlxrwUPnc@bullseye>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Cc: Cong Wang <cong.wang@bytedance.com>,
 Bobby Eshleman <bobby.eshleman@bytedance.com>, kvm@vger.kernel.org,
 netdev@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Cong Wang <xiyou.wangcong@gmail.com>
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
Content-Type: multipart/mixed; boundary="===============3350013028654118561=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>


--===============3350013028654118561==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="g/fPiS3p8CdrynfS"
Content-Disposition: inline


--g/fPiS3p8CdrynfS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 16, 2023 at 04:49:00AM +0000, Bobby Eshleman wrote:
> On Tue, May 02, 2023 at 04:14:18PM -0400, Stefan Hajnoczi wrote:
> > On Tue, May 02, 2023 at 10:44:04AM -0700, Cong Wang wrote:
> > > From: Cong Wang <cong.wang@bytedance.com>
> > >=20
> > > When virtqueue_add_sgs() fails, the skb is put back to send queue,
> > > we should not deliver the copy to tap device in this case. So we
> > > need to move virtio_transport_deliver_tap_pkt() down after all
> > > possible failures.
> > >=20
> > > Fixes: 82dfb540aeb2 ("VSOCK: Add virtio vsock vsockmon hooks")
> > > Cc: Stefan Hajnoczi <stefanha@redhat.com>
> > > Cc: Stefano Garzarella <sgarzare@redhat.com>
> > > Cc: Bobby Eshleman <bobby.eshleman@bytedance.com>
> > > Signed-off-by: Cong Wang <cong.wang@bytedance.com>
> > > ---
> > >  net/vmw_vsock/virtio_transport.c | 5 ++---
> > >  1 file changed, 2 insertions(+), 3 deletions(-)
> > >=20
> > > diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_=
transport.c
> > > index e95df847176b..055678628c07 100644
> > > --- a/net/vmw_vsock/virtio_transport.c
> > > +++ b/net/vmw_vsock/virtio_transport.c
> > > @@ -109,9 +109,6 @@ virtio_transport_send_pkt_work(struct work_struct=
 *work)
> > >  		if (!skb)
> > >  			break;
> > > =20
> > > -		virtio_transport_deliver_tap_pkt(skb);
> > > -		reply =3D virtio_vsock_skb_reply(skb);
> > > -
> > >  		sg_init_one(&hdr, virtio_vsock_hdr(skb), sizeof(*virtio_vsock_hdr(=
skb)));
> > >  		sgs[out_sg++] =3D &hdr;
> > >  		if (skb->len > 0) {
> > > @@ -128,6 +125,8 @@ virtio_transport_send_pkt_work(struct work_struct=
 *work)
> > >  			break;
> > >  		}
> > > =20
> > > +		virtio_transport_deliver_tap_pkt(skb);
> > > +		reply =3D virtio_vsock_skb_reply(skb);
> >=20
> > I don't remember the reason for the ordering, but I'm pretty sure it was
> > deliberate. Probably because the payload buffers could be freed as soon
> > as virtqueue_add_sgs() is called.
> >=20
> > If that's no longer true with Bobby's skbuff code, then maybe it's safe
> > to monitor packets after they have been sent.
> >=20
> > Stefan
>=20
> Hey Stefan,
>=20
> Unfortunately, skbuff doesn't change that behavior.
>=20
> If I understand correctly, the problem flow you are describing
> would be something like this:
>=20
> Thread 0 			Thread 1
> guest:virtqueue_add_sgs()[@send_pkt_work]
>=20
> 				host:vhost_vq_get_desc()[@handle_tx_kick]
> 				host:vhost_add_used()
> 				host:vhost_signal()
> 				guest:virtqueue_get_buf()[@tx_work]
> 				guest:consume_skb()
>=20
> guest:deliver_tap_pkt()[@send_pkt_work]
> ^ use-after-free
>=20
> Which I guess is possible because the receiver can consume the new
> scatterlist during the processing kicked off for a previous batch?
> (doesn't have to wait for the subsequent kick)

Yes, drivers must assume that the device completes request before
virtqueue_add_sgs() returns. For example, the device is allowed to poll
the virtqueue memory and may see the new descriptors immediately.

I haven't audited the current vsock code path to determine whether it's
possible to reach consume_skb() before deliver_tap_pkt() returns, so I
can't say whether it's safe or not.

Stefan

--g/fPiS3p8CdrynfS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmRSZAEACgkQnKSrs4Gr
c8jkvQgAmVX4WzYQDdtxMkSMB4j8ozN7cpcaVR90gu/OuPUKIV8FhCpymBqzgaWO
igJ5x5l1PsTrEB7b644n/bz4SUPOYJiekJeLOGCw22PIwowWVkG0zvvkJMVxLvCG
JdnOYVeoTHYn74n5GHn19eEj8DaPn/451P5zQh5f3AX7ZF4PFhDe6UdZN8iexfZ2
X+sbT+m61lc65n8Chkmd0yBrsDXKKgPDr5EtsSiyD+gUabYhQGrnnzxBk0lt8WbB
C985ZeXbxybJLduNHrSJBSA532rCNP2p4UJiHETArnIhuh+ynsxPOy46WGuKaJKh
xCf3AAd2UkLp1SRmpjL7WZmozD0aBA==
=gU1d
-----END PGP SIGNATURE-----

--g/fPiS3p8CdrynfS--


--===============3350013028654118561==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============3350013028654118561==--

