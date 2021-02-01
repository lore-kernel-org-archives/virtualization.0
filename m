Return-Path: <SRS0=ow7J=HD=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 424AFC433DB
	for <virtualization@archiver.kernel.org>; Mon,  1 Feb 2021 23:22:06 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C202264E7A
	for <virtualization@archiver.kernel.org>; Mon,  1 Feb 2021 23:22:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C202264E7A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=opensynergy.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 9F864857FB;
	Mon,  1 Feb 2021 23:22:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5qVQ1sxbIMpX; Mon,  1 Feb 2021 23:22:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id F408985764;
	Mon,  1 Feb 2021 23:22:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DEFCEC0FA7;
	Mon,  1 Feb 2021 23:22:04 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EAF30C013A
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Feb 2021 23:22:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id D556B214F6
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Feb 2021 23:22:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TO7wc0+2F4EW
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Feb 2021 23:22:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx1.opensynergy.com (mx1.opensynergy.com [217.66.60.4])
 by silver.osuosl.org (Postfix) with ESMTPS id 85333204EA
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Feb 2021 23:22:02 +0000 (UTC)
Received: from SR-MAILGATE-02.opensynergy.com (localhost.localdomain
 [127.0.0.1])
 by mx1.opensynergy.com (Proxmox) with ESMTP id 2F489A1570;
 Tue,  2 Feb 2021 00:22:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=opensynergy.com;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:from:from:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=srmailgate02; bh=SKZK/1HnMki4
 hnaBgoFLy/Sx0y22YEddsx1Drd55/gE=; b=00VgjEXjLKlbQOA/Fynwj1uReuEZ
 NkDv6tUCdGZ/jvJSxz16J253GAez2vKc+1W+o/4nzi4vZw+UHnnXi2+jWvaaDAGh
 BSF6j7YUIV4i6ho9KKerFFOKfopXiZjFy7+w/vO/jXtEr3nTLHML5z2NrQwBddy1
 qUwSA69bJKLQPw8OaaEFpGcCQ3r+IGmh2tfP+7PK0IZvr8IGZR0pFvR2Rzq2PDhB
 VJ8SzmeX3uOL2idQOyPihY2EC7DL5hIwRbaXkUd7XMoDsHrRnDy+3bFP7UqcBJkq
 d2QMuKjCAGKEr/caEtI6jD+cigUR27hRdPEGNoS442S0XBhcc1ms1ih/dA==
Subject: Re: [PATCH v2 8/9] ALSA: virtio: introduce PCM channel map support
To: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
References: <20210124165408.1122868-1-anton.yakovlev@opensynergy.com>
 <20210124165408.1122868-9-anton.yakovlev@opensynergy.com>
 <643248d4-d246-686f-34c3-7e592777e3ec@intel.com>
From: Anton Yakovlev <anton.yakovlev@opensynergy.com>
Message-ID: <9ac289fd-70f2-5939-cf9f-ad9e60133349@opensynergy.com>
Date: Tue, 2 Feb 2021 00:21:59 +0100
MIME-Version: 1.0
In-Reply-To: <643248d4-d246-686f-34c3-7e592777e3ec@intel.com>
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



