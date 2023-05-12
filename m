Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBCE2C77B75
	for <virtualization@archiver.kernel.org>; Fri, 12 May 2023 11:11:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 7392242B66;
	Fri, 12 May 2023 11:11:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7392242B66
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=CNl8PQ30
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HDDXXP0BvkmX; Fri, 12 May 2023 11:11:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id DD4AB401A4;
	Fri, 12 May 2023 11:11:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org DD4AB401A4
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BA16BC0037;
	Fri, 12 May 2023 11:11:46 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 908A6C002A
 for <virtualization@lists.linux-foundation.org>;
 Fri, 12 May 2023 11:11:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 58406841BE
 for <virtualization@lists.linux-foundation.org>;
 Fri, 12 May 2023 11:11:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 58406841BE
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com
 header.a=rsa-sha256 header.s=google header.b=CNl8PQ30
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mFe3_dQLnnt5
 for <virtualization@lists.linux-foundation.org>;
 Fri, 12 May 2023 11:11:44 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3150B83C59
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com
 [IPv6:2607:f8b0:4864:20::432])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3150B83C59
 for <virtualization@lists.linux-foundation.org>;
 Fri, 12 May 2023 11:11:43 +0000 (UTC)
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-64388cf3263so7010167b3a.3
 for <virtualization@lists.linux-foundation.org>;
 Fri, 12 May 2023 04:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1683889903; x=1686481903;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gWUF/DYv1jnKJ8vR8wMgZeyL5oNGsu4WTVEsbiWB8Vk=;
 b=CNl8PQ30zIzL7/2Xhv3Lhc+bcTLn/+StpE629utKmAs1ElN8IfQCAsQWS6zHMDPTxB
 MMDfRtHcogil9uC6uUBk0YKrKoZlFU1G7+jtpOE93GuKUKSZMw/qwRoIdArbdlyOp+bF
 lHZH56+E68OQY/ZUbXowLrSfHKjijbdnlHvQEHiv3BYf4JGzGRgIq+PEd4a68fr90ZIe
 VJSxoFq2Gf5fJawUG/eC+LP93CRswz/qYbc0mPrX1Wg9NIEmYZbJ5lf+y9Gwd92TjH5P
 a8+yHNJoIhEQtXrLPkg+qXwX9xUNH2sYSaaeB/fxPpS6BV9tOOmN13m22g2FklHhcBlj
 PYPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1683889903; x=1686481903;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gWUF/DYv1jnKJ8vR8wMgZeyL5oNGsu4WTVEsbiWB8Vk=;
 b=S7SmjSobpK0km/sJeGHqfW4M/bqqoun3qNG1aLPWw5I6ylqfPyvoQZMiRopJjNp5d0
 D7kaD20aXQ9UWzzI63c6A1LWi/XYf5dyM/vt6uxY/QQ97MMK3WA5JNCxR7hPAIsIc3jD
 y6uHpUph+y4Dzrno+lQ09oYQBMRd8tKwfnympdAPYmGaaL7qEuNqdoENrSOM+x+by0VZ
 TzKHia/JUn6mHCFwB/Qqwhz6weoDmNdRSHD1meg7qZZy0MHPp3GyQlowGeazdjTLVjQI
 1Zp0lzyi6c3GcD8UzLKlFr+UQkro9WviBrABZHFe8UBj6WNEddgwdsXc2wAiF9Ofk2DF
 fk5w==
X-Gm-Message-State: AC+VfDyA4NflnXNSe782RZYsKuW/LOzuKDFpfUnOUNk3MxKVvXMryt19
 qV+94sr/HwE3BZKdxr6Sp/B/Rg==
X-Google-Smtp-Source: ACHHUZ45AjU5yfvO35JkNOdP5Bjt7NUpHmOHLQPaeZJJhytnrB0dPjdZw4VhoG9IRKZI9x0gHCVUkw==
X-Received: by 2002:a05:6a20:9184:b0:100:d4ee:ba80 with SMTP id
 v4-20020a056a20918400b00100d4eeba80mr10019096pzd.27.1683889903283; 
 Fri, 12 May 2023 04:11:43 -0700 (PDT)
Received: from [10.3.43.196] ([61.213.176.6]) by smtp.gmail.com with ESMTPSA id
 g15-20020a63f40f000000b0053031f7a367sm6559889pgi.85.2023.05.12.04.11.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 12 May 2023 04:11:42 -0700 (PDT)
Message-ID: <37a5e7dc-160d-51d2-7631-196ad9e21da7@bytedance.com>
Date: Fri, 12 May 2023 19:09:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: Re: [PATCH 1/2] virtio: abstract virtqueue related methods
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20230512094618.433707-1-pizhenwei@bytedance.com>
 <20230512094618.433707-2-pizhenwei@bytedance.com>
 <20230512064305-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230512064305-mutt-send-email-mst@kernel.org>
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

