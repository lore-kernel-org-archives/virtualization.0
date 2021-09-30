Return-Path: <SRS0=nfYb=OU=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0B0CC433EF
	for <virtualization@archiver.kernel.org>; Thu, 30 Sep 2021 13:17:24 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D07961507
	for <virtualization@archiver.kernel.org>; Thu, 30 Sep 2021 13:17:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6D07961507
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 138576076A;
	Thu, 30 Sep 2021 13:17:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Nv7iExacrhbj; Thu, 30 Sep 2021 13:17:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 5FC4E60724;
	Thu, 30 Sep 2021 13:17:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2EA33C0011;
	Thu, 30 Sep 2021 13:17:19 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 24874C000D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Sep 2021 13:17:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1F8FB40220
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Sep 2021 13:17:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IOXa5xywrkz5
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Sep 2021 13:17:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 47400400F0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Sep 2021 13:17:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1633007832;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ub2cuF6uoFeoONiyB+zLFzfZqc8TQZ4SekwA42Xxx5o=;
 b=Ou0gxUxVCd5Csj8aj+c0quDHgtp1aE0VFm4poCX2QwzukvMQJH0g61fCS7hJrWhYxdvKzg
 PJ0LZsC6DHULDGk8UZ2k/N8IA5uikcmmRSmJSNgKVmW6pCd6jfWcN1xpvSqKG2TtuxCqpx
 yqekV8YfBv2e31K42qYFvQLml1VWWq8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-116-ELitbxyHMQ6EYqaJ2AMj5Q-1; Thu, 30 Sep 2021 09:17:09 -0400
X-MC-Unique: ELitbxyHMQ6EYqaJ2AMj5Q-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C5857801B3D;
 Thu, 30 Sep 2021 13:17:07 +0000 (UTC)
Received: from localhost (unknown [10.39.195.132])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 245F860657;
 Thu, 30 Sep 2021 13:16:56 +0000 (UTC)
Date: Thu, 30 Sep 2021 14:16:56 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: Re: [PATCH 2/2] virtio-blk: set NUMA affinity for a tagset
Message-ID: <YVW4yIkWWEUMsBLp@stefanha-x1.localdomain>
References: <20210926145518.64164-1-mgurtovoy@nvidia.com>
 <20210926145518.64164-2-mgurtovoy@nvidia.com>
 <YVF8RBZSaJs9BScd@stefanha-x1.localdomain>
 <21295187-41c4-5fb6-21c3-28004eb7c5d8@nvidia.com>
 <YVK6hdcrXwQHrXQ9@stefanha-x1.localdomain>
 <f15e1115-25c1-5b9a-223c-db122251d4c1@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <f15e1115-25c1-5b9a-223c-db122251d4c1@nvidia.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
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
Content-Type: multipart/mixed; boundary="===============2634452694434203457=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>


--===============2634452694434203457==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="IKMqPhUCzPj7W18T"
Content-Disposition: inline


--IKMqPhUCzPj7W18T
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 29, 2021 at 06:07:52PM +0300, Max Gurtovoy wrote:
>=20
> On 9/28/2021 9:47 AM, Stefan Hajnoczi wrote:
> > On Mon, Sep 27, 2021 at 08:39:30PM +0300, Max Gurtovoy wrote:
> > > On 9/27/2021 11:09 AM, Stefan Hajnoczi wrote:
> > > > On Sun, Sep 26, 2021 at 05:55:18PM +0300, Max Gurtovoy wrote:
> > > > > To optimize performance, set the affinity of the block device tag=
set
> > > > > according to the virtio device affinity.
> > > > >=20
> > > > > Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> > > > > ---
> > > > >    drivers/block/virtio_blk.c | 2 +-
> > > > >    1 file changed, 1 insertion(+), 1 deletion(-)
> > > > >=20
> > > > > diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_bl=
k.c
> > > > > index 9b3bd083b411..1c68c3e0ebf9 100644
> > > > > --- a/drivers/block/virtio_blk.c
> > > > > +++ b/drivers/block/virtio_blk.c
> > > > > @@ -774,7 +774,7 @@ static int virtblk_probe(struct virtio_device=
 *vdev)
> > > > >    	memset(&vblk->tag_set, 0, sizeof(vblk->tag_set));
> > > > >    	vblk->tag_set.ops =3D &virtio_mq_ops;
> > > > >    	vblk->tag_set.queue_depth =3D queue_depth;
> > > > > -	vblk->tag_set.numa_node =3D NUMA_NO_NODE;
> > > > > +	vblk->tag_set.numa_node =3D virtio_dev_to_node(vdev);
> > > > >    	vblk->tag_set.flags =3D BLK_MQ_F_SHOULD_MERGE;
> > > > >    	vblk->tag_set.cmd_size =3D
> > > > >    		sizeof(struct virtblk_req) +
> > > > I implemented NUMA affinity in the past and could not demonstrate a
> > > > performance improvement:
> > > > https://lists.linuxfoundation.org/pipermail/virtualization/2020-Jun=
e/048248.html
> > > >=20
> > > > The pathological case is when a guest with vNUMA has the virtio-blk=
-pci
> > > > device on the "wrong" host NUMA node. Then memory accesses should c=
ross
> > > > NUMA nodes. Still, it didn't seem to matter.
> > > I think the reason you didn't see any improvement is since you didn't=
 use
> > > the right device for the node query. See my patch 1/2.
> > That doesn't seem to be the case. Please see
> > drivers/base/core.c:device_add():
> >=20
> >    /* use parent numa_node */
> >    if (parent && (dev_to_node(dev) =3D=3D NUMA_NO_NODE))
> >            set_dev_node(dev, dev_to_node(parent));
> >=20
> > IMO it's cleaner to use dev_to_node(&vdev->dev) than to directly access
> > the parent.
> >=20
> > Have I missed something?
>=20
> but dev_to_node(dev) is 0 IMO.
>=20
> who set it to NUMA_NO_NODE ?

drivers/virtio/virtio.c:register_virtio_device():

  device_initialize(&dev->dev);

drivers/base/core.c:device_initialize():

  set_dev_node(dev, -1);

Stefan

--IKMqPhUCzPj7W18T
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmFVuMgACgkQnKSrs4Gr
c8ie0AgAk1gREryODkpkpku94YvDaPnLrUsaDjpYIUT5SIDf1VzYzzYFQF6Gqv90
6xfbA76qc9yVtFEs3WY/pCeCasVX2AHrTrqyu6aacIrmMtHgE6ha5Qroyik0KJe9
0E2LIcjMCB/D6zOQCGPmNeaYJzczdKYf2S7e0Sjf6u5ziDMaOMnJilZYXEJBcOll
urEzjQhWuqwBX1NVYOk4pc9+Twvboo5L++7au82DPa/h92vYx7q+UeLFEjrp/lbd
OssLss9CMFMMVoR27LL45I11W/4EnRjDslkkARKLXJeUevxUYyIdQDLy9bZTN4tX
7+5a0eDo2g4nVGAS+tUJ2Et0x0u2HA==
=/Lgo
-----END PGP SIGNATURE-----

--IKMqPhUCzPj7W18T--


--===============2634452694434203457==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============2634452694434203457==--

