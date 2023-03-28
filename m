Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00A37C761A6
	for <virtualization@archiver.kernel.org>; Tue, 28 Mar 2023 02:17:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8509A41864;
	Tue, 28 Mar 2023 02:17:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8509A41864
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2022-7-12 header.b=B/ih+LEi
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qu54DyJNI1LF; Tue, 28 Mar 2023 02:17:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id BD1B241868;
	Tue, 28 Mar 2023 02:17:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BD1B241868
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1A449C008E;
	Tue, 28 Mar 2023 02:17:39 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8BDD6C007C
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Mar 2023 02:17:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5978F41861
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Mar 2023 02:17:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5978F41861
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ueKmcm6d9fv2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Mar 2023 02:17:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 799904185C
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 799904185C
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Mar 2023 02:17:35 +0000 (UTC)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 32S24qUR015800; Tue, 28 Mar 2023 02:17:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2022-7-12;
 bh=w2qn3c/+T1LSVPjY/f/72x+XlVnI1XvtYmOoXEwQ2nU=;
 b=B/ih+LEiicnHHa00rDBKLU/dn/ONhMbDchnBPAGdWOYW6ePj1vC5j4JgAPjm94/j7wXU
 edzpoQMEQo+lkKpZl/50NXXm3gLe7wUAgiQKp2+/YL+OPI7FlTO+YvzVucNvE9mM7UQT
 Kjkyp3YR8ZtCA9bVBhr6Wb1gZvgFfh6KWi1Xw0G3xfS7/PoB7zbHwfVmfiWQYSZ/2AsH
 PfOLI2QCp3NnEkq6xYRoJn79Wp2HOT17jr68rIigtC42MAMZRpKpYU2ieSyb1PYZastQ
 uj5Rpq+ZirVyfAejM/qXPFWuXtZw91GecAaQspVQC2UKi0XHocVVAuziL2Sxn72KBTIh 2g== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pkq4gr0fr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 28 Mar 2023 02:17:34 +0000
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5)
 with ESMTP id 32RNsOk3020419; Tue, 28 Mar 2023 02:17:33 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3phqd61bvc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 28 Mar 2023 02:17:33 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 32S2FZlv038246;
 Tue, 28 Mar 2023 02:17:32 GMT
Received: from mnchrist-mac.us.oracle.com (dhcp-10-154-123-40.vpn.oracle.com
 [10.154.123.40])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 3phqd61bky-11; Tue, 28 Mar 2023 02:17:32 +0000
From: Mike Christie <michael.christie@oracle.com>
To: stefanha@redhat.com, jasowang@redhat.com, mst@redhat.com,
 sgarzare@redhat.com, virtualization@lists.linux-foundation.org
Subject: [PATCH v6 10/11] vhost-scsi: flush IO vqs then send TMF rsp
Date: Mon, 27 Mar 2023 21:17:16 -0500
Message-Id: <20230328021717.42268-11-michael.christie@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230328021717.42268-1-michael.christie@oracle.com>
References: <20230328021717.42268-1-michael.christie@oracle.com>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-24_11,2023-03-27_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 mlxscore=0 phishscore=0
 malwarescore=0 adultscore=0 spamscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2303280016
X-Proofpoint-GUID: jvppphEugHi-eJDDYD0usGzu5fssWbTS
X-Proofpoint-ORIG-GUID: jvppphEugHi-eJDDYD0usGzu5fssWbTS
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

With one worker we will always send the scsi cmd responses then send the
TMF rsp, because LIO will always complete the scsi cmds first then call
into us to send the TMF response.

With multiple workers, the IO vq workers could be running while the
TMF/ctl vq worker is so this has us do a flush before completing the TMF
to make sure cmds are completed when it's work is later queued and run.

Signed-off-by: Mike Christie <michael.christie@oracle.com>
---
 drivers/vhost/scsi.c  | 22 +++++++++++++++++++---
 drivers/vhost/vhost.c |  6 ++++++
 drivers/vhost/vhost.h |  1 +
 3 files changed, 26 insertions(+), 3 deletions(-)

diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
index 3e86b5fbeca6..48dba4fe2dac 100644
--- a/drivers/vhost/scsi.c
+++ b/drivers/vhost/scsi.c
@@ -1158,12 +1158,28 @@ static void vhost_scsi_tmf_resp_work(struct vhost_work *work)
 {
 	struct vhost_scsi_tmf *tmf = container_of(work, struct vhost_scsi_tmf,
 						  vwork);
-	int resp_code;
+	struct vhost_virtqueue *ctl_vq, *vq;
+	int resp_code, i;
+
+	if (tmf->scsi_resp == TMR_FUNCTION_COMPLETE) {
+		/*
+		 * Flush IO vqs that don't share a worker with the ctl to make
+		 * sure they have sent their responses before us.
+		 */
+		ctl_vq = &tmf->vhost->vqs[VHOST_SCSI_VQ_CTL].vq;
+		for (i = VHOST_SCSI_VQ_IO; i < tmf->vhost->dev.nvqs; i++) {
+			vq = &tmf->vhost->vqs[i].vq;
+
+			if (vhost_vq_is_setup(vq) &&
+			    vq->worker != ctl_vq->worker) {
+				vhost_vq_flush(vq);
+			}
+		}
 
-	if (tmf->scsi_resp == TMR_FUNCTION_COMPLETE)
 		resp_code = VIRTIO_SCSI_S_FUNCTION_SUCCEEDED;
-	else
+	} else {
 		resp_code = VIRTIO_SCSI_S_FUNCTION_REJECTED;
+	}
 
 	vhost_scsi_send_tmf_resp(tmf->vhost, &tmf->svq->vq, tmf->in_iovs,
 				 tmf->vq_desc, &tmf->resp_iov, resp_code);
diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index f812daf25648..1fa5e9a49092 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -275,6 +275,12 @@ void vhost_dev_flush(struct vhost_dev *dev)
 }
 EXPORT_SYMBOL_GPL(vhost_dev_flush);
 
+void vhost_vq_flush(struct vhost_virtqueue *vq)
+{
+	vhost_work_flush_on(vq->worker);
+}
+EXPORT_SYMBOL_GPL(vhost_vq_flush);
+
 /* A lockless hint for busy polling code to exit the loop */
 bool vhost_vq_has_work(struct vhost_virtqueue *vq)
 {
diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
index ef55fae2517c..395707c680e5 100644
--- a/drivers/vhost/vhost.h
+++ b/drivers/vhost/vhost.h
@@ -53,6 +53,7 @@ int vhost_poll_start(struct vhost_poll *poll, struct file *file);
 void vhost_poll_stop(struct vhost_poll *poll);
 void vhost_poll_queue(struct vhost_poll *poll);
 void vhost_dev_flush(struct vhost_dev *dev);
+void vhost_vq_flush(struct vhost_virtqueue *vq);
 
 struct vhost_log {
 	u64 addr;
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
