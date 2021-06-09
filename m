Return-Path: <SRS0=l8rc=LD=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_RED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA896C48BD1
	for <virtualization@archiver.kernel.org>; Wed,  9 Jun 2021 11:20:21 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94CBB613B6
	for <virtualization@archiver.kernel.org>; Wed,  9 Jun 2021 11:20:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94CBB613B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 427AC403C8;
	Wed,  9 Jun 2021 11:20:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id y8yR3lEk-jRF; Wed,  9 Jun 2021 11:20:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id A663A40163;
	Wed,  9 Jun 2021 11:20:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7F4EBC000E;
	Wed,  9 Jun 2021 11:20:19 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B2498C000B
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Jun 2021 11:20:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9ECE4403BD
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Jun 2021 11:20:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yOHk88aEw2Tr
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Jun 2021 11:20:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4B57840104
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Jun 2021 11:20:17 +0000 (UTC)
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
 (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 322EA1FD2A;
 Wed,  9 Jun 2021 11:20:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1623237614; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=oCiBA5IQR9wf4+Cc+r3nE+xIhszdcMtCPYXz7tk1DUc=;
 b=fY/lBPn1RzheTsgcxOOcUlu2A6QxXJzVzaZKYGY8dQ/N9dkPZxAh+IzMlWy3Mdw4YcifeB
 euR+HK45GJ3f0u+/7nmbJqJDLXGEJmIB2cOWMU93FBBin5A1MqrE27Y9jBklc67vNLz8q3
 MEB05kirgOr7hJDXocRIMCqdq+d45FY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1623237614;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=oCiBA5IQR9wf4+Cc+r3nE+xIhszdcMtCPYXz7tk1DUc=;
 b=qtPzutLGd6X37XBCAvAZ4AuMX1bEEdUc0wqN5VeNSoa0OrIM4LVgceME8x2WEfyyR258wQ
 Jhvg0YtWBnitxsBg==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
 by imap.suse.de (Postfix) with ESMTP id 8991F118DD;
 Wed,  9 Jun 2021 11:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1623237614; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=oCiBA5IQR9wf4+Cc+r3nE+xIhszdcMtCPYXz7tk1DUc=;
 b=fY/lBPn1RzheTsgcxOOcUlu2A6QxXJzVzaZKYGY8dQ/N9dkPZxAh+IzMlWy3Mdw4YcifeB
 euR+HK45GJ3f0u+/7nmbJqJDLXGEJmIB2cOWMU93FBBin5A1MqrE27Y9jBklc67vNLz8q3
 MEB05kirgOr7hJDXocRIMCqdq+d45FY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1623237614;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=oCiBA5IQR9wf4+Cc+r3nE+xIhszdcMtCPYXz7tk1DUc=;
 b=qtPzutLGd6X37XBCAvAZ4AuMX1bEEdUc0wqN5VeNSoa0OrIM4LVgceME8x2WEfyyR258wQ
 Jhvg0YtWBnitxsBg==
Received: from director2.suse.de ([192.168.254.72]) by imap3-int with ESMTPSA
 id Pn27IO2jwGBTUgAALh3uQQ
 (envelope-from <tzimmermann@suse.de>); Wed, 09 Jun 2021 11:20:13 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: daniel@ffwll.ch, mripard@kernel.org, maarten.lankhorst@linux.intel.com,
 l.stach@pengutronix.de, linux+etnaviv@armlinux.org.uk,
 christian.gmeiner@gmail.com, inki.dae@samsung.com, jy0922.shim@samsung.com,
 sw0312.kim@samsung.com, kyungmin.park@samsung.com,
 krzysztof.kozlowski@canonical.com, chunkuang.hu@kernel.org,
 p.zabel@pengutronix.de, matthias.bgg@gmail.com, robdclark@gmail.com,
 sean@poorly.run, airlied@redhat.com, kraxel@redhat.com, hjc@rock-chips.com,
 heiko@sntech.de, oleksandr_andrushchenko@epam.com, sumit.semwal@linaro.org,
 christian.koenig@amd.com
Subject: [PATCH 0/9] drm: Implement gem_prime_mmap with drm_gem_prime_mmap()
Date: Wed,  9 Jun 2021 13:20:03 +0200
Message-Id: <20210609112012.10019-1-tzimmermann@suse.de>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Cc: linux-samsung-soc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 etnaviv@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 virtualization@lists.linux-foundation.org, linaro-mm-sig@lists.linaro.org,
 linux-rockchip@lists.infradead.org, linux-mediatek@lists.infradead.org,
 Thomas Zimmermann <tzimmermann@suse.de>, xen-devel@lists.xenproject.org,
 spice-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org
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

Replace all remaining implementations of struct drm_driver.gem_prime_mmap
with use drm_gem_prime_mmap(). For each affected driver, put the mmap code
into struct drm_gem_object_funcs.mmap. With the latter change in place,
create struct file_operations via DEFINE_DRM_GEM_FOPS().

As next steps, remaining drivers can be converted to use drm_gem_prime_mmap()
and drm_gem_mmap() (e.g., Tegra). The default mmap code in drm_gem_prime_mmap()
can be pushed into affected drivers or a helper function. The gem_prime_mmap
hook can probably be removed at some point.

Testing is welcome. I don't have all the necessary hardware.

Thomas Zimmermann (9):
  drm/etnaviv: Implement mmap as GEM object function
  drm/exynox: Implement mmap as GEM object function
  drm/mediatek: Implement mmap as GEM object function
  drm/msm: Implement mmap as GEM object function
  drm/qxl: Remove empty qxl_gem_prime_mmap()
  drm/vgem: Implement mmap as GEM object function
  drm/xen: Implement mmap as GEM object function
  drm/rockchip: Implement mmap as GEM object function
  drm: Update documentation and TODO of gem_prime_mmap hook

 Documentation/gpu/todo.rst                    |  11 --
 drivers/gpu/drm/etnaviv/etnaviv_drv.c         |  14 +--
 drivers/gpu/drm/etnaviv/etnaviv_drv.h         |   3 -
 drivers/gpu/drm/etnaviv/etnaviv_gem.c         |  18 +--
 drivers/gpu/drm/etnaviv/etnaviv_gem_prime.c   |  13 ---
 drivers/gpu/drm/exynos/exynos_drm_drv.c       |  13 +--
 drivers/gpu/drm/exynos/exynos_drm_fbdev.c     |  20 +---
 drivers/gpu/drm/exynos/exynos_drm_gem.c       |  43 ++-----
 drivers/gpu/drm/exynos/exynos_drm_gem.h       |   5 -
 drivers/gpu/drm/mediatek/mtk_drm_drv.c        |  13 +--
 drivers/gpu/drm/mediatek/mtk_drm_gem.c        |  44 ++-----
 drivers/gpu/drm/mediatek/mtk_drm_gem.h        |   3 -
 drivers/gpu/drm/msm/msm_drv.c                 |  14 +--
 drivers/gpu/drm/msm/msm_drv.h                 |   1 -
 drivers/gpu/drm/msm/msm_fbdev.c               |  10 +-
 drivers/gpu/drm/msm/msm_gem.c                 |  67 +++++------
 drivers/gpu/drm/msm/msm_gem.h                 |   3 -
 drivers/gpu/drm/msm/msm_gem_prime.c           |  11 --
 drivers/gpu/drm/qxl/qxl_drv.c                 |   1 -
 drivers/gpu/drm/qxl/qxl_drv.h                 |   2 -
 drivers/gpu/drm/qxl/qxl_prime.c               |   6 -
 drivers/gpu/drm/rockchip/rockchip_drm_drv.c   |  13 +--
 drivers/gpu/drm/rockchip/rockchip_drm_fbdev.c |   3 +-
 drivers/gpu/drm/rockchip/rockchip_drm_gem.c   |  44 ++-----
 drivers/gpu/drm/rockchip/rockchip_drm_gem.h   |   7 --
 drivers/gpu/drm/vgem/vgem_drv.c               |  46 +-------
 drivers/gpu/drm/xen/xen_drm_front.c           |  16 +--
 drivers/gpu/drm/xen/xen_drm_front_gem.c       | 108 +++++++-----------
 drivers/gpu/drm/xen/xen_drm_front_gem.h       |   7 --
 include/drm/drm_drv.h                         |  11 +-
 30 files changed, 136 insertions(+), 434 deletions(-)


base-commit: 70e4d80795934312a3853a4f4f49445ce6db1271
prerequisite-patch-id: c2b2f08f0eccc9f5df0c0da49fa1d36267deb11d
prerequisite-patch-id: c67e5d886a47b7d0266d81100837557fda34cb24
--
2.31.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
