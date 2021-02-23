Return-Path: <SRS0=5J/L=HZ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52A12C433DB
	for <virtualization@archiver.kernel.org>; Tue, 23 Feb 2021 12:34:08 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE05A64E57
	for <virtualization@archiver.kernel.org>; Tue, 23 Feb 2021 12:34:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE05A64E57
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=opensynergy.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id A8F5B855DF;
	Tue, 23 Feb 2021 12:34:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8XfUd4FBDKkd; Tue, 23 Feb 2021 12:34:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 840E08544C;
	Tue, 23 Feb 2021 12:34:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4E56DC000A;
	Tue, 23 Feb 2021 12:34:06 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 84D47C0001
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Feb 2021 12:34:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 667E883103
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Feb 2021 12:34:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nSI4Dd8fZnTv
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Feb 2021 12:34:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx1.opensynergy.com (mx1.opensynergy.com [217.66.60.4])
 by smtp1.osuosl.org (Postfix) with ESMTPS id ED42F82F2D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Feb 2021 12:34:02 +0000 (UTC)
Received: from SR-MAILGATE-02.opensynergy.com (localhost.localdomain
 [127.0.0.1])
 by mx1.opensynergy.com (Proxmox) with ESMTP id 901FCA12AF;
 Tue, 23 Feb 2021 13:33:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=opensynergy.com;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:from:from:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=srmailgate02; bh=N7kU7TdyBUb1
 Lf1mi8iPXCBOHmyPhVHN4c/XFIymx08=; b=IpBWL1vQ38MdMKyAxRrulOobVdt1
 nmPiXJk3UYt8mSolimHTpWKMKL0npjTeyj8zk9vzxEnCXUYnzZSJZ7R6AIPigWOR
 DtygCVLtMaYpnZfvV5CWuRgxeImsealE4uZk01MqkD7h0y/ap+DG7TfEPX1KCxS7
 KKE6bw89Mg0pofVToLWP1FRnB5Ppp3az4S66Pj2wwG4OuSR6ZzHAEEQWsAi87UZ9
 YWGqG1lxnW4wsO3BqkhXG9zFDf2m8qhuz5vakehoQZjziBusmMpe0qNF/cI7MNBt
 eBmizFAJmQZW9VcXnw/Hp9oYnr315Kd7rwPcuQaeNGLyOdkqMo3vFPRsBg==
Subject: Re: [virtio-dev] Re: [PATCH v5 0/9] ALSA: add virtio sound driver
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20210222153444.348390-1-anton.yakovlev@opensynergy.com>
 <20210223070839-mutt-send-email-mst@kernel.org>
From: Anton Yakovlev <anton.yakovlev@opensynergy.com>
Message-ID: <bce13fa2-3ee5-0c6c-5761-17f0389c2d7b@opensynergy.com>
Date: Tue, 23 Feb 2021 13:33:57 +0100
MIME-Version: 1.0
In-Reply-To: <20210223070839-mutt-send-email-mst@kernel.org>
Content-Language: en-US
X-ClientProxiedBy: SR-MAIL-02.open-synergy.com (10.26.10.22) To
 SR-MAIL-02.open-synergy.com (10.26.10.22)
Cc: virtio-dev@lists.oasis-open.org, alsa-devel@alsa-project.org,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
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

On 23.02.2021 13:09, Michael S. Tsirkin wrote:
> On Mon, Feb 22, 2021 at 04:34:35PM +0100, Anton Yakovlev wrote:
>> This series implements a driver part of the virtio sound device
>> specification v8 [1].
>>
>> The driver supports PCM playback and capture substreams, jack and
>> channel map controls. A message-based transport is used to write/read
>> PCM frames to/from a device.
>>
>> As a device part was used OpenSynergy proprietary implementation.
>>
>> v5 changes:
>>   - Fixed another bunch of sparse warnings
>>     (replaced virtio_cread() -> virtio_cread_le()), no functional changes.
>> (Sorry, I didn't know how to run sparse locally, now everything should be fixed)
>>
>> [1] https://lists.oasis-open.org/archives/virtio-dev/202003/msg00185.html
> 
> 
> In the future please number patches from 1, not from 2.
> thanks!

But they are numbered automatically by git. Patch #1 is for virtio_ids.h


>>
>> Anton Yakovlev (9):
>>    uapi: virtio_ids: add a sound device type ID from OASIS spec
>>    ALSA: virtio: add virtio sound driver
>>    ALSA: virtio: handling control messages
>>    ALSA: virtio: build PCM devices and substream hardware descriptors
>>    ALSA: virtio: handling control and I/O messages for the PCM device
>>    ALSA: virtio: PCM substream operators
>>    ALSA: virtio: introduce jack support
>>    ALSA: virtio: introduce PCM channel map support
>>    ALSA: virtio: introduce device suspend/resume support
>>
>>   MAINTAINERS                     |   9 +
>>   include/uapi/linux/virtio_ids.h |   1 +
>>   include/uapi/linux/virtio_snd.h | 334 +++++++++++++++++++++
>>   sound/Kconfig                   |   2 +
>>   sound/Makefile                  |   3 +-
>>   sound/virtio/Kconfig            |  10 +
>>   sound/virtio/Makefile           |  13 +
>>   sound/virtio/virtio_card.c      | 462 +++++++++++++++++++++++++++++
>>   sound/virtio/virtio_card.h      | 113 ++++++++
>>   sound/virtio/virtio_chmap.c     | 219 ++++++++++++++
>>   sound/virtio/virtio_ctl_msg.c   | 310 ++++++++++++++++++++
>>   sound/virtio/virtio_ctl_msg.h   |  78 +++++
>>   sound/virtio/virtio_jack.c      | 233 +++++++++++++++
>>   sound/virtio/virtio_pcm.c       | 498 ++++++++++++++++++++++++++++++++
>>   sound/virtio/virtio_pcm.h       | 120 ++++++++
>>   sound/virtio/virtio_pcm_msg.c   | 392 +++++++++++++++++++++++++
>>   sound/virtio/virtio_pcm_ops.c   | 491 +++++++++++++++++++++++++++++++
>>   17 files changed, 3287 insertions(+), 1 deletion(-)
>>   create mode 100644 include/uapi/linux/virtio_snd.h
>>   create mode 100644 sound/virtio/Kconfig
>>   create mode 100644 sound/virtio/Makefile
>>   create mode 100644 sound/virtio/virtio_card.c
>>   create mode 100644 sound/virtio/virtio_card.h
>>   create mode 100644 sound/virtio/virtio_chmap.c
>>   create mode 100644 sound/virtio/virtio_ctl_msg.c
>>   create mode 100644 sound/virtio/virtio_ctl_msg.h
>>   create mode 100644 sound/virtio/virtio_jack.c
>>   create mode 100644 sound/virtio/virtio_pcm.c
>>   create mode 100644 sound/virtio/virtio_pcm.h
>>   create mode 100644 sound/virtio/virtio_pcm_msg.c
>>   create mode 100644 sound/virtio/virtio_pcm_ops.c
>>
>> --
>> 2.30.0
>>
> 
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

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
