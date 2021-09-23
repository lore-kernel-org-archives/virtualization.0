Return-Path: <SRS0=2rcL=ON=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F138FC433FE
	for <virtualization@archiver.kernel.org>; Thu, 23 Sep 2021 07:34:27 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD0EE6115A
	for <virtualization@archiver.kernel.org>; Thu, 23 Sep 2021 07:34:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org AD0EE6115A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 69CE94028C;
	Thu, 23 Sep 2021 07:34:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Bku2unHDOht2; Thu, 23 Sep 2021 07:34:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id AAB9C40151;
	Thu, 23 Sep 2021 07:34:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 80058C0011;
	Thu, 23 Sep 2021 07:34:25 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EFC7EC000D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 23 Sep 2021 07:34:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id CF6444028C
 for <virtualization@lists.linux-foundation.org>;
 Thu, 23 Sep 2021 07:34:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bGf_HjR3QqKT
 for <virtualization@lists.linux-foundation.org>;
 Thu, 23 Sep 2021 07:34:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C2E2640151
 for <virtualization@lists.linux-foundation.org>;
 Thu, 23 Sep 2021 07:34:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1632382462;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O8cUyI9/HMZ0M0mF4x4BdIxxtOl/YPdtt2A3oRUwwgY=;
 b=GvrcOq15WtJ1K0mWErwcDLsUZu2GaqHvO4Y5giOsw9iq2wqSiOOV3FJOK8A0OzZa60A8ri
 O203f7kv80E6sqDwY+cmnjTNm2nJ6mpCCa1/W92VaUnrQ/AV+WKeUD4KXxyp8HCV/hn/9/
 7p/D4GTDPRYFbzzoGVFpWpwKLVj+i78=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-366-5yL4cSw0PPWoNgEkEhhnQA-1; Thu, 23 Sep 2021 03:34:21 -0400
X-MC-Unique: 5yL4cSw0PPWoNgEkEhhnQA-1
Received: by mail-wr1-f70.google.com with SMTP id
 x2-20020a5d54c2000000b0015dfd2b4e34so4381131wrv.6
 for <virtualization@lists.linux-foundation.org>;
 Thu, 23 Sep 2021 00:34:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=O8cUyI9/HMZ0M0mF4x4BdIxxtOl/YPdtt2A3oRUwwgY=;
 b=Q7NoFlSUoDREirBM+QHmXNgvOL3LH0T5lx5acFjDGUKY+8SBkIhrpVyJywOfBIG8Cr
 A64BWFSoJfZ4OtjjiSoC5rizKFLid3XE7qCk+BUWl6GW+2UH4I2wv2dunSnjDXB7Jjrm
 xznb8Tf+YpDpp26GptEXqeikQ5CyIihn3I26BcQ2RhJ1quHCIWBqkRmeYZVcByI/+liK
 Lpb0We0/LBdyuqFPjZ8alaqH9WxbGfUfNnXunazIfXR9+uVrUxEXtdjwi8nSq3shubYD
 vnXyJJg4UdzBjZXTx3cRlam45cNKinJuIGsfIYz4MdmGsYBvjUhtkRbuE+Rcwind2XV+
 9BiQ==
X-Gm-Message-State: AOAM5308OjREiVye3lwDRIc2nyj35ymSClgGQzIyMH9TgRx/oUS0fjXF
 zAuc8GaVtzxIT2s+OCcs9NQK6aFjAyl9VJJR+h1w82IkVlqOfoIeBPIVOxmL5hzURATF3OmsY2A
 Q8T4PJbqRdC4qCQXeg6APIrufQE5sH1SHmLrDfsWQ6Q==
X-Received: by 2002:adf:e88e:: with SMTP id d14mr3370962wrm.207.1632382460395; 
 Thu, 23 Sep 2021 00:34:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxHVpu+hYgQv3Vr9qakA2clcHQvzESskHQMHwX41kpOJMu4ZLSK8S3ymUHXSpW20Q4DX9HJdw==
X-Received: by 2002:adf:e88e:: with SMTP id d14mr3370927wrm.207.1632382460011; 
 Thu, 23 Sep 2021 00:34:20 -0700 (PDT)
Received: from [192.168.100.42] ([82.142.21.142])
 by smtp.gmail.com with ESMTPSA id t6sm8021355wmj.12.2021.09.23.00.34.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Sep 2021 00:34:19 -0700 (PDT)
