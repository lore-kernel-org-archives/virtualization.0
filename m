Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C727C4332F
	for <virtualization@archiver.kernel.org>; Fri, 14 Oct 2022 13:01:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9B27B8412F;
	Fri, 14 Oct 2022 13:01:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9B27B8412F
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=gJDgn0Oq
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pPzrqAWXfjeb; Fri, 14 Oct 2022 13:01:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 152CB840C7;
	Fri, 14 Oct 2022 13:01:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 152CB840C7
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D86A3C0032;
	Fri, 14 Oct 2022 13:01:17 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C38A7C002D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Oct 2022 13:01:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 943A76F95F
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Oct 2022 13:01:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 943A76F95F
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=gJDgn0Oq
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NT4Om3Ts84N6
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Oct 2022 13:01:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B5E436FA01
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B5E436FA01
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Oct 2022 13:01:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1665752473;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SaldHj1fWL0JB8uDShPZGUz9Hou91o0Rg4EAQ11LSaw=;
 b=gJDgn0OqF0/I9/ibpHSHmJLiL6bnnR4s8yU3HAZ3cPocchRukfIOzMnkt1ZJ94F2AhEa8z
 TMUpsOAhAKOnXfWZ2JMtihxrtdn1ZnB8K1tiz4HbvV1esbTH9IIx7QS/CyJxafJ+o8DIsi
 TS7cEKXpCvLClidg5cxTBwGtC8DGKbQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-634-XqR3iJ_hNVSED85CrJggAA-1; Fri, 14 Oct 2022 09:01:12 -0400
X-MC-Unique: XqR3iJ_hNVSED85CrJggAA-1
Received: by mail-wr1-f70.google.com with SMTP id
 s30-20020adfa29e000000b002302b9671feso1957412wra.20
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Oct 2022 06:01:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SaldHj1fWL0JB8uDShPZGUz9Hou91o0Rg4EAQ11LSaw=;
 b=hTQQpHyBxhsvMPdLNwXwPrTgIjPBMj+LFv0CXAnbsbNUIBIdzd/b5TDPbwOAXjo4Ko
 9A5qCjgJXWLCX8A2zplQPehmo7AD4e8mbjr/IJaK+EtLXv3AjIGEo41uxQ6X0GjhFg0d
 NcJ/+R29D8dQks5MyOJl7qDfOPTF9axNjGexqXKV8AkcKev/jR0dVTuCyKvfDLXlhD88
 WhpcYM/SG+ienY0BKg7KtZgz/3sVXtY6ByzWtiAM/phuNVwKk+BqZN3Lk1ivPdJJwwxH
 AdjlK5ccAZICWvM7cP+1MZ30jVnH6f0dAWDaN+doSE15vhu6plnURBLcI4QPfB1Y7niK
 5G7A==
X-Gm-Message-State: ACrzQf11G2TAzZiRq1o2w19zzIxkqhc12qk5EMaiTwqFBH3FKY3u3CVC
 V+IN4do0aUvnmqsI1YGzCBlplimkf6+QFLatThTlzypiOOMGNzZSZVCNyPM4qBj0vhMfswlRryO
 5K0tB232LxQIK2KvuqMUpn+4Ho1aIklutpxL8XNdR5w==
X-Received: by 2002:a5d:47c5:0:b0:22e:6941:81eb with SMTP id
 o5-20020a5d47c5000000b0022e694181ebmr3293010wrc.408.1665752470735; 
 Fri, 14 Oct 2022 06:01:10 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM64LAt/bXBlG7HpFfz2D7sSRGhelA92JwzG3QdzpfXGbbOKe2ptF7MkqUTL6DhtBxrsuST3Eg==
X-Received: by 2002:a5d:47c5:0:b0:22e:6941:81eb with SMTP id
 o5-20020a5d47c5000000b0022e694181ebmr3292947wrc.408.1665752470102; 
 Fri, 14 Oct 2022 06:01:10 -0700 (PDT)
Received: from ?IPV6:2003:cb:c704:8f00:9219:ab4c:826e:9646?
 (p200300cbc7048f009219ab4c826e9646.dip0.t-ipconnect.de.
 [2003:cb:c704:8f00:9219:ab4c:826e:9646])
 by smtp.gmail.com with ESMTPSA id
 l15-20020a05600c4f0f00b003c6cc57566fsm6123016wmq.14.2022.10.14.06.01.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 14 Oct 2022 06:01:09 -0700 (PDT)
Message-ID: <72e535ce-80eb-a02f-970c-6a9c80da0a24@redhat.com>
Date: Fri, 14 Oct 2022 15:01:08 +0200
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
 <063efd58-8373-90ea-7c5e-9d0e9161d2ba@redhat.com>
 <04e5a2e4-052d-0f80-d642-4e104307f38b@virtuozzo.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <04e5a2e4-052d-0f80-d642-4e104307f38b@virtuozzo.com>
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

On 14.10.22 14:50, Alexander Atanasov wrote:
> Hello,
> 
> On 11.10.22 12:23, David Hildenbrand wrote:
>>>>>> Sounds to me that all you want is some notifier to be called from
>>>>>> adjust_managed_page_count(). What am I missing?
>>>>>
>>>>> Notifier will act as an accumulator to report size of change and it
>>>>> will make things easier for the drivers and users wrt locking.
>>>>> Notifier is similar to the memory hotplug notifier.
>>>>
>>>> Overall, I am not convinced that there is any value of separating the
>>>> value
>>>> and the notifier. You can batch both or not batch both. In addition,
>>>> as I
>>>> mentioned, having two values seems racy.
>>>
>>> I have identified two users so far above - may be more to come.
>>> One type needs the value to adjust. Also having the value is necessary
>>> to report it to users and oom. There are options with callbacks and so
>>> on but it will complicate things with no real gain. You are right about
>>> the atomicity but i guess if that's a problem for some user it could
>>> find a way to ensure it. i am yet to find such place.
>>>
>>
>> I haven't followed the whole discussion, but I just wanted to raise that
>> having a generic mechanism to notify on such changes could be valuable.
>>
>> For example, virtio-mem also uses adjust_managed_page_count() and might
>> sometimes not trigger memory hotplug notifiers when adding more memory
>> (essentially, when it fake-adds memory part of an already added Linux
>> memory block).
>>
>> What might make sense is schedule some kind of deferred notification on
>> adjust_managed_page_count() changes. This way, we could notify without
>> caring about locking and would naturally batch notifications.
>>
>> adjust_managed_page_count() users would not require changes.
> 
> Making it deferred will bring issues for both the users of the
> adjust_managed_page_count and the receivers of the notification -
> locking as first. And it is hard to know when the adjustment will
> finish, some of the drivers wait and retry in blocks. It will bring
> complexity and it will not be possible to convert users in small steps.

What exactly is the issue about handling that deferred? Who needs an 
immediate, 100% precise notification?

Locking from a separate workqueue shouldn't be too hard, or what am i 
missing?

> 
> Other problem is that there are drivers that do not use
> adjust_managed_page_count().

Which ones? Do we care?

-- 
Thanks,

David / dhildenb

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
