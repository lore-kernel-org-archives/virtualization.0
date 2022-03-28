Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7F63C433FE
	for <virtualization@archiver.kernel.org>; Mon, 28 Mar 2022 12:53:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 68E2E812D2;
	Mon, 28 Mar 2022 12:53:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wka2wNLxmoft; Mon, 28 Mar 2022 12:53:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 097E080D47;
	Mon, 28 Mar 2022 12:53:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BD818C002C;
	Mon, 28 Mar 2022 12:53:55 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E143BC0012
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Mar 2022 12:53:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D78AF404B4
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Mar 2022 12:53:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SSwX_Qu_9Z43
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Mar 2022 12:53:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D53B340256
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Mar 2022 12:53:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1648472032;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TdwCaDfr9K+hu3WbN7jI8cLlRDd47eNsiR4Sba462b4=;
 b=QWmhp6YcHmduB5oxUGwrau8tyPzYL06jqs+auZjZkilBIyptTygRnI2IfFW4eEkGJUpDod
 vf3rFMwD1d3AUdljtWbIO7fqi1GdJVB/o9Cz43MehBoWl19wI/6bWYO694pcASO8aikyGk
 uPZ8Z3W4uNcW/d16ZkVhMTn3UeS42Cw=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-611-6swNG_40PFOPn6bvpqg2hg-1; Mon, 28 Mar 2022 08:53:48 -0400
X-MC-Unique: 6swNG_40PFOPn6bvpqg2hg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 811292A5957C;
 Mon, 28 Mar 2022 12:53:48 +0000 (UTC)
Received: from localhost (unknown [10.39.193.150])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 18D6E401E90;
 Mon, 28 Mar 2022 12:53:47 +0000 (UTC)
Date: Mon, 28 Mar 2022 13:53:46 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Suwan Kim <suwan.kim027@gmail.com>
Subject: Re: [PATCH v3 1/2] virtio-blk: support polling I/O
Message-ID: <YkGv2nr6m1MRSYxp@stefanha-x1.localdomain>
References: <20220324140450.33148-1-suwan.kim027@gmail.com>
 <20220324140450.33148-2-suwan.kim027@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20220324140450.33148-2-suwan.kim027@gmail.com>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
Cc: mgurtovoy@nvidia.com, kernel test robot <lkp@intel.com>, mst@redhat.com,
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
Content-Type: multipart/mixed; boundary="===============2180752883893657297=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>


--===============2180752883893657297==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="TYRIV01iPK60gbwJ"
Content-Disposition: inline


--TYRIV01iPK60gbwJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 24, 2022 at 11:04:49PM +0900, Suwan Kim wrote:
> +static int virtblk_poll(struct blk_mq_hw_ctx *hctx, struct io_comp_batch *iob)
> +{
> +	struct virtio_blk_vq *vq = hctx->driver_data;
> +	struct virtblk_req *vbr;
> +	unsigned long flags;
> +	unsigned int len;
> +	int found = 0;
> +
> +	spin_lock_irqsave(&vq->lock, flags);
> +
> +	while ((vbr = virtqueue_get_buf(vq->vq, &len)) != NULL) {
> +		struct request *req = blk_mq_rq_from_pdu(vbr);
> +
> +		found++;
> +		if (!blk_mq_add_to_batch(req, iob, vbr->status,
> +						virtblk_complete_batch))
> +			blk_mq_complete_request(req);
> +	}
> +
> +	spin_unlock_irqrestore(&vq->lock, flags);

virtblk_done() does:

  /* In case queue is stopped waiting for more buffers. */
  if (req_done)
          blk_mq_start_stopped_hw_queues(vblk->disk->queue, true);

Is the same thing needed here in virtblk_poll() so that stopped queues
are restarted when requests complete?

--TYRIV01iPK60gbwJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmJBr9oACgkQnKSrs4Gr
c8hWfwgAuQ9YkkOXR5H2TaQu4QFnMKnl8lNqsfKs5GgbaGfHAsPQ8E5eehq5UUK9
12Yy2w93uSpvqIvIAX5hS3zm8YzdCV2/6sCBLBSV10i+dIonXhg0Rq49H7551Fxo
W3NVwYx8GiXatwdrm69E9VrG3sy5ikONj5TprR5chJLfX+ptGAHTGL/+pPoztqFG
L1OQmvR61aM+R/eKq5SHZ1fltRViANQjGLVs0kYJ2qtyJ5MUdRpaXJdufL/t4CZG
8g9ZAInTSZ8h6zkkEcJuPM/vhbZ3QzTfCIsUKffldqYcgn/46j9mp+FIq5k948SB
xlqD4s0/K5uldLFvO18hn0ve6WSiSA==
=AmVf
-----END PGP SIGNATURE-----

--TYRIV01iPK60gbwJ--


--===============2180752883893657297==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============2180752883893657297==--

