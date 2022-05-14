Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB317C433EF
	for <virtualization@archiver.kernel.org>; Sat, 14 May 2022 00:59:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9779B60EA9;
	Sat, 14 May 2022 00:59:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gxieQ1siNOAk; Sat, 14 May 2022 00:59:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id B12F660E87;
	Sat, 14 May 2022 00:59:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 96427C0039;
	Sat, 14 May 2022 00:59:47 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 78A17C002D
 for <virtualization@lists.linux-foundation.org>;
 Sat, 14 May 2022 00:59:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 594AD83F93
 for <virtualization@lists.linux-foundation.org>;
 Sat, 14 May 2022 00:59:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=bytedance-com.20210112.gappssmtp.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Sonjtvq6qNp0
 for <virtualization@lists.linux-foundation.org>;
 Sat, 14 May 2022 00:59:45 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com
 [IPv6:2607:f8b0:4864:20::102d])
 by smtp1.osuosl.org (Postfix) with ESMTPS id F14D183F9D
 for <virtualization@lists.linux-foundation.org>;
 Sat, 14 May 2022 00:59:44 +0000 (UTC)
Received: by mail-pj1-x102d.google.com with SMTP id fv2so9440219pjb.4
 for <virtualization@lists.linux-foundation.org>;
 Fri, 13 May 2022 17:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20210112.gappssmtp.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=h34AXTj+8XUDrvB6MUnog+G/Mps9P+4k/0m79B0Juyk=;
 b=Gv8pKSglvH5a5FyHPh8FedxfR6/+yWjEuWXTKSfYfNg5JZAi2NN5VMWPt4ee4FBj43
 av3hOrGGfGYZeKR0cSeHUGAzFxhHVDvGn7VJnVKyEd/tAfOgYY63AoSqajftZsDvKHKT
 AHqwj+nV4qxyu1kWDY9II5KJU9FV2sTw+a23bn+zzUJnoygWPNw8Pj2642AkzYb+a7/E
 ZI3mWepUwMMlk0A9UZyBeH9arseKMJCfrdq4l7NekWWGSaVm2EHrJG7yL2+fyNfCXKA8
 MjKSXi+OHGbJS/huFNMr2xnwAPHWwxsK+2LMd7I+So07VyYnwXzwqajt37mVd97Ku2Ty
 lOkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=h34AXTj+8XUDrvB6MUnog+G/Mps9P+4k/0m79B0Juyk=;
 b=T7a09l4pVHxDSmy4y0ePPBmdw6A/OFRl6m+nbliABtMDbyF3ESG4GbxxJizHNvNy2a
 0fyQVyvxHe8wblsw7VOcyyOEI5k12smZuWsDhmfxAn832FE4fxqtRRPSd/vZwCbvEPpz
 yclazvDKlXXF5ls3DGKMgPr+xHohK2c/5vhJgmMXd7dWTZVMEpe2mbnysxPCPzFVrg84
 u0ZnFoTwIBdIxH1juE3dui1dyXVDBbpKO5/Dq4tr4aF+nBUVoLCX7EYV2p0HZ7JN2Bc0
 Rje76LsanC+0PXM5aXiW6xihgonUFORVPss4PxlRUS4WyHMZ8RNg1HqFRfhsLcT32wRR
 Wq8g==
X-Gm-Message-State: AOAM530ZerXm79JEbmUcjHmJomvnn//oE8xPjisYpDeQTXlm5hIF7UgU
 pRqRLws7E15CuU4XHJ1CgjvLyPCKUJ5zhA==
X-Google-Smtp-Source: ABdhPJwKNXpv6ys3t5ZQgXZ8kQmZngYVkPBd0w14p7J13IRwVJ7tkyZpsqTNpeBcIB0d7P5ySKz9+g==
X-Received: by 2002:a17:902:f650:b0:15f:3a10:a020 with SMTP id
 m16-20020a170902f65000b0015f3a10a020mr7187672plg.61.1652489984280; 
 Fri, 13 May 2022 17:59:44 -0700 (PDT)
Received: from always-x1.www.tendawifi.com ([139.177.225.239])
 by smtp.gmail.com with ESMTPSA id
 t24-20020a170902b21800b0015e8d4eb1dbsm2466125plr.37.2022.05.13.17.59.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 May 2022 17:59:43 -0700 (PDT)
From: zhenwei pi <pizhenwei@bytedance.com>
To: mst@redhat.com,
	arei.gonglei@huawei.com,
	berrange@redhat.com
