Return-Path: <SRS0=2rcL=ON=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F28ACC433F5
	for <virtualization@archiver.kernel.org>; Thu, 23 Sep 2021 06:26:18 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81930611B0
	for <virtualization@archiver.kernel.org>; Thu, 23 Sep 2021 06:26:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 81930611B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 386CE41601;
	Thu, 23 Sep 2021 06:26:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ytfexbuwIjmZ; Thu, 23 Sep 2021 06:26:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id A9F8D41600;
	Thu, 23 Sep 2021 06:26:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8B12DC0011;
	Thu, 23 Sep 2021 06:26:16 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F1328C000D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 23 Sep 2021 06:26:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E6B936153F
 for <virtualization@lists.linux-foundation.org>;
 Thu, 23 Sep 2021 06:26:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BSYXZT35lZiV
 for <virtualization@lists.linux-foundation.org>;
 Thu, 23 Sep 2021 06:26:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C2CA7606F3
 for <virtualization@lists.linux-foundation.org>;
 Thu, 23 Sep 2021 06:26:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1632378372;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=71fUOImGUODDyJCOfZ+X9xPf/a4pfZ4Afxj/CEjfaLk=;
 b=f6E8+MZIipTbD+3Ktb52dY80XXvlvWG3EkANabixyf8aF0Pw2vU4Ql0vuRGTWyIlsVyaK/
 jxyUObYbJ7+ZVMZN52by4bFVokJZgJd08fDTGrE4T60nl02I/a645T6JircL2I/I9xHRQN
 gafOgpmeSiSmEKexlUUSiMRhQk78otE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-229-SIJMjoV3Mri432CuLLTdMQ-1; Thu, 23 Sep 2021 02:26:11 -0400
X-MC-Unique: SIJMjoV3Mri432CuLLTdMQ-1
Received: by mail-wr1-f70.google.com with SMTP id
 f11-20020adfc98b000000b0015fedc2a8d4so4302029wrh.0
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Sep 2021 23:26:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=71fUOImGUODDyJCOfZ+X9xPf/a4pfZ4Afxj/CEjfaLk=;
 b=ajKPJQw83ZMxYsOCASKVwfCyP4jVO5NWifvzTSx3Aoz/oQa3HVkdyemsqvQZ+N0GYv
 pvpjmDhBdiJFtWHMK/PaLcEge4wxcJUyeCeW55OdPwyI5mH9hRlO+WCnW8mce61ytXJs
 YNhLRXcVDvgnGZ0JuAaAu97lx0JqYSkt36aOSNfD9zUGwX2lWuClvW4n1jjGBBdVLgnZ
 klZ8ET8dylpOG1YFIRafF8udvxRVxKoB8dCNAbM9cQltRsFzXScy/OqbTUOmegnR9Tl0
 nHA+kJQhkV5yZkClMm8uA46mBauqMLDqa9Dmfwqtbum+cKWK2YSoxReIRCGBJ+W+6OzW
 QM6w==
X-Gm-Message-State: AOAM530H5ZHKjy5HkzKe+Hixz/uO3vCvDlG1mhX1gIFK+KSZrEmXuT84
 G7UWsvzhaLvTeWFCdvM+x39Ea4LCtboNpgwHbnTZ/dQvwgf5wgMbF0Ip3hMDzV6lhPJLyQcFq5H
 4DsLFWIzltqEUE8qoVO40FGd2tMpD45BePzNsRrJXLg==
X-Received: by 2002:a05:600c:35d2:: with SMTP id
 r18mr14004167wmq.97.1632378369831; 
 Wed, 22 Sep 2021 23:26:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx/DaTIZtdSS0b0eqh6Dbu9+P7YRuw+Cv3OyT69GeFyi7+s2AXNgBTjbFRA58JrR83WfyjtAw==
X-Received: by 2002:a05:600c:35d2:: with SMTP id
 r18mr14004142wmq.97.1632378369633; 
 Wed, 22 Sep 2021 23:26:09 -0700 (PDT)
