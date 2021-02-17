Return-Path: <SRS0=bBcF=HT=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B934FC433E0
	for <virtualization@archiver.kernel.org>; Wed, 17 Feb 2021 12:41:56 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 502C764D92
	for <virtualization@archiver.kernel.org>; Wed, 17 Feb 2021 12:41:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 502C764D92
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0C8E46F608
	for <virtualization@archiver.kernel.org>; Wed, 17 Feb 2021 12:41:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NiGmEOOWmxHW for <virtualization@archiver.kernel.org>;
	Wed, 17 Feb 2021 12:41:55 +0000 (UTC)
Received: by smtp3.osuosl.org (Postfix, from userid 1001)
	id A17636F594; Wed, 17 Feb 2021 12:41:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 64D7E6F4BC;
	Wed, 17 Feb 2021 12:41:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 42149C0174;
	Wed, 17 Feb 2021 12:41:50 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0641AC013A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 Feb 2021 12:41:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id E7F9A86088
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 Feb 2021 12:41:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MhkAtg_CRO6D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 Feb 2021 12:41:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 6267C85FB9
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 Feb 2021 12:41:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1613565706;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=o7pHnryK4vudTBjeC8f619X85eskd6tV+DbXH60fnEw=;
 b=V7rapIAy80DO0wenAmOFZWIWBky5BVEwddcSQT3oGIsqN1hIfgOL+gaw64NxcIt7UJiQDX
 cSYglp0Uk0izaTPKC3t7mClXctctAHrBpNUYCtQ27mL6yw56FqSWAPh1JSbDCvQI8I1HLV
 Pc9YJofsa7PhttsrmquJOTkaiVQN1l8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-446-0GUgyPcyPuuw-vrWj6oRWg-1; Wed, 17 Feb 2021 07:41:42 -0500
X-MC-Unique: 0GUgyPcyPuuw-vrWj6oRWg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ED15191276;
 Wed, 17 Feb 2021 12:41:40 +0000 (UTC)
Received: from localhost (ovpn-115-102.ams2.redhat.com [10.36.115.102])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 128B018B5E;
 Wed, 17 Feb 2021 12:41:35 +0000 (UTC)
Date: Wed, 17 Feb 2021 12:41:34 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>
Subject: Re: [RFC v2 2/7] virtio: Add virtio_queue_host_notifier_status
Message-ID: <20210217124134.GD269203@stefanha-x1.localdomain>
References: <20210209153757.1653598-1-eperezma@redhat.com>
 <20210209153757.1653598-3-eperezma@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20210209153757.1653598-3-eperezma@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Rob Miller <rob.miller@broadcom.com>, Parav Pandit <parav@mellanox.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Harpreet Singh Anand <hanand@xilinx.com>, Xiao W Wang <xiao.w.wang@intel.com>,
 Eli Cohen <eli@mellanox.com>, virtualization@lists.linux-foundation.org,
 Eric Blake <eblake@redhat.com>, Michael Lilja <ml@napatech.com>,
 Jim Harford <jim.harford@broadcom.com>
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
Content-Type: multipart/mixed; boundary="===============7845063742910751000=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

--===============7845063742910751000==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="sXc4Kmr5FA7axrvy"
Content-Disposition: inline

--sXc4Kmr5FA7axrvy
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 09, 2021 at 04:37:52PM +0100, Eugenio P=E9rez wrote:
> This allows shadow virtqueue code to assert the queue status before
> making changes.
>=20
> Signed-off-by: Eugenio P=E9rez <eperezma@redhat.com>
> ---
>  include/hw/virtio/virtio.h | 1 +
>  hw/virtio/virtio.c         | 5 +++++
>  2 files changed, 6 insertions(+)
>=20
> diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
> index b7ece7a6a8..227cec13a8 100644
> --- a/include/hw/virtio/virtio.h
> +++ b/include/hw/virtio/virtio.h
> @@ -316,6 +316,7 @@ void virtio_device_release_ioeventfd(VirtIODevice *vd=
ev);
>  bool virtio_device_ioeventfd_enabled(VirtIODevice *vdev);
>  EventNotifier *virtio_queue_get_host_notifier(VirtQueue *vq);
>  void virtio_queue_set_host_notifier_enabled(VirtQueue *vq, bool enabled)=
;
> +bool virtio_queue_host_notifier_status(const VirtQueue *vq);
>  void virtio_queue_host_notifier_read(EventNotifier *n);
>  void virtio_queue_aio_set_host_notifier_handler(VirtQueue *vq, AioContex=
t *ctx,
>                                                  VirtIOHandleAIOOutput ha=
ndle_output);
> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> index 1fd1917ca0..53473ae4df 100644
> --- a/hw/virtio/virtio.c
> +++ b/hw/virtio/virtio.c
> @@ -3594,6 +3594,11 @@ EventNotifier *virtio_queue_get_host_notifier(Virt=
Queue *vq)
>      return &vq->host_notifier;
>  }
> =20
> +bool virtio_queue_host_notifier_status(const VirtQueue *vq)
> +{
> +    return vq->host_notifier_enabled;
> +}
> +
>  void virtio_queue_set_host_notifier_enabled(VirtQueue *vq, bool enabled)

Since there is a virtio_queue_set_host_notifier_enabled() I suggest
calling this function virtio_queue_is_host_notifier_enabled() or
virtio_queue_get_host_notifier_enabled(). That way it's clear they
set/get the same thing.

Stefan

--sXc4Kmr5FA7axrvy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmAtDv4ACgkQnKSrs4Gr
c8jhrAgAlJQwWJbQYjx47mMJ+bFY4vIRCvNQ3f/HF9peIeT8o5se2dn0Gz+VOEr9
1tu8Jf+TzFZgbQ2W8aEoErRF2i02lVU/eMKdnyunQzg6tZR5JFx2Cbepb6P4Dg+t
yTL9xjzsJCJpBEeZfURzv7FE/CXDz3U/noLZMr1dlQOPqzYGmQbBnHoCt39dLNHK
u73peJWPVrU1pK/u/dNWvGXswN9zjYS/aLTPlqEZ1Dwm1A7gZy6sYm5JuJnocEtr
3fKfBNpa25P9RjK5U1Zr6rK/dI9vYNjgA6KeN1Ue7oioBmNG6E1dA+TUhrhChIw+
SCmXF2F/cfDF4O45jaymVRW4pGqSoA==
=iuaX
-----END PGP SIGNATURE-----

--sXc4Kmr5FA7axrvy--


--===============7845063742910751000==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============7845063742910751000==--

