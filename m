Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBD04C77B6C
	for <virtualization@archiver.kernel.org>; Fri,  7 Apr 2023 23:08:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3314884286;
	Fri,  7 Apr 2023 23:08:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3314884286
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=iBqyp/jf
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NLDvhQQP3CZw; Fri,  7 Apr 2023 23:08:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 6F58B84209;
	Fri,  7 Apr 2023 23:08:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6F58B84209
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 51C8CC0037;
	Fri,  7 Apr 2023 23:08:36 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 135A5C002A
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Apr 2023 23:08:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id DC7FC61414
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Apr 2023 23:08:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org DC7FC61414
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20210112 header.b=iBqyp/jf
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KmWaelrjtli2
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Apr 2023 23:08:34 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D33A0613E7
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com
 [IPv6:2001:4860:4864:20::2b])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D33A0613E7
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Apr 2023 23:08:33 +0000 (UTC)
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-18412684c50so2966667fac.5
 for <virtualization@lists.linux-foundation.org>;
 Fri, 07 Apr 2023 16:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20210112; t=1680908913; x=1683500913;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :sender:from:to:cc:subject:date:message-id:reply-to;
 bh=z0hkBEX5cpOKVX71KoRB/i1EOEt0Xqxcn4gT4+N0vLI=;
 b=iBqyp/jfYd0IxkbcZPs/0btgSFWI/JIraYpK7PCOrdtyMDj0HmP6kPFZ4axjxY18a8
 T3S4xFrnQ/bz/Tzv3yo0FOq0A5YZfjk2PD4ljxaOvz16xLbgHXN9JWM54ob2/wNel51P
 EoVe7niHaIuuoSms5WXmuQl6A6AnwGsgZVGmYen8zJTEn/fKFh34Tw1rOP3apNeem8lI
 6pNsTFaJgplSTHFitOpYgSsUySdVf1ndDjVCMOsfY9rW9e9nGxqIS/t2glPMiDtPjdQn
 xYMhQafqWtiX1MjXERMZ7/jmmLZCA8Pe5EPVUUBSdN4wUv49x/2IRUGZesG+NcLMaqsy
 vYaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1680908913; x=1683500913;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :sender:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=z0hkBEX5cpOKVX71KoRB/i1EOEt0Xqxcn4gT4+N0vLI=;
 b=ikptFHb4a1uINFOF4jE72v922t2CJ5GIIzODDjQUnHNZN8EkvzWe0Qkr6mMnYCejv/
 YwUC/u7vsFI+wcY1lsjya4CV8jvNZbMvtS48G/DmTtjtyHRocFMVO0azubv0nPzE8ac3
 yCcHYzb325OjDuqu+IHkgjN5yzeYegi0DkI0V7qe3chW7ZeQGeWMxQlPNJiStt+yqkF+
 TiQEEyFlFzLzrRSIhoGuVb+aUdqrmBwypuEZbXiIV0H12wqbGFwRKvXMFQeKctJL9oar
 wFr2Pgs3/CD8r5LR2gUuBuQEgLoEESHLrhAf7rzL8JEhkW+aMnu2WwmpiOw0R4fwgGt6
 JGJw==
X-Gm-Message-State: AAQBX9cr0HRy08d1gDEa0IllDrclath7Ol1hA/rWWA6utR2RPrcp2lf9
 1BhmsNnSX8HzmYNY5D0p3/g=
X-Google-Smtp-Source: AKy350ZimLsqaUdfR8lke4vOG1f+tCvH1NBCHAkQpCqddi4hjPOjf5aYAn1yAgh2kUEUfcgwTL2z8w==
X-Received: by 2002:a05:6871:90:b0:177:c62f:b059 with SMTP id
 u16-20020a056871009000b00177c62fb059mr268188oaa.49.1680908912809; 
 Fri, 07 Apr 2023 16:08:32 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c?
 ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id
 t21-20020a9d5915000000b006a13dd5c8a2sm2084662oth.5.2023.04.07.16.08.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Apr 2023 16:08:32 -0700 (PDT)
Message-ID: <0395eff6-694e-1a2f-de78-8cb9d7b129a7@roeck-us.net>
Date: Fri, 7 Apr 2023 16:08:30 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] vdpa: solidrun: constify pointers to hwmon_channel_info
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Alvaro Karsz <alvaro.karsz@solid-run.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
References: <20230407150130.79917-1-krzysztof.kozlowski@linaro.org>
From: Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20230407150130.79917-1-krzysztof.kozlowski@linaro.org>
Cc: linux-hwmon@vger.kernel.org, Jean Delvare <jdelvare@suse.com>
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

On 4/7/23 08:01, Krzysztof Kozlowski wrote:
> Statically allocated array of pointed to hwmon_channel_info can be made
> const for safety.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> This depends on hwmon core patch:
> https://lore.kernel.org/all/20230406203103.3011503-2-krzysztof.kozlowski@linaro.org/
> 
> Therefore I propose this should also go via hwmon tree.

I am not going to apply patches for 10+ subsystems through the hwmon tree.
This can only result in chaos. The dependent patch is available at

git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-const

or wait until after the next commit window to apply this patch.

Thanks,
Guenter

> 
> Cc: Jean Delvare <jdelvare@suse.com>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: linux-hwmon@vger.kernel.org
> ---
>   drivers/vdpa/solidrun/snet_hwmon.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/vdpa/solidrun/snet_hwmon.c b/drivers/vdpa/solidrun/snet_hwmon.c
> index e695e36ff753..65304354b34a 100644
> --- a/drivers/vdpa/solidrun/snet_hwmon.c
> +++ b/drivers/vdpa/solidrun/snet_hwmon.c
> @@ -159,7 +159,7 @@ static const struct hwmon_ops snet_hwmon_ops = {
>   	.read_string = snet_hwmon_read_string
>   };
>   
> -static const struct hwmon_channel_info *snet_hwmon_info[] = {
> +static const struct hwmon_channel_info * const snet_hwmon_info[] = {
>   	HWMON_CHANNEL_INFO(temp, HWMON_T_INPUT | HWMON_T_MAX | HWMON_T_CRIT | HWMON_T_LABEL,
>   			   HWMON_T_INPUT | HWMON_T_CRIT | HWMON_T_LABEL),
>   	HWMON_CHANNEL_INFO(power, HWMON_P_INPUT | HWMON_P_LABEL),

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
