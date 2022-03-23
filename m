Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17782C433FE
	for <virtualization@archiver.kernel.org>; Wed, 23 Mar 2022 02:53:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B26A2848EF;
	Wed, 23 Mar 2022 02:53:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rd3I6mcIfjwT; Wed, 23 Mar 2022 02:53:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 47ABE8491F;
	Wed, 23 Mar 2022 02:53:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1633FC001A;
	Wed, 23 Mar 2022 02:53:06 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 973DEC000B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Mar 2022 02:53:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 81D4440CA7
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Mar 2022 02:53:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=bytedance-com.20210112.gappssmtp.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Lzu_XrL5zch6
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Mar 2022 02:53:03 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com
 [IPv6:2607:f8b0:4864:20::102f])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 697054013A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Mar 2022 02:53:03 +0000 (UTC)
Received: by mail-pj1-x102f.google.com with SMTP id
 o6-20020a17090a9f8600b001c6562049d9so454742pjp.3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Mar 2022 19:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20210112.gappssmtp.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Sg3To/7UT7Td+uZYPu+oDeRZF15OaGdKfSNym1I4/hE=;
 b=4UFMN77XWGnYrRYUy3LKDWngeQjcECwfMkSuMWtxxC01Akzeu9rHwKC/nGRbsx3p+2
 VCxF52uasYyYrHRkyOh+UL7ZleClsNHlJIG/BgTX+n29BknYqaJXgHYex7zkFcJEnxWM
 s9dy6tEJouexU56Y7ZW51UabbJhg1PQIHTEBlWZ6yB2YbPwFblRZPeN9zCxo6ABbHmWD
 J4dYAVyp/ryWLppvP0GCLaSmmX8MhocgX0iU3QNHiSKEwHw8j+2vVXS5nXaelIXbmubL
 sJLeCDJMldX4Af4DaoOeTzzuNfhczd498hcReSq2TmrFmzcMq1F6xIgMagR9Fjp2CQe+
 PsGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Sg3To/7UT7Td+uZYPu+oDeRZF15OaGdKfSNym1I4/hE=;
 b=41C2UkOLG7TsQCyntxceM5UV0IqgU9WteY5hKM3x8Q5cgk3T2Dm/kPDlXQqwSZxV/m
 TPR6GoPjyjY/3o2Yp6LeyD9hAXgw8KHHMQh2JVKixy4Chnrkx4I/lLj3pqbYvYV0OAdC
 PdRu8samtNaUgjqrZsA5ytNv69XPq+G47yYO9TamwSzJlm611m/hxvUCoEYLGE3HvFCC
 fxTvSNMxJBJoGu+VuuPA5aVVa+EQxcjxdO2fffQI1XG+Rh6MQIIPUKTqMUDooeAZBaDn
 4bJcZD9RBiD5sUVw5PeBRrjgFwzdhbLy6gMUvopjDB86GZjaCwR6tySThqgCq5/wJbpO
 d15Q==
X-Gm-Message-State: AOAM533sgSHu1xkLVjdLMw3+rh1iOruEtaMO0sUuG9T4MlJR9MSMM58O
 Qxqy717JJ4j5fiWpqFNeIEv/GQ==
X-Google-Smtp-Source: ABdhPJzz4RA92uPgrSrtlvMjFp57uCew5sRe8hpZlNEi889wNBDUneICR+l2GiXixacITs4a6375sw==
X-Received: by 2002:a17:902:7049:b0:151:e52e:ae42 with SMTP id
 h9-20020a170902704900b00151e52eae42mr22231853plt.118.1648003982647; 
 Tue, 22 Mar 2022 19:53:02 -0700 (PDT)
Received: from always-x1.www.tendawifi.com ([139.177.225.224])
 by smtp.gmail.com with ESMTPSA id
 t2-20020a63a602000000b0038062a0bc6fsm18104869pge.67.2022.03.22.19.52.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Mar 2022 19:53:01 -0700 (PDT)
From: zhenwei pi <pizhenwei@bytedance.com>
To: arei.gonglei@huawei.com,
	mst@redhat.com
