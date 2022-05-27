Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1535CC433EF
	for <virtualization@archiver.kernel.org>; Fri, 27 May 2022 08:51:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A0163843A1;
	Fri, 27 May 2022 08:51:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YEN44JXs_tO6; Fri, 27 May 2022 08:51:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 21C2684330;
	Fri, 27 May 2022 08:51:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DAEA3C0032;
	Fri, 27 May 2022 08:51:42 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4F755C002D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 May 2022 08:51:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 377384283D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 May 2022 08:51:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=bytedance-com.20210112.gappssmtp.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fu32dmgigKOO
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 May 2022 08:51:39 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com
 [IPv6:2607:f8b0:4864:20::102b])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 84AC74280C
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 May 2022 08:51:39 +0000 (UTC)
Received: by mail-pj1-x102b.google.com with SMTP id cv10so4008368pjb.4
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 May 2022 01:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20210112.gappssmtp.com; s=20210112;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=PG+uprLo7VOoHUBnmUgR2afDgCJUN3g8BoyoNV69pwY=;
 b=FUcJmAh0SRom7p4snGfbkdrMch+MvdUrGOBW2OdxvKGpj5zyBzqdwTINULwmYJVxZ1
 qJNTbOEmhYd66R66p4QOWdbrMxzqnL/JP3wB0JGPJmlichjLmKflZzNpLbBwpUpdIhJm
 dj9Qqp5noHsW+goU44wZ+qDKAMT6JYnKjN/4NwmDyUEy2ozvt7uR8UqdsRly2dxHa79E
 Z7hddWUBLiVXYcl9PdAA7UXHmu5SqdSs2cdpgSbKrWzf863hmakp801JErgSo6auZRnb
 mLdp5ESyuuCZDvN4aKvAmKW2s7xnIwxbhf9f7N6f7EOKMaJu2QZ6BJfEle2ag/XzYfYR
 0BuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=PG+uprLo7VOoHUBnmUgR2afDgCJUN3g8BoyoNV69pwY=;
 b=mlwE7BhxDLiQ7X642PuakROmf41lg4CasFTVKCnu95byGCSL3Up6ED4869ZF+cnypN
 Fg3lMeYkFBqA17FiSZC2MuG7zdnLjWSqQc4uZsIICx4Uy4d8il0sTK9Er2nbU2d+UH0e
 pTOg62o7OkXz9Lr0zZzexwk2nxmLGvsZj9la+6kUy5eyUfRx/fRSdxZ/LpPseYdenJtJ
 Tu9tHdylYDkBUbGUcHXTFC/+UV97seVrnC49kTCAX6zpahSW9N3DXJuSe5yrjUpiCC9C
 Xhc1wYCtlPgYv1fGRIH5nGVMuhkAOYYzHCUQAMjCrtoxJeFEeAEtsJFrTo451c/c7bl9
 KWZw==
X-Gm-Message-State: AOAM533Q0n8u33/xl/h9lpp+zyjQROm4U43ZLvKQsyYxDusR1W+E+rag
 sngSGpSoN59qs29EbHEdmNNt9w==
X-Google-Smtp-Source: ABdhPJzixZp1Muxj0UjD0Pj4mAPb5akUvRL5t12RiI7j15G8uBwdlF4Spf796wrL8qV1s9WpWQdJpg==
X-Received: by 2002:a17:902:6b03:b0:161:51d6:61b with SMTP id
 o3-20020a1709026b0300b0016151d6061bmr18008014plk.23.1653641498648; 
 Fri, 27 May 2022 01:51:38 -0700 (PDT)
Received: from always-x1.www.tendawifi.com ([139.177.225.235])
 by smtp.gmail.com with ESMTPSA id
 191-20020a6215c8000000b0050dc762816bsm2891367pfv.69.2022.05.27.01.51.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 May 2022 01:51:37 -0700 (PDT)
From: zhenwei pi <pizhenwei@bytedance.com>
To: mst@redhat.com,
	arei.gonglei@huawei.com
Subject: Introduce akcipher service for virtio-crypto
Date: Fri, 27 May 2022 16:47:33 +0800
Message-Id: <20220527084734.2649594-1-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Cc: helei.sig11@bytedance.com, berrange@redhat.com, qemu-devel@nongnu.org,
 zhenwei pi <pizhenwei@bytedance.com>,
 virtualization@lists.linux-foundation.org
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

v7 - v8:
- The changes of QEMU crypto has been reviewed & merged by Daniel,
  remove this part from this series. Thanks to Daniel!
- virtio_crypto.h is updated by e4082063e47e
  ("linux-headers: Update to v5.18-rc6"), remove from this series.
- Minor fixes reviewed by Gonglei. Thanks to Gonglei!

v6 -> v7:
- Fix serval build errors for some specific platforms/configurations.
- Use '%zu' instead of '%lu' for size_t parameters.
- AkCipher-gcrypt: avoid setting wrong error messages when parsing RSA
  keys.
- AkCipher-benchmark: process constant amount of sign/verify instead
 of running sign/verify for a constant duration.

