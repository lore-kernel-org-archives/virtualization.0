Return-Path: <SRS0=rmzs=H3=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7086C433E0
	for <virtualization@archiver.kernel.org>; Thu, 25 Feb 2021 11:51:46 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A51064EC3
	for <virtualization@archiver.kernel.org>; Thu, 25 Feb 2021 11:51:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A51064EC3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=opensynergy.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B66AA6F74D;
	Thu, 25 Feb 2021 11:51:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GKDGHH1N359S; Thu, 25 Feb 2021 11:51:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5BE6C6F74B;
	Thu, 25 Feb 2021 11:51:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3F40CC000A;
	Thu, 25 Feb 2021 11:51:44 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 36322C0001
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Feb 2021 11:51:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 231FF43224
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Feb 2021 11:51:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=opensynergy.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HRYF7FPmkgB0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Feb 2021 11:51:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx1.opensynergy.com (mx1.opensynergy.com [217.66.60.4])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2D53E43127
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Feb 2021 11:51:42 +0000 (UTC)
Received: from SR-MAILGATE-02.opensynergy.com (localhost.localdomain
 [127.0.0.1])
 by mx1.opensynergy.com (Proxmox) with ESMTP id 6C466A06F5;
 Thu, 25 Feb 2021 12:51:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=opensynergy.com;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:from:from:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=srmailgate02; bh=TAhy5sA5EuJA
 cioqsfiM0ihVQ+DRllhVv2+0h39aJRA=; b=FSfYe2+cHjQSpdAgRO0K0EwGjSoE
 sk+pRqYuJHY/NMoIfl0gLsM39at7/fRFpL+T0B6aSEO+X1N83R7JNbXnYDr5Ul90
 sBHnzHqCm+ef74GlzwclYVV9i4Ba0SU/cOEYMXhIkjj4+yzXySxaohmYIqyAmyxX
 qLHu6CvcKWapJwGhPdvUk1sCWA26ddTT+9iz8q+yIeZXPDOTk3Fyav1OFo26crIk
 caU2lFu2crsrKfda6cArThtbmjIZuO9gOgySg5xkYP2SIvazJ8ODNGxy9zswALSQ
 JAnKl1qXj0tGpoo8NHGt+QjZnw5KDMxZiZGHtsEW3pBqn7ZZ3tk0CIlxYQ==
Subject: Re: [PATCH v5 2/9] ALSA: virtio: add virtio sound driver
To: Takashi Iwai <tiwai@suse.de>
References: <20210222153444.348390-1-anton.yakovlev@opensynergy.com>
 <20210222153444.348390-3-anton.yakovlev@opensynergy.com>
 <s5h7dmwqvo4.wl-tiwai@suse.de>
From: Anton Yakovlev <anton.yakovlev@opensynergy.com>
Message-ID: <cea4164d-345e-393b-9328-731c2f874eb7@opensynergy.com>
Date: Thu, 25 Feb 2021 12:51:36 +0100
MIME-Version: 1.0
In-Reply-To: <s5h7dmwqvo4.wl-tiwai@suse.de>
Content-Language: en-US
X-ClientProxiedBy: SR-MAIL-01.open-synergy.com (10.26.10.21) To
 SR-MAIL-02.open-synergy.com (10.26.10.22)
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

On 25.02.2021 11:38, Takashi Iwai wrote:
> On Mon, 22 Feb 2021 16:34:37 +0100,
> Anton Yakovlev wrote:
>> +static int virtsnd_find_vqs(struct virtio_snd *snd)
>> +{
>> +     struct virtio_device *vdev = snd->vdev;
>> +     vq_callback_t *callbacks[VIRTIO_SND_VQ_MAX] = {
>> +             [VIRTIO_SND_VQ_EVENT] = virtsnd_event_notify_cb
>> +     };
>> +     const char *names[VIRTIO_SND_VQ_MAX] = {
> 
> Shouldn't be static?

Well, yes. Although in this particular case, I do not think it is that
critical. :)


> Also it's often const char * const names[] = { ... }
> unless you overwrite something.

I tried to use the same type names as in the function prototype.
Otherwise the compiler or static analyzer may complain.


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
>> +      * It seems that the only way to properly reset the device is to remove
>> +      * and re-create the ALSA sound card device.
>> +      */
>> +     rc = device_reprobe(dev);
>> +     if (rc)
>> +             dev_err(dev, "failed to reprobe sound device: %d\n", rc);
> 
> Now I'm wondering whether it's safe to do that from this place.
> Basically device_reprobe() unbinds the device that releases the full
> resources once including the devm_* stuff.  And this work itself is in
> a part of devm allocated resource, so it'll be released there.  That
> said, we might hit use-after-free...  This needs to be verified.

It's safe. Suicide kernel workers are funny but possible things. Since
the kernel itself (AFAIU) assumes such a situation and does not access
the worker structure after the callback function call.


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
