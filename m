Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7874DC433EF
	for <virtualization@archiver.kernel.org>; Wed, 16 Feb 2022 01:39:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 286C960BD7;
	Wed, 16 Feb 2022 01:39:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LYa4PfSBM-H2; Wed, 16 Feb 2022 01:39:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id B88B860B1D;
	Wed, 16 Feb 2022 01:39:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7D65EC0011;
	Wed, 16 Feb 2022 01:39:12 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 74BF4C000B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Feb 2022 01:39:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4894660B89
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Feb 2022 01:39:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3SLKd2UskKur
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Feb 2022 01:39:09 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com
 [IPv6:2607:f8b0:4864:20::633])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1971260B1D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Feb 2022 01:39:08 +0000 (UTC)
Received: by mail-pl1-x633.google.com with SMTP id c3so810350pls.5
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Feb 2022 17:39:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20210112.gappssmtp.com; s=20210112;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=4IkDugObOHw/CxlumnAa9V9g2g9OJVY9HrD6pEfE2lM=;
 b=P61cP+b5/QdSjJQm9e3zgGhGrgdXFH3lfZfyCCnrtJvrS2+7Cgg/dK89cqyX5yiXdM
 aRg6deIkdutkpSXDRfq1SNB/AVdg67oJTEfGuZzvMRJv/p9e6KRJLEXzcrjwLer7bRSl
 5Hqbc6Y4GJ7wXys6sEIq6kO2AwpaP3Ih1QhqmQi2Ibob5FqsJtnc7XS9CJrZc/tNAlgN
 jpKWExv6vcU/EcHtH4LDz+fQj1sM9wpY6DQprEJuyOb0+OgqwL842EHBvA+fLBpyfLcO
 VgwsmOlwkj6aVXkg+59IM7suM4/u86uaKECJ+K6z9bKeydZ0ploCky1eRev1yrcrzvLq
 wZTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=4IkDugObOHw/CxlumnAa9V9g2g9OJVY9HrD6pEfE2lM=;
 b=7bK+DMT11syna8uOVmOjSJ8AcAy1ILuBtl+Gl7L1XeeM2aTPxLVO0dzTt02WI3yQGm
 AnloRo1CtHWA4W4E+SqMg06ofMuJ5SIXsronyhNISfyIh7GuMyw93Y1L4IC+oD0Tu8Ho
 xb4/pCq4Nuq++lYFkmSoDm/2C2SwIxSSqTuLPdFvmrVTnxp93XOhRpWKs16ANa3o6Gfs
 VR3rgjt6L7YzUBvX+/khWQpnUXBeVxWAN8xCCSJpGabyXoUM7mVM0prkrIJoqSekIs5H
 VUuPpy3FUYSE7+F15G7T7KGeeU/352r8a/g3OUxZ3cdVTMUc5qGQaB6bDmhr9W6J38er
 MvEg==
X-Gm-Message-State: AOAM530LXNagiPAcFCV3qNjutCXyrp6FMtzWQ/Q3cd7i3dK/UaGe4EKu
 e9w1cBBTN6Eab2r6Z7mf7zMywA==
X-Google-Smtp-Source: ABdhPJyVcEQPG2VDaGKPFncTObF/Wmp+3tHQlHV4luaY2AjnKJkKFGfI/nUrfIAuuNsLJkHuYb42pA==
X-Received: by 2002:a17:90b:2390:b0:1b9:c392:ab8d with SMTP id
 mr16-20020a17090b239000b001b9c392ab8dmr293672pjb.30.1644975548318; 
 Tue, 15 Feb 2022 17:39:08 -0800 (PST)
Received: from [10.76.15.169] ([61.120.150.76])
 by smtp.gmail.com with ESMTPSA id j12sm35873328pfu.79.2022.02.15.17.39.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Feb 2022 17:39:07 -0800 (PST)
Subject: PING: [PATCH v2 0/3] Introduce akcipher service for virtio-crypto
To: arei.gonglei@huawei.com
References: <20220211084108.1254218-1-pizhenwei@bytedance.com>
From: zhenwei pi <pizhenwei@bytedance.com>
Message-ID: <cf1c6a2e-92a1-06f7-8f1b-be823c21ab5a@bytedance.com>
Date: Wed, 16 Feb 2022 09:36:17 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220211084108.1254218-1-pizhenwei@bytedance.com>
Content-Language: en-US
Cc: helei.sig11@bytedance.com, mst@redhat.com, linux-kernel@vger.kernel.org,
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

Hi, Lei

Could you please review the V2 version?

On 2/11/22 4:41 PM, zhenwei pi wrote:
> v1 -> v2:
> - Fix 1 compiling warning reported by kernel test robot <lkp@intel.com>
> - Put "__le32 akcipher_algo;" instead of "__le32 reserve;" field of
>     struct virtio_crypto_config directly without size change.
> - Add padding in struct virtio_crypto_ecdsa_session_para to keep
>     64-bit alignment.
> - Remove irrelevant change by code format alignment.
> 
> - Also CC crypto gurus Herbert and linux-crypto@vger.kernel.org.
> 
> - Test with QEMU(patched by the v2 version), works fine.
> 
> v1:
> - Introduce akcipher service, implement RSA algorithm, and a minor fix.
> 
> zhenwei pi (3):
>    virtio_crypto: Introduce VIRTIO_CRYPTO_NOSPC
>    virtio-crypto: introduce akcipher service
>    virtio-crypto: implement RSA algorithm
> 
>   drivers/crypto/virtio/Makefile                |   1 +
>   .../virtio/virtio_crypto_akcipher_algo.c      | 584 ++++++++++++++++++
>   drivers/crypto/virtio/virtio_crypto_common.h  |   3 +
>   drivers/crypto/virtio/virtio_crypto_core.c    |   6 +-
>   drivers/crypto/virtio/virtio_crypto_mgr.c     |  11 +
>   include/uapi/linux/virtio_crypto.h            |  82 ++-
>   6 files changed, 685 insertions(+), 2 deletions(-)
>   create mode 100644 drivers/crypto/virtio/virtio_crypto_akcipher_algo.c
> 

-- 
zhenwei pi
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
