Return-Path: <SRS0=nfYb=OU=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BB1FC433F5
	for <virtualization@archiver.kernel.org>; Thu, 30 Sep 2021 10:19:50 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE00C61884
	for <virtualization@archiver.kernel.org>; Thu, 30 Sep 2021 10:19:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org BE00C61884
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 8077B4020D;
	Thu, 30 Sep 2021 10:19:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id aTbu3UCMc3lP; Thu, 30 Sep 2021 10:19:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id DA9A2400DE;
	Thu, 30 Sep 2021 10:19:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id ACB8FC0011;
	Thu, 30 Sep 2021 10:19:47 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4B690C000D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Sep 2021 10:19:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 333D94011B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Sep 2021 10:19:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Y382U0Sl-iFa
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Sep 2021 10:19:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 51BE5400DE
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Sep 2021 10:19:45 +0000 (UTC)
Received: from localhost (1.general.cking.uk.vpn [10.172.193.212])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 6D53040DD7; 
 Thu, 30 Sep 2021 10:19:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1632997181;
 bh=3HqHjju1V6qHP4N5Fhu3jHizcZDAmcAuKPY+5zu5uUA=;
 h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type;
 b=DFRDD/IITmkIue9vNoR3GTyvYtqoCl6x8xNqCh44bOrIaKBe5ViQ72pzhF6bTUzRX
 QOQbRPbmQsAdXhHoAKdXcN9IX5FajlToixLg62JCJLkHn6MoQcuthfwpEd7yknMeZW
 S7ouknTJ6ZkUf25UoKwzDButS2mUuLkbi02jvpT3lYNqiZXfzCOfhWOT02bFkPcE/b
 sq48NTIIKEHq/0/96U8MR55YEeDWu69UiAAPI4PwdedbZnfF0LR1qLSfzIEiabLTle
 VH3y2WHtIop8PjVnRD0Qu10XNDd0K7iEuofStKZzOxethnuJ91bdBGD/QknAKCERqX
 l2TP0jwsOo0Jg==
From: Colin King <colin.king@canonical.com>
To: David Airlie <airlied@linux.ie>, Gerd Hoffmann <kraxel@redhat.com>,
 Daniel Vetter <daniel@ffwll.ch>, Nicholas Verne <nverne@chromium.org>,
 Gurchetan Singh <gurchetansingh@chromium.org>,
 dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org
Subject: [PATCH][next] drm/virtio: fix potential integer overflow on shift of
 a int
Date: Thu, 30 Sep 2021 11:19:41 +0100
Message-Id: <20210930101941.16546-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
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

From: Colin Ian King <colin.king@canonical.com>

The left shift of unsigned int 32 bit integer constant 1 is evaluated
using 32 bit arithmetic and then assigned to a signed 64 bit integer.
In the case where i is 32 or more this can lead to an overflow. Fix
this by shifting the value 1ULL instead.

Addresses-Coverity: ("Uninitentional integer overflow")
Fixes: 8d6b006e1f51 ("drm/virtio: implement context init: handle VIRTGPU_CONTEXT_PARAM_POLL_RINGS_MASK")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/gpu/drm/virtio/virtgpu_ioctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
index 5618a1d5879c..b3b0557d72cf 100644
--- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
+++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
@@ -819,7 +819,7 @@ static int virtio_gpu_context_init_ioctl(struct drm_device *dev,
 	if (vfpriv->ring_idx_mask) {
 		valid_ring_mask = 0;
 		for (i = 0; i < vfpriv->num_rings; i++)
-			valid_ring_mask |= 1 << i;
+			valid_ring_mask |= 1ULL << i;
 
 		if (~valid_ring_mask & vfpriv->ring_idx_mask) {
 			ret = -EINVAL;
-- 
2.32.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
