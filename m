Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94D60C32793
	for <virtualization@archiver.kernel.org>; Tue, 23 Aug 2022 20:57:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 0E660405E5;
	Tue, 23 Aug 2022 20:57:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0E660405E5
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WKAL+llh
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iKEQACth32DG; Tue, 23 Aug 2022 20:57:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 827874012B;
	Tue, 23 Aug 2022 20:56:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 827874012B
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3D85DC0032;
	Tue, 23 Aug 2022 20:56:59 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7A74BC002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Aug 2022 20:56:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4E07860B35
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Aug 2022 20:56:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4E07860B35
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=WKAL+llh
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XDZTq2ty40Kk
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Aug 2022 20:56:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1817360B11
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1817360B11
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Aug 2022 20:56:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1661288213;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=G6GpA8BrAqKd3EaQ4iUJ+jQPbV5hdMrDQRA6EhvsCCY=;
 b=WKAL+llhcWkmjpbK87MwN2ZQKZVxGjh1cvHlV9G+OfSO65Jn+CMIGq9Pu8AwLF5Mc/sdRR
 VYWkPU0PjyGsuQpN7Y0RV0Y4NYBBqvugG2ai/n7gWnHU6CZXiW28RID4xKKXbKqCcnP8n/
 NWZ12DUjZ9oMNw69RsvJdR8psaN3jfU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-170-1CUsF1F-OmWakf1N3rcxUQ-1; Tue, 23 Aug 2022 16:56:51 -0400
X-MC-Unique: 1CUsF1F-OmWakf1N3rcxUQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 669C0803301;
 Tue, 23 Aug 2022 20:56:51 +0000 (UTC)
Received: from localhost (unknown [10.39.192.115])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CC9541121315;
 Tue, 23 Aug 2022 20:56:50 +0000 (UTC)
Date: Tue, 23 Aug 2022 16:56:49 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Suwan Kim <suwan.kim027@gmail.com>
Subject: Re: [PATCH] virtio-blk: Fix WARN_ON_ONCE in virtio_queue_rq()
Message-ID: <YwU/EVxT0a6q2BfD@fedora>
References: <20220823145005.26356-1-suwan.kim027@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20220823145005.26356-1-suwan.kim027@gmail.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
Cc: acourbot@chromium.org, mst@redhat.com,
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
Content-Type: multipart/mixed; boundary="===============1671952298563865814=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>


--===============1671952298563865814==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Im5Dzx+o78egGwqe"
Content-Disposition: inline


--Im5Dzx+o78egGwqe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 23, 2022 at 11:50:05PM +0900, Suwan Kim wrote:
> @@ -409,6 +409,8 @@ static bool virtblk_add_req_batch(struct virtio_blk_vq *vq,
>  			virtblk_unmap_data(req, vbr);
>  			virtblk_cleanup_cmd(req);
>  			rq_list_add(requeue_list, req);
> +		} else {
> +			blk_mq_start_request(req);
>  		}

The device may see new requests as soon as virtblk_add_req() is called
above. Therefore the device may complete the request before
blk_mq_start_request() is called.

rq->io_start_time_ns = ktime_get_ns() will be after the request was
actually submitted.

I think blk_mq_start_request() needs to be called before
virtblk_add_req().

Stefan

--Im5Dzx+o78egGwqe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmMFPxAACgkQnKSrs4Gr
c8jiqQf/dQaaWu+Y3F9hESOhMyKVdRc88dF4/wgzl4PX7S/aBvAK18a2kq3Fd+yx
zf5E5zf18bPIdOMiEUwW4KsezYZlQZYArev/xuzEUDFnKKTKg7eJhAJ0w3xPH/Bu
19ZQ4rR/8a3WJlJYcAHS0bZEHZN11GdFo3wobbzcy43kNuOf45PTJISe/SaWLRrj
k+qCF1ocbxGxo5RZeRHDXZGtYFDa0OQjMKJToNT9umZN8kPQaiC7YAutYD81r+Jl
fSjEZtlIwAIZJgx3F2oCrqSopAQ34jYQgkpUCUnOgsblL2XW95l/V5wJ5lxrVolT
ljH3Tr5GPLqKzHmJ8+5XoGJVop0lpA==
=cybs
-----END PGP SIGNATURE-----

--Im5Dzx+o78egGwqe--


--===============1671952298563865814==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============1671952298563865814==--

