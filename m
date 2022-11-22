Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 408D4C4332F
	for <virtualization@archiver.kernel.org>; Tue, 22 Nov 2022 10:08:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B39D581F68;
	Tue, 22 Nov 2022 10:08:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B39D581F68
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Yu0FS6Oq2tNx; Tue, 22 Nov 2022 10:08:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 5141F81F36;
	Tue, 22 Nov 2022 10:08:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5141F81F36
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1A5D4C0032;
	Tue, 22 Nov 2022 10:08:06 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2EBC2C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Nov 2022 10:08:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 08631405BB
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Nov 2022 10:08:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 08631405BB
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YILevSVnev9P
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Nov 2022 10:08:00 +0000 (UTC)
X-Greylist: delayed 00:25:29 by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C024E4048D
Received: from formenos.hmeau.com (helcar.hmeau.com [216.24.177.18])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C024E4048D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Nov 2022 10:07:59 +0000 (UTC)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
 by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
 id 1oxPnO-00H3Hz-Km; Tue, 22 Nov 2022 17:42:27 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation);
 Tue, 22 Nov 2022 17:42:26 +0800
Date: Tue, 22 Nov 2022 17:42:26 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Gonglei <arei.gonglei@huawei.com>,
 virtualization@lists.linux-foundation.org,
 Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Subject: [PATCH] crypto: virtio - Use helper to set reqsize
Message-ID: <Y3yZgn/ffk21bGaM@gondor.apana.org.au>
MIME-Version: 1.0
Content-Disposition: inline
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

The value of reqsize must only be changed through the helper.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c b/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c
index 168195672e2e..b2979be613b8 100644
--- a/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c
+++ b/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c
@@ -479,6 +479,9 @@ static int virtio_crypto_rsa_init_tfm(struct crypto_akcipher *tfm)
 	ctx->enginectx.op.prepare_request = NULL;
 	ctx->enginectx.op.unprepare_request = NULL;
 
+	akcipher_set_reqsize(tfm,
+			     sizeof(struct virtio_crypto_akcipher_request));
+
 	return 0;
 }
 
@@ -505,7 +508,6 @@ static struct virtio_crypto_akcipher_algo virtio_crypto_akcipher_algs[] = {
 			.max_size = virtio_crypto_rsa_max_size,
 			.init = virtio_crypto_rsa_init_tfm,
 			.exit = virtio_crypto_rsa_exit_tfm,
-			.reqsize = sizeof(struct virtio_crypto_akcipher_request),
 			.base = {
 				.cra_name = "rsa",
 				.cra_driver_name = "virtio-crypto-rsa",
@@ -528,7 +530,6 @@ static struct virtio_crypto_akcipher_algo virtio_crypto_akcipher_algs[] = {
 			.max_size = virtio_crypto_rsa_max_size,
 			.init = virtio_crypto_rsa_init_tfm,
 			.exit = virtio_crypto_rsa_exit_tfm,
-			.reqsize = sizeof(struct virtio_crypto_akcipher_request),
 			.base = {
 				.cra_name = "pkcs1pad(rsa,sha1)",
 				.cra_driver_name = "virtio-pkcs1-rsa-with-sha1",
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
