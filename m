Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1200C433FE
	for <virtualization@archiver.kernel.org>; Fri, 11 Feb 2022 08:45:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 511B361C13;
	Fri, 11 Feb 2022 08:45:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lIommn15xCOM; Fri, 11 Feb 2022 08:45:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id EA20B60DC6;
	Fri, 11 Feb 2022 08:45:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CA46DC001A;
	Fri, 11 Feb 2022 08:45:08 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C5BE9C000B
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Feb 2022 08:45:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id AD7D881D4D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Feb 2022 08:45:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=bytedance-com.20210112.gappssmtp.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id I_iJAjxZ7BLe
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Feb 2022 08:45:06 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com
 [IPv6:2607:f8b0:4864:20::632])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9BD9681CE7
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Feb 2022 08:45:06 +0000 (UTC)
Received: by mail-pl1-x632.google.com with SMTP id y17so4115358plg.7
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Feb 2022 00:45:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20210112.gappssmtp.com; s=20210112;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=PaB4eX5eIfNXcpFcbMwDNqkLnPT1dKU3PJWq0bzJplM=;
 b=YpWYXFjjs6RShsyABwDfvNm6jx79gmMxhaw1Fpaq+dJnqQXoCYTu2GmkSgtK8IZYXY
 ldohj3ygggnAWQK1+pJA3V4adQAXBiEp0ytiDNvAeVChe997HsHLoeN3u+h4vSOG9D1M
 o43M0/OhPBlte0SUrPcDRLxSeJ/S9VllFkQTzLBmwC1zbhC/2+XiI9zKYvm5b1CCBN3+
 AwzmtABTi/bzBfI9eKAijCHDVlELazxGygu5gV3p6iyoEsib1M41OqteIaqsa4z2AT6g
 maVOY4zLbvGkCzoEeYrOHIrAs15FYATsD6ndXrahQJOx7QCAJm29Ld3cdUoI+GX/YldI
 a/Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=PaB4eX5eIfNXcpFcbMwDNqkLnPT1dKU3PJWq0bzJplM=;
 b=te6BFQzaX4OG643acLYORpKmZPQzT9wyJ5x0ZHPK9qBI6ZPnlCpOBYb8GkhOTBgQx9
 Iki0/dQAnM/KCT8WygBJDG9YgB7Ex8HvOwhVVVANgln5H4LbEwB702FUaS/8cv4t41uM
 xsvwR1/h/teaZdLF+RYyuWOANPuPP2yQWWoFvV52BxVgCEgt6ck/w16QjJEM8n4LF8MH
 CqQG3evgzUEeyL3nuLyeRk+dUZp4gq7U79jBqBa3OToHO1Ho8FT3ErsO2HfHaVf7ezT4
 G8G4LqOg7z0S6BmwFM/sS8Y6g57wDgp7ydYSukUZp1ry3E3ZDMxg19lCF69NVcAR/e66
 lD4w==
X-Gm-Message-State: AOAM533w61R6V59cpsFUVodjqXwDoIKCcn5MilPh6uPLfla5uFMyPs49
 E/INVPXBInreELczW74Sej5F3g==
X-Google-Smtp-Source: ABdhPJw8xZ6h9/FQPj8RwTXVV6Zt8ueVO/BXP2VbGZMp+CjlsH2Wx34zZmbUYlsiJxVDnpE/0+of0A==
X-Received: by 2002:a17:902:b493:: with SMTP id
 y19mr615916plr.97.1644569105992; 
 Fri, 11 Feb 2022 00:45:05 -0800 (PST)
Received: from libai.bytedance.net ([61.120.150.72])
 by smtp.gmail.com with ESMTPSA id u7sm3832686pgc.93.2022.02.11.00.45.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Feb 2022 00:45:05 -0800 (PST)
From: zhenwei pi <pizhenwei@bytedance.com>
To: arei.gonglei@huawei.com,
	mst@redhat.com
Subject: [PATCH v2 0/3] Support akcipher for virtio-crypto
Date: Fri, 11 Feb 2022 16:43:32 +0800
Message-Id: <20220211084335.1254281-1-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.25.1
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

v1 -> v2:
- Update virtio_crypto.h from v2 version of related kernel patch.

v1:
- Support akcipher for virtio-crypto.
- Introduce akcipher class.
- Introduce ASN1 decoder into QEMU.
- Implement RSA backend by nettle/hogweed.

Lei He (1):
  crypto: Introduce RSA algorithm

Zhenwei Pi (2):
  virtio-crypto: header update
  virtio_crypto: Support virtio crypto asym operation

 backends/cryptodev-builtin.c                  | 201 ++++++--
 backends/cryptodev-vhost-user.c               |  34 +-
 backends/cryptodev.c                          |  32 +-
 crypto/akcipher-nettle.c                      | 486 ++++++++++++++++++
 crypto/akcipher.c                             |  91 ++++
 crypto/asn1_decoder.c                         | 185 +++++++
 crypto/asn1_decoder.h                         |  42 ++
 crypto/meson.build                            |   4 +
 hw/virtio/virtio-crypto.c                     | 328 +++++++++---
 include/crypto/akcipher.h                     |  77 +++
 include/hw/virtio/virtio-crypto.h             |   5 +-
 .../standard-headers/linux/virtio_crypto.h    |  82 ++-
 include/sysemu/cryptodev.h                    |  88 +++-
 meson.build                                   |  11 +
 14 files changed, 1518 insertions(+), 148 deletions(-)
 create mode 100644 crypto/akcipher-nettle.c
 create mode 100644 crypto/akcipher.c
 create mode 100644 crypto/asn1_decoder.c
 create mode 100644 crypto/asn1_decoder.h
 create mode 100644 include/crypto/akcipher.h

-- 
2.20.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
