Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E184C77B7A
	for <virtualization@archiver.kernel.org>; Wed, 17 May 2023 08:38:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D45DD841EC;
	Wed, 17 May 2023 08:38:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D45DD841EC
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=TtyWNefn
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KKxlZFJTc-US; Wed, 17 May 2023 08:38:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 5C2B584131;
	Wed, 17 May 2023 08:38:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5C2B584131
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 31AFEC0037;
	Wed, 17 May 2023 08:38:04 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 894C7C002A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 May 2023 08:38:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4EC91400C8
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 May 2023 08:38:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4EC91400C8
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com
 header.a=rsa-sha256 header.s=google header.b=TtyWNefn
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tPv-dUQRsLGm
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 May 2023 08:38:01 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1635640124
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com
 [IPv6:2607:f8b0:4864:20::1034])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1635640124
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 May 2023 08:38:00 +0000 (UTC)
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-24e14a24c9dso493712a91.0
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 May 2023 01:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1684312680; x=1686904680;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/lS0VerKT/K5L5+mTBdB0d9Ml3aR+Xdun4CK+Oz2SxI=;
 b=TtyWNefnV49cwEOlKU8y2jD+mhN5zLQYPxbCTrObAYp/C192RW6uoewbVjaYQfg9yo
 i/yxj0UcotS7dAZ0cUxJpju9r9PSoW8N9SK9Qs6tAdHjtgYdO4hOoYb8eXdLhgtB/TkG
 I3TCiKLegp9VJ/F/+oLMaD3/7k3UUIliS1Wqm4UXeMOrD0ZMhZDF3ADvAn03ktJ9BQ81
 sbkq+yAqCmih3F0vxoOzpI4TYB3rtnCPrjAlbrhO7G8fxrmNRBDRB/1opljUYn6lCakP
 aVc8fi+PXGDb/FM9anQX24DlH/AO7MDJh20Pa4vKQHkP2EbLHAnB5RuC7EzAOMHLNSRy
 Sp9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684312680; x=1686904680;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/lS0VerKT/K5L5+mTBdB0d9Ml3aR+Xdun4CK+Oz2SxI=;
 b=foEHpJ+2LBGFbUljqG2kosZOpy1oW7U1BKUxyMI+7NtPNBDABkJtM4oNRnflufH3Zp
 ohnf1kerkXhY3d5ww7AWsVPnlN50TfjBCddfVYQ0tgBW/tw8WNNVoMB/g5G1uJiJkN1i
 B+nTtx5YWDMVajZGJsVpWl630+dZZR/CtDMYEi4G8aO4VpsuamDi/q8lJT37jl73Ti15
 5jqQDpijpBg5JroC956mgN/BcQf38N6ytDJOJ2TGXt4XJaipUXdj2zDSu6rcW9fxmrYg
 VfwdtB3j8hpHIfDHvxV8b27jO99hvbmbOUBIl1/jcY9/a5tGr5JRevqg2hviVsXDkwW2
 VIlg==
X-Gm-Message-State: AC+VfDw7Ev2qO2zwHi+Gzp5MkVa1Hs8/ogReqIuI07yLVvRYyNie3Jqi
 UgcslVHJzs7LvvkEKYsNOZ5MCw==
X-Google-Smtp-Source: ACHHUZ4BAUBHc0m+lbjNIyl3j50KkdyimAn6S9D1Z8XxzconpCTqA/x2z83kBTjmPp49D30NwUggRg==
X-Received: by 2002:a17:90a:dd88:b0:252:e7e2:fefe with SMTP id
 l8-20020a17090add8800b00252e7e2fefemr11945883pjv.2.1684312680236; 
 Wed, 17 May 2023 01:38:00 -0700 (PDT)
Received: from [10.3.43.196] ([61.213.176.7]) by smtp.gmail.com with ESMTPSA id
 f24-20020a17090ace1800b002405d3bbe42sm1030351pju.0.2023.05.17.01.37.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 May 2023 01:37:59 -0700 (PDT)
Message-ID: <cc9f3aea-b8bc-f312-41bb-3fd68083aa99@bytedance.com>
Date: Wed, 17 May 2023 16:35:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: Re: [PATCH v2 1/2] virtio: abstract virtqueue related methods
Content-Language: en-US
To: Christoph Hellwig <hch@infradead.org>
References: <20230517025424.601141-1-pizhenwei@bytedance.com>
 <20230517025424.601141-2-pizhenwei@bytedance.com>
 <ZGSEq197W8VvOWCc@infradead.org>
 <9e4702f2-5473-2139-3858-ae58817bc7b5@bytedance.com>
 <ZGSGQWqbtdwGXurf@infradead.org>
In-Reply-To: <ZGSGQWqbtdwGXurf@infradead.org>
Cc: xuanzhuo@linux.alibaba.com, mst@redhat.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, stefanha@redhat.com
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



On 5/17/23 15:46, Christoph Hellwig wrote:
> On Wed, May 17, 2023 at 03:43:03PM +0800, zhenwei pi wrote:
>> I have a plan to introduce 'Virtio Over Fabrics'(TCP&RDMA) as Virtio
>> transport, as mentioned in cover letter of this series:
>> 3 weeks ago, I posted a proposal 'Virtio Over Fabrics':
>> https://lists.oasis-open.org/archives/virtio-comment/202304/msg00442.html
> 
> Just don't do it.  Please define your own protocols over RDMA or TCP
> for exactly the operations you need (for many they will already exist)
> instead of piggyg backing on virtio and making everyone else pay the
> price.
> 

Hi

1, `virtqueue_add_inbuf` in current version:
static inline int virtqueue_add_inbuf(struct virtqueue *vq,
                                       struct scatterlist *sg,
                                       unsigned int num,
                                       void *data,
                                       gfp_t gfp)
{
         if (likely(!vq->abstract))
                 return vring_virtqueue_add_sgs(vq, &sg, num, 0, 1, 
data, NULL, gfp);

         return vq->add_sgs(vq, &sg, num, 0, 1, data, NULL, gfp);
}

And disassemble 'virtinput_queue_evtbuf':
static void virtinput_queue_evtbuf(struct virtio_input *vi,
                                    struct virtio_input_event *evtbuf)
{
         struct scatterlist sg[1];

         sg_init_one(sg, evtbuf, sizeof(*evtbuf));
         virtqueue_add_inbuf(vi->evt, sg, 1, evtbuf, GFP_ATOMIC);
}

I notice that two instructions are newly added for vring like:
  24d:   80 78 35 00             cmpb   $0x0,0x35(%rax)
  251:   75 3f                   jne    292

Is it an expensive price...

2, Storage/FS specific remote protocol is quite popular, otherwise I'm 
not familiar with other device protocols. For example, I need a remote 
crypto device to accelerate HTTPS ... With Virtio Over Fabrics, I have a 
chance to attach a virtio-crypto device to do this work.

-- 
zhenwei pi
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
