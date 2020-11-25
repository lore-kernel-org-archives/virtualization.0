Return-Path: <SRS0=EQvy=E7=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA492C64E7C
	for <virtualization@archiver.kernel.org>; Wed, 25 Nov 2020 15:37:05 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3ADE1221F8
	for <virtualization@archiver.kernel.org>; Wed, 25 Nov 2020 15:37:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="FIJ8RCVq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3ADE1221F8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id B942E87222;
	Wed, 25 Nov 2020 15:37:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dYSbCPpewyDk; Wed, 25 Nov 2020 15:37:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 6279F871C8;
	Wed, 25 Nov 2020 15:37:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4CE5FC163C;
	Wed, 25 Nov 2020 15:37:03 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 73B44C0052
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Nov 2020 15:37:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 64D7C2E181
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Nov 2020 15:37:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZGA+WTvBMGGi
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Nov 2020 15:37:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by silver.osuosl.org (Postfix) with ESMTPS id C86ED2E0DA
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Nov 2020 15:36:59 +0000 (UTC)
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net
 [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 5499121D7F;
 Wed, 25 Nov 2020 15:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1606318619;
 bh=/8c1Man/mllWLcUVYHSfgb+rDJvQlTZhZsG1a0laReg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=FIJ8RCVqJIybrC1p9dh1xddFqrt6noy/q+RQ2eoBhrs6Hm+kMqdIsA/UFQFG7drfo
 HHkBDlJLunJYDvZ5W0AZEToCxZtNZVII65Fh+EK6CKX3xFOZd6u3349y67HLTlOP/N
 BPhmWTiIRcQIz9MmR8FYV+KArVDGTFsJmDrr29Rs=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 15/23] vhost scsi: fix cmd completion race
Date: Wed, 25 Nov 2020 10:36:30 -0500
Message-Id: <20201125153638.810419-15-sashal@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201125153638.810419-1-sashal@kernel.org>
References: <20201125153638.810419-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Cc: Maurizio Lombardi <mlombard@redhat.com>, Sasha Levin <sashal@kernel.org>,
 kvm@vger.kernel.org, "Michael S . Tsirkin" <mst@redhat.com>,
 netdev@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Mike Christie <michael.christie@oracle.com>
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

From: Mike Christie <michael.christie@oracle.com>

[ Upstream commit 47a3565e8bb14ec48a75b48daf57aa830e2691f8 ]

We might not do the final se_cmd put from vhost_scsi_complete_cmd_work.
When the last put happens a little later then we could race where
vhost_scsi_complete_cmd_work does vhost_signal, the guest runs and sends
more IO, and vhost_scsi_handle_vq runs but does not find any free cmds.

This patch has us delay completing the cmd until the last lio core ref
is dropped. We then know that once we signal to the guest that the cmd
is completed that if it queues a new command it will find a free cmd.

Signed-off-by: Mike Christie <michael.christie@oracle.com>
Reviewed-by: Maurizio Lombardi <mlombard@redhat.com>
Link: https://lore.kernel.org/r/1604986403-4931-4-git-send-email-michael.christie@oracle.com
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/vhost/scsi.c | 42 +++++++++++++++---------------------------
 1 file changed, 15 insertions(+), 27 deletions(-)

diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
index f63f84a257256..98c484149ac7f 100644
--- a/drivers/vhost/scsi.c
+++ b/drivers/vhost/scsi.c
@@ -320,7 +320,7 @@ static u32 vhost_scsi_tpg_get_inst_index(struct se_portal_group *se_tpg)
 	return 1;
 }
 
-static void vhost_scsi_release_cmd(struct se_cmd *se_cmd)
+static void vhost_scsi_release_cmd_res(struct se_cmd *se_cmd)
 {
 	struct vhost_scsi_cmd *tv_cmd = container_of(se_cmd,
 				struct vhost_scsi_cmd, tvc_se_cmd);
@@ -340,6 +340,16 @@ static void vhost_scsi_release_cmd(struct se_cmd *se_cmd)
 	target_free_tag(se_sess, se_cmd);
 }
 
+static void vhost_scsi_release_cmd(struct se_cmd *se_cmd)
+{
+	struct vhost_scsi_cmd *cmd = container_of(se_cmd,
+					struct vhost_scsi_cmd, tvc_se_cmd);
+	struct vhost_scsi *vs = cmd->tvc_vhost;
+
+	llist_add(&cmd->tvc_completion_list, &vs->vs_completion_list);
+	vhost_work_queue(&vs->dev, &vs->vs_completion_work);
+}
+
 static u32 vhost_scsi_sess_get_index(struct se_session *se_sess)
 {
 	return 0;
@@ -362,28 +372,15 @@ static int vhost_scsi_get_cmd_state(struct se_cmd *se_cmd)
 	return 0;
 }
 
-static void vhost_scsi_complete_cmd(struct vhost_scsi_cmd *cmd)
-{
-	struct vhost_scsi *vs = cmd->tvc_vhost;
-
-	llist_add(&cmd->tvc_completion_list, &vs->vs_completion_list);
-
-	vhost_work_queue(&vs->dev, &vs->vs_completion_work);
-}
-
 static int vhost_scsi_queue_data_in(struct se_cmd *se_cmd)
 {
-	struct vhost_scsi_cmd *cmd = container_of(se_cmd,
-				struct vhost_scsi_cmd, tvc_se_cmd);
-	vhost_scsi_complete_cmd(cmd);
+	transport_generic_free_cmd(se_cmd, 0);
 	return 0;
 }
 
 static int vhost_scsi_queue_status(struct se_cmd *se_cmd)
 {
-	struct vhost_scsi_cmd *cmd = container_of(se_cmd,
-				struct vhost_scsi_cmd, tvc_se_cmd);
-	vhost_scsi_complete_cmd(cmd);
+	transport_generic_free_cmd(se_cmd, 0);
 	return 0;
 }
 
@@ -429,15 +426,6 @@ vhost_scsi_allocate_evt(struct vhost_scsi *vs,
 	return evt;
 }
 
-static void vhost_scsi_free_cmd(struct vhost_scsi_cmd *cmd)
-{
-	struct se_cmd *se_cmd = &cmd->tvc_se_cmd;
-
-	/* TODO locking against target/backend threads? */
-	transport_generic_free_cmd(se_cmd, 0);
-
-}
-
 static int vhost_scsi_check_stop_free(struct se_cmd *se_cmd)
 {
 	return target_put_sess_cmd(se_cmd);
@@ -556,7 +544,7 @@ static void vhost_scsi_complete_cmd_work(struct vhost_work *work)
 		} else
 			pr_err("Faulted on virtio_scsi_cmd_resp\n");
 
-		vhost_scsi_free_cmd(cmd);
+		vhost_scsi_release_cmd_res(se_cmd);
 	}
 
 	vq = -1;
@@ -1088,7 +1076,7 @@ vhost_scsi_handle_vq(struct vhost_scsi *vs, struct vhost_virtqueue *vq)
 						      &prot_iter, exp_data_len,
 						      &data_iter))) {
 				vq_err(vq, "Failed to map iov to sgl\n");
-				vhost_scsi_release_cmd(&cmd->tvc_se_cmd);
+				vhost_scsi_release_cmd_res(&cmd->tvc_se_cmd);
 				goto err;
 			}
 		}
-- 
2.27.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
