Return-Path: <SRS0=Y9jr=OS=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23585C433EF
	for <virtualization@archiver.kernel.org>; Tue, 28 Sep 2021 06:47:48 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B464C61157
	for <virtualization@archiver.kernel.org>; Tue, 28 Sep 2021 06:47:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B464C61157
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7BC9260AD7;
	Tue, 28 Sep 2021 06:47:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bHzOQZzmTVON; Tue, 28 Sep 2021 06:47:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 1AD9360ACB;
	Tue, 28 Sep 2021 06:47:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F382EC0011;
	Tue, 28 Sep 2021 06:47:45 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E825FC000D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Sep 2021 06:47:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D5040402A2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Sep 2021 06:47:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RFI4f4dF7dYW
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Sep 2021 06:47:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7E22E40229
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Sep 2021 06:47:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1632811662;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sCmNJ5vO7haCV1drO5nn+RW5ibWF9pJv3xiWMlwH7+g=;
 b=giP7kwsSY+HiQ9ak6pxrkQvBEQXSj4jr965v6TVqU2Rl7L9NNQvax6lSizqfrHt+Y6rWLB
 AxGCLOV0zf1aq8Wk98Txt/CSU4FPVohBpQusuQB0DwsTmv7YvoBIs9M1a8q946QYh9t8Sv
 RP2qgh4Ex5zFGSuR56iaYen8VHOiM0M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-108-_X6jgUWMN0ePwSNylaNBSQ-1; Tue, 28 Sep 2021 02:47:40 -0400
X-MC-Unique: _X6jgUWMN0ePwSNylaNBSQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ED4CD1808312;
 Tue, 28 Sep 2021 06:47:38 +0000 (UTC)
Received: from localhost (unknown [10.39.192.122])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 196165F70B;
 Tue, 28 Sep 2021 06:47:34 +0000 (UTC)
Date: Tue, 28 Sep 2021 08:47:33 +0200
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: Re: [PATCH 2/2] virtio-blk: set NUMA affinity for a tagset
Message-ID: <YVK6hdcrXwQHrXQ9@stefanha-x1.localdomain>
References: <20210926145518.64164-1-mgurtovoy@nvidia.com>
 <20210926145518.64164-2-mgurtovoy@nvidia.com>
 <YVF8RBZSaJs9BScd@stefanha-x1.localdomain>
 <21295187-41c4-5fb6-21c3-28004eb7c5d8@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <21295187-41c4-5fb6-21c3-28004eb7c5d8@nvidia.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
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
Content-Type: multipart/mixed; boundary="===============8389483731532564288=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>


--===============8389483731532564288==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="tlmjEO+SMhyWD/NG"
Content-Disposition: inline


--tlmjEO+SMhyWD/NG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 27, 2021 at 08:39:30PM +0300, Max Gurtovoy wrote:
>=20
> On 9/27/2021 11:09 AM, Stefan Hajnoczi wrote:
> > On Sun, Sep 26, 2021 at 05:55:18PM +0300, Max Gurtovoy wrote:
> > > To optimize performance, set the affinity of the block device tagset
> > > according to the virtio device affinity.
> > >=20
> > > Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> > > ---
> > >   drivers/block/virtio_blk.c | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > >=20
> > > diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> > > index 9b3bd083b411..1c68c3e0ebf9 100644
> > > --- a/drivers/block/virtio_blk.c
> > > +++ b/drivers/block/virtio_blk.c
> > > @@ -774,7 +774,7 @@ static int virtblk_probe(struct virtio_device *vd=
ev)
> > >   	memset(&vblk->tag_set, 0, sizeof(vblk->tag_set));
> > >   	vblk->tag_set.ops =3D &virtio_mq_ops;
> > >   	vblk->tag_set.queue_depth =3D queue_depth;
> > > -	vblk->tag_set.numa_node =3D NUMA_NO_NODE;
> > > +	vblk->tag_set.numa_node =3D virtio_dev_to_node(vdev);
> > >   	vblk->tag_set.flags =3D BLK_MQ_F_SHOULD_MERGE;
> > >   	vblk->tag_set.cmd_size =3D
> > >   		sizeof(struct virtblk_req) +
> > I implemented NUMA affinity in the past and could not demonstrate a
> > performance improvement:
> > https://lists.linuxfoundation.org/pipermail/virtualization/2020-June/04=
8248.html
> >=20
> > The pathological case is when a guest with vNUMA has the virtio-blk-pci
> > device on the "wrong" host NUMA node. Then memory accesses should cross
> > NUMA nodes. Still, it didn't seem to matter.
>=20
> I think the reason you didn't see any improvement is since you didn't use
> the right device for the node query. See my patch 1/2.

That doesn't seem to be the case. Please see
drivers/base/core.c:device_add():

  /* use parent numa_node */
  if (parent && (dev_to_node(dev) =3D=3D NUMA_NO_NODE))
          set_dev_node(dev, dev_to_node(parent));

IMO it's cleaner to use dev_to_node(&vdev->dev) than to directly access
the parent.

Have I missed something?

>=20
> I can try integrating these patches in my series and fix it.
>=20
> BTW, we might not see a big improvement because of other bottlenecks but
> this is known perf optimization we use often in block storage drivers.

Let's see benchmark results. Otherwise this is just dead code that adds
complexity.

Stefan

--tlmjEO+SMhyWD/NG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmFSuoMACgkQnKSrs4Gr
c8jpCgf8CGJHEk5t5Yz49uW2kuVSk/IZC3Uk7tJ7zK+xNzn1d2lgfpCvVl0a0AdC
YxDeNMKrD5Oh+0AWZaOpenc0FMWZIC4gu85XGpyyxkbgcQWImQPTLNsR2l7ZlDsI
thxfw+TkrccTvpq/X6J28iiMxqLi2HEvUd8bTj/4QVUQJgYpDyc75YflbJtwgcIv
mmr8PBanK2J3O7AoNfPK+kARXD1/74w3p45z3iPLrnvFr79KgqEAH+34xSZCA2BJ
ohOfaQJ68mrHkshlcblnsNAk2LZWPU8yoUSh4Buf7LcEMEbxbCGEHdZtuOgARhNM
KxyuXSb7Q+TiRYQwAc6Sz2sSCqLFJg==
=cy+s
-----END PGP SIGNATURE-----

--tlmjEO+SMhyWD/NG--


--===============8389483731532564288==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============8389483731532564288==--

