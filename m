Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D035C761AF
	for <virtualization@archiver.kernel.org>; Mon, 20 Mar 2023 15:08:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 90A214179A;
	Mon, 20 Mar 2023 15:08:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 90A214179A
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=tY3Ql9iJ;
	dkim=fail reason="signature verification failed" header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=Tu6H19lK
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id coGurfXVT3Dy; Mon, 20 Mar 2023 15:08:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 3442F4176D;
	Mon, 20 Mar 2023 15:08:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3442F4176D
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0EA1CC008B;
	Mon, 20 Mar 2023 15:07:59 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A9324C0035
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Mar 2023 15:07:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6FAED41766
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Mar 2023 15:07:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6FAED41766
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Fldn8K8d_R_0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Mar 2023 15:07:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4B7A6410A0
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4B7A6410A0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Mar 2023 15:07:56 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 8417C1F890;
 Mon, 20 Mar 2023 15:07:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1679324874; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=F8iEY6hvgFvbfS66JBlGNNOLt4qzuk1VBL9oz6gKuvc=;
 b=tY3Ql9iJDGGUUtONILGkHGG9FkJ4d9+WsA4v6XorK3nOjS8nwd/c9ARNmeDsL2oInbTdBk
 +jjMeGO2eWrXoxoWPVVmq+q+uKVjNnZGnZNLZgb9eDNDiHzt/DjxEA41p2sJMh2zEmtmBI
 RYDdLudpgImprfPhVYTQys7obZanak8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1679324874;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=F8iEY6hvgFvbfS66JBlGNNOLt4qzuk1VBL9oz6gKuvc=;
 b=Tu6H19lK1lCbh1UVuI64UqkklNSYStJ8GirUbFDfpkbi6pGsClREeT6sWYG4wRjNnnoT9g
 g69nLVjVwqw9V3DQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 453D613A00;
 Mon, 20 Mar 2023 15:07:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id sIoPEMp2GGTXOgAAMHmgww
 (envelope-from <tzimmermann@suse.de>); Mon, 20 Mar 2023 15:07:54 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: javierm@redhat.com, daniel@ffwll.ch, airlied@gmail.com, mripard@kernel.org,
 maarten.lankhorst@linux.intel.com, zackr@vmware.com, kraxel@redhat.com,
 dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org,
 linux-graphics-maintainer@vmware.com
Subject: [PATCH v2 4/8] drm/fb-helper: Support smem_len in deferred I/O
Date: Mon, 20 Mar 2023 16:07:47 +0100
Message-Id: <20230320150751.20399-5-tzimmermann@suse.de>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230320150751.20399-1-tzimmermann@suse.de>
References: <20230320150751.20399-1-tzimmermann@suse.de>
MIME-Version: 1.0
Cc: Thomas Zimmermann <tzimmermann@suse.de>
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

The size of the framebuffer can either be stored in screen_info or
smem_len. Take both into account in the deferred I/O code.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/drm_fb_helper.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_helper.c
index 7e96ed9efdb5..bb0b25209b3e 100644
--- a/drivers/gpu/drm/drm_fb_helper.c
+++ b/drivers/gpu/drm/drm_fb_helper.c
@@ -672,7 +672,7 @@ static void drm_fb_helper_memory_range_to_clip(struct fb_info *info, off_t off,
 void drm_fb_helper_deferred_io(struct fb_info *info, struct list_head *pagereflist)
 {
 	struct drm_fb_helper *helper = info->par;
-	unsigned long start, end, min_off, max_off;
+	unsigned long start, end, min_off, max_off, total_size;
 	struct fb_deferred_io_pageref *pageref;
 	struct drm_rect damage_area;
 
@@ -690,7 +690,11 @@ void drm_fb_helper_deferred_io(struct fb_info *info, struct list_head *pagerefli
 	 * of the screen and account for non-existing scanlines. Hence,
 	 * keep the covered memory area within the screen buffer.
 	 */
-	max_off = min(max_off, info->screen_size);
+	if (info->screen_size)
+		total_size = info->screen_size;
+	else
+		total_size = info->fix.smem_len;
+	max_off = min(max_off, total_size);
 
 	if (min_off < max_off) {
 		drm_fb_helper_memory_range_to_clip(info, min_off, max_off - min_off, &damage_area);
-- 
2.40.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
