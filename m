Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 197A8384233
	for <virtualization@lists.linux.dev>; Sat, 12 Sep 2026 08:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789203176; cv=none; b=AMkmq2Qfz7lGfrLL+TIN86De0F1aMsyZH6l9WIaAj/+yjW5gdKSgjDRfho/kIyxzkTY66Q5eKLik6E1tOL2HnUiDNaB/uRs3ViCLQjeBCq/b8DKzSGgjE/rPq7RgVVFXrFnkgjAyxflF+vaph9CG//XaIv5jAimu9d12ChVMVSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789203176; c=relaxed/simple;
	bh=dquZraZjSq1eNM+T01tcQIrz2JYvFIRH7UkrcXngR/g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=CCniLUq3Ku6yyTNEzL4MF2wPcElSWdbOhJsSroOORmtzSpyk5KBD2BHrZLKG9kwxvqp86cEkB8Anxmr1PJvvREYpRF3X8+P8WH/HO8bkWhvCPqRUtWrrjLNV7dK1GxpESUtGwMRLtVF55MuBJlCOGt+F09YlgQpaL1YPVbCrqik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cAAHydwN; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=OgXOGiUZ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cAAHydwN";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OgXOGiUZ"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68C85fCT2343712
	for <virtualization@lists.linux.dev>; Sat, 12 Sep 2026 08:52:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=JBHFKISvb5GpVQD3ZIst72
	axNU1WVodRSK6PtMFk5sM=; b=cAAHydwN5dNGUGUMFXpisq/Iq0RO/ru1PTNKhK
	zgjYiDXkNln1quw5I50Sb0gMm+HcficYy3izkgODOkw/NFQtwDGX1JXUJUIWz3Mo
	/Wtf23DYrFhkN87N6yvH+3JCLxQIBjEZ9NQTMydXhjCjkveTbXv7HxuUHO8YoIAQ
	zvuWkUX6hPc1M1/no8didy0oBYmUOSZZFBQZfU65re+5FtB1p3HSWXGcfy6rMANp
	ctPggWEuW9xwZ9MqREqofKCXa+zTGNYOXEYgadusZpCdb2iRvMfNBEklVP6pEqPq
	Gv9PKaEPu83VwK43p0Fce7HgvaylYYroKO7/TOuO5DLUwjxQ==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gmy9d8hh4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <virtualization@lists.linux.dev>; Sat, 12 Sep 2026 08:52:51 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cc1a439db36so1509530a12.2
        for <virtualization@lists.linux.dev>; Sat, 12 Sep 2026 01:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789203171; x=1789807971; darn=lists.linux.dev;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=JBHFKISvb5GpVQD3ZIst72axNU1WVodRSK6PtMFk5sM=;
        b=OgXOGiUZ0N2chVm1R8/RdrJyLa0trbycEfA/uN0cLeHgCPiur+YOlDKPJTvJ7FHSzv
         zo2wP0YToj8NzfUZpDk9yZzbe8+qYgByLid39vUdHnSfiBGypL2kLPQfnXfharA8mXmb
         IQvhX+dEI2ITF5ahqjrk6xaQkJV3eboRtTqVK9i3NpSxKkPk/Qw9sl02mzATpGxqoQOm
         E00G1K5f/QK14vpjV/fZYwtahnCCt9DrZ+zcySi9HU07bS0GviccHvq/vnP2dYr9uKyN
         LzTEN/aTrEjeF4Ibb2dpaW4kNx8yeTfXskzYBtMe1XNrj1q6YGaLn3vVtOcqn358d8Zm
         ZHWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789203171; x=1789807971;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=JBHFKISvb5GpVQD3ZIst72axNU1WVodRSK6PtMFk5sM=;
        b=XjM1YxmsE6ANS1x8KlH3LvwAieEcVs4waUuvpQu3EGxaVt1Ho1lZM+E+2vyT8dsXCs
         aSBMn5VVeBs/plC0TKGuW7aeLzmW/JNpBQboqrSaOsVeyQppNPAwH0qBtw+UBiwTyIEy
         hXFAa2033iWLUmAD2joG4lCoFSROvTGt44eeGdTY9qKJpjP+H2b32nQ7tLucn9ej9vH6
         MuQyMS7qfu8Hp1buhSKB39HsZWWbPEqu8XEdIaA8MYcq5K6wGmDn7+xFjlsvaUxgleba
         h2/WgeQZRQO5QxxNLk2RY/QZ+l88BrATCbiEDQtQZSshKpgJN6RHPDCYnkCFwzz41xwQ
         3nzQ==
