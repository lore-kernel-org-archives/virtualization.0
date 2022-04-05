Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 446E3C433EF
	for <virtualization@archiver.kernel.org>; Tue,  5 Apr 2022 07:26:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id CD405400CE;
	Tue,  5 Apr 2022 07:26:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vnDcueJ75aAt; Tue,  5 Apr 2022 07:26:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 712BA40531;
	Tue,  5 Apr 2022 07:26:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 38921C001D;
	Tue,  5 Apr 2022 07:26:44 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 98F1AC0012
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Apr 2022 07:26:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 875F4823E0
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Apr 2022 07:26:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vNmlHCcPF7Lt
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Apr 2022 07:26:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C110E81360
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Apr 2022 07:26:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1649143599;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DtRKacOwwOeXGaBsH2DzeX8idyChR5dRn3lTIEka55E=;
 b=egvYv/0GbHgVilTTIa4O4iFxOHjGGXlOP2l0rflYeWWcR1SP/6Ytda2dJ6rJGVo4jLYo8j
 ozWJQFBjPrMISEogdiEwSAjU8M2qka2etCFgJthiPlNBc53FaX0d5BlWqEpzXMl1RG81mv
 CaihLDSRKgF34aWzP6lM0WaY48Xrx3s=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-132-qtmh9eRYPSGpAzNM5esJfg-1; Tue, 05 Apr 2022 03:26:36 -0400
X-MC-Unique: qtmh9eRYPSGpAzNM5esJfg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A17D7185A794;
 Tue,  5 Apr 2022 07:26:35 +0000 (UTC)
Received: from localhost (unknown [10.39.193.238])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 383D440E84E0;
 Tue,  5 Apr 2022 07:26:35 +0000 (UTC)
Date: Tue, 5 Apr 2022 08:26:34 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Suwan Kim <suwan.kim027@gmail.com>
Subject: Re: [PATCH v4 1/2] virtio-blk: support polling I/O
Message-ID: <YkvvKr9nCfza5KRa@stefanha-x1.localdomain>
References: <20220405053122.77626-1-suwan.kim027@gmail.com>
 <20220405053122.77626-2-suwan.kim027@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20220405053122.77626-2-suwan.kim027@gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
Cc: mgurtovoy@nvidia.com, mst@redhat.com,
 virtualization@lists.linux-foundation.org, linux-block@vger.kernel.org,
 pbonzini@redhat.com
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
Content-Type: multipart/mixed; boundary="===============0302413873292258832=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>


--===============0302413873292258832==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Jp8XQicBu+MZNkcI"
Content-Disposition: inline


--Jp8XQicBu+MZNkcI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 05, 2022 at 02:31:21PM +0900, Suwan Kim wrote:
> +static int virtblk_poll(struct blk_mq_hw_ctx *hctx, struct io_comp_batch=
 *iob)
> +{
> +	struct virtio_blk *vblk =3D hctx->queue->queuedata;
> +	struct virtio_blk_vq *vq =3D hctx->driver_data;
> +	struct virtblk_req *vbr;
> +	bool req_done =3D false;
> +	unsigned long flags;
> +	unsigned int len;
> +	int found =3D 0;
> +
> +	spin_lock_irqsave(&vq->lock, flags);
> +
> +	while ((vbr =3D virtqueue_get_buf(vq->vq, &len)) !=3D NULL) {
> +		struct request *req =3D blk_mq_rq_from_pdu(vbr);
> =20
> -	return blk_mq_virtio_map_queues(&set->map[HCTX_TYPE_DEFAULT],
> -					vblk->vdev, 0);
> +		found++;
> +		if (!blk_mq_add_to_batch(req, iob, vbr->status,
> +						virtblk_complete_batch))
> +			blk_mq_complete_request(req);
> +		req_done =3D true;
> +	}
> +
> +	if (req_done)

Minor nit: req_done can be replaced with found > 0.

> +		blk_mq_start_stopped_hw_queues(vblk->disk->queue, true);
> +
> +	spin_unlock_irqrestore(&vq->lock, flags);
> +
> +	return found;
> +}

--Jp8XQicBu+MZNkcI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEyBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmJL7yoACgkQnKSrs4Gr
c8jUsgf2JdI3U+9wOFUIjYhSgc6aLyfvp5Z/e/qlArMH91NRMqQYPdhVExmmJTsw
RTcidyru8K34V0PxslJOl1hqOQrO3GsIZ3x2H2uq00lc8rySclyLgWsToUst3Pew
Lc7DML09u6E/OaGBGhN7HY30kJlpE0oCdjDvmn7OdfA6i/fsFj8Ca8QlZARDuOGG
zcTvw97nbRJimZ76xnd9ApOrdjyk1s6d3RtbXfoehpL11UM7HDEWm45C5wAy6W0n
Dy3zYnG3j0BVhU+2Z48rZ+vUxZ6m7NhystgCiMYd4TqD0Z5kssY8jp7T1mpjSPre
hyns9kyCB1Aqx5fekBeHVDwfLh+T
=2Ve7
-----END PGP SIGNATURE-----

--Jp8XQicBu+MZNkcI--


--===============0302413873292258832==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============0302413873292258832==--

