Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D74A4C433F5
	for <virtualization@archiver.kernel.org>; Fri,  6 May 2022 16:28:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 81DE860D57;
	Fri,  6 May 2022 16:28:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nChvTBdBeZbs; Fri,  6 May 2022 16:28:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 5EDD360C22;
	Fri,  6 May 2022 16:28:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2FFA5C0032;
	Fri,  6 May 2022 16:28:30 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0D53FC002D
 for <virtualization@lists.linux-foundation.org>;
 Fri,  6 May 2022 16:28:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id DA4734041C
 for <virtualization@lists.linux-foundation.org>;
 Fri,  6 May 2022 16:28:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1TdjrcyCcqUS
 for <virtualization@lists.linux-foundation.org>;
 Fri,  6 May 2022 16:28:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 787F2400E9
 for <virtualization@lists.linux-foundation.org>;
 Fri,  6 May 2022 16:28:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1651854505;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Afy3LRmgbTX/W4kOJBv51V2x19c9yS1eYu85zuJRd9c=;
 b=KtvYQ30KEaae5NwHKDR2QOuRJJl/ypiGqvCLSk9s9E3UHJH3R0WP880tg2w+csROWYyo1Z
 qChTMosWLEVmoD1x4SnEC26eDTxQ5Z4dk85jpvhxpzjoXSAzKDFa5+KbqxzKkbOzFiYHGN
 tRpf/9BDJUhEB9NXWM+kC75Wdk7o3nM=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-659-IAZXROrTPRS8OwVVGgdKHg-1; Fri, 06 May 2022 12:28:25 -0400
X-MC-Unique: IAZXROrTPRS8OwVVGgdKHg-1
Received: by mail-qk1-f197.google.com with SMTP id
 c84-20020a379a57000000b0069fcf83c373so5242493qke.20
 for <virtualization@lists.linux-foundation.org>;
 Fri, 06 May 2022 09:28:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:organization:in-reply-to
 :content-transfer-encoding;
 bh=Afy3LRmgbTX/W4kOJBv51V2x19c9yS1eYu85zuJRd9c=;
 b=E6XeThPtiUmsmlGRN1VZdDhHDqFIc24Y2Cv1eonEYuWTO1X6+fEGAts/SKPvBWwWJT
 ixKlszfuX27Ldn4BIkpqokcAjU47rvZX/3ae1TK+ovpdYyurMn20cwaU0ivAf8Lv5yPM
 p8TIlYQQUQWa9PstVPTMYsK5oqN7n+CSy8P+1z78dW7csv7YjIdcnSqwX7z3A15Mws19
 y5yr2qq+LRcz/ynM12QK5E7gEiZMnmi/BE6JPOlmru9W3LCwFM4Wm8Ga/PBaRaorbFFp
 3H+EuJhfGwXL93RBzJ8NGjL+8YIJCjes2BAmywOUnEa/eonhn8YFTt4ZmISQz6KLkSTj
 ll8g==
X-Gm-Message-State: AOAM5311C3Guonft/4kEYeKfXGtcxKlICbRrzBD4Vm7v0wwHH0q1Z271
 sXDZV86hrNzOOUA+KT9e/5kUAFpN28X2l1AQqQ0hGJqD2V3F2YBPAniC+Q2sLZs8MPcpnCO4X91
 4hNi2b6RR8sNCXVY928uQPTVRFmhyA7uL2nKVj2wgxQ==
X-Received: by 2002:a05:620a:4405:b0:6a0:30b7:7d5b with SMTP id
 v5-20020a05620a440500b006a030b77d5bmr2843357qkp.482.1651854504318; 
 Fri, 06 May 2022 09:28:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy9mEOuQZwJEmFcxWadpmKCBaw0BWvAOMjoo5GmSP6daGuDLSFXPHz5F/LLg72a11CQ2+pb/A==
