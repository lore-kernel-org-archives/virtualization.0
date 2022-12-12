Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96042C4332F
	for <virtualization@archiver.kernel.org>; Mon, 12 Dec 2022 19:05:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 0D49D400D0;
	Mon, 12 Dec 2022 19:05:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0D49D400D0
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=Cw0oiXQ1
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vbcuWue3VgHY; Mon, 12 Dec 2022 19:05:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 9E9BB40154;
	Mon, 12 Dec 2022 19:05:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9E9BB40154
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 79C25C0032;
	Mon, 12 Dec 2022 19:05:05 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8D595C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Dec 2022 19:05:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5453240202
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Dec 2022 19:05:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5453240202
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20210112 header.b=Cw0oiXQ1
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WLgbtpVEDKvl
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Dec 2022 19:05:03 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5517F4014B
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5517F4014B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Dec 2022 19:05:03 +0000 (UTC)
Received: by mail-ot1-x330.google.com with SMTP id
 m6-20020a9d7e86000000b0066ec505ae93so7888056otp.9
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Dec 2022 11:05:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :sender:from:to:cc:subject:date:message-id:reply-to;
 bh=ikOi/brEDS1RRSKmqeJmcWUMDmT651JD+MszxE9reuE=;
 b=Cw0oiXQ1iV3nwKNAb2Bm0S13p6hv8dYl8gkEbj48HuTZGf12sKG/HL5sS59bGEIBUl
 XqA3yGrssoSrZknRnJm7xQoucpT0W+VDfmGm3qAjJZC+P3CgYQcDZnUkmiz0JvAaIQfc
 OCIpBi24jtzbP4CatV8Le2CPb9L4WtzYhSjQcflx1D9XWD/hDdXS3AfjsaNKoGdQvwsc
 /iOoNFXMdz0eciDKS9DCu7/fz6u6+/ie0yhouiem3BlBJlvSZxNIlc9gJir0wq3dOLMw
 FpQxRnOnPZECUWdk2cpRgrfeT0dgDxte2lv0Nq/a3u74y6jSnRe6s/0Ui3H7sxpom2BF
 sFSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :sender:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ikOi/brEDS1RRSKmqeJmcWUMDmT651JD+MszxE9reuE=;
 b=0TO3IzSYAz077glZgJynQNgSlwlDT19PZrjbZ8KGLjwQLRksaQ0RE98Is8nUySIqsv
 FkKIz4Oj3pDnPYr8EGGu+osKQ988E8gogR2ly9WB8+JlLALmvAsFEqFhtSSKvRLCEx2B
 J/7izUX5aVvFT83KDT+1d53g+CmfKNup9lz9t5tX37ZTnQDghui9p1xzOCZeQ9QcioeH
 XNJIuB2pilbvjWiNj2PIhHF5NnjvVsIpWOrXu5c4c6pryrlwvv+kUIEZkTc1EHCnf7wg
 szT6UbapsuQsrFD9QVyfJfmpT2bQ+N3tJeUienYswd0YOk8JBBZAs0V8BwnTELun98zY
 0eTA==
X-Gm-Message-State: ANoB5pn6kbuvoyljuS8sPV+tFEVgT4mgxG5RewtY6x811E16/Dz5S5EZ
 vFkRZdLs+pgQ5+OaYVf9wGA=
X-Google-Smtp-Source: AA0mqf66QD7e1pgPXpU6quuymHO4LOa340MQczZT+ccvn0dgfx9ZCe2VpS37DWiZM+q0PxNVQidlpA==
X-Received: by 2002:a9d:4b0b:0:b0:66e:c0c9:876e with SMTP id
 q11-20020a9d4b0b000000b0066ec0c9876emr9243456otf.38.1670871902305; 
 Mon, 12 Dec 2022 11:05:02 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c?
 ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id
 c7-20020a9d4807000000b0066193df8edasm268395otf.34.2022.12.12.11.05.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Dec 2022 11:05:01 -0800 (PST)
Message-ID: <f02e6f0f-d144-3eed-03e2-e55f459f666c@roeck-us.net>
Date: Mon, 12 Dec 2022 11:05:00 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 3/3 v4] virtio: vdpa: new SolidNET DPU driver.
Content-Language: en-US
To: Alvaro Karsz <alvaro.karsz@solid-run.com>
References: <20221212142454.3225177-1-alvaro.karsz@solid-run.com>
 <20221212142454.3225177-4-alvaro.karsz@solid-run.com>
 <848cc714-b152-8cec-ce03-9b606f268aef@roeck-us.net>
 <CAJs=3_AdgWS23-t6dELgSfz7DS4U0eXuXP_UZ3Fn21VCEwA-4w@mail.gmail.com>
 <3f83e874-3d7c-cc97-2207-a47dbcfe960f@roeck-us.net>
 <CAJs=3_D6_TayfdSz9e6P6G+axyUht4iyHnwHgPJ8sXG2a3sm2w@mail.gmail.com>
 <CAJs=3_DhEpGjgNZ6+cJiK6WVCQkBYW0V2EvF9vhTW-K6VodB_Q@mail.gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <CAJs=3_DhEpGjgNZ6+cJiK6WVCQkBYW0V2EvF9vhTW-K6VodB_Q@mail.gmail.com>
Cc: Jean Delvare <jdelvare@suse.com>, linux-pci@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>,
 virtualization@lists.linux-foundation.org
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

On 12/12/22 09:56, Alvaro Karsz wrote:
>> Even better would be a separate CONFIG_SNET_VDPA_HWMON Kconfig option.
> 
> I prefer to wrap everything with a single Kconfig option.
> 
>> depends on HWMON || HWMON=n
> 
> Are you referring here to CONFIG_SNET_VDPA, or to the
> CONFIG_SNET_VDPA_HWMON you suggested?

Either

> Because if this refers to CONFIG_SNET_VDPA, HWMON=m  will block the driver.
> 

No, it won't. It would force SNET_VDPA to be built as module if HWMON
is built as module. Then you would not need IS_REACHABLE but could use
IS_ENABLED instead.

Guenter

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
