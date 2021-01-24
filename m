Return-Path: <SRS0=rEPQ=G3=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_RED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91A33C433DB
	for <virtualization@archiver.kernel.org>; Sun, 24 Jan 2021 16:54:27 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2947422CA2
	for <virtualization@archiver.kernel.org>; Sun, 24 Jan 2021 16:54:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2947422CA2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=opensynergy.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id D163820407;
	Sun, 24 Jan 2021 16:54:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0kwQizXzpvfI; Sun, 24 Jan 2021 16:54:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 570432042D;
	Sun, 24 Jan 2021 16:54:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3E0D0C0FA7;
	Sun, 24 Jan 2021 16:54:25 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E2563C013A
 for <virtualization@lists.linux-foundation.org>;
 Sun, 24 Jan 2021 16:54:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id D0EC58558A
 for <virtualization@lists.linux-foundation.org>;
 Sun, 24 Jan 2021 16:54:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Bn5foPYvK8Tn
 for <virtualization@lists.linux-foundation.org>;
 Sun, 24 Jan 2021 16:54:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx1.opensynergy.com (mx1.opensynergy.com [217.66.60.4])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 2D0F885572
 for <virtualization@lists.linux-foundation.org>;
 Sun, 24 Jan 2021 16:54:24 +0000 (UTC)
Received: from SR-MAILGATE-02.opensynergy.com (localhost.localdomain
 [127.0.0.1])
 by mx1.opensynergy.com (Proxmox) with ESMTP id C2D0FA1474;
 Sun, 24 Jan 2021 17:54:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=opensynergy.com;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:from:from:message-id:mime-version:reply-to:subject:subject
 :to:to; s=srmailgate02; bh=407DwG5ueGDAX8UwpLnKp71Ue2el151hR6ieo
 eo9Lsw=; b=wTWwrbJojW2Q5Vvv5xNXSCFFHQ9MxSVVkFpTe4RCu+x03TQ5hVZxJ
 N/GkqQ59+LUsGTd+ZK/KkHqSZIHJCUQ2Nj/FRxxFATAon/V+hSz3+5TSdjUA22mz
 PluxMQc6nH0JZE+Jkbsh9X6eIHjNW9X5+UQJnoih+zGslMLVnMTPU2zyR2sGLpVL
 YXwn1yrfcnXai16HNxHFHLSFHioSWou5nYiOegRn5p/UC8pw4RNsEaxUU9qvairm
 IglVYW6fkI0pLYJXomFbXBAS60FuQC1djE+yVLMmevNpBmQcr3AnNR5Bq/T9uBrq
 LtSb6OguYinjczdj6BpjH93pgTHqa7VEw==
From: Anton Yakovlev <anton.yakovlev@opensynergy.com>
To: <virtualization@lists.linux-foundation.org>,
 <alsa-devel@alsa-project.org>, <virtio-dev@lists.oasis-open.org>
Subject: [PATCH v2 0/9] ALSA: add virtio sound driver
Date: Sun, 24 Jan 2021 17:53:59 +0100
Message-ID: <20210124165408.1122868-1-anton.yakovlev@opensynergy.com>
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

The series is based (and was actually tested) on Linus's master
branch [2], on top of

commit 1e2a199f6ccd ("Merge tag 'spi-fix-v5.11-rc4' of ...")

As a device part was used OpenSynergy proprietary implementation.

Any comments are very welcome.

v1->v2 changes:

1. For some reason, in the previous patch series, several patches were
   squashed. Fixed this issue to make the review easier.
2. Added mst@redhat.com to the MAINTAINERS.
3. When creating virtqueues, now only the event virtqueue is disabled.
   It's enabled only after successful initialization of the device.
4. Added additional comments to the reset worker function:
   [2/9] virtio_card.c:virtsnd_reset_fn()
5. Added check that VIRTIO_F_VERSION_1 feature bit is set.
6. Added additional comments to the device removing function:
   [2/9] virtio_card.c:virtsnd_remove()
7. Added additional comments to the tx/rx interrupt handler:
   [5/9] virtio_pcm_msg.c:virtsnd_pcm_msg_complete()
8. Added additional comments to substream release wait function.
   [6/9] virtio_pcm_ops.c:virtsnd_pcm_released()

[1] https://lists.oasis-open.org/archives/virtio-dev/202003/msg00185.html
[2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git


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
 include/uapi/linux/virtio_snd.h | 361 ++++++++++++++++++++
 sound/Kconfig                   |   2 +
 sound/Makefile                  |   3 +-
 sound/virtio/Kconfig            |  10 +
 sound/virtio/Makefile           |  13 +
 sound/virtio/virtio_card.c      | 577 +++++++++++++++++++++++++++++++
 sound/virtio/virtio_card.h      | 121 +++++++
 sound/virtio/virtio_chmap.c     | 237 +++++++++++++
 sound/virtio/virtio_ctl_msg.c   | 293 ++++++++++++++++
 sound/virtio/virtio_ctl_msg.h   | 122 +++++++
 sound/virtio/virtio_jack.c      | 255 ++++++++++++++
 sound/virtio/virtio_pcm.c       | 582 ++++++++++++++++++++++++++++++++
 sound/virtio/virtio_pcm.h       | 132 ++++++++
 sound/virtio/virtio_pcm_msg.c   | 325 ++++++++++++++++++
 sound/virtio/virtio_pcm_ops.c   | 528 +++++++++++++++++++++++++++++
 17 files changed, 3570 insertions(+), 1 deletion(-)
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
