Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B11EEC76196
	for <virtualization@archiver.kernel.org>; Tue, 11 Apr 2023 03:25:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0AC2A418F2;
	Tue, 11 Apr 2023 03:25:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0AC2A418F2
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igel-co-jp.20210112.gappssmtp.com header.i=@igel-co-jp.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=bu1uq1So
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1nQuNEUqTE6F; Tue, 11 Apr 2023 03:25:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 2610D40978;
	Tue, 11 Apr 2023 03:25:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2610D40978
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F2EAEC0037;
	Tue, 11 Apr 2023 03:25:46 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 797B9C002A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Apr 2023 03:25:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3FD6E409A6
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Apr 2023 03:25:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3FD6E409A6
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=igel-co-jp.20210112.gappssmtp.com
 header.i=@igel-co-jp.20210112.gappssmtp.com header.a=rsa-sha256
 header.s=20210112 header.b=bu1uq1So
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EAh59-mY7JCS
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Apr 2023 03:25:43 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2771140609
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com
 [IPv6:2607:f8b0:4864:20::1029])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2771140609
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Apr 2023 03:25:43 +0000 (UTC)
Received: by mail-pj1-x1029.google.com with SMTP id c3so7612198pjg.1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Apr 2023 20:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=igel-co-jp.20210112.gappssmtp.com; s=20210112; t=1681183542;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7XUoNyfPy7EwnAW1tUOTNtWKEocwT7jAS6X1S3hv+0Q=;
 b=bu1uq1SovAZxCB4dUdo7ThN4+LGmO8IbueHdlC2chn8IZUuBUl3uZXSMSGiYLHLzWT
 dMiEJIeF2KsLVJXwRAG+8u0kmsICsa9U+PEhIGTWYxIh0RG/KLNkRMAXJDp6Z7+YTe+A
 Esx5PDnmp3zbtbss3AGhWsQdPa+orI266obiBhI/UKPCcbYTkAsL8OsKbF2eTATyhYYH
 giIq+ccyf1iHM8RGMGd55PHeAdm8cnFni48+6Ti556jqZI+PF4kb+Sb4kSWNYf9OBdHI
 2n+JlkGfmpNTcgrhkWcWJ4AnUjRtHwB5w9juDVFyj7erDm/nSviBk0oLZ1YcSrosiAYQ
 qVYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1681183542;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7XUoNyfPy7EwnAW1tUOTNtWKEocwT7jAS6X1S3hv+0Q=;
 b=EWQ7Av1PKSNAnmz9kzOXPetm/lvXdA/sf8CsYjjSttDLSQtrQVITh+8JEnsxwRheWP
 onfaqvfiLNXR/rfF6M0NuBtlklzFmpXdXExiG+aTirf0+DH2z0lD4VEKLxqL/KCF41VH
 HKkK3oAUntBn81TQyzRMcXazh/I0xOkMqdy7U3E+w7JTJHUKAvGfuq4unuI9Q82q+saz
 6M9I/9I2kDVlIHpkGGmFj8Lab2Udbp/mgaCyxoMZXUciJZHDsMfLIIEplhyDu71xHaDT
 5Zw34WciuWu0RH3RqjhqYHBhd9ZIsk0fn1AoCvPD8IM1V16Y9Qh8y6ZApAiTyLdebKy1
 DC5g==
X-Gm-Message-State: AAQBX9dEqkn4IdCNXse5LWNy4v0c3pBZ7fhf7fAFEjP0ErqbL6KxunOv
 x5w9HOU6t7HymgFDHaChU3UeBA==
X-Google-Smtp-Source: AKy350acoaF3Wr3Z0i9aFV4dHgpSlRzjzEyS/9M1NzDDRHPf/HuH6joogmQHqgd/iNHE3EDxyuzT8A==
X-Received: by 2002:a17:903:68b:b0:1a1:f95a:24f2 with SMTP id
 ki11-20020a170903068b00b001a1f95a24f2mr1080611plb.19.1681183542532; 
 Mon, 10 Apr 2023 20:25:42 -0700 (PDT)
