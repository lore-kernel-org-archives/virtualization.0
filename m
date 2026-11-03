Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793701959;
	b=4pmu+nePWaCQY5fMdiaBpGHjUpsUUtBdOnH8AsLoiUaMGfCC7iPp3aoohAgBT5u9ojT+
	 Y7NEfoqrwWPtda6fkKQVnyTAav1yeeppt683NxS+8xNeXA0uf68c+hEIOp/ygfZu5b+5i
	 ODYNaKwA0LTkpihXg9/+QGmqVjYkF08vOipoMi9h6/HPQjfhaF9z1NVNB5OFLfuCnzFzn
	 shznNEhBUkj16Sveqi/VwaBXoaBe3+gtOAgVvjJkfyPoSe8nROHfYP60gf7ANlp4jpNYv
	 U5MkpAjnCTLSyev2E4u/p7ctJ+dQ8NL0nlrFdGr9ExWK14KPnhG+vszxCCkXgS5ijyA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793701959;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=9OTHugQliWNMFHV9r9MfN3kHQpTez4X3FtLgUfekNy4=;
	b=FQSP/2tJINE0XEsEAU2QI2oJdqplqh5u/xjdLxGkM+fu1m28EVXyhA3SeQqibI6TfeGh
	 YxRJPdkSpD+ljfwon5oBMydqWnuwRFtJvEKvBWpYIyZtXFuus9ZGIEtznIQnirwbWvMF5
	 O3anPddo33uc1yY/MzqHiqYIc4wubPkg/vkLp2/qx18lsiMkKTOxgXrdgg6GHZ7ogFdp5
	 a4hPMnO5/C843MH/Szk8VCFBnjaQV6caOBpqHgvcbd22KLEsTph0fb3YVvG2yeKSczTBg
	 myJILHVaWzfXWFsVtA1uzcDmaU0Ie85xHcn0+E56kwP+aE7cDM3ahcTfCN0IXzXBv7g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b="oUoSKOU/";
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=TGHbhfKR;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6DC0606A823
	for <virtualization@lists.linux.dev>; Tue,  3 Nov 2026 10:32:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A6DC0606A823
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=oUoSKOU/;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=TGHbhfKR
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A3AASO31594036
	for <virtualization@lists.linux.dev>; Tue, 3 Nov 2026 10:32:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=9OTHugQliWNMFHV9r9MfN3
	kHQpTez4X3FtLgUfekNy4=; b=oUoSKOU/WSY8TyBJ7fYAgtZ2ukVbmoEFhacU/E
	pFUbBsoA0DUyxE2U7gz6X9Uz/XUlt3MtOEIN5Z5KZWYjWq+FCNx94Lt5JwbFqFDf
	+vpHiQ+FtlrT4kBi52kyFiIx/IHtXXuquhpalp5tzk55E0J22GMxhYQbNMeC//Uq
	F47yyh2MQrOv92J+g0PrwkbXwbBVDAu8qR0cpJaZG7va3P3jqDL/M8QJ857S4foS
	6Lnzkbf5iAAfgtfv9GKxKFyC/+FKvSDp3Adk/qg6A21MGXyA7ka+a/aeyrNzcLq2
	xQRuDDSs8dZUxLdcOwEVCGmsPGxPMEkLLreWgkMQ/dNCcOBA==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hq081u9jb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <virtualization@lists.linux.dev>; Tue, 03 Nov 2026 10:32:37 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cc1cdfb337eso2353969a12.0
        for <virtualization@lists.linux.dev>; Tue, 03 Nov 2026 02:32:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793701957; x=1794306757; darn=lists.linux.dev;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=9OTHugQliWNMFHV9r9MfN3kHQpTez4X3FtLgUfekNy4=;
        b=TGHbhfKRh3P2/AmOmPrQ32urw0Y/7Su/jUvtKvZ9xF/RESrJqRjSXW0FVuNYeLRJhG
         zVKuQyAKjgGd5TqdGrPrRUUB+zYaeY0VKWXY2JzWu645JkESJgGr5v7yJWVZMh8EcuCZ
         Bjm4sBCLX4Ve/EE1ocuvfa1odnRN7a/JQGM2duLVJSgN48FBjGfdyXGA6leegCRZmAyi
         d51bsIVhBFeWWyQJIrQ7c30/rPr5VxglV5gpe8jP12r+9Ni3L3YC7qmZe6KBrueqp91P
         PTUA8QknQy+Af4t8nd51/C/rCn4f/UWyeKZEaD6yccyrIbc/XeyJKlp7w2D0YCkqkXjz
         dZqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793701957; x=1794306757;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=9OTHugQliWNMFHV9r9MfN3kHQpTez4X3FtLgUfekNy4=;
        b=yFYTkIXYSx5BTyr6Mt0Ea/Hs1JniPNoUJ/+feO9OlkYMM0XBHE5DAuSf2iMO64MOLf
         eDWCKQB7hCyf7p+tvLO+eIPyc9Mr4+yKKRILLo6xfd5HQqwABjo6T7nWhSBBf4h7MyBX
         GkYD6JH/PWCxGlMH5/i5vZXp0gSyg8kjuZWPq9l8A9D07IPB6Pg0mGB4lVIUo2POPDXV
         Z9jbqSyJaWqMuinLQEUiuFHULCK1VZe3MIj2GXCzpOB2kEk3EeiD2jQrCP2zFo7ELzSr
         2Og2GMA+eDpcO1R1791T35eJY5jRiohsWcs0yRJSOC94jvcBFJLu1g8OJ+SMLBPfXMvK
         ueYg==
