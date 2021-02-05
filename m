Return-Path: <SRS0=ITlz=HH=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B62EC433E0
	for <virtualization@archiver.kernel.org>; Fri,  5 Feb 2021 15:06:38 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C99C6509A
	for <virtualization@archiver.kernel.org>; Fri,  5 Feb 2021 15:06:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C99C6509A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 14F5286B4E;
	Fri,  5 Feb 2021 15:06:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VNeIYScQR1du; Fri,  5 Feb 2021 15:06:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 39CB386B08;
	Fri,  5 Feb 2021 15:06:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0CFA6C1E6F;
	Fri,  5 Feb 2021 15:06:35 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CB0E2C013A
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Feb 2021 15:06:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id BAA2487035
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Feb 2021 15:06:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lGO3B+AMMNyq
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Feb 2021 15:06:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by hemlock.osuosl.org (Postfix) with ESMTPS id CD83E87074
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Feb 2021 15:06:32 +0000 (UTC)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 6AFD4AC43;
 Fri,  5 Feb 2021 15:06:30 +0000 (UTC)
From: Thomas Zimmermann <tzimmermann@suse.de>
To: daniel@ffwll.ch, airlied@linux.ie, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, kraxel@redhat.com, hdegoede@redhat.com,
 sean@poorly.run, sam@ravnborg.org, noralf@tronnes.org
Subject: [PATCH v2 0/7] drm: Move vmap out of commit tail for SHMEM-based
 drivers
Date: Fri,  5 Feb 2021 16:06:21 +0100
Message-Id: <20210205150628.28072-1-tzimmermann@suse.de>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Cc: Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

Several SHMEM-based drivers use the BO as shadow buffer for the real
framebuffer memory. Damage handling requires a vmap of the BO memory.
But vmap/vunmap can acquire the dma-buf reservation lock, which is not
allowed in commit tails.

This patchset introduces a set of helpers that implement vmap/vunmap
in the plane's prepare_fb and cleanup_fb; and provide the mapping's
address to commit-tail functions. Wrappers for simple KMS are provides,
as all of the involved drivers are built upon simple-KMS helpers.

Patch 1 adds the support for private plane state to the simple-KMS
helper library.

Patches 2 and 3 provide plane state for shadow-buffered planes. It's a
DRM plane with BO mappings into kernel address space. The involved
helpers take care of the details. The code is independent from GEM
SHMEM and can be used with other shadow-buffered planes. I put all
this in a new file. In a later patch, drm_gem_fb_prepare_fb() et al
could be moved there as well.

Patches 4 to 7 convert each involved driver to the new helpers. The
vmap operations are being removed from commit-tail functions. An
additional benefit is that vmap errors are now detected before the
commit starts. The original commit-tail functions could not
handle failed vmap operations.

I smoke-tested the code by running fbdev, Xorg and weston with the
converted mgag200 driver.

v2:
	* export drm_gem_vmap()/_vunmap() (kernel test robot)
	* make duplicate_state interface compatible with
	  struct drm_plane_funcs

Thomas Zimmermann (7):
  drm/simple-kms: Add plane-state helpers
  drm/gem: Export drm_gem_vmap() and drm_gem_vunmap()
  drm: Add additional atomic helpers for shadow-buffered planes
  drm/mgag200: Move vmap out of commit tail
  drm/cirrus: Move vmap out of commit tail
  drm/gm12u320: Move vmap out of commit tail
  drm/udl: Move vmap out of commit tail

 Documentation/gpu/drm-kms-helpers.rst   |  12 ++
 drivers/gpu/drm/Makefile                |   3 +-
 drivers/gpu/drm/drm_gem.c               |   2 +
 drivers/gpu/drm/drm_gem_atomic_helper.c | 208 ++++++++++++++++++++++++
 drivers/gpu/drm/drm_simple_kms_helper.c |  40 ++++-
 drivers/gpu/drm/mgag200/mgag200_mode.c  |  23 +--
 drivers/gpu/drm/tiny/cirrus.c           |  43 ++---
 drivers/gpu/drm/tiny/gm12u320.c         |  28 ++--
 drivers/gpu/drm/udl/udl_modeset.c       |  34 ++--
 include/drm/drm_gem_atomic_helper.h     |  73 +++++++++
 include/drm/drm_simple_kms_helper.h     |  27 +++
 11 files changed, 412 insertions(+), 81 deletions(-)
 create mode 100644 drivers/gpu/drm/drm_gem_atomic_helper.c
 create mode 100644 include/drm/drm_gem_atomic_helper.h


base-commit: f9173d6435c6a9bb0b0076ebf9122d876da208ae
prerequisite-patch-id: c2b2f08f0eccc9f5df0c0da49fa1d36267deb11d
prerequisite-patch-id: f8140f08b77c49beb6243d9a2a88ebcc7097e391
prerequisite-patch-id: 6bffaf03d01daeb29a0b0ffbc78b415e72907a17
prerequisite-patch-id: 6386ca949b8b677a7eada2672990dab2f84f734f
prerequisite-patch-id: 706e35d0b2185d2332f725e1c22d8ffed910ea7b
prerequisite-patch-id: e30631cc73b905efa477be3f56daf1ff5112fe03
--
2.30.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
