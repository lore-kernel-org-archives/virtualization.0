Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BD50C433FE
	for <virtualization@archiver.kernel.org>; Tue, 24 May 2022 23:36:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 37C5F60AEA;
	Tue, 24 May 2022 23:36:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8kGpLk2-acQd; Tue, 24 May 2022 23:36:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id D091160A79;
	Tue, 24 May 2022 23:36:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A2A59C0039;
	Tue, 24 May 2022 23:36:53 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E135CC002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 May 2022 23:36:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id BBBAB60A91
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 May 2022 23:36:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id N0f3upw9C9YR
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 May 2022 23:36:50 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com
 [IPv6:2607:f8b0:4864:20::1036])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D6C4360A79
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 May 2022 23:36:50 +0000 (UTC)
Received: by mail-pj1-x1036.google.com with SMTP id
 v5-20020a17090a7c0500b001df84fa82f8so3536933pjf.5
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 May 2022 16:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20210112.gappssmtp.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=7d1GZoiIPgurRKHqYkbLbRfkJMBlTGlbTuzD6kjnHaA=;
 b=KeFIqxa6CCFetIxYiv9IdzoKB2DP/2IjtAPFyJN7ulMa+N9FmuID4xO83AXLE9XhxD
 QLC9D4pC5g086lAPfbPlDRGHNGdMHwddAVFaFt97S4GEoEBfL5enEWauuAld1AZRclVs
 vlk6RettmorUKl8wUHT10Vie0HCcM3Mx9wBPqG0i6qhZfHFc4kVMJS7KgOVSrQE0xBgI
 9LIyRn2BTe72SSbfwn7J7ox7BQCmbUiHCfzzLsvKvnGb9uty97mnBsqi4usWbcRHpKsb
 9kuGhvHlJM08XtjrVtsc39552A578wJHeQW3WGHq8tKjima0G3jN8kCS2zMVMq4kqLdj
 4kKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=7d1GZoiIPgurRKHqYkbLbRfkJMBlTGlbTuzD6kjnHaA=;
 b=w5xvXu7XtCUvJUmFXZZbaqnsv5WHu/CMeXXIjLLdSVnuG/TQbV7ANdklLjIaFUvgal
 QikJPAZoRcdPY3YL3QoCK4ObfDMVkTW/nm7eWiFgpRuUnGNEHVHBXcSZSUF4JUTvDet9
 B+BlQu88Eu5st2jjfji5n9SnS2HSuwQtDeR5zq/GhA6KwUPfWLtSH1qqEnxkAos0PMHQ
 AnlAXbTrJiOgEyZqxUrqnT7Yyu3ujoMrpk/o+gROhf1f+QbhcMTQeMrmePCgycdSojbt
 n4MvkkVck9lk/Uo142QTv4qbbhhHOb8XSm5NSD7+hZK8p05Gys69IPquiO8cBAxSKPdH
 MPvA==
X-Gm-Message-State: AOAM532vluEyhN5FYMP82RJF8VhtQWQSr1IADfupr19dPD5hcrgTCsfy
 f7IZdFs3tmAOT0NiJ/CdXZNntg==
X-Google-Smtp-Source: ABdhPJyYL9A7b9Eq9H2YA+sOCWRW25ucZlQtBHk+GLvqCYdvPljMLdHOrNVkUrPOkTAZFApgB75bJQ==
X-Received: by 2002:a17:90b:388c:b0:1df:cb4b:3e72 with SMTP id
 mu12-20020a17090b388c00b001dfcb4b3e72mr7391714pjb.130.1653435410036; 
 Tue, 24 May 2022 16:36:50 -0700 (PDT)
Received: from [10.255.89.252] ([139.177.225.239])
 by smtp.gmail.com with ESMTPSA id
 t11-20020a17090abc4b00b001df54d74adbsm272232pjv.25.2022.05.24.16.36.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 May 2022 16:36:49 -0700 (PDT)
