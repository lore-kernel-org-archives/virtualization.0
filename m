Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56CB9C433F5
	for <virtualization@archiver.kernel.org>; Thu, 10 Feb 2022 06:58:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id DA6B740127;
	Thu, 10 Feb 2022 06:58:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qha2HS5o-OXg; Thu, 10 Feb 2022 06:58:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 4793D405FD;
	Thu, 10 Feb 2022 06:58:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 17B80C001A;
	Thu, 10 Feb 2022 06:58:35 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 90155C000B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Feb 2022 06:58:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 60059405FD
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Feb 2022 06:58:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id opit4aDOGd-g
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Feb 2022 06:58:32 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com
 [IPv6:2607:f8b0:4864:20::42d])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2513D40127
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Feb 2022 06:58:31 +0000 (UTC)
Received: by mail-pf1-x42d.google.com with SMTP id x15so6184766pfr.5
 for <virtualization@lists.linux-foundation.org>;
 Wed, 09 Feb 2022 22:58:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20210112.gappssmtp.com; s=20210112;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=qubtFSL5pffuSE96y3KeDZ8ATTHDcApsGYblihKFKlM=;
 b=EJVUaU8FgXsLEg4U3EZPRn43bEa9gR+0klojCs/EluWwEY+HOcMpGt8mz0MLTWfDli
 qauc/PGRY033F8Tl9tbpzf+m9yWO/hW8G4GSAAiN5tbaLEyyIpGoU9fV/rM4rQ7ZZQsx
 dDewofAx3MwRkM8+5kbNA4zzIMcgaKOsgeNnwEofmay4MTy70hEmofAKysX/3wQUHa6b
 IUmexz1cnwAIYlI1mhnqzUeXVhDUT4cn/83Nys6l3ClEbfRVXJ5m5h76IVWeSSDOqf0T
 GMiE60mDEldQ0KK4Q4cZILLx5jPwXRN9TXmIhfZIYYA9GnGmzdJLnmybBl+FM4hsne0X
 4/Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=qubtFSL5pffuSE96y3KeDZ8ATTHDcApsGYblihKFKlM=;
 b=WR48X227gxfDC+Halh6zBsGvv5vp5rmO3+pI9xsXiLwj4AVvYQv5Qh256OEKS7bLQb
 ui6CZWA4yQdJa+l0Q3PSVson6TY7xnV7OpCA27fcybQAlJmZ+bkYfE9X2+sRt2V3sqa2
 0pb5n4ZTnKLS3pfbgDZfcSxW3Tb3fPLOw/fxk1hU1wz4QYD0T3Z97tSMpUQ+46nOwa/Q
 slUvM+g1BcK1IkEL04V7d0qE5vlGMtr4xESpFO1GRFSj5bRWqibU+anZ1jDDYnWP5h7N
 Aq27WVx3gm3d1yhWxKXRoPbgStRk1jAZbHE7szpR4q9lUqNac4bJese5Z2uaTFiRza6m
 n2Qg==
X-Gm-Message-State: AOAM532tKhS6+azl6AFN+2aeXlgeC9cNKj9VjdQGlY4n3iJaHQ6iaCNO
 4RscxQIJqrf6xh5d71d26kSsFA==
X-Google-Smtp-Source: ABdhPJz1WhCuTVXHDD6QOhULgG9i8OXhz4OWau8w2cQgW4jcTWpQlOcKDdkF6kfkaUkIxBX/nFR0qA==
X-Received: by 2002:a63:b141:: with SMTP id g1mr5087167pgp.269.1644476311381; 
 Wed, 09 Feb 2022 22:58:31 -0800 (PST)
Received: from [10.76.15.169] ([61.120.150.76])
 by smtp.gmail.com with ESMTPSA id h10sm22807072pfc.103.2022.02.09.22.58.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Feb 2022 22:58:30 -0800 (PST)
Subject: PING: [PATCH 0/3] Introduce akcipher service for virtio-crypto
To: mst@redhat.com, arei.gonglei@huawei.com
References: <20220121022438.1042547-1-pizhenwei@bytedance.com>
From: zhenwei pi <pizhenwei@bytedance.com>
Message-ID: <9d07cc9d-b3f1-6fc9-eca1-6124f7baf7e0@bytedance.com>
Date: Thu, 10 Feb 2022 14:55:42 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220121022438.1042547-1-pizhenwei@bytedance.com>
Content-Language: en-US
Cc: helei.sig11@bytedance.com, linux-kernel@vger.kernel.org,
 linux-crypto@vger.kernel.org, virtualization@lists.linux-foundation.org
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

PING!

PS: Please ignore the warning from kernel test robot, I'll fix it in 
next version.

On 1/21/22 10:24 AM, zhenwei pi wrote:
> Introduce akcipher service, implement RSA algorithm, and a minor fix.
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
>   include/uapi/linux/virtio_crypto.h            |  98 ++-
>   6 files changed, 693 insertions(+), 10 deletions(-)
>   create mode 100644 drivers/crypto/virtio/virtio_crypto_akcipher_algo.c
> 

-- 
zhenwei pi
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
