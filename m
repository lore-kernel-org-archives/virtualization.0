Return-Path: <SRS0=LBOH=OZ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1A8CC433FE
	for <virtualization@archiver.kernel.org>; Tue,  5 Oct 2021 13:30:57 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81E30619E1
	for <virtualization@archiver.kernel.org>; Tue,  5 Oct 2021 13:30:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 81E30619E1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 43E7F60B38;
	Tue,  5 Oct 2021 13:30:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ax2WYrovr6zS; Tue,  5 Oct 2021 13:30:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id B9EE560778;
	Tue,  5 Oct 2021 13:30:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 916A4C000F;
	Tue,  5 Oct 2021 13:30:55 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A1924C000D
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Oct 2021 13:30:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7EB9F404A8
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Oct 2021 13:30:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id U7DVPjnchNgg
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Oct 2021 13:30:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3FBB540165
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Oct 2021 13:30:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1633440652;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=n1i8Euern9P25K11N8MWPbpda+LgMAsFjt0OleN5ka4=;
 b=OgcRnWCVf1b4BaQJizo06sHQTUJjf/KZQ4tqDUmD0eiCkwwnv5OKBwB1Vu3X8URhDgHlk2
 s6OrY/BUmPCAWMNyoWYiVr8cRHeeGp43AR+UxqYNn3oVD+rqLE2qRhBC9lLa9YTNUcZsQF
 NUXRi1HclIZdosv6o6s5otnNpdpl268=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-324-V1b5cxJHNtygoUWAV_dO-A-1; Tue, 05 Oct 2021 09:30:51 -0400
X-MC-Unique: V1b5cxJHNtygoUWAV_dO-A-1
Received: by mail-wm1-f69.google.com with SMTP id
 x3-20020a05600c21c300b0030d2b0fb3b4so7608825wmj.5
 for <virtualization@lists.linux-foundation.org>;
 Tue, 05 Oct 2021 06:30:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=n1i8Euern9P25K11N8MWPbpda+LgMAsFjt0OleN5ka4=;
 b=iXynx6QX4cgM0NoJclXIuAktjbx95qq7wmFkgu1QG9jRwzFUQAq4cndpsC7coLc8NO
 P3BaUNCwOvG3WaSkQMvUL64OO7lxAg/72BboQvRdO8bUH2IvobjIJY9UJOj5uuViyRBI
 K5BlEvup2vD1mzLhL0bGRvxH79ZTTWmwimiYPBjmmZQssGZd6XNredLoOmDeNT/IgRp3
 oyBVUCVrL1EqHpTTtYrWnBc4Uib0XhjQ9YV3CaTLc4Ng33IOKFTytxnQX/siBEV2e7lU
 QLG+DcSweRCjuUES62Wh9+6iRZoP9J4Ko2fmdD1i3tdwkCC8gludeSPMJyjuAVsenXeU
 SdKA==
X-Gm-Message-State: AOAM531YDOCUoz2qtJdUx4yq7EvipiOITD7OGYjWjU354oqrNBdOEQdJ
 3pZuhi59QsjsNr+UykUELwnCjZHbvc15u35B/TJh9ihAEcB20wZqrBZoYxueqOsNacLVndAR843
 /9zqxacJnjyUwaYDEEVVJ/ZS9kxkcs/fOYBa8awY1rw==
X-Received: by 2002:adf:f94b:: with SMTP id q11mr21752287wrr.408.1633440649632; 
 Tue, 05 Oct 2021 06:30:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyOOs163cK4VZu3EocaK1ey7lkWDzdoDW8k0yZYvyozSF8o+cLe2SMVDBPk8+nISneLdVSrhQ==
X-Received: by 2002:adf:f94b:: with SMTP id q11mr21752251wrr.408.1633440649399; 
 Tue, 05 Oct 2021 06:30:49 -0700 (PDT)
Received: from [192.168.100.42] ([82.142.3.114])
 by smtp.gmail.com with ESMTPSA id z12sm17751793wrv.31.2021.10.05.06.30.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Oct 2021 06:30:48 -0700 (PDT)
Message-ID: <40a84813-afc4-049b-2713-8bdad9c4bc20@redhat.com>
Date: Tue, 5 Oct 2021 15:30:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH 1/4] hwrng: virtio - add an internal buffer
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20210922170903.577801-1-lvivier@redhat.com>
 <20210922170903.577801-2-lvivier@redhat.com>
 <20210922145651-mutt-send-email-mst@kernel.org>
 <0dd338bb-0fbe-b9d5-0962-d47ac2de4c4e@redhat.com>
 <20210923030026-mutt-send-email-mst@kernel.org>
 <fcd17df1-5aed-346b-e7cd-abe4dfb67e69@redhat.com>
 <20211005075433-mutt-send-email-mst@kernel.org>
From: Laurent Vivier <lvivier@redhat.com>
In-Reply-To: <20211005075433-mutt-send-email-mst@kernel.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=lvivier@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Herbert Xu <herbert@gondor.apana.org.au>, amit@kernel.org,
 rusty@rustcorp.com.au, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 Alexander Potapenko <glider@google.com>, linux-crypto@vger.kernel.org,
 Matt Mackall <mpm@selenic.com>, akong@redhat.com,
 Dmitriy Vyukov <dvyukov@google.com>
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