Subject: [PATCH v6 6/9] crypto: Implement RSA algorithm by gcrypt
Date: Sat, 14 May 2022 08:55:01 +0800
Message-Id: <20220514005504.1042884-7-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220514005504.1042884-1-pizhenwei@bytedance.com>
References: <20220514005504.1042884-1-pizhenwei@bytedance.com>
MIME-Version: 1.0
Cc: helei.sig11@bytedance.com, cohuck@redhat.com, qemu-devel@nongnu.org,
 pizhenwei@bytedance.com, virtualization@lists.linux-foundation.org,
 linux-crypto@vger.kernel.org
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

Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
Signed-off-by: lei he <helei.sig11@bytedance.com>
---
 crypto/akcipher-gcrypt.c.inc | 597 +++++++++++++++++++++++++++++++++++
 crypto/akcipher.c            |   4 +-
 2 files changed, 600 insertions(+), 1 deletion(-)
 create mode 100644 crypto/akcipher-gcrypt.c.inc

diff --git a/crypto/akcipher-gcrypt.c.inc b/crypto/akcipher-gcrypt.c.inc
new file mode 100644
index 0000000000..6c5daa301e
--- /dev/null
+++ b/crypto/akcipher-gcrypt.c.inc
@@ -0,0 +1,597 @@
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
+#include <gcrypt.h>
+
+#include "qemu/osdep.h"
+#include "qemu/host-utils.h"
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
+static void qcrypto_gcrypt_rsa_free(QCryptoAkCipher *akcipher)
+{
+    QCryptoGcryptRSA *rsa = (QCryptoGcryptRSA *)akcipher;
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
+    switch (opts->alg) {
+    case QCRYPTO_AKCIPHER_ALG_RSA:
+        return (QCryptoAkCipher *)qcrypto_gcrypt_rsa_new(
+            &opts->u.rsa, type, key, keylen, errp);
+
+    default:
+        error_setg(errp, "Unsupported algorithm: %u", opts->alg);
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
+    const uint8_t *key, size_t keylen, Error **errp)
+{
+    g_autoptr(QCryptoAkCipherRSAKey) rsa_key = qcrypto_akcipher_rsakey_parse(
+        QCRYPTO_AKCIPHER_KEY_TYPE_PRIVATE, key, keylen, errp);
+    gcry_mpi_t n = NULL, e = NULL, d = NULL, p = NULL, q = NULL, u = NULL;
+    bool compute_mul_inv = false;
+    int ret = -1;
+    gcry_error_t err;
+
+    if (!rsa_key) {
+        return ret;
+    }
+
+    err = gcry_mpi_scan(&n, GCRYMPI_FMT_STD,
+                        rsa_key->n.data, rsa_key->n.len, NULL);
+    if (gcry_err_code(err) != 0) {
+        error_setg(errp, "Failed to parse RSA parameter n: %s/%s",
+                   gcry_strsource(err), gcry_strerror(err));
+        goto cleanup;
+    }
+
+    err = gcry_mpi_scan(&e, GCRYMPI_FMT_STD,
+                        rsa_key->e.data, rsa_key->e.len, NULL);
+    if (gcry_err_code(err) != 0) {
+        error_setg(errp, "Failed to parse RSA parameter e: %s/%s",
+                   gcry_strsource(err), gcry_strerror(err));
+        goto cleanup;
+    }
+
+    err = gcry_mpi_scan(&d, GCRYMPI_FMT_STD,
+                        rsa_key->d.data, rsa_key->d.len, NULL);
+    if (gcry_err_code(err) != 0) {
+        error_setg(errp, "Failed to parse RSA parameter d: %s/%s",
+                   gcry_strsource(err), gcry_strerror(err));
+        goto cleanup;
+    }
+
+    err = gcry_mpi_scan(&p, GCRYMPI_FMT_STD,
+                        rsa_key->p.data, rsa_key->p.len, NULL);
+    if (gcry_err_code(err) != 0) {
+        error_setg(errp, "Failed to parse RSA parameter p: %s/%s",
+                   gcry_strsource(err), gcry_strerror(err));
+        goto cleanup;
+    }
+
+    err = gcry_mpi_scan(&q, GCRYMPI_FMT_STD,
+                        rsa_key->q.data, rsa_key->q.len, NULL);
+    if (gcry_err_code(err) != 0) {
+        error_setg(errp, "Failed to parse RSA parameter q: %s/%s",
+                   gcry_strsource(err), gcry_strerror(err));
+        goto cleanup;
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
+        error_setg(errp, "Failed to build RSA private key: %s/%s",
+                   gcry_strsource(err), gcry_strerror(err));
+        goto cleanup;
+    }
+    qcrypto_gcrypt_set_rsa_size((QCryptoAkCipher *)rsa,  n);
+    ret = 0;
+
+cleanup:
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
+                                               size_t keylen,
+                                               Error **errp)
+{
+
+    g_autoptr(QCryptoAkCipherRSAKey) rsa_key = qcrypto_akcipher_rsakey_parse(
+        QCRYPTO_AKCIPHER_KEY_TYPE_PUBLIC, key, keylen, errp);
+    gcry_mpi_t n = NULL, e = NULL;
+    int ret = -1;
+    gcry_error_t err;
+
+    if (!rsa_key) {
+        return ret;
+    }
+
+    err = gcry_mpi_scan(&n, GCRYMPI_FMT_STD,
+                        rsa_key->n.data, rsa_key->n.len, NULL);
+    if (gcry_err_code(err) != 0) {
+        error_setg(errp, "Failed to parse RSA parameter n: %s/%s",
+                   gcry_strsource(err), gcry_strerror(err));
+        goto cleanup;
+    }
+
+    err = gcry_mpi_scan(&e, GCRYMPI_FMT_STD,
+                        rsa_key->e.data, rsa_key->e.len, NULL);
+    if (gcry_err_code(err) != 0) {
+        error_setg(errp, "Failed to parse RSA parameter e: %s/%s",
+                   gcry_strsource(err), gcry_strerror(err));
+        goto cleanup;
+    }
+
+    err = gcry_sexp_build(&rsa->key, NULL,
+                          "(public-key (rsa (n %m) (e %m)))", n, e);
+    if (gcry_err_code(err) != 0) {
+        error_setg(errp, "Failed to build RSA public key: %s/%s",
+                   gcry_strsource(err), gcry_strerror(err));
+        goto cleanup;
+    }
+    qcrypto_gcrypt_set_rsa_size((QCryptoAkCipher *)rsa, n);
+    ret = 0;
+
+cleanup:
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
+    QCryptoGcryptRSA *rsa = (QCryptoGcryptRSA *)akcipher;
+    int ret = -1;
+    gcry_sexp_t data_sexp = NULL, cipher_sexp = NULL;
+    gcry_sexp_t cipher_sexp_item = NULL;
+    gcry_mpi_t cipher_mpi = NULL;
+    const char *result;
+    gcry_error_t err;
+    size_t actual_len;
+
+    if (in_len > akcipher->max_plaintext_len) {
+        error_setg(errp, "Plaintext length is greater than key size: %d",
+                   akcipher->max_plaintext_len);
+        return ret;
+    }
+
+    err = gcry_sexp_build(&data_sexp, NULL,
+                          "(data (flags %s) (value %b))",
+                          QCryptoRSAPaddingAlgorithm_str(rsa->padding_alg),
+                          in_len, in);
+    if (gcry_err_code(err) != 0) {
+        error_setg(errp, "Failed to build plaintext: %s/%s",
+                   gcry_strsource(err), gcry_strerror(err));
+        goto cleanup;
+    }
+
+    err = gcry_pk_encrypt(&cipher_sexp, data_sexp, rsa->key);
+    if (gcry_err_code(err) != 0) {
+        error_setg(errp, "Failed to encrypt: %s/%s",
+                   gcry_strsource(err), gcry_strerror(err));
+        goto cleanup;
+    }
+
+    /* S-expression of cipher: (enc-val (rsa (a a-mpi))) */
+    cipher_sexp_item = gcry_sexp_find_token(cipher_sexp, "a", 0);
+    if (!cipher_sexp_item || gcry_sexp_length(cipher_sexp_item) != 2) {
+        error_setg(errp, "Invalid ciphertext result");
+        goto cleanup;
+    }
+
+    if (rsa->padding_alg == QCRYPTO_RSA_PADDING_ALG_RAW) {
+        cipher_mpi = gcry_sexp_nth_mpi(cipher_sexp_item, 1, GCRYMPI_FMT_USG);
+        if (!cipher_mpi) {
+            error_setg(errp, "Invalid ciphertext result");
+            goto cleanup;
+        }
+        err = gcry_mpi_print(GCRYMPI_FMT_USG, out, out_len,
+                             &actual_len, cipher_mpi);
+        if (gcry_err_code(err) != 0) {
+            error_setg(errp, "Failed to print MPI: %s/%s",
+                       gcry_strsource(err), gcry_strerror(err));
+            goto cleanup;
+        }
+
+        if (actual_len > out_len) {
+            error_setg(errp, "Ciphertext buffer length is too small");
+            goto cleanup;
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
+        if (!result) {
+            error_setg(errp, "Invalid ciphertext result");
+            goto cleanup;
+        }
+        if (actual_len > out_len) {
+            error_setg(errp, "Ciphertext buffer length is too small");
+            goto cleanup;
+        }
+        memcpy(out, result, actual_len);
+        ret = actual_len;
+    }
+
+cleanup:
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
+    QCryptoGcryptRSA *rsa = (QCryptoGcryptRSA *)akcipher;
+    int ret = -1;
+    gcry_sexp_t data_sexp = NULL, cipher_sexp = NULL;
+    gcry_mpi_t data_mpi = NULL;
+    gcry_error_t err;
+    size_t actual_len;
+    const char *result;
+
+    if (in_len > akcipher->max_ciphertext_len) {
+        error_setg(errp, "Ciphertext length is greater than key size: %d",
+                   akcipher->max_ciphertext_len);
+        return ret;
+    }
+
+    err = gcry_sexp_build(&cipher_sexp, NULL,
+                          "(enc-val (flags %s) (rsa (a %b) ))",
+                          QCryptoRSAPaddingAlgorithm_str(rsa->padding_alg),
+                          in_len, in);
+    if (gcry_err_code(err) != 0) {
+        error_setg(errp, "Failed to build ciphertext: %s/%s",
+                   gcry_strsource(err), gcry_strerror(err));
+        goto cleanup;
+    }
+
+    err = gcry_pk_decrypt(&data_sexp, cipher_sexp, rsa->key);
+    if (gcry_err_code(err) != 0) {
+        error_setg(errp, "Failed to decrypt: %s/%s",
+                   gcry_strsource(err), gcry_strerror(err));
+        goto cleanup;
+    }
+
+    /* S-expression of plaintext: (value plaintext) */
+    if (rsa->padding_alg == QCRYPTO_RSA_PADDING_ALG_RAW) {
+        data_mpi = gcry_sexp_nth_mpi(data_sexp, 1, GCRYMPI_FMT_USG);
+        if (!data_mpi) {
+            error_setg(errp, "Invalid plaintext result");
+            goto cleanup;
+        }
+        err = gcry_mpi_print(GCRYMPI_FMT_USG, out, out_len,
+                             &actual_len, data_mpi);
+        if (gcry_err_code(err) != 0) {
+            error_setg(errp, "Failed to print MPI: %s/%s",
+                       gcry_strsource(err), gcry_strerror(err));
+            goto cleanup;
+        }
+        if (actual_len > out_len) {
+            error_setg(errp, "Plaintext buffer length is too small");
+            goto cleanup;
+        }
+        /* We always padding leading-zeros for RSA-RAW */
+        if (actual_len < out_len) {
+            memmove((uint8_t *)out + (out_len - actual_len), out, actual_len);
+            memset(out, 0, out_len - actual_len);
+        }
+        ret = out_len;
+    } else {
+        result = gcry_sexp_nth_data(data_sexp, 1, &actual_len);
+        if (!result) {
+            error_setg(errp, "Invalid plaintext result");
+            goto cleanup;
+        }
+        if (actual_len > out_len) {
+            error_setg(errp, "Plaintext buffer length is too small");
+            goto cleanup;
+        }
+        memcpy(out, result, actual_len);
+        ret = actual_len;
+    }
+
+cleanup:
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
+    QCryptoGcryptRSA *rsa = (QCryptoGcryptRSA *)akcipher;
+    int ret = -1;
+    gcry_sexp_t dgst_sexp = NULL, sig_sexp = NULL;
+    gcry_sexp_t sig_sexp_item = NULL;
+    const char *result;
+    gcry_error_t err;
+    size_t actual_len;
+
+    if (in_len > akcipher->max_dgst_len) {
+        error_setg(errp, "Data length is greater than key size: %d",
+                   akcipher->max_dgst_len);
+        return ret;
+    }
+
+    if (rsa->padding_alg != QCRYPTO_RSA_PADDING_ALG_PKCS1) {
+        error_setg(errp, "Invalid padding %u", rsa->padding_alg);
+        return ret;
+    }
+
+    err = gcry_sexp_build(&dgst_sexp, NULL,
+                          "(data (flags pkcs1) (hash %s %b))",
+                          QCryptoHashAlgorithm_str(rsa->hash_alg),
+                          in_len, in);
+    if (gcry_err_code(err) != 0) {
+        error_setg(errp, "Failed to build dgst: %s/%s",
+                   gcry_strsource(err), gcry_strerror(err));
+        goto cleanup;
+    }
+
+    err = gcry_pk_sign(&sig_sexp, dgst_sexp, rsa->key);
+    if (gcry_err_code(err) != 0) {
+        error_setg(errp, "Failed to make signature: %s/%s",
+                   gcry_strsource(err), gcry_strerror(err));
+        goto cleanup;
+    }
+
+    /* S-expression of signature: (sig-val (rsa (s s-mpi))) */
+    sig_sexp_item = gcry_sexp_find_token(sig_sexp, "s", 0);
+    if (!sig_sexp_item || gcry_sexp_length(sig_sexp_item) != 2) {
+        error_setg(errp, "Invalid signature result");
+        goto cleanup;
+    }
+
+    result = gcry_sexp_nth_data(sig_sexp_item, 1, &actual_len);
+    if (!result) {
+        error_setg(errp, "Invalid signature result");
+        goto cleanup;
+    }
+
+    if (actual_len > out_len) {
+        error_setg(errp, "Signature buffer length is too small");
+        goto cleanup;
+    }
+    memcpy(out, result, actual_len);
+    ret = actual_len;
+
+cleanup:
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
+    QCryptoGcryptRSA *rsa = (QCryptoGcryptRSA *)akcipher;
+    int ret = -1;
+    gcry_sexp_t sig_sexp = NULL, dgst_sexp = NULL;
+    gcry_error_t err;
+
+    if (in_len > akcipher->max_signature_len) {
+        error_setg(errp, "Signature length is greater than key size: %d",
+                   akcipher->max_signature_len);
+        return ret;
+    }
+
+    if (in2_len > akcipher->max_dgst_len) {
+        error_setg(errp, "Data length is greater than key size: %d",
+                   akcipher->max_dgst_len);
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
+        error_setg(errp, "Failed to build signature: %s/%s",
+                   gcry_strsource(err), gcry_strerror(err));
+        goto cleanup;
+    }
+
+    err = gcry_sexp_build(&dgst_sexp, NULL,
+                          "(data (flags pkcs1) (hash %s %b))",
+                          QCryptoHashAlgorithm_str(rsa->hash_alg),
+                          in2_len, in2);
+    if (gcry_err_code(err) != 0) {
+        error_setg(errp, "Failed to build dgst: %s/%s",
+                   gcry_strsource(err), gcry_strerror(err));
+        goto cleanup;
+    }
+
+    err = gcry_pk_verify(sig_sexp, dgst_sexp, rsa->key);
+    if (gcry_err_code(err) != 0) {
+        error_setg(errp, "Failed to verify signature: %s/%s",
+                   gcry_strsource(err), gcry_strerror(err));
+        goto cleanup;
+    }
+    ret = 0;
+
+cleanup:
+    gcry_sexp_release(dgst_sexp);
+    gcry_sexp_release(sig_sexp);
+
+    return ret;
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
+        if (qcrypto_gcrypt_parse_rsa_private_key(rsa, key, keylen, errp) != 0) {
+            error_setg(errp, "Failed to parse rsa private key");
+            goto error;
+        }
+        break;
+
+    case QCRYPTO_AKCIPHER_KEY_TYPE_PUBLIC:
+        if (qcrypto_gcrypt_parse_rsa_public_key(rsa, key, keylen, errp) != 0) {
+            error_setg(errp, "Failed to parse rsa public rsa key");
+            goto error;
+        }
+        break;
+
+    default:
+        error_setg(errp, "Unknown akcipher key type %d", type);
+        goto error;
+    }
+
+    return rsa;
+
+error:
+    qcrypto_gcrypt_rsa_free((QCryptoAkCipher *)rsa);
+    return NULL;
+}
+
+
+bool qcrypto_akcipher_supports(QCryptoAkCipherOptions *opts)
+{
+    switch (opts->alg) {
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
index f287083f92..ad88379c1e 100644
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
