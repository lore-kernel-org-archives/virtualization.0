Return-Path: <SRS0=Keeg=BP=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04262C433DF
	for <virtualization@archiver.kernel.org>; Wed,  5 Aug 2020 13:44:53 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD3A12065C
	for <virtualization@archiver.kernel.org>; Wed,  5 Aug 2020 13:44:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WntcZhYi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD3A12065C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 9659D868AF;
	Wed,  5 Aug 2020 13:44:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AnMtN2Rs8fz3; Wed,  5 Aug 2020 13:44:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 25493868B4;
	Wed,  5 Aug 2020 13:44:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 03AE3C0051;
	Wed,  5 Aug 2020 13:44:52 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B2858C004C
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Aug 2020 13:44:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id AF1A42268C
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Aug 2020 13:44:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dfSMCub3JxUj
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Aug 2020 13:44:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-1.mimecast.com
 [207.211.31.81])
 by silver.osuosl.org (Postfix) with ESMTPS id 6E3D9214FD
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Aug 2020 13:44:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596635088;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PnsUzUfj/maYqHomtkyX8zOTJsr1HA4XmfpAedp5w54=;
 b=WntcZhYiTHY8iT9Qh7t1mAblXb4b/PXdYNNdyuP4NvcxSZK67MMyWYKMiL/RnyvYFKUW+c
 xnH0Z92+RKzMvr+xPBitDDgSTZ5vDIG81/NqZ2FKwAwdRBKO9FVxJ1MTXFrS4KXZdQ6NT7
 VoiXi9hFsp/2XUU2NgFTuUqojn/NCmY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-481-Oztdw6A5MRiTl4ZbRFzhDA-1; Wed, 05 Aug 2020 09:44:46 -0400
X-MC-Unique: Oztdw6A5MRiTl4ZbRFzhDA-1
Received: by mail-wr1-f72.google.com with SMTP id k11so13088416wrv.1
 for <virtualization@lists.linux-foundation.org>;
 Wed, 05 Aug 2020 06:44:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=PnsUzUfj/maYqHomtkyX8zOTJsr1HA4XmfpAedp5w54=;
 b=mHtcaLpqtW1QWCMI4haPdWQt0ZH9tkw20VHRRGhLzukvCUSj2fZiLoAxAYV0W/l4uc
 hGAGy7qr8DQJIBkEsmCIgty3596vGxkH7cEFhIKy8yVbeqBr0my67m8qXA6+ciEtAELd
 nQ/K/gu3x+FAIzfpTazYWbuBnkghjzrl30wrNuuqtcnJVAFml1xkbKlMLB0pXREa1b/m
 AjZf5Ql/GE18t27kV6aPtyD++uOf6kP01cTbtUqBfgBwodW5Mznm0Bv+e2H1XtTpDFvX
 vSI8pJ3DTzgj7izwJI5iYIeGwC1bZlFV/VEPpKkeE3TQ7ZpgmeNVyS/IJoxROxvDW6Ha
 LY9g==
X-Gm-Message-State: AOAM531nhkyS6cOTT2ehexnylQc5SIibQXhjwXy4+Iic15jJFC73G3VT
 i0np0UFc2avMOiyqnpxEH6/YvVEA3PnZXI8MnZT5mqHyxnvbVsrcR30AnCGfKTt43NdA9jVR0+p
 YR2AJqXgFma5C8dFX8Sr1ZANP3F9XZv2IZfSZePfxkw==
X-Received: by 2002:a7b:ce83:: with SMTP id q3mr3330206wmj.5.1596635085325;
 Wed, 05 Aug 2020 06:44:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxspf2A9DeJp/XDd6wXksBjAJ9F8IN1IMgFckmDgI4O8zQGWyVV23BOfPLRsaeXGpCTmqk5Bg==
X-Received: by 2002:a7b:ce83:: with SMTP id q3mr3330187wmj.5.1596635085095;
 Wed, 05 Aug 2020 06:44:45 -0700 (PDT)
Received: from redhat.com (bzq-79-178-123-8.red.bezeqint.net. [79.178.123.8])
 by smtp.gmail.com with ESMTPSA id
 l21sm2648720wmj.25.2020.08.05.06.44.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2020 06:44:44 -0700 (PDT)