On 05/10/2021 13:55, Michael S. Tsirkin wrote:
> On Thu, Sep 23, 2021 at 09:34:18AM +0200, Laurent Vivier wrote:
>> On 23/09/2021 09:04, Michael S. Tsirkin wrote:
>>> On Thu, Sep 23, 2021 at 08:26:06AM +0200, Laurent Vivier wrote:
>>>> On 22/09/2021 21:02, Michael S. Tsirkin wrote:
>>>>> On Wed, Sep 22, 2021 at 07:09:00PM +0200, Laurent Vivier wrote:
>>>>>> hwrng core uses two buffers that can be mixed in the
>>>>>> virtio-rng queue.
>>>>>>
>>>>>> If the buffer is provided with wait=0 it is enqueued in the
>>>>>> virtio-rng queue but unused by the caller.
>>>>>> On the next call, core provides another buffer but the
>>>>>> first one is filled instead and the new one queued.
>>>>>> And the caller reads the data from the new one that is not
>>>>>> updated, and the data in the first one are lost.
>>>>>>
>>>>>> To avoid this mix, virtio-rng needs to use its own unique
>>>>>> internal buffer at a cost of a data copy to the caller buffer.
>>>>>>
>>>>>> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
>>>>>> ---
>>>>>>     drivers/char/hw_random/virtio-rng.c | 43 ++++++++++++++++++++++-------
>>>>>>     1 file changed, 33 insertions(+), 10 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/char/hw_random/virtio-rng.c b/drivers/char/hw_random/virtio-rng.c
>>>>>> index a90001e02bf7..208c547dcac1 100644
>>>>>> --- a/drivers/char/hw_random/virtio-rng.c
>>>>>> +++ b/drivers/char/hw_random/virtio-rng.c
>>>>>> @@ -18,13 +18,20 @@ static DEFINE_IDA(rng_index_ida);
>>>>>>     struct virtrng_info {
>>>>>>     	struct hwrng hwrng;
>>>>>>     	struct virtqueue *vq;
>>>>>> -	struct completion have_data;
>>>>>>     	char name[25];
>>>>>> -	unsigned int data_avail;
>>>>>>     	int index;
>>>>>>     	bool busy;
>>>>>>     	bool hwrng_register_done;
>>>>>>     	bool hwrng_removed;
>>>>>> +	/* data transfer */
>>>>>> +	struct completion have_data;
>>>>>> +	unsigned int data_avail;
>>>>>> +	/* minimal size returned by rng_buffer_size() */
>>>>>> +#if SMP_CACHE_BYTES < 32
>>>>>> +	u8 data[32];
>>>>>> +#else
>>>>>> +	u8 data[SMP_CACHE_BYTES];
>>>>>> +#endif
>>>>>
>>>>> Let's move this logic to a macro in hw_random.h ?
>>>>>
>>>>>>     };
>>>>>>     static void random_recv_done(struct virtqueue *vq)
>>>>>> @@ -39,14 +46,14 @@ static void random_recv_done(struct virtqueue *vq)
>>>>>>     }
>>>>>>     /* The host will fill any buffer we give it with sweet, sweet randomness. */
>>>>>> -static void register_buffer(struct virtrng_info *vi, u8 *buf, size_t size)
>>>>>> +static void register_buffer(struct virtrng_info *vi)
>>>>>>     {
>>>>>>     	struct scatterlist sg;
>>>>>> -	sg_init_one(&sg, buf, size);
>>>>>> +	sg_init_one(&sg, vi->data, sizeof(vi->data));
>>>>>
>>>>> Note that add_early_randomness requests less:
>>>>>            size_t size = min_t(size_t, 16, rng_buffer_size());
>>>>>
>>>>> maybe track how much was requested and grow up to sizeof(data)?
>>>>
>>>> I think this problem is managed by PATCH 3/4 as we reuse unused data of the buffer.
>>>
>>> the issue I'm pointing out is that we are requesting too much
>>> entropy from host - more than guest needs.
>>
>> Yes, guest asks for 16 bytes, but we request SMP_CACHE_BYTES (64 on x86_64),
>> and these 16 bytes are used with add_device_randomness(). With the following
>> patches, the remaining 48 bytes are used rapidly by hwgnd kthread or by the
>> next virtio_read.
>>
>> If there is no enough entropy the call is simply ignored as wait=0.
>>
>> At this patch level the call is always simply ignored (because wait=0) and
>> the data requested here are used by the next read that always asks for a
>> SMP_CACHE_BYTES bytes data size.
>>
>> Moreover in PATCH 4/4 we always have a pending request of size
>> SMP_CACHE_BYTES, so driver always asks a block of this size and the guest
>> takes what it needs.
>>
>> Originally I used a 16 bytes block but performance are divided by 4.
>>
>> Do you propose something else?
>>
>> Thanks,
>> Laurent
> 
> Maybe min(size, sizeof(vi->data))?
> 
But it means, in the case of mixed buffers, we will ask 16 bytes on the first call, not 
use it, and  ask SMP_CACHE_BYTES bytes on the next call to get only 16:

- add_early_randomness() asks for 16 bytes but wait = 0 and thus the request is queued but 
not used. add_early_randomness() is called when we switch from one hw_random backend to 
another (so generally only once...)

- hwrng_fillfn() and rng_dev_read() always ask rng_buffer_size() (max(32, SMP_CACHE_BYTES)).

So we can say we use SMP_CACHE_BYTES in 99% of the cases.

Moreover, this will be discarded by patch 3 and 4 as we have a loop to ask more data in a 
fixed size buffer.

I'm not sure it's worth introducing this change in this patch.

Thanks,
Laurent

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
