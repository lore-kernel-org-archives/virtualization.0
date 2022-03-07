Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41C2FC433EF
	for <virtualization@archiver.kernel.org>; Mon,  7 Mar 2022 09:10:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DFFEC81AF5;
	Mon,  7 Mar 2022 09:10:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QUIH7zg-qPpv; Mon,  7 Mar 2022 09:10:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 8BA0E81ABA;
	Mon,  7 Mar 2022 09:10:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 679BFC001D;
	Mon,  7 Mar 2022 09:10:51 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 78BC2C000B
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Mar 2022 09:10:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5426B40926
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Mar 2022 09:10:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=bytedance-com.20210112.gappssmtp.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uhppU_TnMgYk
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Mar 2022 09:10:49 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com
 [IPv6:2607:f8b0:4864:20::532])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 86B5540923
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Mar 2022 09:10:48 +0000 (UTC)
Received: by mail-pg1-x532.google.com with SMTP id t187so8756103pgb.1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 07 Mar 2022 01:10:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20210112.gappssmtp.com; s=20210112;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=BGwyYo7g1htnNGKOyrQxUnucb3lG+yHE/6CNQIclhU4=;
 b=M/TRFnQNOVHFac3+Y4t+KdG579bu88UML933YrFzRxZ3JT52mO0DSGwu0RCo7Kf7kK
 kpUp/r/MuLMQSvDq4Q5/B0kw+9krsbLcXCirGybrySkWNrYiPXeCJYl/h2k/1hBcnojl
 aA5P9ul8FTU66oeZRwhflmHzc8yyH+f0wlETkYQg2x+3BLyDiVYu7zFCdhMK67J4dZ9V
 JGvlUmkg+Y1UMQjhmHiftQHYn6mNnfQG38IyfeKa8Qc3/onLq4zTROHO40m/XrOyzryF
 9opcdaewEXlnUGjCKPNtZygo9AbhcZm8gButQvKwuSVsqe4d8mh5AUFz20/Y8thEwB7I
 AmVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=BGwyYo7g1htnNGKOyrQxUnucb3lG+yHE/6CNQIclhU4=;
 b=c/NBEzOCsx3kLx9ez9ec6UwE/rhAr0LKBFiVlmqBeUWgtQoDo5CfN4vxj7c40M1y/M
 xjxlu2UH+9iHUuYh84JcC2XSAaT0bCxh6+nRp4j4WlB2VZ583aOfMp5bDjWMH0ILKbMU
 0l6NXD5c3Rmfu6NyUxkpah0BJv3vF1o/IQ129mrJb+I5jCY7vvS8FXspIiJ1auynV1aE
 mMCVlcHgga/IPvt+BXZfe5A2IgE8BzCCxWWBkzD8AHxwnh3roWhBZ1NORPLv9JKD1+Nz
 LJs+R4gTQkzwqy2lkhP91p+mKlvQoNomV7LeVBwrycDtvSBpppWItjwA/n6QOk4ptzyp
 Gblg==
X-Gm-Message-State: AOAM530k5ziMwkOsR1hOrKPb6BlJjgNDpltbWupGJQ0ufTMsM4TX7UvI
 963+oFjdWNxdpHcKoyLPWVaH4g==
X-Google-Smtp-Source: ABdhPJw5FNg9UcOK8tkQrJCwqMGFgXjBCkXtPMQZwPCYqKm/YKFsvsHoDlTsgVbHJMN1tHThFbp4ew==
X-Received: by 2002:a05:6a00:244f:b0:4cc:a2ba:4cd8 with SMTP id
 d15-20020a056a00244f00b004cca2ba4cd8mr11758227pfj.74.1646644247704; 
 Mon, 07 Mar 2022 01:10:47 -0800 (PST)
Received: from [10.76.15.169] ([61.120.150.76])
 by smtp.gmail.com with ESMTPSA id
 o19-20020a056a0015d300b004f6e4dc74b5sm6346050pfu.92.2022.03.07.01.10.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Mar 2022 01:10:47 -0800 (PST)
Subject: Re: Re: [PATCH v3 0/4] Introduce akcipher service for virtio-crypto
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20220302033917.1295334-1-pizhenwei@bytedance.com>
 <a9d1dfc1-080e-fba2-8fbb-28718b067e0d@bytedance.com>
 <20220307040431-mutt-send-email-mst@kernel.org>
From: zhenwei pi <pizhenwei@bytedance.com>
Message-ID: <a950f727-cda8-3259-b35e-e1306035dbde@bytedance.com>
Date: Mon, 7 Mar 2022 17:07:53 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220307040431-mutt-send-email-mst@kernel.org>
Content-Language: en-US
Cc: herbert@gondor.apana.org.au, cohuck@redhat.com,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 linux-crypto@vger.kernel.org, helei.sig11@bytedance.com
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

On 3/7/22 5:05 PM, Michael S. Tsirkin wrote:
> On Mon, Mar 07, 2022 at 10:42:30AM +0800, zhenwei pi wrote:
>> Hi, Michael & Lei
>>
>> The full patchset has been reviewed by Gonglei, thanks to Gonglei.
>> Should I modify the virtio crypto specification(use "__le32 akcipher_algo;"
>> instead of "__le32 reserve;" only, see v1->v2 change), and start a new issue
>> for a revoting procedure?
> 
> You can but not it probably will be deferred to 1.3. OK with you?
> 

OK!

-- 
zhenwei pi
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
