Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C48D1C00A8F
	for <virtualization@archiver.kernel.org>; Tue, 24 Oct 2023 02:44:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3C3D783E06;
	Tue, 24 Oct 2023 02:44:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3C3D783E06
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tA8ClRpzl4bP; Tue, 24 Oct 2023 02:44:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id A77BB83E04;
	Tue, 24 Oct 2023 02:44:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A77BB83E04
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6437FC0071;
	Tue, 24 Oct 2023 02:44:15 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3A8DBC0032
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Oct 2023 02:44:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0A24A83E04
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Oct 2023 02:44:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0A24A83E04
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id avsobi_oOW1q
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Oct 2023 02:44:12 +0000 (UTC)
Received: from out30-113.freemail.mail.aliyun.com
 (out30-113.freemail.mail.aliyun.com [115.124.30.113])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 236ED83DFE
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Oct 2023 02:44:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 236ED83DFE
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R901e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046051;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=7; SR=0;
 TI=SMTPD_---0VuoXqpk_1698115445; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0VuoXqpk_1698115445) by smtp.aliyun-inc.com;
 Tue, 24 Oct 2023 10:44:05 +0800
Message-ID: <1698114697.434748-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH 1/2] virtio_pci: Don't make an extra copy of cpu affinity
 mask
Date: Tue, 24 Oct 2023 10:31:37 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jakub Sitnicki <jakub@cloudflare.com>
References: <20231019101625.412936-1-jakub@cloudflare.com>
 <1697720122.49851-2-xuanzhuo@linux.alibaba.com>
 <87il6x2rj6.fsf@cloudflare.com>
In-Reply-To: <87il6x2rj6.fsf@cloudflare.com>
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

On Mon, 23 Oct 2023 18:52:45 +0200, Jakub Sitnicki <jakub@cloudflare.com> wrote:
> On Thu, Oct 19, 2023 at 08:55 PM +08, Xuan Zhuo wrote:
> > On Thu, 19 Oct 2023 12:16:24 +0200, Jakub Sitnicki <jakub@cloudflare.com> wrote:
> >> Since commit 19e226e8cc5d ("virtio: Make vp_set_vq_affinity() take a
> >> mask.") it is actually not needed to have a local copy of the cpu mask.
> >
> >
> > Could you give more info to prove this?


Actually, my question is that can we pass a val on the stack(or temp value) to
the irq_set_affinity_hint()?

Such as the virtio-net uses zalloc_cpumask_var to alloc a cpu_mask, and
that will be released.



	int __irq_apply_affinity_hint(unsigned int irq, const struct cpumask *m,
				      bool setaffinity)
	{
		unsigned long flags;
		struct irq_desc *desc = irq_get_desc_lock(irq, &flags, IRQ_GET_DESC_CHECK_GLOBAL);

		if (!desc)
			return -EINVAL;
->		desc->affinity_hint = m;
		irq_put_desc_unlock(desc, flags);
		if (m && setaffinity)
			__irq_set_affinity(irq, m, false);
		return 0;
	}
	EXPORT_SYMBOL_GPL(__irq_apply_affinity_hint);

The above code directly refers the mask pointer. If the mask is a temp value, I
think that is a bug.

And I notice that many places directly pass the temp value to this API.
And I am a little confused. ^_^ Or I missed something.

Thanks.


> >
> > If you are right, I think you should delete all code about msix_affinity_masks?
>
> Sorry for the late reply. I've been away.
>
> It looks that msix_affinity_masks became unused - intentionally - in
> 2015, after commit 210d150e1f5d ("virtio_pci: Clear stale cpumask when
> setting irq affinity") [1].
>
> Originally introduced in 2012 in commit 75a0a52be3c2 ("virtio: introduce
> an API to set affinity for a virtqueue") [2]. As I understand, it was
> meant to make it possible to set VQ affinity to more than once CPU.
>
> Now that we can pass a CPU mask, listing all CPUs, to set_vq_affinity,
> msix_affinity_masks seems to no longer have a purpose.
>
> So, IMO, you're right. We can remove it.
>
> Happy to do that in a follow up series.
>
> That is - if you're okay with these two patches in the current form.
>
> Thanks for reviewing.
>
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=210d150e1f5da506875e376422ba31ead2d49621
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=75a0a52be3c27b58654fbed2c8f2ff401482b9a4
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
