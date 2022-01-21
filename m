Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7855C433EF
	for <virtualization@archiver.kernel.org>; Fri, 21 Jan 2022 02:26:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8827460ED6;
	Fri, 21 Jan 2022 02:26:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id miFw5d4nWg9X; Fri, 21 Jan 2022 02:26:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 3677760BCD;
	Fri, 21 Jan 2022 02:26:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 090C9C0039;
	Fri, 21 Jan 2022 02:26:01 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 63ADDC002F
 for <virtualization@lists.linux-foundation.org>;
 Fri, 21 Jan 2022 02:25:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 60C4141670
 for <virtualization@lists.linux-foundation.org>;
 Fri, 21 Jan 2022 02:25:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=bytedance-com.20210112.gappssmtp.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id P0VHe02_zACP
 for <virtualization@lists.linux-foundation.org>;
 Fri, 21 Jan 2022 02:25:58 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com
 [IPv6:2607:f8b0:4864:20::535])
 by smtp4.osuosl.org (Postfix) with ESMTPS id AC87F41669
 for <virtualization@lists.linux-foundation.org>;
 Fri, 21 Jan 2022 02:25:58 +0000 (UTC)
Received: by mail-pg1-x535.google.com with SMTP id g2so6975197pgo.9
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 Jan 2022 18:25:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20210112.gappssmtp.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=/xLkpZ2sPhON9Uu4HwhEOk6KJqVId8ApNAzoWtNRra0=;
 b=nGMcYSi2ftHKX3ltcV11aTskHheSJFXB61BSAN7mJcfMxi3ks7XfA/UbpJASpA6pni
 pyVDdEHUYFBRNOD0Y7UWBLTWzJANO7N7TORmFFoY4jc+3DmM83CYImj/kX65S4S0/Wfr
 GyC1qmJIiAWNC5cpwFsfXQczfACjA1+NpL7Y0qDgw5sDYLuqfZXa9HvsaOFm/p4PWntv
 Ex7GhP6pWe3JOL0u+lCrlQyKVS1mxV2FIhCyalcQA+LGrPEtWTvXuOLuLW0Je/ITu4OE
 sfVr0BlOmRCM8BNFs7NBnubDgn89imVXx9jCsy97stVlK8kCGoRxDNt9Gp2XLRfrUaOj
 UyfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=/xLkpZ2sPhON9Uu4HwhEOk6KJqVId8ApNAzoWtNRra0=;
 b=Y0vT5q8sZ7nyHYojLJyODVt3p9Xjqt+LU60fxIdimIcwmBzCsinjg2aNbylP7QpPhj
 CpVcmjfq1hLv6KV/xjtRMsDUNiei51KlF0AZc8fVbqa91yEEzJ+RcsLCCZ5P3QKIW+Z0
 Vkdq2cUG3BWT7BFTb9r6vI2iA5BdDUmS4GNFkZGR6tBH3TlR5zx4Cfx8QR+SIeiLeAb1
 UmoSdPcDhDNKZ4vQoSey7HQWQ2nGFVmrRaFQsXtvadrLYDAzXsHz257GVDKa3ng68wNt
 jQll65rdHqLiwDApmHE+Q0ACrhg3/KzTjCJKTFJHzer0+BOYYne4iubrDbzDgaahgKoA
 rpIg==
X-Gm-Message-State: AOAM533gJxw953odEtRf4UOyJFshaUOV8AaSnaUlDlKSuucNzlIMshj7
 fwhiIC4pFtmWYSMPkEWSVZp0gg==
X-Google-Smtp-Source: ABdhPJyuwOBSEd1JIlhU+2G/71EkHDtbQ+C8B4IdLrFnoBXm0tR/YH1SqBMuk4mOyD8PnZkL/SnoRg==
X-Received: by 2002:a05:6a00:216f:b0:49f:dcb7:2bf2 with SMTP id
 r15-20020a056a00216f00b0049fdcb72bf2mr1973578pff.19.1642731958115; 
 Thu, 20 Jan 2022 18:25:58 -0800 (PST)
