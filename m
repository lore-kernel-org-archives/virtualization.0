Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60E72C3A5A7
	for <virtualization@archiver.kernel.org>; Tue,  6 Dec 2022 16:32:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C31DF81ED4;
	Tue,  6 Dec 2022 16:32:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C31DF81ED4
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=cevzQV2m
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iCBYxgrGiUsQ; Tue,  6 Dec 2022 16:32:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 525D381E90;
	Tue,  6 Dec 2022 16:31:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 525D381E90
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2679BC0033;
	Tue,  6 Dec 2022 16:31:59 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CF559C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Dec 2022 16:31:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B64A040463
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Dec 2022 16:31:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B64A040463
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=cevzQV2m
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sf_vBzxmO7iE
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Dec 2022 16:31:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9235840272
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9235840272
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Dec 2022 16:31:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1670344314;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=f7tva0QRnvY34jr6F4y3N6frBD9DljEnyo24Q5FToPc=;
 b=cevzQV2mJe6b3NN0XEKfXA6jRjnT8I3DAnZCkqY+KziuhFbdD9ruaNEPZ62cSeOPf5hIN1
 ISCEaPzpaoiQFR6El/IgU3tRQk1xBetu0ZxxZBHwNlxLAye+51jJIeTFQS+tyyK/UodWif
 TpOmXcP0kySruieQbyc7Eqms8rGu/qg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-297-NHrOxJHpO8e_BNKhHHWkEQ-1; Tue, 06 Dec 2022 11:31:49 -0500
X-MC-Unique: NHrOxJHpO8e_BNKhHHWkEQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B84DD86EB63;
 Tue,  6 Dec 2022 16:31:48 +0000 (UTC)
Received: from localhost (unknown [10.39.193.218])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 090482028CE4;
 Tue,  6 Dec 2022 16:31:47 +0000 (UTC)
Date: Tue, 6 Dec 2022 11:31:44 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Alvaro Karsz <alvaro.karsz@solid-run.com>
Subject: Re: [PATCH v3] virtio_blk: add VIRTIO_BLK_F_LIFETIME feature support
Message-ID: <Y49ucLGtCOtnbM0K@fedora>
References: <20221205162035.2261037-1-alvaro.karsz@solid-run.com>
MIME-Version: 1.0
In-Reply-To: <20221205162035.2261037-1-alvaro.karsz@solid-run.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Cc: Jens Axboe <axboe@kernel.dk>, linux-scsi@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, linux-nvme@lists.infradead.org,
 virtualization@lists.linux-foundation.org, linux-block@vger.kernel.org,
 dm-devel@redhat.com, Paolo Bonzini <pbonzini@redhat.com>
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
Content-Type: multipart/mixed; boundary="===============6903956285677146007=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>


--===============6903956285677146007==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Kf1ZFtRxkbtTQRVa"
Content-Disposition: inline


--Kf1ZFtRxkbtTQRVa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Dec 05, 2022 at 06:20:34PM +0200, Alvaro Karsz wrote:

I don't like that the ioctl lifetime struct is passed through
little-endian from the device to userspace. The point of this new ioctl
is not to be a passthrough interface. The kernel should define a proper
UABI struct for the ioctl and handle endianness conversion. But I think
Michael is happy with this approach, so nevermind.

> @@ -219,4 +247,8 @@ struct virtio_scsi_inhdr {
>  #define VIRTIO_BLK_S_OK		0
>  #define VIRTIO_BLK_S_IOERR	1
>  #define VIRTIO_BLK_S_UNSUPP	2
> +
> +/* Virtblk ioctl commands */
> +#define VBLK_GET_LIFETIME	_IOR('r', 0, struct virtio_blk_lifetime)

Does something include <linux/ioctl.h> for _IOR()? Failure to include
the necessary header file could break userspace applications that
include <linux/virtio_blk.h>.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--Kf1ZFtRxkbtTQRVa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmOPbnAACgkQnKSrs4Gr
c8iLOggAsIIn2qOsdq8S+xOJLEgfRN7/BoDt8YZ8CMsipVZs0G2Y6iVOhZFBNe98
W/edX+RVO5c7C8wPToA0QPqxO3hw7I/g6ztXeAm4KTx2mduzxQilJRDipEfpFOXV
OnW7IUGMedQPrwbMNqeT32QpFk/OVicOH/QguVDmQajXMIPUSvfBCnsSm8aHDl9p
YvADYVTPdoxJt3OTCGKXU7pfUwSC6/w8KVfxk3jnNKkuCDoEEeuCgkhyEc+CpGlo
i6z4bn23yupNn/d9CPROsEYRSB07OI8iAj7n6r1QMP2TG9+dOHgA4nnd0kcSWwYO
ZOnWHf2RJzEb34YNO5Bm0pio+X7vYQ==
=PdE9
-----END PGP SIGNATURE-----

--Kf1ZFtRxkbtTQRVa--


--===============6903956285677146007==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============6903956285677146007==--