Message-ID: <79d17b10-3532-57d4-e70c-3ccf1ab0d87d@bytedance.com>
Date: Wed, 25 May 2022 07:32:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: Re: [PATCH 3/3] virtio_balloon: Introduce memory recover
Content-Language: en-US
To: Sean Christopherson <seanjc@google.com>, david@redhat.com
References: <20220520070648.1794132-1-pizhenwei@bytedance.com>
 <20220520070648.1794132-4-pizhenwei@bytedance.com>
 <Yo0zmP28FqpivlxF@google.com>
From: zhenwei pi <pizhenwei@bytedance.com>
In-Reply-To: <Yo0zmP28FqpivlxF@google.com>
Cc: mst@redhat.com, qemu-devel@nongnu.org, naoya.horiguchi@nec.com,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 linux-mm@kvack.org, pbonzini@redhat.com, akpm@linux-foundation.org
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



On 5/25/22 03:35, Sean Christopherson wrote:
> On Fri, May 20, 2022, zhenwei pi wrote:
>> @@ -59,6 +60,12 @@ enum virtio_balloon_config_read {
>>   	VIRTIO_BALLOON_CONFIG_READ_CMD_ID = 0,
>>   };
>>   
>> +/* the request body to commucate with host side */
>> +struct __virtio_balloon_recover {
>> +	struct virtio_balloon_recover vbr;
>> +	__virtio32 pfns[VIRTIO_BALLOON_PAGES_PER_PAGE];
> 
> I assume this is copied from virtio_balloon.pfns, which also uses __virtio32, but
> isn't that horribly broken?  PFNs are 'unsigned long', i.e. 64 bits on 64-bit kernels.
> x86-64 at least most definitely generates 64-bit PFNs.  Unless there's magic I'm
> missing, page_to_balloon_pfn() will truncate PFNs and feed the host bad info.
> 

Yes, I also noticed this point, I suppose the balloon device can not 
work on a virtual machine which has physical address larger than 16T.

I still let the recover VQ keep aligned with the inflate VQ and deflate 
VQ. I prefer the recover VQ to be workable/unworkable with 
inflate/deflate VQ together. So I leave this to the virtio balloon 
maintainer to decide ...

>> @@ -494,6 +511,198 @@ static void update_balloon_size_func(struct work_struct *work)
>>   		queue_work(system_freezable_wq, work);
>>   }
>>   
>> +/*
>> + * virtballoon_memory_failure - notified by memory failure, try to fix the
>> + *                              corrupted page.
>> + * The memory failure notifier is designed to call back when the kernel handled
>> + * successfully only, WARN_ON_ONCE on the unlikely condition to find out any
>> + * error(memory error handling is a best effort, not 100% coverd).
>> + */
>> +static int virtballoon_memory_failure(struct notifier_block *notifier,
>> +				      unsigned long pfn, void *parm)
>> +{
>> +	struct virtio_balloon *vb = container_of(notifier, struct virtio_balloon,
>> +						 memory_failure_nb);
>> +	struct page *page;
>> +	struct __virtio_balloon_recover *out_vbr;
>> +	struct scatterlist sg;
>> +	unsigned long flags;
>> +	int err;
>> +
>> +	page = pfn_to_online_page(pfn);
>> +	if (WARN_ON_ONCE(!page))
>> +		return NOTIFY_DONE;
>> +
>> +	if (PageHuge(page))
>> +		return NOTIFY_DONE;
>> +
>> +	if (WARN_ON_ONCE(!PageHWPoison(page)))
>> +		return NOTIFY_DONE;
>> +
>> +	if (WARN_ON_ONCE(page_count(page) != 1))
>> +		return NOTIFY_DONE;
>> +
>> +	get_page(page); /* balloon reference */
>> +
>> +	out_vbr = kzalloc(sizeof(*out_vbr), GFP_KERNEL);
>> +	if (WARN_ON_ONCE(!out_vbr))
>> +		return NOTIFY_BAD;
> 
> Not that it truly matters, but won't failure at this point leak the poisoned page?

I'll fix this, thanks!

-- 
zhenwei pi
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