Received: from libai.bytedance.net ([61.120.150.72])
 by smtp.gmail.com with ESMTPSA id h2sm5057577pfv.31.2022.01.20.18.25.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Jan 2022 18:25:57 -0800 (PST)
From: zhenwei pi <pizhenwei@bytedance.com>
To: mst@redhat.com,
	arei.gonglei@huawei.com
Subject: [PATCH 2/3] virtio-crypto: introduce akcipher service
Date: Fri, 21 Jan 2022 10:24:37 +0800
Message-Id: <20220121022438.1042547-3-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220121022438.1042547-1-pizhenwei@bytedance.com>
References: <20220121022438.1042547-1-pizhenwei@bytedance.com>
MIME-Version: 1.0
Cc: helei.sig11@bytedance.com, linux-kernel@vger.kernel.org,
 zhenwei pi <pizhenwei@bytedance.com>,
 virtualization@lists.linux-foundation.org, linux-crypto@vger.kernel.org
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

Introduce asymmetric service definition, asymmetric operations and
several well known algorithms.

Co-developed-by: lei he <helei.sig11@bytedance.com>
Signed-off-by: lei he <helei.sig11@bytedance.com>
Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
---
 include/uapi/linux/virtio_crypto.h | 99 +++++++++++++++++++++++++++---
 1 file changed, 89 insertions(+), 10 deletions(-)

diff --git a/include/uapi/linux/virtio_crypto.h b/include/uapi/linux/virtio_crypto.h
index 1166a49084b0..050578d61d85 100644
--- a/include/uapi/linux/virtio_crypto.h
+++ b/include/uapi/linux/virtio_crypto.h
@@ -33,10 +33,11 @@
 #include <linux/virtio_config.h>
 
 
-#define VIRTIO_CRYPTO_SERVICE_CIPHER 0
-#define VIRTIO_CRYPTO_SERVICE_HASH   1
-#define VIRTIO_CRYPTO_SERVICE_MAC    2
-#define VIRTIO_CRYPTO_SERVICE_AEAD   3
+#define VIRTIO_CRYPTO_SERVICE_CIPHER   0
+#define VIRTIO_CRYPTO_SERVICE_HASH     1
+#define VIRTIO_CRYPTO_SERVICE_MAC      2
+#define VIRTIO_CRYPTO_SERVICE_AEAD     3
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
 	__le32 opcode;
 	__le32 algo;
 	__le32 flag;
@@ -180,6 +185,57 @@ struct virtio_crypto_aead_create_session_req {
 	__u8 padding[32];
 };
 
