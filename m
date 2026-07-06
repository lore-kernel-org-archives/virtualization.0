Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9BB3ED3C3;
	Mon,  6 Jul 2026 08:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.22.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783326779; cv=none; b=sFFe55X7NzVORrJJNMt5TxiOY16L1URuYmaJGFCMC4FkPzcvBAYfveC1Dn+TRAzM3RtcYEq1wIi2vGXJdJVYxPv+PjsqSo+v34bdD6gLgwnGIIG/nBkd3/YYXGpLfvSwQynk0VGmPWaDWG/Hk3JXdnC9LDTZBPGJJvC9wQXXsho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783326779; c=relaxed/simple;
	bh=G6TJDV8n7CKUZj6TUumyToZT9ULQcJTdPYcRUpNHG/A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=My+p5rsXhaTgQNAlvrWiRrPriEsRzCqbf/hSFMjglz/xbbVRWPqnvR3YOfbvFmkp3lsna4HDeEq6ElVzJMn/gJZBECwFvu3dnYPF5JFmwYja2i1wAzETlJxU9mtPOw6vCsAALmKCZ1pz6hvsfDCLgv/UMooT/2D8m7j+b+R8Ftg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=iD/o8aFh; arc=none smtp.client-ip=54.207.22.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="iD/o8aFh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1783326729;
	bh=LHY1VQfhrrYW8PNV1KnluZMuXn8FcGRCpR/5ZSVPgrI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=iD/o8aFh1mUSZ4PQ1yNyN10luWwBbLWaakf21TFnmSd4LW9kU4bjxmEcRRcWKsvuO
	 JTz6fpHB32lxxVz7S3AuPvss6PZwbjAvGQGQel3/JKRs42K3Kg/kd+30V3j4ZMqfD8
	 TEUrVwCd+3/7jhBcmEf5/WEzAtJafvd4nAwkeFhU=
X-QQ-mid: esmtpsz18t1783326712t8e702ae8
X-QQ-Originating-IP: XDXjbWGoNs4i6VO7x86R7FeHoNs+/OyWb8dJDDo2lF0=
Received: from PEN202512010004 ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 06 Jul 2026 16:31:50 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 2413049374460835585
EX-QQ-RecipientCnt: 8
From: raoxu <raoxu@uniontech.com>
To: jpb@kernel.org
Cc: joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	virtualization@lists.linux.dev,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	raoxu@uniontech.com
Subject: [PATCH] iommu/virtio: reject short event buffers
Date: Mon,  6 Jul 2026 16:31:48 +0800
Message-ID: <6800BE0812AF0897+20260706083148.788991-1-raoxu@uniontech.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: NQDSFSrlZSaikEkST05ga6AwWQMyj8qAV9DqfzBkeSkhTE5oiF9cJRBY
	dD9biB+lQAfw+vH+YP/N4WNGRsAlaf9yun4II6Axdve7GCpBQM/FCiSZRLjhVdexIQTa+fM
	Qe2p/cGvrdVIyc2zrddVfsz1Tg08Kxcc3bzpHPxFEmic8joD8SXTLjH/CsuNoGG75Yxvz1F
	aAYN27LhZEh8Kf9IIgsLaMXlQGjSIc7at0Q3Nhggx3HEngwMc+J7cjZ+ic8WF1yA7oJPV+E
	+tobQRMmOAnzmN9mfXdvSxCtzVlDAY8YnngdK0bc3wILOWWUl/Nbn1j4xI43sze1lV3NCze
	hX7ScPrsVD+IeTxSfrNs9KD5Yh7Kg2n12sk4Xp0eKExJzuS7mkWTB+T7Ih3sX9as1qutCC/
	3uQBXNAwPBo01lNDlYnKP9d+Pn/6Gaca61brKVv9DqPRJdwwjzW0tv0aaVko1NSVVlcee9Z
	xzi/cxY55IJMDJYsM/MNqN4pcC92AdWfIexgxLAkPPA7JxsEDdP3hLTKBc6qDHcNt9sy7Zv
	Jr96QUlbvN3Ivzu7nX38AeV1C/sKq3Uq6553t2TXIx6SBRQyiBVaEQxrzRqEUakh/rihhuw
	aCQOxVDDqoaQWhCBcmae/h2ZRtG9GTXXfZZixE+m8p44BZq6UWb9AboPGAV61gbEWMA9doQ
	bzsZsMWLJIgLN0YBrmK5wQ8x8XKNhVt0j6AyN6RFcJvw/QfYEqKrtU7x6ZiDmlNXL1fBwXl
	Qcj7PqVcnNsIF1H/NjugutpBLWprmlaMV9KyMHHZDB14tO0IaQ0Ev8a5oioL27rpoEmKlh2
	4VVlzHUCeyNdg6uotTrSULottkQ9FcorcgzIJkXkwEA1yb4m64IffMl3yg5B5fjQ2gZCzHU
	Ymi7D1+EHcsGy1hcXFra0nZRiiKNYwFnJJOT+3GWhgVKTtEcO0J2EpIBxXdxGgJZQWOGLG5
	SuWpx3DJymB/8o298YYJEaAiSuOAfjfqvS19bPzsfnZ4xsnTpW0gWJyjJHmHo8oAvgxe3np
	ezM/LgKIPMOWewkK95hfEMH2AvTBLOv/hv8uT8JwTZjsXoRhx6
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
X-QQ-RECHKSPAM: 0

From: Xu Rao <raoxu@uniontech.com>

The event queue uses fixed-size buffers for struct viommu_event. The
device-reported used length is currently only checked for oversized
buffers, so a short used buffer can still be passed to the fault
handler.

In that case the handler parses fields that were not written by the
device for this event, potentially using stale data from a previous
event and reporting a bogus fault.

Reject any event buffer whose used length is not exactly the expected
event size. Still recycle the buffer back to the event queue so a bad
event does not permanently shrink the queue.

Signed-off-by: Xu Rao <raoxu@uniontech.com>
---
 drivers/iommu/virtio-iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
index 587fc13197f1..3ace4a6dd02a 100644
--- a/drivers/iommu/virtio-iommu.c
+++ b/drivers/iommu/virtio-iommu.c
@@ -635,7 +635,7 @@ static void viommu_event_handler(struct virtqueue *vq)
 	struct viommu_dev *viommu = vq->vdev->priv;

 	while ((evt = virtqueue_get_buf(vq, &len)) != NULL) {
-		if (len > sizeof(*evt)) {
+		if (len != sizeof(*evt)) {
 			dev_err(viommu->dev,
 				"invalid event buffer (len %u != %zu)\n",
 				len, sizeof(*evt));
--
2.50.1

