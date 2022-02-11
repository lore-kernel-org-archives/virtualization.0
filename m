Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D530FC433FE
	for <virtualization@archiver.kernel.org>; Fri, 11 Feb 2022 08:45:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 905BD82771;
	Fri, 11 Feb 2022 08:45:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id aU1R9iuu_tri; Fri, 11 Feb 2022 08:45:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 2277E81CE7;
	Fri, 11 Feb 2022 08:45:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0651BC001A;
	Fri, 11 Feb 2022 08:45:14 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 62E18C000B
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Feb 2022 08:45:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 41859400E6
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Feb 2022 08:45:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=bytedance-com.20210112.gappssmtp.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3OEFqTLjdFFB
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Feb 2022 08:45:11 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com
 [IPv6:2607:f8b0:4864:20::1036])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2327C402F3
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Feb 2022 08:45:10 +0000 (UTC)
Received: by mail-pj1-x1036.google.com with SMTP id y9so7502085pjf.1
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Feb 2022 00:45:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20210112.gappssmtp.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=1YUUEgbKT5E8ArafBlTdhEpSwGDviZA6oIz5a+XwpPM=;
 b=0oAjqplYNLMWICcrHeQjBdyutmnnlHMmThim5ZJF8kipGWzVHnNCy5Prycxm4OuZvp
 JcNXCx6po3z1kHXAVdEEWRbGBksAMyNwzJoRs04r8PY8NiT+23idoQsS4eEn/z2ORiKv
 6ftzQN5tVH72P81P7NQ3cKgY0tT4SvOguNm9Matwnd5L83k7HsDoyjii35eIwFogbato
 Tc7ZWif6dnotY903l4eu1E0AQqe1T2LNVO4zC7qqT1oNQbDw3I3fvWc+yb/yAU8rmqk4
 13x0u2/ubiVg/GVgontGpRVNdIZ0voPzXb3cJtu2IsqWCxGLDAZW8gs/6J5KEFqUk5Tu
 Vs8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=1YUUEgbKT5E8ArafBlTdhEpSwGDviZA6oIz5a+XwpPM=;
 b=YsUF4FCr8IqVi4PaYHhtaQ3tMwcDiG3OkELWMwIzkv4OdpRsK//OKCfFhOhOeFGemc
 8tXzm2T98Q9OT1Ba4oQgqYnwKJtRJr9/0GUExUXYTHKvJNzZNsKg8AKMTmqdRee0unRr
 Y6CFG7wY2vgfxUD744uRFtOwTuEnmL1IXxGADma86CkJn014DUOfCAtdpLjqERZD/9+X
 aJkX4D80z9KAP29ahvlv65agWAg0cDCxtp+Z/nGcA1iNvS7/dK12S4gOTDrIkf8nobk0
 G1uhvwawL4rTs1jcplpkYC96+qUYihI1TITdqtU7mBYdc0GXl7ENndfV3x/LSdCt1uTg
 11Wg==
X-Gm-Message-State: AOAM533dVlXVbF5x771tRX7SMIHb9tPx1XJxdPB5S4na8kmEisPrhwht
 b+rZQsO5SptC2DUK0cXbUPYRdQ==
X-Google-Smtp-Source: ABdhPJw0i8CweAp8N3HyYA7GXnJvxBIJPXb8oQ92581c5MIHS9NNqR0ydiY6heLawvan4w9U+B1r5w==
X-Received: by 2002:a17:902:d707:: with SMTP id
 w7mr450632ply.159.1644569110334; 
 Fri, 11 Feb 2022 00:45:10 -0800 (PST)
Received: from libai.bytedance.net ([61.120.150.72])
 by smtp.gmail.com with ESMTPSA id u7sm3832686pgc.93.2022.02.11.00.45.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Feb 2022 00:45:09 -0800 (PST)
From: zhenwei pi <pizhenwei@bytedance.com>
To: arei.gonglei@huawei.com,
	mst@redhat.com
Subject: [PATCH v2 1/3] virtio-crypto: header update
Date: Fri, 11 Feb 2022 16:43:33 +0800
Message-Id: <20220211084335.1254281-2-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220211084335.1254281-1-pizhenwei@bytedance.com>
References: <20220211084335.1254281-1-pizhenwei@bytedance.com>
MIME-Version: 1.0
Cc: helei.sig11@bytedance.com, qemu-devel@nongnu.org,
 zhenwei pi <pizhenwei@bytedance.com>,
 virtualization@lists.linux-foundation.org, linux-crypto@vger.kernel.org,
 herbert@gondor.apana.org.au
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

