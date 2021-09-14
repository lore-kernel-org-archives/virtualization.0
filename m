Return-Path: <SRS0=LSNt=OE=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB5CAC433F5
	for <virtualization@archiver.kernel.org>; Tue, 14 Sep 2021 09:45:35 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BA2661108
	for <virtualization@archiver.kernel.org>; Tue, 14 Sep 2021 09:45:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9BA2661108
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5805B6081D;
	Tue, 14 Sep 2021 09:45:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ve1K3M4Ff0cn; Tue, 14 Sep 2021 09:45:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id E6F0B6060C;
	Tue, 14 Sep 2021 09:45:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CD842C0011;
	Tue, 14 Sep 2021 09:45:33 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1FE7EC000D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Sep 2021 09:45:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id F20A24033D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Sep 2021 09:45:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OgEBvANDSVq9
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Sep 2021 09:45:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9092B4032F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Sep 2021 09:45:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1631612729;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=E5LbE6tJqoUXws78/lpKd/8E8fVAHtF02Bi+7E0E5fs=;
 b=VfAU49d5BGQE41zBt+oMgrVKmS9tGl9Hje9XRIizSfXNGeanpmkLRdpvB+g+1y1OCVXEmM
 LHaKZwB6v/OmBDyr0OfwJiZha6c4IbR3YRogOel613Zks3Sj+hKxsY/UW83AJuUxsmcoKq
 /YyPoaGJOsizp5srZO9qx1isjJTplMk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-559-djjld0Q7MeSrQJ-k89N0yA-1; Tue, 14 Sep 2021 05:45:28 -0400
X-MC-Unique: djjld0Q7MeSrQJ-k89N0yA-1
Received: by mail-wm1-f70.google.com with SMTP id
 k29-20020a05600c1c9d00b00304e40495b2so480510wms.9
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Sep 2021 02:45:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:organization
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=E5LbE6tJqoUXws78/lpKd/8E8fVAHtF02Bi+7E0E5fs=;
 b=wGyBxu2azkrwMGyU4pSqE8hnrSnhHtpSR1j9ib59bpsbpna+TKWKe0kPDYQ1GOIyN9
 HX7yKJllcdWSC6UD/yHkITZNOJN0ZFzZfc/jHUjwcNXgFSzqItRlV5s+wFwOSLGlfmlh
 zbSKXUQQR+SyPsKJwvSqV/gNlsS2Wj+2q5nBlQ4va2YvFy0eVSv3fXpwK2SqSrsrsTWp
 OT3tjTv2UAby+QqX5/x0IC55xevCIb0QUf/v2f6gg2l/0KTdcfuIKzbIdbwDX256g8DL
 icTLNARrCvQjxqtLmNKkuI3F0+anpZPi6kZ9+l9WPkfXnqIJdNtKro8m+6MDnb4prCns
 XHdw==
X-Gm-Message-State: AOAM5330ec7Bdf6GPeH2fnPDjPPhRK8lesxIxbI/kRBMqW6XzI5fm3kQ
 ryJIb8XDMo7IiFc2iuuS2Q+zNghZ4qCnPCoYNyf8XWOM/+yMzQ8nGxjajlv14A+YY28Xt+TZcb1
 psZhj2VXJ/f7GQTC26cI7ZerfUZ6w7IudtPWKHxEEVg==
X-Received: by 2002:adf:9bdb:: with SMTP id e27mr17402906wrc.162.1631612727182; 
 Tue, 14 Sep 2021 02:45:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy8IcKWrpo+CJ7yCXWiJlrYgqbtEzRpSOIG2NkaYA3QbTjmbDrA7ukm1vPG4+wVUH0DoQ1dzw==
X-Received: by 2002:adf:9bdb:: with SMTP id e27mr17402881wrc.162.1631612726956; 
 Tue, 14 Sep 2021 02:45:26 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c6041.dip0.t-ipconnect.de. [91.12.96.65])
 by smtp.gmail.com with ESMTPSA id
 f5sm591405wmb.47.2021.09.14.02.45.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Sep 2021 02:45:26 -0700 (PDT)
