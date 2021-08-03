Return-Path: <SRS0=yluT=M2=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_RED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A1A1C4338F
	for <virtualization@archiver.kernel.org>; Tue,  3 Aug 2021 12:59:43 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 200B660F01
	for <virtualization@archiver.kernel.org>; Tue,  3 Aug 2021 12:59:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 200B660F01
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4EBE06075E;
	Tue,  3 Aug 2021 12:59:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lHdX_0lYHmi0; Tue,  3 Aug 2021 12:59:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id D12256077B;
	Tue,  3 Aug 2021 12:59:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0661FC002C;
	Tue,  3 Aug 2021 12:59:40 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 912A4C000E
 for <virtualization@lists.linux-foundation.org>;
 Tue,  3 Aug 2021 12:59:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 745C7829B1
 for <virtualization@lists.linux-foundation.org>;
 Tue,  3 Aug 2021 12:59:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=suse.de header.b="OBz8KvsL";
 dkim=neutral reason="invalid (unsupported algorithm ed25519-sha256)"
 header.d=suse.de header.b="eNyKwYY2"
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IJwX-tsjjfkL
 for <virtualization@lists.linux-foundation.org>;
 Tue,  3 Aug 2021 12:59:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 by smtp1.osuosl.org (Postfix) with ESMTPS id BFC2482980
 for <virtualization@lists.linux-foundation.org>;
 Tue,  3 Aug 2021 12:59:36 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 0E153200CD;
 Tue,  3 Aug 2021 12:59:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1627995575; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YwMrprOEshldFA5MZJDSVCnYE/kuxkA8HL3ps9QmON8=;
 b=OBz8KvsLPi2UsZvLqdeC+Isrtp3T8zww3rq3X4Kruipr1RqlhtDkQO+0Oyq6A4PjyqmN+h
 4jiO01/e+PSIxDtsdn4q/epnxZXftVOM6Ul8eBd/TMfdrDIztmQWwM1MwagUXEiHqB1Ewc
 3PMZoIBvvLB4bR+Cv1bJqO6L083IUt8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1627995575;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YwMrprOEshldFA5MZJDSVCnYE/kuxkA8HL3ps9QmON8=;
 b=eNyKwYY2AcoRszMzwCSJAw0O8/EKhXnozHeNf2d8AGXgXJOEIUmvv+L0EbYZa9iAEzgami
 x8rOpkU+OiWLCnBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8C6A513CEF;
 Tue,  3 Aug 2021 12:59:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id wK7oILY9CWExZwAAMHmgww
 (envelope-from <tzimmermann@suse.de>); Tue, 03 Aug 2021 12:59:34 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: airlied@redhat.com, airlied@linux.ie, daniel@ffwll.ch,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, noralf@tronnes.org,
 drawat.floss@gmail.com, kraxel@redhat.com, hdegoede@redhat.com,
 sean@poorly.run, rodrigosiqueiramelo@gmail.com, melissa.srw@gmail.com,
 sam@ravnborg.org
Subject: [PATCH 08/11] drm/simpledrm: Use offset-adjusted shadow-plane mapping
Date: Tue,  3 Aug 2021 14:59:25 +0200
Message-Id: <20210803125928.27780-9-tzimmermann@suse.de>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210803125928.27780-1-tzimmermann@suse.de>
References: <20210803125928.27780-1-tzimmermann@suse.de>
MIME-Version: 1.0
Cc: linux-hyperv@vger.kernel.org, Thomas Zimmermann <tzimmermann@suse.de>,
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

For framebuffers with non-zero offset fields, shadow-plane helpers
provide a pointer to the first byte of the contained data. Use it in
simpledrm.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/tiny/simpledrm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/tiny/simpledrm.c b/drivers/gpu/drm/tiny/simpledrm.c
index 08ae66b1e6f5..481b48bde047 100644
--- a/drivers/gpu/drm/tiny/simpledrm.c
+++ b/drivers/gpu/drm/tiny/simpledrm.c
@@ -639,7 +639,7 @@ simpledrm_simple_display_pipe_enable(struct drm_simple_display_pipe *pipe,
 	struct simpledrm_device *sdev = simpledrm_device_of_dev(pipe->crtc.dev);
 	struct drm_shadow_plane_state *shadow_plane_state = to_drm_shadow_plane_state(plane_state);
 	struct drm_framebuffer *fb = plane_state->fb;
-	void *vmap = shadow_plane_state->map[0].vaddr; /* TODO: Use mapping abstraction properly */
+	void *vmap = shadow_plane_state->data[0].vaddr; /* TODO: Use mapping abstraction */
 	struct drm_device *dev = &sdev->dev;
 	int idx;
 
@@ -677,7 +677,7 @@ simpledrm_simple_display_pipe_update(struct drm_simple_display_pipe *pipe,
 	struct simpledrm_device *sdev = simpledrm_device_of_dev(pipe->crtc.dev);
 	struct drm_plane_state *plane_state = pipe->plane.state;
 	struct drm_shadow_plane_state *shadow_plane_state = to_drm_shadow_plane_state(plane_state);
-	void *vmap = shadow_plane_state->map[0].vaddr; /* TODO: Use mapping abstraction properly */
+	void *vmap = shadow_plane_state->data[0].vaddr; /* TODO: Use mapping abstraction */
 	struct drm_framebuffer *fb = plane_state->fb;
 	struct drm_device *dev = &sdev->dev;
 	struct drm_rect clip;
-- 
2.32.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
