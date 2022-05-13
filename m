Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 855B6C433F5
	for <virtualization@archiver.kernel.org>; Fri, 13 May 2022 10:19:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 1DB1340354;
	Fri, 13 May 2022 10:19:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IiIo5SNn2U80; Fri, 13 May 2022 10:19:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 528C14010D;
	Fri, 13 May 2022 10:19:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 32012C0039;
	Fri, 13 May 2022 10:19:17 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 195DCC002D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 13 May 2022 10:19:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 011BF417BC
 for <virtualization@lists.linux-foundation.org>;
 Fri, 13 May 2022 10:19:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id i306J8BHqsCt
 for <virtualization@lists.linux-foundation.org>;
 Fri, 13 May 2022 10:19:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5F831417BB
 for <virtualization@lists.linux-foundation.org>;
 Fri, 13 May 2022 10:19:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1652437153;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EPf7Pu0P3apZDaVMQixl1n2kADN4YzofhOzrTrcdAa8=;
 b=CPNBrAXn5frveHIQVvDqsJ7ZSzkEi3PYvPJV9PeHwIopRcMUb+1KSlG6eL4qm+r8PgjTjv
 ofEJsjRlvnTWG5ZWl69FIor5wqdpRSovEDyJecteKVoer2L9m16t25o6ikGpIJjk3O/DdS
 j1185I4GZlJcj+14tEG2fVXgL+bckkg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-249-x81wPrzyNfefgR_QHivJ3A-1; Fri, 13 May 2022 06:19:11 -0400
X-MC-Unique: x81wPrzyNfefgR_QHivJ3A-1
Received: by mail-wr1-f71.google.com with SMTP id
 j21-20020adfa555000000b0020adb9ac14fso2773126wrb.13
 for <virtualization@lists.linux-foundation.org>;
 Fri, 13 May 2022 03:19:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=EPf7Pu0P3apZDaVMQixl1n2kADN4YzofhOzrTrcdAa8=;
 b=RGUeHvLL6vNgsAy9DjIuN223q1TXgo3TuJ0bsDaVW1Q/qxlJk+12fu2noDlub4lJ6U
 wyQJ9DZU8YQoI2uAJJr3xV90BXbg3dFMl6i2vtm/iS3Fnsqy73djAn1yZl1N0JOu6prO
 2K26GJWJB1EU9+wD5omHkZn1WxGhhV71OZ851/2ks7VtwIkd8YAaKH54D51MRE3grFvB
 CfUWbdmK8qwdIkduQ8Hz2KS7QpGu0NpX+gYAQYDc8LPG7eWEVQu57F2+VJt90c/Cqnx/
 lXoMrcMMfTvy3ECp/9PlJczBfkNx3oy94QSvnQjsw1m6rR1iUbWmRz4kJhMrStmC9xlZ
 mLJQ==
X-Gm-Message-State: AOAM530cXXo+ueKfPzvz9Uwh6UAas/5xEV0ZnkpDHAelB2evolRE/SVb
 b1JZ67nwibl4mtMIl8yn6aRKEErQhrz7NQf3+L7ZqksbUe+K3rFUNF3scANpkzrrUCkmtZJokqC
 r7hFVDlgc+u3o5kxRivk82fCKBig6olFC/nodPn50mQ==
X-Received: by 2002:a5d:59af:0:b0:20c:52e9:6c49 with SMTP id
 p15-20020a5d59af000000b0020c52e96c49mr3323834wrr.319.1652437150446; 
 Fri, 13 May 2022 03:19:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzOvQ9dLuL2eP6se0sIQQw2vcFkFPnn3HUq1CsaeQRIonOi4eo7q34RY1zmOYpDDtAhLHncpw==
X-Received: by 2002:a5d:59af:0:b0:20c:52e9:6c49 with SMTP id
 p15-20020a5d59af000000b0020c52e96c49mr3323804wrr.319.1652437150126; 
 Fri, 13 May 2022 03:19:10 -0700 (PDT)
Received: from redhat.com ([2.53.15.195]) by smtp.gmail.com with ESMTPSA id
 r21-20020adfb1d5000000b0020c5253d924sm1732386wra.112.2022.05.13.03.19.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 May 2022 03:19:09 -0700 (PDT)
