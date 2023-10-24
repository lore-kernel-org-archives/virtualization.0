Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B917CC00A8F
	for <virtualization@archiver.kernel.org>; Tue, 24 Oct 2023 11:47:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6932C4ED1E;
	Tue, 24 Oct 2023 11:47:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6932C4ED1E
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6MKb9k0VNxvj; Tue, 24 Oct 2023 11:47:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 7CAD44EC14;
	Tue, 24 Oct 2023 11:47:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7CAD44EC14
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5145AC0071;
	Tue, 24 Oct 2023 11:47:29 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1BCAAC0032
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Oct 2023 11:47:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id DE9464EC40
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Oct 2023 11:47:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org DE9464EC40
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KQPNU8vUSk3H
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Oct 2023 11:47:26 +0000 (UTC)
Received: from out30-100.freemail.mail.aliyun.com
 (out30-100.freemail.mail.aliyun.com [115.124.30.100])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2DDEE4EC14
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Oct 2023 11:47:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2DDEE4EC14
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R171e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018045176;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=7; SR=0;
 TI=SMTPD_---0VuqJKun_1698148004; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0VuqJKun_1698148004) by smtp.aliyun-inc.com;
 Tue, 24 Oct 2023 19:46:45 +0800
Message-ID: <1698147983.0338666-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH 1/2] virtio_pci: Don't make an extra copy of cpu affinity
 mask
Date: Tue, 24 Oct 2023 19:46:23 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jakub Sitnicki <jakub@cloudflare.com>
References: <20231019101625.412936-1-jakub@cloudflare.com>
 <1697720122.49851-2-xuanzhuo@linux.alibaba.com>
 <87il6x2rj6.fsf@cloudflare.com>
 <1698114697.434748-1-xuanzhuo@linux.alibaba.com>
 <87edhk2z03.fsf@cloudflare.com>
 <1698144808.8577316-1-xuanzhuo@linux.alibaba.com>
 <87a5s82qig.fsf@cloudflare.com>
In-Reply-To: <87a5s82qig.fsf@cloudflare.com>
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Tue, 24 Oct 2023 13:26:49 +0200, Jakub Sitnicki <jakub@cloudflare.com> wrote:
> On Tue, Oct 24, 2023 at 06:53 PM +08, Xuan Zhuo wrote:
> > On Tue, 24 Oct 2023 10:17:19 +0200, Jakub Sitnicki <jakub@cloudflare.com> wrote:
> >> On Tue, Oct 24, 2023 at 10:31 AM +08, Xuan Zhuo wrote:
> >> > On Mon, 23 Oct 2023 18:52:45 +0200, Jakub Sitnicki <jakub@cloudflare.com> wrote:
> >> >> On Thu, Oct 19, 2023 at 08:55 PM +08, Xuan Zhuo wrote:
> >> >> > On Thu, 19 Oct 2023 12:16:24 +0200, Jakub Sitnicki <jakub@cloudflare.com> wrote:
> >> >> >> Since commit 19e226e8cc5d ("virtio: Make vp_set_vq_affinity() take a
> >> >> >> mask.") it is actually not needed to have a local copy of the cpu mask.
> >> >> >
> >> >> >
> >> >> > Could you give more info to prove this?
> >> >
> >> >
> >> > Actually, my question is that can we pass a val on the stack(or temp value) to
> >> > the irq_set_affinity_hint()?
> >> >
> >> > Such as the virtio-net uses zalloc_cpumask_var to alloc a cpu_mask, and
> >> > that will be released.
> >> >
> >> >
> >> >
> >> > 	int __irq_apply_affinity_hint(unsigned int irq, const struct cpumask *m,
> >> > 				      bool setaffinity)
> >> > 	{
> >> > 		unsigned long flags;
> >> > 		struct irq_desc *desc = irq_get_desc_lock(irq, &flags, IRQ_GET_DESC_CHECK_GLOBAL);
> >> >
> >> > 		if (!desc)
> >> > 			return -EINVAL;
> >> > ->		desc->affinity_hint = m;
> >> > 		irq_put_desc_unlock(desc, flags);
> >> > 		if (m && setaffinity)
> >> > 			__irq_set_affinity(irq, m, false);
> >> > 		return 0;
> >> > 	}
> >> > 	EXPORT_SYMBOL_GPL(__irq_apply_affinity_hint);
> >> >
> >> > The above code directly refers the mask pointer. If the mask is a temp value, I
> >> > think that is a bug.
> >>
> >> You are completely right. irq_set_affinity_hint stores the mask pointer.
> >> irq_affinity_hint_proc_show later dereferences it when user reads out
> >> /proc/irq/*/affinity_hint.
> >>
> >> I have failed to notice that. That's why we need cpumask_copy to stay.
> >>
> >> My patch is buggy. Please disregard.
> >>
> >> I will send a v2 to only migrate from deprecated irq_set_affinity_hint.
> >>
> >> > And I notice that many places directly pass the temp value to this API.
> >> > And I am a little confused. ^_^ Or I missed something.
> >>
> >> There seem two be two gropus of callers:
> >>
> >> 1. Those that use get_cpu_mask/cpumask_of/cpumask_of_node to produce a
> >>    cpumask pointer which is a preallocated constant.
> >>
> >>    $ weggli 'irq_set_affinity_hint(_, $func(_));' ~/src/linux
> >>
> >> 2. Those that pass a pointer to memory somewhere.
> >>
> >>    $ weggli 'irq_set_affinity_hint(_, $mask);' ~/src/linux
> >>
> >> (weggli tool can be found at https://github.com/weggli-rs/weggli)
> >>
> >> I've looked over the callers from group #2 but I couldn't find any
> >> passing a pointer memory on stack :-)
> >
> > Pls check stmmac_request_irq_multi_msi()
>
> Good catch. That one looks buggy.
>
> I should also checked for callers that take an address of a var/field:
>
>   $ weggli 'irq_set_affinity_hint(_, &$mask);' ~/src/linux

Do you find more?

Thanks.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
