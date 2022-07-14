Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B36DC43334
	for <virtualization@archiver.kernel.org>; Thu, 14 Jul 2022 13:25:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B6EA2615BC;
	Thu, 14 Jul 2022 13:25:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B6EA2615BC
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=cB8ILY0R
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id a8OG-ELyWEMJ; Thu, 14 Jul 2022 13:25:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 2A473615C1;
	Thu, 14 Jul 2022 13:25:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2A473615C1
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id ED1A1C0035;
	Thu, 14 Jul 2022 13:25:00 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 18C66C0035
 for <virtualization@lists.linux-foundation.org>;
 Thu, 14 Jul 2022 13:25:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id EFAD884A18
 for <virtualization@lists.linux-foundation.org>;
 Thu, 14 Jul 2022 13:24:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org EFAD884A18
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=cB8ILY0R
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Y0ACaQxqymMC
 for <virtualization@lists.linux-foundation.org>;
 Thu, 14 Jul 2022 13:24:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2ED2A8498F
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2ED2A8498F
 for <virtualization@lists.linux-foundation.org>;
 Thu, 14 Jul 2022 13:24:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1657805091;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JFb6Y2djfjlq4aYtQeDVixTBGc4GMhc4NBOsa8B4jJM=;
 b=cB8ILY0RPqY8FwkQH9tI4zADd6vzUkpAhEZ23oozQZm247L7M9uRDbXUO8Ynx1r6lWrR2d
 kFM9vDEWISq5JFX0Vy4p2PuBW01J9ZCfZl0fUEaJl+jKAGJY1EqigxVWD7OHeA/QC+WUSU
 1V87MQz6ER65JBaFKr3xl0095+whRSU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-59-XdgKZmMlNKykiG2ucDqB8w-1; Thu, 14 Jul 2022 09:24:43 -0400
X-MC-Unique: XdgKZmMlNKykiG2ucDqB8w-1
Received: by mail-wm1-f71.google.com with SMTP id
 m20-20020a05600c4f5400b003a03aad6bdfso651110wmq.6
 for <virtualization@lists.linux-foundation.org>;
 Thu, 14 Jul 2022 06:24:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:organization:in-reply-to
 :content-transfer-encoding;
 bh=JFb6Y2djfjlq4aYtQeDVixTBGc4GMhc4NBOsa8B4jJM=;
 b=bN2X7XldYOXM10r2G+ZEH9EE8YARxopaHnqR07NXUans93lozGqjsRrKgYQpC0QPIe
 9I9/BwFeOaO6fO8hzlGgk8rQtzRFoUlwOMNf4D5U/JOHnE6wGgv+cMJqKw3e7Q9aYYJt
 /JZTMn0cbUfEj/Kodkqib33VDHE7NYC6Fz2/8IgamQyNu3k4URL/luZ4nym/aKanOY9f
 4QEh2aHDBW/NI7trhaGK+1JA0SjvJJOES7cqkRX5rWfefWxeBsaKCNWWN97QJceS4cfF
 ThHIvzVCcm2PmOuck7P4AVmKODpdpOB0Ylkia9PZD/SzLIEEfi3Csa+tCvyTG+WiHeab
 XBzw==
X-Gm-Message-State: AJIora9fVXJ5oyreKkpE6K6ckQ+NQOl49XX2I4aJpE+yZixRdaGap0so
 r1Eg4i+sfuPnadvYqDIaRiXxj64wwKlRQuXDGqCm9EyWmFIzYrxtI9WaeqPvWP6dSdOVztNuz4I
 Dk1Z/owM8elSkh8w8goo38KLEUvEbytKp0RbaMyl95g==
X-Received: by 2002:a05:6000:2cc:b0:21d:76d8:1f2c with SMTP id
 o12-20020a05600002cc00b0021d76d81f2cmr8158608wry.471.1657805082134; 
 Thu, 14 Jul 2022 06:24:42 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sXOdCJbsP6vWBuuwTfoqFW5KzG83L6mkk6KFoxTtE5rJXJnDpfvfDi52mje6Dx7tO8Ehze5A==
X-Received: by 2002:a05:6000:2cc:b0:21d:76d8:1f2c with SMTP id
 o12-20020a05600002cc00b0021d76d81f2cmr8158591wry.471.1657805081871; 
 Thu, 14 Jul 2022 06:24:41 -0700 (PDT)
Received: from ?IPV6:2003:cb:c709:3d00:dae4:4dc0:aa8c:bc1?
 (p200300cbc7093d00dae44dc0aa8c0bc1.dip0.t-ipconnect.de.
 [2003:cb:c709:3d00:dae4:4dc0:aa8c:bc1])
 by smtp.gmail.com with ESMTPSA id
 g20-20020a05600c4ed400b003a2cfb9f5basm6564857wmq.16.2022.07.14.06.24.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Jul 2022 06:24:41 -0700 (PDT)
Message-ID: <bfb7ab7f-6c17-e1fe-d87e-b19312f06e0c@redhat.com>
Date: Thu, 14 Jul 2022 15:24:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v4 1/1] Create debugfs file with virtio balloon usage
 information
