Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B96CF2AEFB
	for <virtualization@lists.linux-foundation.org>; Wed,  9 Oct 2024 01:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728437932; cv=none; b=YR0WRKcp/98gty8H+0FSjjPepf1O08rB2dgKoN8IRiOkPPPA6tphYI57VQMEp2H/qWsRjlfPflErf4UE5GM7hQ4Ccdv1Zm29oYoPsaeFgWs0QGxPDNA1s8lKHvwu1l3Sz94nOJ71eDI8rVeaSmHOC6j73rmQd8CSy1NA6j/0LZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728437932; c=relaxed/simple;
	bh=JjfHsoNUktHGYsLxsRTZ/OwgUJbEOFgqUe+ajwelA8Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=reZivitODpJyrbnRXaZkBfGU+VvUqvybFKHC9yeRUt57FGGGYCQKmP5DzXuZKVpauLduTpEGge7Np4JWYmDM2Eh/crOtP7j4OY+fz4C7bH/p9eh/gJJlCMicqd1w3sDZ2uyWcy/uw6AUfmeJb+6VOk0nd0cvfsvI5cnrplP8+tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=LMz5qvCU; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LMz5qvCU"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 606C881191
	for <virtualization@lists.linux-foundation.org>; Wed,  9 Oct 2024 01:38:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -6.49
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NqK2NjAZ5BKq for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Oct 2024 01:38:50 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.177.32; helo=mx0b-00069f02.pphosted.com; envelope-from=michael.christie@oracle.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 7825A8118D
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7825A8118D
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2023-11-20 header.b=LMz5qvCU
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 7825A8118D
	for <virtualization@lists.linux-foundation.org>; Wed,  9 Oct 2024 01:38:50 +0000 (UTC)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 498JtYr8012571;
	Wed, 9 Oct 2024 01:38:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2023-11-20; bh=GzDNl
	KtRxMcwGAkkQ4Gp3Z4hYhT2TW59SE5o5zu5oC4=; b=LMz5qvCUGWjiy2i2paLgR
	3Ern4YlBpK1ihdTFycdfffNfSekajRrNWpZUSezlNsL3s+B9p6nRRRRwI9XAxExW
	JLBy4y1L4IYBqPliH+Yo+ZrjO7PfAzkIqL07FSZL51FseKljBZ3W7nX13Z2ZtbCE
	UkqSbEKD4UDw2Uc12QidyuP05P/vweRSi8qiqiDj2B2qtDu8Nwjye9LL0iN+VHBE
	zkL7gu19Et51rNNBcV/pPO+hc4DQM+hZe4Up5DU3kqqKq7h9qCSFCdOEOYljT56Y
	rOObn0BZIJ6srN/7JzH/DZrCrN4XbQYbAhvVmzRaLjnPz7gt4XJO8uPs2/fCCB5m
	A==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42300dy70u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 09 Oct 2024 01:38:48 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 498NNaPp011881;
	Wed, 9 Oct 2024 01:38:48 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 422uwe899p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 09 Oct 2024 01:38:48 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4991chjA024787;
	Wed, 9 Oct 2024 01:38:47 GMT
Received: from mnc-mac.us.oracle.com (dhcp-10-65-182-164.vpn.oracle.com [10.65.182.164])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 422uwe897c-3;
	Wed, 09 Oct 2024 01:38:47 +0000
From: Mike Christie <michael.christie@oracle.com>
To: stefanha@redhat.com, jasowang@redhat.com, mst@redhat.com,
        sgarzare@redhat.com, pbonzini@redhat.com, target-devel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Cc: Mike Christie <michael.christie@oracle.com>
Subject: [PATCH 3/8] vhost-scsi: Add better resource allocation failure handling
Date: Tue,  8 Oct 2024 20:38:33 -0500
Message-ID: <20241009013839.88593-3-michael.christie@oracle.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20241009013839.88593-1-michael.christie@oracle.com>
References: <20241009013839.88593-1-michael.christie@oracle.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-08_24,2024-10-08_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 spamscore=0 adultscore=0 phishscore=0 suspectscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410090009
X-Proofpoint-GUID: O-muYBagzuxjeqfaJBuR9BfoX44s-dwh
X-Proofpoint-ORIG-GUID: O-muYBagzuxjeqfaJBuR9BfoX44s-dwh

