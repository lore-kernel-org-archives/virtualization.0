Return-Path: <SRS0=ivLu=BN=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 268A1C433DF
	for <virtualization@archiver.kernel.org>; Mon,  3 Aug 2020 20:59:25 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25C9622C9F
	for <virtualization@archiver.kernel.org>; Mon,  3 Aug 2020 20:59:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eIE/5fYG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25C9622C9F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id B559B85C2E;
	Mon,  3 Aug 2020 20:59:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pe2E8zED-W0q; Mon,  3 Aug 2020 20:59:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 4C673844C9;
	Mon,  3 Aug 2020 20:59:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 451B8C0050;
	Mon,  3 Aug 2020 20:59:24 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A83C7C004C
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 Aug 2020 20:59:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id A32CF844C9
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 Aug 2020 20:59:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4T1O2F7OzKxT
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 Aug 2020 20:59:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-2.mimecast.com
 [207.211.31.81])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id F1D6B844B4
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 Aug 2020 20:59:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596488360;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Pbr1N8DSevefC/5XR/FPYq4gph7eMtDNIH83d+s2qxE=;
 b=eIE/5fYGRyPV1aoYhYDQeHPoM8PFP7Pv5seD/DQeCqz9l6T0CnuhW77VKoIKyjjHxxsqFr
 PGiMqWahLvbUmwcc3uQcwvIe8MfI61C5s0Qodyl40B/LqWQ23kb0xZHZFw4D9WIRfqNrRR
 /v1qK4330uzZKWOibwrlcaKwhpeOs+g=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-27-laF0dB1NNuya4GXlECY4rA-1; Mon, 03 Aug 2020 16:59:13 -0400
X-MC-Unique: laF0dB1NNuya4GXlECY4rA-1
Received: by mail-qv1-f70.google.com with SMTP id k17so13049581qvj.12
 for <virtualization@lists.linux-foundation.org>;
 Mon, 03 Aug 2020 13:59:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Pbr1N8DSevefC/5XR/FPYq4gph7eMtDNIH83d+s2qxE=;
 b=bpStHNfHd9w5uX3aliRqU940Nqr+6j4V0+7VAXJ6wY4UxkYMbXC7R4kMPeAa5QW50F
 zhngQwiG/Gbyh5Wi3Qm6ptrhK4KiOXTKuRZIrhalCity3Ux/TFD08PUrKhmYFMJrwyYJ
 bQUu6uDD56kBsx5EuF/hYdYlLUecMo850A6I01qFG4f6evpGXreX2prhuitD2xGc80j0
 JamWnks69KP1OX8Am7k5Vqkg+Bn5GAmoAxiMWhIov8QbdJnIgYK7VVC2ugv62oDh3vsw
 ++sCxYxVIBRWEfddTivu4cIcaR2b7auirbTXuEv0D/Dsdnir9DUrzDsCib0uDvLmllyl
 26Jg==
X-Gm-Message-State: AOAM5306Rzgxzrefjug1Sb6rxAE/I/mxl6coXTOCM8LSoS2eQRjqFV0M
 lPzZJwsHY48eYx+9Nw2fGnyFKi2wBfaPb4gBm6emguBMTWdvz9iE9fg2CYbGsWrFTXlAer16ua5
 cmsVXr7HASm79u6Dn/YR2CJLoT9ZMaUAb3JJhI64SfQ==
X-Received: by 2002:a37:97c5:: with SMTP id
 z188mr17625693qkd.185.1596488353342; 
 Mon, 03 Aug 2020 13:59:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwpOGU4uU2+OZrgzDbQ/8jdl4TOLFPS5AcU+IWHZ8zsJRTTGwbHFRTkcrWAk9H50yW4pnfpSQ==
X-Received: by 2002:a37:97c5:: with SMTP id
 z188mr17625681qkd.185.1596488353070; 
 Mon, 03 Aug 2020 13:59:13 -0700 (PDT)
Received: from redhat.com (bzq-79-177-102-128.red.bezeqint.net.
 [79.177.102.128])
 by smtp.gmail.com with ESMTPSA id k2sm21549694qkf.127.2020.08.03.13.59.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Aug 2020 13:59:12 -0700 (PDT)
Date: Mon, 3 Aug 2020 16:59:09 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v2 08/24] virtio_crypto: correct tags for config space fields
Message-ID: <20200803205814.540410-9-mst@redhat.com>
References: <20200803205814.540410-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200803205814.540410-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: linux-crypto@vger.kernel.org, virtualization@lists.linux-foundation.org
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

Since crypto is a modern-only device,
tag config space fields as having little endian-ness.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/uapi/linux/virtio_crypto.h | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/include/uapi/linux/virtio_crypto.h b/include/uapi/linux/virtio_crypto.h
index 50cdc8aebfcf..a03932f10565 100644
--- a/include/uapi/linux/virtio_crypto.h
+++ b/include/uapi/linux/virtio_crypto.h
@@ -414,33 +414,33 @@ struct virtio_crypto_op_data_req {
 
 struct virtio_crypto_config {
 	/* See VIRTIO_CRYPTO_OP_* above */
-	__u32  status;
+	__le32  status;
 
 	/*
 	 * Maximum number of data queue
 	 */
-	__u32  max_dataqueues;
+	__le32  max_dataqueues;
 
 	/*
 	 * Specifies the services mask which the device support,
 	 * see VIRTIO_CRYPTO_SERVICE_* above
 	 */
-	__u32 crypto_services;
+	__le32 crypto_services;
 
 	/* Detailed algorithms mask */
-	__u32 cipher_algo_l;
-	__u32 cipher_algo_h;
-	__u32 hash_algo;
-	__u32 mac_algo_l;
-	__u32 mac_algo_h;
-	__u32 aead_algo;
+	__le32 cipher_algo_l;
+	__le32 cipher_algo_h;
+	__le32 hash_algo;
+	__le32 mac_algo_l;
+	__le32 mac_algo_h;
+	__le32 aead_algo;
 	/* Maximum length of cipher key */
-	__u32 max_cipher_key_len;
+	__le32 max_cipher_key_len;
 	/* Maximum length of authenticated key */
-	__u32 max_auth_key_len;
-	__u32 reserve;
+	__le32 max_auth_key_len;
+	__le32 reserve;
 	/* Maximum size of each crypto request's content */
-	__u64 max_size;
+	__le64 max_size;
 };
 
 struct virtio_crypto_inhdr {
-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