Received: from [10.16.161.199] (napt.igel.co.jp. [219.106.231.132])
 by smtp.gmail.com with ESMTPSA id
 t13-20020a1709028c8d00b001a19196af48sm8452094plo.64.2023.04.10.20.25.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Apr 2023 20:25:42 -0700 (PDT)
Message-ID: <de392fbd-3ffd-466d-cc7f-32f55c03227f@igel.co.jp>
Date: Tue, 11 Apr 2023 12:25:39 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.0
Subject: Re: [PATCH v2 2/2] tools/virtio: fix build caused by virtio_ring
 changes
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20230410112845.337212-1-mie@igel.co.jp>
 <20230410112845.337212-2-mie@igel.co.jp>
 <20230410080014-mutt-send-email-mst@kernel.org>
 <2023041055-provided-antiquely-bbdb@gregkh>
 <20230410154035-mutt-send-email-mst@kernel.org>
From: Shunsuke Mie <mie@igel.co.jp>
In-Reply-To: <20230410154035-mutt-send-email-mst@kernel.org>
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


On 2023/04/11 4:44, Michael S. Tsirkin wrote:
> On Mon, Apr 10, 2023 at 08:40:34PM +0200, Greg Kroah-Hartman wrote:
>> On Mon, Apr 10, 2023 at 08:00:33AM -0400, Michael S. Tsirkin wrote:
>>> On Mon, Apr 10, 2023 at 08:28:45PM +0900, Shunsuke Mie wrote:
>>>> Fix the build dependency for virtio_test. The virtio_ring that is used from
>>>> the test requires container_of_const(). Change to use container_of.h kernel
>>>> header directly and adapt related codes.
>>>>
>>>> Signed-off-by: Shunsuke Mie <mie@igel.co.jp>
>>> This is only for next right? That's where container_of_const
>>> things are I think ...
>> container_of_const() is in 6.2.
>
> Absolutely but the patch switching virtio to that is not there.
>
>
>>>> ---
>>>>   tools/include/linux/types.h   |  1 -
>>>>   tools/virtio/linux/compiler.h |  2 ++
>>>>   tools/virtio/linux/kernel.h   |  5 +----
>>>>   tools/virtio/linux/module.h   |  1 -
>>>>   tools/virtio/linux/uaccess.h  | 11 ++---------
>>>>   5 files changed, 5 insertions(+), 15 deletions(-)
>>>>
>>>> diff --git a/tools/include/linux/types.h b/tools/include/linux/types.h
>>>> index 051fdeaf2670..f1896b70a8e5 100644
>>>> --- a/tools/include/linux/types.h
>>>> +++ b/tools/include/linux/types.h
>>>> @@ -49,7 +49,6 @@ typedef __s8  s8;
>>>>   #endif
>>>>   
>>>>   #define __force
>>>> -#define __user
>> Why is this needed?
>>
>>>>   #define __must_check
>>>>   #define __cold
>>>>   
>>>> diff --git a/tools/virtio/linux/compiler.h b/tools/virtio/linux/compiler.h
>>>> index 2c51bccb97bb..1f3a15b954b9 100644
>>>> --- a/tools/virtio/linux/compiler.h
>>>> +++ b/tools/virtio/linux/compiler.h
>>>> @@ -2,6 +2,8 @@
>>>>   #ifndef LINUX_COMPILER_H
>>>>   #define LINUX_COMPILER_H
>>>>   
>>>> +#include "../../../include/linux/compiler_types.h"
>> While I understand your need to not want to duplicate code, what in the
>> world is this doing?  Why not use the in-kernel compiler.h instead?  Why
>> are you copying loads of .h files into tools/virtio/?  What is this for
>> and why not just use the real files so you don't have to even attempt to
>> try to keep things in sync (hint, they will always be out of sync.)
> Because it's doing a very weird hack: building some kernel
> code into a userspace binary, used for just for testing.
> This is all not part of kernel build intentionally, no
> one is supposed to use this binary in production, but
> it was helpful in finding bugs in virtio core in the past
> so I keep it around.
Would it be possible to switch to in-kernel tests, such as KUnit? If it's
possible, we could use the kernel headers and implementations as they are,
and we could address the concerns that Greg raised I think.


Best regards,

Shunsuke

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
