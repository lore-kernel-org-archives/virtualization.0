Return-Path: <SRS0=rmzs=H3=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37127C433DB
	for <virtualization@archiver.kernel.org>; Thu, 25 Feb 2021 22:19:42 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96E7564DA3
	for <virtualization@archiver.kernel.org>; Thu, 25 Feb 2021 22:19:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96E7564DA3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=opensynergy.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 4AF2143326;
	Thu, 25 Feb 2021 22:19:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XqCDt0PN61TU; Thu, 25 Feb 2021 22:19:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 0F6B34332C;
	Thu, 25 Feb 2021 22:19:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D7E6CC000A;
	Thu, 25 Feb 2021 22:19:39 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4E3FFC0001
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Feb 2021 22:19:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3C7074ED2E
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Feb 2021 22:19:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=opensynergy.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PMEBUGcg_eOS
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Feb 2021 22:19:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx1.opensynergy.com (mx1.opensynergy.com [217.66.60.4])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 263C84ED25
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Feb 2021 22:19:37 +0000 (UTC)
Received: from SR-MAILGATE-02.opensynergy.com (localhost.localdomain
 [127.0.0.1])
 by mx1.opensynergy.com (Proxmox) with ESMTP id A94DAA12BA;
 Thu, 25 Feb 2021 23:19:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=opensynergy.com;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:from:from:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=srmailgate02; bh=VmhpQ9IAKsvf
 k7oW2kDn8RfoCMyYDunAm6/v4M1Pbss=; b=HB1IjxBZ/F80GewGIjqAmYzCRU46
 9xVvfpcNpK0cvywrxzB1X11Yj2CBkL0ybUaLST83nCliwQRdxZ/RV1GlEyz8KqqY
 L286M1bSSYStGAgLMQjA/IZIo5eELlnwc3vMZb7bwianKhdfNV/+ORG3UVe8cfMB
 13mc6kuRo7noC774WSY5WXS4TSXZQVS3WMag1kS0P/z7BjG5RBepgjGY7rEiOqcP
 9d7m2+0ZJi+BuRD27GtkWIyA9uVnvq1vZwAsN5PWvwV/RG1ynHRLTt8aKyJDde7m
 aLh8h3c6eJSKchmZ5ojU4k1Ngi4AtXfK6zOp3c+nfrgZWpijgzqpoYdZig==
Subject: Re: [PATCH v5 6/9] ALSA: virtio: PCM substream operators
To: Takashi Iwai <tiwai@suse.de>, "Michael S. Tsirkin" <mst@redhat.com>
References: <20210222153444.348390-1-anton.yakovlev@opensynergy.com>
 <20210222153444.348390-7-anton.yakovlev@opensynergy.com>
 <s5h35xkquvj.wl-tiwai@suse.de>
 <d9b6e8fa-7356-1cbf-029b-6f7c8bad4994@opensynergy.com>
 <s5hlfbcpayj.wl-tiwai@suse.de>
 <20210225135951-mutt-send-email-mst@kernel.org>
 <s5hblc7opok.wl-tiwai@suse.de>
From: Anton Yakovlev <anton.yakovlev@opensynergy.com>
Message-ID: <0a9f6dea-ed75-16eb-9fc2-84148fa820be@opensynergy.com>
Date: Thu, 25 Feb 2021 23:19:31 +0100
MIME-Version: 1.0
In-Reply-To: <s5hblc7opok.wl-tiwai@suse.de>
Content-Language: en-US
X-ClientProxiedBy: SR-MAIL-02.open-synergy.com (10.26.10.22) To
 SR-MAIL-02.open-synergy.com (10.26.10.22)
Cc: virtio-dev@lists.oasis-open.org, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
 Jaroslav Kysela <perex@perex.cz>, virtualization@lists.linux-foundation.org
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

On 25.02.2021 21:30, Takashi Iwai wrote:> On Thu, 25 Feb 2021 20:02:50 
+0100,
> Michael S. Tsirkin wrote:
>>
>> On Thu, Feb 25, 2021 at 01:51:16PM +0100, Takashi Iwai wrote:
>>> On Thu, 25 Feb 2021 13:14:37 +0100,
>>> Anton Yakovlev wrote:


[snip]


>> Takashi given I was in my tree for a while and I planned to merge
>> it this merge window.
> 
> Hmm, that's too quick, I'm afraid.  I see still a few rough edges in
> the code.  e.g. the reset work should be canceled at the driver
> removal, but it's missing right now.  And that'll become tricky
> because the reset work itself unbinds the device, hence it'll get
> stuck if calling cancel_work_sync() at remove callback.

Yes, you made a good point here! In this case, we need some external
mutex for synchronization. This is just a rough idea, but maybe
something like this might work:

struct reset_work {
     struct mutex mutex;
     struct work_struct work;
     struct virtio_snd *snd;
     bool resetting;
};

static struct reset_work reset_works[SNDRV_CARDS];

init()
     // init mutexes and workers


virtsnd_probe()
     snd_card_new(snd->card)
     reset_works[snd->card->number].snd = snd;


virtsnd_remove()
     mutex_lock(reset_works[snd->card->number].mutex)
     reset_works[snd->card->number].snd = NULL;
     resetting = reset_works[snd->card->number].resetting;
     mutex_unlock(reset_works[snd->card->number].mutex)

     if (!resetting)
         // cancel worker reset_works[snd->card->number].work
     // remove device


virtsnd_reset_fn(work)
     mutex_lock(work->mutex)
     if (!work->snd)
         // do nothing and take an exit path
     work->resetting = true;
     mutex_unlock(work->mutex)

     device_reprobe()

     work->resetting = false;


interrupt_handler()
     schedule_work(reset_works[snd->card->number].work);


What do you think?


-- 
Anton Yakovlev
Senior Software Engineer

OpenSynergy GmbH
Rotherstr. 20, 10245 Berlin

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
