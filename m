Return-Path: <SRS0=H/CR=HL=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16EABC433DB
	for <virtualization@archiver.kernel.org>; Tue,  9 Feb 2021 12:40:41 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 853B264E50
	for <virtualization@archiver.kernel.org>; Tue,  9 Feb 2021 12:40:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 853B264E50
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=opensynergy.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 48A688639F;
	Tue,  9 Feb 2021 12:40:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nNmMh-anwKfN; Tue,  9 Feb 2021 12:40:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 66A1E862D4;
	Tue,  9 Feb 2021 12:40:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3CBFAC1D9F;
	Tue,  9 Feb 2021 12:40:39 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 30C21C013A
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Feb 2021 12:40:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 1FCE086788
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Feb 2021 12:40:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ePzZpnJ4WWC6
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Feb 2021 12:40:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx1.opensynergy.com (mx1.opensynergy.com [217.66.60.4])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 1DA9186678
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Feb 2021 12:40:36 +0000 (UTC)
Received: from SR-MAILGATE-02.opensynergy.com (localhost.localdomain
 [127.0.0.1])
 by mx1.opensynergy.com (Proxmox) with ESMTP id 61BA0A15F7;
 Tue,  9 Feb 2021 13:40:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=opensynergy.com;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:from:from:message-id:mime-version:reply-to:subject:subject
 :to:to; s=srmailgate02; bh=DhKooPdZHZSbFwcus3VYCgE1dkJZGK8NHt1WJ
 eUPXxM=; b=R7P38M2xUWYiiWKyWwTDampjS0hvOEGOVHLgvrjaWK7wbp6qVLx1A
 QndrrutstOOJ4LIJhnZGJnzSacQrkoxbIAMqRABxLOZx4G1NKEhoL6mPtwwSkaLG
 WB/3DTxyE1Gl8GLWRm/SqiW30y51tbMQGvG7K+McqBfo+tWx4o61N4EO9xWcRD4W
 SL+nF68iCHDNz6UzPueKNDWsdcL3ZRpm/zU6fOuoBy737szuvMVWnST3axKokBaP
 LU88UXMhEUzn81HTSBKL+jQ3p3GaCub8sUyqNL4RWiasCHekWzRPQS7F9D5u/XJ5
 6Jyu/R+c4+1L+45FOB3KVJg/ydRJVAj7g==
From: Anton Yakovlev <anton.yakovlev@opensynergy.com>
To: <virtualization@lists.linux-foundation.org>,
 <alsa-devel@alsa-project.org>, <virtio-dev@lists.oasis-open.org>
Subject: [PATCH v3 0/9] ALSA: add virtio sound driver
Date: Tue, 9 Feb 2021 13:40:01 +0100
Message-ID: <20210209124011.1224628-1-anton.yakovlev@opensynergy.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
X-ClientProxiedBy: SR-MAIL-02.open-synergy.com (10.26.10.22) To
 SR-MAIL-01.open-synergy.com (10.26.10.21)
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

This series implements a driver part of the virtio sound device
specification v8 [1].

The driver supports PCM playback and capture substreams, jack and
channel map controls. A message-based transport is used to write/read
PCM frames to/from a device.

As a device part was used OpenSynergy proprietary implementation.

Any comments are very welcome.

v3 changes:
- Fixed license headers for all files.
- Many coding style and kernel doc fixes.
- Replaced devm_kmalloc/devm_kfree with kmalloc/kfree wherever appropriate.
- Made the names of the card and PCM devices more informative.
- To process the DEVICE_NEEDS_RESET status, simply call device_reprobe().
- For control messages replaced atomic_t by refcount_t for the reference counter
  and simplified the general logic.
- Use vmalloc'ed managed buffer for PCM substreams.
- Replaced all atomic fields in the virtio substream structure with
  non-atomic + spinlock.
- Use the non-atomic PCM ops.
- Use ops->sync_stop() to release the substream on the device side.
- Rebased and tested on top of v5.11-rc6.

v2 changes:
- For some reason, in the previous patch series, several patches were
  squashed. Fixed this issue to make the review easier.
- Added mst@redhat.com to the MAINTAINERS.
- When creating virtqueues, now only the event virtqueue is disabled.
  It's enabled only after successful initialization of the device.
- Added additional comments to the reset worker function:
  [2/9] virtio_card.c:virtsnd_reset_fn()
- Added check that VIRTIO_F_VERSION_1 feature bit is set.
- Added additional comments to the device removing function:
  [2/9] virtio_card.c:virtsnd_remove()
- Added additional comments to the tx/rx interrupt handler:
  [5/9] virtio_pcm_msg.c:virtsnd_pcm_msg_complete()
- Added additional comments to substream release wait function.
  [6/9] virtio_pcm_ops.c:virtsnd_pcm_released()

[1] https://lists.oasis-open.org/archives/virtio-dev/202003/msg00185.html


Anton Yakovlev (9):
  uapi: virtio_ids: add a sound device type ID from OASIS spec
  ALSA: virtio: add virtio sound driver
  ALSA: virtio: handling control messages
  ALSA: virtio: build PCM devices and substream hardware descriptors
  ALSA: virtio: handling control and I/O messages for the PCM device
  ALSA: virtio: PCM substream operators
  ALSA: virtio: introduce jack support
  ALSA: virtio: introduce PCM channel map support
  ALSA: virtio: introduce device suspend/resume support

 MAINTAINERS                     |   9 +
 include/uapi/linux/virtio_ids.h |   1 +
 include/uapi/linux/virtio_snd.h | 334 +++++++++++++++++++++
 sound/Kconfig                   |   2 +
 sound/Makefile                  |   3 +-
 sound/virtio/Kconfig            |  10 +
 sound/virtio/Makefile           |  13 +
 sound/virtio/virtio_card.c      | 462 +++++++++++++++++++++++++++++
 sound/virtio/virtio_card.h      | 113 ++++++++
 sound/virtio/virtio_chmap.c     | 219 ++++++++++++++
 sound/virtio/virtio_ctl_msg.c   | 311 ++++++++++++++++++++
 sound/virtio/virtio_ctl_msg.h   |  78 +++++
 sound/virtio/virtio_jack.c      | 233 +++++++++++++++
 sound/virtio/virtio_pcm.c       | 499 ++++++++++++++++++++++++++++++++
 sound/virtio/virtio_pcm.h       | 121 ++++++++
 sound/virtio/virtio_pcm_msg.c   | 393 +++++++++++++++++++++++++
 sound/virtio/virtio_pcm_ops.c   | 493 +++++++++++++++++++++++++++++++
 17 files changed, 3293 insertions(+), 1 deletion(-)
 create mode 100644 include/uapi/linux/virtio_snd.h
 create mode 100644 sound/virtio/Kconfig
 create mode 100644 sound/virtio/Makefile
 create mode 100644 sound/virtio/virtio_card.c
 create mode 100644 sound/virtio/virtio_card.h
 create mode 100644 sound/virtio/virtio_chmap.c
 create mode 100644 sound/virtio/virtio_ctl_msg.c
 create mode 100644 sound/virtio/virtio_ctl_msg.h
 create mode 100644 sound/virtio/virtio_jack.c
 create mode 100644 sound/virtio/virtio_pcm.c
 create mode 100644 sound/virtio/virtio_pcm.h
 create mode 100644 sound/virtio/virtio_pcm_msg.c
 create mode 100644 sound/virtio/virtio_pcm_ops.c

-- 
2.30.0


_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
