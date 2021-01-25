Return-Path: <SRS0=TROJ=G4=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 958A9C433E0
	for <virtualization@archiver.kernel.org>; Mon, 25 Jan 2021 04:51:03 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7CFA22CAD
	for <virtualization@archiver.kernel.org>; Mon, 25 Jan 2021 04:51:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7CFA22CAD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cloud.ionos.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 3CD3C86B89;
	Mon, 25 Jan 2021 04:51:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PC4QFORKVd40; Mon, 25 Jan 2021 04:51:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id AB29A86B9B;
	Mon, 25 Jan 2021 04:51:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8E73BC0FA7;
	Mon, 25 Jan 2021 04:51:00 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3D6A7C013A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Jan 2021 04:50:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 29D1686B9B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Jan 2021 04:50:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qveMIw9LkDG0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Jan 2021 04:50:57 +0000 (UTC)
X-Greylist: delayed 00:14:37 by SQLgrey-1.7.6
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com
 [209.85.215.169])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 7FE2A86B89
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Jan 2021 04:50:57 +0000 (UTC)
Received: by mail-pg1-f169.google.com with SMTP id z21so8110705pgj.4
 for <virtualization@lists.linux-foundation.org>;
 Sun, 24 Jan 2021 20:50:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cloud.ionos.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=T5YNgIrxBX6fSO1uhOYj11WRP7y8mCJCG6UXZFMUMjA=;
 b=EGw97nswwXd08Pj3+sWIL4ti+9YlSXulGKujjjzAHqHGWS5XhVFnpJ02q9S8WUqUZ1
 yj44hN0tL5eXwuks+p3F0bSmFG2to6KhbLDQ+bSeGWlYgZGfa3CrTNi9FyWkswwdY8VQ
 biUJPVMdB5U4ANOpJwuKQ6ozsjgEgRZSCJpZMMutGYnifSIVmtC89065pxx6oi78WTaO
 znsulJubrIh446r3rLooSFpAV4XTTnytEt1c5BeHWmXXQ6aUHRClQDK9cUOZqhYOKCjs
 mT0nu7qqhOu98tuy3LJq2EGC8SeffErW4mxZ06gRUVouukgx94ADwRTZhuxUjTMpV5R2
 lVkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=T5YNgIrxBX6fSO1uhOYj11WRP7y8mCJCG6UXZFMUMjA=;
 b=rLSHPrkHoEnubqIfLTFcz4fybAdxn4JO8ppdSkx/VSJICkItvCYtk3A6ngnnrfVril
 JXm9Xc0ZMzJwdw8ZdunV2ZAzHqhB54lUQI9OAGZMfrV7avLC/7Jl1xZ+gFOauoD0KSlJ
 nLfYpmjpdKfAZscTgXRL+JWAwosvwmi5WlEVUnvg9V5kV8ie8mWQAoNq6l3yicUkP2vK
 ZZ+XLlDMGJfxt4A5utKK1HWqR79GxvOgIs/GTP7AdwpIh5f1I64wYGynrXiIjbniFBbm
 p3vVWqUGphXyHkxr7eTQ9ITmqMGjscbTvA5Oz6TRzf8rjnd21bTpceK3ZH6iXu+XjF8h
 n4bQ==
X-Gm-Message-State: AOAM5307gD/MM0aFyRQyvZSwRhUkIKfNTIuc4MyiXnUL5My4gL/tgbMp
 qilwYfNSJWpc8fxO5sV8cWOV5A==
X-Google-Smtp-Source: ABdhPJxrjMpd3h6RGgg92+oDLbKLK9Y1xyMwNRPuEq/mP68ZCP68fxGlT9XubdX49i8m563mlVDMRw==
X-Received: by 2002:a62:444:0:b029:1bc:ebb6:71f8 with SMTP id
 65-20020a6204440000b02901bcebb671f8mr5247300pfe.75.1611550255849; 
 Sun, 24 Jan 2021 20:50:55 -0800 (PST)