X-Received: by 2002:a05:620a:4405:b0:6a0:30b7:7d5b with SMTP id
 v5-20020a05620a440500b006a030b77d5bmr2843324qkp.482.1651854503954; 
 Fri, 06 May 2022 09:28:23 -0700 (PDT)
Received: from [10.23.153.165] ([46.248.132.196])
 by smtp.gmail.com with ESMTPSA id
 l1-20020ae9f001000000b0069fd35d2abcsm2638745qkg.112.2022.05.06.09.28.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 May 2022 09:28:23 -0700 (PDT)
Message-ID: <ac3fc5b9-d09c-5fb6-998d-f7c655d7fa00@redhat.com>
Date: Fri, 6 May 2022 18:28:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 3/4] mm/memofy-failure.c: optimize hwpoison_filter
To: zhenwei pi <pizhenwei@bytedance.com>,
 Naoya Horiguchi <naoya.horiguchi@linux.dev>
References: <20220429142206.294714-1-pizhenwei@bytedance.com>
 <20220429142206.294714-4-pizhenwei@bytedance.com>
 <20220506085920.GC1356094@u2004>
 <3c0e25fb-695d-4a29-6de4-c892f89cea7a@bytedance.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <3c0e25fb-695d-4a29-6de4-c892f89cea7a@bytedance.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=david@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: "Michael S. Tsirkin" <mst@redhat.com>, naoya.horiguchi@nec.com,
 linux-kernel@vger.kernel.org, "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>, linux-mm@kvack.org,
 akpm@linux-foundation.org, Wu Fengguang <fengguang.wu@intel.com>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On 06.05.22 15:38, zhenwei pi wrote:
> 
> 
> On 5/6/22 16:59, Naoya Horiguchi wrote:
>> On Fri, Apr 29, 2022 at 10:22:05PM +0800, zhenwei pi wrote:
>>> In the memory failure procedure, hwpoison_filter has higher priority,
>>> if memory_filter() filters the error event, there is no need to do
>>> the further work.
>>
>> Could you clarify what problem you are trying to solve (what does
>> "optimize" mean in this context or what is the benefit)?
>>
> 
> OK. The background of this work:
> As well known, the memory failure mechanism handles memory corrupted 
> event, and try to send SIGBUS to the user process which uses this 
> corrupted page.
> 
> For the virtualization case, QEMU catches SIGBUS and tries to inject MCE 
> into the guest, and the guest handles memory failure again. Thus the 
> guest gets the minimal effect from hardware memory corruption.
> 
> The further step I'm working on:
> 1, try to modify code to decrease poisoned pages in a single place 
> (mm/memofy-failure.c: simplify num_poisoned_pages_dec in this series).
> 
> 2, try to use page_handle_poison() to handle SetPageHWPoison() and 
> num_poisoned_pages_inc() together. It would be best to call 
> num_poisoned_pages_inc() in a single place too. I'm not sure if this is 
> possible or not, please correct me if I misunderstand.
> 
> 3, introduce memory failure notifier list in memory-failure.c: notify 
> the corrupted PFN to someone who registers this list.
> If I can complete [1] and [2] part, [3] will be quite easy(just call 
> notifier list after increasing poisoned page).
> 
> 4, introduce memory recover VQ for memory balloon device, and registers 
> memory failure notifier list. During the guest kernel handles memory 
> failure, balloon device gets notified by memory failure notifier list, 
> and tells the host to recover the corrupted PFN(GPA) by the new VQ.

Most probably you might want to do that asynchronously, and once the
callback succeeds, un-poison the page.

> 
> 5, host side remaps the corrupted page(HVA), and tells the guest side to 
> unpoison the PFN(GPA). Then the guest fixes the corrupted page(GPA) 
> dynamically.

I think QEMU already does that during reboots. Now it would be triggered
by the guest for individual pages.

> 
> Because [4] and [5] are related to balloon device, also CC Michael, 
> David and Jason.

Doesn't sound too crazy for me, although it's a shame that we always
have to use virtio-balloon for such fairly balloon-unrelated things.

-- 
Thanks,

David / dhildenb

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
