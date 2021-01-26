Return-Path: <SRS0=+Z4V=G5=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FEB5C433DB
	for <virtualization@archiver.kernel.org>; Tue, 26 Jan 2021 07:40:53 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9146E22273
	for <virtualization@archiver.kernel.org>; Tue, 26 Jan 2021 07:40:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9146E22273
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 494E987000;
	Tue, 26 Jan 2021 07:40:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id aVrLVv09zYI1; Tue, 26 Jan 2021 07:40:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 66E2D86F3F;
	Tue, 26 Jan 2021 07:40:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 45D26C0FA7;
	Tue, 26 Jan 2021 07:40:50 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 12F0DC013A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Jan 2021 07:40:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 01168851A4
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Jan 2021 07:40:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QbCyRZeJULuB
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Jan 2021 07:40:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 9E98285118
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Jan 2021 07:40:47 +0000 (UTC)
IronPort-SDR: KaZ0lnFGjBz4QGby7zxRkiTdX+SYNFLDH3ftOEk5bXVFmghKZIe3FP0qHgMpxVD7eej3uQ5cfJ
 s++hV2u/lVyA==
X-IronPort-AV: E=McAfee;i="6000,8403,9875"; a="241391575"
X-IronPort-AV: E=Sophos;i="5.79,375,1602572400"; d="scan'208";a="241391575"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jan 2021 23:40:45 -0800
IronPort-SDR: zgP8Qm+Gvv16cNo08q7txgjrXUAHycE6DfPglon2E99+Tj1Ov+xN+jww9nqH65/mWfOgqC6HX3
 XZcYxqUhNXKg==
X-IronPort-AV: E=Sophos;i="5.79,375,1602572400"; d="scan'208";a="387728025"
Received: from kleve-mobl1.ger.corp.intel.com (HELO ubuntu) ([10.252.52.33])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jan 2021 23:40:43 -0800
Date: Tue, 26 Jan 2021 08:40:41 +0100 (CET)
From: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
To: Anton Yakovlev <anton.yakovlev@opensynergy.com>
Subject: Re: [PATCH v2 7/9] ALSA: virtio: introduce jack support
In-Reply-To: <20210124165408.1122868-8-anton.yakovlev@opensynergy.com>
Message-ID: <8dce1870-9ffe-949d-ee5a-f2564f88ac5@intel.com>
References: <20210124165408.1122868-1-anton.yakovlev@opensynergy.com>
 <20210124165408.1122868-8-anton.yakovlev@opensynergy.com>
MIME-Version: 1.0
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


On Sun, 24 Jan 2021, Anton Yakovlev wrote:

> Enumerate all available jacks and create ALSA controls.
>
> At the moment jacks have a simple implementation and can only be used
> to receive notifications about a plugged in/out device.
>
> Signed-off-by: Anton Yakovlev <anton.yakovlev@opensynergy.com>
> ---
> sound/virtio/Makefile      |   1 +
> sound/virtio/virtio_card.c |  18 +++
> sound/virtio/virtio_card.h |  12 ++
> sound/virtio/virtio_jack.c | 255 +++++++++++++++++++++++++++++++++++++
> 4 files changed, 286 insertions(+)
> create mode 100644 sound/virtio/virtio_jack.c

[snip]

> diff --git a/sound/virtio/virtio_jack.c b/sound/virtio/virtio_jack.c
> new file mode 100644
> index 000000000000..83593c59f6bf
> --- /dev/null
> +++ b/sound/virtio/virtio_jack.c
> @@ -0,0 +1,255 @@

[snip]

> +/**
> + * virtsnd_jack_parse_cfg() - Parse the jack configuration.
> + * @snd: VirtIO sound device.
> + *
> + * This function is called during initial device initialization.
> + *
> + * Context: Any context that permits to sleep.
> + * Return: 0 on success, -errno on failure.
> + */
> +int virtsnd_jack_parse_cfg(struct virtio_snd *snd)
> +{
> +	struct virtio_device *vdev = snd->vdev;
> +	struct virtio_snd_jack_info *info;
> +	unsigned int i;
> +	int rc;
> +
> +	virtio_cread(vdev, struct virtio_snd_config, jacks, &snd->njacks);
> +	if (!snd->njacks)
> +		return 0;
> +
> +	snd->jacks = devm_kcalloc(&vdev->dev, snd->njacks, sizeof(*snd->jacks),
> +				  GFP_KERNEL);
> +	if (!snd->jacks)
> +		return -ENOMEM;
> +
> +	info = devm_kcalloc(&vdev->dev, snd->njacks, sizeof(*info), GFP_KERNEL);

just kcalloc()

> +	if (!info)
> +		return -ENOMEM;
> +
> +	rc = virtsnd_ctl_query_info(snd, VIRTIO_SND_R_JACK_INFO, 0, snd->njacks,
> +				    sizeof(*info), info);
> +	if (rc)
> +		return rc;
> +
> +	for (i = 0; i < snd->njacks; ++i) {
> +		struct virtio_jack *jack = &snd->jacks[i];
> +		struct virtio_pcm *pcm;
> +
> +		jack->nid = le32_to_cpu(info[i].hdr.hda_fn_nid);
> +		jack->features = le32_to_cpu(info[i].features);
> +		jack->defconf = le32_to_cpu(info[i].hda_reg_defconf);
> +		jack->caps = le32_to_cpu(info[i].hda_reg_caps);
> +		jack->connected = info[i].connected;
> +
> +		pcm = virtsnd_pcm_find_or_create(snd, jack->nid);
> +		if (IS_ERR(pcm))
> +			return PTR_ERR(pcm);
> +	}
> +
> +	devm_kfree(&vdev->dev, info);
> +
> +	return 0;
> +}

Thanks
Guennadi
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
