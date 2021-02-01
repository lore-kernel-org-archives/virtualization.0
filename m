Return-Path: <SRS0=ow7J=HD=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7D83C433DB
	for <virtualization@archiver.kernel.org>; Mon,  1 Feb 2021 23:18:20 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75F6B64E2A
	for <virtualization@archiver.kernel.org>; Mon,  1 Feb 2021 23:18:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75F6B64E2A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=opensynergy.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 3100C85B8D;
	Mon,  1 Feb 2021 23:18:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1dtlfTusbm39; Mon,  1 Feb 2021 23:18:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 535C1855D8;
	Mon,  1 Feb 2021 23:18:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 35C7BC0FA7;
	Mon,  1 Feb 2021 23:18:19 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 663C2C013A
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Feb 2021 23:18:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 4D68785660
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Feb 2021 23:18:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id glUr62bIwLZs
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Feb 2021 23:18:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx1.opensynergy.com (mx1.opensynergy.com [217.66.60.4])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 3B49184C26
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Feb 2021 23:18:16 +0000 (UTC)
Received: from SR-MAILGATE-02.opensynergy.com (localhost.localdomain
 [127.0.0.1])
 by mx1.opensynergy.com (Proxmox) with ESMTP id 80A95A1569;
 Tue,  2 Feb 2021 00:18:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=opensynergy.com;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:from:from:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=srmailgate02; bh=lUMI46TQw0fr
 jF2ARY5V4xhdbBHFJlxLuLVTz4ns2iQ=; b=TkEsI5KLXCuVRFyJkEdLrRZI97d0
 x0e1DpOxZ34WCeJucEcMvvUokEBuXuT9ZcESYewcCwCHu2a3i4OmAHKs/KBbRsKZ
 So5yoUc61267K8VfzO6qL3SEB86qQyDAicDRcqBUtjWvMoM9Cs8A5DwsD4XbwmJI
 YDYSjuHAiHz0BEd/1eHF9hYDBAohHvFdKtu493uJJ8JUVdL0ufOzng8OOQsRx0/H
 zkwPFb0oU1g6xUNSFoG6hGBnh+1DCEg2mI2Lt28e94SyU2uWe6GFpA8z+lCQmTEX
 Rrjpm8gnqLmj/X0W6N/BEPD1vmjqXzXDuQLzymE7ShOwqb9WiaqElkvK8A==
Subject: Re: [virtio-dev] Re: [PATCH v2 2/9] ALSA: virtio: add virtio sound
 driver
To: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
References: <20210124165408.1122868-1-anton.yakovlev@opensynergy.com>
 <20210124165408.1122868-3-anton.yakovlev@opensynergy.com>
 <8754dae8-114-6383-510-de2ba9dc4fa@intel.com>
From: Anton Yakovlev <anton.yakovlev@opensynergy.com>
Message-ID: <52f71ac6-3ec7-2884-7a64-1995f416d20a@opensynergy.com>
Date: Tue, 2 Feb 2021 00:18:09 +0100
MIME-Version: 1.0
In-Reply-To: <8754dae8-114-6383-510-de2ba9dc4fa@intel.com>
Content-Language: en-US
X-ClientProxiedBy: SR-MAIL-02.open-synergy.com (10.26.10.22) To
 SR-MAIL-01.open-synergy.com (10.26.10.21)
Cc: virtio-dev@lists.oasis-open.org, alsa-devel@alsa-project.org,
 "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org,
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

Hi Guennadi,

Sorry for the late reply and thanks for your comments, they helped me a
lot! Please see my answers inline.


On 25.01.2021 15:54, Guennadi Liakhovetski wrote:

...[snip]...

 >
 >> + * 1. Redistributions of source code must retain the above copyright
 >> + *    notice, this list of conditions and the following disclaimer.
 >> + * 2. Redistributions in binary form must reproduce the above copyright
 >> + *    notice, this list of conditions and the following disclaimer in
 >> the
 >> + *    documentation and/or other materials provided with the
 >> distribution.
 >> + * 3. Neither the name of OpenSynergy GmbH nor the names of its
 >> contributors
 >> + *    may be used to endorse or promote products derived from this
 >> software
 >> + *    without specific prior written permission.
 >> + * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 >> + * ``AS IS'' AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
 >> + * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
 >> + * FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN NO EVENT SHALL IBM OR
 >
 > IBM? Also no idea whether this warranty disclaimer is appropriate here. I
 > thought we were transitioning to those SPDX identifiers to eliminate all
 > these headers.

