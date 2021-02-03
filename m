Return-Path: <SRS0=+GVp=HF=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78E1AC433DB
	for <virtualization@archiver.kernel.org>; Wed,  3 Feb 2021 17:34:23 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B120A64F87
	for <virtualization@archiver.kernel.org>; Wed,  3 Feb 2021 17:34:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B120A64F87
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=opensynergy.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 386FA23265;
	Wed,  3 Feb 2021 17:34:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tVz12pW+Jo4M; Wed,  3 Feb 2021 17:34:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 578D1231CB;
	Wed,  3 Feb 2021 17:34:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2C157C0174;
	Wed,  3 Feb 2021 17:34:20 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 69747C013A
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 Feb 2021 17:34:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 6205181E69
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 Feb 2021 17:34:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IfzdKqziamGe
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 Feb 2021 17:34:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx1.opensynergy.com (mx1.opensynergy.com [217.66.60.4])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id C236081E65
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 Feb 2021 17:34:16 +0000 (UTC)
Received: from SR-MAILGATE-02.opensynergy.com (localhost.localdomain
 [127.0.0.1])
 by mx1.opensynergy.com (Proxmox) with ESMTP id DEDB2A15A4;
 Wed,  3 Feb 2021 18:34:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=opensynergy.com;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:from:from:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=srmailgate02; bh=6JriUFT4K4Gw
 YTQBWmEFwOKzOJIBhwKv+n4I3Bk9mZ4=; b=ZS9V4YZ72FWVi7jLDWcSYcAxKf+E
 q4/rbVgU+kTQKo0+HohUXRP4aRJctXkwRTS7slZVNXGVKEiK9xYezJH9qleb++ty
 JDcfELO4n6iMqRMMd0uR7JoH2qOXonsSXmUprzdqEdYgcb9UJ5qN8waT3PmM2XPN
 dlUUlFCn3FynQI2qXzqEURdH7WoJ1zk7yMy89/tIPNhS8TiZERrSlg8ybV0LKvN4
 OLsmqvjaD56VsoWRsLLSzTwfxCW8IgfMgG9uVJemr/v2fqHOTROjmkg4MgFGNlYR
 JULqEYM8W+YWDNKrq+WzFkkvkBm5hy9haTBbLVTHCkGRzuKehKmn9ICG+w==
Subject: Re: [virtio-dev] Re: [PATCH v2 2/9] ALSA: virtio: add virtio sound
 driver
To: Takashi Iwai <tiwai@suse.de>
References: <20210124165408.1122868-1-anton.yakovlev@opensynergy.com>
 <20210124165408.1122868-3-anton.yakovlev@opensynergy.com>
 <8754dae8-114-6383-510-de2ba9dc4fa@intel.com>
 <52f71ac6-3ec7-2884-7a64-1995f416d20a@opensynergy.com>
 <s5h35yd9jf0.wl-tiwai@suse.de>
From: Anton Yakovlev <anton.yakovlev@opensynergy.com>
Message-ID: <fb4808e7-28d6-996e-02fc-c63d0e1d8221@opensynergy.com>
Date: Wed, 3 Feb 2021 18:34:12 +0100
MIME-Version: 1.0
In-Reply-To: <s5h35yd9jf0.wl-tiwai@suse.de>
Content-Language: en-US
X-ClientProxiedBy: SR-MAIL-01.open-synergy.com (10.26.10.21) To
 SR-MAIL-01.open-synergy.com (10.26.10.21)
Cc: alsa-devel@alsa-project.org, virtio-dev@lists.oasis-open.org,
 Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org,
 Jaroslav Kysela <perex@perex.cz>, "Michael S. Tsirkin" <mst@redhat.com>,
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

Hi Takashi,


On 03.02.2021 17:59, Takashi Iwai wrote:
> On Tue, 02 Feb 2021 00:18:09 +0100,
> Anton Yakovlev wrote:
>>>> +/**
>>>> + * virtsnd_reset_fn() - Kernel worker's function to reset the device.
>>>> + * @work: Reset device work.
>>>> + *
>>>> + * Context: Process context.
>>>> + */
>>>> +static void virtsnd_reset_fn(struct work_struct *work)
>>>> +{
>>>> +     struct virtio_snd *snd =
>>>> +             container_of(work, struct virtio_snd, reset_work);
>>>> +     struct virtio_device *vdev = snd->vdev;
>>>> +     struct device *dev = &vdev->dev;
>>>> +     int rc;
>>>> +
>>>> +     dev_info(dev, "sound device needs reset\n");
>>>> +
>>>> +     /*
>>>> +      * It seems that the only way to properly reset the device is to
>>>> remove
>>>> +      * and re-create the ALSA sound card device.
>>>> +      *
>>>> +      * Also resetting the device involves a number of steps with
>>>> setting the
>>>> +      * status bits described in the virtio specification. And the
>>>> easiest
>>>> +      * way to get everything right is to use the virtio bus interface.
>>>> +      */
>>>> +     rc = dev->bus->remove(dev);
>>>> +     if (rc)
>>>> +             dev_warn(dev, "bus->remove() failed: %d", rc);
>>>> +
>>>> +     rc = dev->bus->probe(dev);
>>>> +     if (rc)
>>>> +             dev_err(dev, "bus->probe() failed: %d", rc);
>>>
>>> This looks very suspicious to me. Wondering what ALSA maintainers
>> will say
>>> to this.
>>
>> I'm also wondering what the virtio people have to say. This part is a
>> purely virtio specific thing. And since none of the existing virtio
>> drivers processes the request to reset the device, it is not clear what
>> is the best way to proceed here. For this reason, the most
>> straightforward and simple solution was chosen.
> 
> What is this "reset" actually supposed to do?  Reconfguring
> everything, or changing only certain parameters, devices, whatever?

It means bringing this particular device to its initial state.

After that, the driver can re-read the configurations from the device
and reconfigure everything.


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
