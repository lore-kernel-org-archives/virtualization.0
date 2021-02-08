Return-Path: <SRS0=X+k7=HK=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C51F9C433E0
	for <virtualization@archiver.kernel.org>; Mon,  8 Feb 2021 11:55:47 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 153A664E79
	for <virtualization@archiver.kernel.org>; Mon,  8 Feb 2021 11:55:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 153A664E79
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 9F10385D61;
	Mon,  8 Feb 2021 11:55:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zgZ6qnIBKB8z; Mon,  8 Feb 2021 11:55:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id D7B4B85C06;
	Mon,  8 Feb 2021 11:55:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B7987C1DA9;
	Mon,  8 Feb 2021 11:55:45 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BA6F2C013A
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Feb 2021 11:55:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id B66628707A
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Feb 2021 11:55:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id r2vULJgqAQck
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Feb 2021 11:55:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 1C0B987001
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Feb 2021 11:55:43 +0000 (UTC)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 7B5D0AD4E;
 Mon,  8 Feb 2021 11:55:41 +0000 (UTC)
From: Thomas Zimmermann <tzimmermann@suse.de>
To: daniel@ffwll.ch, airlied@linux.ie, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, kraxel@redhat.com, hdegoede@redhat.com,
 sean@poorly.run, sam@ravnborg.org, noralf@tronnes.org
Subject: [PATCH v3 1/7] drm/simple-kms: Add plane-state helpers
Date: Mon,  8 Feb 2021 12:55:32 +0100
Message-Id: <20210208115538.6430-2-tzimmermann@suse.de>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210208115538.6430-1-tzimmermann@suse.de>
References: <20210208115538.6430-1-tzimmermann@suse.de>
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

Just like regular plane-state helpers, drivers can use these new
callbacks to create and destroy private plane state.

v2:
	* make duplicate_state interface compatible with
	  struct drm_plane_funcs

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Tested-by: Gerd Hoffmann <kraxel@redhat.com>
Acked-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/drm_simple_kms_helper.c | 40 +++++++++++++++++++++++--
 include/drm/drm_simple_kms_helper.h     | 27 +++++++++++++++++
 2 files changed, 64 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/drm_simple_kms_helper.c b/drivers/gpu/drm/drm_simple_kms_helper.c
index 6ce8f5cd1eb5..89675d4b7b6c 100644
--- a/drivers/gpu/drm/drm_simple_kms_helper.c
+++ b/drivers/gpu/drm/drm_simple_kms_helper.c
@@ -253,13 +253,47 @@ static const struct drm_plane_helper_funcs drm_simple_kms_plane_helper_funcs = {
 	.atomic_update = drm_simple_kms_plane_atomic_update,
 };
 
+static void drm_simple_kms_plane_reset(struct drm_plane *plane)
+{
+	struct drm_simple_display_pipe *pipe;
+
+	pipe = container_of(plane, struct drm_simple_display_pipe, plane);
+	if (!pipe->funcs || !pipe->funcs->reset_plane)
+		return drm_atomic_helper_plane_reset(plane);
+
+	return pipe->funcs->reset_plane(pipe);
+}
+
+static struct drm_plane_state *drm_simple_kms_plane_duplicate_state(struct drm_plane *plane)
+{
+	struct drm_simple_display_pipe *pipe;
+
+	pipe = container_of(plane, struct drm_simple_display_pipe, plane);
+	if (!pipe->funcs || !pipe->funcs->duplicate_plane_state)
+		return drm_atomic_helper_plane_duplicate_state(plane);
+
+	return pipe->funcs->duplicate_plane_state(pipe);
+}
+
+static void drm_simple_kms_plane_destroy_state(struct drm_plane *plane,
+					       struct drm_plane_state *state)
+{
+	struct drm_simple_display_pipe *pipe;
+
+	pipe = container_of(plane, struct drm_simple_display_pipe, plane);
+	if (!pipe->funcs || !pipe->funcs->destroy_plane_state)
+		drm_atomic_helper_plane_destroy_state(plane, state);
+	else
+		pipe->funcs->destroy_plane_state(pipe, state);
+}
+
 static const struct drm_plane_funcs drm_simple_kms_plane_funcs = {
 	.update_plane		= drm_atomic_helper_update_plane,
 	.disable_plane		= drm_atomic_helper_disable_plane,
 	.destroy		= drm_plane_cleanup,
-	.reset			= drm_atomic_helper_plane_reset,
-	.atomic_duplicate_state	= drm_atomic_helper_plane_duplicate_state,
-	.atomic_destroy_state	= drm_atomic_helper_plane_destroy_state,
+	.reset			= drm_simple_kms_plane_reset,
+	.atomic_duplicate_state	= drm_simple_kms_plane_duplicate_state,
+	.atomic_destroy_state	= drm_simple_kms_plane_destroy_state,
 	.format_mod_supported   = drm_simple_kms_format_mod_supported,
 };
 
diff --git a/include/drm/drm_simple_kms_helper.h b/include/drm/drm_simple_kms_helper.h
index e6dbf3161c2f..40b34573249f 100644
--- a/include/drm/drm_simple_kms_helper.h
+++ b/include/drm/drm_simple_kms_helper.h
@@ -149,6 +149,33 @@ struct drm_simple_display_pipe_funcs {
 	 * more details.
 	 */
 	void (*disable_vblank)(struct drm_simple_display_pipe *pipe);
+
+	/**
+	 * @reset_plane:
+	 *
+	 * Optional, called by &drm_plane_funcs.reset. Please read the
+	 * documentation for the &drm_plane_funcs.reset hook for more details.
+	 */
+	void (*reset_plane)(struct drm_simple_display_pipe *pipe);
+
+	/**
+	 * @duplicate_plane_state:
+	 *
+	 * Optional, called by &drm_plane_funcs.atomic_duplicate_state.  Please
+	 * read the documentation for the &drm_plane_funcs.atomic_duplicate_state
+	 * hook for more details.
+	 */
+	struct drm_plane_state * (*duplicate_plane_state)(struct drm_simple_display_pipe *pipe);
+
+	/**
+	 * @destroy_plane_state:
+	 *
+	 * Optional, called by &drm_plane_funcs.atomic_destroy_state.  Please
+	 * read the documentation for the &drm_plane_funcs.atomic_destroy_state
+	 * hook for more details.
+	 */
+	void (*destroy_plane_state)(struct drm_simple_display_pipe *pipe,
+				    struct drm_plane_state *plane_state);
 };
 
 /**
-- 
2.30.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
