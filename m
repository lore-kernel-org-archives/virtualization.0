Return-Path: <SRS0=We/I=EX=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 805E4C2D0E4
	for <virtualization@archiver.kernel.org>; Tue, 17 Nov 2020 11:23:20 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBCC6221F8
	for <virtualization@archiver.kernel.org>; Tue, 17 Nov 2020 11:23:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JUGpk64+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBCC6221F8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 2FF29870B2;
	Tue, 17 Nov 2020 11:23:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nxWAlbiap8qy; Tue, 17 Nov 2020 11:23:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 8C32887068;
	Tue, 17 Nov 2020 11:23:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6A6ACC0800;
	Tue, 17 Nov 2020 11:23:18 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 37371C07FF
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Nov 2020 11:23:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 281F38665B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Nov 2020 11:23:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fT0phd3afir1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Nov 2020 11:23:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 830EC86655
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Nov 2020 11:23:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1605612195;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dS7znSw5g8o6/lg1YdPszQ5ItVhBgNxvcUYvJULhaMY=;
 b=JUGpk64+rXvy+0eMAw99Z5VCE+2M0uKKImCxjudtjoUfjb+Im98Oou1bf9HbXHsd1FOIv2
 9Wh2w79AKQv7RlMGlmozNg9O4AzuQ+uURHWGWskcyQl9qXOlFmt+gwNGhDNcPj5jwN+KdQ
 M9Vb7GJH+NzZBdxuM5bJUdMPHLv73YQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-209-6aTCZUfEMembvr5360JvOA-1; Tue, 17 Nov 2020 06:23:11 -0500
X-MC-Unique: 6aTCZUfEMembvr5360JvOA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B8FC68030C5;
 Tue, 17 Nov 2020 11:23:09 +0000 (UTC)
Received: from localhost (ovpn-113-172.ams2.redhat.com [10.36.113.172])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 79BA419C78;
 Tue, 17 Nov 2020 11:23:06 +0000 (UTC)
Date: Tue, 17 Nov 2020 11:23:05 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH RFC 06/12] vdpa_sim: add struct vdpasim_device to store
 device properties
Message-ID: <20201117112305.GE131917@stefanha-x1.localdomain>
References: <20201113134712.69744-1-sgarzare@redhat.com>
 <20201113134712.69744-7-sgarzare@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201113134712.69744-7-sgarzare@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Laurent Vivier <lvivier@redhat.com>, Max Gurtovoy <mgurtovoy@nvidia.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, Eli Cohen <elic@nvidia.com>
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
Content-Type: multipart/mixed; boundary="===============8311155281100118431=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

--===============8311155281100118431==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="KuLpqunXa7jZSBt+"
Content-Disposition: inline

--KuLpqunXa7jZSBt+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 13, 2020 at 02:47:06PM +0100, Stefano Garzarella wrote:
> Move device properties used during the entire life cycle in a new
> structure to simplify the copy of these fields during the vdpasim
> initialization.
>=20
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
>  drivers/vdpa/vdpa_sim/vdpa_sim.h     | 17 ++++++++------
>  drivers/vdpa/vdpa_sim/vdpa_sim.c     | 33 ++++++++++++++--------------
>  drivers/vdpa/vdpa_sim/vdpa_sim_blk.c |  8 +++++--
>  drivers/vdpa/vdpa_sim/vdpa_sim_net.c |  9 +++++---
>  4 files changed, 38 insertions(+), 29 deletions(-)
>=20
> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.h b/drivers/vdpa/vdpa_sim/vdp=
a_sim.h
> index 6a1267c40d5e..76e642042eb0 100644
> --- a/drivers/vdpa/vdpa_sim/vdpa_sim.h
> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim.h
> @@ -40,12 +40,17 @@ struct vdpasim_virtqueue {
>  =09irqreturn_t (*cb)(void *data);
>  };
> =20
> +struct vdpasim_device {
> +=09u64 supported_features;
> +=09u32 id;
> +=09int nvqs;
> +};
> +
>  struct vdpasim_init_attr {
> -=09u32=09=09device_id;
> -=09u64=09=09features;
> +=09struct vdpasim_device device;

It's unclear to me what the exact purpose of struct vdpasim_device is.
At least the name reminds me of struct device, which this is not.

Should this be called just struct vdpasim_attr or struct
vdpasim_dev_attr? In other words, the attributes that are needed even
after intialization?

--KuLpqunXa7jZSBt+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl+zspkACgkQnKSrs4Gr
c8gFPwf9EKotDJQ7Se2GaXlaY0nCpGIeqdUBQaX5Et7tpXyDxXzsIKTYIfqAsqU1
Ww4kBfcM9jPqPjLZSdlMLdWqysoQ0teBSSNuCcb+uOC3O9N9c4eh3o7lO1SQpvya
OSfsYqw8bDmohwhxKYPTpjbM5fxcO7HiKrneufqBnSgJcubmQt7nJkCWNX+73r/g
xn4baxIxEAWEWFrBLeDtKfVBr/kk9dj6uXSMKMvWIwFibGN1b36n555O5sd8MenZ
iT4SJJuKdfQZE4vj743dAR7F8qyVYBHYyvEieRXZN4qAz5bEAPnmULAlYTzlJUh/
vpYRvzcmyXImaHN+a+uRHcG+7lJSEA==
=VNtu
-----END PGP SIGNATURE-----

--KuLpqunXa7jZSBt+--


--===============8311155281100118431==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============8311155281100118431==--