+struct virtio_crypto_rsa_session_para {
+#define VIRTIO_CRYPTO_RSA_RAW_PADDING   0
+#define VIRTIO_CRYPTO_RSA_PKCS1_PADDING 1
+	__le32 padding_algo;
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
+	__le32 hash_algo;
+};
+
+struct virtio_crypto_ecdsa_session_para {
+#define VIRTIO_CRYPTO_CURVE_UNKNOWN   0
+#define VIRTIO_CRYPTO_CURVE_NIST_P192 1
+#define VIRTIO_CRYPTO_CURVE_NIST_P224 2
+#define VIRTIO_CRYPTO_CURVE_NIST_P256 3
+#define VIRTIO_CRYPTO_CURVE_NIST_P384 4
+#define VIRTIO_CRYPTO_CURVE_NIST_P521 5
+	__le32 curve_id;
+};
+
+struct virtio_crypto_akcipher_session_para {
+#define VIRTIO_CRYPTO_NO_AKCIPHER    0
+#define VIRTIO_CRYPTO_AKCIPHER_RSA   1
+#define VIRTIO_CRYPTO_AKCIPHER_DSA   2
+#define VIRTIO_CRYPTO_AKCIPHER_ECDSA 3
+	__le32 algo;
+
+#define VIRTIO_CRYPTO_AKCIPHER_KEY_TYPE_PUBLIC  1
+#define VIRTIO_CRYPTO_AKCIPHER_KEY_TYPE_PRIVATE 2
+	__le32 keytype;
+	__le32 keylen;
+
+	union {
+		struct virtio_crypto_rsa_session_para rsa;
+		struct virtio_crypto_ecdsa_session_para ecdsa;
+	} u;
+};
+
+struct virtio_crypto_akcipher_create_session_req {
+	struct virtio_crypto_akcipher_session_para para;
+	__u8 padding[36];
+};
+
 struct virtio_crypto_alg_chain_session_para {
 #define VIRTIO_CRYPTO_SYM_ALG_CHAIN_ORDER_HASH_THEN_CIPHER  1
 #define VIRTIO_CRYPTO_SYM_ALG_CHAIN_ORDER_CIPHER_THEN_HASH  2
@@ -247,6 +303,8 @@ struct virtio_crypto_op_ctrl_req {
 			mac_create_session;
 		struct virtio_crypto_aead_create_session_req
 			aead_create_session;
+		struct virtio_crypto_akcipher_create_session_req
+			akcipher_create_session;
 		struct virtio_crypto_destroy_session_req
 			destroy_session;
 		__u8 padding[56];
@@ -266,6 +324,14 @@ struct virtio_crypto_op_header {
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
 	__le32 opcode;
 	/* algo should be service-specific algorithms */
 	__le32 algo;
@@ -390,6 +456,16 @@ struct virtio_crypto_aead_data_req {
 	__u8 padding[32];
 };
 
+struct virtio_crypto_akcipher_para {
+	__le32 src_data_len;
+	__le32 dst_data_len;
+};
+
+struct virtio_crypto_akcipher_data_req {
+	struct virtio_crypto_akcipher_para para;
+	__u8 padding[40];
+};
+
 /* The request of the data virtqueue's packet */
 struct virtio_crypto_op_data_req {
 	struct virtio_crypto_op_header header;
@@ -399,16 +475,18 @@ struct virtio_crypto_op_data_req {
 		struct virtio_crypto_hash_data_req hash_req;
 		struct virtio_crypto_mac_data_req mac_req;
 		struct virtio_crypto_aead_data_req aead_req;
+		struct virtio_crypto_akcipher_data_req akcipher_req;
 		__u8 padding[48];
 	} u;
 };
 
-#define VIRTIO_CRYPTO_OK        0
-#define VIRTIO_CRYPTO_ERR       1
-#define VIRTIO_CRYPTO_BADMSG    2
-#define VIRTIO_CRYPTO_NOTSUPP   3
-#define VIRTIO_CRYPTO_INVSESS   4 /* Invalid session id */
-#define VIRTIO_CRYPTO_NOSPC     5 /* no free session ID */
+#define VIRTIO_CRYPTO_OK            0
+#define VIRTIO_CRYPTO_ERR           1
+#define VIRTIO_CRYPTO_BADMSG        2
+#define VIRTIO_CRYPTO_NOTSUPP       3
+#define VIRTIO_CRYPTO_INVSESS       4 /* Invalid session id */
+#define VIRTIO_CRYPTO_NOSPC         5 /* no free session ID */
+#define VIRTIO_CRYPTO_KEY_REJECTED  6 /* Signature verification failed */
 
 /* The accelerator hardware is ready */
 #define VIRTIO_CRYPTO_S_HW_READY  (1 << 0)
@@ -442,6 +520,7 @@ struct virtio_crypto_config {
 	__le32 reserve;
 	/* Maximum size of each crypto request's content */
 	__le64 max_size;
+	__le32 akcipher_algo;
 };
 
 struct virtio_crypto_inhdr {
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
