Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43195C433EF
	for <virtualization@archiver.kernel.org>; Wed, 23 Mar 2022 12:36:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id CD49B40C01;
	Wed, 23 Mar 2022 12:36:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id c3gCr6iS0cR7; Wed, 23 Mar 2022 12:36:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 2575D40AB8;
	Wed, 23 Mar 2022 12:36:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 68AC6C0086;
	Wed, 23 Mar 2022 12:36:48 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0633AC0012
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Mar 2022 12:36:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D9DA0849D9
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Mar 2022 12:36:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IPCTF23_Dd_D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Mar 2022 12:36:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0A1A9849FA
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Mar 2022 12:36:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1648039004;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fa9QTM48OUejCQPoDl5NAKjvkdcSmGmWd5J/s9MvAqs=;
 b=PAtX4DX1UVR9GMtgl2OcT4Fsnx3xiOwLWb3u1JvRBGc3eArubsmm1NewWw1qhF1UC0NNwU
 lvrDuxolFHPM/PpxeQ3seXBEFcpB9k1nboQ6afuVvNBqyzVi1r5JrzItNFzrVncJ64ZCqN
 m04+sMui+cAvATioDIMYAKheB58rWdA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-62-OPfg87QuN5WIztkZh2MB0Q-1; Wed, 23 Mar 2022 08:36:41 -0400
X-MC-Unique: OPfg87QuN5WIztkZh2MB0Q-1
Received: by mail-wm1-f72.google.com with SMTP id
 bg28-20020a05600c3c9c00b0038c8da4d9b3so2770893wmb.0
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Mar 2022 05:36:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=fa9QTM48OUejCQPoDl5NAKjvkdcSmGmWd5J/s9MvAqs=;
 b=L3UwfPCxZ3H56h64SCn7HvEAiufl5N5gibhzyDyCSZi3LoNt4OvmlJmumIteCx6jB+
 DLzBD2zJ606wjcp6eBZj4jjITXADO9il6NQ8be93KcrqVhQfgeDDxuXlUcLNH6PMsoTT
 LtTU134JlRfM1vwQnmCRO71w0uk3Nl4+TKGI1ue4TyJoY7GlhwuE3ZFyT5nFK1HGQVs0
 yO4xmnedOEK7aEeu345ja32ZxFaH+cTfk2EVD6832V/UweDSe26ew8yxSdKg3OMzRaGj
 X9lh1DfjJttRajkT4qHWnJ2OQX8gq2B+uw7dEuDghYBkFhVWSQasDFT2NTdwFJ9+CqHr
 A1vg==
X-Gm-Message-State: AOAM530xBXZgK+WOdt1mkyBaXiLkvOtXFMxe+QI8E4iQ72hBwbmqoZeJ
 R/KCRSeqG4cvW+En2vRAgeFGYfBAkwVe7mIn+fqA+n3WLvk43C9cBPg5l+1jFx90uWt/LMgUYyM
 FGVlnEF44g9P5pE4v9287gkMuC7b6pnlHj2bjz/reFg==
X-Received: by 2002:a5d:6b0b:0:b0:1ef:d826:723a with SMTP id
 v11-20020a5d6b0b000000b001efd826723amr27400460wrw.420.1648039000396; 
 Wed, 23 Mar 2022 05:36:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwBxeWRoCDIdMerVIOvtlAnOjiNcVTIj/UD5hdtcw5XobeVf2TSLgENh4CA6UmlgZGf3azmWw==
X-Received: by 2002:a5d:6b0b:0:b0:1ef:d826:723a with SMTP id
 v11-20020a5d6b0b000000b001efd826723amr27400445wrw.420.1648039000212; 
 Wed, 23 Mar 2022 05:36:40 -0700 (PDT)
Received: from redhat.com ([2.55.151.118]) by smtp.gmail.com with ESMTPSA id
 r15-20020a5d6c6f000000b002040552e88esm11818773wrz.29.2022.03.23.05.36.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Mar 2022 05:36:39 -0700 (PDT)
Date: Wed, 23 Mar 2022 08:36:36 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: zhenwei pi <pizhenwei@bytedance.com>
Subject: Re: [PATCH v3 0/6] Support akcipher for virtio-crypto
Message-ID: <20220323083558-mutt-send-email-mst@kernel.org>
References: <20220323024912.249789-1-pizhenwei@bytedance.com>
MIME-Version: 1.0
In-Reply-To: <20220323024912.249789-1-pizhenwei@bytedance.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: herbert@gondor.apana.org.au, qemu-devel@nongnu.org,
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

On Wed, Mar 23, 2022 at 10:49:06AM +0800, zhenwei pi wrote:
> v2 -> v3:
> - Introduce akcipher types to qapi
> - Add test/benchmark suite for akcipher class
> - Seperate 'virtio_crypto: Support virtio crypto asym operation' into:
>   - crypto: Introduce akcipher crypto class
>   - virtio-crypto: Introduce RSA algorithm

Thanks!
I tagged this but qemu is in freeze. If possible pls ping or
repost after the release to help make sure I don't lose it.

> v1 -> v2:
> - Update virtio_crypto.h from v2 version of related kernel patch.
> 
> v1:
> - Support akcipher for virtio-crypto.
> - Introduce akcipher class.
> - Introduce ASN1 decoder into QEMU.
> - Implement RSA backend by nettle/hogweed.
> 
> Lei He (3):
>   crypto-akcipher: Introduce akcipher types to qapi
>   crypto: Implement RSA algorithm by hogweed
>   tests/crypto: Add test suite for crypto akcipher
> 
> Zhenwei Pi (3):
>   virtio-crypto: header update
>   crypto: Introduce akcipher crypto class
>   virtio-crypto: Introduce RSA algorithm
> 
>  backends/cryptodev-builtin.c                  | 319 +++++++-
>  backends/cryptodev-vhost-user.c               |  34 +-
>  backends/cryptodev.c                          |  32 +-
>  crypto/akcipher-nettle.c                      | 523 +++++++++++++
>  crypto/akcipher.c                             |  81 ++
>  crypto/asn1_decoder.c                         | 185 +++++
>  crypto/asn1_decoder.h                         |  42 +
>  crypto/meson.build                            |   4 +
>  hw/virtio/virtio-crypto.c                     | 326 ++++++--
>  include/crypto/akcipher.h                     | 155 ++++
>  include/hw/virtio/virtio-crypto.h             |   5 +-
>  .../standard-headers/linux/virtio_crypto.h    |  82 +-
>  include/sysemu/cryptodev.h                    |  88 ++-
>  meson.build                                   |  11 +
>  qapi/crypto.json                              |  86 +++
>  tests/bench/benchmark-crypto-akcipher.c       | 163 ++++
>  tests/bench/meson.build                       |   6 +
>  tests/bench/test_akcipher_keys.inc            | 277 +++++++
>  tests/unit/meson.build                        |   1 +
>  tests/unit/test-crypto-akcipher.c             | 715 ++++++++++++++++++
>  20 files changed, 2990 insertions(+), 145 deletions(-)
>  create mode 100644 crypto/akcipher-nettle.c
>  create mode 100644 crypto/akcipher.c
>  create mode 100644 crypto/asn1_decoder.c
>  create mode 100644 crypto/asn1_decoder.h
>  create mode 100644 include/crypto/akcipher.h
>  create mode 100644 tests/bench/benchmark-crypto-akcipher.c
>  create mode 100644 tests/bench/test_akcipher_keys.inc
>  create mode 100644 tests/unit/test-crypto-akcipher.c
> 
> -- 
> 2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
