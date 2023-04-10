Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5FC4C76196
	for <virtualization@archiver.kernel.org>; Mon, 10 Apr 2023 10:00:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 3289740B52;
	Mon, 10 Apr 2023 10:00:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3289740B52
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igel-co-jp.20210112.gappssmtp.com header.i=@igel-co-jp.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=IDv2Pb1q
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yGYthHpoRg7U; Mon, 10 Apr 2023 10:00:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 5CCB9408BD;
	Mon, 10 Apr 2023 10:00:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5CCB9408BD
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 422ACC0037;
	Mon, 10 Apr 2023 10:00:11 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A2619C002A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Apr 2023 10:00:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6F62B40A08
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Apr 2023 10:00:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6F62B40A08
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id b56Tknukp_ko
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Apr 2023 10:00:09 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A7EB4408BD
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com
 [IPv6:2607:f8b0:4864:20::1032])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A7EB4408BD
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Apr 2023 10:00:09 +0000 (UTC)
Received: by mail-pj1-x1032.google.com with SMTP id
 q15-20020a17090a2dcf00b0023efab0e3bfso6829705pjm.3
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Apr 2023 03:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=igel-co-jp.20210112.gappssmtp.com; s=20210112; t=1681120809;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1lOn71eOpVH75+mzBFJgeHPK/bE4oCp6up1ds6aJ9dU=;
 b=IDv2Pb1q8CQSZ0dn9AEvTUL7La35AnVpTkWiO5k4hgtk1vN3OBuSIYblAvhssVpsHV
 RssDkI5d8UtWU1+JSN6NnZvXrlXlkRbY/97+mH3CGe92FftSlVwBAlVAOCIQ0mwXeoXi
 b+1lB0F+jbI6NRHoQ7e1HrA9+6fti25ipytnzBcI9qT9x6Rv/rD4GQxtx4tmVncwF3a3
 icPjQHMmFckiZdkoEIxb6hTK/Nbi3/sjIVwhuDl5oNktvh6Pmhi9ygqD/YfieFQzSebx
 PxHCqvCJuKHvj2SrCN+7JKIx/4HGs0v53KGumC0AXezB6WH4oS7e6g0UTPtYDJt2/0KE
 ZJzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1681120809;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1lOn71eOpVH75+mzBFJgeHPK/bE4oCp6up1ds6aJ9dU=;
 b=B8gCbJd8kAeeH4aunPTwDe3WWCnJvfz2Hc7uJL0RqgyKrjYa6Ldw+atWQH0DYE/+LU
 2U/1qnYkdXRmAnc6UuCFrsVU0VFA0hzvqp8LLDJMgufwYarVdlktx8pjaPK8XXkzulfF
 2xJjLo3NKgcIrChktFcG+Yz8BmjSsTTaCFFVlPs6ZLYfOMTxLGmS8lUGK0IJNkAjJnvp
 hlh455KYOMz+SCxjeQt3yK3UUF+Be5gVC9TLMzGvnTkdqEKvXBrzCoQ5o1tZxvRCqX+e
 MqRJuO7b02aDjJE4JXehroM+Ym314vlHuE1v8wFMhLOHHFlD2/l2D5m5DGuOA1LPVzoV
 rO5g==
X-Gm-Message-State: AAQBX9ejCJNOtBkllqlWhTdjDc1gjo6CEaoM3a6SVdagAdDw4qZJlNxh
 npvQcrPzx+/mTS4y6JRzWNcB3A==
X-Google-Smtp-Source: AKy350a7xWTWdOZiQI/K8arMXIWagE5vLIjHC5mhuISjeRI/iHZx3CTkQK/JnKwWoTvO4JQGgxdD0A==
X-Received: by 2002:a17:90b:2241:b0:246:9c75:351a with SMTP id
 hk1-20020a17090b224100b002469c75351amr3658215pjb.12.1681120808990; 
 Mon, 10 Apr 2023 03:00:08 -0700 (PDT)
Received: from [10.16.161.199] (napt.igel.co.jp. [219.106.231.132])
 by smtp.gmail.com with ESMTPSA id
 b11-20020a17090a550b00b0023cd53e7706sm8800617pji.47.2023.04.10.03.00.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Apr 2023 03:00:08 -0700 (PDT)
Message-ID: <cd2619b1-5d0b-1e7e-12bd-bcb9dcb5c533@igel.co.jp>
Date: Mon, 10 Apr 2023 19:00:04 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.0
Subject: Re: [PATCH] tools/virtio: fix build caused by virtio_ring changes
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20230410092419.302932-1-mie@igel.co.jp>
 <20230410054259-mutt-send-email-mst@kernel.org>
From: Shunsuke Mie <mie@igel.co.jp>
In-Reply-To: <20230410054259-mutt-send-email-mst@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
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


