Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 845BE218EBA;
	Sun, 21 Jun 2026 02:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782009815; cv=none; b=tNRLba7V61vijqN0L0VbFD8QyScj4nPY3F76sZ+w8gO6jtZoW/NgU7YtJnh7K/AX5Pi1M4cqyQHJ25pafxUHd75jB9Dt3ZoMG2DuvXyTFlbu7dASTqDSqg0ZUDlSZkDdPCD5MbEZh4t7tyP17e5PpIS+jt7JIHen+KOSR6ovFKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782009815; c=relaxed/simple;
	bh=1ndsoy/3ImmWptJQTHAk+1hcRFK145grgtun0wStoH0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ZQiweRnfUYVMvDzpCCyZgpONUdIfw2ybBZT9yF+em3/W80kudDuYH8pCV8eP2jo6kDq6d39PmGUb0KgrvvdJMd+s1xNZqklkNZjb34/WMIHv1qPGOlx+0Dk9utO2RKcjpfjNsxlV/5qqJCsibh01splJe8StrMiiyxYrweKyhcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OQ2N2P4y; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OQ2N2P4y"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 158FCC2BCB0;
	Sun, 21 Jun 2026 02:43:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1782009815;
	bh=1ndsoy/3ImmWptJQTHAk+1hcRFK145grgtun0wStoH0=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=OQ2N2P4yOztncvvwUBWPnmescRwpx5yOEiBRxV1q1cWR/tODOAQztpB7SqbAV4X9F
	 lAC6T7J7DkJ0WnbdFCsVYYOUl/fBxTtcF5ZjjVSGamgMT+eGmjRA+6HtDC/ijgjGUc
	 SyGk7SHfscgxxPCJQQA433fFrKRU1huef7KKfbP7DQRTv/q43dfAD8NXpT6C95XfHL
	 gO8ChxDchjFtGxRRJ12qdiDQIaHlTiq5ysOexIrEWySp6Mqbyjj1zQb9U6nugit/pq
	 Cp8aIRF0zSRMSJFAQdbjG5XmfRbEmxKhZge6fQaKkPIbGlhgqnVCAt8tvj7UMsMxaG
	 d4PUS+N3r6/Nw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09B1CCD4F26;
	Sun, 21 Jun 2026 02:43:35 +0000 (UTC)
From: Bryam Vargas via B4 Relay <devnull+hexlabsecurity.proton.me@kernel.org>
Date: Sat, 20 Jun 2026 21:43:34 -0500
Subject: [PATCH] drm/virtio: bound EDID block reads to the response buffer
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260620-b4-disp-22bba7bf-v1-1-b95924cee742@proton.me>
X-B4-Tracking: v=1; b=H4sIANVPN2oC/x3MMQqAMAxA0atIZgMxSiteRRyMTTWLSgsiiHe3O
 L7h/weyJtMMQ/VA0suyHXtBU1ewbPO+KlooBiZ25JhQOgyWT2QWmb1E7HzoKdJCfStQsjNptPt
 fjtP7fhCInU5iAAAA
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>, 
 David Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Cc: linux-kernel@vger.kernel.org, 
 Gurchetan Singh <gurchetansingh@chromium.org>, 
 Chia-I Wu <olvaffe@gmail.com>, dri-devel@lists.freedesktop.org, 
 virtualization@lists.linux.dev
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782009813; l=1599;
 i=hexlabsecurity@proton.me; s=proton; h=from:subject:message-id;
 bh=XxBP3LnfnnuW9zu82lhaoZrAWbBKUMrGJ5tj8DbRz74=;
 b=0R3EVoEafhlGW7lqeKCkN4SzQtVGL/H6D18PLmGpAR926B+ckGp8vn9XX0ehwqyK8ee9tC7Ox
 wuLEqpZmfwTAGGt6EJ8nS2DucwWBoHEeE/jssXW1gjNYz0bYrT1Czmr
X-Developer-Key: i=hexlabsecurity@proton.me; a=ed25519;
 pk=dmppBMZNLLoPzxHi9l8tZDzEZUunPbgsYqIZYXeUrL0=
X-Endpoint-Received: by B4 Relay for hexlabsecurity@proton.me/proton with
 auth_id=814
X-Original-From: Bryam Vargas <hexlabsecurity@proton.me>
Reply-To: hexlabsecurity@proton.me

From: Bryam Vargas <hexlabsecurity@proton.me>

virtio_get_edid_block() validates the read offset only against the
device-supplied resp->size field, never against the fixed-size resp->edid
array. The EDID block index is driven by the device-supplied extension
count, so a malicious virtio-gpu backend can advertise a large size
together with a high block count and read far past the array into adjacent
kernel memory, which is then surfaced in the parsed EDID (an out-of-bounds
read / info leak).

Also reject any read whose end exceeds the size of the edid array.
Conforming EDID responses stay within the array and are unaffected.

Fixes: b4b01b4995fb ("drm/virtio: add edid support")
Cc: stable@vger.kernel.org
Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>
---
 drivers/gpu/drm/virtio/virtgpu_vq.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio/virtgpu_vq.c
index 67865810a2e7..c8b9475a7472 100644
--- a/drivers/gpu/drm/virtio/virtgpu_vq.c
+++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
@@ -897,7 +897,8 @@ static int virtio_get_edid_block(void *data, u8 *buf,
 	struct virtio_gpu_resp_edid *resp = data;
 	size_t start = block * EDID_LENGTH;
 
-	if (start + len > le32_to_cpu(resp->size))
+	if (start + len > le32_to_cpu(resp->size) ||
+	    start + len > sizeof(resp->edid))
 		return -EINVAL;
 	memcpy(buf, resp->edid + start, len);
 	return 0;

---
base-commit: 1a3746ccbb0a97bed3c06ccde6b880013b1dddc1
change-id: 20260620-b4-disp-22bba7bf-47d80f0c083b

Best regards,
-- 
Bryam Vargas <hexlabsecurity@proton.me>


