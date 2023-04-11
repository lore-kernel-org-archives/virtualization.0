Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E746C77B61
	for <virtualization@archiver.kernel.org>; Tue, 11 Apr 2023 03:17:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A68F76141E;
	Tue, 11 Apr 2023 03:17:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A68F76141E
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igel-co-jp.20210112.gappssmtp.com header.i=@igel-co-jp.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=shohQdAn
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sSMsKfJUBd2O; Tue, 11 Apr 2023 03:17:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 1A61861413;
	Tue, 11 Apr 2023 03:17:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1A61861413
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EB16DC0037;
	Tue, 11 Apr 2023 03:17:54 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4A359C002A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Apr 2023 03:17:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2504D82021
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Apr 2023 03:17:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2504D82021
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=igel-co-jp.20210112.gappssmtp.com
 header.i=@igel-co-jp.20210112.gappssmtp.com header.a=rsa-sha256
 header.s=20210112 header.b=shohQdAn
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id m8XloFdmgvDe
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Apr 2023 03:17:52 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 21CF782018
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com
 [IPv6:2607:f8b0:4864:20::431])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 21CF782018
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Apr 2023 03:17:52 +0000 (UTC)
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-63238429f87so683901b3a.0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Apr 2023 20:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=igel-co-jp.20210112.gappssmtp.com; s=20210112; t=1681183071;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0i4sacpzXDdA/hnFZhlWTyon+8D7LzSMzXk2XHrkT40=;
 b=shohQdAnhYMUMlB4tI9RYOTnYwy60WZ5spGEWv+d4W6D3qVgZFQJtLvK9+fESJ4AJ+
 pqzsVjYJEvKS1C5xRf2CRRPQ39ICdFkFn4AyBINrGlN19van8TJkdSJJAszBBIgxC96D
 /w5OlvoWJYzaxPQVH2+5SCVL6Rxe+q2quS5v9Z3FDssCZNWBB3jhBUfoUwXXMRtrv4Ic
 LoC+0xmopfhAM71kIkjJmKt8bvzKVCIuguOjZ2zLmJhsFmp5mbiWdQLmR8I9EqDfUQnm
 m2Z7huSZa1UYO7/BheuSA/rwRDTrqNJzhn//Z1+GPkRjS3a9xlQt1lCIY8gWi63S6tfq
 g+nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1681183071;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0i4sacpzXDdA/hnFZhlWTyon+8D7LzSMzXk2XHrkT40=;
 b=PVN76nUtAD6dgapfFXxETZKPwfyrjSfSNktm6Guex5BAS9b6BgfWAFNNzAHou+/sJu
 gcNAlFAQZqhcPKzYmyAOGBiKt6F3ZA6IpivJXwihOHr245JvEeCmVQ4gshBAiPRC43Xj
 vdMuTBtBypjK+g834HbZ6U8kHiimjNYuPgW0FvBI99xXsLOJh2/Su1zucljBoF0FJgc1
 EjdOd7x8NlBifSuLZnWFTNh/U45mEj5pPOcW54ZPM+D0dNphn2H0WfJfoOICQPTcwc3R
 j81PpsGFb1HQYjQpbCJVbzLhFaRRrEGyPaI9u52D8eEfH48ymiyzO/+PjfhKEQHwo88r
 TKog==
X-Gm-Message-State: AAQBX9eclj7acwk4ckjJm9477bG2snj8ENGyr1371XyLLOCSK1Mbrzo5
 1QECXi5dlAWRq6JNpd8Qk3+bhA==
X-Google-Smtp-Source: AKy350Zu+w9A/P0WWtC00arO5OtiFSv2vBGHTuwKwC/YXhPPZgWJCoXoFfM/q9wcXM9rtM0WWEqbDQ==
X-Received: by 2002:aa7:956c:0:b0:626:2ce1:263c with SMTP id
 x12-20020aa7956c000000b006262ce1263cmr1462738pfq.5.1681183071512; 
 Mon, 10 Apr 2023 20:17:51 -0700 (PDT)
Received: from [10.16.161.199] (napt.igel.co.jp. [219.106.231.132])
 by smtp.gmail.com with ESMTPSA id
 d16-20020aa78690000000b00639c1fc8766sm1865246pfo.212.2023.04.10.20.17.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Apr 2023 20:17:51 -0700 (PDT)
Message-ID: <7e7f5268-c64e-c207-8b4d-f017816c4dfe@igel.co.jp>
Date: Tue, 11 Apr 2023 12:17:48 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.0
Subject: Re: [PATCH v2 2/2] tools/virtio: fix build caused by virtio_ring
 changes
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
References: <20230410112845.337212-1-mie@igel.co.jp>
 <20230410112845.337212-2-mie@igel.co.jp>
 <20230410080014-mutt-send-email-mst@kernel.org>
 <2023041055-provided-antiquely-bbdb@gregkh>
From: Shunsuke Mie <mie@igel.co.jp>
In-Reply-To: <2023041055-provided-antiquely-bbdb@gregkh>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org,
 "Matthew Wilcox \(Oracle\)" <willy@infradead.org>,
 virtualization@lists.linux-foundation.org,
 =?UTF-8?Q?Eugenio_P=c3=a9rez?= <eperezma@redhat.com>,
 Sakari Ailus <sakari.ailus@linux.intel.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
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