On 26.01.2021 10:22, Guennadi Liakhovetski wrote:
 > CAUTION: This email originated from outside of the organization.
 > Do not click links or open attachments unless you recognize the sender
 > and know the content is safe.
 >
 >
 > On Sun, 24 Jan 2021, Anton Yakovlev wrote:
 >
 >> Enumerate all available PCM channel maps and create ALSA controls.
 >>
 >> Signed-off-by: Anton Yakovlev <anton.yakovlev@opensynergy.com>
 >> ---
 >> sound/virtio/Makefile       |   1 +
 >> sound/virtio/virtio_card.c  |  15 +++
 >> sound/virtio/virtio_card.h  |   8 ++
 >> sound/virtio/virtio_chmap.c | 237 ++++++++++++++++++++++++++++++++++++
 >> sound/virtio/virtio_pcm.h   |   4 +
 >> 5 files changed, 265 insertions(+)
 >> create mode 100644 sound/virtio/virtio_chmap.c
 >
 > [snip]
 >
 >> diff --git a/sound/virtio/virtio_chmap.c b/sound/virtio/virtio_chmap.c
 >> new file mode 100644
 >> index 000000000000..8a2ddc4dcffb
 >> --- /dev/null
 >> +++ b/sound/virtio/virtio_chmap.c
 >> @@ -0,0 +1,237 @@
 >
 > [snip]
 >
 >> +/**
 >> + * virtsnd_chmap_parse_cfg() - Parse the channel map configuration.
 >> + * @snd: VirtIO sound device.
 >> + *
 >> + * This function is called during initial device initialization.
 >> + *
 >> + * Context: Any context that permits to sleep.
 >> + * Return: 0 on success, -errno on failure.
 >> + */
 >> +int virtsnd_chmap_parse_cfg(struct virtio_snd *snd)
 >> +{
 >> +     struct virtio_device *vdev = snd->vdev;
 >> +     unsigned int i;
 >> +     int rc;
 >> +
 >> +     virtio_cread(vdev, struct virtio_snd_config, chmaps,
 >> &snd->nchmaps);
 >> +     if (!snd->nchmaps)
 >> +             return 0;
 >> +
 >> +     snd->chmaps = devm_kcalloc(&vdev->dev, snd->nchmaps,
 >> +                                sizeof(*snd->chmaps), GFP_KERNEL);
 >> +     if (!snd->chmaps)
 >> +             return -ENOMEM;
 >> +
 >> +     rc = virtsnd_ctl_query_info(snd, VIRTIO_SND_R_CHMAP_INFO, 0,
 >> +                                 snd->nchmaps, sizeof(*snd->chmaps),
 >> +                                 snd->chmaps);
 >> +     if (rc)
 >> +             return rc;
 >> +
 >> +     /* Count the number of channel maps per each PCM device/stream. */
 >> +     for (i = 0; i < snd->nchmaps; ++i) {
 >> +             struct virtio_snd_chmap_info *info = &snd->chmaps[i];
 >> +             unsigned int nid = le32_to_cpu(info->hdr.hda_fn_nid);
 >> +             struct virtio_pcm *pcm;
 >> +             struct virtio_pcm_stream *stream;
 >> +
 >> +             pcm = virtsnd_pcm_find_or_create(snd, nid);
 >> +             if (IS_ERR(pcm))
 >> +                     return PTR_ERR(pcm);
 >> +
 >> +             switch (info->direction) {
 >> +             case VIRTIO_SND_D_OUTPUT: {
 >> +                     stream = &pcm->streams[SNDRV_PCM_STREAM_PLAYBACK];
 >> +                     break;
 >> +             }
 >> +             case VIRTIO_SND_D_INPUT: {
 >> +                     stream = &pcm->streams[SNDRV_PCM_STREAM_CAPTURE];
 >> +                     break;
 >> +             }
 >> +             default: {
 >> +                     dev_err(&vdev->dev,
 >> +                             "chmap #%u: unknown direction (%u)\n", i,
 >> +                             info->direction);
 >> +                     return -EINVAL;
 >> +             }
 >> +             }
 >> +
 >> +             stream->nchmaps++;
 >> +     }
 >> +
 >> +     return 0;
 >> +}
 >> +
 >> +/**
 >> + * virtsnd_chmap_add_ctls() - Create an ALSA control for channel maps.
 >> + * @pcm: ALSA PCM device.
 >> + * @direction: PCM stream direction (SNDRV_PCM_STREAM_XXX).
 >> + * @stream: VirtIO PCM stream.
 >> + *
 >> + * Context: Any context.
 >> + * Return: 0 on success, -errno on failure.
 >> + */
 >> +static int virtsnd_chmap_add_ctls(struct snd_pcm *pcm, int direction,
 >> +                               struct virtio_pcm_stream *stream)
 >> +{
 >> +     unsigned int i;
 >> +     int max_channels = 0;
 >> +
 >> +     for (i = 0; i < stream->nchmaps; i++)
 >> +             if (max_channels < stream->chmaps[i].channels)
 >> +                     max_channels = stream->chmaps[i].channels;
 >> +
 >> +     return snd_pcm_add_chmap_ctls(pcm, direction, stream->chmaps,
 >> +                                   max_channels, 0, NULL);
 >> +}
 >> +
 >> +/**
 >> + * virtsnd_chmap_build_devs() - Build ALSA controls for channel maps.
 >> + * @snd: VirtIO sound device.
 >> + *
 >> + * Context: Any context.
 >> + * Return: 0 on success, -errno on failure.
 >> + */
 >> +int virtsnd_chmap_build_devs(struct virtio_snd *snd)
 >> +{
 >> +     struct virtio_device *vdev = snd->vdev;
 >> +     struct virtio_pcm *pcm;
 >> +     struct virtio_pcm_stream *stream;
 >> +     unsigned int i;
 >> +     int rc;
 >> +
 >> +     /* Allocate channel map elements per each PCM device/stream. */
 >> +     list_for_each_entry(pcm, &snd->pcm_list, list) {
 >> +             for (i = 0; i < ARRAY_SIZE(pcm->streams); ++i) {
 >> +                     stream = &pcm->streams[i];
 >> +
 >> +                     if (!stream->nchmaps)
 >> +                             continue;
 >> +
 >> +                     stream->chmaps = devm_kcalloc(&vdev->dev,
 >> +                                                   stream->nchmaps + 1,
 >> +
 >> sizeof(*stream->chmaps),
 >> +                                                   GFP_KERNEL);
 >> +                     if (!stream->chmaps)
 >> +                             return -ENOMEM;
 >> +
 >> +                     stream->nchmaps = 0;
 >> +             }
 >> +     }
 >> +
 >> +     /* Initialize channel maps per each PCM device/stream. */
 >> +     for (i = 0; i < snd->nchmaps; ++i) {
 >> +             struct virtio_snd_chmap_info *info = &snd->chmaps[i];
 >> +             unsigned int nid = le32_to_cpu(info->hdr.hda_fn_nid);
 >> +             unsigned int channels = info->channels;
 >> +             unsigned int ch;
 >> +             struct snd_pcm_chmap_elem *chmap;
 >> +
 >> +             pcm = virtsnd_pcm_find(snd, nid);
 >> +             if (IS_ERR(pcm))
 >> +                     return PTR_ERR(pcm);
 >> +
 >> +             if (info->direction == VIRTIO_SND_D_OUTPUT)
 >> +                     stream = &pcm->streams[SNDRV_PCM_STREAM_PLAYBACK];
 >> +             else
 >> +                     stream = &pcm->streams[SNDRV_PCM_STREAM_CAPTURE];
 >> +
 >> +             chmap = &stream->chmaps[stream->nchmaps++];
 >> +
 >> +             if (channels > ARRAY_SIZE(chmap->map))
 >> +                     channels = ARRAY_SIZE(chmap->map);
 >> +
 >> +             chmap->channels = channels;
 >> +
 >> +             for (ch = 0; ch < channels; ++ch) {
 >> +                     u8 position = info->positions[ch];
 >> +
 >> +                     if (position >= ARRAY_SIZE(g_v2a_position_map))
 >> +                             return -EINVAL;
 >> +
 >> +                     chmap->map[ch] = g_v2a_position_map[position];
 >> +             }
 >> +     }
 >
 > You enter this function after virtsnd_chmap_parse_cfg() has run. And
 > virtsnd_chmap_parse_cfg() has already found or created all the PCMs and
 > counted channel maps - the same way as you do in the above loop. Wouldn't
 > it be enough to reuse the result of that counting and avoid re-counting
 > here?

If I understood your question right, then... it's not re-counting here. :)
It's just a referencing to each channel map for each stream in one by
one manner.


 >> +
 >> +     /* Create an ALSA control per each PCM device/stream. */
 >> +     list_for_each_entry(pcm, &snd->pcm_list, list) {
 >> +             if (!pcm->pcm)
 >> +                     continue;
 >> +
 >> +             for (i = 0; i < ARRAY_SIZE(pcm->streams); ++i) {
 >> +                     stream = &pcm->streams[i];
 >> +
 >> +                     if (!stream->nchmaps)
 >> +                             continue;
 >> +
 >> +                     rc = virtsnd_chmap_add_ctls(pcm->pcm, i, stream);
 >> +                     if (rc)
 >> +                             return rc;
 >> +             }
 >> +     }
 >> +
 >> +     return 0;
 >> +}
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
