Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBB29C7EE22
	for <virtualization@archiver.kernel.org>; Thu, 18 May 2023 00:49:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 64D69417D7;
	Thu, 18 May 2023 00:49:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 64D69417D7
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=irwx18AO
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ayJkHWZZksBy; Thu, 18 May 2023 00:49:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id C580540184;
	Thu, 18 May 2023 00:49:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C580540184
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 962F7C0037;
	Thu, 18 May 2023 00:49:30 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EC0FDC002A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 May 2023 00:49:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C6E5383F6F
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 May 2023 00:49:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C6E5383F6F
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com
 header.a=rsa-sha256 header.s=google header.b=irwx18AO
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QtHvbXxVy1Fj
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 May 2023 00:49:28 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 26B9681ADE
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com
 [IPv6:2607:f8b0:4864:20::102a])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 26B9681ADE
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 May 2023 00:49:27 +0000 (UTC)
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-24e14a24c9dso1239779a91.0
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 May 2023 17:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1684370967; x=1686962967;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dqs7e96VU7euNkbUd3s38dZfeIV90lulRcNptau9itQ=;
 b=irwx18AOoF/WaB2RJXI4aW0f4cVD7vyPi88o/Ve/dBK44+gMFtKbbHTz1kJvpJA39y
 2CJ1PEfUM6p046OXGOCCIV97F0hUKMFoc4z/Lj7lTPTTFa7lBPzH9cg3wHkQLL+S3zHG
 wI/xw+foLnsPBAa3MizYsUCx26R2G2JkzgKCzKLQUS1dmGnF0rVFnLzyau9ManMlblEL
 vonF9cmbgmHm3FuJcNiV2dshj4qXxG4ZfmWNZ87R69R05FDlqb3VZP1Tp0uRZKKqOF+X
 k2Rj8of2C1CuoD2t9s06R/MucCebbqFJp7u2bdjRCzgqYXe5YNFa0q0Efb0vE16Zp+Oz
 z1CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684370967; x=1686962967;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dqs7e96VU7euNkbUd3s38dZfeIV90lulRcNptau9itQ=;
 b=W7dxHksXRzU6VMrvlbwx1kZrerS/1YpsofWmdRFlk3B6GESGqbv0lJ0K6CTDWfhEU2
 bCZg8r7dLVQA5YFBlYQsfoYHXSrmhinwQ1YRx02McnQOl7Up37Al6AeE+12/h6YwhJzX
 VAhiF76x90DiJYuBhMlXtqmhD65Hp2wg7vxSvTRpf4oUIjWbs+8kusqXUhlpzuriENNh
 gzgEebFYqq5Y8AYOjvdaQg3m1QF54Q8nWJ9VP5kfiwX6F8OPU9PRf+djIjgy3U7Z7Dd2
 nFSF3xuCPA32pXOzsAVSgdqsu7rXhSAXOZFyPhyDVB5yi94679kI4ZWg41Jt47+lwmKc
 kggA==
X-Gm-Message-State: AC+VfDwgf/91J3x4TNrW5tqC3wrcPBA+gKxMqcbSRg8zpm/1ISLxUyWF
 1hSSJMuvP2TBTKYmw01IVGyj2w==
X-Google-Smtp-Source: ACHHUZ4dyrTdh4NiyhPjMeXGqf9rfFoVdnVDL1MwIvXHP9SyWPw1WqHnaVnEtF4CgJ265mMVBHLL8A==
X-Received: by 2002:a17:902:b598:b0:1ad:f26e:3a2e with SMTP id
 a24-20020a170902b59800b001adf26e3a2emr594531pls.50.1684370967323; 
 Wed, 17 May 2023 17:49:27 -0700 (PDT)
Received: from [10.3.43.196] ([61.213.176.13])
 by smtp.gmail.com with ESMTPSA id
 x2-20020a170902ea8200b001ae365072ccsm3936plb.122.2023.05.17.17.49.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 May 2023 17:49:26 -0700 (PDT)
