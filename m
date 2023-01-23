Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55757C25B50
	for <virtualization@archiver.kernel.org>; Mon, 23 Jan 2023 09:59:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D5C1C41511;
	Mon, 23 Jan 2023 09:59:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D5C1C41511
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=dXXFZReh
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zDt9d94PjnaM; Mon, 23 Jan 2023 09:59:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 12272414A2;
	Mon, 23 Jan 2023 09:59:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 12272414A2
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D7B9EC0033;
	Mon, 23 Jan 2023 09:58:59 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1F9FEC002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 Jan 2023 09:58:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id DADF2414E0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 Jan 2023 09:58:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org DADF2414E0
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BoCafl-zWp8A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 Jan 2023 09:58:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C027D414A2
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C027D414A2
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 Jan 2023 09:58:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1674467935;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xqxVJDgcGhaPuWMeQPrfnb0idJyOysfRMbpPEBhyxTU=;
 b=dXXFZRehiBAb1KIy4L1+07ovrHRz88xAbTiayet4yU1BCsldyfUy/Bu/hJ3bdhmeSht6Cp
 ZPWMSR46ErZRcneUKOtewHpOiRv9KdSqFaMB746kol+uzHHiGyjc817F54EUdQPx3or9cU
 dPp+bhzTJlw4zr1NnFDYKGoTZB0B2mc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-620-9EHwwE1bMRyRBTZFNkh2Vg-1; Mon, 23 Jan 2023 04:58:52 -0500
X-MC-Unique: 9EHwwE1bMRyRBTZFNkh2Vg-1
Received: by mail-wm1-f72.google.com with SMTP id
 m7-20020a05600c4f4700b003d971a5e770so7251249wmq.3
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 Jan 2023 01:58:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:subject:organization:from
 :references:cc:to:content-language:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xqxVJDgcGhaPuWMeQPrfnb0idJyOysfRMbpPEBhyxTU=;
 b=0DOLdzPcO8q1+Gv+veduv5Sx5OJLq+KiQe4PTxVmc9wlCmoUvqlOlpbPIyRfI9b9Ax
 EquqgJX6sf3huZPh0THLlRiuM6VWyELpoxGILyZmeItSbWVm3jB70Lp1GvlJgzNcwK1Z
 HkffvnU9IEG0HN23BoGSw44jpl5iQ1WamgWGb5vxJCLd0cqWR5lZOvx7aR6UFWBCziWK
 a3uvEUzNuQCMi9hRf6KCcX10qYn8kJYWydCTGZMS0lTYr6wkbMo9bD7v8VI7h9u1qx8n
 hVK3nF2ZkCNl/trw1SFFwA6lGrGsdR4f6bF3vIOzqLkrVL3iUj3aEd8DuvlYq0TM/FXm
 KQ1Q==
X-Gm-Message-State: AFqh2koJQikppGyQMn5EJMhzVRAQmSQ2R6NDzbVd5PynAnEVGDh/KMM+
 GQK9cvA+aZji+atATE1qXpHZmoIWtpAQWICMi30EvyGStXxVFeIBE3IdG7pukw7awkzzIjkwowr
 6c6s+20UJYwGk1+JP6Zj1nsLX5RwsIlXaobGZ0JxTlg==
X-Received: by 2002:adf:f6cf:0:b0:2bc:858a:3def with SMTP id
 y15-20020adff6cf000000b002bc858a3defmr29393201wrp.5.1674467930996; 
 Mon, 23 Jan 2023 01:58:50 -0800 (PST)
X-Google-Smtp-Source: AMrXdXstu8PcgHyGx2MksVilHw4EWMLVNPr4EaFuPknof9TNabDZ9AHTOwZsX8ISDp5PVXt4YaBMkQ==
X-Received: by 2002:adf:f6cf:0:b0:2bc:858a:3def with SMTP id
 y15-20020adff6cf000000b002bc858a3defmr29393191wrp.5.1674467930702; 
 Mon, 23 Jan 2023 01:58:50 -0800 (PST)
Received: from ?IPV6:2003:cb:c704:1100:65a0:c03a:142a:f914?
 (p200300cbc704110065a0c03a142af914.dip0.t-ipconnect.de.
 [2003:cb:c704:1100:65a0:c03a:142a:f914])
 by smtp.gmail.com with ESMTPSA id
 l14-20020a5d526e000000b0028e55b44a99sm24225816wrc.17.2023.01.23.01.58.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Jan 2023 01:58:50 -0800 (PST)