To: Alexander Atanasov <alexander.atanasov@virtuozzo.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
References: <20220705083638.29669-1-alexander.atanasov@virtuozzo.com>
 <7fd5e645-3892-6e0d-de80-08728e29b150@redhat.com>
 <123b7518-b0c9-171c-9596-73654691ee58@virtuozzo.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <123b7518-b0c9-171c-9596-73654691ee58@virtuozzo.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=david@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: kernel@openvz.org, linux-kernel@vger.kernel.org,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On 14.07.22 15:20, Alexander Atanasov wrote:
> Hello,
> 
> On 14/07/2022 14:35, David Hildenbrand wrote:
>> On 05.07.22 10:36, Alexander Atanasov wrote:
>>> Allow the guest to know how much it is ballooned by the host.
>>> It is useful when debugging out of memory conditions.
>>>
>>> When host gets back memory from the guest it is accounted
>>> as used memory in the guest but the guest have no way to know
>>> how much it is actually ballooned.
>>>
>>> Signed-off-by: Alexander Atanasov <alexander.atanasov@virtuozzo.com>
>>> ---
>>>   drivers/virtio/virtio_balloon.c     | 77 +++++++++++++++++++++++++++++
>>>   include/uapi/linux/virtio_balloon.h |  1 +
>>>   2 files changed, 78 insertions(+)
>>>
>>> V2:
>>>   - fixed coding style
>>>   - removed pretty print
>>> V3:
>>>   - removed dublicate of features
>>>   - comment about balooned_pages more clear
>>>   - convert host pages to balloon pages
>>> V4:
>>>   - added a define for BALLOON_PAGE_SIZE to make things clear
>>>
>>> diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
>>> index b9737da6c4dd..dc4ad584b947 100644
>>> --- a/drivers/virtio/virtio_balloon.c
>>> +++ b/drivers/virtio/virtio_balloon.c
>>> @@ -10,6 +10,7 @@
>>>   #include <linux/virtio_balloon.h>
>>>   #include <linux/swap.h>
>>>   #include <linux/workqueue.h>
>>> +#include <linux/debugfs.h>
>>>   #include <linux/delay.h>
>>>   #include <linux/slab.h>
>>>   #include <linux/module.h>
>>> @@ -731,6 +732,77 @@ static void report_free_page_func(struct work_struct *work)
>>>   	}
>>>   }
>>>   
>>> +/*
>>> + * DEBUGFS Interface
>>> + */
>>> +#ifdef CONFIG_DEBUG_FS
>>> +
>>> +#define guest_to_balloon_pages(i) ((i)*VIRTIO_BALLOON_PAGES_PER_PAGE)
>>> +/**
>>> + * virtio_balloon_debug_show - shows statistics of balloon operations.
>>> + * @f: pointer to the &struct seq_file.
>>> + * @offset: ignored.
>>> + *
>>> + * Provides the statistics that can be accessed in virtio-balloon in the debugfs.
>>> + *
>>> + * Return: zero on success or an error code.
>>> + */
>>> +
>>> +static int virtio_balloon_debug_show(struct seq_file *f, void *offset)
>>> +{
>>> +	struct virtio_balloon *b = f->private;
>>> +	u32 num_pages;
>>> +	struct sysinfo i;
>>> +
>>> +	si_meminfo(&i);
>>> +
>>> +	seq_printf(f, "%-22s: %d\n", "page_size", VIRTIO_BALLOON_PAGE_SIZE);
>>> +
>>> +	virtio_cread_le(b->vdev, struct virtio_balloon_config, actual,
>>> +			&num_pages);
>>> +	/*
>>> +	 * Pages allocated by host from the guest memory.
>>> +	 * Host inflates the balloon to get more memory.
>>> +	 * Guest needs to deflate the balloon to get more memory.
>>> +	 */
>> Please drop that comment. This is basic virtio-balloon operation that
>> must not be explained at this point.
> 
> Ok
> 
>>> +	seq_printf(f, "%-22s: %u\n", "ballooned_pages", num_pages);
>>> +
>>> +	/* Total Memory for the guest from host */
>>> +	seq_printf(f, "%-22s: %lu\n", "total_pages",
>>> +			guest_to_balloon_pages(i.totalram));
>> totalram is calculated from totalram_pages().
>>
>> When we inflate/deflate, we adjust totalram as well via
>> adjust_managed_page_count().
> 
> That is true only when not using DEFLATE_ON_OOM.
> 
> Otherwise inflated memory is accounted as used and total ram stays the same.
>> Consequently, this doesn't calculate what you actually want?
>> Total memory would be totalram+inflated, current would be totalram.
> 
> My calculations are correct for the case deflate_on_oom is enabled.
> 

Which is the corner cases. You'd have to special case on DEFLATE_ON_OOM
availability.

>> But, TBH, only export num_pages. User space can just lookup the other
>> information (totalram) via /proc/meminfo.
> 
> I have missed that the memory accounting is made differently depending 
> on a flag.
> 
> Since the calculations are different i'd prefer to have the values 
> calculate and printed there.

What about an indication instead, whether or not inflated pages are
accounted into total or not? That would be slightly cleaner IMHO.

-- 
Thanks,

David / dhildenb

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
