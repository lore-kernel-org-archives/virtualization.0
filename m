Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5586FC433F5
	for <virtualization@archiver.kernel.org>; Mon, 11 Apr 2022 10:47:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 153C5830A7;
	Mon, 11 Apr 2022 10:47:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zAYpY_GWxS33; Mon, 11 Apr 2022 10:47:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 3E417830DE;
	Mon, 11 Apr 2022 10:47:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2252FC002F;
	Mon, 11 Apr 2022 10:47:37 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E2316C002C
 for <virtualization@lists.linux-foundation.org>;
 Mon, 11 Apr 2022 10:47:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B99B560EBA
 for <virtualization@lists.linux-foundation.org>;
 Mon, 11 Apr 2022 10:47:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=bytedance-com.20210112.gappssmtp.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FX3ZOCcYyLr6
 for <virtualization@lists.linux-foundation.org>;
 Mon, 11 Apr 2022 10:47:34 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com
 [IPv6:2607:f8b0:4864:20::529])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2C3EA60EB7
 for <virtualization@lists.linux-foundation.org>;
 Mon, 11 Apr 2022 10:47:34 +0000 (UTC)
Received: by mail-pg1-x529.google.com with SMTP id 32so11715583pgl.4
 for <virtualization@lists.linux-foundation.org>;
 Mon, 11 Apr 2022 03:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20210112.gappssmtp.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=nNtkoG484vmGA2G5o7qx9HouaOdIaIIC9BssRN2CkN8=;
 b=Jl28+bHxKSj4EvVR6PTx8cD+Dku3kkEVXpJ2j5cV6L4Oe09uqo+Q87TQ7YauNAa4N8
 H/AyVXne7/oqkEFSdvvTXgnGXwsaOdkhCE5jV1RzLnGYHcUXKdUjyBE//daaQ83vCyZX
 x7Etc5W3dj3FM1n/MqlH0vo8w/eBMougl9YuL6iREZSPxkeZs7aqgwrJKHs/N5De1CRa
 3xVbWdMZjxgVcuXGIdYd0Fzc3aZXxnYi/xe7FFjUW7UUI3VBRHAAw1S84hbjSrRn0hE9
 7NXtLsCjn82xoetFEsJFs1YHHLnI12nPQr578WKE20bv7At5VLqh7jdgGFzFE5CAgRMk
 txKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=nNtkoG484vmGA2G5o7qx9HouaOdIaIIC9BssRN2CkN8=;
 b=6cZFeMGIvOi8htGyvYYOga5XVQ1Vy6ea/wiMGaw3ymTcNijiuv5wzpA007iJo8HjDb
 35Wn+WvcwHH5O+munCM42pHAizs+nfgOnszrHUzuoT6QGOpxAETAlapkauAxXXf85OR6
 Qll8kslZG6Amihu5o6fz3jLAXp7LOsQM77LKr2dd0H+LGU5YXqoVBEWOXtyTxprSEFPf
 sNkDesfuHq3OzqUUa/zS4xwQpaPwOa/xJaVSKLFt2k6VEb78QnnKo9p8ZhrftdRoewaO
 vTD1luuPbBY/yc/4W2aN+exrg2D6ZnsPcDOesmo31MVcdX8iaKKr3fe72lux9tZzcsIR
 8cZA==
X-Gm-Message-State: AOAM532EXhWGjX3/0sNc7FvTD7hZKj1NYiL7ODOkhFCtiFpzpSnNJZ8Q
 H+chEiRax1wfaChX5K/UtIFOc0HaNlMXKQ==
X-Google-Smtp-Source: ABdhPJw0P659LxLbjlUxJjUs7jHR+6w/qBXc0gJHBGLid3ysy5CmNwC9V4RAhH6tTiTKl9BJXBmMhA==
X-Received: by 2002:a63:b246:0:b0:398:666d:d10 with SMTP id
 t6-20020a63b246000000b00398666d0d10mr25941284pgo.274.1649674053447; 
 Mon, 11 Apr 2022 03:47:33 -0700 (PDT)
Received: from always-x1.bytedance.net ([61.120.150.76])
 by smtp.gmail.com with ESMTPSA id
 d8-20020a636808000000b00398e9c7049bsm27541649pgc.31.2022.04.11.03.47.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Apr 2022 03:47:32 -0700 (PDT)
From: zhenwei pi <pizhenwei@bytedance.com>
To: mst@redhat.com,
	berrange@redhat.com,
	arei.gonglei@huawei.com