Message-ID: <de3f1fd1-bcec-c6e5-e57a-b06674144c3b@redhat.com>
Date: Mon, 23 Jan 2023 10:58:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
To: Sudarshan Rajagopalan <quic_sudaraja@quicinc.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Suren Baghdasaryan
 <surenb@google.com>, Mike Rapoport <rppt@kernel.org>,
 Oscar Salvador <osalvador@suse.de>,
 Anshuman Khandual <anshuman.khandual@arm.com>, mark.rutland@arm.com,
 will@kernel.org, virtualization@lists.linux-foundation.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org
References: <072de3f4-6bd3-f9ce-024d-e469288fc46a@quicinc.com>
 <acd8d55c-8528-bb21-488e-e5999c3c4e4e@redhat.com>
 <2faf67fe-b1df-d110-6d57-67f284cd5584@quicinc.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [RFC] memory pressure detection in VMs using PSI mechanism for
 dynamically inflating/deflating VM memory
In-Reply-To: <2faf67fe-b1df-d110-6d57-67f284cd5584@quicinc.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: "Sukadev Bhattiprolu \(QUIC\)" <quic_sukadev@quicinc.com>,
 "Srivatsa Vaddagiri \(QUIC\)" <quic_svaddagi@quicinc.com>,
 "Patrick Daly \(QUIC\)" <quic_pdaly@quicinc.com>,
 "Trilok Soni \(QUIC\)" <quic_tsoni@quicinc.com>
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

>>>
>>> 1. This will be a native userspace daemon that will be running only in
>>> the Linux VM which will use virtio-mem driver that uses memory hotplug
>>> to add/remove memory. The VM (aka Secondary VM, SVM) will request for
>>> memory from the host which is Primary VM, PVM via the backend hypervisor
>>> which takes care of cross-VM communication.
>>>
>>> 2. This will be guest driver. This daemon will use PSI mechanism to
>>> monitor memory pressure to keep track of memory demands in the system.
>>> It will register to few memory pressure events and make an educated
>>> guess on when demand for memory in system is increasing.
>>
>> Is that running in the primary or the secondary VM?
> 
> The userspace PSI daemon will be running on secondary VM. It will talk
> to a kernel driver (running on secondary VM itself) via ioctl. This
> kernel driver will talk to slightly modified version of virtio-mem
> driver where it can call the virtio_mem_config_changed(virtiomem_device)
> function for resizing the secondary VM. So its mainly "guest driven" now.

Okay, thanks.

[...]

>>>
>>> This daemon is currently in just Beta stage now and we have basic
>>> functionality running. We are yet to add more flesh to this scheme to
>>
>> Good to hear that the basics are running with virtio-mem (I assume :) ).
>>
>>> make sure any potential risks or security concerns are taken care as
>>> well.
>>
>> It would be great to draw/explain the architecture in more detail.
> 
> We will be looking into solving any potential security concerns where
> hypervisor would restrict few actions of resizing of memory. Right now,
> we are experimenting to see if PSI mechanism itself can be used for ways
> of detecting memory pressure in the system and add memory to secondary
> VM when memory is in need. Taking into account all the latencies
> involved in the PSI scheme (i.e. time when one does malloc call till
> when extra memory gets added to SVM system). And wanted to know
> upstream's opinion on such a scheme using PSI mechanism for detecting
> memory pressure and resizing SVM accordingly.

One problematic thing is that adding memory to Linux by virtio-mem 
eventually consumes memory (e.g., the memmap), especially when having to 
to add a completely new memory block to Linux.

So if you're already under severe memory pressure, these allocations to 
bring up new memory can fail. The question is, if PSI can notify "early" 
enough such that this barely happens in practice.

There are some possible ways to mitigate:

1) Always keep spare memory blocks by virtio-mem added to Linux, that
    don't expose any memory yet. Memory from these block can be handed
    over to Linux without additional Linux allocations. Of course, they
    consume metadata, so one might want to limit them.

2) Implement memmap_on_memory support for virtio-mem. This might help in
    some setups, where the device block size is suitable.

Did you run into that scenario already during your experiments, and how 
did you deal with that?

-- 
Thanks,

David / dhildenb

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
