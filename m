Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7B64C77B7C
	for <virtualization@archiver.kernel.org>; Fri, 12 May 2023 11:55:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1900441F69;
	Fri, 12 May 2023 11:55:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1900441F69
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=KhnXpEvv
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6qkfTKhfzfC6; Fri, 12 May 2023 11:55:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 3521141F7E;
	Fri, 12 May 2023 11:55:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3521141F7E
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 049F9C0037;
	Fri, 12 May 2023 11:55:56 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7F513C002A
 for <virtualization@lists.linux-foundation.org>;
 Fri, 12 May 2023 11:55:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 53775841DC
 for <virtualization@lists.linux-foundation.org>;
 Fri, 12 May 2023 11:55:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 53775841DC
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com
 header.a=rsa-sha256 header.s=google header.b=KhnXpEvv
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id w0qwn1qu4OkY
 for <virtualization@lists.linux-foundation.org>;
 Fri, 12 May 2023 11:55:54 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2AAB1841D6
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com
 [IPv6:2607:f8b0:4864:20::436])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2AAB1841D6
 for <virtualization@lists.linux-foundation.org>;
 Fri, 12 May 2023 11:55:53 +0000 (UTC)
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-6439b410679so6497408b3a.0
 for <virtualization@lists.linux-foundation.org>;
 Fri, 12 May 2023 04:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1683892553; x=1686484553;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5Gba+mHkqBgGHJ7UuOU7TI0XxLnFfu08zX8z0165YJw=;
 b=KhnXpEvva702ZnXXycpET18s/LyE1iJoZ4lWJ6dXCdOhkZtxT49LD5pbsZYttO+idc
 wW4JKJWlqOwGBoX1Ixm91stGEwh2CxxEaQEjSjh/lRP+/FIVHe/cbOGuHE+9v0v03Z3g
 r6bOGV8pYRiD1cqrL3UCE43/ilmFIcrgBaXzlIG84qZpeApxm1sLNN8mWncXEIq7Mh1c
 lEYfoSco7n8L9qE/A3+cGge6idxsYZYNWM7s2y8uYgGXws81s0+DQ0/nrzaYR4bVcmVp
 kgWrrnYsWe4PMsxeNtAO5SNWvGe4AhRzNje7MJ6DvnM32dauVC173AJ+C4aYhv+me9de
 Hl4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1683892553; x=1686484553;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5Gba+mHkqBgGHJ7UuOU7TI0XxLnFfu08zX8z0165YJw=;
 b=DogWjq80MJgXaU5nFVOQVBCxx/g6GlXggnV+MlzEHioxBIcPv1J3MO6d8nxJChiIrT
 ofI3qaLjahPxtnhCcYmlWxv5ffor03tb9H6Tg10+dZntOXTlHUCJrDaSLCIpgCcuAeNc
 +870NDrVsBuc3viI+yKB+T/EvCPWMJMED/JrdcshhXELEQXGL2qHLkQpyUnxFOFutlE5
 yttQOGOvllQA/SRQkl0J5PGIsLoZEpQ/MLaJHMTSlB0MRD+5fCEwg6CuULBLswVSJyK3
 in5iEuPmT+V5fRiR+SDGLIPKY8E58NTrIROJGaa3Dx1IjaNU3tbu17C1pv4VCkuKxwtV
 DufA==
X-Gm-Message-State: AC+VfDxb8rosrE2Pvwnh+6naHnKw7wpqKZBEytgmszTwq3hje4yWLsv3
 cxcGdXsuNhcvR3eyFUcSGzizoQ==
X-Google-Smtp-Source: ACHHUZ42poTV7OM0UC4TNtwYuyGOfPkqr2Bfl5BYoC/qBqr6/rmRKckeMKAQi+M5ii8DeCfOqO0xcg==
X-Received: by 2002:a05:6a00:1a06:b0:63b:8423:9e31 with SMTP id
 g6-20020a056a001a0600b0063b84239e31mr30050836pfv.11.1683892553385; 
 Fri, 12 May 2023 04:55:53 -0700 (PDT)
