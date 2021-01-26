Return-Path: <SRS0=+Z4V=G5=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C08B1C433DB
	for <virtualization@archiver.kernel.org>; Tue, 26 Jan 2021 07:26:07 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A52E22D58
	for <virtualization@archiver.kernel.org>; Tue, 26 Jan 2021 07:26:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A52E22D58
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id C851C86FFC;
	Tue, 26 Jan 2021 07:26:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jE66e69DdEXk; Tue, 26 Jan 2021 07:26:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 072DF86FFA;
	Tue, 26 Jan 2021 07:26:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E2DC2C0FA7;
	Tue, 26 Jan 2021 07:26:05 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A88EDC013A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Jan 2021 07:26:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 9504F86777
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Jan 2021 07:26:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id o-xmEkJ6hC7Z
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Jan 2021 07:26:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 1CD228677D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Jan 2021 07:26:03 +0000 (UTC)
IronPort-SDR: eufDUoUdG6Q3LFytb/bKtLog47+cht7Z0qMu8p463s4ztu9H5e72HsQuQ/iTkTLBdhBPbUs/eo
 mXqkYhP8HfEg==
X-IronPort-AV: E=McAfee;i="6000,8403,9875"; a="264684678"
X-IronPort-AV: E=Sophos;i="5.79,375,1602572400"; d="scan'208";a="264684678"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jan 2021 23:26:02 -0800
IronPort-SDR: Sd5dS09jU/hBm6xU+DWJk8sUX/O9t+7dGZwRVHfAOilhhBCQCOJTOb8K/pIcZfNyzFi2khNo+8
 eiASdJp37QAg==
X-IronPort-AV: E=Sophos;i="5.79,375,1602572400"; d="scan'208";a="387723377"
Received: from kleve-mobl1.ger.corp.intel.com (HELO ubuntu) ([10.252.52.33])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jan 2021 23:26:00 -0800
Date: Tue, 26 Jan 2021 08:25:58 +0100 (CET)
From: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
To: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Subject: Re: [PATCH v2 6/9] ALSA: virtio: PCM substream operators
In-Reply-To: <7b4fa4c1-4af1-47b5-d2e6-bb2f81e75488@intel.com>
Message-ID: <d92151ca-cde3-d1e6-23fe-f0c671379e9@intel.com>
References: <20210124165408.1122868-1-anton.yakovlev@opensynergy.com>
 <20210124165408.1122868-7-anton.yakovlev@opensynergy.com>
 <7b4fa4c1-4af1-47b5-d2e6-bb2f81e75488@intel.com>
MIME-Version: 1.0
Cc: virtio-dev@lists.oasis-open.org, alsa-devel@alsa-project.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Takashi Iwai <tiwai@suse.com>,
 linux-kernel@vger.kernel.org, Jaroslav Kysela <perex@perex.cz>,
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

One more thing I missed yesterday:

On Mon, 25 Jan 2021, Guennadi Liakhovetski wrote:

>
> On Sun, 24 Jan 2021, Anton Yakovlev wrote:
>
>> Introduce the operators required for the operation of substreams.
>> 
>> Signed-off-by: Anton Yakovlev <anton.yakovlev@opensynergy.com>
>> ---
>> sound/virtio/Makefile         |   3 +-
>> sound/virtio/virtio_pcm.c     |   5 +-
>> sound/virtio/virtio_pcm.h     |   2 +
>> sound/virtio/virtio_pcm_ops.c | 513 ++++++++++++++++++++++++++++++++++
>> 4 files changed, 521 insertions(+), 2 deletions(-)
>> create mode 100644 sound/virtio/virtio_pcm_ops.c
>
> [snip]
>
>> diff --git a/sound/virtio/virtio_pcm_ops.c b/sound/virtio/virtio_pcm_ops.c
>> new file mode 100644
>> index 000000000000..19882777fcd6
>> --- /dev/null
>> +++ b/sound/virtio/virtio_pcm_ops.c
>> @@ -0,0 +1,513 @@
>
> [snip]
>
>> +/**
>> + * virtsnd_pcm_release() - Release the PCM substream on the device side.
>> + * @substream: VirtIO substream.
>> + *
>> + * Context: Any context that permits to sleep.
>> + * Return: 0 on success, -errno on failure.
>> + */
>> +static inline bool virtsnd_pcm_released(struct virtio_pcm_substream 
>> *substream)
>> +{
>> +	/*
>> +	 * The spec states that upon receipt of the RELEASE command "the 
>> device
>> +	 * MUST complete all pending I/O messages for the specified stream 
>> ID".
>> +	 * Thus, we consider the absence of I/O messages in the queue as an
>> +	 * indication that the substream has been released.
>> +	 */
>> +	return atomic_read(&substream->msg_count) == 0;
>
> Also here having it atomic doesn't really seem to help. This just means, that 
> at some point of time it was == 0.
>
>> +}
>> +
>> +static int virtsnd_pcm_release(struct virtio_pcm_substream *substream)
>
> kernel-doc missing
>
>> +{
>> +	struct virtio_snd *snd = substream->snd;
>> +	struct virtio_snd_msg *msg;
>> +	unsigned int js = msecs_to_jiffies(msg_timeout_ms);
>> +	int rc;
>> +
>> +	msg = virtsnd_pcm_ctl_msg_alloc(substream, VIRTIO_SND_R_PCM_RELEASE,
>> +					GFP_KERNEL);
>> +	if (IS_ERR(msg))
>> +		return PTR_ERR(msg);
>> +
>> +	rc = virtsnd_ctl_msg_send_sync(snd, msg);
>> +	if (rc)
>> +		return rc;
>> +
>> +	return wait_event_interruptible_timeout(substream->msg_empty,
>> +						virtsnd_pcm_released(substream),
>> +						js);

wait_event_interruptible_timeout() will return a positive number in 
success cases, 0 means a timeout and condition still false. Whereas when 
you call this function you interpret 0 as success and you expect any != 0 
to be a negative error. Wondering how this worked during your tests?

Thanks
Guennadi
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