Received: from gqjiang-home.profitbricks.net ([185.125.207.232])
 by smtp.gmail.com with ESMTPSA id l14sm16459423pjy.15.2021.01.24.20.50.35
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 24 Jan 2021 20:50:55 -0800 (PST)
From: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
To: axboe@kernel.dk
Subject: [PATCH V3 1/2] block: remove unnecessary argument from
 blk_execute_rq_nowait
Date: Mon, 25 Jan 2021 05:49:57 +0100
Message-Id: <1611550198-17142-2-git-send-email-guoqing.jiang@cloud.ionos.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1611550198-17142-1-git-send-email-guoqing.jiang@cloud.ionos.com>
References: <1611550198-17142-1-git-send-email-guoqing.jiang@cloud.ionos.com>
Cc: hch@infradead.org, linux-nfs@vger.kernel.org, linux-scsi@vger.kernel.org,
 linux-mmc@vger.kernel.org, linux-nvme@lists.infradead.org,
 virtualization@lists.linux-foundation.org, linux-block@vger.kernel.org,
 linux-ide@vger.kernel.org, target-devel@vger.kernel.org
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

The 'q' is not used since commit a1ce35fa4985 ("block: remove dead
elevator code"), also update the comment of the function.

And more importantly it never really was needed to start with given
that we can trivial derive it from struct request.

Cc: target-devel@vger.kernel.org
Cc: linux-scsi@vger.kernel.org
Cc: virtualization@lists.linux-foundation.org
Cc: linux-ide@vger.kernel.org
Cc: linux-mmc@vger.kernel.org
Cc: linux-nvme@lists.infradead.org
Cc: linux-nfs@vger.kernel.org
Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
---
 block/blk-exec.c                   | 10 ++++------
 drivers/block/sx8.c                |  4 ++--
 drivers/nvme/host/core.c           |  4 ++--
 drivers/nvme/host/lightnvm.c       |  2 +-
 drivers/nvme/host/pci.c            |  4 ++--
 drivers/nvme/target/passthru.c     |  2 +-
 drivers/scsi/scsi_error.c          |  2 +-
 drivers/scsi/sg.c                  |  3 +--
 drivers/scsi/st.c                  |  2 +-
 drivers/target/target_core_pscsi.c |  3 +--
 include/linux/blkdev.h             |  2 +-
 11 files changed, 17 insertions(+), 21 deletions(-)

diff --git a/block/blk-exec.c b/block/blk-exec.c
index 85324d5..2e37e85 100644
--- a/block/blk-exec.c
+++ b/block/blk-exec.c
@@ -31,8 +31,7 @@ static void blk_end_sync_rq(struct request *rq, blk_status_t error)
 }
 
 /**
- * blk_execute_rq_nowait - insert a request into queue for execution
- * @q:		queue to insert the request in
+ * blk_execute_rq_nowait - insert a request to I/O scheduler for execution
  * @bd_disk:	matching gendisk
  * @rq:		request to insert
  * @at_head:    insert request at head or tail of queue
@@ -45,9 +44,8 @@ static void blk_end_sync_rq(struct request *rq, blk_status_t error)
  * Note:
  *    This function will invoke @done directly if the queue is dead.
  */
