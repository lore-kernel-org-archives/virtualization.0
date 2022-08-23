Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB958C32772
	for <virtualization@archiver.kernel.org>; Tue, 23 Aug 2022 19:46:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3A86481A23;
	Tue, 23 Aug 2022 19:46:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3A86481A23
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=UkHrdL/J
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9vXssHVY9pV9; Tue, 23 Aug 2022 19:46:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id DBBB281951;
	Tue, 23 Aug 2022 19:46:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DBBB281951
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AE34BC0033;
	Tue, 23 Aug 2022 19:46:09 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0558AC002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Aug 2022 19:46:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id DB41B81A23
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Aug 2022 19:46:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DB41B81A23
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JTQ0YljjFqjU
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Aug 2022 19:46:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 21964819ED
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 21964819ED
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Aug 2022 19:46:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1661283965;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3u4ljWIPqWR+/WFCSoyP8zNBlYZo4PXquSCFtPsQPOE=;
 b=UkHrdL/J3GvlE0LfgcuQ4sWcALF4vJTwP9c40LOB/+rvlWYb5PAagkPV00EpWvwHXOfpFz
 9kROz/HmZU6G0FAWt60RoVCrW1Zg3yTSm4OIKcC/QDFSf9rzplQ4s3ADU4VQpwPe2NpbKM
 VvsuW3rnNllFgWvt3a4zylrYts2/ZXg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-423-WMAdbVQvPMynVgrZKTQa8A-1; Tue, 23 Aug 2022 15:46:03 -0400
X-MC-Unique: WMAdbVQvPMynVgrZKTQa8A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8D242185A79C;
 Tue, 23 Aug 2022 19:46:03 +0000 (UTC)
Received: from localhost (unknown [10.39.192.115])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E838A1121319;
 Tue, 23 Aug 2022 19:46:02 +0000 (UTC)
Date: Tue, 23 Aug 2022 15:46:01 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Alvaro Karsz <alvaro.karsz@solid-run.com>
Subject: Re: [PATCH] virtio_blk: add SECURE ERASE command support
Message-ID: <YwUueWHKi5YmQeGP@fedora>
References: <20220822162055.634854-1-alvaro.karsz@solid-run.com>
MIME-Version: 1.0
In-Reply-To: <20220822162055.634854-1-alvaro.karsz@solid-run.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
Cc: Jens Axboe <axboe@kernel.dk>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 virtualization@lists.linux-foundation.org
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
Content-Type: multipart/mixed; boundary="===============8567712829165505145=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>


--===============8567712829165505145==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="rDt2iadMPfQKvphy"
Content-Disposition: inline


--rDt2iadMPfQKvphy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 22, 2022 at 07:20:55PM +0300, Alvaro Karsz wrote:
> @@ -1075,6 +1079,12 @@ static int virtblk_probe(struct virtio_device *vde=
v)
>  		blk_queue_max_write_zeroes_sectors(q, v ? v : UINT_MAX);
>  	}
>=20
> +	if (virtio_has_feature(vdev, VIRTIO_BLK_F_SECURE_ERASE)) {
> +		virtio_cread(vdev, struct virtio_blk_config,
> +			     max_secure_erase_sectors, &v);
> +		blk_queue_max_secure_erase_sectors(q, v ? v : UINT_MAX);
> +	}

What about max_secure_erase_seg and secure_erase_sector_alignment?

--rDt2iadMPfQKvphy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmMFLngACgkQnKSrs4Gr
c8jNowf/dqstP/KUvD096BvNujMBTCTR7BtxMklXBRdeG9ERURFSBpd3ch1BGr7K
UsoSIlwZDcDt/kW8sapk/06g7IayWmZUl1tTd3llh7mPUFhtVVjEFDWkQBTsw6VB
HrekBZwCJ5EVq3RaGsFDVe0mlh6tlCzMq30pEc8UHWPOIuQX8Y/knU89NvojWr9V
SdEgivqMB5+leANrRNlroG7E62T+V3WjxxjnTpZ090/fkdde4od94jCk+PIYJo40
ZO9Azi5s+5tRBJUcKvs7MwhAvCh5JdcaGgOwzZ0fclbFFrtZMrBIobt0kIJ9VQ9Z
21FjF/F0Y+tDZwQYlUdyt9l/H9878g==
=6xAY
-----END PGP SIGNATURE-----

--rDt2iadMPfQKvphy--


--===============8567712829165505145==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============8567712829165505145==--

