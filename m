Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDD7BC433EF
	for <virtualization@archiver.kernel.org>; Mon, 11 Apr 2022 10:47:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7370B83033;
	Mon, 11 Apr 2022 10:47:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HWM3QMOfYw-L; Mon, 11 Apr 2022 10:47:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 2AAD882FDE;
	Mon, 11 Apr 2022 10:47:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 03587C002F;
	Mon, 11 Apr 2022 10:47:18 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 60F4EC002C
 for <virtualization@lists.linux-foundation.org>;
 Mon, 11 Apr 2022 10:47:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3C75481AD7
 for <virtualization@lists.linux-foundation.org>;
 Mon, 11 Apr 2022 10:47:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1WTax6nZtejw
 for <virtualization@lists.linux-foundation.org>;
 Mon, 11 Apr 2022 10:47:15 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com
 [IPv6:2607:f8b0:4864:20::52c])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 311B082FDE
 for <virtualization@lists.linux-foundation.org>;
 Mon, 11 Apr 2022 10:47:15 +0000 (UTC)
Received: by mail-pg1-x52c.google.com with SMTP id s137so11113308pgs.5
 for <virtualization@lists.linux-foundation.org>;
 Mon, 11 Apr 2022 03:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20210112.gappssmtp.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=T2tpQeswcKujfVdwIoHw1RfrV9uib5LWkvVd7zn6J2E=;
 b=CVqR85YK0kV1ew5YUb3MKn+PwqC2RZOKHCbao+qgSvMsIETamGFD9jCgpWNEtN4C6k
 H+RQP9uMXjyo2wdqC6/aN2iyj28Ans+K9/6FrjtHKaua2079TiC1j024zPO37h0HS/Cy
 q3DtobvPoZzMU2wUk6X8HfMYTDfPJgEcTzKA6QZHRNOzU0YUiYrXVH+EydNk/MdWRYom
 Gi0/CD5X0ZI3Q6qVX88MHAJr9DDgUWy9xZNM6bmkR0aZfZgF688948+SR42xez+1w5yw
 L1ydr7fmLrGBuSkaUMgO6fpcyqj0qQD7qCjxathDC782+hCBUb+FOBT2a8RXM54zLNid
 t24g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=T2tpQeswcKujfVdwIoHw1RfrV9uib5LWkvVd7zn6J2E=;
 b=I3LkM+jA/lfHjvvhPiek7pZPM30ACwiB92hGkizlmzu10Pht7jHolvdqbkU/G4ABOa
 kz50PrIQvTwCZZqTf0AYPs3YPgxIM+6Ic3Sq5H3W0qrsGsYqP3Qp7TGt8H6rnxUkv4TB
 rpLZurNXxIlYAVQw/ZWemBBNlInWqz7lLRT/ocN4PqgSe3V22tVzFeMsigO+cA1mC522
 59C6vrJ9bia5OeECpFof17JIRxN25RH+XZGGNWdJNn482zvtywMD+p7p/0jYhRnNOlXX
 4IKVSD8Jb/XwP1pxJjnhI+ENVj7TgWZz9G6Xg6zfw86fKh9oQ3XDMU2C1O8TPvKQ9huk
 R32Q==
X-Gm-Message-State: AOAM532Tq9JOMVPMrC+NgNACjj7mHbVpTGp/8LspLvSePefbqBnOhNwG
 oLeo8kwlxI5qWpn5E0dQ46aonQ==
X-Google-Smtp-Source: ABdhPJywzB2A8MdeFTx2U2wbcJIYP/g1Ica6qEgtJFifufvGAHLRLpTSa7YMRA+izmFa0y09OLt/eQ==
X-Received: by 2002:a63:1141:0:b0:39c:b664:c508 with SMTP id
 1-20020a631141000000b0039cb664c508mr20204916pgr.49.1649674034556; 
 Mon, 11 Apr 2022 03:47:14 -0700 (PDT)
Received: from always-x1.bytedance.net ([61.120.150.76])
 by smtp.gmail.com with ESMTPSA id
 d8-20020a636808000000b00398e9c7049bsm27541649pgc.31.2022.04.11.03.47.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Apr 2022 03:47:14 -0700 (PDT)
From: zhenwei pi <pizhenwei@bytedance.com>
To: mst@redhat.com,
	berrange@redhat.com,
	arei.gonglei@huawei.com
Subject: [PATCH v4 2/8] crypto-akcipher: Introduce akcipher types to qapi
Date: Mon, 11 Apr 2022 18:43:21 +0800
Message-Id: <20220411104327.197048-3-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220411104327.197048-1-pizhenwei@bytedance.com>
References: <20220411104327.197048-1-pizhenwei@bytedance.com>
MIME-Version: 1.0
Cc: helei.sig11@bytedance.com, cohuck@redhat.com, qemu-devel@nongnu.org,
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

From: Lei He <helei.sig11@bytedance.com>

Introduce akcipher types, also include RSA related types.

Signed-off-by: Lei He <helei.sig11@bytedance.com>
Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
---
 qapi/crypto.json | 64 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/qapi/crypto.json b/qapi/crypto.json
index 1ec54c15ca..9e2b41fc82 100644
--- a/qapi/crypto.json
+++ b/qapi/crypto.json
@@ -540,3 +540,67 @@
   'data': { '*loaded': { 'type': 'bool', 'features': ['deprecated'] },
             '*sanity-check': 'bool',
             '*passwordid': 'str' } }
+##
+# @QCryptoAkCipherAlgorithm:
+#
+# The supported algorithms for asymmetric encryption ciphers
+#
+# @rsa: RSA algorithm
+#
+# Since: 7.1
+##
+{ 'enum': 'QCryptoAkCipherAlgorithm',
+  'prefix': 'QCRYPTO_AKCIPHER_ALG',
+  'data': ['rsa']}
+
+##
+# @QCryptoAkCipherKeyType:
+#
+# The type of asymmetric keys.
+#
+# Since: 7.1
+##
+{ 'enum': 'QCryptoAkCipherKeyType',
+  'prefix': 'QCRYPTO_AKCIPHER_KEY_TYPE',
+  'data': ['public', 'private']}
+
+##
+# @QCryptoRSAPaddingAlgorithm:
+#
+# The padding algorithm for RSA.
+#
+# @raw: no padding used
+# @pkcs1: pkcs1#v1.5
+#
+# Since: 7.1
+##
+{ 'enum': 'QCryptoRSAPaddingAlgorithm',
+  'prefix': 'QCRYPTO_RSA_PADDING_ALG',
+  'data': ['raw', 'pkcs1']}
+
+##
+# @QCryptoAkCipherOptionsRSA:
+#
+# Specific parameters for RSA algorithm.
+#
+# @hash-alg: QCryptoHashAlgorithm
+# @padding-alg: QCryptoRSAPaddingAlgorithm
+#
+# Since: 7.1
+##
+{ 'struct': 'QCryptoAkCipherOptionsRSA',
+  'data': { 'hash-alg':'QCryptoHashAlgorithm',
+            'padding-alg': 'QCryptoRSAPaddingAlgorithm'}}
+
+##
+# @QCryptoAkCipherOptions:
+#
+# The options that are available for all asymmetric key algorithms
+# when creating a new QCryptoAkCipher.
+#
+# Since: 7.1
+##
+{ 'union': 'QCryptoAkCipherOptions',
+  'base': { 'algorithm': 'QCryptoAkCipherAlgorithm' },
+  'discriminator': 'algorithm',
+  'data': { 'rsa': 'QCryptoAkCipherOptionsRSA' }}
-- 
2.20.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
