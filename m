Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BE3FC7EE22
	for <virtualization@archiver.kernel.org>; Thu, 18 May 2023 11:03:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 99AB242890;
	Thu, 18 May 2023 11:03:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 99AB242890
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=L/z29TYp
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MVMUJmjOqldy; Thu, 18 May 2023 11:03:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id B2C82428A3;
	Thu, 18 May 2023 11:03:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B2C82428A3
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6FB37C0035;
	Thu, 18 May 2023 11:03:49 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EE077C002A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 May 2023 11:03:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id CEF9381FDA
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 May 2023 11:03:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CEF9381FDA
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com
 header.a=rsa-sha256 header.s=google header.b=L/z29TYp
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id C81Kodg_v9Jt
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 May 2023 11:03:46 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7AD9381FBA
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com
 [IPv6:2607:f8b0:4864:20::633])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7AD9381FBA
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 May 2023 11:03:46 +0000 (UTC)
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1ae557aaf1dso15293645ad.2
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 May 2023 04:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1684407826; x=1686999826;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=L8wUobxEGLI2p/DjIP+xJqCqQPQ2167f6CpUfP5l0e4=;
 b=L/z29TYptPB+dKSNb3mEL33qDf2zvq+L0/3Z2CVEjBTqugDsEWs4MwCo5ccH0uwpL2
 AvGAMh7gnwX3UthjGXJv4Cg8sPuRyiIteL58u2eUEKt8LTGjf0Afwk/DmajdKGxekkoU
 KYUZWBlXieZm0Pi8ecFqz2JfXx46KJUIGMbpDXk8FcYGg2OzUUrnv3s7Vb/DtuWYrhhm
 CBEnpAB563A60MUjfailaf0/PpGx3yHkXNXQSQSVj9op61WUVu7XgfOqWYbc7N5oCXCl
 kqRmWgC1aglb0CFUUG+hapCkb8YOtKlcOoyyDnM2rBjdev+O/LWdwDhH9N6t/OOENpdk
 CKXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684407826; x=1686999826;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=L8wUobxEGLI2p/DjIP+xJqCqQPQ2167f6CpUfP5l0e4=;
 b=Xz8a4H54eIoWkTK7JDWNP3Reu5P2G0ByGtrSCcfqPssRovta61vDRqL4EnAx9nt51I
 Rh7sRPHKHgxFAuh1IdY8DOxC/VL7P3SEgk/k2AUMHXxvKPAQJ1roPUC888nId2xhEP7o
 v75SRa8ZNkj6qqpuvq+MnbjmSSmwVWbi14antnVKytUZ0qeS8XxKVwtDpoCPZ6WEKQ37
 B5k6TEg5hz3GYHhcdhWdCGmNyN7J6QEj9VaQAmpvmXXyJe7N9ainWSpQMMQ0+4aTsm1i
 NcSk8gUwFOo821k6zBJbPUl+qivkTJ+eelHsq71lg8Tvaal/Gzrzx21fXLuf0S/f72cI
 GZNg==
X-Gm-Message-State: AC+VfDw7EfIoTxh16eNM7leZ8sGBilo0/7wx8aZUbPegUyOWVvP6YIIC
 2Q/BUjeWDclQgJd+Oln5cOLcpA==
X-Google-Smtp-Source: ACHHUZ6qEky0lbIh7SGpL1S6SNPIGEpyyuqz6caX9PGmjpQo/xjkVek+4gHTCYfNOHYvwcR5n+qSlg==
X-Received: by 2002:a17:903:1205:b0:1ae:14d:8d0a with SMTP id
 l5-20020a170903120500b001ae014d8d0amr2459581plh.29.1684407825895; 
 Thu, 18 May 2023 04:03:45 -0700 (PDT)
Received: from [10.3.43.196] ([61.213.176.8]) by smtp.gmail.com with ESMTPSA id
 h8-20020a170902ac8800b001a194df5a58sm1141310plr.167.2023.05.18.04.03.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 May 2023 04:03:45 -0700 (PDT)