Subject: [PATCH v3 2/6] crypto-akcipher: Introduce akcipher types to qapi
Date: Wed, 23 Mar 2022 10:49:08 +0800
Message-Id: <20220323024912.249789-3-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220323024912.249789-1-pizhenwei@bytedance.com>
References: <20220323024912.249789-1-pizhenwei@bytedance.com>
MIME-Version: 1.0
Cc: herbert@gondor.apana.org.au, qemu-devel@nongnu.org,
 zhenwei pi <pizhenwei@bytedance.com>,
 virtualization@lists.linux-foundation.org, linux-crypto@vger.kernel.org,
 Lei He <helei.sig11@bytedance.com>
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

Introduce akcipher types, also include RSA & ECDSA related types.

Signed-off-by: Lei He <helei.sig11@bytedance.com>
Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
---
 qapi/crypto.json | 86 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 86 insertions(+)

diff --git a/qapi/crypto.json b/qapi/crypto.json
index 1ec54c15ca..d44c38e3b1 100644
--- a/qapi/crypto.json
+++ b/qapi/crypto.json
@@ -540,3 +540,89 @@
   'data': { '*loaded': { 'type': 'bool', 'features': ['deprecated'] },
             '*sanity-check': 'bool',
             '*passwordid': 'str' } }
+##
+# @QCryptoAkcipherAlgorithm:
+#
+# The supported algorithms for asymmetric encryption ciphers
+#
+# @rsa: RSA algorithm
+# @ecdsa: ECDSA algorithm
+#
+# Since: 7.0
+##
+{ 'enum': 'QCryptoAkcipherAlgorithm',
+  'prefix': 'QCRYPTO_AKCIPHER_ALG',
+  'data': ['rsa', 'ecdsa']}
+
+##
+# @QCryptoAkcipherKeyType:
+#
+# The type of asymmetric keys.
+#
+# Since: 7.0
+##
+{ 'enum': 'QCryptoAkcipherKeyType',
+  'prefix': 'QCRYPTO_AKCIPHER_KEY_TYPE',
+  'data': ['public', 'private']}
+
+##
+# @QCryptoRsaHashAlgorithm:
+#
+# The hash algorithm for RSA pkcs1 padding algothrim
+#
+# Since: 7.0
+##
+{ 'enum': 'QCryptoRsaHashAlgorithm',
+  'prefix': 'QCRYPTO_RSA_HASH_ALG',
+  'data': [ 'md2', 'md3', 'md4', 'md5', 'sha1', 'sha256', 'sha384', 'sha512', 'sha224' ]}
+
+##
+# @QCryptoRsaPaddingAlgorithm:
+#
+# The padding algorithm for RSA.
+#
+# @raw: no padding used
+# @pkcs1: pkcs1#v1.5
+#
+# Since: 7.0
+##
+{ 'enum': 'QCryptoRsaPaddingAlgorithm',
+  'prefix': 'QCRYPTO_RSA_PADDING_ALG',
+  'data': ['raw', 'pkcs1']}
+
+##
+# @QCryptoCurveId:
+#
+# The well-known curves, referenced from https://csrc.nist.gov/csrc/media/publications/fips/186/3/archive/2009-06-25/documents/fips_186-3.pdf
+#
+# Since: 7.0
+##
+{ 'enum': 'QCryptoCurveId',
+  'prefix': 'QCRYPTO_CURVE_ID',
+  'data': ['nist-p192', 'nist-p224', 'nist-p256', 'nist-p384', 'nist-p521']}
+
+##
+# @QCryptoRsaOptions:
+#
+# Specific parameters for RSA algorithm.
+#
+# @hash-algo: QCryptoRsaHashAlgorithm
+# @padding-algo: QCryptoRsaPaddingAlgorithm
+#
+# Since: 7.0
+##
+{ 'struct': 'QCryptoRsaOptions',
+  'data': { 'hash-algo':'QCryptoRsaHashAlgorithm',
+            'padding-algo': 'QCryptoRsaPaddingAlgorithm'}}
+
+##
+# @QCryptoEcdsaOptions:
+#
+# Specific parameter for ECDSA algorithm.
+#
+# @curve-id: QCryptoCurveId
+#
+# Since: 7.0
+##
+{ 'struct': 'QCryptoEcdsaOptions',
+  'data': { 'curve-id': 'QCryptoCurveId' }}
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
