Return-Path: <SRS0=3a2n=EM=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81E75C4741F
	for <virtualization@archiver.kernel.org>; Fri,  6 Nov 2020 15:26:41 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01CAD20704
	for <virtualization@archiver.kernel.org>; Fri,  6 Nov 2020 15:26:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01CAD20704
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id A70712E134;
	Fri,  6 Nov 2020 15:26:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id M1d24xbJ4pn8; Fri,  6 Nov 2020 15:26:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 7AABA2E12A;
	Fri,  6 Nov 2020 15:26:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 62A7FC088B;
	Fri,  6 Nov 2020 15:26:39 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F3E25C0889
 for <virtualization@lists.linux-foundation.org>;
 Fri,  6 Nov 2020 15:26:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id EF6D6868E3
 for <virtualization@lists.linux-foundation.org>;
 Fri,  6 Nov 2020 15:26:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IA038-0E3Ckw
 for <virtualization@lists.linux-foundation.org>;
 Fri,  6 Nov 2020 15:26:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 1A514869A4
 for <virtualization@lists.linux-foundation.org>;
 Fri,  6 Nov 2020 15:26:37 +0000 (UTC)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 2C94FABA2;
 Fri,  6 Nov 2020 15:26:35 +0000 (UTC)
From: Thomas Zimmermann <tzimmermann@suse.de>
To: maarten.lankhorst@linux.intel.com, mripard@kernel.org, airlied@linux.ie,
 daniel@ffwll.ch, yuq825@gmail.com, robh@kernel.org,
 tomeu.vizoso@collabora.com, steven.price@arm.com,
 alyssa.rosenzweig@collabora.com, sean@poorly.run, eric@anholt.net,
 kraxel@redhat.com, rodrigosiqueiramelo@gmail.com, melissa.srw@gmail.com,
 hamohammed.sa@gmail.com
Subject: [PATCH v2 0/2] Default to cachable mappings for GEM SHMEM
Date: Fri,  6 Nov 2020 16:26:30 +0100
Message-Id: <20201106152632.26530-1-tzimmermann@suse.de>
X-Mailer: git-send-email 2.29.0
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

Shmem-allocated memory uses the system's default caching flags,
usually involving cached mappings.

By default, SHMEM GEM helpers map pages using writecombine. Only a few
drivers require this setting. Others revert it to default mappings
flags. Some could benefit from caching, but don't care.

Unify the behaviour by switching the SHMEM GEM code to use cached
mappings (i.e., PAGE_KERNEL actually); just like regular shmem memory
does. The 3 drivers that require write combining explicitly select it
during GEM object creation.

The exception is dma-buf imported pages, which are always mapped
using writecombine mode.

v2:
	* recreate patches on top of latest SHMEM helpers
	* update lima, panfrost, v3d (Daniel, Rob)
	* udl has been updated before separately.

Thomas Zimmermann (2):
  drm/shmem-helper: Use cached mappings by default
  drm/shmem-helper: Removed drm_gem_shmem_create_object_cached()

 drivers/gpu/drm/drm_gem_shmem_helper.c  | 37 ++++---------------------
 drivers/gpu/drm/lima/lima_gem.c         |  2 +-
 drivers/gpu/drm/mgag200/mgag200_drv.c   |  1 -
 drivers/gpu/drm/panfrost/panfrost_gem.c |  2 +-
 drivers/gpu/drm/udl/udl_drv.c           |  2 --
 drivers/gpu/drm/v3d/v3d_bo.c            |  2 +-
 drivers/gpu/drm/virtio/virtgpu_object.c |  1 -
 drivers/gpu/drm/vkms/vkms_drv.c         |  1 -
 include/drm/drm_gem_shmem_helper.h      |  7 ++---
 9 files changed, 11 insertions(+), 44 deletions(-)

--
2.29.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