On 5/12/23 18:46, Michael S. Tsirkin wrote:
> On Fri, May 12, 2023 at 05:46:17PM +0800, zhenwei pi wrote:
>> There is already a virtqueue abstract structure in virtio subsystem
>> (see struct virtqueue in include/linux/virtio.h), however the vring
>> based virtqueue is used only in the past years, the virtqueue related
>> methods mix much with vring(just look like the codes, virtqueue_xxx
>> functions are implemented in virtio_ring.c).
>>
>> Abstract virtqueue related methods(see struct virtqueue_ops), and
>> separate virtqueue_xxx symbols from vring. This allows a non-vring
>> based transport in the future. With this change, the following symbols
>> are exported from virtio.ko instead of virtio_ring.ko:
>>    virtqueue_add_sgs
>>    virtqueue_add_outbuf
>>    virtqueue_add_inbuf
>>    virtqueue_add_inbuf_ctx
>>    virtqueue_kick_prepare
>>    virtqueue_notify
>>    virtqueue_kick
>>    virtqueue_enable_cb_prepare
>>    virtqueue_enable_cb
>>    virtqueue_enable_cb_delayed
>>    virtqueue_disable_cb
>>    virtqueue_poll
>>    virtqueue_get_buf_ctx
>>    virtqueue_get_buf
>>    virtqueue_detach_unused_buf
>>    virtqueue_get_vring_size
>>    virtqueue_resize
>>    virtqueue_is_broken
>>    virtio_break_device
>>    __virtio_unbreak_device
>>
>> Cc: Stefan Hajnoczi <stefanha@redhat.com>
>> Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
>> ---
>>   drivers/virtio/virtio.c      | 362 +++++++++++++++++++++++++++++++++++
>>   drivers/virtio/virtio_ring.c | 282 +++++----------------------
>>   include/linux/virtio.h       |  29 +++
>>   3 files changed, 443 insertions(+), 230 deletions(-)
>>
>> diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
>> index 3893dc29eb26..8d8715a10f26 100644
>> --- a/drivers/virtio/virtio.c
>> +++ b/drivers/virtio/virtio.c
>> @@ -553,6 +553,368 @@ int virtio_device_restore(struct virtio_device *dev)
>>   EXPORT_SYMBOL_GPL(virtio_device_restore);
>>   #endif
>>   
>> +/**
>> + * virtqueue_add_sgs - expose buffers to other end
>> + * @vq: the struct virtqueue we're talking about.
>> + * @sgs: array of terminated scatterlists.
>> + * @out_sgs: the number of scatterlists readable by other side
>> + * @in_sgs: the number of scatterlists which are writable (after readable ones)
>> + * @data: the token identifying the buffer.
>> + * @gfp: how to do memory allocations (if necessary).
>> + *
>> + * Caller must ensure we don't call this with other virtqueue operations
>> + * at the same time (except where noted).
>> + *
>> + * Returns zero or a negative error (ie. ENOSPC, ENOMEM, EIO).
>> + */
>> +int virtqueue_add_sgs(struct virtqueue *vq, struct scatterlist *sgs[],
>> +		      unsigned int out_sgs, unsigned int in_sgs,
>> +		      void *data, gfp_t gfp)
>> +{
>> +	unsigned int i, total_sg = 0;
>> +
>> +	/* Count them first. */
>> +	for (i = 0; i < out_sgs + in_sgs; i++) {
>> +		struct scatterlist *sg;
>> +
>> +		for (sg = sgs[i]; sg; sg = sg_next(sg))
>> +			total_sg++;
>> +	}
>> +	return vq->ops->add_sgs(vq, sgs, total_sg, out_sgs, in_sgs,
>> +				data, NULL, gfp);
>> +}
>> +EXPORT_SYMBOL_GPL(virtqueue_add_sgs);
> 
> 
> Hmm this kind of indirection on data path is going to be costly
> performance-wise especially when retpolines are in place.
> 
> Any data on this?
> 

Hi,

1, What about moving these functions into virtio.h and declare them as 
static inline?
2, what about moving method fields into struct virtqueue?

Then we have struct like:
struct virtqueue {
	struct list_head list;
	...
	void *priv;

	/* virtqueue specific operations */
         int (*add_sgs)(struct virtqueue *vq, struct scatterlist *sgs[],
                        unsigned int total_sg,
                        unsigned int out_sgs, unsigned int in_sgs,
                        void *data, void *ctx, gfp_t gfp);
	...
}

and functions like:
static inline int virtqueue_add_sgs(...)
{
         unsigned int i, total_sg = 0;

         /* Count them first. */
         for (i = 0; i < out_sgs + in_sgs; i++) {
                 struct scatterlist *sg;

                 for (sg = sgs[i]; sg; sg = sg_next(sg))
                         total_sg++;
         }
         return vq->add_sgs(vq, sgs, total_sg, out_sgs, in_sgs,
                            data, NULL, gfp);
}

If [1] is acceptable, we can also reduce changes in patch 'tools/virtio: 
implement virtqueue in test'.

-- 
zhenwei pi
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
