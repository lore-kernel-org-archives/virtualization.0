Return-Path: <SRS0=Jws+=OR=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 181FCC433EF
	for <virtualization@archiver.kernel.org>; Mon, 27 Sep 2021 08:09:55 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57CDC6115C
	for <virtualization@archiver.kernel.org>; Mon, 27 Sep 2021 08:09:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 57CDC6115C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 18F0B4062C;
	Mon, 27 Sep 2021 08:09:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wuCBg_2lRZDw; Mon, 27 Sep 2021 08:09:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id BD7334061D;
	Mon, 27 Sep 2021 08:09:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 981F1C000F;
	Mon, 27 Sep 2021 08:09:52 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EBC72C000D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Sep 2021 08:09:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id CE35340624
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Sep 2021 08:09:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id L611qbl8plnq
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Sep 2021 08:09:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E463A4061D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Sep 2021 08:09:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1632730189;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=l5HpZigQlfyuuUZ5v+ofmgDie9ICzyMUm/Yd5LeQNgs=;
 b=CNim4ZEdgEW3pH+d7o0ma7dlrznjFykDe9VXTfxa52fS0SHYtRZu9mqKs073+2kkfJZ/5X
 gsrRPt+jg3iIhl+6Imq3DDy+6h7r7uzG/fTcCnbYKe9VXMsfji9ShFSdGEhQAUQ5RV+MXo
 1+DlJnYk58iOvVLd4jopzyjORBpHGcg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-423-_aKQvTj3OGGAeQFzAmzX2g-1; Mon, 27 Sep 2021 04:09:45 -0400
X-MC-Unique: _aKQvTj3OGGAeQFzAmzX2g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4518010168C3;
 Mon, 27 Sep 2021 08:09:44 +0000 (UTC)
Received: from localhost (unknown [10.39.192.180])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4750C6B54F;
 Mon, 27 Sep 2021 08:09:41 +0000 (UTC)
Date: Mon, 27 Sep 2021 10:09:40 +0200
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: Re: [PATCH 2/2] virtio-blk: set NUMA affinity for a tagset
Message-ID: <YVF8RBZSaJs9BScd@stefanha-x1.localdomain>
References: <20210926145518.64164-1-mgurtovoy@nvidia.com>
 <20210926145518.64164-2-mgurtovoy@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20210926145518.64164-2-mgurtovoy@nvidia.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, kvm@vger.kernel.org,
 mst@redhat.com, israelr@nvidia.com, virtualization@lists.linux-foundation.org,
 hch@infradead.org, nitzanc@nvidia.com, oren@nvidia.com
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
Content-Type: multipart/mixed; boundary="===============5030327265122528810=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>


--===============5030327265122528810==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="fF+gM4A/h2gK2jIm"
Content-Disposition: inline


--fF+gM4A/h2gK2jIm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 26, 2021 at 05:55:18PM +0300, Max Gurtovoy wrote:
> To optimize performance, set the affinity of the block device tagset
> according to the virtio device affinity.
>=20
> Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> ---
>  drivers/block/virtio_blk.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index 9b3bd083b411..1c68c3e0ebf9 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -774,7 +774,7 @@ static int virtblk_probe(struct virtio_device *vdev)
>  	memset(&vblk->tag_set, 0, sizeof(vblk->tag_set));
>  	vblk->tag_set.ops =3D &virtio_mq_ops;
>  	vblk->tag_set.queue_depth =3D queue_depth;
> -	vblk->tag_set.numa_node =3D NUMA_NO_NODE;
> +	vblk->tag_set.numa_node =3D virtio_dev_to_node(vdev);
>  	vblk->tag_set.flags =3D BLK_MQ_F_SHOULD_MERGE;
>  	vblk->tag_set.cmd_size =3D
>  		sizeof(struct virtblk_req) +

I implemented NUMA affinity in the past and could not demonstrate a
performance improvement:
https://lists.linuxfoundation.org/pipermail/virtualization/2020-June/048248=
=2Ehtml

The pathological case is when a guest with vNUMA has the virtio-blk-pci
device on the "wrong" host NUMA node. Then memory accesses should cross
NUMA nodes. Still, it didn't seem to matter.

Please share your benchmark results. If you haven't collected data yet
you could even combine our patches to see if it helps. Thanks!

Stefan

--fF+gM4A/h2gK2jIm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmFRfEMACgkQnKSrs4Gr
c8ijxgf/WJsZGMwBy3P0wAF4J4oXhH44ONmgK3OJh5n9i3QtyVEG73LkgnD5Gf9M
9NZnRYgfeYce3jD3ymDS6xk/lqY205H+O1ZYUvFo4Kn/w3hJvpstwbgMKk6sm4XB
NXsaB+0M7gsAm0HVgWzkDqanzOSLMFJZpF0Lvtj6/+9NYyRvBXbFkP6vCfLQEoQw
0YB+df/mv5UMjUXg0BxiXrMalaQ6po2bNAhBe3PmMXsVIr3wG/gyyUxyugKyZFeK
KE/I4zTmsgqO/72E5c9On7mSF5zZvQNLA00K29ENsGZbprNodTcDhqdaNhwRdSCw
SOku06A0BIXyZlgMKBqTxm8nW5XX4A==
=sWXI
-----END PGP SIGNATURE-----

--fF+gM4A/h2gK2jIm--


--===============5030327265122528810==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============5030327265122528810==--