X-Forwarded-Encrypted: i=1; AKwUvBzb5u4Ey99lw9z8lL47YOW5fiLsb4LqtTDSjMQaEaKzl2mpbqRtSegGlvsjFbyfOoadmMqcVNP2sZVPl3pHmw==@lists.linux.dev
X-Gm-Message-State: APuU4Z/itsAo0wxIr6HNfIFRF5GQb+3GkMX7lxDttHFK/u6nJiZvIqNq
	ztWjB0cdcxP1lKC+Eq8w6gFrZZJoPUl+K+905FxLVwJjgg71vZe5hy4Afg1KkgC7UVQlx97/yha
	f+7ZbKn+F0h1OdDS8qLJnxYMfLQJfwvjsv+aOCkMXqOuD+5I6U2Aed+KIzuJ5uBa3vFJ0Q88LO7
	t2tA==
X-Gm-Gg: AYBFou3A7xcU9hFF93tVm1jBJJdOvColvrQItbziNf9viwQxkHfGimHKW7IOyeKjQYK
	bN2G8F8sZttQxnWA4Mu6Stch/M3iXoohcEbwqHgtYhKJg1QASWSNlD72vZ6nz3Bv5MSU31ePwoX
	nhaKhgMhvrNCipNCbcm2OpkOPoU/8/lclupnKeLOdr3MzkdEC6/gjIxCjrA+WuFDcq4PsL96Cki
	mDaJagpRO48c8XAOldplTRyujL7bVZvVUhTB5znewFoyGx3n7hxl6Xxn97c35AVaLSpNEWYZAkq
	P5y8bbRZ8VKS/sXz/4s4jwqptaYN9edIEsUX4q9wQz0Niwrd7Rbe1OkIkgI+mX8YAiJwTq1KPCW
	Dcn6liNjhxjtW3VfJzDD4myY0UnkRaJP/yn8yGclnS4jQhMyrkLXV5Z9x4fOz5GuiGiZaeJnDIK
	kD
X-Received: by 2002:a17:90b:2e4f:b0:3ac:8897:7bab with SMTP id 98e67ed59e1d1-3ae89536bffmr9604445a91.6.1793701957168;
        Tue, 03 Nov 2026 02:32:37 -0800 (PST)
X-Received: by 2002:a17:90b:2e4f:b0:3ac:8897:7bab with SMTP id 98e67ed59e1d1-3ae89536bffmr9604430a91.6.1793701956680;
        Tue, 03 Nov 2026 02:32:36 -0800 (PST)
Received: from congzhan02.ap.qualcomm.com ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b07c8329afsm3740814a91.8.2026.11.03.02.32.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 02:32:36 -0800 (PST)
From: Cong Zhang <cong.zhang@oss.qualcomm.com>
Date: Tue, 03 Nov 2026 18:32:21 +0800
Subject: [PATCH RESEND v3] virtio_blk: use synchronous quiesce in
 virtblk_freeze_priv()
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261103-virtblk_sync_quiesce-v3-1-f40233f9bdd9@oss.qualcomm.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>,
        Eugenio Perez <eperezma@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Ming Lei <ming.lei@redhat.com>
Cc: linux-arm-msm@vger.kernel.org, virtualization@lists.linux.dev,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Cong Zhang <cong.zhang@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-38bf1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793701952; l=2531;
 i=cong.zhang@oss.qualcomm.com; s=20250926; h=from:subject:message-id;
 bh=GA7vQS8Tiz0/LgX66p7Nd9+W/EfJ3aiCYcUb5tpLGpQ=;
 b=LbXB6Q5QCzunltowh2X7OUgrJOoa7ZCDRcYJximUm767xh12vRbVj9yQba6diwAiYryTaRG+W
 eTQIzHhKcO8DAINJrvgq0uE8bVDzdsSuasQJVRd2EDSj9cg1dYIik2U