Update header from linux, support akcipher service.

Signed-off-by: lei he <helei.sig11@bytedance.com>
Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
---
 .../standard-headers/linux/virtio_crypto.h    | 82 ++++++++++++++++++-
 1 file changed, 81 insertions(+), 1 deletion(-)

diff --git a/include/standard-headers/linux/virtio_crypto.h b/include/standard-headers/linux/virtio_crypto.h
index 5ff0b4ee59..68066dafb6 100644
--- a/include/standard-headers/linux/virtio_crypto.h
+++ b/include/standard-headers/linux/virtio_crypto.h
@@ -37,6 +37,7 @@
 #define VIRTIO_CRYPTO_SERVICE_HASH   1
 #define VIRTIO_CRYPTO_SERVICE_MAC    2
 #define VIRTIO_CRYPTO_SERVICE_AEAD   3
+#define VIRTIO_CRYPTO_SERVICE_AKCIPHER 4
 
 #define VIRTIO_CRYPTO_OPCODE(service, op)   (((service) << 8) | (op))
 
@@ -57,6 +58,10 @@ struct virtio_crypto_ctrl_header {
 	   VIRTIO_CRYPTO_OPCODE(VIRTIO_CRYPTO_SERVICE_AEAD, 0x02)
 #define VIRTIO_CRYPTO_AEAD_DESTROY_SESSION \
 	   VIRTIO_CRYPTO_OPCODE(VIRTIO_CRYPTO_SERVICE_AEAD, 0x03)
+#define VIRTIO_CRYPTO_AKCIPHER_CREATE_SESSION \
+	   VIRTIO_CRYPTO_OPCODE(VIRTIO_CRYPTO_SERVICE_AKCIPHER, 0x04)
+#define VIRTIO_CRYPTO_AKCIPHER_DESTROY_SESSION \
+	   VIRTIO_CRYPTO_OPCODE(VIRTIO_CRYPTO_SERVICE_AKCIPHER, 0x05)
 	uint32_t opcode;
 	uint32_t algo;
 	uint32_t flag;
@@ -180,6 +185,58 @@ struct virtio_crypto_aead_create_session_req {
 	uint8_t padding[32];
 };
 
+struct virtio_crypto_rsa_session_para {
+#define VIRTIO_CRYPTO_RSA_RAW_PADDING   0
+#define VIRTIO_CRYPTO_RSA_PKCS1_PADDING 1
+	uint32_t padding_algo;
+
+#define VIRTIO_CRYPTO_RSA_NO_HASH   0
+#define VIRTIO_CRYPTO_RSA_MD2       1
+#define VIRTIO_CRYPTO_RSA_MD3       2
+#define VIRTIO_CRYPTO_RSA_MD4       3
+#define VIRTIO_CRYPTO_RSA_MD5       4
+#define VIRTIO_CRYPTO_RSA_SHA1      5
+#define VIRTIO_CRYPTO_RSA_SHA256    6
+#define VIRTIO_CRYPTO_RSA_SHA384    7
+#define VIRTIO_CRYPTO_RSA_SHA512    8
+#define VIRTIO_CRYPTO_RSA_SHA224    9
+	uint32_t hash_algo;
+};
+
+struct virtio_crypto_ecdsa_session_para {
+#define VIRTIO_CRYPTO_CURVE_UNKNOWN   0
+#define VIRTIO_CRYPTO_CURVE_NIST_P192 1
+#define VIRTIO_CRYPTO_CURVE_NIST_P224 2
+#define VIRTIO_CRYPTO_CURVE_NIST_P256 3
+#define VIRTIO_CRYPTO_CURVE_NIST_P384 4
+#define VIRTIO_CRYPTO_CURVE_NIST_P521 5
+	uint32_t curve_id;
+	uint32_t padding;
+};
+
+struct virtio_crypto_akcipher_session_para {
+#define VIRTIO_CRYPTO_NO_AKCIPHER    0
+#define VIRTIO_CRYPTO_AKCIPHER_RSA   1
+#define VIRTIO_CRYPTO_AKCIPHER_DSA   2
+#define VIRTIO_CRYPTO_AKCIPHER_ECDSA 3
+	uint32_t algo;
+
+#define VIRTIO_CRYPTO_AKCIPHER_KEY_TYPE_PUBLIC  1
+#define VIRTIO_CRYPTO_AKCIPHER_KEY_TYPE_PRIVATE 2
+	uint32_t keytype;
+	uint32_t keylen;
+
+	union {
+		struct virtio_crypto_rsa_session_para rsa;
+		struct virtio_crypto_ecdsa_session_para ecdsa;
+	} u;
+};
+
+struct virtio_crypto_akcipher_create_session_req {
+	struct virtio_crypto_akcipher_session_para para;
+	uint8_t padding[36];
+};
+
 struct virtio_crypto_alg_chain_session_para {
 #define VIRTIO_CRYPTO_SYM_ALG_CHAIN_ORDER_HASH_THEN_CIPHER  1
 #define VIRTIO_CRYPTO_SYM_ALG_CHAIN_ORDER_CIPHER_THEN_HASH  2
@@ -247,6 +304,8 @@ struct virtio_crypto_op_ctrl_req {
 			mac_create_session;
 		struct virtio_crypto_aead_create_session_req
 			aead_create_session;
+		struct virtio_crypto_akcipher_create_session_req
+			akcipher_create_session;
 		struct virtio_crypto_destroy_session_req
 			destroy_session;
 		uint8_t padding[56];
@@ -266,6 +325,14 @@ struct virtio_crypto_op_header {
 	VIRTIO_CRYPTO_OPCODE(VIRTIO_CRYPTO_SERVICE_AEAD, 0x00)
 #define VIRTIO_CRYPTO_AEAD_DECRYPT \
 	VIRTIO_CRYPTO_OPCODE(VIRTIO_CRYPTO_SERVICE_AEAD, 0x01)
+#define VIRTIO_CRYPTO_AKCIPHER_ENCRYPT \
+	VIRTIO_CRYPTO_OPCODE(VIRTIO_CRYPTO_SERVICE_AKCIPHER, 0x00)
+#define VIRTIO_CRYPTO_AKCIPHER_DECRYPT \
+	VIRTIO_CRYPTO_OPCODE(VIRTIO_CRYPTO_SERVICE_AKCIPHER, 0x01)
+#define VIRTIO_CRYPTO_AKCIPHER_SIGN \
+	VIRTIO_CRYPTO_OPCODE(VIRTIO_CRYPTO_SERVICE_AKCIPHER, 0x02)
+#define VIRTIO_CRYPTO_AKCIPHER_VERIFY \
+	VIRTIO_CRYPTO_OPCODE(VIRTIO_CRYPTO_SERVICE_AKCIPHER, 0x03)
 	uint32_t opcode;
 	/* algo should be service-specific algorithms */
 	uint32_t algo;
@@ -390,6 +457,16 @@ struct virtio_crypto_aead_data_req {
 	uint8_t padding[32];
 };
 
+struct virtio_crypto_akcipher_para {
+	uint32_t src_data_len;
+	uint32_t dst_data_len;
+};
+
+struct virtio_crypto_akcipher_data_req {
+	struct virtio_crypto_akcipher_para para;
+	uint8_t padding[40];
+};
+
 /* The request of the data virtqueue's packet */
 struct virtio_crypto_op_data_req {
 	struct virtio_crypto_op_header header;
@@ -399,6 +476,7 @@ struct virtio_crypto_op_data_req {
 		struct virtio_crypto_hash_data_req hash_req;
 		struct virtio_crypto_mac_data_req mac_req;
 		struct virtio_crypto_aead_data_req aead_req;
+		struct virtio_crypto_akcipher_data_req akcipher_req;
 		uint8_t padding[48];
 	} u;
 };
@@ -408,6 +486,8 @@ struct virtio_crypto_op_data_req {
 #define VIRTIO_CRYPTO_BADMSG    2
 #define VIRTIO_CRYPTO_NOTSUPP   3
 #define VIRTIO_CRYPTO_INVSESS   4 /* Invalid session id */
+#define VIRTIO_CRYPTO_NOSPC     5 /* no free session ID */
+#define VIRTIO_CRYPTO_KEY_REJECTED 6 /* Signature verification failed */
 
 /* The accelerator hardware is ready */
 #define VIRTIO_CRYPTO_S_HW_READY  (1 << 0)
@@ -438,7 +518,7 @@ struct virtio_crypto_config {
 	uint32_t max_cipher_key_len;
 	/* Maximum length of authenticated key */
 	uint32_t max_auth_key_len;
-	uint32_t reserve;
+	uint32_t akcipher_algo;
 	/* Maximum size of each crypto request's content */
 	uint64_t max_size;
 };
-- 
2.20.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
