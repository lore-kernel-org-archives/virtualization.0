Return-Path: <SRS0=dwtO=HI=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 272BAC433E0
	for <virtualization@archiver.kernel.org>; Sat,  6 Feb 2021 13:17:42 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F95764EBC
	for <virtualization@archiver.kernel.org>; Sat,  6 Feb 2021 13:17:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F95764EBC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 5D12B862FC;
	Sat,  6 Feb 2021 13:17:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id joTFvS7jaOiQ; Sat,  6 Feb 2021 13:17:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 1175386302;
	Sat,  6 Feb 2021 13:17:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CBBC8C08A1;
	Sat,  6 Feb 2021 13:17:36 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C8017C013A
 for <virtualization@lists.linux-foundation.org>;
 Sat,  6 Feb 2021 13:17:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id B7181872FA
 for <virtualization@lists.linux-foundation.org>;
 Sat,  6 Feb 2021 13:17:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ToXfUANuRv+B
 for <virtualization@lists.linux-foundation.org>;
 Sat,  6 Feb 2021 13:17:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from userp2130.oracle.com (userp2130.oracle.com [156.151.31.86])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 60A6F872E1
 for <virtualization@lists.linux-foundation.org>;
 Sat,  6 Feb 2021 13:17:14 +0000 (UTC)
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 116DAA7b058414;
 Sat, 6 Feb 2021 13:17:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=mime-version :
 message-id : date : from : to : cc : subject : references : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=iBieoUlmovjvu5MaIJ9cX8BhQE205Z9HXYbmJPk/bDk=;
 b=qS/UJStC/nkTVP/7CzekK8ci4FqXC+RyAqJRpDbmo9Xv+t4hMztZTr4iUy6llQ/LjW9M
 3NH+O+TFJQdKARJ6YpvnKfGpLxl3mv+4Fo4HiXkvJXarBX+0OEROCCuEvaglUbQFROvu
 oWuXhPwM1rKlnyYK1nytJ8fqOfa5uYr0Y2oIBJ1mYBaZgwZUtIBumykl7xdYBpU9CNFA
 JLgEh8n/cbGYPIjPDOqJUUrykouJUMGff33r1svR6q0H05AYdc+d9TTPYgv0G3hKOfSg
 VXBaHNKK2uqQg61uC3MKrifipl87bsThi52vgkphIn4rBJ1bQrWnb5T2kqjVLP7rVisk jQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by userp2130.oracle.com with ESMTP id 36hjhqgn9f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 06 Feb 2021 13:17:12 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 116DARWr028459;
 Sat, 6 Feb 2021 13:17:09 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by userp3020.oracle.com with ESMTP id 36hjeh3f5y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 06 Feb 2021 13:17:09 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 116DH89E018854;
 Sat, 6 Feb 2021 13:17:08 GMT
Received: from ban25x6uut24.us.oracle.com (/10.153.73.24) by default (Oracle
 Beehive Gateway v4.0) with ESMTP ; Sat, 06 Feb 2021 05:16:17 -0800
MIME-Version: 1.0
Message-ID: <1612614564-4220-3-git-send-email-si-wei.liu@oracle.com>
Date: Sat, 6 Feb 2021 04:29:24 -0800 (PST)
From: Si-Wei Liu <si-wei.liu@oracle.com>
To: mst@redhat.com, jasowang@redhat.com, elic@nvidia.com
Subject: [PATCH 3/3] mlx5_vdpa: defer clear_virtqueues to until DRIVER_OK
References: <1612614564-4220-1-git-send-email-si-wei.liu@oracle.com>
In-Reply-To: <1612614564-4220-1-git-send-email-si-wei.liu@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-IMR: 1
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9886
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 suspectscore=0
 adultscore=0 phishscore=0 bulkscore=0 mlxlogscore=999 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102060093
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9886
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 impostorscore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 mlxscore=0 phishscore=0
 lowpriorityscore=0 mlxlogscore=999 clxscore=1015 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102060093
Cc: si-wei.liu@oracle.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org
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

While virtq is stopped,  get_vq_state() is supposed to
be  called to  get  sync'ed  with  the latest internal
avail_index from device. The saved avail_index is used
to restate  the virtq  once device is started.  Commit
b35ccebe3ef7 introduced the clear_virtqueues() routine
to  reset  the saved  avail_index,  however, the index
gets cleared a bit earlier before get_vq_state() tries
to read it. This would cause consistency problems when
virtq is restarted, e.g. through a series of link down
and link up events. We  could  defer  the  clearing of
avail_index  to  until  the  device  is to be started,
i.e. until  VIRTIO_CONFIG_S_DRIVER_OK  is set again in
set_status().

Fixes: b35ccebe3ef7 ("vdpa/mlx5: Restore the hardware used index after change map")
Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
---
 drivers/vdpa/mlx5/net/mlx5_vnet.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index aa6f8cd..444ab58 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -1785,7 +1785,6 @@ static void mlx5_vdpa_set_status(struct vdpa_device *vdev, u8 status)
 	if (!status) {
 		mlx5_vdpa_info(mvdev, "performing device reset\n");
 		teardown_driver(ndev);
-		clear_virtqueues(ndev);
 		mlx5_vdpa_destroy_mr(&ndev->mvdev);
 		ndev->mvdev.status = 0;
 		++mvdev->generation;
@@ -1794,6 +1793,7 @@ static void mlx5_vdpa_set_status(struct vdpa_device *vdev, u8 status)
 
 	if ((status ^ ndev->mvdev.status) & VIRTIO_CONFIG_S_DRIVER_OK) {
 		if (status & VIRTIO_CONFIG_S_DRIVER_OK) {
+			clear_virtqueues(ndev);
 			err = setup_driver(ndev);
 			if (err) {
 				mlx5_vdpa_warn(mvdev, "failed to setup driver\n");
-- 
1.8.3.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
