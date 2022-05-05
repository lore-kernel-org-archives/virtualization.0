Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDD19C433EF
	for <virtualization@archiver.kernel.org>; Thu,  5 May 2022 09:33:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 7AA8C40A17;
	Thu,  5 May 2022 09:33:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IEfB0N2H8TWh; Thu,  5 May 2022 09:33:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id E49764060B;
	Thu,  5 May 2022 09:33:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B9F5BC0032;
	Thu,  5 May 2022 09:33:19 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id ABE79C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu,  5 May 2022 09:33:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8634A4070B
 for <virtualization@lists.linux-foundation.org>;
 Thu,  5 May 2022 09:33:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 13akVMox1pFN
 for <virtualization@lists.linux-foundation.org>;
 Thu,  5 May 2022 09:33:18 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com
 [IPv6:2607:f8b0:4864:20::52e])
 by smtp2.osuosl.org (Postfix) with ESMTPS id F16F14060B
 for <virtualization@lists.linux-foundation.org>;
 Thu,  5 May 2022 09:33:17 +0000 (UTC)
Received: by mail-pg1-x52e.google.com with SMTP id 202so3211434pgc.9
 for <virtualization@lists.linux-foundation.org>;
 Thu, 05 May 2022 02:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20210112.gappssmtp.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=LAABk+Hqn/ed3olCk7cLLnxGOLs8GPCl8qPvqmsVMMM=;
 b=ErbXNtFsbGBEns+3J2+rqVHArDPQgCAH5aInArNTr5Ytkh/2HnvkfZXsi+I8K9/fKL
 FOod075XSxK4u/V8rbUwYiTnw6NXlPrvknjrKk02/PKJgkljGMJxHnB+e1xcGiYhZC4J
 CVcjLuK/RXUvnMfbnldwLtRd3sIqwBcG5uKkEbX8yd+vyFbQZRSah9nEtuLOhACyZ3ya
 XaDrcJdsyj6SllWgRfR3/AOf2W1IRrw9wkJdWRgoV9vASSILU2/qzvlVf0Zxqb1gMZYI
 oIKjAQgqB18wWrdMBJP2VgJ1s0eE++rcSs3OtLqAt5iMcVjZMs3QZ4wqnKyLSuxZIqFR
 WDmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=LAABk+Hqn/ed3olCk7cLLnxGOLs8GPCl8qPvqmsVMMM=;
 b=KxABo2sMTCI58cKkQB8by4+wqY+9A1emDz18fbppqZdXSwnY0aEEhYLmp0wib7WGlj
 EBoMW2MAYXEnHMHFa/beL8NigabdQ65kBC+ZFjWY2JtbLquYgaaecNLSqD4Uvi4LUubV
 vYSDluaM0F17fPtg4ypWFFcVBGo0rnsuJ3vxpV7mHKSgUx2EnO9Gh44okMhe3+tD6W1p
 rFwLKkAILWPJCRnIG+N/fyc3bvJLpf185YvEKoA9L2bEvzojI62bHcaKufGzqymFyILH
 G5j50LkwLUO80IY+M6WiFkTsY9obfYa2rQ2NX6Laipp/UGgtUVK5iFfVxa6W/5ZhoGdh
 2qDQ==
X-Gm-Message-State: AOAM530ocDnVXIRCFnIyzQkxDbeBv2mLHtaJ6Kr9pgUxvEGjTRlKCgM+
 LFZIDk93Ed+i8Qs+6EX4cIaBng==
X-Google-Smtp-Source: ABdhPJwaIsuvBtKuAQv+SmYbKWs22EAjLiyHSuubS0HBGDuWiWajxYniwE9CGElZZX7/xwqc39QOow==
X-Received: by 2002:a65:5b81:0:b0:3aa:1671:c6a7 with SMTP id
 i1-20020a655b81000000b003aa1671c6a7mr21224552pgr.169.1651743197230; 
 Thu, 05 May 2022 02:33:17 -0700 (PDT)
Received: from [10.255.89.252] ([139.177.225.255])
 by smtp.gmail.com with ESMTPSA id
 mu6-20020a17090b388600b001d960eaed66sm1054035pjb.42.2022.05.05.02.33.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 May 2022 02:33:16 -0700 (PDT)
Message-ID: <ea42cb6e-cd1d-e0be-ab9f-382b75c070e8@bytedance.com>
Date: Thu, 5 May 2022 17:29:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: Re: PING: [PATCH v4 0/5] virtio-crypto: Improve performance
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20220424104140.44841-1-pizhenwei@bytedance.com>
 <cc9eb4aa-2e40-490f-f5a0-beee3a57313b@bytedance.com>
 <7f7ab8ae46174ed6b0888b5fbeb5849b@huawei.com>
 <20220505005607-mutt-send-email-mst@kernel.org>
From: zhenwei pi <pizhenwei@bytedance.com>
In-Reply-To: <20220505005607-mutt-send-email-mst@kernel.org>
Cc: "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
 "davem@davemloft.net" <davem@davemloft.net>,
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


On 5/5/22 12:57, Michael S. Tsirkin wrote:
> On Thu, May 05, 2022 at 03:14:40AM +0000, Gonglei (Arei) wrote:
>>
>>
>>> -----Original Message-----
>>> From: zhenwei pi [mailto:pizhenwei@bytedance.com]
>>> Sent: Thursday, May 5, 2022 10:35 AM
>>> To: Gonglei (Arei) <arei.gonglei@huawei.com>; mst@redhat.com;
>>> jasowang@redhat.com
>>> Cc: herbert@gondor.apana.org.au; linux-kernel@vger.kernel.org;
>>> virtualization@lists.linux-foundation.org; linux-crypto@vger.kernel.org;
>>> helei.sig11@bytedance.com; davem@davemloft.net
>>> Subject: PING: [PATCH v4 0/5] virtio-crypto: Improve performance
>>>
>>> Hi, Lei
>>>
>>> Jason replied in another patch:
>>> Still hundreds of lines of changes, I'd leave this change to other maintainers to
>>> decide.
>>>
>>> Quite frankly, the virtio crypto driver changed only a few in the past, and the
>>> performance of control queue is not good enough. I am in doubt about that this
>>> driver is not used widely. So I'd like to rework a lot, it would be best to complete
>>> this work in 5.18 window.
>>>
>>> This gets different point with Jason. I would appreciate it if you could give me
>>> any hint.
>>>
>>
>> This is already in my todo list.
>>
>> Regards,
>> -Gonglei
> 
> It's been out a month though, not really acceptable latency for review.
> So I would apply this for next,  but you need to address Dan Captenter's
> comment, and look for simular patterns elesewhere in your patch.
> 

I fixed this in the v5 series. Thanks!

-- 
zhenwei pi
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