X-Developer-Key: i=cong.zhang@oss.qualcomm.com; a=ed25519;
 pk=8SBh3ey5igz2nlW+UFC6khFvaNPgG7MmbWtAeO2s6n8=
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAzMDA0MSBTYWx0ZWRfX6OibPrXJbSLd
 imriBXNl8lNFd++rrmo1OJPDQ27zZ8FyMEvmMmoDYzfrToNJNndHmy53KRCJcvydIHCpXPkk+VC
 EOHJi9dkEI0J1LOol2dG6esE1w0eNUY=
X-Proofpoint-ORIG-GUID: XQ78_wXKKqZxNCWInQ13YDzJW0jXD31T
X-Authority-Analysis: v=2.4 cv=F73C5ahN c=1 sm=1 tr=0 ts=6ae9b845 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=20KFwNOVAAAA:8
 a=kkXLOB11zRU5SlhL2XgA:9 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-GUID: XQ78_wXKKqZxNCWInQ13YDzJW0jXD31T
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAzMDA0MSBTYWx0ZWRfX77GShMhRzP1E
 pCq1Il7CmIM6xNAcr5PzOX7n+mwdjZvzueMhPx+gHwcPhe8BAbf+nXznsr5gDcHWpCamhDw/4wt
 Es+0bq2VRSX4/KYLSiuK+M+6KR2tS2h3Sgmtd+K7ERJUjEoAzXRz7rsyD1leJM4BlFnl+8rYn1J
 Av0fE82RvUFzUgFF+q1ybA6JYA7L+k5kCQ5mUHbRFCuzJo695n1V3go9m8LnokwYy9fbRbiOa4W
 f6y+gJMzgGgAnwaYX4WxIzSYuaMXyNFcjelMA4Q35w0+pxJXo8dO0uhQpnE04wVYv1lYOKub6Jm
 h493GbK7xGOFlFbyZFNeJ9CmSK6GPLvq6altVoXso9tlhTJr+BnHxkcUOMlfpRMdhgsOeQ6oCfv
 VXRSVBKWPIvRvClH3C0J1Qxb7eiA5ZT2+1de8xRE3eV2N74GkkK0a+vZGOyFGM4V850AWkANFPr
 d6HEc8dPnqTqyjxLJMg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-03_02,2026-11-02_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0
 clxscore=1015 impostorscore=0 adultscore=0 suspectscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611030041

blk_mq_run_work_fn() can call blk_mq_sched_dispatch_requests() through
blk_mq_run_dispatch_ops(). The dispatcher checks QUEUE_FLAG_QUIESCED
while the flag is clear. It can then be preempted before it gets a
request. At that time, it has no queue usage reference, so
blk_mq_freeze_queue() does not wait for it.

virtblk_freeze_priv() then calls blk_mq_quiesce_queue_nowait() and
blk_mq_unfreeze_queue(). A new request can enter the queue. The old
dispatcher can run again, use its old flag check, get the new request,
and call virtio_queue_rq(). At the same time, virtblk_freeze_priv() can
reset the device, delete the virtqueues, and free vblk->vqs. The old
dispatcher can then use a deleted virtqueue or a NULL vblk->vqs, and the
kernel can crash.

Fix this by using blk_mq_quiesce_queue(), which waits for dispatch code
that was already running. Keep the existing freeze and unfreeze order.
The queue remains quiesced until virtblk_restore_priv() calls
blk_mq_unquiesce_queue().

Fixes: 7678abee0867 ("virtio-blk: don't keep queue frozen during system suspend")
Cc: stable@vger.kernel.org
Acked-by: Jason Wang <jasowangio@gmail.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Cong Zhang <cong.zhang@oss.qualcomm.com>
---
Changes in v3:
- Move the race description into the commit log.
- Remove the blank line between tags.
- Add Cc: stable@vger.kernel.org to the commit trailers.
- Link to v2: https://lore.kernel.org/20260912-virtblk_sync_quiesce-v2-1-09a001549b72@oss.qualcomm.com

Changes in v2:
- Cc stable@vger.kernel.org.
- Link to v1: https://lore.kernel.org/20260911-virtblk_sync_quiesce-v1-1-a883f8f31258@oss.qualcomm.com
---
 drivers/block/virtio_blk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 32bf3ba07a9d..7a570591e040 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -1595,7 +1595,7 @@ static int virtblk_freeze_priv(struct virtio_device *vdev)
 
 	/* Ensure no requests in virtqueues before deleting vqs. */
 	memflags = blk_mq_freeze_queue(q);
-	blk_mq_quiesce_queue_nowait(q);
+	blk_mq_quiesce_queue(q);
 	blk_mq_unfreeze_queue(q, memflags);
 
 	/* Ensure we don't receive any more interrupts */

---
base-commit: 50d05c7c76c96b90462f24debacca971d2e86713
change-id: 20260910-virtblk_sync_quiesce-9b2c88d45416

Best regards,
--
Cong Zhang <cong.zhang@oss.qualcomm.com>
-- 
Cong Zhang <cong.zhang@oss.qualcomm.com>

