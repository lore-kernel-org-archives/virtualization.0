Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A285C00A8F
	for <virtualization@archiver.kernel.org>; Tue, 24 Oct 2023 12:02:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C317060ABE;
	Tue, 24 Oct 2023 12:02:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C317060ABE
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=ce2YjTG5
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4Whto9ozbnqB; Tue, 24 Oct 2023 12:02:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 1F5D66006A;
	Tue, 24 Oct 2023 12:02:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1F5D66006A
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F1513C0071;
	Tue, 24 Oct 2023 12:02:46 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8F4A8C0032
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Oct 2023 12:02:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1B2056006A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Oct 2023 12:02:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1B2056006A
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sLTfphCLLDo4
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Oct 2023 12:02:43 +0000 (UTC)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 878246FBF2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Oct 2023 12:02:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 878246FBF2
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-9ba1eb73c27so690212866b.3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Oct 2023 05:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cloudflare.com; s=google09082023; t=1698148961; x=1698753761;
 darn=lists.linux-foundation.org; 
 h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
 :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
 bh=vUX3/J/qlNzLrWL3mFobCRPHJJns33eg8PeRo1zgZcc=;
 b=ce2YjTG5V+C0dtpOdv5Tub9p0Lbz8FlbuSs6ISJDb2mKbYvOdu+mW9ZfwriWTN4F8+
 IYTjUZIrNH/dTipHs+iYhyubPjsaxF5Oe8C8ta4Iu1tAfBsP1LJw6XCf0p5hjMeqIYiu
 q9jLI2FkW+vtOMf1fHm0tUraAu5MIx1rRL1K9/BQneYR8D9izkOFWdBf4XytOo1e3cyz
 k7cdBjf/wYQgWyA3jDFvqbZCTTMN1YqNA3ovy4aSsuxbSVLDR3uZzJmtPu5OmjX56qfr
 UMZTWh7MWhBsmQb91XWXPja6CgbyJ9yqKX7vhPbXQKu0vUtSH9RMYaLycXgvNeY8uVO0
 Ws2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698148961; x=1698753761;
 h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
 :user-agent:references:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vUX3/J/qlNzLrWL3mFobCRPHJJns33eg8PeRo1zgZcc=;
 b=no1sbHDzlvm+eWNmEk9+f0s0U+DU872N5trhrI2Dc6iU0NOwhgAQhCWfgnBUORF/Kw
 uO/Qzf2SEbOdTRiNpVQmC0g+vfxe/+54tF7v3rGuAMobrvfI2e8XsOjLF0qLc/4KhNnw
 7U9kMdXABdgTcKKwMBd3c1asR3wBPy51axoIhXLa/k3yhhcOxTslfbbZvTQo1WA6y4II
 glpErC+6rUW9zwEvxVCjBQdK0Ry/JKyaF6g+rXbQUlE9y1FXT+aXhHAcJ5EAKlvm2+dw
 8AnTQSVENuhoemUYYtz93yCfGdSz8at8UYIBrSgColrV4s69V97JTqEmrK8UoCdhowL3
 vFAA==
X-Gm-Message-State: AOJu0YxmO/wGBVTxtynWPkJ4mrRrC/LR0mriB6er58oSU5YopjV9VtK0
 qj06n72YCeKQUdb/3JFPhwYSJg==
X-Google-Smtp-Source: AGHT+IHQlQp6SYqGcwivXMQJdIDTmbhdyz84sLTrVeXzyLB/BwkNn6E/Xytz51NfRzcDQJk4SzIHUA==
X-Received: by 2002:a17:906:da84:b0:9a5:d657:47e1 with SMTP id
 xh4-20020a170906da8400b009a5d65747e1mr9250857ejb.43.1698148961496; 
 Tue, 24 Oct 2023 05:02:41 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5064:2dc::49:e9])
 by smtp.gmail.com with ESMTPSA id
 e6-20020a170906080600b009c70b392051sm8195883ejd.100.2023.10.24.05.02.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Oct 2023 05:02:40 -0700 (PDT)
References: <20231019101625.412936-1-jakub@cloudflare.com>
 <1697720122.49851-2-xuanzhuo@linux.alibaba.com>
 <87il6x2rj6.fsf@cloudflare.com>
 <1698114697.434748-1-xuanzhuo@linux.alibaba.com>
 <87edhk2z03.fsf@cloudflare.com>
 <1698144808.8577316-1-xuanzhuo@linux.alibaba.com>
 <87a5s82qig.fsf@cloudflare.com>
 <1698147983.0338666-1-xuanzhuo@linux.alibaba.com>
User-agent: mu4e 1.6.10; emacs 28.3
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH 1/2] virtio_pci: Don't make an extra copy of cpu
 affinity mask
Date: Tue, 24 Oct 2023 13:55:02 +0200
In-reply-to: <1698147983.0338666-1-xuanzhuo@linux.alibaba.com>
Message-ID: <875y2w2ppc.fsf@cloudflare.com>
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

