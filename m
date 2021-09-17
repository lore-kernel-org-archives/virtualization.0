Return-Path: <SRS0=2Qdu=OH=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB11DC433EF
	for <virtualization@archiver.kernel.org>; Fri, 17 Sep 2021 12:57:18 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 615DC610C7
	for <virtualization@archiver.kernel.org>; Fri, 17 Sep 2021 12:57:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 615DC610C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1F1E660BA3;
	Fri, 17 Sep 2021 12:57:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xl_mXL3WEo7x; Fri, 17 Sep 2021 12:57:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id B481760B99;
	Fri, 17 Sep 2021 12:57:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 89798C0011;
	Fri, 17 Sep 2021 12:57:16 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6C486C000D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 17 Sep 2021 12:57:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4CD6B84056
 for <virtualization@lists.linux-foundation.org>;
 Fri, 17 Sep 2021 12:57:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gdLun3QQT4Ov
 for <virtualization@lists.linux-foundation.org>;
 Fri, 17 Sep 2021 12:57:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1B8DE84055
 for <virtualization@lists.linux-foundation.org>;
 Fri, 17 Sep 2021 12:57:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1631883432;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FQnPZA6xUWUP11i+Z9E31Kr1ejPTCYUzohp8nM2hvfY=;
 b=TunbnJZi24vG+kxJag5JTbvQm3qgq2oCe0dLmxg5YFgfMLkaHvLZhfvb99STne3BMCUOUd
 j5Ro6yhHs9W4GI1wdfrVRUTde+3p5aSaykmZEPeAjStGKvDVTXhljcG8xxysB9ePqt83Ce
 i2L5k0iQmRDomOyYwsxjLTF0PJudhBI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-453-RP07_ZasPSy008DnWC-H8g-1; Fri, 17 Sep 2021 08:57:06 -0400
X-MC-Unique: RP07_ZasPSy008DnWC-H8g-1
Received: by mail-wm1-f72.google.com with SMTP id
 y12-20020a1c7d0c000000b003077f64d75fso4594952wmc.7
 for <virtualization@lists.linux-foundation.org>;
 Fri, 17 Sep 2021 05:57:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=FQnPZA6xUWUP11i+Z9E31Kr1ejPTCYUzohp8nM2hvfY=;
 b=I9Heaxc1f11j9Ws0fhutZyvTdNA3XrAos9zuKZOuQcC40zemYP4err4F0Hr/TehArD
 buO57J+BkY5perTK/FysiaI8+cm3X2Xekyon9OW9mCRiy6KB3MnhT0uLya7FokOs0ipd
 35obK8c8osU9waNVZ1PNNit2Oh/YI7QvHLmW/0HK/C8gHkd3DJvAf0iGUbhXjIFipPY0
 27gJzGVxvT+tsGZAiCbst13tqab1l2lKNnJbqdRTPGnQFdcYmFzoqmnBiG35tn8hkPai
 1hrvfpaeVXNsWgIu2lO+WT+r26V417OUyQb9phF6sjMBGCFnC1JDL1bQNKcncg1CiGfB
 635A==
X-Gm-Message-State: AOAM533hUMuj4WtMV4YhMS60gkGfD0n1YodFZ2JfUxE14XwPzuXPOtB1
 S9Nk6iha+20yqssILYg0doPSIzPRakLE8safuc37jugHg0GpY0J7vtAwn4+v4Pq5WFpxfvoBQG4
 D2Nfbqql6dHtTc/BOO3BI60qha3ymH6TRuhWoDKlPEg==
X-Received: by 2002:adf:f545:: with SMTP id j5mr11989293wrp.9.1631883425088;
 Fri, 17 Sep 2021 05:57:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx5qrcLQ8dwEJuSoNizLqquRmA2rvY0kHdWId7HBCd4W3UfcMYVTAJ+OXviWhtHbTBxjh1EHw==
X-Received: by 2002:adf:f545:: with SMTP id j5mr11989261wrp.9.1631883424770;
 Fri, 17 Sep 2021 05:57:04 -0700 (PDT)
Received: from [192.168.100.42] ([82.142.14.254])
 by smtp.gmail.com with ESMTPSA id z12sm6581808wro.75.2021.09.17.05.57.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Sep 2021 05:57:04 -0700 (PDT)
Message-ID: <b3569868-f9fd-438e-2d18-984ff1689432@redhat.com>
Date: Fri, 17 Sep 2021 14:57:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: Use of uninitialized memory with CONFIG_HW_RANDOM_VIRTIO
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <CAG_fn=WwQ29akxY1Eq=N_=HCF3t7z+T2obh9aRVUDFy1FSA3-Q@mail.gmail.com>
 <20210819165742-mutt-send-email-mst@kernel.org>
 <d0d232ab-5222-5eef-60de-e8cc0f2a0791@redhat.com>
 <CAG_fn=Um3Up2VyGOC0ezJ51N8AWZfGcWz+98cvwpBrJkby3+NA@mail.gmail.com>
 <639bbb70-eca8-97c5-7faa-8563e594d67a@redhat.com>
 <CAG_fn=VGU5A+JDC9mqksLbHHjHEJ6RSB9Ce2WVF9ysAHd=RWKg@mail.gmail.com>
 <e4ecab9b-1d09-069f-1ef1-d8d5a3499826@redhat.com>
 <20210916185802-mutt-send-email-mst@kernel.org>