X-Forwarded-Encrypted: i=1; AKwUvBwYuEIcoLOdshbQLLiRMo4f74QRGiVuRa6hrQ5ggs7wI/pk+S1aVLFHIP8vD7toh/FLGWubNn6gvRLppdTNDA==@lists.linux.dev
X-Gm-Message-State: AFuF++mZb08WDQKTnk2k3siUjl3Fny/SIagfiQyHKR9niiHlyH0/Gn++
	nLbGKMaVUXmLG3sFYH/ueLUzFYiOe/l34JkRNyruNhsM7CqeLrgLNkZGsnldnTpZ+koAsEwLr5/
	REFuCtfD9MXRJ9zruak4i4OaSTm2gBJ0ivJsWPfLMjGo9n9WukQ/FHQDgVpCv0dGXqH4ueQ==
X-Gm-Gg: AYBFou0g141YqxNnZQl0F3+cTdr506PvWJtQ75i0EhQYQnKLM7nrcuVM4gK3kj3Rhwk
	xvMhe6zpmKXCI06T643Mv1xMbi/Ofv0MXtgGjEyxVbiuSRA5LykOTy+v2WGaZDigEE7Wv1QrpeC
	33okwpDfQCsqjTCQAr/gF7qK91jfEQmXZZU3VAYA1BDx9lbYVCcZNlOqAWlsFJyFJpHz1jYphjS
	sOFUs8eNxcK3t90Dnx4391mVWi2cTe08hJp1RUQpOcJt3xUOQoSfXyfRZJeqjtTuMbxw2xhNafg
	k09r+2dkMNjAf8th2rS0zl45gQVZ2MkWsAcYn1u469DpD776du0uOHL4/3mz8ELy5xvM/VL/b1Y
	qKkc5pmUeXXGwxZv45ZRLtSrnX28/DLBPlMrDQy7EDNwBHRf9oVyJXMGUE/lh0j3jr0O39vLyuw
	==
X-Received: by 2002:a17:90a:da8f:b0:398:d6e8:f84e with SMTP id 98e67ed59e1d1-39d9bd6976amr12162618a91.9.1789203170754;
        Sat, 12 Sep 2026 01:52:50 -0700 (PDT)
X-Received: by 2002:a17:90a:da8f:b0:398:d6e8:f84e with SMTP id 98e67ed59e1d1-39d9bd6976amr12162576a91.9.1789203170296;
        Sat, 12 Sep 2026 01:52:50 -0700 (PDT)
Received: from congzhan02.ap.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39d9afa367bsm2721832a91.0.2026.09.12.01.52.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Sep 2026 01:52:49 -0700 (PDT)
From: Cong Zhang <cong.zhang@oss.qualcomm.com>
Date: Sat, 12 Sep 2026 16:52:44 +0800
Subject: [PATCH v2] virtio_blk: use synchronous quiesce in
 virtblk_freeze_priv()
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260912-virtblk_sync_quiesce-v2-1-09a001549b72@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIANsSpWoC/22Nyw6CMBREf8XctSW0PFJc+R+GEChFrgKVXmgkh
 H+3YNy5meQkM3NWIG1RE1xOK1jtkNAMHsT5BKoth7tmWHsGEYo0zHjIHNqp6p4FLYMqxtlvlWZ
 ZJZSUdZzEPAU/fVnd4Pu4veVfprl6aDXtX3ujRZqMXQ6v43vvp+D/FY4zzkopo0Y2EReJvBqiY
 JzLTpm+D3xAvm3bByMsulHRAAAA