-void blk_execute_rq_nowait(struct request_queue *q, struct gendisk *bd_disk,
-			   struct request *rq, int at_head,
-			   rq_end_io_fn *done)
+void blk_execute_rq_nowait(struct gendisk *bd_disk, struct request *rq,
+			   int at_head, rq_end_io_fn *done)
 {
 	WARN_ON(irqs_disabled());
 	WARN_ON(!blk_rq_is_passthrough(rq));
@@ -83,7 +81,7 @@ void blk_execute_rq(struct request_queue *q, struct gendisk *bd_disk,
 	unsigned long hang_check;
 
 	rq->end_io_data = &wait;
-	blk_execute_rq_nowait(q, bd_disk, rq, at_head, blk_end_sync_rq);
+	blk_execute_rq_nowait(bd_disk, rq, at_head, blk_end_sync_rq);
 
 	/* Prevent hang_check timer from firing at us during very long I/O */
 	hang_check = sysctl_hung_task_timeout_secs;
diff --git a/drivers/block/sx8.c b/drivers/block/sx8.c
index 4478eb7..2cdf277 100644
--- a/drivers/block/sx8.c
+++ b/drivers/block/sx8.c
@@ -539,7 +539,7 @@ static int carm_array_info (struct carm_host *host, unsigned int array_idx)
 	spin_unlock_irq(&host->lock);
 
 	DPRINTK("blk_execute_rq_nowait, tag == %u\n", rq->tag);
-	blk_execute_rq_nowait(host->oob_q, NULL, rq, true, NULL);
+	blk_execute_rq_nowait(NULL, rq, true, NULL);
 
 	return 0;
 
@@ -578,7 +578,7 @@ static int carm_send_special (struct carm_host *host, carm_sspc_t func)
 	crq->msg_bucket = (u32) rc;
 
 	DPRINTK("blk_execute_rq_nowait, tag == %u\n", rq->tag);
-	blk_execute_rq_nowait(host->oob_q, NULL, rq, true, NULL);
+	blk_execute_rq_nowait(NULL, rq, true, NULL);
 
 	return 0;
 }
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index a39befb..0bea9ae 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -925,7 +925,7 @@ static void nvme_execute_rq_polled(struct request_queue *q,
 
 	rq->cmd_flags |= REQ_HIPRI;
 	rq->end_io_data = &wait;
-	blk_execute_rq_nowait(q, bd_disk, rq, at_head, nvme_end_sync_rq);
+	blk_execute_rq_nowait(bd_disk, rq, at_head, nvme_end_sync_rq);
 
 	while (!completion_done(&wait)) {
 		blk_poll(q, request_to_qc_t(rq->mq_hctx, rq), true);
@@ -1202,7 +1202,7 @@ static int nvme_keep_alive(struct nvme_ctrl *ctrl)
 	rq->timeout = ctrl->kato * HZ;
 	rq->end_io_data = ctrl;
 
-	blk_execute_rq_nowait(rq->q, NULL, rq, 0, nvme_keep_alive_end_io);
+	blk_execute_rq_nowait(NULL, rq, 0, nvme_keep_alive_end_io);
 
 	return 0;
 }
diff --git a/drivers/nvme/host/lightnvm.c b/drivers/nvme/host/lightnvm.c
index 6c8eab8..0e5a550 100644
--- a/drivers/nvme/host/lightnvm.c
+++ b/drivers/nvme/host/lightnvm.c
@@ -695,7 +695,7 @@ static int nvme_nvm_submit_io(struct nvm_dev *dev, struct nvm_rq *rqd,
 
 	rq->end_io_data = rqd;
 
-	blk_execute_rq_nowait(q, NULL, rq, 0, nvme_nvm_end_io);
+	blk_execute_rq_nowait(NULL, rq, 0, nvme_nvm_end_io);
 
 	return 0;
 
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 856aa31..5b78e68 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1357,7 +1357,7 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
 	}
 
 	abort_req->end_io_data = NULL;
-	blk_execute_rq_nowait(abort_req->q, NULL, abort_req, 0, abort_endio);
+	blk_execute_rq_nowait(NULL, abort_req, 0, abort_endio);
 
 	/*
 	 * The aborted req will be completed on receiving the abort req.
@@ -2281,7 +2281,7 @@ static int nvme_delete_queue(struct nvme_queue *nvmeq, u8 opcode)
 	req->end_io_data = nvmeq;
 
 	init_completion(&nvmeq->delete_done);
-	blk_execute_rq_nowait(q, NULL, req, false,
+	blk_execute_rq_nowait(NULL, req, false,
 			opcode == nvme_admin_delete_cq ?
 				nvme_del_cq_end : nvme_del_queue_end);
 	return 0;
diff --git a/drivers/nvme/target/passthru.c b/drivers/nvme/target/passthru.c
index b9776fc..cbc88ac 100644
--- a/drivers/nvme/target/passthru.c
+++ b/drivers/nvme/target/passthru.c
@@ -275,7 +275,7 @@ static void nvmet_passthru_execute_cmd(struct nvmet_req *req)
 		schedule_work(&req->p.work);
 	} else {
 		rq->end_io_data = req;
-		blk_execute_rq_nowait(rq->q, ns ? ns->disk : NULL, rq, 0,
+		blk_execute_rq_nowait(ns ? ns->disk : NULL, rq, 0,
 				      nvmet_passthru_req_done);
 	}
 
diff --git a/drivers/scsi/scsi_error.c b/drivers/scsi/scsi_error.c
index f11f51e..c00f06e 100644
--- a/drivers/scsi/scsi_error.c
+++ b/drivers/scsi/scsi_error.c
@@ -2007,7 +2007,7 @@ static void scsi_eh_lock_door(struct scsi_device *sdev)
 	req->timeout = 10 * HZ;
 	rq->retries = 5;
 
-	blk_execute_rq_nowait(req->q, NULL, req, 1, eh_lock_door_done);
+	blk_execute_rq_nowait(NULL, req, 1, eh_lock_door_done);
 }
 
 /**
diff --git a/drivers/scsi/sg.c b/drivers/scsi/sg.c
index bfa8d77..4383d93 100644
--- a/drivers/scsi/sg.c
+++ b/drivers/scsi/sg.c
@@ -829,8 +829,7 @@ sg_common_write(Sg_fd * sfp, Sg_request * srp,
 
 	srp->rq->timeout = timeout;
 	kref_get(&sfp->f_ref); /* sg_rq_end_io() does kref_put(). */
-	blk_execute_rq_nowait(sdp->device->request_queue, sdp->disk,
-			      srp->rq, at_head, sg_rq_end_io);
+	blk_execute_rq_nowait(sdp->disk, srp->rq, at_head, sg_rq_end_io);
 	return 0;
 }
 
diff --git a/drivers/scsi/st.c b/drivers/scsi/st.c
index 43f7624..841ad2f 100644
--- a/drivers/scsi/st.c
+++ b/drivers/scsi/st.c
@@ -585,7 +585,7 @@ static int st_scsi_execute(struct st_request *SRpnt, const unsigned char *cmd,
 	rq->retries = retries;
 	req->end_io_data = SRpnt;
 
-	blk_execute_rq_nowait(req->q, NULL, req, 1, st_scsi_execute_end);
+	blk_execute_rq_nowait(NULL, req, 1, st_scsi_execute_end);
 	return 0;
 }
 
diff --git a/drivers/target/target_core_pscsi.c b/drivers/target/target_core_pscsi.c
index 7994f27..33770e5 100644
--- a/drivers/target/target_core_pscsi.c
+++ b/drivers/target/target_core_pscsi.c
@@ -1000,8 +1000,7 @@ pscsi_execute_cmd(struct se_cmd *cmd)
 		req->timeout = PS_TIMEOUT_OTHER;
 	scsi_req(req)->retries = PS_RETRY;
 
-	blk_execute_rq_nowait(pdv->pdv_sd->request_queue, NULL, req,
-			(cmd->sam_task_attr == TCM_HEAD_TAG),
+	blk_execute_rq_nowait(NULL, req, (cmd->sam_task_attr == TCM_HEAD_TAG),
 			pscsi_req_done);
 
 	return 0;
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 4526b9e..623a612 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -950,7 +950,7 @@ extern int blk_rq_map_user_iov(struct request_queue *, struct request *,
 			       gfp_t);
 extern void blk_execute_rq(struct request_queue *, struct gendisk *,
 			  struct request *, int);
-extern void blk_execute_rq_nowait(struct request_queue *, struct gendisk *,
+extern void blk_execute_rq_nowait(struct gendisk *,
 				  struct request *, int, rq_end_io_fn *);
 
 /* Helper to convert REQ_OP_XXX to its string format XXX */
-- 
2.7.4

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