v5 -> v6:
- Fix build errors and codestyles.
- Add parameter 'Error **errp' for qcrypto_akcipher_rsakey_parse.
- Report more detailed errors.
- Fix buffer length check and return values of akcipher-nettle, allows caller to
 pass a buffer with larger size than actual needed.

A million thanks to Daniel!

v4 -> v5:
- Move QCryptoAkCipher into akcipherpriv.h, and modify the related comments.
- Rename asn1_decoder.c to der.c.
- Code style fix: use 'cleanup' & 'error' lables.
- Allow autoptr type to auto-free.
- Add test cases for rsakey to handle DER error.
- Other minor fixes.

v3 -> v4:
- Coding style fix: Akcipher -> AkCipher, struct XXX -> XXX, Rsa -> RSA,
XXX-alg -> XXX-algo.
- Change version info in qapi/crypto.json, from 7.0 -> 7.1.
- Remove ecdsa from qapi/crypto.json, it would be introduced with the implemetion later.
- Use QCryptoHashAlgothrim instead of QCryptoRSAHashAlgorithm(removed) in qapi/crypto.json.
- Rename arguments of qcrypto_akcipher_XXX to keep aligned with qcrypto_cipher_XXX(dec/enc/sign/vefiry -> in/out/in2), and add qcrypto_akcipher_max_XXX APIs.
- Add new API: qcrypto_akcipher_supports.
- Change the return value of qcrypto_akcipher_enc/dec/sign, these functions return the actual length of result.
- Separate ASN.1 source code and test case clean.
- Disable RSA raw encoding for akcipher-nettle.
- Separate RSA key parser into rsakey.{hc}, and implememts it with builtin-asn1-decoder and nettle respectivly.
- Implement RSA(pkcs1 and raw encoding) algorithm by gcrypt. This has higher priority than nettle.
- For some akcipher operations(eg, decryption of pkcs1pad(rsa)), the length of returned result maybe less than the dst buffer size, return the actual length of result instead of the buffer length to the guest side. (in function virtio_crypto_akcipher_input_data_helper)
- Other minor changes.

Thanks to Daniel!

Eric pointed out this missing part of use case, send it here again.

In our plan, the feature is designed for HTTPS offloading case and other applications which use kernel RSA/ecdsa by keyctl syscall. The full picture shows bellow:


                 Nginx/openssl[1] ... Apps
Guest   -----------------------------------------
                  virtio-crypto driver[2]
-------------------------------------------------
                  virtio-crypto backend[3]
Host    -----------------------------------------
                 /          |          \
             builtin[4]   vhost     keyctl[5] ...


[1] User applications can offload RSA calculation to kernel by keyctl syscall. There is no keyctl engine in openssl currently, we developed a engine and tried to contribute it to openssl upstream, but openssl 1.x does not accept new feature. Link:
   https://github.com/openssl/openssl/pull/16689

This branch is available and maintained by Lei <helei.sig11@bytedance.com>
   https://github.com/TousakaRin/openssl/tree/OpenSSL_1_1_1-kctl_engine

We tested nginx(change config file only) with openssl keyctl engine, it works fine.

[2] virtio-crypto driver is used to communicate with host side, send requests to host side to do asymmetric calculation.
   https://lkml.org/lkml/2022/3/1/1425

[3] virtio-crypto backend handles requests from guest side, and forwards request to crypto backend driver of QEMU.

[4] Currently RSA is supported only in builtin driver. This driver is supposed to test the full feature without other software(Ex vhost process) and hardware dependence. ecdsa is introduced into qapi type without implementation, this may be implemented in Q3-2022 or later. If ecdsa type definition should be added with the implementation together, I'll remove this in next version.

[5] keyctl backend is in development, we will post this feature in Q2-2022. keyctl backend can use hardware acceleration(Ex, Intel QAT).

Setup the full environment, tested with Intel QAT on host side, the QPS of HTTPS increase to ~200% in a guest.

VS PCI passthrough: the most important benefit of this solution makes the VM migratable.

v2 -> v3:
- Introduce akcipher types to qapi
- Add test/benchmark suite for akcipher class
- Seperate 'virtio_crypto: Support virtio crypto asym operation' into:
 - crypto: Introduce akcipher crypto class
 - virtio-crypto: Introduce RSA algorithm

v1 -> v2:
- Update virtio_crypto.h from v2 version of related kernel patch.

v1:
- Support akcipher for virtio-crypto.
- Introduce akcipher class.
- Introduce ASN1 decoder into QEMU.
- Implement RSA backend by nettle/hogweed.

Zhenwei Pi (1):
  crypto: Introduce RSA algorithm

 backends/cryptodev-builtin.c      | 274 +++++++++++++++++++++----
 backends/cryptodev-vhost-user.c   |  34 +++-
 backends/cryptodev.c              |  32 ++-
 hw/virtio/virtio-crypto.c         | 323 ++++++++++++++++++++++++------
 include/hw/virtio/virtio-crypto.h |   5 +-
 include/sysemu/cryptodev.h        |  83 ++++++--
 6 files changed, 607 insertions(+), 144 deletions(-)

-- 
2.20.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