X-Change-ID: 20260910-virtblk_sync_quiesce-9b2c88d45416
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>,
        =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Ming Lei <ming.lei@redhat.com>
Cc: linux-arm-msm@vger.kernel.org, virtualization@lists.linux.dev,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Cong Zhang <cong.zhang@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-38bf1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789203166; l=2165;
 i=cong.zhang@oss.qualcomm.com; s=20250926; h=from:subject:message-id;
 bh=dquZraZjSq1eNM+T01tcQIrz2JYvFIRH7UkrcXngR/g=;
 b=0Ru6H5o7DriZH6nGIn+WEPZQ8StS9Rizbxvz8EIwzzUUBVZ0EF77mcdQDEO7uy9EnjUAdZw7+
 t7tYlt2DxODCqquyJaKo7mzhK7StK0v9KpZ9C/U5sLB8hfQCB4cYQMQ
X-Developer-Key: i=cong.zhang@oss.qualcomm.com; a=ed25519;
 pk=8SBh3ey5igz2nlW+UFC6khFvaNPgG7MmbWtAeO2s6n8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEyMDEyNSBTYWx0ZWRfX4/jB8EwWU6Cl
 JAn0Ymr1XL+Gy8dpPK3J58emJvFthNtZYtbbvtoaH5VvU5bo9/VM9T++MoqvjqQh523vvBnksTC
 JgHgojMct/LKdXzT/8ZziNlEAJx7HO9rvfdmnvRQbNfd0O+UpjNsoAJn0MWcmbJsbYg6RXAk2Ww
 PH4wqQ1Y0wALsOd78C1WXV/zh8b/mR3ZuCy4ayDA6jbuzWIWaXgdGwUELr7O1SnuiVDBqvT73u4
 4bHIT/uKWpZuH7dg9GZwGeLMDIXNN9QIAdCa1ckTNEHBH7EPU55S7ZGs6TTQb4iGh2+IVea+Qk/
 xuyXlZwsWrjQDupNT8VQuUjujDAvpI8pMY7oaiVTgPjFYpBg0p4EDwGF++IbW//FA9G3OkjaJ9l
 +5fmXqsZ1kieOtV1oZ9DO54lllLA4PhfclyD7ps+CVsElRXcZheqprAOJsvALP9PndCUx/OmvAy
 NUUeTi+efdXzgBAqOSw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEyMDEyNSBTYWx0ZWRfX8/3ud1/c74vo
 YQY04nwx+lHaSof0xmomqwuXHfLC8jPoCn5ZGqRNKxgaBpQg219Zb8FShfyaX6vy7kiDE8drmEp
 WlQOspUiJz5Iw+qqTBIXOfj+6k48l3A=
X-Proofpoint-GUID: 6EHwSazp0pO0uL9YWzlnrxHGLtKmYwKC
X-Authority-Analysis: v=2.4 cv=OeUNnRTY c=1 sm=1 tr=0 ts=6aa512e3 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=roso6HiFfYj01OpyUwUA:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-ORIG-GUID: 6EHwSazp0pO0uL9YWzlnrxHGLtKmYwKC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-12_03,2026-09-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 bulkscore=0 spamscore=0
 priorityscore=1501 suspectscore=0 impostorscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609120125

Replace blk_mq_quiesce_queue_nowait() with blk_mq_quiesce_queue() in
virtblk_freeze_priv().

Keep the existing freeze and unfreeze order. The synchronous call waits
for dispatch code that was already running. The queue remains quiesced
until virtblk_restore_priv() calls blk_mq_unquiesce_queue().

Fixes: 7678abee0867 ("virtio-blk: don't keep queue frozen during system suspend")

Signed-off-by: Cong Zhang <cong.zhang@oss.qualcomm.com>
---
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
---
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

