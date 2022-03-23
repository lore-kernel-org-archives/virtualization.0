Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B4EEC433EF
	for <virtualization@archiver.kernel.org>; Wed, 23 Mar 2022 07:36:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4224A41A35;
	Wed, 23 Mar 2022 07:36:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yfS60oGBoPr9; Wed, 23 Mar 2022 07:36:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id CE72D41A2E;
	Wed, 23 Mar 2022 07:36:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8DD5CC0012;
	Wed, 23 Mar 2022 07:36:08 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9AB92C000B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Mar 2022 07:36:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9756541869
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Mar 2022 07:36:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pz834GSyNghV
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Mar 2022 07:36:04 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com
 [IPv6:2607:f8b0:4864:20::1034])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D451841A2E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Mar 2022 07:36:04 +0000 (UTC)
Received: by mail-pj1-x1034.google.com with SMTP id
 mp6-20020a17090b190600b001c6841b8a52so5583671pjb.5
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Mar 2022 00:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20210112.gappssmtp.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=zvylfPpDD9P7LaVoOftyiAyZ4rjtzB+zBl0Umv/tVM8=;
 b=DRpcKWazqF/j9WlI8wmS2svwLYoi3ZrvlWHtWFCRpaYYQad4aGM5+KqGDh3unwJKNO
 nCeZrxwS//AlUXG0MZGTCWTc4MzpKlyri/EZR9aT7g3aCDodJUtmoGKvkeVOhaojjptD
 qaQ8/hZO2wpgYFHGvwBzmYLTwT9+opQ/Xo8maJo6ZJGGYb2OsGEVYcWY9hOdRDGwtTyg
 299GeeOXfEOrc5ZO6Ho/0skuS/yEe19FHUJcd/9qxKH1j92hWH7vNqgg/nGTjini/NkZ
 fRLTFYZuk4xfRIYoel7PdNUz1GXEGZkwUtiOl/CyTIBv2TW8tTATGeNYaKUkmgqejH/U
 qz3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=zvylfPpDD9P7LaVoOftyiAyZ4rjtzB+zBl0Umv/tVM8=;
 b=3hZEZKMRwdZBoS1FV+SOFELpYhb9PV3V80MBzA8VPdkBI87mqPZqjrWa0jWI7zXWQI
 u6H3aMCjMd2TwQmLZM/P23s7Hid5k8nfvqbILMVzlWJekc6gwEv3NFWFg62duyNKsSp4
 6nTABqc/h/oOZgqLmCcUeDBRMxCDKRIwoyc9F1q6+1uPE5HyvFafydzWOsJVlbuP5i+m
 PVA6FTjT1ceqRxBPFruOilXEsjcbQczElvZD4cQmOCPcqK4kMbZzgdLlKXl4SyGCWsB5
 /JjuRg3eN7vxd0MGuwwWqf+kaGXEGqRulB1H1QD/bpsa6fOcjpuOjmYe8YfHJilXsyV/
 Zx7w==
X-Gm-Message-State: AOAM533bYpsJiq+hfrtfIYqM+X+3K0nf7u9CiEciK6XZElSVVN2QaF73
 mDE/ym6Vuz5QDctYVxDYTBafQw==
X-Google-Smtp-Source: ABdhPJyiRm/ds9KsWZNW+LTcMfpWdOU27E0yNqDGEitACnD7dqxgZWBF8j1F3DZKQNh5UngmIs8tgw==
X-Received: by 2002:a17:90a:4581:b0:1bc:d215:8722 with SMTP id
 v1-20020a17090a458100b001bcd2158722mr9837129pjg.149.1648020964224; 
 Wed, 23 Mar 2022 00:36:04 -0700 (PDT)
Received: from [10.255.146.117] ([139.177.225.224])
 by smtp.gmail.com with ESMTPSA id
 il3-20020a17090b164300b001c6d5ed3cacsm5713618pjb.1.2022.03.23.00.36.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Mar 2022 00:36:03 -0700 (PDT)
Message-ID: <f806c17c-cc7e-e2eb-e187-e83148160322@bytedance.com>
Date: Wed, 23 Mar 2022 15:32:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: Re: [PATCH v3 0/6] Support akcipher for virtio-crypto
Content-Language: en-US
To: Eric Biggers <ebiggers@kernel.org>
References: <20220323024912.249789-1-pizhenwei@bytedance.com>
 <YjqtXFvfDq0kELl7@sol.localdomain>
From: zhenwei pi <pizhenwei@bytedance.com>
In-Reply-To: <YjqtXFvfDq0kELl7@sol.localdomain>
Cc: herbert@gondor.apana.org.au, mst@redhat.com, qemu-devel@nongnu.org,
 virtualization@lists.linux-foundation.org, linux-crypto@vger.kernel.org,
 "helei.sig11@bytedance.com" <helei.sig11@bytedance.com>
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


On 3/23/22 13:17, Eric Biggers wrote:
> On Wed, Mar 23, 2022 at 10:49:06AM +0800, zhenwei pi wrote:
>> v2 -> v3:
>> - Introduce akcipher types to qapi
>> - Add test/benchmark suite for akcipher class
>> - Seperate 'virtio_crypto: Support virtio crypto asym operation' into:
>>    - crypto: Introduce akcipher crypto class
>>    - virtio-crypto: Introduce RSA algorithm
>>
>> v1 -> v2:
>> - Update virtio_crypto.h from v2 version of related kernel patch.
>>
>> v1:
>> - Support akcipher for virtio-crypto.
>> - Introduce akcipher class.
>> - Introduce ASN1 decoder into QEMU.
>> - Implement RSA backend by nettle/hogweed.
>>
>> Lei He (3):
>>    crypto-akcipher: Introduce akcipher types to qapi
>>    crypto: Implement RSA algorithm by hogweed
>>    tests/crypto: Add test suite for crypto akcipher
>>
>> Zhenwei Pi (3):
>>    virtio-crypto: header update
>>    crypto: Introduce akcipher crypto class
>>    virtio-crypto: Introduce RSA algorithm
> 
> You forgot to describe the point of this patchset and what its use case is.
> Like any other Linux kernel patchset, that needs to be in the cover letter.
> 
> - Eric
Thanks Eric for pointing this missing part.

This feature provides akcipher service offloading capability. QEMU side 
handles asymmetric requests via virtio-crypto devices from guest side, 
do encrypt/decrypt/sign/verify operations on host side, and return the 
result to guest.

This patchset implements a RSA backend by hogweed from nettle, it works 
together with guest patch:
https://lkml.org/lkml/2022/3/1/1425

-- 
zhenwei pi
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
