Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE09155757
	for <virtualization@lists.linux.dev>; Wed,  4 Sep 2024 07:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725436326; cv=none; b=fjXUnyF0vYU1Czy3SmdNKK/IF+1LmK2HfxjWjXsvOvBy+o5y6NMBQvVrGF9BWZdakEB/A3ww3kY0PzCpG82iNUGuOzsaZnxYn6X8nIU0ox72W/QY/btcthFan0aTyvvB3YQV1jyW0AgfxTCmHb6qRzdlmlrsadr8YzXfcJMG2+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725436326; c=relaxed/simple;
	bh=XlTIUbn1Mep0bKbMFbS0L2TutkBucy3kWAGcWXdoArw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IubHzw5qH25Cpnf53kmozZcmAIS9G4g7ZONnn8btcff39fvuqgy4kwDYLjUcd2xK6cl3zJUO+zANTkL12FoCgFT6hhiKkNCHzt2SBsapfsJQ4j3QLLR0k0fkCoSJRObh/P3o6kNW0cg/3V5xTj6j6EIZD1s1ypLQlSRYc7g9esE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=VCOi1+mK; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="VCOi1+mK"
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-70f79f75da6so1734891a34.0
        for <virtualization@lists.linux.dev>; Wed, 04 Sep 2024 00:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1725436323; x=1726041123; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bfyB8TiIbc9wTFMFFJC/xReObRPNUC9QjHtcNn56KQA=;
        b=VCOi1+mKH806I0G3l69cNtJCLgi0y/HOGBrXxIbt/3Cvwws3uaa6aA/HA+viga31tt
         NpuZ9kHpeRGrAGb+Os6nw6yAEr+EYWXg6M/5UYvjSGKZkgraz5LDitqsRjzNJyoq4Hk6
         HEj/4ABwYKg5LtiPenKBqv9ggV/AeKcfiW1XAuHEIUQDMGaucIEj7LJFXPW2x6uvcHOr
         IrF6L5uPbYnpXM/4/xyBjd7dUSJgQzDCgUhH+t689qMgbseMd2l/fbnNac64ecgY3r2B
         4xlAJngiX6ql1gU983r1AwnG7dk1FgwhwG3BvQhlrVREgP9Nc38Uy4tqglbzUGgmMPyR
         j8aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725436323; x=1726041123;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bfyB8TiIbc9wTFMFFJC/xReObRPNUC9QjHtcNn56KQA=;
        b=I6ezKJbs1OEhdnoXTG9kXecosqsDowoOnoQNq9dEgIq4e9q8/t6OdsZsHF6hf4o3Kh
         ds5cGx6YiqeMxcLzNlwVX9zOPwftSTxLmbVLdL8KhcnhMQ+kK3Ws8uxQKSVwJ9kjoD7/
         RRLwNudICnCaFA6Va59oRXTZhQUc1cYv8AK0cmmnTM+onep78dJxbqKtvOk9VjjE8l6g
         uVhPSabTxdZOeN/XdMDoEe+wRjHBLxhOUBtj9WcpWBEla6liLzHjIuAMZBydrsNtuKXW
         SEfQYwqTwqxdZz83S4BB7aGfaNAtfp3d1lJkFsGW+//CEDvTEfeN/7Kh1e6ra1CbXPU5
         U+YQ==
X-Gm-Message-State: AOJu0YwNtAby6y+x8kUBPVLHcDMVZM5yli6wx4kHSNNk56DAUVaDnMAh
	ppovfDIB8mWqTuSRSej1zvhMQvI3bp+ZTkgI9xV1Bpr/YQeexiElkpesIu8LHMU=
X-Google-Smtp-Source: AGHT+IG652SFWHwBqEQjGzp7WbwcxYCsCWumiQr3uHJxnBiYGLnAeBTDteRRsBG1TzYF486FAdHplg==
X-Received: by 2002:a05:6870:a44c:b0:278:1b05:eda9 with SMTP id 586e51a60fabf-2781b066212mr5124716fac.17.1725436323108;
        Wed, 04 Sep 2024 00:52:03 -0700 (PDT)
Received: from [10.254.132.181] ([139.177.225.239])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7177858be66sm1037612b3a.120.2024.09.04.00.51.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Sep 2024 00:52:02 -0700 (PDT)
Message-ID: <845e22c1-84ee-47f8-b335-346b21d3216c@bytedance.com>
Date: Wed, 4 Sep 2024 15:51:56 +0800
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [External] Re: [PATCH v2] virtio_net: Fix mismatched buf address
 when unmapping for small packets
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jiahui Cen <cenjiahui@bytedance.com>,
 Ying Fang <fangying.tommy@bytedance.com>, mst@redhat.com,
 jasowang@redhat.com, eperezma@redhat.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
References: <20240904061009.90785-1-liwenbo.martin@bytedance.com>
 <1725432304.274084-1-xuanzhuo@linux.alibaba.com>
 <CABwj4+hMwUQ+=m+XyG=66e+PUbOzOvHEsQzboB17DE+3aBHA3g@mail.gmail.com>
 <1725435002.9733856-1-xuanzhuo@linux.alibaba.com>
From: Wenbo Li <liwenbo.martin@bytedance.com>
In-Reply-To: <1725435002.9733856-1-xuanzhuo@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Thank you. I'll fix these in v3.

