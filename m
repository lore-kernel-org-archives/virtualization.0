Return-Path: <SRS0=rmzs=H3=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44C0CC433E0
	for <virtualization@archiver.kernel.org>; Thu, 25 Feb 2021 12:14:46 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C9F564F16
	for <virtualization@archiver.kernel.org>; Thu, 25 Feb 2021 12:14:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C9F564F16
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=opensynergy.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2EB276F72B;
	Thu, 25 Feb 2021 12:14:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Yw_Y5yxf9FfS; Thu, 25 Feb 2021 12:14:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id B2D0A60709;
	Thu, 25 Feb 2021 12:14:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8E1F2C000A;
	Thu, 25 Feb 2021 12:14:43 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 21609C0001
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Feb 2021 12:14:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1DE1343215
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Feb 2021 12:14:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=opensynergy.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id y3Qfg-WUb-JG
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Feb 2021 12:14:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx1.opensynergy.com (mx1.opensynergy.com [217.66.60.4])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 63D9D43127
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Feb 2021 12:14:41 +0000 (UTC)
Received: from SR-MAILGATE-02.opensynergy.com (localhost.localdomain
 [127.0.0.1])
 by mx1.opensynergy.com (Proxmox) with ESMTP id 44471A06F5;
 Thu, 25 Feb 2021 13:14:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=opensynergy.com;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:from:from:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=srmailgate02; bh=tsvHDlnqSzD6
 yifbwIkb7LBXJuGwyXOyWV+yVzi4100=; b=G84w91d1T9lH3djLLcOGRc4cIZ4v
 djJeKodpta0rHWo8XqOqFYCrvJR/pbd+e/0qggFRXzKFvmv7AmJ9z/AnGR4832KL
 kzz1FeygLg0MA0XYDyZanT+CZ+tjorlXscycxAN176GW4aDD20q3pC7VMvRic6mR
 ESw3CoT1Fa4X4oanD6fgCGeTu5LCc2kd5hcSCnTeLTqpFE+1PQNieX829jtJ6uRB
 3Hlf6df6K1Bfqt1UykpiGlc/Gh/nrHTKfxKI0f3G2KLP80afENBYh/hlHgb4ut0+
 LNrWQyz1HiaBbzUl+UEQ0fPOpmJzckdPtwEAcoslNZBKfokyPCftiDPs2w==
Subject: Re: [PATCH v5 6/9] ALSA: virtio: PCM substream operators
To: Takashi Iwai <tiwai@suse.de>
References: <20210222153444.348390-1-anton.yakovlev@opensynergy.com>
 <20210222153444.348390-7-anton.yakovlev@opensynergy.com>
 <s5h35xkquvj.wl-tiwai@suse.de>
From: Anton Yakovlev <anton.yakovlev@opensynergy.com>
Message-ID: <d9b6e8fa-7356-1cbf-029b-6f7c8bad4994@opensynergy.com>
Date: Thu, 25 Feb 2021 13:14:37 +0100
MIME-Version: 1.0
In-Reply-To: <s5h35xkquvj.wl-tiwai@suse.de>
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

On 25.02.2021 11:55, Takashi Iwai wrote:
> On Mon, 22 Feb 2021 16:34:41 +0100,
> Anton Yakovlev wrote:
>> +static int virtsnd_pcm_open(struct snd_pcm_substream *substream)
>> +{
>> +     struct virtio_pcm *vpcm = snd_pcm_substream_chip(substream);
>> +     struct virtio_pcm_substream *vss = NULL;
>> +
>> +     if (vpcm) {
>> +             switch (substream->stream) {
>> +             case SNDRV_PCM_STREAM_PLAYBACK:
>> +             case SNDRV_PCM_STREAM_CAPTURE: {
> 
> The switch() here looks superfluous.  The substream->stream must be a
> good value in the callback.  If any, you can put WARN_ON() there, but
> I don't think it worth.

At least it doesn't do any harm. If something really went wrong, we can
check it right in the open callback, which is called the very first.


>> +static int virtsnd_pcm_hw_params(struct snd_pcm_substream *substream,
>> +                              struct snd_pcm_hw_params *hw_params)
>> +{
> ....
>> +     return virtsnd_pcm_msg_alloc(vss, periods, period_bytes);
> 
> We have the allocation, but...
> 
>> +static int virtsnd_pcm_hw_free(struct snd_pcm_substream *substream)
>> +{
>> +     return 0;
> 
> ... no release at hw_free()?
> I know that the free is present in the allocator, but it's only for
> re-allocation case, I suppose.

When the substream stops, sync_ptr waits until the device has completed
all pending messages. This wait can be interrupted either by a signal or
due to a timeout. In this case, the device can still access messages
even after calling hw_free(). It can also issue an interrupt, and the
interrupt handler will also try to access message structures. Therefore,
freeing of already allocated messages occurs either in hw_params() or in
dev->release(), since there it is 100% safe.


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