On 2023/04/11 3:40, Greg Kroah-Hartman wrote:
> On Mon, Apr 10, 2023 at 08:00:33AM -0400, Michael S. Tsirkin wrote:
>> On Mon, Apr 10, 2023 at 08:28:45PM +0900, Shunsuke Mie wrote:
>>> Fix the build dependency for virtio_test. The virtio_ring that is used from
>>> the test requires container_of_const(). Change to use container_of.h kernel
>>> header directly and adapt related codes.
>>>
>>> Signed-off-by: Shunsuke Mie <mie@igel.co.jp>
>> This is only for next right? That's where container_of_const
>> things are I think ...
> container_of_const() is in 6.2.
>
>
>>> ---
>>>   tools/include/linux/types.h   |  1 -
>>>   tools/virtio/linux/compiler.h |  2 ++
>>>   tools/virtio/linux/kernel.h   |  5 +----
>>>   tools/virtio/linux/module.h   |  1 -
>>>   tools/virtio/linux/uaccess.h  | 11 ++---------
>>>   5 files changed, 5 insertions(+), 15 deletions(-)
>>>
>>> diff --git a/tools/include/linux/types.h b/tools/include/linux/types.h
>>> index 051fdeaf2670..f1896b70a8e5 100644
>>> --- a/tools/include/linux/types.h
>>> +++ b/tools/include/linux/types.h
>>> @@ -49,7 +49,6 @@ typedef __s8  s8;
>>>   #endif
>>>   
>>>   #define __force
>>> -#define __user
> Why is this needed?
>
>>>   #define __must_check
>>>   #define __cold
>>>   
>>> diff --git a/tools/virtio/linux/compiler.h b/tools/virtio/linux/compiler.h
>>> index 2c51bccb97bb..1f3a15b954b9 100644
>>> --- a/tools/virtio/linux/compiler.h
>>> +++ b/tools/virtio/linux/compiler.h
>>> @@ -2,6 +2,8 @@
>>>   #ifndef LINUX_COMPILER_H
>>>   #define LINUX_COMPILER_H
>>>   
>>> +#include "../../../include/linux/compiler_types.h"
> While I understand your need to not want to duplicate code, what in the
> world is this doing?  Why not use the in-kernel compiler.h instead?  Why
> are you copying loads of .h files into tools/virtio/?  What is this for
> and why not just use the real files so you don't have to even attempt to
> try to keep things in sync (hint, they will always be out of sync.)
>
>>> +
>>>   #define WRITE_ONCE(var, val) \
>>>   	(*((volatile typeof(val) *)(&(var))) = (val))
>>>   
>>> diff --git a/tools/virtio/linux/kernel.h b/tools/virtio/linux/kernel.h
>>> index 8b877167933d..6702008f7f5c 100644
>>> --- a/tools/virtio/linux/kernel.h
>>> +++ b/tools/virtio/linux/kernel.h
>>> @@ -10,6 +10,7 @@
>>>   #include <stdarg.h>
>>>   
>>>   #include <linux/compiler.h>
>>> +#include "../../../include/linux/container_of.h"
> Either do this for all .h files, or not, don't pick and choose.
>
>
>
>>>   #include <linux/log2.h>
>>>   #include <linux/types.h>
>>>   #include <linux/overflow.h>
>>> @@ -107,10 +108,6 @@ static inline void free_page(unsigned long addr)
>>>   	free((void *)addr);
>>>   }
>>>   
>>> -#define container_of(ptr, type, member) ({			\
>>> -	const typeof( ((type *)0)->member ) *__mptr = (ptr);	\
>>> -	(type *)( (char *)__mptr - offsetof(type,member) );})
>>> -
>>>   # ifndef likely
>>>   #  define likely(x)	(__builtin_expect(!!(x), 1))
>>>   # endif
>>> diff --git a/tools/virtio/linux/module.h b/tools/virtio/linux/module.h
>>> index 9dfa96fea2b2..5cf39167d47a 100644
>>> --- a/tools/virtio/linux/module.h
>>> +++ b/tools/virtio/linux/module.h
>>> @@ -4,4 +4,3 @@
>>>   #define MODULE_LICENSE(__MODULE_LICENSE_value) \
>>>   	static __attribute__((unused)) const char *__MODULE_LICENSE_name = \
>>>   		__MODULE_LICENSE_value
>>> -
> This change has nothing to do with what you said was happening in this
> patch :(
>
> Please be more careful.
>
>>> diff --git a/tools/virtio/linux/uaccess.h b/tools/virtio/linux/uaccess.h
>>> index 991dfb263998..cde2c344b260 100644
>>> --- a/tools/virtio/linux/uaccess.h
>>> +++ b/tools/virtio/linux/uaccess.h
>>> @@ -6,15 +6,10 @@
>>>   
>>>   extern void *__user_addr_min, *__user_addr_max;
>>>   
>>> -static inline void __chk_user_ptr(const volatile void *p, size_t size)
>>> -{
>>> -	assert(p >= __user_addr_min && p + size <= __user_addr_max);
>>> -}
>>> -
> What does this function have to do with container_of()?
>
>
>>>   #define put_user(x, ptr)					\
>>>   ({								\
>>>   	typeof(ptr) __pu_ptr = (ptr);				\
>>> -	__chk_user_ptr(__pu_ptr, sizeof(*__pu_ptr));		\
>>> +	__chk_user_ptr(__pu_ptr);		\
> Why are you trying to duplicate in-kernel .h files?
>
> This all doesn't look ok, sorry.
>
> greg k-h

Thank you. I'll modify problems you commented, but we have to discuss 
the design of tools/virtio.

Best regards,

Shunsuke.

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
