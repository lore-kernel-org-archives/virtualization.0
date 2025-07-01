Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDFE4274FEE
	for <virtualization@lists.linux-foundation.org>; Tue,  1 Jul 2025 13:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751375929; cv=none; b=l8OCvjw3OwgIK6tYtg8gcl1cZCw3vEqYTewWuK6D6WzRYuvqUj43jRo3UYXkzkBNM2FKMSAlmt3Rz2uoSfaU5g8RDa/uzL5wvFKksvsKBeoG9RPQxUgV9aYyfgA8PZF2rEZo5VDbQVaF5lR4eWI8YskJEGotJk7suqQsBnPPgnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751375929; c=relaxed/simple;
	bh=ZH/q3VNf/bXbhSvmsNcfK1lIDc6sWxMcPfDrISGe4GI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TmEzXKaeY5r9vX8vzsmKxKe8i8ajPvA3+g839NDGcFZ++A3zwbA0t+m7TisDcU/1s+8VHHEBMUa+tas63DYbcQhfqq8e4FdXx8dRZGzcHQUuv4djBuo3vu+RAhNrvuzrbp5O9Mc5Q9BoDk2sRNUEus2wWdQRA32CAHgK7N6MHu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 52EDC84A0E
	for <virtualization@lists.linux-foundation.org>; Tue,  1 Jul 2025 13:18:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -7.891
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fqjerfgEmZLF for <virtualization@lists.linux-foundation.org>;
 Tue,  1 Jul 2025 13:18:46 +0000 (UTC)
X-Greylist: delayed 1107 seconds by postgrey-1.37 at util1.osuosl.org; Tue, 01 Jul 2025 13:18:44 UTC
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 6CAFF8432E
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6CAFF8432E
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=45.249.212.190; helo=szxga04-in.huawei.com; envelope-from=zhengxinyu6@huawei.com; receiver=<UNKNOWN> 
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 6CAFF8432E
	for <virtualization@lists.linux-foundation.org>; Tue,  1 Jul 2025 13:18:43 +0000 (UTC)
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4bWjh85W7tz20sxk;
	Tue,  1 Jul 2025 20:56:08 +0800 (CST)
Received: from kwepemo200008.china.huawei.com (unknown [7.202.195.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 101BB1A016C;
	Tue,  1 Jul 2025 21:00:09 +0800 (CST)
Received: from huawei.com (10.67.175.28) by kwepemo200008.china.huawei.com
 (7.202.195.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 1 Jul
 2025 21:00:08 +0800
From: ZHENG Xinyu <zhengxinyu6@huawei.com>
To: <mst@redhat.com>, <jasowang@redhat.com>
CC: <pbonzini@redhat.com>, <stefanha@redhat.com>,
	<virtualization@lists.linux-foundation.org>, <kvm@vger.kernel.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 5.10] vhost-scsi: protect vq->log_used with vq->mutex
Date: Tue, 1 Jul 2025 12:48:48 +0000
Message-ID: <20250701124848.4162114-1-zhengxinyu6@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemo200008.china.huawei.com (7.202.195.61)

From: Dongli Zhang <dongli.zhang@oracle.com>

The vhost-scsi completion path may access vq->log_base when vq->log_used is
already set to false.

    vhost-thread                       QEMU-thread

vhost_scsi_complete_cmd_work()
-> vhost_add_used()
   -> vhost_add_used_n()
      if (unlikely(vq->log_used))
                                      QEMU disables vq->log_used
                                      via VHOST_SET_VRING_ADDR.
                                      mutex_lock(&vq->mutex);
                                      vq->log_used = false now!
                                      mutex_unlock(&vq->mutex);

				      QEMU gfree(vq->log_base)
        log_used()
        -> log_write(vq->log_base)

Assuming the VMM is QEMU. The vq->log_base is from QEMU userpace and can be
reclaimed via gfree(). As a result, this causes invalid memory writes to
QEMU userspace.

The control queue path has the same issue.

Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Reviewed-by: Mike Christie <michael.christie@oracle.com>
Message-Id: <20250403063028.16045-2-dongli.zhang@oracle.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Zheng Xinyu <zhengxinyu6@huawei.com>
---
 drivers/vhost/scsi.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
index a23a65e7d828..fcde3752b4f1 100644
--- a/drivers/vhost/scsi.c
+++ b/drivers/vhost/scsi.c
@@ -579,8 +579,10 @@ static void vhost_scsi_complete_cmd_work(struct vhost_work *work)
 		ret = copy_to_iter(&v_rsp, sizeof(v_rsp), &iov_iter);
 		if (likely(ret == sizeof(v_rsp))) {
 			struct vhost_scsi_virtqueue *q;
-			vhost_add_used(cmd->tvc_vq, cmd->tvc_vq_desc, 0);
 			q = container_of(cmd->tvc_vq, struct vhost_scsi_virtqueue, vq);
+			mutex_lock(&q->vq.mutex);
+			vhost_add_used(cmd->tvc_vq, cmd->tvc_vq_desc, 0);
+			mutex_unlock(&q->vq.mutex);
 			vq = q - vs->vqs;
 			__set_bit(vq, signal);
 		} else
@@ -1193,8 +1195,11 @@ static void vhost_scsi_tmf_resp_work(struct vhost_work *work)
 	else
 		resp_code = VIRTIO_SCSI_S_FUNCTION_REJECTED;
 
+	mutex_lock(&tmf->svq->vq.mutex);
 	vhost_scsi_send_tmf_resp(tmf->vhost, &tmf->svq->vq, tmf->in_iovs,
 				 tmf->vq_desc, &tmf->resp_iov, resp_code);
+	mutex_unlock(&tmf->svq->vq.mutex);
+
 	vhost_scsi_release_tmf_res(tmf);
 }
 
-- 
2.34.1

