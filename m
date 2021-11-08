Return-Path: <SRS0=GFjK=P3=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89FFDC433EF
	for <virtualization@archiver.kernel.org>; Mon,  8 Nov 2021 09:32:00 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C4FB61284
	for <virtualization@archiver.kernel.org>; Mon,  8 Nov 2021 09:32:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3C4FB61284
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 321AC6077D;
	Mon,  8 Nov 2021 09:31:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Oeou9bPEl1Ev; Mon,  8 Nov 2021 09:31:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id BFDB96059A;
	Mon,  8 Nov 2021 09:31:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0F910C0035;
	Mon,  8 Nov 2021 09:31:57 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 89C94C0012
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Nov 2021 09:31:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 854C640207
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Nov 2021 09:31:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=suse.de header.b="uAnMa/J7";
 dkim=neutral reason="invalid (unsupported algorithm ed25519-sha256)"
 header.d=suse.de header.b="m4SuzB/K"
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MR32WeiXuPh7
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Nov 2021 09:31:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3E1B64013E
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Nov 2021 09:31:55 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 2D3761FD71;
 Mon,  8 Nov 2021 09:31:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1636363913; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=5XyQx0AR4GPq5hVW1Qc5M0q7dshvnisHzKYMYXuS6aY=;
 b=uAnMa/J74iDjOx7Ds5xZraGMBn6PTJAgRbJ2/op62jbOc/tLXshx+k8a+UETyamy1p1m1f
 Co5F3R9jS80pL63lHYT1dXBBtqh5bZoaoPHa9NjMexlYzevIYqSX5UEXKkyobOSB1p6Zr2
 Kzvv7RDLJW8Ry7c3GCJB1Ysa1dvgj/4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1636363913;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=5XyQx0AR4GPq5hVW1Qc5M0q7dshvnisHzKYMYXuS6aY=;
 b=m4SuzB/KpGriWkhlzDfl8ta39h56SY9bwdifRsL0AX2d+eki3qIm4xjg1gttOOf2JzOjUA
 pnWd2le0IqHbIgBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F076413B04;
 Mon,  8 Nov 2021 09:31:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id nQN/OYjuiGFXfAAAMHmgww
 (envelope-from <tzimmermann@suse.de>); Mon, 08 Nov 2021 09:31:52 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: daniel@ffwll.ch, airlied@linux.ie, mripard@kernel.org,
 maarten.lankhorst@linux.intel.com
Subject: [PATCH v2 0/3] drm/shmem-helper: Cleanup public interface
Date: Mon,  8 Nov 2021 10:31:46 +0100
Message-Id: <20211108093149.7226-1-tzimmermann@suse.de>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Cc: Thomas Zimmermann <tzimmermann@suse.de>, lima@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org
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

The interface of GEM SHMEM helpers inconsistently uses either struct
drm_gem_object or drm_gem_shmem_object for the GEM object. Convert GEM
SHMEM functions to accept struct drm_gem_shmem_object, provide small
wrappers for GEM object callbacks and update all users.

Converting all GEM object functions to use drm_gem_shmem_object enables
type checking by the C compiler. Previous callers could have passed any
implementation of drm_gem_object to the GEM SHMEM helpers. It also
removes upcasting in the GEM functions and simplifies the caller side.
No functional changes.

For GEM object callbacks, the SHMEM helper library now provides a
number of small wrappers that do the necessary upcasting. Again no
functional changes.

v2:
	* documentation fixes and updates (Daniel)

Thomas Zimmermann (3):
  drm/shmem-helper: Unexport drm_gem_shmem_create_with_handle()
  drm/shmem-helper: Export dedicated wrappers for GEM object functions
  drm/shmem-helper: Pass GEM shmem object in public interfaces

 drivers/gpu/drm/drm_gem_shmem_helper.c        | 131 ++++++--------
 drivers/gpu/drm/lima/lima_gem.c               |  18 +-
 drivers/gpu/drm/lima/lima_sched.c             |   4 +-
 drivers/gpu/drm/panfrost/panfrost_drv.c       |   2 +-
 drivers/gpu/drm/panfrost/panfrost_gem.c       |  20 ++-
 .../gpu/drm/panfrost/panfrost_gem_shrinker.c  |   2 +-
 drivers/gpu/drm/panfrost/panfrost_mmu.c       |   5 +-
 drivers/gpu/drm/panfrost/panfrost_perfcnt.c   |   6 +-
 drivers/gpu/drm/v3d/v3d_bo.c                  |  22 +--
 drivers/gpu/drm/virtio/virtgpu_object.c       |  27 ++-
 include/drm/drm_gem_shmem_helper.h            | 168 +++++++++++++++---
 11 files changed, 256 insertions(+), 149 deletions(-)


base-commit: 215295e7b0a3deb2015c6d6b343b319e4f6d9a1d
--
2.33.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