It was a copy-paste mistake, I will edit these lines.


...[snip]...

 >> +
 >> +/**
 >> + * virtsnd_disable_vqs() - Disable all virtqueues.
 >> + * @snd: VirtIO sound device.
 >> + *
 >> + * Also free all allocated events and control messages.
 >> + *
 >> + * Context: Any context.
 >> + */
 >> +static void virtsnd_disable_vqs(struct virtio_snd *snd)
 >> +{
 >> +     struct virtio_device *vdev = snd->vdev;
 >> +     unsigned int i;
 >> +     unsigned long flags;
 >> +
 >> +     for (i = 0; i < VIRTIO_SND_VQ_MAX; ++i) {
 >> +             struct virtio_snd_queue *queue = &snd->queues[i];
 >> +
 >> +             spin_lock_irqsave(&queue->lock, flags);
 >> +             /* Prohibit the use of the queue */
 >> +             if (queue->vqueue)
 >> +                     virtqueue_disable_cb(queue->vqueue);
 >> +             queue->vqueue = NULL;
 >> +             spin_unlock_irqrestore(&queue->lock, flags);
 >> +     }
 >> +
 >> +     if (snd->event_msgs)
 >
 > Check not needed, kfree(NULL) is ok.

Yes, you are right here. I didn't notice that devm_kfree() now works
fine with NULL argument too.


 >> +             devm_kfree(&vdev->dev, snd->event_msgs);
 >
 > I think there are very few cases when managed resources have to be
 > explicitly freed. If explicit freeing is always required, then there's no
 > need to have them managed. If there's a clear case for managed resources,
 > usually you don't need to free them explicitly. Here.event_msgs are
 > allocated in virtsnd_find_vqs() above, which is only called during
 > probing. And this function is only called during release. So, I'd assume,
 > that you don't need to free memory explicitly here.

Here, the reason for explicitly freeing managed resources is in the
current device reset handling logic. At the moment, executing the reset
worker results in a call to virtsnd_disable_vqs. After which the device
is recreated. And since in this case the driver is not detached from the
device, the managed resources are not automatically freed. On the other
hand, managed resources allow not to worry about deallocation if the
probing function returns an error.


 >> +
 >> +     snd->event_msgs = NULL;
 >
 > snd is about to be freed, so do you really need this?

No :)


 >> +}
 >> +
 >> +/**
 >> + * virtsnd_reset_fn() - Kernel worker's function to reset the device.
 >> + * @work: Reset device work.
 >> + *
 >> + * Context: Process context.
 >> + */
 >> +static void virtsnd_reset_fn(struct work_struct *work)
 >> +{
 >> +     struct virtio_snd *snd =
 >> +             container_of(work, struct virtio_snd, reset_work);
 >> +     struct virtio_device *vdev = snd->vdev;
 >> +     struct device *dev = &vdev->dev;
 >> +     int rc;
 >> +
 >> +     dev_info(dev, "sound device needs reset\n");
 >> +
 >> +     /*
 >> +      * It seems that the only way to properly reset the device is to
 >> remove
 >> +      * and re-create the ALSA sound card device.
 >> +      *
 >> +      * Also resetting the device involves a number of steps with
 >> setting the
 >> +      * status bits described in the virtio specification. And the
 >> easiest
 >> +      * way to get everything right is to use the virtio bus interface.
 >> +      */
 >> +     rc = dev->bus->remove(dev);
 >> +     if (rc)
 >> +             dev_warn(dev, "bus->remove() failed: %d", rc);
 >> +
 >> +     rc = dev->bus->probe(dev);
 >> +     if (rc)
 >> +             dev_err(dev, "bus->probe() failed: %d", rc);
 >
 > This looks very suspicious to me. Wondering what ALSA maintainers 
will say
 > to this.

I'm also wondering what the virtio people have to say. This part is a
purely virtio specific thing. And since none of the existing virtio
drivers processes the request to reset the device, it is not clear what
is the best way to proceed here. For this reason, the most
straightforward and simple solution was chosen.


...[snip]...

 >
 > Thanks
 > Guennadi
 >
 > ---------------------------------------------------------------------
 > To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
 > For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
 >
 >
-- 
Anton Yakovlev
Senior Software Engineer

OpenSynergy GmbH
Rotherstr. 20, 10245 Berlin

www.opensynergy.com

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
