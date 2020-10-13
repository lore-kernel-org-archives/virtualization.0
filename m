Return-Path: <SRS0=ZRN8=DU=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45230C433DF
	for <virtualization@archiver.kernel.org>; Tue, 13 Oct 2020 13:27:24 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9654F23102
	for <virtualization@archiver.kernel.org>; Tue, 13 Oct 2020 13:27:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9654F23102
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 1090E87B55;
	Tue, 13 Oct 2020 13:27:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vGrXnh4lwA7o; Tue, 13 Oct 2020 13:27:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 88D9D87940;
	Tue, 13 Oct 2020 13:27:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6EB99C0052;
	Tue, 13 Oct 2020 13:27:22 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8A37BC0051
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Oct 2020 13:27:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 79AC687B55
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Oct 2020 13:27:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OwtyM5o74tI5
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Oct 2020 13:27:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by hemlock.osuosl.org (Postfix) with ESMTPS id F233287940
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Oct 2020 13:27:20 +0000 (UTC)
IronPort-SDR: vp1jCoUsJTWIUPdobcuu7cseMamM+DFApmHffPguU/4eayERORyRi7tM8weaIjOhDzfIsqESS/
 KrRmNUpZZ/Tw==
X-IronPort-AV: E=McAfee;i="6000,8403,9772"; a="165118356"
X-IronPort-AV: E=Sophos;i="5.77,370,1596524400"; d="scan'208";a="165118356"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Oct 2020 06:27:19 -0700
IronPort-SDR: TYK4IrnTR+X0Cbr/2jiotEL4uJt/+l9BMomWSZsNWrOI9e0q0acjCl5Wt1Itupj+iXpp7uy5uJ
 sK5LZrwzsBng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,370,1596524400"; d="scan'208";a="351107056"
Received: from black.fi.intel.com ([10.237.72.28])
 by fmsmga002.fm.intel.com with ESMTP; 13 Oct 2020 06:27:17 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
 id 82D6C3BB; Tue, 13 Oct 2020 16:27:16 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
 Gerd Hoffmann <kraxel@redhat.com>, Daniel Vetter <daniel@ffwll.ch>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 virtualization@lists.linux-foundation.org
Subject: [PATCH v2] drm/virtio: Use UUID API for importing the UUID
Date: Tue, 13 Oct 2020 16:27:14 +0300
Message-Id: <20201013132714.70973-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 David Stevens <stevensd@chromium.org>
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

There is import_uuid() function which imports u8 array to the uuid_t.
Use it instead of open coding variant.

This allows to hide the uuid_t internals.

Reviewed-by: David Stevens <stevensd@chromium.org>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: rebased on top of drm-misc-next (Gerd), added Rb tag (David)
 drivers/gpu/drm/virtio/virtgpu_vq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio/virtgpu_vq.c
index 6434b9fb38a6..c1824f536936 100644
--- a/drivers/gpu/drm/virtio/virtgpu_vq.c
+++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
@@ -1141,7 +1141,7 @@ static void virtio_gpu_cmd_resource_uuid_cb(struct virtio_gpu_device *vgdev,
 
 	if (resp_type == VIRTIO_GPU_RESP_OK_RESOURCE_UUID &&
 	    obj->uuid_state == STATE_INITIALIZING) {
-		memcpy(&obj->uuid.b, resp->uuid, sizeof(obj->uuid.b));
+		import_uuid(&obj->uuid, resp->uuid);
 		obj->uuid_state = STATE_OK;
 	} else {
 		obj->uuid_state = STATE_ERR;
-- 
2.28.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
