Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10F2DC00A8F
	for <virtualization@archiver.kernel.org>; Tue, 24 Oct 2023 08:41:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A09D14EB99;
	Tue, 24 Oct 2023 08:41:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A09D14EB99
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=eI5ZJGpe
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6oDoW1DB6ds2; Tue, 24 Oct 2023 08:41:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id E72614EA77;
	Tue, 24 Oct 2023 08:41:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E72614EA77
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A4820C0039;
	Tue, 24 Oct 2023 08:41:56 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 78E54C0032
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Oct 2023 08:41:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 502444EB79
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Oct 2023 08:41:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 502444EB79
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ojHhTIa5F-HZ
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Oct 2023 08:41:52 +0000 (UTC)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 413974EA77
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Oct 2023 08:41:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 413974EA77
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-53dd752685fso6485642a12.3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Oct 2023 01:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cloudflare.com; s=google09082023; t=1698136910; x=1698741710;
 darn=lists.linux-foundation.org; 
 h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
 :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
 bh=C8xvYkCmZq71kHKyYg3Cr3ZgYB4uayEvhz+bKkQ5m20=;
 b=eI5ZJGpe2ljZQMi2q2a/EfkMZ6KaZCCfa/3pQLd6TQZpt0Gr4AC0bfpmN6MHbM47K0
 1tiYS/v9WrmlolSIYWENaep8ZtqgYppZVhIOfcfD0f3AS4M2Iq0Aia998JjIHtnmLxr4
 V2m9TRLV+xtJBjt7y5ZBwaZk5JNLH1AmA+pkmO2wpZOkqTRq/zqD6aM4fTE7cAzUWXkA
 ADc0ljQXdoifssNZa1XFxMvhGhB/nXjKS4MAl3kLc7te/P4/U+/8pOt7mbTjju1LIKlK
 W7uJe1IZNWJJ6KXq/6qy9tCW3ikPh9tuqd3JnBxq2kdorssRb/uQsiNHOJh7Wmk0QWyv
 xd6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698136910; x=1698741710;
 h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
 :user-agent:references:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=C8xvYkCmZq71kHKyYg3Cr3ZgYB4uayEvhz+bKkQ5m20=;
 b=V84K5x7SFe9HGlUPO7VVT6XIku7DODDYYKQqFgIvUKP6k4vkH+GJ7jycYAHZEE56+0
 Az4B53x8DpKE99Jjrq5vfTnFiA2hdQlfpwTPCM3B9eDxjMFkLwDiYwIxunJdX8ilicmZ
 Vj8WRRkKuVj+Lbw8Xn6ET4IHaWaYum+uVUdFahIzp4JywE48ZGEM1PNqqZ6HW71ro/Gc
 8L/7xOembQ1PwiXTgrldHPu2cgoQyk2ms7nhVrbvZX6nsL35Tfwjb/T9VZb/e7YuRwi+
 JbxegtFDjs6l8kXfBRshy7yZNHLDGjxoTevVLHffJy9qx5F+gf/Wt79+YdpfCOLYEdOC
 ROAw==
X-Gm-Message-State: AOJu0YwSTEKSvBwNDlJvD7R6S0RpNVbhDY46pr5koxysaD8xg/tW+VCf
 vkpCm5DAMPSBT6ljZCKcpbui1Q==
X-Google-Smtp-Source: AGHT+IHtw+iPFosKDroEJ1nbhV/VjCXM79Rhv9j65atjsILQTwGUacYmMeR1TiFi+DRbxlo0l8nW+A==
X-Received: by 2002:a17:907:320a:b0:9ad:e4e1:1476 with SMTP id
 xg10-20020a170907320a00b009ade4e11476mr7191910ejb.77.1698136910181; 
 Tue, 24 Oct 2023 01:41:50 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5064:2dc::49:e9])
 by smtp.gmail.com with ESMTPSA id
 t7-20020a1709066bc700b009b9f87b34b6sm7864739ejs.189.2023.10.24.01.41.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Oct 2023 01:41:49 -0700 (PDT)
References: <20231019101625.412936-1-jakub@cloudflare.com>
 <1697720122.49851-2-xuanzhuo@linux.alibaba.com>
 <87il6x2rj6.fsf@cloudflare.com>
 <1698114697.434748-1-xuanzhuo@linux.alibaba.com>
User-agent: mu4e 1.6.10; emacs 28.3
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH 1/2] virtio_pci: Don't make an extra copy of cpu
 affinity mask
Date: Tue, 24 Oct 2023 10:17:19 +0200
In-reply-to: <1698114697.434748-1-xuanzhuo@linux.alibaba.com>
Message-ID: <87edhk2z03.fsf@cloudflare.com>
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

On Tue, Oct 24, 2023 at 10:31 AM +08, Xuan Zhuo wrote:
> On Mon, 23 Oct 2023 18:52:45 +0200, Jakub Sitnicki <jakub@cloudflare.com> wrote:
>> On Thu, Oct 19, 2023 at 08:55 PM +08, Xuan Zhuo wrote:
>> > On Thu, 19 Oct 2023 12:16:24 +0200, Jakub Sitnicki <jakub@cloudflare.com> wrote:
>> >> Since commit 19e226e8cc5d ("virtio: Make vp_set_vq_affinity() take a
>> >> mask.") it is actually not needed to have a local copy of the cpu mask.
>> >
>> >
>> > Could you give more info to prove this?
>
>
> Actually, my question is that can we pass a val on the stack(or temp value) to
> the irq_set_affinity_hint()?
>
> Such as the virtio-net uses zalloc_cpumask_var to alloc a cpu_mask, and
> that will be released.
>
>
>
> 	int __irq_apply_affinity_hint(unsigned int irq, const struct cpumask *m,
> 				      bool setaffinity)
> 	{
> 		unsigned long flags;
> 		struct irq_desc *desc = irq_get_desc_lock(irq, &flags, IRQ_GET_DESC_CHECK_GLOBAL);
>
> 		if (!desc)
> 			return -EINVAL;
> ->		desc->affinity_hint = m;
> 		irq_put_desc_unlock(desc, flags);
> 		if (m && setaffinity)
> 			__irq_set_affinity(irq, m, false);
> 		return 0;
> 	}
> 	EXPORT_SYMBOL_GPL(__irq_apply_affinity_hint);
>
> The above code directly refers the mask pointer. If the mask is a temp value, I
> think that is a bug.

You are completely right. irq_set_affinity_hint stores the mask pointer.
irq_affinity_hint_proc_show later dereferences it when user reads out
/proc/irq/*/affinity_hint.

I have failed to notice that. That's why we need cpumask_copy to stay.

My patch is buggy. Please disregard.

I will send a v2 to only migrate from deprecated irq_set_affinity_hint.

> And I notice that many places directly pass the temp value to this API.
> And I am a little confused. ^_^ Or I missed something.

There seem two be two gropus of callers:

1. Those that use get_cpu_mask/cpumask_of/cpumask_of_node to produce a
   cpumask pointer which is a preallocated constant.

   $ weggli 'irq_set_affinity_hint(_, $func(_));' ~/src/linux

2. Those that pass a pointer to memory somewhere.

   $ weggli 'irq_set_affinity_hint(_, $mask);' ~/src/linux

(weggli tool can be found at https://github.com/weggli-rs/weggli)

I've looked over the callers from group #2 but I couldn't find any
passing a pointer memory on stack :-)

Thanks for pointing this out.

[...]
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
