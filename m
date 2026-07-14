Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E278B36C0CE
	for <virtualization@lists.linux.dev>; Tue, 14 Jul 2026 02:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783997068; cv=none; b=AW1gML7NS+1b3ilpNdPnl5+wDmaTxtpEcl/O1wRE5a2sVYK7j8XSNsJnH5ogYsBLAvS7mXXbR+4WyJ8AJ70VvXZtzgNFHFmZ+amMOucR0FUy4Ng2rlEiBoRMuYW7MQ34IAk5eNEQXkOZn22aYsjy5YJQjdzvpqYgZz5WdTyrhxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783997068; c=relaxed/simple;
	bh=vLEtINN942eEtZGbjgNUQXtv40sEDfXCx13S/8IA2G4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LGCE9VZ0/C3PTQitySfJf9GFwlG4xa3alVUpRMXbIixsR3oncH9lgvdamBE3FwwiyRl+PQ/sbe223jS6R+sWTeyAR2X8YQWZdW56n1LbQSFtMNnS6cLxwMlX2MK3vrm0SeOvNbfxTYWareWMcxZcvH6jda3S8UU23mjzm1cfEvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: e7e335a07f2d11f1aa26b74ffac11d73-20260714
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:b14ff526-52db-44e5-a4f5-2948bfd76b79,IP:15,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:15
X-CID-INFO: VERSION:1.3.12,REQID:b14ff526-52db-44e5-a4f5-2948bfd76b79,IP:15,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:15
X-CID-META: VersionHash:e7bac3a,CLOUDID:15b9d2c464e697817dd56674a5c52e92,BulkI
	D:2607141009474T8OY1UJ,BulkQuantity:1,Recheck:0,SF:10|38|66|78|102|127|136
	|865|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:40
	,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:
	0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: e7e335a07f2d11f1aa26b74ffac11d73-20260714
X-User: zhaoguohan@kylinos.cn
Received: from zgh-vmware-virtual-platform.localdomain [(116.128.244.171)] by mailgw.kylinos.cn
	(envelope-from <zhaoguohan@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 709730700; Tue, 14 Jul 2026 10:44:16 +0800
From: GuoHan Zhao <zhaoguohan@kylinos.cn>
To: Peter Hilber <peter.hilber@oss.qualcomm.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	virtualization@lists.linux.dev
Cc: Jason Wang <jasowangio@gmail.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] virtio: rtc: time out alarm requests
Date: Tue, 14 Jul 2026 10:43:52 +0800
Message-ID: <20260714024352.71307-1-zhaoguohan@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

RTC class operations run with rtc_device.ops_lock held. The virtio RTC
alarm requests currently wait without a timeout for the device to return
their requestq buffers.

On surprise removal, virtio-pci marks the virtqueues broken before
unregistering the virtio device. If an alarm request is waiting when the
device stops responding, viortc_remove() blocks in viortc_class_stop()
while trying to acquire ops_lock. The request cannot complete and device
removal hangs until the waiting task is signalled.

Use the same 60-second timeout as clock read requests for alarm reads,
alarm programming, and alarm interrupt enable requests. The existing
message reference counting keeps a timed-out request alive until a late
response or device teardown.

Fixes: 9d4f22fd563e ("virtio_rtc: Add RTC class driver")
Assisted-by: Codex:gpt-5.6-sol
Signed-off-by: GuoHan Zhao <zhaoguohan@kylinos.cn>
---
 drivers/virtio/virtio_rtc_driver.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/virtio/virtio_rtc_driver.c b/drivers/virtio/virtio_rtc_driver.c
index 4419735b0f0d..74616ba5be11 100644
--- a/drivers/virtio/virtio_rtc_driver.c
+++ b/drivers/virtio/virtio_rtc_driver.c
@@ -574,8 +574,8 @@ static int viortc_msg_xfer(struct viortc_vq *vq, struct viortc_msg *msg,
  * read requests
  */
 
-/** timeout for clock readings, where timeouts are considered non-fatal */
-#define VIORTC_MSG_READ_TIMEOUT secs_to_jiffies(60)
+/** timeout for runtime requests, where timeouts are considered non-fatal */
+#define VIORTC_MSG_TIMEOUT secs_to_jiffies(60)
 
 /**
  * viortc_read() - VIRTIO_RTC_REQ_READ wrapper
@@ -600,7 +600,7 @@ int viortc_read(struct viortc_dev *viortc, u16 vio_clk_id, u64 *reading)
 	VIORTC_MSG_WRITE(hdl, clock_id, &vio_clk_id);
 
 	ret = viortc_msg_xfer(&viortc->vqs[VIORTC_REQUESTQ], VIORTC_MSG(hdl),
-			      VIORTC_MSG_READ_TIMEOUT);
+			      VIORTC_MSG_TIMEOUT);
 	if (ret) {
 		dev_dbg(&viortc->vdev->dev, "%s: xfer returned %d\n", __func__,
 			ret);
@@ -642,7 +642,7 @@ int viortc_read_cross(struct viortc_dev *viortc, u16 vio_clk_id, u8 hw_counter,
 	VIORTC_MSG_WRITE(hdl, hw_counter, &hw_counter);
 
 	ret = viortc_msg_xfer(&viortc->vqs[VIORTC_REQUESTQ], VIORTC_MSG(hdl),
-			      VIORTC_MSG_READ_TIMEOUT);
+			      VIORTC_MSG_TIMEOUT);
 	if (ret) {
 		dev_dbg(&viortc->vdev->dev, "%s: xfer returned %d\n", __func__,
 			ret);
@@ -809,7 +809,7 @@ int viortc_read_alarm(struct viortc_dev *viortc, u16 vio_clk_id,
 	VIORTC_MSG_WRITE(hdl, clock_id, &vio_clk_id);
 
 	ret = viortc_msg_xfer(&viortc->vqs[VIORTC_REQUESTQ], VIORTC_MSG(hdl),
-			      0);
+			      VIORTC_MSG_TIMEOUT);
 	if (ret) {
 		dev_dbg(&viortc->vdev->dev, "%s: xfer returned %d\n", __func__,
 			ret);
@@ -858,7 +858,7 @@ int viortc_set_alarm(struct viortc_dev *viortc, u16 vio_clk_id, u64 alarm_time,
 	VIORTC_MSG_WRITE(hdl, flags, &flags);
 
 	ret = viortc_msg_xfer(&viortc->vqs[VIORTC_REQUESTQ], VIORTC_MSG(hdl),
-			      0);
+			      VIORTC_MSG_TIMEOUT);
 	if (ret) {
 		dev_dbg(&viortc->vdev->dev, "%s: xfer returned %d\n", __func__,
 			ret);
@@ -900,7 +900,7 @@ int viortc_set_alarm_enabled(struct viortc_dev *viortc, u16 vio_clk_id,
 	VIORTC_MSG_WRITE(hdl, flags, &flags);
 
 	ret = viortc_msg_xfer(&viortc->vqs[VIORTC_REQUESTQ], VIORTC_MSG(hdl),
-			      0);
+			      VIORTC_MSG_TIMEOUT);
 	if (ret) {
 		dev_dbg(&viortc->vdev->dev, "%s: xfer returned %d\n", __func__,
 			ret);

base-commit: 3b029c035b34bbc693405ddf759f0e9b920c27f1
-- 
2.43.0

