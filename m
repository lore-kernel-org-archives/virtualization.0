Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81BDCC25B70
	for <virtualization@archiver.kernel.org>; Sat, 28 Oct 2023 01:47:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id F01BD41969;
	Sat, 28 Oct 2023 01:47:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org F01BD41969
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ix4OivQZxMcZ; Sat, 28 Oct 2023 01:47:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 37BCE41966;
	Sat, 28 Oct 2023 01:47:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 37BCE41966
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 14B4EC0039;
	Sat, 28 Oct 2023 01:47:37 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 32517C0032
 for <virtualization@lists.linux-foundation.org>;
 Sat, 28 Oct 2023 01:47:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 179F482274
 for <virtualization@lists.linux-foundation.org>;
 Sat, 28 Oct 2023 01:47:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 179F482274
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yVRuGRp2OTeY
 for <virtualization@lists.linux-foundation.org>;
 Sat, 28 Oct 2023 01:47:33 +0000 (UTC)
Received: from out30-132.freemail.mail.aliyun.com
 (out30-132.freemail.mail.aliyun.com [115.124.30.132])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3158282270
 for <virtualization@lists.linux-foundation.org>;
 Sat, 28 Oct 2023 01:47:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3158282270
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R641e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046059;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=6; SR=0;
 TI=SMTPD_---0Vv05X6g_1698457645; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0Vv05X6g_1698457645) by smtp.aliyun-inc.com;
 Sat, 28 Oct 2023 09:47:26 +0800
Message-ID: <1698457540.127802-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH v2] virtio_pci: Switch away from deprecated
 irq_set_affinity_hint
Date: Sat, 28 Oct 2023 09:45:40 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jakub Sitnicki <jakub@cloudflare.com>
References: <20231025145319.380775-1-jakub@cloudflare.com>
 <87wmv91h3p.fsf@cloudflare.com>
 <20231026131830-mutt-send-email-mst@kernel.org>
 <87sf5w1ica.fsf@cloudflare.com>
In-Reply-To: <87sf5w1ica.fsf@cloudflare.com>
Cc: kernel-team@cloudflare.com, "Michael S. Tsirkin" <mst@redhat.com>,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
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

On Fri, 27 Oct 2023 12:03:17 +0200, Jakub Sitnicki <jakub@cloudflare.com> wrote:
> On Thu, Oct 26, 2023 at 01:20 PM -04, Michael S. Tsirkin wrote:
> > On Thu, Oct 26, 2023 at 06:25:08PM +0200, Jakub Sitnicki wrote:
> >> On Wed, Oct 25, 2023 at 04:53 PM +02, Jakub Sitnicki wrote:
> >> > Since commit 65c7cdedeb30 ("genirq: Provide new interfaces for affinity
> >> > hints") irq_set_affinity_hint is being phased out.
> >> >
> >> > Switch to new interfaces for setting and applying irq affinity hints.
> >> >
> >> > Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
> >> > ---
> >> > v2:
> >> >  - Leave cpumask_copy as is. We can't pass pointer to stack memory as hint.
> >> >    Proposed a change to IRQ affinity interface to address this limitation:
> >> >    https://lore.kernel.org/r/20231025141517.375378-1-jakub@cloudflare.com
> >>
> >> Just a note to the ^ - if we wanted to get rid of msix_affinity_masks,
> >> we could call irq_set_affinity directly, instead of calling it through
> >> irq_set_affinity[_and]_hint.
> >>
> >> The hint wouldn't be available any more in /proc/irq/N/affinity_hint,
> >> but the same information can be gathered from /proc/irq/N/smp_affinity.
> >>
> >> [...]
> >
> >
> > So we are potentially breaking some userspace - what's the value we
> > gain?  Is there some way we can make disable_irq/enable_irq work?
> > That would have a lot of value.
> > There is an actual need for that in virtio for coco but we can't use
> > these APIs with affinity managed IRQs.
>
> Sorry, that is beyond my ken today.
>
> I saw the comment in vp_modern_disable_vq_and_reset:
>
> 	/* For the case where vq has an exclusive irq, call synchronize_irq() to
> 	 * wait for completion.
> 	 *
> 	 * note: We can't use disable_irq() since it conflicts with the affinity
> 	 * managed IRQ that is used by some drivers.
> 	 */
>
> ... but I fail to follow how the two conflict.
>
> Perhaps Xuah could shed some light here.

I forgot which device that manages the irq by it self. If we disable the irq,
then the device will lost the irq, so we must not call disable_irq().

Thanks.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