Date: Fri, 13 May 2022 06:19:05 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: zhenwei pi <pizhenwei@bytedance.com>
Subject: Re: [PATCH v5 0/9] Introduce akcipher service for virtio-crypto
Message-ID: <20220513061844-mutt-send-email-mst@kernel.org>
References: <20220428135943.178254-1-pizhenwei@bytedance.com>
MIME-Version: 1.0
In-Reply-To: <20220428135943.178254-1-pizhenwei@bytedance.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: berrange@redhat.com, helei.sig11@bytedance.com, cohuck@redhat.com,
 qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org,
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

On Thu, Apr 28, 2022 at 09:59:34PM +0800, zhenwei pi wrote:
> Hi, Lei & MST
> 
> Daniel has started to review the akcipher framework and nettle & gcrypt
> implementation, this part seems to be ready soon. Thanks a lot to Daniel!
> 
> And the last patch "crypto: Introduce RSA algorithm" handles akcipher
> requests from guest and uses the new akcipher service. The new feature
> can be used to test by the builtin driver. I would appreciate it if you
> could review patch.


I applied the first 6 patches. Tests need to address Daniel's comments.

> v4 -> v5:
> - Move QCryptoAkCipher into akcipherpriv.h, and modify the related comments.
> - Rename asn1_decoder.c to der.c.
> - Code style fix: use 'cleanup' & 'error' lables.
> - Allow autoptr type to auto-free.
> - Add test cases for rsakey to handle DER error.
> - Other minor fixes.
> 
> v3 -> v4:
> - Coding style fix: Akcipher -> AkCipher, struct XXX -> XXX, Rsa -> RSA,
> XXX-alg -> XXX-algo.
> - Change version info in qapi/crypto.json, from 7.0 -> 7.1.
> - Remove ecdsa from qapi/crypto.json, it would be introduced with the implemetion later.
> - Use QCryptoHashAlgothrim instead of QCryptoRSAHashAlgorithm(removed) in qapi/crypto.json.
> - Rename arguments of qcrypto_akcipher_XXX to keep aligned with qcrypto_cipher_XXX(dec/enc/sign/vefiry -> in/out/in2), and add qcrypto_akcipher_max_XXX APIs.
> - Add new API: qcrypto_akcipher_supports.
> - Change the return value of qcrypto_akcipher_enc/dec/sign, these functions return the actual length of result.
> - Separate ASN.1 source code and test case clean.
> - Disable RSA raw encoding for akcipher-nettle.
> - Separate RSA key parser into rsakey.{hc}, and implememts it with builtin-asn1-decoder and nettle respectivly.
> - Implement RSA(pkcs1 and raw encoding) algorithm by gcrypt. This has higher priority than nettle.
> - For some akcipher operations(eg, decryption of pkcs1pad(rsa)), the length of returned result maybe less than the dst buffer size, return the actual length of result instead of the buffer length to the guest side. (in function virtio_crypto_akcipher_input_data_helper)
> - Other minor changes.
> 
> Thanks to Daniel!
> 
> Eric pointed out this missing part of use case, send it here again.
> 
> In our plan, the feature is designed for HTTPS offloading case and other applications which use kernel RSA/ecdsa by keyctl syscall. The full picture shows bellow:
> 
> 
>                   Nginx/openssl[1] ... Apps
> Guest   -----------------------------------------
>                    virtio-crypto driver[2]
> -------------------------------------------------
>                    virtio-crypto backend[3]
> Host    -----------------------------------------
>                   /          |          \
>               builtin[4]   vhost     keyctl[5] ...
> 
> 
> [1] User applications can offload RSA calculation to kernel by keyctl syscall. There is no keyctl engine in openssl currently, we developed a engine and tried to contribute it to openssl upstream, but openssl 1.x does not accept new feature. Link:
>     https://github.com/openssl/openssl/pull/16689
> 
> This branch is available and maintained by Lei <helei.sig11@bytedance.com>
>     https://github.com/TousakaRin/openssl/tree/OpenSSL_1_1_1-kctl_engine
> 
> We tested nginx(change config file only) with openssl keyctl engine, it works fine.
> 
> [2] virtio-crypto driver is used to communicate with host side, send requests to host side to do asymmetric calculation.
>     https://lkml.org/lkml/2022/3/1/1425
> 
> [3] virtio-crypto backend handles requests from guest side, and forwards request to crypto backend driver of QEMU.
> 
> [4] Currently RSA is supported only in builtin driver. This driver is supposed to test the full feature without other software(Ex vhost process) and hardware dependence. ecdsa is introduced into qapi type without implementation, this may be implemented in Q3-2022 or later. If ecdsa type definition should be added with the implementation together, I'll remove this in next version.
> 
> [5] keyctl backend is in development, we will post this feature in Q2-2022. keyctl backend can use hardware acceleration(Ex, Intel QAT).
> 
> Setup the full environment, tested with Intel QAT on host side, the QPS of HTTPS increase to ~200% in a guest.
> 
> VS PCI passthrough: the most important benefit of this solution makes the VM migratable.
> 
> v2 -> v3:
> - Introduce akcipher types to qapi
> - Add test/benchmark suite for akcipher class
> - Seperate 'virtio_crypto: Support virtio crypto asym operation' into:
>   - crypto: Introduce akcipher crypto class
>   - virtio-crypto: Introduce RSA algorithm
> 
> v1 -> v2:
> - Update virtio_crypto.h from v2 version of related kernel patch.
> 
> v1:
> - Support akcipher for virtio-crypto.
> - Introduce akcipher class.
> - Introduce ASN1 decoder into QEMU.
> - Implement RSA backend by nettle/hogweed.
> 
> Lei He (6):
>   qapi: crypto-akcipher: Introduce akcipher types to qapi
>   crypto: add ASN.1 DER decoder
>   crypto: Implement RSA algorithm by hogweed
>   crypto: Implement RSA algorithm by gcrypt
>   test/crypto: Add test suite for crypto akcipher
>   tests/crypto: Add test suite for RSA keys
> 
> Zhenwei Pi (3):
>   virtio-crypto: header update
>   crypto: Introduce akcipher crypto class
>   crypto: Introduce RSA algorithm
> 
>  backends/cryptodev-builtin.c                  | 272 ++++-
>  backends/cryptodev-vhost-user.c               |  34 +-
>  backends/cryptodev.c                          |  32 +-
>  crypto/akcipher-gcrypt.c.inc                  | 520 +++++++++
>  crypto/akcipher-nettle.c.inc                  | 432 ++++++++
>  crypto/akcipher.c                             | 108 ++
>  crypto/akcipherpriv.h                         |  55 +
>  crypto/der.c                                  | 190 ++++
>  crypto/der.h                                  |  82 ++
>  crypto/meson.build                            |   6 +
>  crypto/rsakey-builtin.c.inc                   | 209 ++++
>  crypto/rsakey-nettle.c.inc                    | 154 +++
>  crypto/rsakey.c                               |  44 +
>  crypto/rsakey.h                               |  94 ++
>  hw/virtio/virtio-crypto.c                     | 323 ++++--
>  include/crypto/akcipher.h                     | 158 +++
>  include/hw/virtio/virtio-crypto.h             |   5 +-
>  .../standard-headers/linux/virtio_crypto.h    |  82 +-
>  include/sysemu/cryptodev.h                    |  83 +-
>  meson.build                                   |  11 +
>  qapi/crypto.json                              |  64 ++
>  tests/bench/benchmark-crypto-akcipher.c       | 157 +++
>  tests/bench/meson.build                       |   4 +
>  tests/bench/test_akcipher_keys.inc            | 537 ++++++++++
>  tests/unit/meson.build                        |   2 +
>  tests/unit/test-crypto-akcipher.c             | 990 ++++++++++++++++++
>  tests/unit/test-crypto-der.c                  | 290 +++++
>  27 files changed, 4792 insertions(+), 146 deletions(-)
>  create mode 100644 crypto/akcipher-gcrypt.c.inc
>  create mode 100644 crypto/akcipher-nettle.c.inc
>  create mode 100644 crypto/akcipher.c
>  create mode 100644 crypto/akcipherpriv.h
>  create mode 100644 crypto/der.c
>  create mode 100644 crypto/der.h
>  create mode 100644 crypto/rsakey-builtin.c.inc
>  create mode 100644 crypto/rsakey-nettle.c.inc
>  create mode 100644 crypto/rsakey.c
>  create mode 100644 crypto/rsakey.h
>  create mode 100644 include/crypto/akcipher.h
>  create mode 100644 tests/bench/benchmark-crypto-akcipher.c
>  create mode 100644 tests/bench/test_akcipher_keys.inc
>  create mode 100644 tests/unit/test-crypto-akcipher.c
>  create mode 100644 tests/unit/test-crypto-der.c
> 
> -- 
> 2.20.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