Subject: [PATCH v4 6/8] crypto: Implement RSA algorithm by gcrypt
Date: Mon, 11 Apr 2022 18:43:25 +0800
Message-Id: <20220411104327.197048-7-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220411104327.197048-1-pizhenwei@bytedance.com>
References: <20220411104327.197048-1-pizhenwei@bytedance.com>
MIME-Version: 1.0
Cc: helei.sig11@bytedance.com, cohuck@redhat.com, qemu-devel@nongnu.org,
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

Added gcryt implementation of RSA algorithm, RSA algorithm
implemented by gcrypt has a higher priority than nettle because
it supports raw padding.

Signed-off-by: Lei He <helei.sig11@bytedance.com>
---
 crypto/akcipher-gcrypt.c.inc | 531 +++++++++++++++++++++++++++++++++++
 crypto/akcipher.c            |   4 +-
 2 files changed, 534 insertions(+), 1 deletion(-)
 create mode 100644 crypto/akcipher-gcrypt.c.inc

diff --git a/crypto/akcipher-gcrypt.c.inc b/crypto/akcipher-gcrypt.c.inc
new file mode 100644
index 0000000000..c109bf0566
--- /dev/null
+++ b/crypto/akcipher-gcrypt.c.inc
@@ -0,0 +1,531 @@
+/*
+ * QEMU Crypto akcipher algorithms
+ *
+ * Copyright (c) 2022 Bytedance
+ * Author: lei he <helei.sig11@bytedance.com>
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2.1 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see <http://www.gnu.org/licenses/>.
+ *
+ */
+
+#include <stdbool.h>
+
+#include <gcrypt.h>
+
+#include "qemu/osdep.h"
+#include "qemu/host-utils.h"
+#include "asn1_decoder.h"
+#include "crypto/akcipher.h"
+#include "crypto/random.h"
+#include "qapi/error.h"
+#include "sysemu/cryptodev.h"
+#include "rsakey.h"
+
+typedef struct QCryptoGcryptRSA {
+    QCryptoAkCipher akcipher;
+    gcry_sexp_t key;
+    QCryptoRSAPaddingAlgorithm padding_alg;
+    QCryptoHashAlgorithm hash_alg;
+} QCryptoGcryptRSA;
+
+static void qcrypto_gcrypt_rsa_destroy(QCryptoGcryptRSA *rsa)
+{
+    if (!rsa) {
+        return;
+    }
+
+    gcry_sexp_release(rsa->key);
+    g_free(rsa);
+}
+
+static QCryptoGcryptRSA *qcrypto_gcrypt_rsa_new(
+    const QCryptoAkCipherOptionsRSA *opt,
+    QCryptoAkCipherKeyType type,
+    const uint8_t *key,  size_t keylen,
+    Error **errp);
+
+QCryptoAkCipher *qcrypto_akcipher_new(const QCryptoAkCipherOptions *opts,
+                                      QCryptoAkCipherKeyType type,
+                                      const uint8_t *key, size_t keylen,
+                                      Error **errp)
+{
+    switch (opts->algorithm) {
+    case QCRYPTO_AKCIPHER_ALG_RSA:
+        return (QCryptoAkCipher *)qcrypto_gcrypt_rsa_new(
+            &opts->u.rsa, type, key, keylen, errp);
+
+    default:
+        error_setg(errp, "Unsupported algorithm: %u", opts->algorithm);
+        return NULL;
+    }
+
+    return NULL;
+}
+
+static void qcrypto_gcrypt_set_rsa_size(QCryptoAkCipher *akcipher, gcry_mpi_t n)
+{
+    size_t key_size = (gcry_mpi_get_nbits(n) + 7) / 8;
+    akcipher->max_plaintext_len = key_size;
+    akcipher->max_ciphertext_len = key_size;
+    akcipher->max_dgst_len = key_size;
+    akcipher->max_signature_len = key_size;
+}
+
+static int qcrypto_gcrypt_parse_rsa_private_key(
+    QCryptoGcryptRSA *rsa,
+    const uint8_t *key, size_t keylen)
+{
+    QCryptoAkCipherRSAKey *rsa_key =
+        qcrypto_akcipher_parse_rsa_private_key(key, keylen);
+    gcry_mpi_t n = NULL, e = NULL, d = NULL, p = NULL, q = NULL, u = NULL;
+    int ret = -1;
+    bool compute_mul_inv = false;
+    gcry_error_t err;
+    if (!rsa_key) {
+        return ret;
+    }
+
+    err = gcry_mpi_scan(&n, GCRYMPI_FMT_STD,
+                        rsa_key->n.data, rsa_key->n.len, NULL);
+    if (gcry_err_code(err) != 0) {
+        goto clear;
+    }
+
+    err = gcry_mpi_scan(&e, GCRYMPI_FMT_STD,
+                        rsa_key->e.data, rsa_key->e.len, NULL);
+    if (gcry_err_code(err) != 0) {
+        goto clear;
+    }
+
+    err = gcry_mpi_scan(&d, GCRYMPI_FMT_STD,
+                        rsa_key->d.data, rsa_key->d.len, NULL);
+    if (gcry_err_code(err) != 0) {
+        goto clear;
+    }
+
+    err = gcry_mpi_scan(&p, GCRYMPI_FMT_STD,
+                        rsa_key->p.data, rsa_key->p.len, NULL);
+    if (gcry_err_code(err) != 0) {
+        goto clear;
+    }
+
+    err = gcry_mpi_scan(&q, GCRYMPI_FMT_STD,
+                        rsa_key->q.data, rsa_key->q.len, NULL);
+    if (gcry_err_code(err) != 0) {
+        goto clear;
+    }
+
+    if (gcry_mpi_cmp_ui(p, 0) > 0 && gcry_mpi_cmp_ui(q, 0) > 0) {
+        compute_mul_inv = true;
+
+        u = gcry_mpi_new(0);
+        if (gcry_mpi_cmp(p, q) > 0) {
+            gcry_mpi_swap(p, q);
+        }
+        gcry_mpi_invm(u, p, q);
+    }
+
+    if (compute_mul_inv) {
+        err = gcry_sexp_build(&rsa->key, NULL,
+            "(private-key (rsa (n %m) (e %m) (d %m) (p %m) (q %m) (u %m)))",
+            n, e, d, p, q, u);
+    } else {
+        err = gcry_sexp_build(&rsa->key, NULL,
+            "(private-key (rsa (n %m) (e %m) (d %m)))", n, e, d);
+    }
+    if (gcry_err_code(err) != 0) {
+        goto clear;
+    }
+    qcrypto_gcrypt_set_rsa_size((QCryptoAkCipher *)rsa,  n);
+    ret = 0;
+
+clear:
+    qcrypto_akcipher_free_rsa_key(rsa_key);
+    gcry_mpi_release(n);
+    gcry_mpi_release(e);
+    gcry_mpi_release(d);
+    gcry_mpi_release(p);
+    gcry_mpi_release(q);
+    gcry_mpi_release(u);
+    return ret;
+}
+
+static int qcrypto_gcrypt_parse_rsa_public_key(QCryptoGcryptRSA *rsa,
+                                               const uint8_t *key,
+                                               size_t keylen)
+{
+
+    QCryptoAkCipherRSAKey *rsa_key =
+        qcrypto_akcipher_parse_rsa_public_key(key, keylen);
+    gcry_mpi_t n = NULL, e = NULL;
+    int ret = -1;
+    gcry_error_t err;
+    if (!rsa_key) {
+        return ret;
+    }
+
+    err = gcry_mpi_scan(&n, GCRYMPI_FMT_STD,
+                        rsa_key->n.data, rsa_key->n.len, NULL);
+    if (gcry_err_code(err) != 0) {
+        goto clear;
+    }
+
+    err = gcry_mpi_scan(&e, GCRYMPI_FMT_STD,
+                        rsa_key->e.data, rsa_key->e.len, NULL);
+    if (gcry_err_code(err) != 0) {
+        goto clear;
+    }
+
+    err = gcry_sexp_build(&rsa->key, NULL,
+                          "(public-key (rsa (n %m) (e %m)))", n, e);
+    if (gcry_err_code(err) != 0) {
+        goto clear;
+    }
+    qcrypto_gcrypt_set_rsa_size((QCryptoAkCipher *)rsa, n);
+    ret = 0;
+
+clear:
+    qcrypto_akcipher_free_rsa_key(rsa_key);
+    gcry_mpi_release(n);
+    gcry_mpi_release(e);
+    return ret;
+}
+
+static int qcrypto_gcrypt_rsa_encrypt(QCryptoAkCipher *akcipher,
+                                      const void *in, size_t in_len,
+                                      void *out, size_t out_len,
+                                      Error **errp)
+{
+    QCryptoGcryptRSA *rsa =
+        container_of(akcipher, QCryptoGcryptRSA, akcipher);
+    int ret = -1;
+    gcry_sexp_t data_sexp = NULL, cipher_sexp = NULL;
+    gcry_sexp_t cipher_sexp_item = NULL;
+    gcry_mpi_t cipher_mpi = NULL;
+    const char *result;
+    gcry_error_t err;
+    size_t actual_len;
+
+    if (in_len > akcipher->max_plaintext_len) {
+        error_setg(errp, "Invalid buffer size");
+        return ret;
+    }
+
+    err = gcry_sexp_build(&data_sexp, NULL,
+                          "(data (flags %s) (value %b))",
+                          QCryptoRSAPaddingAlgorithm_str(rsa->padding_alg),
+                          in_len, in);
+    if (gcry_err_code(err) != 0) {
+        goto clear;
+    }
+
+    err = gcry_pk_encrypt(&cipher_sexp, data_sexp, rsa->key);
+    if (gcry_err_code(err) != 0) {
+        goto clear;
+    }
+
+    /* S-expression of cipher: (enc-val (rsa (a a-mpi))) */
+    cipher_sexp_item = gcry_sexp_find_token(cipher_sexp, "a", 0);
+    if (!cipher_sexp_item || gcry_sexp_length(cipher_sexp_item) != 2) {
+        goto clear;
+    }
+
+    if (rsa->padding_alg == QCRYPTO_RSA_PADDING_ALG_RAW) {
+        cipher_mpi = gcry_sexp_nth_mpi(cipher_sexp_item, 1, GCRYMPI_FMT_USG);
+        if (!cipher_mpi) {
+            goto clear;
+        }
+        err = gcry_mpi_print(GCRYMPI_FMT_USG, out, out_len,
+                             &actual_len, cipher_mpi);
+        if (gcry_err_code(err) != 0 || actual_len > out_len) {
+            goto clear;
+        }
+
+        /* We always padding leading-zeros for RSA-RAW */
+        if (actual_len < out_len) {
+            memmove((uint8_t *)out + (out_len - actual_len), out, actual_len);
+            memset(out, 0, out_len - actual_len);
+        }
+        ret = out_len;
+
+    } else {
+        result = gcry_sexp_nth_data(cipher_sexp_item, 1, &actual_len);
+        if (!result || actual_len > out_len) {
+            goto clear;
+        }
+        memcpy(out, result, actual_len);
+        ret = actual_len;
+    }
+
+clear:
+    gcry_sexp_release(data_sexp);
+    gcry_sexp_release(cipher_sexp);
+    gcry_sexp_release(cipher_sexp_item);
+    gcry_mpi_release(cipher_mpi);
+    return ret;
+}
+
+static int qcrypto_gcrypt_rsa_decrypt(QCryptoAkCipher *akcipher,
+                                      const void *in, size_t in_len,
+                                      void *out, size_t out_len,
+                                      Error **errp)
+{
+    QCryptoGcryptRSA *rsa =
+        container_of(akcipher, QCryptoGcryptRSA, akcipher);
+    int ret = -1;
+    gcry_sexp_t data_sexp = NULL, cipher_sexp = NULL;
+    gcry_mpi_t data_mpi = NULL;
+    gcry_error_t err;
+    size_t actual_len;
+    const char *result;
+
+    if (in_len > akcipher->max_ciphertext_len) {
+        error_setg(errp, "Invalid buffer size");
+        return ret;
+    }
+
+    err = gcry_sexp_build(&cipher_sexp, NULL,
+                          "(enc-val (flags %s) (rsa (a %b) ))",
+                          QCryptoRSAPaddingAlgorithm_str(rsa->padding_alg),
+                          in_len, in);
+    if (gcry_err_code(err) != 0) {
+        goto clear;
+    }
+
+    err = gcry_pk_decrypt(&data_sexp, cipher_sexp, rsa->key);
+    if (gcry_err_code(err) != 0) {
+        goto clear;
+    }
+
+    /* S-expression of cipher: (value plaintext) */
+    if (rsa->padding_alg == QCRYPTO_RSA_PADDING_ALG_RAW) {
+        data_mpi = gcry_sexp_nth_mpi(data_sexp, 1, GCRYMPI_FMT_USG);
+        if (!data_mpi) {
+            goto clear;
+        }
+        err = gcry_mpi_print(GCRYMPI_FMT_USG, out, out_len,
+                             &actual_len, data_mpi);
+        if (gcry_err_code(err) != 0) {
+            goto clear;
+        }
+         if (actual_len > out_len) {
+            goto clear;
+        }
+        /* We always padding leading-zeros for RSA-RAW */
+        if (actual_len < out_len) {
+            memmove((uint8_t *)out + (out_len - actual_len), out, actual_len);
+            memset(out, 0, out_len - actual_len);
+        }
+        ret = out_len;
+    } else {
+        result = gcry_sexp_nth_data(data_sexp, 1, &actual_len);
+        if (!result || actual_len > out_len) {
+            goto clear;
+        }
+        memcpy(out, result, actual_len);
+        ret = actual_len;
+    }
+
+clear:
+    gcry_sexp_release(cipher_sexp);
+    gcry_sexp_release(data_sexp);
+    gcry_mpi_release(data_mpi);
+    return ret;
+}
+
+static int qcrypto_gcrypt_rsa_sign(QCryptoAkCipher *akcipher,
+                                   const void *in, size_t in_len,
+                                   void *out, size_t out_len, Error **errp)
+{
+    QCryptoGcryptRSA *rsa =
+        container_of(akcipher, QCryptoGcryptRSA, akcipher);
+    int ret = -1;
+    gcry_sexp_t dgst_sexp = NULL, sig_sexp = NULL;
+    gcry_sexp_t sig_sexp_item = NULL;
+    const char *result;
+    gcry_error_t err;
+    size_t actual_len;
+
+    if (in_len > akcipher->max_dgst_len) {
+        error_setg(errp, "Invalid buffer size");
+        return ret;
+    }
+
+    if (rsa->padding_alg != QCRYPTO_RSA_PADDING_ALG_PKCS1) {
+        return ret;
+    }
+    err = gcry_sexp_build(&dgst_sexp, NULL,
+                          "(data (flags pkcs1) (hash %s %b))",
+                          QCryptoHashAlgorithm_str(rsa->hash_alg),
+                          in_len, in);
+
+    if (gcry_err_code(err) != 0) {
+        goto clear;
+    }
+
+    err = gcry_pk_sign(&sig_sexp, dgst_sexp, rsa->key);
+    if (gcry_err_code(err) != 0) {
+        goto clear;
+    }
+
+    /* S-expression of signature: (sig-val (rsa (s s-mpi))) */
+    sig_sexp_item = gcry_sexp_find_token(sig_sexp, "s", 0);
+    if (!sig_sexp_item || gcry_sexp_length(sig_sexp_item) != 2) {
+        goto clear;
+    }
+
+    result = gcry_sexp_nth_data(sig_sexp_item, 1, &actual_len);
+    if (!result || actual_len > out_len) {
+        goto clear;
+     }
+    memcpy(out, result, actual_len);
+    ret = actual_len;
+
+clear:
+    gcry_sexp_release(dgst_sexp);
+    gcry_sexp_release(sig_sexp);
+    gcry_sexp_release(sig_sexp_item);
+
+    return ret;
+}
+
+static int qcrypto_gcrypt_rsa_verify(QCryptoAkCipher *akcipher,
+                                     const void *in, size_t in_len,
+                                     const void *in2, size_t in2_len,
+                                     Error **errp)
+{
+    QCryptoGcryptRSA *rsa =
+        container_of(akcipher, QCryptoGcryptRSA, akcipher);
+    int ret = -1;
+    gcry_sexp_t sig_sexp = NULL, dgst_sexp = NULL;
+    gcry_error_t err;
+
+    if (in_len > akcipher->max_signature_len ||
+        in2_len > akcipher->max_dgst_len) {
+        error_setg(errp, "Invalid buffer size");
+        return ret;
+    }
+
+    if (rsa->padding_alg != QCRYPTO_RSA_PADDING_ALG_PKCS1) {
+        error_setg(errp, "Invalid padding %u", rsa->padding_alg);
+        return ret;
+    }
+
+    err = gcry_sexp_build(&sig_sexp, NULL,
+                          "(sig-val (rsa (s %b)))", in_len, in);
+    if (gcry_err_code(err) != 0) {
+        goto clear;
+    }
+
+    err = gcry_sexp_build(&dgst_sexp, NULL,
+                          "(data (flags pkcs1) (hash %s %b))",
+                          QCryptoHashAlgorithm_str(rsa->hash_alg),
+                          in2_len, in2);
+    if (gcry_err_code(err) != 0) {
+        goto clear;
+    }
+
+    err = gcry_pk_verify(sig_sexp, dgst_sexp, rsa->key);
+    if (gcry_err_code(err) == 0) {
+        ret = 0;
+    }
+
+clear:
+    gcry_sexp_release(dgst_sexp);
+    gcry_sexp_release(sig_sexp);
+
+    return ret;
+}
+
+static int qcrypto_gcrypt_rsa_free(QCryptoAkCipher *akcipher,
+                                   Error **errp)
+{
+    qcrypto_gcrypt_rsa_destroy((QCryptoGcryptRSA *)akcipher);
+    return 0;
+}
+
+QCryptoAkCipherDriver gcrypt_rsa = {
+    .encrypt = qcrypto_gcrypt_rsa_encrypt,
+    .decrypt = qcrypto_gcrypt_rsa_decrypt,
+    .sign = qcrypto_gcrypt_rsa_sign,
+    .verify = qcrypto_gcrypt_rsa_verify,
+    .free = qcrypto_gcrypt_rsa_free,
+};
+
+static QCryptoGcryptRSA *qcrypto_gcrypt_rsa_new(
+    const QCryptoAkCipherOptionsRSA *opt,
+    QCryptoAkCipherKeyType type,
+    const uint8_t *key, size_t keylen,
+    Error **errp)
+{
+    QCryptoGcryptRSA *rsa = g_new0(QCryptoGcryptRSA, 1);
+    rsa->padding_alg = opt->padding_alg;
+    rsa->hash_alg = opt->hash_alg;
+    rsa->akcipher.driver = &gcrypt_rsa;
+
+    switch (type) {
+    case QCRYPTO_AKCIPHER_KEY_TYPE_PRIVATE:
+        if (qcrypto_gcrypt_parse_rsa_private_key(rsa, key, keylen) != 0) {
+            error_setg(errp, "Failed to parse rsa private key");
+            goto err;
+        }
+        break;
+
+    case QCRYPTO_AKCIPHER_KEY_TYPE_PUBLIC:
+        if (qcrypto_gcrypt_parse_rsa_public_key(rsa, key, keylen) != 0) {
+            error_setg(errp, "Failed to parse rsa public rsa key");
+            goto err;
+        }
+        break;
+
+    default:
+        error_setg(errp, "Unknown akcipher key type %d", type);
+    }
+
+    return rsa;
+
+err:
+    qcrypto_gcrypt_rsa_destroy(rsa);
+    return NULL;
+}
+
+
+bool qcrypto_akcipher_supports(QCryptoAkCipherOptions *opts)
+{
+    switch (opts->algorithm) {
+    case QCRYPTO_AKCIPHER_ALG_RSA:
+        switch (opts->u.rsa.padding_alg) {
+        case QCRYPTO_RSA_PADDING_ALG_RAW:
+            return true;
+
+        case QCRYPTO_RSA_PADDING_ALG_PKCS1:
+            switch (opts->u.rsa.hash_alg) {
+            case QCRYPTO_HASH_ALG_MD5:
+            case QCRYPTO_HASH_ALG_SHA1:
+            case QCRYPTO_HASH_ALG_SHA256:
+            case QCRYPTO_HASH_ALG_SHA512:
+                return true;
+
+            default:
+                return false;
+            }
+
+        default:
+            return false;
+        }
+
+    default:
+        return true;
+    }
+}
diff --git a/crypto/akcipher.c b/crypto/akcipher.c
index dc29127bb4..5c60d54565 100644
--- a/crypto/akcipher.c
+++ b/crypto/akcipher.c
@@ -23,7 +23,9 @@
 #include "crypto/akcipher.h"
 #include "akcipherpriv.h"
 
-#if defined(CONFIG_NETTLE) && defined(CONFIG_HOGWEED)
+#if defined(CONFIG_GCRYPT)
+#include "akcipher-gcrypt.c.inc"
+#elif defined(CONFIG_NETTLE) && defined(CONFIG_HOGWEED)
 #include "akcipher-nettle.c.inc"
 #else
 QCryptoAkCipher *qcrypto_akcipher_new(const QCryptoAkCipherOptions *opts,
-- 
2.20.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
