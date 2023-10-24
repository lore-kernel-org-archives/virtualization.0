Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FA89C00A8F
	for <virtualization@archiver.kernel.org>; Tue, 24 Oct 2023 11:45:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id EC1464314C;
	Tue, 24 Oct 2023 11:45:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org EC1464314C
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=RZ4gMGJi
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rg95f44nEbdz; Tue, 24 Oct 2023 11:45:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 13212414A1;
	Tue, 24 Oct 2023 11:45:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 13212414A1
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E8CA7C0071;
	Tue, 24 Oct 2023 11:45:18 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CC454C0032
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Oct 2023 11:45:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9886942EE1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Oct 2023 11:45:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9886942EE1
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id in5RaQFXAEOY
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Oct 2023 11:45:15 +0000 (UTC)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1E0C8414A1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Oct 2023 11:45:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1E0C8414A1
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-9c773ac9b15so559382766b.2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Oct 2023 04:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cloudflare.com; s=google09082023; t=1698147913; x=1698752713;
 darn=lists.linux-foundation.org; 
 h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
 :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
 bh=FCKEM37FEKxAp8yEqlco8GPnQf1xX5ZBdasFIuffA9g=;
 b=RZ4gMGJitRsVcOGDc4wlbu3Il9o/eHiTkU5BSQdlnQiI4yNXkeLBNG/JswsPDKVvsu
 b9DUcPWKGDoFPuvQ28y1B6VhDvIUwhZUex0AdViK/6B7lcgzmf+u81uKInPJptJbMIV+
 Q6yZNLnzOXDgBPrAuriGS0mRVz4RQxpKjby8oaHapiYQf4iyVV/kn0rCd4WO9e3eZV3l
 IZVUMRN/DLGy2asoBN6NekVKlluqSbwe3BH8OUxWk1eSYBTDdCFZQ0BGjqKftdEBfJkq
 UoDD11R67N5dYsd+2JV4amMVagZLHZCYix6i+JOM9c5YkapfL12WhMBvRdinMeJn7mmM
 40kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698147913; x=1698752713;
 h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
 :user-agent:references:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FCKEM37FEKxAp8yEqlco8GPnQf1xX5ZBdasFIuffA9g=;
 b=nOkH/l9ImLz1ST6Dkg01A403yCANv7bPfdzQFCsp/fDNTOWAeykhiFWKjDU3UIwMC/
 ykXx1IE0VKKx0fT4vMaqbZY6lbzmxgUjzfsQDBpjojqt+sIh/VMYEvvLQm3l4ersgW5W
 BrHY84QKmIM09RVt8FFnTHao67TKRW3OdHQaSZriseRsvofrraa0g8SVsTLwdPHvS9tV
 DmBeHlhPOac5m24VIK8iqfsx8lwAwGLRziuWDBdq/tcYFdS96CQLur0270ktOQT9Qrwe
 VyIUI4EmhzyUrWHUJKGvhi4SsofGlLk03DvQLLB/GsizJVBAmeGC1SklNh/oBx4HygnV
 Q7gw==
X-Gm-Message-State: AOJu0YwVgTHir7IhwmCSIqTsWvzVQ4qOqe/WLW9wprAXX3U1gn0XPWFi
 +9Z0CU6GkXhX0GdgqdO1Zk2bdg==
X-Google-Smtp-Source: AGHT+IFUueyAdpQ6doppKxn1Ji8Dk8R6RwdnkhbK2rxReEs2hdalFEjCHuZM5oO7Y3ivYfpkSrV6qg==
X-Received: by 2002:a17:907:841:b0:9be:16ba:19ab with SMTP id
 ww1-20020a170907084100b009be16ba19abmr8865005ejb.29.1698147913081; 
 Tue, 24 Oct 2023 04:45:13 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5064:2dc::49:e9])
 by smtp.gmail.com with ESMTPSA id
 d13-20020a1709064c4d00b009a5f1d15642sm8070595ejw.158.2023.10.24.04.45.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Oct 2023 04:45:12 -0700 (PDT)
References: <20231019101625.412936-1-jakub@cloudflare.com>
 <1697720122.49851-2-xuanzhuo@linux.alibaba.com>
 <87il6x2rj6.fsf@cloudflare.com>
 <1698114697.434748-1-xuanzhuo@linux.alibaba.com>
 <87edhk2z03.fsf@cloudflare.com>
 <1698144808.8577316-1-xuanzhuo@linux.alibaba.com>