From: Laurent Vivier <lvivier@redhat.com>
In-Reply-To: <20210916185802-mutt-send-email-mst@kernel.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=lvivier@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: amit@kernel.org, rusty@rustcorp.com.au,
 virtualization@lists.linux-foundation.org,
 syzkaller <syzkaller@googlegroups.com>,
 Alexander Potapenko <glider@google.com>, akong@redhat.com,
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

On 17/09/2021 00:58, Michael S. Tsirkin wrote:
> On Thu, Sep 16, 2021 at 10:52:59AM +0200, Laurent Vivier wrote:
>> On 13/09/2021 10:25, Alexander Potapenko wrote:
>>> Hi Laurent,
>>>
>>> I took the latest kernel (5.15-rc1,
>>> 6880fa6c56601bb8ed59df6c30fd390cc5f6dd8f) and a slightly modified
>>> config from syzbot (see attached)
>>> The latter has a lot of unnecessary debug checks, but those should not
>>> affect the RNG.
>>>
>>> You then need to apply the following patch to the kernel:
>>>
>>> ====================================================
>>> diff --git a/drivers/char/hw_random/core.c b/drivers/char/hw_random/core.c
>>> index a3db27916256d..a4cba9f0ff8cb 100644
>>> --- a/drivers/char/hw_random/core.c
>>> +++ b/drivers/char/hw_random/core.c
>>> @@ -433,8 +433,11 @@ static int hwrng_fillfn(void *unused)
>>>                   if (IS_ERR(rng) || !rng)
>>>                           break;
>>>                   mutex_lock(&reading_mutex);
>>> +               memset(rng_fillbuf, 'A', rng_buffer_size());
>>> +               rng_fillbuf[rng_buffer_size()-1] = 0;
>>>                   rc = rng_get_data(rng, rng_fillbuf,
>>>                                     rng_buffer_size(), 1);
>>> +               pr_err("rng_fillbuf: %s\n", rng_fillbuf);
>>>                   mutex_unlock(&reading_mutex);
>>>                   put_rng(rng);
>>>                   if (rc <= 0) {
>>> ====================================================
>>>
>>> and run the kernel under QEMU.
>>>
>>> On my machine I'm seeing the following output:
>>>
>>> $ cat log | strings | grep rng_fillbuf
>>> [    4.901931][  T897] rng_fillbuf:
>>> AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
>>> [    4.903104][  T897] rng_fillbuf: >
>>> [    4.903641][  T897] rng_fillbuf:
>>> [    4.904846][  T897] rng_fillbuf: ?
>>> [    4.913442][  T897] rng_fillbuf: [
>>>
>>> , which denotes that the first call to rng_get_data() leaves
>>> rng_fillbuf uninitialized.
>>
>>
>> Thank you for the detailed steps.
>>
>> The problem happens because we mix two different buffers:
>> - in add_early_randomness() we provide rng_buffer but don't wait it is full (see [1])
>> - in hwrng_fillfn() we provide rng_fillbuf, and we wait data here, but we
>> received the signal from QEMU that there are data, but these data are in
>> rng_buffer while we expect them in rng_fillbuf.
>>
>> There are several ways to fix/workaround that:
>>
>> 1- ignore the read when wait=0 :
>>
>> diff --git a/drivers/char/hw_random/virtio-rng.c b/drivers/char/hw_random/virtio-rng.c
>> index a90001e02bf7..8466d76566fd 100644
>> --- a/drivers/char/hw_random/virtio-rng.c
>> +++ b/drivers/char/hw_random/virtio-rng.c
>> @@ -59,15 +59,15 @@ static int virtio_read(struct hwrng *rng, void *buf,
>> size_t size, bool wait)
>>          if (vi->hwrng_removed)
>>                  return -ENODEV;
>>
>> +       if (!wait)
>> +               return 0;
>> +
>>          if (!vi->busy) {
>>                  vi->busy = true;
>>                  reinit_completion(&vi->have_data);
>>                  register_buffer(vi, buf, size);
>>          }
>>
>> -       if (!wait)
>> -               return 0;
>> -
>>          ret = wait_for_completion_killable(&vi->have_data);
>>          if (ret < 0)
>>                  return ret;
>>
>>
>> 2- Use an internal intermediate buffer in virtio-rng, at a cost of a copy,
>>     I have some patches (somewhere) I can refresh to do that.
>>
>> 3- modify hw_random/core.c to use only one buffer
>>
>> Thanks,
>> Laurent
>>
>> [1] 78887832e765 ("hwrng: core - don't wait on add_early_randomness()")
> 
> 4. actually differentiate between the two
> using the pointer returned by get_buf.

Even if it can help I think we should avoid to keep mixing buffers.

For instance, if we submit a buffer with wait=0, the caller can re-use or release the 
memory while it is queued in the queue of the device.

Moreover, what to do if buffers differ?

Wait and use the data in the previous buffer (that can be corrupted by the submitter 
in-between)?

Or wait and drop, and wait again with the new buffer?

BTW, I found my patches that introduce an internal buffer in virtio-rng (solution 2):

https://github.com/vivier/linux/commits/virtio-rng

Thanks,
Laurent

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