Message-ID: <ee2a975f-0aa6-a46a-e9d2-7f82e313347f@bytedance.com>
Date: Thu, 18 May 2023 08:47:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: Re: Re: [PATCH v2 1/2] virtio: abstract virtqueue related methods
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20230517025424.601141-1-pizhenwei@bytedance.com>
 <20230517025424.601141-2-pizhenwei@bytedance.com>
 <ZGSEq197W8VvOWCc@infradead.org>
 <9e4702f2-5473-2139-3858-ae58817bc7b5@bytedance.com>
 <ZGSGQWqbtdwGXurf@infradead.org>
 <cc9f3aea-b8bc-f312-41bb-3fd68083aa99@bytedance.com>
 <20230517062401-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230517062401-mutt-send-email-mst@kernel.org>
Cc: xuanzhuo@linux.alibaba.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 Christoph Hellwig <hch@infradead.org>, stefanha@redhat.com
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

On 5/17/23 18:39, Michael S. Tsirkin wrote:
> On Wed, May 17, 2023 at 04:35:55PM +0800, zhenwei pi wrote:
>>
>>
>> On 5/17/23 15:46, Christoph Hellwig wrote:
>>> On Wed, May 17, 2023 at 03:43:03PM +0800, zhenwei pi wrote:
>>>> I have a plan to introduce 'Virtio Over Fabrics'(TCP&RDMA) as Virtio
>>>> transport, as mentioned in cover letter of this series:
>>>> 3 weeks ago, I posted a proposal 'Virtio Over Fabrics':
>>>> https://lists.oasis-open.org/archives/virtio-comment/202304/msg00442.html
>>>
>>> Just don't do it.  Please define your own protocols over RDMA or TCP
>>> for exactly the operations you need (for many they will already exist)
>>> instead of piggyg backing on virtio and making everyone else pay the
>>> price.
>>>
>>
>> Hi
>>
>> 1, `virtqueue_add_inbuf` in current version:
>> static inline int virtqueue_add_inbuf(struct virtqueue *vq,
>>                                        struct scatterlist *sg,
>>                                        unsigned int num,
>>                                        void *data,
>>                                        gfp_t gfp)
>> {
>>          if (likely(!vq->abstract))
>>                  return vring_virtqueue_add_sgs(vq, &sg, num, 0, 1, data,
>> NULL, gfp);
>>
>>          return vq->add_sgs(vq, &sg, num, 0, 1, data, NULL, gfp);
>> }
>>
>> And disassemble 'virtinput_queue_evtbuf':
>> static void virtinput_queue_evtbuf(struct virtio_input *vi,
>>                                     struct virtio_input_event *evtbuf)
>> {
>>          struct scatterlist sg[1];
>>
>>          sg_init_one(sg, evtbuf, sizeof(*evtbuf));
>>          virtqueue_add_inbuf(vi->evt, sg, 1, evtbuf, GFP_ATOMIC);
>> }
>>
>> I notice that two instructions are newly added for vring like:
>>   24d:   80 78 35 00             cmpb   $0x0,0x35(%rax)
>>   251:   75 3f                   jne    292
>>
>> Is it an expensive price...
> 
> Can we somehow only override the kick method?
> Then take the ring and send it over ...
> 

Could you please take a look at this code?
https://github.com/pizhenwei/linux/blob/virtio-of-github/drivers/virtio/virtio_fabrics.c#LL861C13-L861C23

> 
>> 2, Storage/FS specific remote protocol is quite popular, otherwise I'm not
>> familiar with other device protocols. For example, I need a remote crypto
>> device to accelerate HTTPS ... With Virtio Over Fabrics, I have a chance to
>> attach a virtio-crypto device to do this work.
>>
>> -- 
>> zhenwei pi
> 

-- 
zhenwei pi
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