Message-ID: <fcd17df1-5aed-346b-e7cd-abe4dfb67e69@redhat.com>
Date: Thu, 23 Sep 2021 09:34:18 +0200
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
From: Laurent Vivier <lvivier@redhat.com>
In-Reply-To: <20210923030026-mutt-send-email-mst@kernel.org>
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

On 23/09/2021 09:04, Michael S. Tsirkin wrote:
> On Thu, Sep 23, 2021 at 08:26:06AM +0200, Laurent Vivier wrote:
>> On 22/09/2021 21:02, Michael S. Tsirkin wrote:
>>> On Wed, Sep 22, 2021 at 07:09:00PM +0200, Laurent Vivier wrote:
>>>> hwrng core uses two buffers that can be mixed in the
>>>> virtio-rng queue.
>>>>
>>>> If the buffer is provided with wait=0 it is enqueued in the
>>>> virtio-rng queue but unused by the caller.
>>>> On the next call, core provides another buffer but the
>>>> first one is filled instead and the new one queued.
>>>> And the caller reads the data from the new one that is not
>>>> updated, and the data in the first one are lost.
>>>>
>>>> To avoid this mix, virtio-rng needs to use its own unique
>>>> internal buffer at a cost of a data copy to the caller buffer.
>>>>
>>>> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
>>>> ---
>>>>    drivers/char/hw_random/virtio-rng.c | 43 ++++++++++++++++++++++-------
>>>>    1 file changed, 33 insertions(+), 10 deletions(-)
>>>>
>>>> diff --git a/drivers/char/hw_random/virtio-rng.c b/drivers/char/hw_random/virtio-rng.c
>>>> index a90001e02bf7..208c547dcac1 100644
>>>> --- a/drivers/char/hw_random/virtio-rng.c
>>>> +++ b/drivers/char/hw_random/virtio-rng.c
>>>> @@ -18,13 +18,20 @@ static DEFINE_IDA(rng_index_ida);
>>>>    struct virtrng_info {
>>>>    	struct hwrng hwrng;
>>>>    	struct virtqueue *vq;
>>>> -	struct completion have_data;
>>>>    	char name[25];
>>>> -	unsigned int data_avail;
>>>>    	int index;
>>>>    	bool busy;
>>>>    	bool hwrng_register_done;
>>>>    	bool hwrng_removed;
>>>> +	/* data transfer */
>>>> +	struct completion have_data;
>>>> +	unsigned int data_avail;
>>>> +	/* minimal size returned by rng_buffer_size() */
>>>> +#if SMP_CACHE_BYTES < 32
>>>> +	u8 data[32];
>>>> +#else
>>>> +	u8 data[SMP_CACHE_BYTES];
>>>> +#endif
>>>
>>> Let's move this logic to a macro in hw_random.h ?
>>>
>>>>    };
>>>>    static void random_recv_done(struct virtqueue *vq)
>>>> @@ -39,14 +46,14 @@ static void random_recv_done(struct virtqueue *vq)
>>>>    }
>>>>    /* The host will fill any buffer we give it with sweet, sweet randomness. */
>>>> -static void register_buffer(struct virtrng_info *vi, u8 *buf, size_t size)
>>>> +static void register_buffer(struct virtrng_info *vi)
>>>>    {
>>>>    	struct scatterlist sg;
>>>> -	sg_init_one(&sg, buf, size);
>>>> +	sg_init_one(&sg, vi->data, sizeof(vi->data));
>>>
>>> Note that add_early_randomness requests less:
>>>           size_t size = min_t(size_t, 16, rng_buffer_size());
>>>
>>> maybe track how much was requested and grow up to sizeof(data)?
>>
>> I think this problem is managed by PATCH 3/4 as we reuse unused data of the buffer.
> 
> the issue I'm pointing out is that we are requesting too much
> entropy from host - more than guest needs.

Yes, guest asks for 16 bytes, but we request SMP_CACHE_BYTES (64 on x86_64), and these 16 
bytes are used with add_device_randomness(). With the following patches, the remaining 48 
bytes are used rapidly by hwgnd kthread or by the next virtio_read.

If there is no enough entropy the call is simply ignored as wait=0.

At this patch level the call is always simply ignored (because wait=0) and the data 
requested here are used by the next read that always asks for a SMP_CACHE_BYTES bytes data 
size.

Moreover in PATCH 4/4 we always have a pending request of size SMP_CACHE_BYTES, so driver 
always asks a block of this size and the guest takes what it needs.

Originally I used a 16 bytes block but performance are divided by 4.

Do you propose something else?

Thanks,
Laurent

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