On 2023/04/10 18:46, Michael S. Tsirkin wrote:
> On Mon, Apr 10, 2023 at 06:24:19PM +0900, Shunsuke Mie wrote:
>> Fix the build dependency for virtio_test. virtio_ring requires
>> container_of_const() and struce device.
>>
>> Signed-off-by: Shunsuke Mie <mie@igel.co.jp>
>> ---
>>   tools/include/linux/container_of.h | 36 ++++++++++++++++++++++++++++++
>>   tools/virtio/linux/compiler.h      |  3 +++
>>   tools/virtio/linux/kernel.h        |  5 +----
>>   tools/virtio/linux/module.h        |  1 +
>>   4 files changed, 41 insertions(+), 4 deletions(-)
>>   create mode 100644 tools/include/linux/container_of.h
>>
>> diff --git a/tools/include/linux/container_of.h b/tools/include/linux/container_of.h
>> new file mode 100644
>> index 000000000000..06e293b7cfda
>> --- /dev/null
>> +++ b/tools/include/linux/container_of.h
>> @@ -0,0 +1,36 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +#ifndef _LINUX_CONTAINER_OF_H
>> +#define _LINUX_CONTAINER_OF_H
>> +
>> +#include <linux/build_bug.h>
>> +#include <linux/stddef.h>
>> +
>> +/**
>> + * container_of - cast a member of a structure out to the containing structure
>> + * @ptr:	the pointer to the member.
>> + * @type:	the type of the container struct this is embedded in.
>> + * @member:	the name of the member within the struct.
>> + *
>> + * WARNING: any const qualifier of @ptr is lost.
>> + */
>> +#define container_of(ptr, type, member) ({				\
>> +	void *__mptr = (void *)(ptr);					\
>> +	static_assert(__same_type(*(ptr), ((type *)0)->member) ||	\
>> +		      __same_type(*(ptr), void),			\
>> +		      "pointer type mismatch in container_of()");	\
>> +	((type *)(__mptr - offsetof(type, member))); })
>> +
>> +/**
>> + * container_of_const - cast a member of a structure out to the containing
>> + *			structure and preserve the const-ness of the pointer
>> + * @ptr:		the pointer to the member
>> + * @type:		the type of the container struct this is embedded in.
>> + * @member:		the name of the member within the struct.
>> + */
>> +#define container_of_const(ptr, type, member)				\
>> +	_Generic(ptr,							\
>> +		const typeof(*(ptr)) *: ((const type *)container_of(ptr, type, member)),\
>> +		default: ((type *)container_of(ptr, type, member))	\
>> +	)
>> +
>> +#endif	/* _LINUX_CONTAINER_OF_H */
>
> Please just do
> #include "../../../include/linux/container_of.h"
> instead.
Okey, I'll do that.
>
>
>> diff --git a/tools/virtio/linux/compiler.h b/tools/virtio/linux/compiler.h
>> index 2c51bccb97bb..ac27b3ea6e67 100644
>> --- a/tools/virtio/linux/compiler.h
>> +++ b/tools/virtio/linux/compiler.h
>> @@ -8,4 +8,7 @@
>>   #define READ_ONCE(var) (*((volatile typeof(var) *)(&(var))))
>>   
>>   #define __aligned(x) __attribute((__aligned__(x)))
>> +
>> +#define __same_type(a, b) __builtin_types_compatible_p(typeof(a), typeof(b))
>> +
>>   #endif
> #include "../../../include/linux/compiler_types.h" instead?
I'll try it.
>> diff --git a/tools/virtio/linux/kernel.h b/tools/virtio/linux/kernel.h
>> index 8b877167933d..3cd20cb92649 100644
>> --- a/tools/virtio/linux/kernel.h
>> +++ b/tools/virtio/linux/kernel.h
>> @@ -10,6 +10,7 @@
>>   #include <stdarg.h>
>>   
>>   #include <linux/compiler.h>
>> +#include <linux/container_of.h>
>>   #include <linux/log2.h>
>>   #include <linux/types.h>
>>   #include <linux/overflow.h>
>> @@ -107,10 +108,6 @@ static inline void free_page(unsigned long addr)
>>   	free((void *)addr);
>>   }
>>   
>> -#define container_of(ptr, type, member) ({			\
>> -	const typeof( ((type *)0)->member ) *__mptr = (ptr);	\
>> -	(type *)( (char *)__mptr - offsetof(type,member) );})
>> -
>>   # ifndef likely
>>   #  define likely(x)	(__builtin_expect(!!(x), 1))
>>   # endif
>> diff --git a/tools/virtio/linux/module.h b/tools/virtio/linux/module.h
>> index 9dfa96fea2b2..e2e791dbd104 100644
>> --- a/tools/virtio/linux/module.h
>> +++ b/tools/virtio/linux/module.h
>> @@ -5,3 +5,4 @@
>>   	static __attribute__((unused)) const char *__MODULE_LICENSE_name = \
>>   		__MODULE_LICENSE_value
>>   
>> +struct device;
>
> It's not there in include/linux/module - pls put it in the
> same here where it is for linux.
I understood. I'll add some files that has the definition.
>> -- 
>> 2.25.1

Best regards,

Shunsuke.

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