Date: Wed, 5 Aug 2020 09:44:42 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v3 32/38] virtio_crypto: convert to LE accessors
Message-ID: <20200805134226.1106164-33-mst@redhat.com>
References: <20200805134226.1106164-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200805134226.1106164-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Herbert Xu <herbert@gondor.apana.org.au>,
 virtualization@lists.linux-foundation.org, linux-crypto@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

Virtio crypto is modern-only. Use LE accessors for config space.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/crypto/virtio/virtio_crypto_core.c | 46 +++++++++++-----------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/drivers/crypto/virtio/virtio_crypto_core.c b/drivers/crypto/virtio/virtio_crypto_core.c
index c8a962c62663..aeecce27fe8f 100644
--- a/drivers/crypto/virtio/virtio_crypto_core.c
+++ b/drivers/crypto/virtio/virtio_crypto_core.c
@@ -204,8 +204,8 @@ static int virtcrypto_update_status(struct virtio_crypto *vcrypto)
 	u32 status;
 	int err;
 
-	virtio_cread(vcrypto->vdev,
-	    struct virtio_crypto_config, status, &status);
+	virtio_cread_le(vcrypto->vdev,
+			struct virtio_crypto_config, status, &status);
 
 	/*
 	 * Unknown status bits would be a host error and the driver
@@ -323,31 +323,31 @@ static int virtcrypto_probe(struct virtio_device *vdev)
 	if (!vcrypto)
 		return -ENOMEM;
 
-	virtio_cread(vdev, struct virtio_crypto_config,
+	virtio_cread_le(vdev, struct virtio_crypto_config,
 			max_dataqueues, &max_data_queues);
 	if (max_data_queues < 1)
 		max_data_queues = 1;
 
-	virtio_cread(vdev, struct virtio_crypto_config,
-		max_cipher_key_len, &max_cipher_key_len);
-	virtio_cread(vdev, struct virtio_crypto_config,
-		max_auth_key_len, &max_auth_key_len);
-	virtio_cread(vdev, struct virtio_crypto_config,
-		max_size, &max_size);
-	virtio_cread(vdev, struct virtio_crypto_config,
-		crypto_services, &crypto_services);
-	virtio_cread(vdev, struct virtio_crypto_config,
-		cipher_algo_l, &cipher_algo_l);
-	virtio_cread(vdev, struct virtio_crypto_config,
-		cipher_algo_h, &cipher_algo_h);
-	virtio_cread(vdev, struct virtio_crypto_config,
-		hash_algo, &hash_algo);
-	virtio_cread(vdev, struct virtio_crypto_config,
-		mac_algo_l, &mac_algo_l);
-	virtio_cread(vdev, struct virtio_crypto_config,
-		mac_algo_h, &mac_algo_h);
-	virtio_cread(vdev, struct virtio_crypto_config,
-		aead_algo, &aead_algo);
+	virtio_cread_le(vdev, struct virtio_crypto_config,
+			max_cipher_key_len, &max_cipher_key_len);
+	virtio_cread_le(vdev, struct virtio_crypto_config,
+			max_auth_key_len, &max_auth_key_len);
+	virtio_cread_le(vdev, struct virtio_crypto_config,
+			max_size, &max_size);
+	virtio_cread_le(vdev, struct virtio_crypto_config,
+			crypto_services, &crypto_services);
+	virtio_cread_le(vdev, struct virtio_crypto_config,
+			cipher_algo_l, &cipher_algo_l);
+	virtio_cread_le(vdev, struct virtio_crypto_config,
+			cipher_algo_h, &cipher_algo_h);
+	virtio_cread_le(vdev, struct virtio_crypto_config,
+			hash_algo, &hash_algo);
+	virtio_cread_le(vdev, struct virtio_crypto_config,
+			mac_algo_l, &mac_algo_l);
+	virtio_cread_le(vdev, struct virtio_crypto_config,
+			mac_algo_h, &mac_algo_h);
+	virtio_cread_le(vdev, struct virtio_crypto_config,
+			aead_algo, &aead_algo);
 
 	/* Add virtio crypto device to global table */
 	err = virtcrypto_devmgr_add_dev(vcrypto);
-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