If we can't allocate mem to map in data for a request or can't find
a tag for a command, we currently drop the command. This leads to the
error handler running to clean it up. Instead of dropping the command
this has us return an error telling the initiator that it queued more
commands than we can handle. The initiator will then reduce how many
commands it will send us and retry later.

Signed-off-by: Mike Christie <michael.christie@oracle.com>
---
 drivers/vhost/scsi.c | 28 +++++++++++++++++++++++++---
 1 file changed, 25 insertions(+), 3 deletions(-)

diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
index 776051577a5f..415fd3be17b9 100644
--- a/drivers/vhost/scsi.c
+++ b/drivers/vhost/scsi.c
@@ -629,7 +629,7 @@ vhost_scsi_get_cmd(struct vhost_virtqueue *vq, struct vhost_scsi_tpg *tpg,
 
 	tag = sbitmap_get(&svq->scsi_tags);
 	if (tag < 0) {
-		pr_err("Unable to obtain tag for vhost_scsi_cmd\n");
+		pr_warn_once("Guest sent too many cmds. Returning TASK_SET_FULL.\n");
 		return ERR_PTR(-ENOMEM);
 	}
 
@@ -928,6 +928,24 @@ static void vhost_scsi_target_queue_cmd(struct vhost_scsi_cmd *cmd)
 	target_submit(se_cmd);
 }
 
+static void
+vhost_scsi_send_status(struct vhost_scsi *vs, struct vhost_virtqueue *vq,
+		       int head, unsigned int out, u8 status)
+{
+	struct virtio_scsi_cmd_resp __user *resp;
+	struct virtio_scsi_cmd_resp rsp;
+	int ret;
+
+	memset(&rsp, 0, sizeof(rsp));
+	rsp.status = status;
+	resp = vq->iov[out].iov_base;
+	ret = __copy_to_user(resp, &rsp, sizeof(rsp));
+	if (!ret)
+		vhost_add_used_and_signal(&vs->dev, vq, head, 0);
+	else
+		pr_err("Faulted on virtio_scsi_cmd_resp\n");
+}
+
 static void
 vhost_scsi_send_bad_target(struct vhost_scsi *vs,
 			   struct vhost_virtqueue *vq,
@@ -1212,8 +1230,8 @@ vhost_scsi_handle_vq(struct vhost_scsi *vs, struct vhost_virtqueue *vq)
 					 exp_data_len + prot_bytes,
 					 data_direction);
 		if (IS_ERR(cmd)) {
-			vq_err(vq, "vhost_scsi_get_cmd failed %ld\n",
-			       PTR_ERR(cmd));
+			ret = PTR_ERR(cmd);
+			vq_err(vq, "vhost_scsi_get_tag failed %dd\n", ret);
 			goto err;
 		}
 		cmd->tvc_vhost = vs;
@@ -1250,11 +1268,15 @@ vhost_scsi_handle_vq(struct vhost_scsi *vs, struct vhost_virtqueue *vq)
 		 * EINVAL: Invalid response buffer, drop the request
 		 * EIO:    Respond with bad target
 		 * EAGAIN: Pending request
+		 * ENOMEM: Could not allocate resources for request
 		 */
 		if (ret == -ENXIO)
 			break;
 		else if (ret == -EIO)
 			vhost_scsi_send_bad_target(vs, vq, vc.head, vc.out);
+		else if (ret == -ENOMEM)
+			vhost_scsi_send_status(vs, vq, vc.head, vc.out,
+					       SAM_STAT_TASK_SET_FULL);
 	} while (likely(!vhost_exceeds_weight(vq, ++c, 0)));
 out:
 	mutex_unlock(&vq->mutex);
-- 
2.34.1