User-agent: mu4e 1.6.10; emacs 28.3
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH 1/2] virtio_pci: Don't make an extra copy of cpu
 affinity mask
Date: Tue, 24 Oct 2023 13:26:49 +0200
In-reply-to: <1698144808.8577316-1-xuanzhuo@linux.alibaba.com>
Message-ID: <87a5s82qig.fsf@cloudflare.com>
MIME-Version: 1.0
Cc: Caleb Raitto <caraitto@google.com>, kernel-team@cloudflare.com,
 "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org
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
From: Jakub Sitnicki via Virtualization
 <virtualization@lists.linux-foundation.org>
Reply-To: Jakub Sitnicki <jakub@cloudflare.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Tue, Oct 24, 2023 at 06:53 PM +08, Xuan Zhuo wrote:
> On Tue, 24 Oct 2023 10:17:19 +0200, Jakub Sitnicki <jakub@cloudflare.com> wrote:
>> On Tue, Oct 24, 2023 at 10:31 AM +08, Xuan Zhuo wrote:
>> > On Mon, 23 Oct 2023 18:52:45 +0200, Jakub Sitnicki <jakub@cloudflare.com> wrote:
>> >> On Thu, Oct 19, 2023 at 08:55 PM +08, Xuan Zhuo wrote:
>> >> > On Thu, 19 Oct 2023 12:16:24 +0200, Jakub Sitnicki <jakub@cloudflare.com> wrote:
>> >> >> Since commit 19e226e8cc5d ("virtio: Make vp_set_vq_affinity() take a
>> >> >> mask.") it is actually not needed to have a local copy of the cpu mask.
>> >> >
>> >> >
>> >> > Could you give more info to prove this?
>> >
>> >
>> > Actually, my question is that can we pass a val on the stack(or temp value) to
>> > the irq_set_affinity_hint()?
>> >
>> > Such as the virtio-net uses zalloc_cpumask_var to alloc a cpu_mask, and
>> > that will be released.
>> >
>> >
>> >
>> > 	int __irq_apply_affinity_hint(unsigned int irq, const struct cpumask *m,
>> > 				      bool setaffinity)
>> > 	{
>> > 		unsigned long flags;
>> > 		struct irq_desc *desc = irq_get_desc_lock(irq, &flags, IRQ_GET_DESC_CHECK_GLOBAL);
>> >
>> > 		if (!desc)
>> > 			return -EINVAL;
>> > ->		desc->affinity_hint = m;
>> > 		irq_put_desc_unlock(desc, flags);
>> > 		if (m && setaffinity)
>> > 			__irq_set_affinity(irq, m, false);
>> > 		return 0;
>> > 	}
>> > 	EXPORT_SYMBOL_GPL(__irq_apply_affinity_hint);
>> >
>> > The above code directly refers the mask pointer. If the mask is a temp value, I
>> > think that is a bug.
>>
>> You are completely right. irq_set_affinity_hint stores the mask pointer.
>> irq_affinity_hint_proc_show later dereferences it when user reads out
>> /proc/irq/*/affinity_hint.
>>
>> I have failed to notice that. That's why we need cpumask_copy to stay.
>>
>> My patch is buggy. Please disregard.
>>
>> I will send a v2 to only migrate from deprecated irq_set_affinity_hint.
>>
>> > And I notice that many places directly pass the temp value to this API.
>> > And I am a little confused. ^_^ Or I missed something.
>>
>> There seem two be two gropus of callers:
>>
>> 1. Those that use get_cpu_mask/cpumask_of/cpumask_of_node to produce a
>>    cpumask pointer which is a preallocated constant.
>>
>>    $ weggli 'irq_set_affinity_hint(_, $func(_));' ~/src/linux
>>
>> 2. Those that pass a pointer to memory somewhere.
>>
>>    $ weggli 'irq_set_affinity_hint(_, $mask);' ~/src/linux
>>
>> (weggli tool can be found at https://github.com/weggli-rs/weggli)
>>
>> I've looked over the callers from group #2 but I couldn't find any
>> passing a pointer memory on stack :-)
>
> Pls check stmmac_request_irq_multi_msi()

Good catch. That one looks buggy.

I should also checked for callers that take an address of a var/field:

  $ weggli 'irq_set_affinity_hint(_, &$mask);' ~/src/linux
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
