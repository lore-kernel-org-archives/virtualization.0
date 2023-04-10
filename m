Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A2E0C76196
	for <virtualization@archiver.kernel.org>; Mon, 10 Apr 2023 14:03:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id E55B840901;
	Mon, 10 Apr 2023 14:03:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E55B840901
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=oEWIIxAF
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jZgGys7b_N3j; Mon, 10 Apr 2023 14:03:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id F022A400D8;
	Mon, 10 Apr 2023 14:03:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org F022A400D8
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 97F7AC0037;
	Mon, 10 Apr 2023 14:03:07 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 20B45C002A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Apr 2023 14:03:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E308981EB2
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Apr 2023 14:03:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E308981EB2
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20210112 header.b=oEWIIxAF
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oYbB-iwL6mKb
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Apr 2023 14:03:04 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C90B681EAD
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com
 [IPv6:2607:f8b0:4864:20::102b])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C90B681EAD
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Apr 2023 14:03:04 +0000 (UTC)
Received: by mail-pj1-x102b.google.com with SMTP id
 pc4-20020a17090b3b8400b0024676052044so4672170pjb.1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Apr 2023 07:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20210112; t=1681135384; x=1683727384;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :sender:from:to:cc:subject:date:message-id:reply-to;
 bh=qY72AomAbMje6jRkZ+K0dBVO8y8e5SQs2AgwhNQHgaI=;
 b=oEWIIxAFZGUXoIe7xm1Ww8Nz5Z1O+m6YP4HtPpJ8p7hF+bFb+WyuYjq7x04iikFM+V
 rHVxzwXXMnvyiYcVtj5wcGfCt4t4q87NA1P1H95JgxzGknyyU/CEkZpl31YynsD+Jsrz
 gumTPlz6ysQsp2NrISfE2b94qiWJga0fqfYEIii2PDW/4rLJyrHlDvXpeFWhbL/zT0U6
 3BLmHxrSQwc14m5nuP+gak300fknTJrwK3qrf5wgFiUNEI1OF/qNEgjLUlIx+FspC1N3
 knJ1AP9JfKHwmN7tg4SvgsKxGmFR2wSHr3Fv5TxK+a4J4zs3QkdFX5fwwamB0n/e+xX6
 BpTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1681135384; x=1683727384;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :sender:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qY72AomAbMje6jRkZ+K0dBVO8y8e5SQs2AgwhNQHgaI=;
 b=vdRdwbUa8ErTYsazRfi4POutcc4KyyotrToKF/tI8ZTOg4ulFP/J+5w24fN5kdm7uj
 tF/LmkY1lrS2a75zcRKp992DR7U3z1rIpWbKKpFjbjW23lP1HkCW/mi2Bgbu/7FMFaQD
 cRsdhRoyPUz4Kn3grqdJEhFGYbtYvFjrw4toKSHvWLkHFs2IWVZfYHQXVokJPYt6+ngb
 vcDCCaC7SZmLpkj2ceTrErEGYgBuUFlSLjMNAP2d+p/SZjK2EqrGpOC2W0TJhjW8igLP
 DUZXshk/C2jBBE2a+/WRpF7V6xYaurv6dg+gBwEi6nn0EdKGXs8IeU/2Nw4HvWfbQgkU
 Dvaw==
X-Gm-Message-State: AAQBX9fq4lMt49t2m+SePH5Upe/DfGMoa2IZlBxyoWOM7dSCvxJhFw3z
 LJzuH/FwQ+ZyveURTuoyqX0=
X-Google-Smtp-Source: AKy350ZhmibEj2DixzKyVcxxNP46/k57WPd2OqJaXKP90aKYHVrwKh1KvVPgM74ZIbICsziOKIE9Sw==
X-Received: by 2002:a17:902:f544:b0:1a1:d70f:7114 with SMTP id
 h4-20020a170902f54400b001a1d70f7114mr13250142plf.14.1681135384043; 
 Mon, 10 Apr 2023 07:03:04 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c?
 ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id
 p12-20020a1709028a8c00b001a63deeb5e2sm2108819plo.92.2023.04.10.07.03.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Apr 2023 07:03:03 -0700 (PDT)
Message-ID: <2facc7cd-81fa-b8b7-6974-217392906578@roeck-us.net>
Date: Mon, 10 Apr 2023 07:03:01 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] vdpa: solidrun: constify pointers to hwmon_channel_info
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20230407150130.79917-1-krzysztof.kozlowski@linaro.org>
 <0395eff6-694e-1a2f-de78-8cb9d7b129a7@roeck-us.net>
 <20230410055634-mutt-send-email-mst@kernel.org>
From: Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20230410055634-mutt-send-email-mst@kernel.org>
Cc: linux-hwmon@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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

On 4/10/23 02:56, Michael S. Tsirkin wrote:
> On Fri, Apr 07, 2023 at 04:08:30PM -0700, Guenter Roeck wrote:
>> On 4/7/23 08:01, Krzysztof Kozlowski wrote:
>>> Statically allocated array of pointed to hwmon_channel_info can be made
>>> const for safety.
>>>
>>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>>
>>> ---
>>>
>>> This depends on hwmon core patch:
>>> https://lore.kernel.org/all/20230406203103.3011503-2-krzysztof.kozlowski@linaro.org/
>>>
>>> Therefore I propose this should also go via hwmon tree.
>>
>> I am not going to apply patches for 10+ subsystems through the hwmon tree.
>> This can only result in chaos. The dependent patch is available at
>>
>> git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-const
> 
> Doesn't it cause build errors or warnings there?
> 

Are you saying that "hwmon: constify pointers to hwmon_channel_info" applied on its own
on top of v6.3-rc5 (as done in above branch) causes build errors or warnings ?
I have not seen any such reports, and I don't immediately see why that would be
the case. Please elaborate.

Guenter

>> or wait until after the next commit window to apply this patch.
>>
>> Thanks,
>> Guenter
>>
>>>
>>> Cc: Jean Delvare <jdelvare@suse.com>
>>> Cc: Guenter Roeck <linux@roeck-us.net>
>>> Cc: linux-hwmon@vger.kernel.org
>>> ---
>>>    drivers/vdpa/solidrun/snet_hwmon.c | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/vdpa/solidrun/snet_hwmon.c b/drivers/vdpa/solidrun/snet_hwmon.c
>>> index e695e36ff753..65304354b34a 100644
>>> --- a/drivers/vdpa/solidrun/snet_hwmon.c
>>> +++ b/drivers/vdpa/solidrun/snet_hwmon.c
>>> @@ -159,7 +159,7 @@ static const struct hwmon_ops snet_hwmon_ops = {
>>>    	.read_string = snet_hwmon_read_string
>>>    };
>>> -static const struct hwmon_channel_info *snet_hwmon_info[] = {
>>> +static const struct hwmon_channel_info * const snet_hwmon_info[] = {
>>>    	HWMON_CHANNEL_INFO(temp, HWMON_T_INPUT | HWMON_T_MAX | HWMON_T_CRIT | HWMON_T_LABEL,
>>>    			   HWMON_T_INPUT | HWMON_T_CRIT | HWMON_T_LABEL),
>>>    	HWMON_CHANNEL_INFO(power, HWMON_P_INPUT | HWMON_P_LABEL),
> 

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