On Tue, Oct 24, 2023 at 07:46 PM +08, Xuan Zhuo wrote:
> On Tue, 24 Oct 2023 13:26:49 +0200, Jakub Sitnicki <jakub@cloudflare.com> wrote:
>> On Tue, Oct 24, 2023 at 06:53 PM +08, Xuan Zhuo wrote:
>> > On Tue, 24 Oct 2023 10:17:19 +0200, Jakub Sitnicki <jakub@cloudflare.com> wrote:
>> >> On Tue, Oct 24, 2023 at 10:31 AM +08, Xuan Zhuo wrote:
>> >> > On Mon, 23 Oct 2023 18:52:45 +0200, Jakub Sitnicki <jakub@cloudflare.com> wrote:
>> >> >> On Thu, Oct 19, 2023 at 08:55 PM +08, Xuan Zhuo wrote:
>> >> >> > On Thu, 19 Oct 2023 12:16:24 +0200, Jakub Sitnicki <jakub@cloudflare.com> wrote:
>> >> >> >> Since commit 19e226e8cc5d ("virtio: Make vp_set_vq_affinity() take a
>> >> >> >> mask.") it is actually not needed to have a local copy of the cpu mask.
>> >> >> >
>> >> >> >
>> >> >> > Could you give more info to prove this?
>> >> >
>> >> >
>> >> > Actually, my question is that can we pass a val on the stack(or temp value) to
>> >> > the irq_set_affinity_hint()?
>> >> >
>> >> > Such as the virtio-net uses zalloc_cpumask_var to alloc a cpu_mask, and
>> >> > that will be released.
>> >> >
>> >> >
>> >> >
>> >> > 	int __irq_apply_affinity_hint(unsigned int irq, const struct cpumask *m,
>> >> > 				      bool setaffinity)
>> >> > 	{
>> >> > 		unsigned long flags;
>> >> > 		struct irq_desc *desc = irq_get_desc_lock(irq, &flags, IRQ_GET_DESC_CHECK_GLOBAL);
>> >> >
>> >> > 		if (!desc)
>> >> > 			return -EINVAL;
>> >> > ->		desc->affinity_hint = m;
>> >> > 		irq_put_desc_unlock(desc, flags);
>> >> > 		if (m && setaffinity)
>> >> > 			__irq_set_affinity(irq, m, false);
>> >> > 		return 0;
>> >> > 	}
>> >> > 	EXPORT_SYMBOL_GPL(__irq_apply_affinity_hint);
>> >> >
>> >> > The above code directly refers the mask pointer. If the mask is a temp value, I
>> >> > think that is a bug.
>> >>
>> >> You are completely right. irq_set_affinity_hint stores the mask pointer.
>> >> irq_affinity_hint_proc_show later dereferences it when user reads out
>> >> /proc/irq/*/affinity_hint.
>> >>
>> >> I have failed to notice that. That's why we need cpumask_copy to stay.
>> >>
>> >> My patch is buggy. Please disregard.
>> >>
>> >> I will send a v2 to only migrate from deprecated irq_set_affinity_hint.
>> >>
>> >> > And I notice that many places directly pass the temp value to this API.
>> >> > And I am a little confused. ^_^ Or I missed something.
>> >>
>> >> There seem two be two gropus of callers:
>> >>
>> >> 1. Those that use get_cpu_mask/cpumask_of/cpumask_of_node to produce a
>> >>    cpumask pointer which is a preallocated constant.
>> >>
>> >>    $ weggli 'irq_set_affinity_hint(_, $func(_));' ~/src/linux
>> >>
>> >> 2. Those that pass a pointer to memory somewhere.
>> >>
>> >>    $ weggli 'irq_set_affinity_hint(_, $mask);' ~/src/linux
>> >>
>> >> (weggli tool can be found at https://github.com/weggli-rs/weggli)
>> >>
>> >> I've looked over the callers from group #2 but I couldn't find any
>> >> passing a pointer memory on stack :-)
>> >
>> > Pls check stmmac_request_irq_multi_msi()
>>
>> Good catch. That one looks buggy.
>>
>> I should also checked for callers that take an address of a var/field:
>>
>>   $ weggli 'irq_set_affinity_hint(_, &$mask);' ~/src/linux
>
> Do you find more?

No, just the one you pointed out. Unless I missed something.

I ran an improved query. Shows everything but the non-interesting cases:

$ weggli '{
	NOT: irq_set_affinity_hint(_, NULL);
	NOT: irq_set_affinity_hint(_, get_cpu_mask(_));
	NOT: irq_set_affinity_hint(_, cpumask_of(_));
	irq_set_affinity_hint(_, _);
}' ~/src/linux

And repeated it for irq_set_affinity_and_hint and irq_update_affinity.

The calls where it was not obvious at first sight that we're passing a
pointer to some heap memory, turned out to use a temporary variable to
either store address to heap memory or return value from cpumask_of*().

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
