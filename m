Return-Path: <SRS0=COaL=H7=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC919C433E0
	for <virtualization@archiver.kernel.org>; Mon,  1 Mar 2021 09:29:32 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D3C864E3F
	for <virtualization@archiver.kernel.org>; Mon,  1 Mar 2021 09:29:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D3C864E3F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=opensynergy.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 108C060627;
	Mon,  1 Mar 2021 09:29:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hXdPS0lieG86; Mon,  1 Mar 2021 09:29:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id B5FDF6006A;
	Mon,  1 Mar 2021 09:29:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8C0D9C000B;
	Mon,  1 Mar 2021 09:29:30 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E9F7EC0001
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Mar 2021 09:29:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id CADD483B9D
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Mar 2021 09:29:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=opensynergy.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Uf1yPDsMKSxF
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Mar 2021 09:29:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx1.opensynergy.com (mx1.opensynergy.com [217.66.60.4])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1D21683ABE
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Mar 2021 09:29:27 +0000 (UTC)
Received: from SR-MAILGATE-02.opensynergy.com (localhost.localdomain
 [127.0.0.1])
 by mx1.opensynergy.com (Proxmox) with ESMTP id 98005A1340;
 Mon,  1 Mar 2021 10:29:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=opensynergy.com;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:from:from:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=srmailgate02; bh=AF2+aLbHpYk6
 yxg/KMusF89bfRVX3X9/VCCjZ8mooHU=; b=njrad0q9gBYFdXuKLLKrdMQiJrmC
 2BkUzmkCM+/7GTmtBRL4KEei2E9d4aTwbewItdx8ywzFTZ+Wq+o0YIf8ctZOxS6s
 pWUn/fd83sGZ/mCG1K5YR5fADtw4ahaRbEnXVRkPL6sL2RWJlDxJ4xow1k7GxPEl
 wsNo0I+0+kfO+5odG3fJVrIfyApV8XWZNWyz1D/U2mYX25e+aY8VQk5NmK18oKUf
 AXuAStUtmc5vLAuHdldToU4L4wQobXvwR0KNh3CO0PUQIgSbPn1tUFY+nQuOALEY
 zXBiH5ZcCoYx9U6bwN5/r1O8apbH0HBuDUG76grDuZ0I2zjZIrk1jMc/Zw==
Subject: Re: [PATCH v6 6/9] ALSA: virtio: PCM substream operators
To: Takashi Iwai <tiwai@suse.de>
References: <20210227085956.1700687-1-anton.yakovlev@opensynergy.com>
 <20210227085956.1700687-7-anton.yakovlev@opensynergy.com>
 <s5hr1l0juld.wl-tiwai@suse.de>
From: Anton Yakovlev <anton.yakovlev@opensynergy.com>
Message-ID: <f8a4bbf5-3bee-f336-0efd-94410184fb2b@opensynergy.com>
Date: Mon, 1 Mar 2021 10:29:24 +0100
MIME-Version: 1.0
In-Reply-To: <s5hr1l0juld.wl-tiwai@suse.de>
Content-Language: en-US
X-ClientProxiedBy: SR-MAIL-01.open-synergy.com (10.26.10.21) To
 SR-MAIL-01.open-synergy.com (10.26.10.21)
Cc: virtio-dev@lists.oasis-open.org, alsa-devel@alsa-project.org, "Michael S.
 Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org,
 Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>,
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On 28.02.2021 12:32, Takashi Iwai wrote:
> On Sat, 27 Feb 2021 09:59:53 +0100,
> Anton Yakovlev wrote:
>>


[snip]


>> +static snd_pcm_uframes_t
>> +virtsnd_pcm_pointer(struct snd_pcm_substream *substream)
>> +{
>> +     struct virtio_pcm_substream *vss = snd_pcm_substream_chip(substream);
>> +     snd_pcm_uframes_t hw_ptr = SNDRV_PCM_POS_XRUN;
>> +     unsigned long flags;
>> +
>> +     spin_lock_irqsave(&vss->lock, flags);
>> +     if (!vss->xfer_xrun)
>> +             hw_ptr = bytes_to_frames(substream->runtime, vss->hw_ptr);
>> +     spin_unlock_irqrestore(&vss->lock, flags);
> 
> Oh, and if we drop nonatomc PCM, both trigger and pointer callbacks
> are guaranteed to be called inside the spinlock, hence you can remove
> *_irqsave() but just us spin_lock() in those two callbacks.

As I understand, spin_lock_irqsave() disables only local interrupts. But
what about other CPU cores?


> 
> thanks,
> 
> Takashi
> 

-- 
Anton Yakovlev
Senior Software Engineer

OpenSynergy GmbH
Rotherstr. 20, 10245 Berlin

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
