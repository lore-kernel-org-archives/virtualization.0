Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B4FBC433F5
	for <virtualization@archiver.kernel.org>; Thu,  3 Mar 2022 02:02:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 2E52B40593;
	Thu,  3 Mar 2022 02:02:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qrmFkYgLb1jI; Thu,  3 Mar 2022 02:02:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 6B8CB40395;
	Thu,  3 Mar 2022 02:02:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3335DC0082;
	Thu,  3 Mar 2022 02:02:05 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6F65DC000B
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Mar 2022 02:02:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6170A40395
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Mar 2022 02:02:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Lq9Y7WtxlYly
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Mar 2022 02:02:01 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com
 [IPv6:2607:f8b0:4864:20::435])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3AF62400FE
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Mar 2022 02:02:00 +0000 (UTC)
Received: by mail-pf1-x435.google.com with SMTP id a5so3513001pfv.9
 for <virtualization@lists.linux-foundation.org>;
 Wed, 02 Mar 2022 18:02:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20210112.gappssmtp.com; s=20210112;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=8cIobXUGos4eqS6yTcZeG6b/dnVbjGhFoz3W2ZVDn2s=;
 b=pleEBLa8m2cMQ+1uDstwD0gO1ujAkJC8w7JX+czCrNwEkcW9bkeKolv4JBH2kbWED1
 oHA/3CKBiHmeMxHnnzeho4c/9sIh/mPhWU5exgMIHWstHaWw/xYA+XiYWebJr8xjaqsg
 X7Si2rizZdoIr2D8a5142aKNXUXUfrDG6qOQpPR+zcyq5HKDO5kNSDJcG757SjEZNu/B
 OcjGbnDzxHJBTOpukLJBNgGO0SXAX0M63wQbM7cp4tWZ4iNueL8g9NFR6DnvtSOlt1Vo
 IYQ3PsOFmEdcbEuVEqI3HQ87cWES8Rsvp2cWgNCeentZUMnAE8y613pJBOVE6vVSBfjl
 WG9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=8cIobXUGos4eqS6yTcZeG6b/dnVbjGhFoz3W2ZVDn2s=;
 b=VtuSIUMtw95bfrwFLK0Fz1VogiLU8DCaR8/kWSgVLJyFNIsXM8dDFpirXLVwYBDzZ8
 arA5yM/vlQQRUhNnWB1K0zJkFkHsxohir5RCdJOtO0tCtYMqOMas0xwwmON0B3U3KoFB
 8WJ6X8ZlL5nCjAnvduex/TDVwnDfsdLcsCVlVCWJkUjQuqbZ26afy6UFtA7zVjZ/ygBQ
 enw5j2V640En82SVvZmymSZU194BpKCp5Uz+6rJcrIoz7xGI7tQ09IBxZCwgPJDJIxyi
 elZ5otlu3lR6IYa/9vu1b4Ikp3iQaUvk5jcbwAZI0jPvpZC/LQw0uNwNjePEeEzQgevc
 TJew==
X-Gm-Message-State: AOAM530y9/XvkcdiHuRNt4R/EMjw9oiYiluNCHYphRQPKZ11p3wqjjTA
 /JG9T8VHuyyUOj01AwbwA/H0Fw==
X-Google-Smtp-Source: ABdhPJwRB/dmHAgWApB90i9J8EAZVtuLSwQQucQk9VP2MLtTU7Q5qC6rx8boQVavL1CF4KOQf6x0Tg==
X-Received: by 2002:a63:914a:0:b0:36c:70c9:8057 with SMTP id
 l71-20020a63914a000000b0036c70c98057mr28260012pge.597.1646272920429; 
 Wed, 02 Mar 2022 18:02:00 -0800 (PST)
Received: from [10.76.15.169] ([61.120.150.76])
 by smtp.gmail.com with ESMTPSA id
 g15-20020a056a0023cf00b004e17e11cb17sm474850pfc.111.2022.03.02.18.01.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Mar 2022 18:01:59 -0800 (PST)
Subject: Re: Re: [PATCH v3 0/4] Introduce akcipher service for virtio-crypto
To: Eric Biggers <ebiggers@kernel.org>
References: <20220302033917.1295334-1-pizhenwei@bytedance.com>
 <Yh/WUSBesj/tRncT@gmail.com>
From: zhenwei pi <pizhenwei@bytedance.com>
Message-ID: <9bb1446c-2ae2-09b0-e7fe-4643567542d1@bytedance.com>
Date: Thu, 3 Mar 2022 09:59:06 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <Yh/WUSBesj/tRncT@gmail.com>
Content-Language: en-US
Cc: herbert@gondor.apana.org.au, mst@redhat.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, linux-crypto@vger.kernel.org,
 helei.sig11@bytedance.com
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

On 3/3/22 4:40 AM, Eric Biggers wrote:
> On Wed, Mar 02, 2022 at 11:39:13AM +0800, zhenwei pi wrote:
>> v2 -> v3:
>>    Rename virtio_crypto_algs.c to virtio_crypto_skcipher_algs.c, and
>>      minor changes of function name.
>>    Minor changes in virtio_crypto_akcipher_algs.c: no need to copy from
>>      buffer if opcode is verify.
>>
>> v1 -> v2:
>>    Fix 1 compiling warning reported by kernel test robot <lkp@intel.com>
>>    Put "__le32 akcipher_algo;" instead of "__le32 reserve;" field of
>>      struct virtio_crypto_config directly without size change.
>>    Add padding in struct virtio_crypto_ecdsa_session_para to keep
>>      64-bit alignment.
>>    Remove irrelevant change by code format alignment.
>>
>>    Also CC crypto gurus Herbert and linux-crypto@vger.kernel.org.
>>
>>    Test with QEMU(patched by the v2 version), works fine.
>>
>> v1:
>>    Introduce akcipher service, implement RSA algorithm, and a minor fix.
>>
>> zhenwei pi (4):
>>    virtio_crypto: Introduce VIRTIO_CRYPTO_NOSPC
>>    virtio-crypto: introduce akcipher service
>>    virtio-crypto: implement RSA algorithm
>>    virtio-crypto: rename skcipher algs
>>
>>   drivers/crypto/virtio/Makefile                |   3 +-
>>   .../virtio/virtio_crypto_akcipher_algs.c      | 585 ++++++++++++++++++
>>   drivers/crypto/virtio/virtio_crypto_common.h  |   7 +-
>>   drivers/crypto/virtio/virtio_crypto_core.c    |   6 +-
>>   drivers/crypto/virtio/virtio_crypto_mgr.c     |  15 +-
>>   ...o_algs.c => virtio_crypto_skcipher_algs.c} |   4 +-
>>   include/uapi/linux/virtio_crypto.h            |  82 ++-
>>   7 files changed, 693 insertions(+), 9 deletions(-)
>>   create mode 100644 drivers/crypto/virtio/virtio_crypto_akcipher_algs.c
>>   rename drivers/crypto/virtio/{virtio_crypto_algs.c => virtio_crypto_skcipher_algs.c} (99%)
> 
> Why is this patchset useful?  That isn't explained anywhere.
> 
> - Eric
> 
Sorry about this missing part.

This feature provides akcipher service offloading capability for guest 
side. And I also sent a patchset of QEMU:
https://patchwork.kernel.org/project/qemu-devel/cover/20220211084335.1254281-1-pizhenwei@bytedance.com/

The two patchsets work together, guest side sends 
encrypt/decrypt/sign/verify requests to host side, host side handles 
request and return response to the guest.

-- 
zhenwei pi
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
