Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F538C433EF
	for <virtualization@archiver.kernel.org>; Wed,  9 Feb 2022 15:56:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B906E41521;
	Wed,  9 Feb 2022 15:56:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qJseq85Lbaac; Wed,  9 Feb 2022 15:56:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 4192741559;
	Wed,  9 Feb 2022 15:56:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AB85DC0077;
	Wed,  9 Feb 2022 15:56:42 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3E017C0011
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Feb 2022 15:56:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1CBCE4047F
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Feb 2022 15:56:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=suse.de header.b="WihCwBeu";
 dkim=neutral reason="invalid (unsupported algorithm ed25519-sha256)"
 header.d=suse.de header.b="bAJsBNxv"
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kUGdPX5FGS-t
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Feb 2022 15:56:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4B9D2400D0
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Feb 2022 15:56:40 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 4B4381F383;
 Wed,  9 Feb 2022 15:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1644422197; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=jw5vORRNedcMhyTsHWpDYLPvPJ9B0ItRnP3EWanTYu8=;
 b=WihCwBeuRVPM3B1YhfezlglyW37hYl40XsP1AZ0jTYVwIMGakIYAvqWAqh/6W0FAK2jrCF
 FLpbNGVCMPW7wqDqQrFgcegiPohXYduESF9+Fhp75zIOd57z3COVbPbwEQw9f34ZpYuRaX
 nq5tx0aDTLn9mcwvqFCxMgvOpeoB3Qc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1644422197;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=jw5vORRNedcMhyTsHWpDYLPvPJ9B0ItRnP3EWanTYu8=;
 b=bAJsBNxvtaLa0PEEm+UKkM8ifw2iQ/mhjSdkt95TAlezjJV+y0xNFzsv9jKPp1TjR9A/5c
 NkEpRs2C0+woabDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E268213D58;
 Wed,  9 Feb 2022 15:56:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id S3ooNjTkA2JxHAAAMHmgww
 (envelope-from <tzimmermann@suse.de>); Wed, 09 Feb 2022 15:56:36 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: daniel@ffwll.ch, airlied@linux.ie, mripard@kernel.org,
 maarten.lankhorst@linux.intel.com, yuq825@gmail.com, robh@kernel.org,
 tomeu.vizoso@collabora.com, steven.price@arm.com,
 alyssa.rosenzweig@collabora.com, emma@anholt.net, kraxel@redhat.com,
 gurchetansingh@chromium.org, olvaffe@gmail.com
Subject: [PATCH v2 0/2] drm/gem-shmem: Various improvements
Date: Wed,  9 Feb 2022 16:56:32 +0100
Message-Id: <20220209155634.3994-1-tzimmermann@suse.de>
X-Mailer: git-send-email 2.34.1
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

Two patches for GEM's SHMEM-backed implementation.

v2:
	* update drivers after vm_ops change

Thomas Zimmermann (2):
  drm/gem-shmem: Set vm_ops in static initializer
  drm/gem-shmem: Don't store mmap'ed buffers in core dumps

 drivers/gpu/drm/drm_gem_shmem_helper.c  | 7 ++++---
 drivers/gpu/drm/lima/lima_gem.c         | 1 +
 drivers/gpu/drm/panfrost/panfrost_gem.c | 1 +
 drivers/gpu/drm/v3d/v3d_bo.c            | 1 +
 drivers/gpu/drm/virtio/virtgpu_object.c | 1 +
 include/drm/drm_gem_shmem_helper.h      | 2 ++
 6 files changed, 10 insertions(+), 3 deletions(-)

-- 
2.34.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