Subject: Re: [PATCH v4 3/3] virtio-mem: disallow mapping virtio-mem memory via
 /dev/mem
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20210902160919.25683-1-david@redhat.com>
 <20210902160919.25683-4-david@redhat.com>
 <20210903025630-mutt-send-email-mst@kernel.org>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <e5344ed1-6aaf-9e0a-a32d-f7cf69fe5a34@redhat.com>
Date: Tue, 14 Sep 2021 11:45:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210903025630-mutt-send-email-mst@kernel.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=david@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
 Andy Shevchenko <andy.shevchenko@gmail.com>, Hanjun Guo <guohanjun@huawei.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Dan Williams <dan.j.williams@intel.com>
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

On 03.09.21 09:02, Michael S. Tsirkin wrote:
> On Thu, Sep 02, 2021 at 06:09:19PM +0200, David Hildenbrand wrote:
>> We don't want user space to be able to map virtio-mem device memory
>> directly (e.g., via /dev/mem) in order to have guarantees that in a sane
>> setup we'll never accidentially access unplugged memory within the
>> device-managed region of a virtio-mem device, just as required by the
>> virtio-spec.
>>
>> As soon as the virtio-mem driver is loaded, the device region is visible
>> in /proc/iomem via the parent device region. From that point on user space
>> is aware of the device region and we want to disallow mapping anything
>> inside that region (where we will dynamically (un)plug memory) until
>> the driver has been unloaded cleanly and e.g., another driver might take
>> over.
>>
>> By creating our parent IORESOURCE_SYSTEM_RAM resource with
>> IORESOURCE_EXCLUSIVE, we will disallow any /dev/mem access to our
>> device region until the driver was unloaded cleanly and removed the
>> parent region. This will work even though only some memory blocks are
>> actually currently added to Linux and appear as busy in the resource tree.
>>
>> So access to the region from user space is only possible
>> a) if we don't load the virtio-mem driver.
>> b) after unloading the virtio-mem driver cleanly.
>>
>> Don't build virtio-mem if access to /dev/mem cannot be restricticted --
>> if we have CONFIG_DEVMEM=y but CONFIG_STRICT_DEVMEM is not set.
>>
>> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
> 
> 
>> ---
>>   drivers/virtio/Kconfig      | 1 +
>>   drivers/virtio/virtio_mem.c | 4 +++-
>>   2 files changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/virtio/Kconfig b/drivers/virtio/Kconfig
>> index ce1b3f6ec325..ff80cd03f1d1 100644
>> --- a/drivers/virtio/Kconfig
>> +++ b/drivers/virtio/Kconfig
>> @@ -101,6 +101,7 @@ config VIRTIO_MEM
>>   	depends on MEMORY_HOTPLUG_SPARSE
>>   	depends on MEMORY_HOTREMOVE
>>   	depends on CONTIG_ALLOC
>> +	depends on !DEVMEM || STRICT_DEVMEM
>>   	help
>>   	 This driver provides access to virtio-mem paravirtualized memory
>>   	 devices, allowing to hotplug and hotunplug memory.
> 
> It would be nicer if there was a symbol in the MEMORY_ namespace
> we can depend on exported by mm and depending on !DEVMEM ||
> STRICT_DEVMEM.
> 
> E.g.
> 
> config MEMORY_EXCLUSIVE
>          def_bool y
>          depends on !DEVMEM || STRICT_DEVMEM
> 
> and then in virtio
> 	depends on MEMORY_EXCLUSIVE
> 
> 

Yes, but I'm not able to come up with an expressive name. 
MEMORY_EXCLUSIVE can be highly misleading ...


> the virtio change itself is ok though:
> 
> Acked-by: Michael S. Tsirkin <mst@redhat.com>

Thanks!


-- 
Thanks,

David / dhildenb

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