Received: from [192.168.100.42] ([82.142.21.142])
 by smtp.gmail.com with ESMTPSA id v20sm4386301wra.73.2021.09.22.23.26.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Sep 2021 23:26:08 -0700 (PDT)
Message-ID: <0dd338bb-0fbe-b9d5-0962-d47ac2de4c4e@redhat.com>
Date: Thu, 23 Sep 2021 08:26:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH 1/4] hwrng: virtio - add an internal buffer
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20210922170903.577801-1-lvivier@redhat.com>
 <20210922170903.577801-2-lvivier@redhat.com>
 <20210922145651-mutt-send-email-mst@kernel.org>
From: Laurent Vivier <lvivier@redhat.com>
In-Reply-To: <20210922145651-mutt-send-email-mst@kernel.org>
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

On 22/09/2021 21:02, Michael S. Tsirkin wrote:
> On Wed, Sep 22, 2021 at 07:09:00PM +0200, Laurent Vivier wrote:
>> hwrng core uses two buffers that can be mixed in the
>> virtio-rng queue.
>>
>> If the buffer is provided with wait=0 it is enqueued in the
>> virtio-rng queue but unused by the caller.
>> On the next call, core provides another buffer but the
>> first one is filled instead and the new one queued.
>> And the caller reads the data from the new one that is not
>> updated, and the data in the first one are lost.
>>
>> To avoid this mix, virtio-rng needs to use its own unique
>> internal buffer at a cost of a data copy to the caller buffer.
>>
>> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
>> ---
>>   drivers/char/hw_random/virtio-rng.c | 43 ++++++++++++++++++++++-------
>>   1 file changed, 33 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/char/hw_random/virtio-rng.c b/drivers/char/hw_random/virtio-rng.c
>> index a90001e02bf7..208c547dcac1 100644
>> --- a/drivers/char/hw_random/virtio-rng.c
>> +++ b/drivers/char/hw_random/virtio-rng.c
>> @@ -18,13 +18,20 @@ static DEFINE_IDA(rng_index_ida);
>>   struct virtrng_info {
>>   	struct hwrng hwrng;
>>   	struct virtqueue *vq;
>> -	struct completion have_data;
>>   	char name[25];
>> -	unsigned int data_avail;
>>   	int index;
>>   	bool busy;
>>   	bool hwrng_register_done;
>>   	bool hwrng_removed;
>> +	/* data transfer */
>> +	struct completion have_data;
>> +	unsigned int data_avail;
>> +	/* minimal size returned by rng_buffer_size() */
>> +#if SMP_CACHE_BYTES < 32
>> +	u8 data[32];
>> +#else
>> +	u8 data[SMP_CACHE_BYTES];
>> +#endif
> 
> Let's move this logic to a macro in hw_random.h ?
> 
>>   };
>>   
>>   static void random_recv_done(struct virtqueue *vq)
>> @@ -39,14 +46,14 @@ static void random_recv_done(struct virtqueue *vq)
>>   }
>>   
>>   /* The host will fill any buffer we give it with sweet, sweet randomness. */
>> -static void register_buffer(struct virtrng_info *vi, u8 *buf, size_t size)
>> +static void register_buffer(struct virtrng_info *vi)
>>   {
>>   	struct scatterlist sg;
>>   
>> -	sg_init_one(&sg, buf, size);
>> +	sg_init_one(&sg, vi->data, sizeof(vi->data));
> 
> Note that add_early_randomness requests less:
>          size_t size = min_t(size_t, 16, rng_buffer_size());
> 
> maybe track how much was requested and grow up to sizeof(data)?

I think this problem is managed by PATCH 3/4 as we reuse unused data of the buffer.

> 
>>   
>>   	/* There should always be room for one buffer. */
>> -	virtqueue_add_inbuf(vi->vq, &sg, 1, buf, GFP_KERNEL);
>> +	virtqueue_add_inbuf(vi->vq, &sg, 1, vi->data, GFP_KERNEL);
> 
> 
> BTW no longer true if DMA API is in use ... not easy to fix,
> I think some changes to virtio API to allow pre-mapping
> s/g for DMA might be needed ...

Is there something I can do here?

Thanks,
Laurent

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