On 9/4/24 15:30, Xuan Zhuo wrote:
> On Wed, 4 Sep 2024 15:21:28 +0800, =?utf-8?b?5paH5Y2a5p2O?= <liwenbo.martin@bytedance.com> wrote:
>> When SWIOTLB is enabled, a DMA map will allocate a bounce buffer for real
>> DMA operations,
>> and when unmapping, SWIOTLB copies the content in the bounce buffer to the
>> driver-allocated
>> buffer (the `buf` variable). Such copy only synchronizes data in the buffer
>> range, not the whole page.
>> So we should give the correct offset for DMA unmapping.
> I see.
>
> But I think we should pass the "correct" buf to virtio core as the "data" by
> virtqueue_add_inbuf_ctx().
>
> In the merge mode, we pass the pointer that points to the virtnet header.
> In the small mode, we pass the pointer that points to the virtnet header - offset.
>
> But this is not the only problem, we try to get the virtnet header by the buf
> inside receive_buf(before receive_small).
>
> 	flags = ((struct virtio_net_common_hdr *)buf)->hdr.flags;
>
> So I think it is time to unify the buf that passed to the virtio core into a
> pointer pointed to the virtnet header.
>
> Thanks.
>
>
>> Thanks.
>>
>> On Wed, Sep 4, 2024 at 2:46 PM Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
>>> On Wed,  4 Sep 2024 14:10:09 +0800, Wenbo Li <liwenbo.martin@bytedance.com>
>> wrote:
>>>> Currently, the virtio-net driver will perform a pre-dma-mapping for
>>>> small or mergeable RX buffer. But for small packets, a mismatched
>> address
>>>> without VIRTNET_RX_PAD and xdp_headroom is used for unmapping.
>>> Will used virt_to_head_page(), so could you say more about it?
>>>
>>>          struct page *page = virt_to_head_page(buf);
>>>
>>> Thanks.
>>>
>>>> That will result in unsynchronized buffers when SWIOTLB is enabled, for
>>>> example, when running as a TDX guest.
>>>>
>>>> This patch handles small and mergeable packets separately and fixes
>>>> the mismatched buffer address.
>>>>
>>>> Changes from v1: Use ctx to get xdp_headroom.
>>>>
>>>> Fixes: 295525e29a5b ("virtio_net: merge dma operations when filling
>> mergeable buffers")
>>>> Signed-off-by: Wenbo Li <liwenbo.martin@bytedance.com>
>>>> Signed-off-by: Jiahui Cen <cenjiahui@bytedance.com>
>>>> Signed-off-by: Ying Fang <fangying.tommy@bytedance.com>
>>>> ---
>>>>   drivers/net/virtio_net.c | 29 ++++++++++++++++++++++++++++-
>>>>   1 file changed, 28 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
>>>> index c6af18948..cbc3c0ae4 100644
>>>> --- a/drivers/net/virtio_net.c
>>>> +++ b/drivers/net/virtio_net.c
>>>> @@ -891,6 +891,23 @@ static void *virtnet_rq_get_buf(struct
>> receive_queue *rq, u32 *len, void **ctx)
>>>>        return buf;
>>>>   }
>>>>
>>>> +static void *virtnet_rq_get_buf_small(struct receive_queue *rq,
>>>> +                                   u32 *len,
>>>> +                                   void **ctx,
>>>> +                                   unsigned int header_offset)
>>>> +{
>>>> +     void *buf;
>>>> +     unsigned int xdp_headroom;
>>>> +
>>>> +     buf = virtqueue_get_buf_ctx(rq->vq, len, ctx);
>>>> +     if (buf) {
>>>> +             xdp_headroom = (unsigned long)*ctx;
>>>> +             virtnet_rq_unmap(rq, buf + VIRTNET_RX_PAD + xdp_headroom,
>> *len);
>>>> +     }
>>>> +
>>>> +     return buf;
>>>> +}
>>>> +
>>>>   static void virtnet_rq_init_one_sg(struct receive_queue *rq, void
>> *buf, u32 len)
>>>>   {
>>>>        struct virtnet_rq_dma *dma;
>>>> @@ -2692,13 +2709,23 @@ static int virtnet_receive_packets(struct
>> virtnet_info *vi,
>>>>        int packets = 0;
>>>>        void *buf;
>>>>
>>>> -     if (!vi->big_packets || vi->mergeable_rx_bufs) {
>>>> +     if (vi->mergeable_rx_bufs) {
>>>>                void *ctx;
>>>>                while (packets < budget &&
>>>>                       (buf = virtnet_rq_get_buf(rq, &len, &ctx))) {
>>>>                        receive_buf(vi, rq, buf, len, ctx, xdp_xmit,
>> stats);
>>>>                        packets++;
>>>>                }
>>>> +     } else if (!vi->big_packets) {
>>>> +             void *ctx;
>>>> +             unsigned int xdp_headroom = virtnet_get_headroom(vi);
>>>> +             unsigned int header_offset = VIRTNET_RX_PAD +
>> xdp_headroom;
>>>> +
>>>> +             while (packets < budget &&
>>>> +                    (buf = virtnet_rq_get_buf_small(rq, &len, &ctx,
>> header_offset))) {
>>>> +                     receive_buf(vi, rq, buf, len, ctx, xdp_xmit,
>> stats);
>>>> +                     packets++;
>>>> +             }
>>>>        } else {
>>>>                while (packets < budget &&
>>>>                       (buf = virtqueue_get_buf(rq->vq, &len)) != NULL) {
>>>> --
>>>> 2.20.1
>>>>
