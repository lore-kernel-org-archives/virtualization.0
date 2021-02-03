Return-Path: <SRS0=+GVp=HF=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFE7CC433DB
	for <virtualization@archiver.kernel.org>; Wed,  3 Feb 2021 13:10:55 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 763EA64F9A
	for <virtualization@archiver.kernel.org>; Wed,  3 Feb 2021 13:10:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 763EA64F9A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 0B3D887060;
	Wed,  3 Feb 2021 13:10:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5d96QdPOSP92; Wed,  3 Feb 2021 13:10:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id C27C0870FB;
	Wed,  3 Feb 2021 13:10:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AD360C0FA7;
	Wed,  3 Feb 2021 13:10:53 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7C023C013A
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 Feb 2021 13:10:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 6B01C8708A
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 Feb 2021 13:10:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zCR9BgRerHJ0
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 Feb 2021 13:10:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by hemlock.osuosl.org (Postfix) with ESMTPS id CEA2587060
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 Feb 2021 13:10:50 +0000 (UTC)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 32B04AFD2;
 Wed,  3 Feb 2021 13:10:49 +0000 (UTC)
From: Thomas Zimmermann <tzimmermann@suse.de>
To: daniel@ffwll.ch, airlied@linux.ie, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, kraxel@redhat.com, hdegoede@redhat.com,
 sean@poorly.run, sam@ravnborg.org, noralf@tronnes.org
Subject: [PATCH 1/6] drm/simple-kms: Add plane-state helpers
Date: Wed,  3 Feb 2021 14:10:41 +0100
Message-Id: <20210203131046.22371-2-tzimmermann@suse.de>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210203131046.22371-1-tzimmermann@suse.de>
References: <20210203131046.22371-1-tzimmermann@suse.de>
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

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/drm_simple_kms_helper.c | 40 +++++++++++++++++++++++--
 include/drm/drm_simple_kms_helper.h     | 28 +++++++++++++++++
 2 files changed, 65 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/drm_simple_kms_helper.c b/drivers/gpu/drm/drm_simple_kms_helper.c
index 6ce8f5cd1eb5..0c5bb0f98fa0 100644
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
+	return pipe->funcs->duplicate_plane_state(pipe, plane->state);
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
index e6dbf3161c2f..0c1a2e07caf2 100644
--- a/include/drm/drm_simple_kms_helper.h
+++ b/include/drm/drm_simple_kms_helper.h
@@ -149,6 +149,34 @@ struct drm_simple_display_pipe_funcs {
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
+	struct drm_plane_state * (*duplicate_plane_state)(struct drm_simple_display_pipe *pipe,
+							  struct drm_plane_state *plane_state);
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