Message-ID: <f16b8f56-8890-a4ae-0108-ff5667350fbc@bytedance.com>
Date: Thu, 18 May 2023 19:01:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: Re: Re: Re: [PATCH v2 1/2] virtio: abstract virtqueue related
 methods
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20230517025424.601141-1-pizhenwei@bytedance.com>
 <20230517025424.601141-2-pizhenwei@bytedance.com>
 <ZGSEq197W8VvOWCc@infradead.org>
 <9e4702f2-5473-2139-3858-ae58817bc7b5@bytedance.com>
 <ZGSGQWqbtdwGXurf@infradead.org>
 <cc9f3aea-b8bc-f312-41bb-3fd68083aa99@bytedance.com>
 <20230517062401-mutt-send-email-mst@kernel.org>
 <ee2a975f-0aa6-a46a-e9d2-7f82e313347f@bytedance.com>
 <20230518060656-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230518060656-mutt-send-email-mst@kernel.org>
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



On 5/18/23 18:09, Michael S. Tsirkin wrote:
> On Thu, May 18, 2023 at 08:47:22AM +0800, zhenwei pi wrote:
>> On 5/17/23 18:39, Michael S. Tsirkin wrote:
>>> On Wed, May 17, 2023 at 04:35:55PM +0800, zhenwei pi wrote:
>>>>
>>>>
>>>> On 5/17/23 15:46, Christoph Hellwig wrote:
>>>>> On Wed, May 17, 2023 at 03:43:03PM +0800, zhenwei pi wrote:
>>>>>> I have a plan to introduce 'Virtio Over Fabrics'(TCP&RDMA) as Virtio
>>>>>> transport, as mentioned in cover letter of this series:
>>>>>> 3 weeks ago, I posted a proposal 'Virtio Over Fabrics':
>>>>>> https://lists.oasis-open.org/archives/virtio-comment/202304/msg00442.html
>>>>>
>>>>> Just don't do it.  Please define your own protocols over RDMA or TCP
>>>>> for exactly the operations you need (for many they will already exist)
>>>>> instead of piggyg backing on virtio and making everyone else pay the
>>>>> price.
>>>>>
>>>>
>>>> Hi
>>>>
>>>> 1, `virtqueue_add_inbuf` in current version:
>>>> static inline int virtqueue_add_inbuf(struct virtqueue *vq,
>>>>                                         struct scatterlist *sg,
>>>>                                         unsigned int num,
>>>>                                         void *data,
>>>>                                         gfp_t gfp)
>>>> {
>>>>           if (likely(!vq->abstract))
>>>>                   return vring_virtqueue_add_sgs(vq, &sg, num, 0, 1, data,
>>>> NULL, gfp);
>>>>
>>>>           return vq->add_sgs(vq, &sg, num, 0, 1, data, NULL, gfp);
>>>> }
>>>>
>>>> And disassemble 'virtinput_queue_evtbuf':
>>>> static void virtinput_queue_evtbuf(struct virtio_input *vi,
>>>>                                      struct virtio_input_event *evtbuf)
>>>> {
>>>>           struct scatterlist sg[1];
>>>>
>>>>           sg_init_one(sg, evtbuf, sizeof(*evtbuf));
>>>>           virtqueue_add_inbuf(vi->evt, sg, 1, evtbuf, GFP_ATOMIC);
>>>> }
>>>>
>>>> I notice that two instructions are newly added for vring like:
>>>>    24d:   80 78 35 00             cmpb   $0x0,0x35(%rax)
>>>>    251:   75 3f                   jne    292
>>>>
>>>> Is it an expensive price...
>>>
>>> Can we somehow only override the kick method?
>>> Then take the ring and send it over ...
>>>
>>
>> Could you please take a look at this code?
>> https://github.com/pizhenwei/linux/blob/virtio-of-github/drivers/virtio/virtio_fabrics.c#LL861C13-L861C23
> 
> what am I looking at here?
> 
> Looks like at least vof_handle_vq duplicates some code from vringh.
> But besides that yes, that's the idea.
> 

OK, I'd drop this series.

Cc Jason & Stefan.


-- 
zhenwei pi
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
