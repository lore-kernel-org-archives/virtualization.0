Return-Path: <SRS0=7x/u=EF=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9522C4363A
	for <virtualization@archiver.kernel.org>; Fri, 30 Oct 2020 11:48:36 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E73E920825
	for <virtualization@archiver.kernel.org>; Fri, 30 Oct 2020 11:48:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hmUIwi+/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E73E920825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 2F7E886303;
	Fri, 30 Oct 2020 11:48:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Zm_52iglE_yc; Fri, 30 Oct 2020 11:48:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id C32DC863FF;
	Fri, 30 Oct 2020 11:48:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id ADE25C0859;
	Fri, 30 Oct 2020 11:48:30 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E3C07C0051
 for <virtualization@lists.linux-foundation.org>;
 Fri, 30 Oct 2020 11:48:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id D359F863FF
 for <virtualization@lists.linux-foundation.org>;
 Fri, 30 Oct 2020 11:48:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id j-OlGO6QzH4Y
 for <virtualization@lists.linux-foundation.org>;
 Fri, 30 Oct 2020 11:48:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from aserp2120.oracle.com (aserp2120.oracle.com [141.146.126.78])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 4D1DF86303
 for <virtualization@lists.linux-foundation.org>;
 Fri, 30 Oct 2020 11:48:29 +0000 (UTC)
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09UBjBtS068968;
 Fri, 30 Oct 2020 11:48:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=u8OK6JTwAscu54Un4Xn+CHsR2kUdCYEM2EQPwUmKxRk=;
 b=hmUIwi+/SgAeglz3QH998o7cRxvHLF+OAEXoRHRIt+EKjWGGAX7lzXQ3htM4sf6qP+7y
 OgfPYnWxONAeh5QZ8kRx/GOVl22NTpBTpwzYBvN3co6AC5gbpZzCMraHA9YktLlPD8IU
 CoKBTzuildrRREwy+h0pa3IFBJZIm+99TKLjBEnTgcsrp0jw/7jSQ7H7Urcbh8l94T8k
 sJXXLqcEmXpiFCO97Ztv6ccuw4i6svpq3D3z1sd/bBzK+4EkFHk11NC5bhMIqnvviN3m
 wa+h66jS4RLOOeYh6vINZAnkAAIy13IFlkztZvjtF3g7Mg1ZTzkPISU683+JuTT2el3w Bw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by aserp2120.oracle.com with ESMTP id 34cc7m9a7q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 30 Oct 2020 11:48:19 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09UBjWSS008946;
 Fri, 30 Oct 2020 11:48:18 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by userp3030.oracle.com with ESMTP id 34cx70m29d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 30 Oct 2020 11:48:18 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 09UBmF2r023127;
 Fri, 30 Oct 2020 11:48:15 GMT
Received: from mwanda (/41.57.98.10) by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Fri, 30 Oct 2020 04:48:15 -0700
Date: Fri, 30 Oct 2020 14:48:08 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: David Airlie <airlied@linux.ie>, Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH] drm/virtio: Fix a double free in virtio_gpu_cmd_map()
Message-ID: <20201030114808.GD3251003@mwanda>
MIME-Version: 1.0
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9789
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 phishscore=0 spamscore=0
 bulkscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0 suspectscore=2
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010300091
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9789
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 adultscore=0
 malwarescore=0 spamscore=0 clxscore=1011 mlxscore=0 suspectscore=2
 priorityscore=1501 impostorscore=0 bulkscore=0 phishscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010300091
Cc: Tomeu Vizoso <tomeu.vizoso@collabora.com>, kernel-janitors@vger.kernel.org,
 dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org,
 Daniel Vetter <daniel@ffwll.ch>, Gurchetan Singh <gurchetansingh@chromium.org>
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

This is freed both here and in the caller (virtio_gpu_vram_map()) so
it's a double free.  The correct place is only in the caller.

Fixes: 16845c5d5409 ("drm/virtio: implement blob resources: implement vram object")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/gpu/drm/virtio/virtgpu_vq.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio/virtgpu_vq.c
index 72586cd8cc4c..3f200306c9d7 100644
--- a/drivers/gpu/drm/virtio/virtgpu_vq.c
+++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
@@ -1212,10 +1212,8 @@ int virtio_gpu_cmd_map(struct virtio_gpu_device *vgdev,
 	struct virtio_gpu_resp_map_info *resp_buf;
 
 	resp_buf = kzalloc(sizeof(*resp_buf), GFP_KERNEL);
-	if (!resp_buf) {
-		virtio_gpu_array_put_free(objs);
+	if (!resp_buf)
 		return -ENOMEM;
-	}
 
 	cmd_p = virtio_gpu_alloc_cmd_resp
 		(vgdev, virtio_gpu_cmd_resource_map_cb, &vbuf, sizeof(*cmd_p),
-- 
2.28.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
