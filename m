Return-Path: <SRS0=ow7J=HD=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1337C433DB
	for <virtualization@archiver.kernel.org>; Mon,  1 Feb 2021 23:20:06 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8167664EBF
	for <virtualization@archiver.kernel.org>; Mon,  1 Feb 2021 23:20:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8167664EBF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=opensynergy.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 305EA21507;
	Mon,  1 Feb 2021 23:20:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bIz32c9MHCWT; Mon,  1 Feb 2021 23:20:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 0E4EA214F6;
	Mon,  1 Feb 2021 23:20:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 00579C0FA7;
	Mon,  1 Feb 2021 23:20:04 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 00587C013A
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Feb 2021 23:20:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id E6CE384948
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Feb 2021 23:20:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rVGta7QWcU-M
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Feb 2021 23:20:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx1.opensynergy.com (mx1.opensynergy.com [217.66.60.4])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 4CB01847B3
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Feb 2021 23:20:02 +0000 (UTC)
Received: from SR-MAILGATE-02.opensynergy.com (localhost.localdomain
 [127.0.0.1])
 by mx1.opensynergy.com (Proxmox) with ESMTP id E0387A1570;
 Tue,  2 Feb 2021 00:20:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=opensynergy.com;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:from:from:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=srmailgate02; bh=ssfdkDmw6xak
 rwOPLgsefLQO8t7T2+/G9UIklxeWIDE=; b=NOAwJnm3djpRw7B3Z2J3EzeTW/U/
 SH+1zuzXql+yR7YTrw+/qGWPiQvz0aYOvH4GGuwdmfcrKcyDENOxTfCCqFvwJCEJ
 v13+6qI/tPZzYS2uRXqKRqJbNJhESGqXaxRq2Esq9R5gTlG89ZDRM1BHMAaGELZ5
 bBW1Jxx7lSklVzt3mu070UNG9YY+AoCdAVkN9MBez38CQ/NmLQgb0CuaXhY18uVT
 Vv2xCUn1U2ZD+L7I23me1NXVFbEIlNK8H+E0DOhMCnnd6EavKHZPGhXzR+/v7uKk
 iUuflU8H+9MJYMBV9fh8SUXny7ddh/IBd2bpmRnp4shSwpvHE7t5wMs0mw==
Subject: Re: [virtio-dev] Re: [PATCH v2 4/9] ALSA: virtio: build PCM devices
 and substream hardware descriptors
To: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
References: <20210124165408.1122868-1-anton.yakovlev@opensynergy.com>
 <20210124165408.1122868-5-anton.yakovlev@opensynergy.com>
 <6f93189c-7cfc-25c7-6b2c-ad8e21bf42c@intel.com>
From: Anton Yakovlev <anton.yakovlev@opensynergy.com>
Message-ID: <4eb2f618-1b8d-b339-8f85-ff061a1f563e@opensynergy.com>
Date: Tue, 2 Feb 2021 00:19:59 +0100
MIME-Version: 1.0
In-Reply-To: <6f93189c-7cfc-25c7-6b2c-ad8e21bf42c@intel.com>
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



On 25.01.2021 16:44, Guennadi Liakhovetski wrote:
 > On Sun, 24 Jan 2021, Anton Yakovlev wrote:
 >

...[snip]...

 >>
 >> diff --git a/sound/virtio/virtio_card.c b/sound/virtio/virtio_card.c
 >> index 955eadc2d858..39fe13b43dd1 100644
 >> --- a/sound/virtio/virtio_card.c
 >> +++ b/sound/virtio/virtio_card.c
 >> @@ -92,6 +92,17 @@ static void virtsnd_event_notify_cb(struct
 >> virtqueue *vqueue)
 >>                       if (!event)
 >>                               break;
 >>
 >> +                     switch (le32_to_cpu(event->hdr.code)) {
 >> +                     case VIRTIO_SND_EVT_PCM_PERIOD_ELAPSED:
 >> +                     case VIRTIO_SND_EVT_PCM_XRUN: {
 >
 > In the previous patch you had a switch-case statement complying to the
 > common kernel coding style. It isn't specified in coding-style.rst, but
 > these superfluous braces really don't seem to be good for anything - in
 > this and multiple other switch-case statements in the series.

I will fix this. Thanks!


...[snip]...


 >> @@ -359,6 +384,8 @@ static int virtsnd_probe(struct virtio_device *vdev)
 >> static void virtsnd_remove(struct virtio_device *vdev)
 >> {
 >>       struct virtio_snd *snd = vdev->priv;
 >> +     struct virtio_pcm *pcm;
 >> +     struct virtio_pcm *pcm_next;
 >>
 >>       if (!snd)
 >>               return;
 >> @@ -376,6 +403,24 @@ static void virtsnd_remove(struct virtio_device
 >> *vdev)
 >>       vdev->config->reset(vdev);
 >>       vdev->config->del_vqs(vdev);
 >>
 >> +     list_for_each_entry_safe(pcm, pcm_next, &snd->pcm_list, list) {
 >> +             unsigned int i;
 >> +
 >> +             list_del(&pcm->list);
 >> +
 >> +             for (i = 0; i < ARRAY_SIZE(pcm->streams); ++i) {
 >> +                     struct virtio_pcm_stream *stream =
 >> &pcm->streams[i];
 >> +
 >> +                     if (stream->substreams)
 >> +                             devm_kfree(&vdev->dev, 
stream->substreams);
 >> +             }
 >> +
 >> +             devm_kfree(&vdev->dev, pcm);
 >
 > Please double-check both devm_kfree() calls above. Probably they aren't
 > needed in the .remove() method.

Then I will redo these parts, and the parts that you noticed in the rest
of the comments to this file.


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
