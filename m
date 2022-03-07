Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1062AC433F5
	for <virtualization@archiver.kernel.org>; Mon,  7 Mar 2022 02:45:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 99396813C8;
	Mon,  7 Mar 2022 02:45:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Xo4r44xq5vxf; Mon,  7 Mar 2022 02:45:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 45882813CB;
	Mon,  7 Mar 2022 02:45:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 175C1C001D;
	Mon,  7 Mar 2022 02:45:29 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 46D9DC000B
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Mar 2022 02:45:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1F6C240323
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Mar 2022 02:45:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=bytedance-com.20210112.gappssmtp.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DVkqDq7dVXeA
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Mar 2022 02:45:26 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com
 [IPv6:2607:f8b0:4864:20::102b])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0050940150
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Mar 2022 02:45:25 +0000 (UTC)
Received: by mail-pj1-x102b.google.com with SMTP id cx5so12032828pjb.1
 for <virtualization@lists.linux-foundation.org>;
 Sun, 06 Mar 2022 18:45:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20210112.gappssmtp.com; s=20210112;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=MqTvzhnDnNsM5gc1jxNKVsqHTeWOImRbSBaH/Le+AV0=;
 b=ii0KSuBKQb6dIjrfOwNM5mk/9+Nq7Hgn9DTHrwdUkgL/ZLQLBBKluI3Iwlmv8Zu1O4
 Q8/j77axaUB3XVjJ72tcgzUH8A4jWRlTK5rp7S6IQ0j7DWMJpCmQZidE1zpTVZ6rE19a
 XJXOL96PemSMSQwhyECg4jWBTKm06QfU2quY23E0II6hHrppbQ9TsirSKEmILBMVNz8/
 bCdC9cURTp3hMsgFnMlrhoNl4n+ATpabzkW2Z0rpr9zQIH4Yr2xTEbXqKed2RxmmlJ7a
 b/EF2ho6JLko+gIQb3pK4xJQsa2D7+REwDPDyFkd18tHDpzyUN6cCmuySwm7Nv4EXGU0
 YyRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=MqTvzhnDnNsM5gc1jxNKVsqHTeWOImRbSBaH/Le+AV0=;
 b=izn5tG5vKkLMeh4eL35CgvLZoWFLc1rBvGC+Jjgqkdij1MbdI45o74BQKtYpgj1ffy
 cVntiobFkVYbK2KBMIrPPlX+beRaBWUxAtGfcC7frn6RojwFdHjnmV7PN7b8OYh74ZT5
 dMBCdPyGFz/6CaCFwhQco78IxWZDpWAt6ygAX7gIP/mV0g0w/Cm6/t8JV3gvSNfrsr7V
 QGaxw3gJEx47sF0v3P42gSbM6GTyqO7JjmmI0MwJADpVyccmiirtugSwCrAsUxAJez9J
 39UexERvo1cpDdbAxPHq3AEoaFPmdJDgG4K6kHdKpIqaYHFTMkY6ZeZH9umYelVoKTW6
 u8Rg==
X-Gm-Message-State: AOAM531NgpkzAb//mVhD34fY1t/QE0vu3Xtpk7k+qrD/tP8YDepgG6cX
 5Gb87KgO8HzKWJFcKlAJ6dr9aw==
X-Google-Smtp-Source: ABdhPJx9z16gRqP9k0HLwPVJ/PCks1UzrTHcjIYRn5tv8E0ldU0gePkCgrzBhpbw4mb5hbFv4roBfw==
X-Received: by 2002:a17:902:7143:b0:151:eea7:bc62 with SMTP id
 u3-20020a170902714300b00151eea7bc62mr1578566plm.122.1646621125042; 
 Sun, 06 Mar 2022 18:45:25 -0800 (PST)
Received: from [10.76.15.169] ([61.120.150.76])
 by smtp.gmail.com with ESMTPSA id
 nn5-20020a17090b38c500b001bf09d6c7d7sm11087532pjb.26.2022.03.06.18.45.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 06 Mar 2022 18:45:24 -0800 (PST)
Subject: Re: [PATCH v3 0/4] Introduce akcipher service for virtio-crypto
To: arei.gonglei@huawei.com, mst@redhat.com
References: <20220302033917.1295334-1-pizhenwei@bytedance.com>
From: zhenwei pi <pizhenwei@bytedance.com>
Message-ID: <a9d1dfc1-080e-fba2-8fbb-28718b067e0d@bytedance.com>
Date: Mon, 7 Mar 2022 10:42:30 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220302033917.1295334-1-pizhenwei@bytedance.com>
Content-Language: en-US
Cc: helei.sig11@bytedance.com, cohuck@redhat.com, linux-kernel@vger.kernel.org,
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

Hi, Michael & Lei

The full patchset has been reviewed by Gonglei, thanks to Gonglei.
Should I modify the virtio crypto specification(use "__le32 
akcipher_algo;" instead of "__le32 reserve;" only, see v1->v2 change), 
and start a new issue for a revoting procedure?

Also cc Cornelia Huck.

On 3/2/22 11:39 AM, zhenwei pi wrote:
> v2 -> v3:
>    Rename virtio_crypto_algs.c to virtio_crypto_skcipher_algs.c, and
>      minor changes of function name.
>    Minor changes in virtio_crypto_akcipher_algs.c: no need to copy from
>      buffer if opcode is verify.
> 
> v1 -> v2:
>    Fix 1 compiling warning reported by kernel test robot <lkp@intel.com>
>    Put "__le32 akcipher_algo;" instead of "__le32 reserve;" field of
>      struct virtio_crypto_config directly without size change.
>    Add padding in struct virtio_crypto_ecdsa_session_para to keep
>      64-bit alignment.
>    Remove irrelevant change by code format alignment.
> 
>    Also CC crypto gurus Herbert and linux-crypto@vger.kernel.org.
> 
>    Test with QEMU(patched by the v2 version), works fine.
> 
> v1:
>    Introduce akcipher service, implement RSA algorithm, and a minor fix.
> 
> zhenwei pi (4):
>    virtio_crypto: Introduce VIRTIO_CRYPTO_NOSPC
>    virtio-crypto: introduce akcipher service
>    virtio-crypto: implement RSA algorithm
>    virtio-crypto: rename skcipher algs
> 
>   drivers/crypto/virtio/Makefile                |   3 +-
>   .../virtio/virtio_crypto_akcipher_algs.c      | 585 ++++++++++++++++++
>   drivers/crypto/virtio/virtio_crypto_common.h  |   7 +-
>   drivers/crypto/virtio/virtio_crypto_core.c    |   6 +-
>   drivers/crypto/virtio/virtio_crypto_mgr.c     |  15 +-
>   ...o_algs.c => virtio_crypto_skcipher_algs.c} |   4 +-
>   include/uapi/linux/virtio_crypto.h            |  82 ++-
>   7 files changed, 693 insertions(+), 9 deletions(-)
>   create mode 100644 drivers/crypto/virtio/virtio_crypto_akcipher_algs.c
>   rename drivers/crypto/virtio/{virtio_crypto_algs.c => virtio_crypto_skcipher_algs.c} (99%)
> 

-- 
zhenwei pi
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