Received: from [10.3.43.196] ([61.213.176.7]) by smtp.gmail.com with ESMTPSA id
 j11-20020a62e90b000000b00571cdbd0771sm6874751pfh.102.2023.05.12.04.55.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 12 May 2023 04:55:52 -0700 (PDT)
Message-ID: <59b38f07-73c2-07c2-ef2d-660445f593e1@bytedance.com>
Date: Fri, 12 May 2023 19:53:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: Re: Re: [PATCH 1/2] virtio: abstract virtqueue related methods
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20230512094618.433707-1-pizhenwei@bytedance.com>
 <20230512094618.433707-2-pizhenwei@bytedance.com>
 <20230512064305-mutt-send-email-mst@kernel.org>
 <37a5e7dc-160d-51d2-7631-196ad9e21da7@bytedance.com>
 <20230512072819-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230512072819-mutt-send-email-mst@kernel.org>
Cc: xuanzhuo@linux.alibaba.com, linux-kernel@vger.kernel.org,
 stefanha@redhat.com, virtualization@lists.linux-foundation.org
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
From: zhenwei pi via Virtualization <virtualization@lists.linux-foundation.org>
Reply-To: zhenwei pi <pizhenwei@bytedance.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On 5/12/23 19:35, Michael S. Tsirkin wrote:
> On Fri, May 12, 2023 at 07:09:40PM +0800, zhenwei pi wrote:
>> On 5/12/23 18:46, Michael S. Tsirkin wrote:
>>> On Fri, May 12, 2023 at 05:46:17PM +0800, zhenwei pi wrote:
>>>> There is already a virtqueue abstract structure in virtio subsystem
>>>> (see struct virtqueue in include/linux/virtio.h), however the vring
>>>> based virtqueue is used only in the past years, the virtqueue related
>>>> methods mix much with vring(just look like the codes, virtqueue_xxx
>>>> functions are implemented in virtio_ring.c).
>>>>
>>>> Abstract virtqueue related methods(see struct virtqueue_ops), and
>>>> separate virtqueue_xxx symbols from vring. This allows a non-vring
>>>> based transport in the future. With this change, the following symbols
>>>> are exported from virtio.ko instead of virtio_ring.ko:
>>>>     virtqueue_add_sgs
>>>>     virtqueue_add_outbuf
>>>>     virtqueue_add_inbuf
>>>>     virtqueue_add_inbuf_ctx
>>>>     virtqueue_kick_prepare
>>>>     virtqueue_notify
>>>>     virtqueue_kick
>>>>     virtqueue_enable_cb_prepare
>>>>     virtqueue_enable_cb
>>>>     virtqueue_enable_cb_delayed
>>>>     virtqueue_disable_cb
>>>>     virtqueue_poll
>>>>     virtqueue_get_buf_ctx
>>>>     virtqueue_get_buf
>>>>     virtqueue_detach_unused_buf
>>>>     virtqueue_get_vring_size
>>>>     virtqueue_resize
>>>>     virtqueue_is_broken
>>>>     virtio_break_device
>>>>     __virtio_unbreak_device
>>>>
>>>> Cc: Stefan Hajnoczi <stefanha@redhat.com>
>>>> Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
>>>> ---
>>>>    drivers/virtio/virtio.c      | 362 +++++++++++++++++++++++++++++++++++
>>>>    drivers/virtio/virtio_ring.c | 282 +++++----------------------
>>>>    include/linux/virtio.h       |  29 +++
>>>>    3 files changed, 443 insertions(+), 230 deletions(-)
>>>>
>>>> diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
>>>> index 3893dc29eb26..8d8715a10f26 100644
>>>> --- a/drivers/virtio/virtio.c
>>>> +++ b/drivers/virtio/virtio.c
>>>> @@ -553,6 +553,368 @@ int virtio_device_restore(struct virtio_device *dev)
>>>>    EXPORT_SYMBOL_GPL(virtio_device_restore);
>>>>    #endif
>>>> +/**
>>>> + * virtqueue_add_sgs - expose buffers to other end
>>>> + * @vq: the struct virtqueue we're talking about.
>>>> + * @sgs: array of terminated scatterlists.
>>>> + * @out_sgs: the number of scatterlists readable by other side
>>>> + * @in_sgs: the number of scatterlists which are writable (after readable ones)
>>>> + * @data: the token identifying the buffer.
>>>> + * @gfp: how to do memory allocations (if necessary).
>>>> + *
>>>> + * Caller must ensure we don't call this with other virtqueue operations
>>>> + * at the same time (except where noted).
>>>> + *
>>>> + * Returns zero or a negative error (ie. ENOSPC, ENOMEM, EIO).
>>>> + */
>>>> +int virtqueue_add_sgs(struct virtqueue *vq, struct scatterlist *sgs[],
>>>> +		      unsigned int out_sgs, unsigned int in_sgs,
>>>> +		      void *data, gfp_t gfp)
>>>> +{
>>>> +	unsigned int i, total_sg = 0;
>>>> +
>>>> +	/* Count them first. */
>>>> +	for (i = 0; i < out_sgs + in_sgs; i++) {
>>>> +		struct scatterlist *sg;
>>>> +
>>>> +		for (sg = sgs[i]; sg; sg = sg_next(sg))
>>>> +			total_sg++;
>>>> +	}
>>>> +	return vq->ops->add_sgs(vq, sgs, total_sg, out_sgs, in_sgs,
>>>> +				data, NULL, gfp);
>>>> +}
>>>> +EXPORT_SYMBOL_GPL(virtqueue_add_sgs);
>>>
>>>
>>> Hmm this kind of indirection on data path is going to be costly
>>> performance-wise especially when retpolines are in place.
>>>
>>> Any data on this?
>>>
>>
>> Hi,
>>
>> 1, What about moving these functions into virtio.h and declare them as
>> static inline?
> 
> This will do nothing to remove indirection.
> 
>> 2, what about moving method fields into struct virtqueue?
> 
> This gets rid of one level of indirection but the big problem
> is indirect function call due to retpolines, this remains.
> 
> 
>> Then we have struct like:
>> struct virtqueue {
>> 	struct list_head list;
>> 	...
>> 	void *priv;
>>
>> 	/* virtqueue specific operations */
>>          int (*add_sgs)(struct virtqueue *vq, struct scatterlist *sgs[],
>>                         unsigned int total_sg,
>>                         unsigned int out_sgs, unsigned int in_sgs,
>>                         void *data, void *ctx, gfp_t gfp);
>> 	...
>> }
>>
>> and functions like:
>> static inline int virtqueue_add_sgs(...)
>> {
>>          unsigned int i, total_sg = 0;
>>
>>          /* Count them first. */
>>          for (i = 0; i < out_sgs + in_sgs; i++) {
>>                  struct scatterlist *sg;
>>
>>                  for (sg = sgs[i]; sg; sg = sg_next(sg))
>>                          total_sg++;
>>          }
>>          return vq->add_sgs(vq, sgs, total_sg, out_sgs, in_sgs,
>>                             data, NULL, gfp);
>> }
> 
> Maybe a flag in vq:
> 	bool abstract; /* use ops to add/get bufs and kick */
> and then
> 	if (unlikely(vq->abstract))
> 		 return vq->ops->add_sgs(vq, sgs, total_sg, out_sgs, in_sgs,
> 				    	 data, NULL, gfp);
> 
> transport then just sets the ops if it wants abstract vqs,
> and core then skips the vring.
> 
> 
>> If [1] is acceptable, we can also reduce changes in patch 'tools/virtio:
>> implement virtqueue in test'.
> 
> Yea that one shouldn't be there.
> 
>> -- 
>> zhenwei pi
> 

OK, I'll try and send a next version a few days later. Thanks!

-- 
zhenwei pi
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
