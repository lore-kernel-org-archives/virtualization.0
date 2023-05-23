Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 271D6C7EE26
	for <virtualization@archiver.kernel.org>; Tue, 23 May 2023 21:03:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 986B64016F;
	Tue, 23 May 2023 21:03:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 986B64016F
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=GlTsGQ9D
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5dSprIC0r3zQ; Tue, 23 May 2023 21:03:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 10D1841DA4;
	Tue, 23 May 2023 21:03:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 10D1841DA4
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CE037C0036;
	Tue, 23 May 2023 21:03:51 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 581E7C002A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 May 2023 21:03:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 20FF74016F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 May 2023 21:03:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 20FF74016F
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wrHVrO7YiJso
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 May 2023 21:03:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 60FD941DA4
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 60FD941DA4
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 May 2023 21:03:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684875828;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dDfzDTi3bvLYMGRSQ2aUta3Popi1PlcNquIJQrs4Los=;
 b=GlTsGQ9Djj88YmB5SMGPLzfSrcNdRCtjEp9ggnWaftgGWaXID2akcObhmP42kHmRsZ48cF
 sH95dX/HqYHE/jxKGkYwtcdRdJQALIfpiI2qEePKIrBIwYkPE7FoQtBOKKKU4q53GEu/U7
 OS8TeOeMWya5+OsB8K48WGt3bHP1QUc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-140-9p2KsFM-MD-6K4o0n8nsGg-1; Tue, 23 May 2023 17:03:44 -0400
X-MC-Unique: 9p2KsFM-MD-6K4o0n8nsGg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A0D7585A5AA;
 Tue, 23 May 2023 21:03:43 +0000 (UTC)
Received: from localhost (unknown [10.39.192.61])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 98456492B00;
 Tue, 23 May 2023 21:03:42 +0000 (UTC)
Date: Tue, 23 May 2023 17:03:35 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Peter-Jan Gootzen <peter-jan@gootzen.net>
Subject: Re: [PATCH] virtio-fs: Improved request latencies when Virtio queue
 is full
Message-ID: <20230523210335.GA141797@fedora>
References: <20230522131915.114534-1-peter-jan@gootzen.net>
MIME-Version: 1.0
In-Reply-To: <20230522131915.114534-1-peter-jan@gootzen.net>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Cc: miklos@szeredi.hu, vgoyal@redhat.com,
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
Content-Type: multipart/mixed; boundary="===============1199237978471684012=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>


--===============1199237978471684012==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="557lsgXCVjWg7/iP"
Content-Disposition: inline


--557lsgXCVjWg7/iP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 22, 2023 at 03:19:15PM +0200, Peter-Jan Gootzen wrote:
> When the Virtio queue is full, a work item is scheduled
> to execute in 1ms that retries adding the request to the queue.
> This is a large amount of time on the scale on which a
> virtio-fs device can operate. When using a DPU this is around
> 40us baseline without going to a remote server (4k, QD=3D1).
> This patch queues requests when the Virtio queue is full,
> and when a completed request is taken off, immediately fills
> it back up with queued requests.
>=20
> This reduces the 99.9th percentile latencies in our tests by
> 60x and slightly increases the overall throughput, when using a
> queue depth 2x the size of the Virtio queue size, with a
> DPU-powered virtio-fs device.
>=20
> Signed-off-by: Peter-Jan Gootzen <peter-jan@gootzen.net>
> ---
>  fs/fuse/virtio_fs.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
>=20
> diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
> index 4d8d4f16c727..8af9d3dc61d3 100644
> --- a/fs/fuse/virtio_fs.c
> +++ b/fs/fuse/virtio_fs.c
> @@ -347,6 +347,8 @@ static void virtio_fs_hiprio_done_work(struct work_st=
ruct *work)
>  		}
>  	} while (!virtqueue_enable_cb(vq) && likely(!virtqueue_is_broken(vq)));
>  	spin_unlock(&fsvq->lock);
> +
> +	schedule_delayed_work(&fsvq->dispatch_work, 0);

This avoids scheduling work when there is nothing queued and uses
schedule_work() since there is no timeout value:

  if (!list_empty(&fsvq->queued_reqs)) {
      schedule_work(&fsvq->dispatch_work);
  }
  spin_unlock(&fsvq->lock);

--557lsgXCVjWg7/iP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmRtKicACgkQnKSrs4Gr
c8jY/wgAhjjhgWP2hLT+OseMLTR9zRCSxrW/p/3pb2SzT+pMw28ZjXiQiQSJpqO9
hPRaaAdj8yCM0DrhzF8ssxw5g/AzH40gnGXslBzzCXPcvqkEew/woRJfA5uKzB9O
Nvgr4CBG3VX6maQVm8+UroUyAs8CqDPdWyayU7KZQJ4S59ErVKimOECPR3hobJpc
6debKmLxI6m+vVa8gGaDBIVd6h2yrrdULYd0toYvNTfm4g57gGee8iPhFOH0E3Ip
s2K1q9p/E6VeokjmGU9HHQFTmWk+N03MTRtS92uOzsdv2wlVmSisMLfnG6eQ6Dpt
aA3D+Y1Rv/CbKmYih8N+J0q9deV2Rw==
=O6HK
-----END PGP SIGNATURE-----

--557lsgXCVjWg7/iP--


--===============1199237978471684012==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============1199237978471684012==--

