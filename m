Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B72FC433FE
	for <virtualization@archiver.kernel.org>; Tue, 11 Oct 2022 09:23:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id CA2C440B78;
	Tue, 11 Oct 2022 09:23:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org CA2C440B78
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WMZ4JKOC
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eURHb8bRzgHE; Tue, 11 Oct 2022 09:23:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 5430A4017B;
	Tue, 11 Oct 2022 09:23:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5430A4017B
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 357B7C0033;
	Tue, 11 Oct 2022 09:23:12 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8AAEBC002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Oct 2022 09:23:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 580F740B5A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Oct 2022 09:23:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 580F740B5A
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0ZcCSA_nOpPZ
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Oct 2022 09:23:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 99F944017B
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 99F944017B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Oct 2022 09:23:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1665480189;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7I7VQ6hVchBULwDy9Ro8vnqtPorb7QB9wWs0IPouq+c=;
 b=WMZ4JKOCQHRYY3Od1kbz48SYIsQTvtaZItTcw0JTp5Yjp6W1rfMn0WD6J6jQokkbpEjDG0
 582P6h2SsgqmOlX2YXaoLZ+MKISU0ZhtDS0wDtE7P5ZxrIdy+R7Y7PnRDF2a3j0gIbNjUB
 2wuoav5WL5modBFF4OfstuM9XpaWwAI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-140-LfIugWqfMEeA7n89BEAXJA-1; Tue, 11 Oct 2022 05:23:08 -0400
X-MC-Unique: LfIugWqfMEeA7n89BEAXJA-1
Received: by mail-wm1-f69.google.com with SMTP id
 l1-20020a7bc341000000b003bfe1273d6cso3542971wmj.4
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Oct 2022 02:23:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7I7VQ6hVchBULwDy9Ro8vnqtPorb7QB9wWs0IPouq+c=;
 b=aJx+SLB0nuLAE+EBjfyZkHiNP29mL+zHt56kHuH/dk0ZubseP9uPhz6OJNeu9/25h/
 aDjC9N+NBMJeiAn9bsL2s3H14kW6wAboku3OUTTii7U8OsKiNkBYO9Ob+oa2/g3iw4mp
 j403/BJTA/i5MxxIQDymdbSlik0m4811wPd5eRFxpSQooXpnjEPBcBEd1qqgY6ipZYmO
 2RuikdTjmsF1R8ZbkHP6Io6o0ooWrjxQH6ZYo0Le+TgXFADHKxcVatWANtwDR4if8u8d
 r2lgpV6FPNg1zRAQnRwrv07rrfyVIY7vfdqhSlYjvOaFqV6rNOyIiQomRflHvPMIBrrW
 tMNQ==
X-Gm-Message-State: ACrzQf3eQAzelo/J8qbCnZXyV7Biqyx7CbrxJOQQTz5pEgapSeY0bi0z
 UKzNE7tQ7Rg+2DmWry4XineWx4ng4vtuH3985ErBzthqcZJOfBhZbiSYW8+oHYdCRDWw0jHjHE3
 N8/9kW2h235Mb3xTIW6ntbRCvw1AvxgZiOve9S6radw==
X-Received: by 2002:a05:6000:1d94:b0:22e:34ef:b07f with SMTP id
 bk20-20020a0560001d9400b0022e34efb07fmr14488958wrb.272.1665480187117; 
 Tue, 11 Oct 2022 02:23:07 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5/v0oDIPLg4t3JtaZmER6DstrkRy6lzlCDSJhQvysmjbbliEW55qmefKyCt2f67xZNCfvhGA==
X-Received: by 2002:a05:6000:1d94:b0:22e:34ef:b07f with SMTP id
 bk20-20020a0560001d9400b0022e34efb07fmr14488943wrb.272.1665480186841; 
 Tue, 11 Oct 2022 02:23:06 -0700 (PDT)
Received: from ?IPV6:2003:cb:c709:6900:f110:6527:aa46:a922?
 (p200300cbc7096900f1106527aa46a922.dip0.t-ipconnect.de.
 [2003:cb:c709:6900:f110:6527:aa46:a922])
 by smtp.gmail.com with ESMTPSA id
 z17-20020a1c4c11000000b003b7b36dcb8dsm17149070wmf.31.2022.10.11.02.23.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Oct 2022 02:23:06 -0700 (PDT)
Message-ID: <063efd58-8373-90ea-7c5e-9d0e9161d2ba@redhat.com>
Date: Tue, 11 Oct 2022 11:23:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: RFC [PATCH v4 2/7] Enable balloon drivers to report inflated
 memory
To: Alexander Atanasov <alexander.atanasov@virtuozzo.com>,
 Nadav Amit <nadav.amit@gmail.com>
References: <20221005090158.2801592-1-alexander.atanasov@virtuozzo.com>
 <20221005090158.2801592-3-alexander.atanasov@virtuozzo.com>
 <88EDC41D-408F-4ADF-A933-0A6F36E5F262@gmail.com>
 <a8ce5c48-3efc-5ea3-6f5c-53b9e33f65c7@virtuozzo.com>
 <42C75E59-696B-41D5-BD77-68EFF0B075C6@gmail.com>
 <d55338c4-d15f-14ec-c057-806a5d5aa618@virtuozzo.com>
 <71E14334-CA3B-45FB-A854-7A8D6649C798@gmail.com>
 <b7dd38ba-9ff9-6b4c-2460-d4b1ee3bb3f0@virtuozzo.com>
 <1118F098-972A-4F58-8EE1-270A06E4F9D1@gmail.com>
 <7ba328e5-3bc8-cb22-f00c-eddb8aea9a06@virtuozzo.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <7ba328e5-3bc8-cb22-f00c-eddb8aea9a06@virtuozzo.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: "Michael S. Tsirkin" <mst@redhat.com>, LKML <linux-kernel@vger.kernel.org>,
 Linux Virtualization <virtualization@lists.linux-foundation.org>,
 Linux MM <linux-mm@kvack.org>, kernel@openvz.org,
 Andrew Morton <akpm@linux-foundation.org>
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

>>>> Sounds to me that all you want is some notifier to be called from
>>>> adjust_managed_page_count(). What am I missing?
>>>
>>> Notifier will act as an accumulator to report size of change and it will make things easier for the drivers and users wrt locking.
>>> Notifier is similar to the memory hotplug notifier.
>>
>> Overall, I am not convinced that there is any value of separating the value
>> and the notifier. You can batch both or not batch both. In addition, as I
>> mentioned, having two values seems racy.
> 
> I have identified two users so far above - may be more to come.
> One type needs the value to adjust. Also having the value is necessary
> to report it to users and oom. There are options with callbacks and so
> on but it will complicate things with no real gain. You are right about
> the atomicity but i guess if that's a problem for some user it could
> find a way to ensure it. i am yet to find such place.
> 

I haven't followed the whole discussion, but I just wanted to raise that 
having a generic mechanism to notify on such changes could be valuable.

For example, virtio-mem also uses adjust_managed_page_count() and might 
sometimes not trigger memory hotplug notifiers when adding more memory 
(essentially, when it fake-adds memory part of an already added Linux 
memory block).

What might make sense is schedule some kind of deferred notification on 
adjust_managed_page_count() changes. This way, we could notify without 
caring about locking and would naturally batch notifications.

adjust_managed_page_count() users would not require changes.

-- 
Thanks,

David / dhildenb

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
