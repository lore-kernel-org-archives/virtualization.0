Return-Path: <SRS0=EgWE=L6=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A6ADC07E96
	for <virtualization@archiver.kernel.org>; Tue,  6 Jul 2021 13:16:54 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC56E6192B
	for <virtualization@archiver.kernel.org>; Tue,  6 Jul 2021 13:16:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC56E6192B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A84E2605D5;
	Tue,  6 Jul 2021 13:16:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7mbdRfiwkpPW; Tue,  6 Jul 2021 13:16:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id E33296059D;
	Tue,  6 Jul 2021 13:16:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BC514C0010;
	Tue,  6 Jul 2021 13:16:51 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 73E7CC000E
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Jul 2021 13:16:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E2F3C82ECF
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Jul 2021 13:14:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WVOKdcby8ds7
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Jul 2021 13:14:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id AA210839E5
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Jul 2021 13:14:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1625577257;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=A+vURWiwExzHKQ1zqn329GpoJ8uorhaLWw889D3KLCk=;
 b=DdhISsDmqFxYpwO5yBG7fob0cpK7FQ7/65EDlr7eka7+bN/s6kxJk0osoOOH2lk1dyE+Kz
 mmgk7La+dS9CvanJEN4BsnXlgBRHKBKpLFpxtIbBOXGc0uxmXSu2l6G7jxaeLkoIxvOa1M
 dB8lhOfreEry1su4Iqzvq7j5/AM7eWw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-382-Rm8scm4zMfycpyJd6ld4yQ-1; Tue, 06 Jul 2021 09:14:15 -0400
X-MC-Unique: Rm8scm4zMfycpyJd6ld4yQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 90CE7824F98;
 Tue,  6 Jul 2021 13:14:14 +0000 (UTC)
Received: from localhost (ovpn-115-23.ams2.redhat.com [10.36.115.23])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7F3BF5DA60;
 Tue,  6 Jul 2021 13:14:10 +0000 (UTC)
Date: Tue, 6 Jul 2021 14:14:09 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH 1/2] vdpa: support per virtqueue max queue size
Message-ID: <YORXIS+WmDkX2DN7@stefanha-x1.localdomain>
References: <20210705071910.31965-1-jasowang@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20210705071910.31965-1-jasowang@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Cc: kvm@vger.kernel.org, mst@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 xieyongji@bytedance.com
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
Content-Type: multipart/mixed; boundary="===============4069386633925357938=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>


--===============4069386633925357938==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="LaXrVM2vNYxuaCd2"
Content-Disposition: inline


--LaXrVM2vNYxuaCd2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 05, 2021 at 03:19:09PM +0800, Jason Wang wrote:
> Virtio spec allows the device to specify the per virtqueue max queue
> size. vDPA needs to adapt to this flexibility. E.g Qemu advertise a
> small control virtqueue for virtio-net.
>=20
> So this patch adds a index parameter to get_vq_num_max bus operations
> for the device to report its per virtqueue max queue size.
>=20
> Both VHOST_VDPA_GET_VRING_NUM and VDPA_ATTR_DEV_MAX_VQ_SIZE assume a
> global maximum size. So we iterate all the virtqueues to return the
> minimal size in this case. Actually, the VHOST_VDPA_GET_VRING_NUM is
> not a must for the userspace. Userspace may choose to check the
> VHOST_SET_VRING_NUM for proving or validating the maximum virtqueue
> size. Anyway, we can invent a per vq version of
> VHOST_VDPA_GET_VRING_NUM in the future if it's necessary.
>=20
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  drivers/vdpa/ifcvf/ifcvf_main.c   |  2 +-
>  drivers/vdpa/mlx5/net/mlx5_vnet.c |  2 +-
>  drivers/vdpa/vdpa.c               | 22 +++++++++++++++++++++-
>  drivers/vdpa/vdpa_sim/vdpa_sim.c  |  2 +-
>  drivers/vdpa/virtio_pci/vp_vdpa.c |  2 +-
>  drivers/vhost/vdpa.c              |  9 ++++++---
>  drivers/virtio/virtio_vdpa.c      |  2 +-
>  include/linux/vdpa.h              |  5 ++++-
>  8 files changed, 36 insertions(+), 10 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--LaXrVM2vNYxuaCd2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmDkVyEACgkQnKSrs4Gr
c8hTKggAp8tSQbbf8/pQa6Bi9ldcTpa4FzjzvITQFELFg45XJ9q4WDx+eNMxRTpe
IuvanLQoWiiQL2pYcUZCi/+PCGsj+bu44yJ24Uk9/cIWUbg+s8T+GLMxaNdEP8WO
52McfMT5MK+waHfnbhZ2jaNEGAdo5EVRBIF1Q/7vdg9Lfr0YxRtVuZ6EVuuncW5y
jETFKnKb0YdHpbO//gK/a7L6jLJEABTm0QQNK9OZnxnlbEuduUfeu8saUZSdDbWL
G/7TR55TF+CFd27T7gTA7WLcQszFk1tg1fTbdnDUpU/588L6Gy5+6CoCb+5+a6Ts
vdBRToz2iTg0KTFP/gYhTTQcxq7wmA==
=eXQg
-----END PGP SIGNATURE-----

--LaXrVM2vNYxuaCd2--


--===============4069386633925357938==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============4069386633925357938==--

