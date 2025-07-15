Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12D932114
	for <virtualization@lists.linux-foundation.org>; Tue, 15 Jul 2025 03:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752550372; cv=none; b=qI1285PDFQgUO1oH9JRCGbEvMT2KAgn2Yp4pkw6eS678FHhcEgejHU6x0oDAw/1TWkw9t7V0oNgUyWNf0bDqvYfzFatDamOsK+Ig6thHVt3WemptzDlgDb4EjBJZS800QSQW7ctEjltEhmypsXweFhNh6maKE8h7CcE5TgYUBMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752550372; c=relaxed/simple;
	bh=UJ+ui+6YpbQeBXRY8FDN7OeI2IwWSgW+6ApfXKdlyAE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tCBHsxUTGw+EZkcAy0aQ+Cgh2Luk6FS68+Grted1dx9A1mbnQhpf6ZWatvZELa8UnBVzEzjGml4Kvz/vMKPnaX/luW/7IN8ZoPQslyu/DqZIpcyr7CVZ8aYQ8uftFe9MVWb08OEkIQH+oa8xYTVz+XsGmhg46y0cs5dTaMCH7zI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 60BA1606EA
	for <virtualization@lists.linux-foundation.org>; Tue, 15 Jul 2025 03:32:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -7.891
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id t-BtI7F-_88P for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Jul 2025 03:32:48 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=45.249.212.190; helo=szxga04-in.huawei.com; envelope-from=zhengxinyu6@huawei.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org B984F60664
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B984F60664
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	by smtp3.osuosl.org (Postfix) with ESMTPS id B984F60664
	for <virtualization@lists.linux-foundation.org>; Tue, 15 Jul 2025 03:32:46 +0000 (UTC)
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4bh4T84DfTz2TSvn;
	Tue, 15 Jul 2025 11:30:36 +0800 (CST)
Received: from kwepemo200008.china.huawei.com (unknown [7.202.195.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 461411400CB;
	Tue, 15 Jul 2025 11:32:39 +0800 (CST)
Received: from huawei.com (10.67.175.28) by kwepemo200008.china.huawei.com
 (7.202.195.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 15 Jul
 2025 11:32:38 +0800
From: Xinyu Zheng <zhengxinyu6@huawei.com>
To: <mst@redhat.com>, <jasowang@redhat.com>, <pbonzini@redhat.com>,
	<stefanha@redhat.com>, <virtualization@lists.linux-foundation.org>,
	<kvm@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <gregkh@linuxfoundation.org>,
	<stable@vger.kernel.org>
CC: <zhengxinyu6@huawei.com>
Subject: [PATCH v5.10 v2] vhost-scsi: protect vq->log_used with vq->mutex
Date: Tue, 15 Jul 2025 03:21:03 +0000
Message-ID: <20250715032103.1624084-1-zhengxinyu6@huawei.com>
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

[ Upstream commit f591cf9fce724e5075cc67488c43c6e39e8cbe27 ]

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

Cc: stable@vger.kernel.org#5.10.x
Cc: gregkh@linuxfoundation.org
Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Reviewed-by: Mike Christie <michael.christie@oracle.com>
Message-Id: <20250403063028.16045-2-dongli.zhang@oracle.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
[ Conflicts in drivers/vhost/scsi.c
  bacause vhost_scsi_complete_cmd_work() has been refactored. ]
Signed-off-by: Xinyu Zheng <zhengxinyu6@huawei.com>
---
V1 -> V2: Remove unnecessary CVE tag
 
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

