Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2BC6381E85
	for <virtualization@lists.linux.dev>; Thu, 10 Sep 2026 16:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789057872; cv=none; b=kNmnR5AoO5q89DJw0ModJd29lffdYmZvH6ssy0FvJ+c5BXpcXJGJSB9GG6PBwaYmASSxPxWdhl5ACoG55ZfcKIa+ThkRFaOHecQDOqn4S2YwLdmC0Mc4XUgSD8MkQjABCiMRr4UZPGes1sLF6VzxnwJ3ozwc+ExpxLHBfQQMWAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789057872; c=relaxed/simple;
	bh=kcJgGBv43uV4lQuuDHe4VjFldBPqvQ8pUtSwWNQ1PIE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=t2IJeHrt5Ovi/+DIbrJoLiQ1GYRdWg1FnWYOraiA8CZtjUUxPHEipelsxGJTHfBglzHca3iwlNSQ9DqRjwLECTyRh8SxwVlpbVI02uz6q1KiRiIzxMMxhVogZqkgNlDLwy+cO5eDHr/AzwY55J8H/MTDvyhtc0ZlA8b8IQm4Uho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=k46jxYaJ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PcwGRYvL; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="k46jxYaJ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PcwGRYvL"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68AF4IHP1326170
	for <virtualization@lists.linux.dev>; Thu, 10 Sep 2026 16:31:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=m7yzWTdFaMYpCscxPwImij
	Ly8JVKI4jHgQ7Y/ei13oU=; b=k46jxYaJTuZcphY9IGriGaTx8KR/eHKegwy7iF
	mT3YB1cvTGLVdkkeJ5pk+eNt0AJhUzGvnklQlbKL8d9m3JJt4azqWnBN3SZd71j6
	tyqfPd+Kvh4tz3X+3tB+vpMKnq3+5YqNhwMiDTOQt9m7Z+BCdJbEaB/z/6I0+9FX
	fGCPs7h9qfaJWEZ9NO/daV7x9IqUSEGRLP9rkrFxfr9E+TbJwaXxG72c8+KhfI1P
	b9CDepIUA0arxpn62PiV8OPdbzSJMfvKGuaz0WLa+T7Xjx2Rx6Ve57MZQJMwfd58
	cN3g3qfJY5QKbv8L6co1n6IdAO8Q1U7QCppRIznbQa+7Rfqg==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gkwts0vdg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <virtualization@lists.linux.dev>; Thu, 10 Sep 2026 16:31:09 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-38f57e31b6eso4431029a91.1
        for <virtualization@lists.linux.dev>; Thu, 10 Sep 2026 09:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789057869; x=1789662669; darn=lists.linux.dev;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=m7yzWTdFaMYpCscxPwImijLy8JVKI4jHgQ7Y/ei13oU=;
        b=PcwGRYvLLTFg5xq4OtaiSymJPqd+gjVufuzCnMkzUlWxgM2C6p3rMGQz/8vbAdtLlD
         1PdS7vxMv+/G9lQYJacUrgk5aankP7KssEgeaW+AvvycPxxT2oE2OrhNt3ZOVC6gKByB
         WUWQ9Mj9kuRnpty59cldPO0jFxknG0hedIyoji/Q/uF4SjBZHX0N17SdCXjD3bIaAkxi
         7v8zQVjF8Ev2Ow86i+PCRfWBUSFCzKQ4/Q1lP4+RABOotzMenr3yFCwjYjeaP1vmUsB4
         etrbz3l3El987V0Q58h9KmneBuTQSzYzjZyEhXW8vm11iWdh4I2ZO2He81blWsjN2xE/
         16Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789057869; x=1789662669;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=m7yzWTdFaMYpCscxPwImijLy8JVKI4jHgQ7Y/ei13oU=;
        b=O1Bit/dgmhOhOtN9DgjhajSHsQyBsPF0GKUOu6OvIPgSC3oNJ01cF7ZGSbhgTVHXqm
         up+Y2TTdIrpcCjbj9C25rqFsRkBFHW2QMWNCOsOncdkH2jmg9N2bpc7N6gJ8femMqEtv
         M/90mvZFFbaARVy46D+3iPhjRzL45NGZpgMgYM/FA/thsoO/zd5oEiMV/U68r1S5F8Tc
         tBkl3ejagArf1fLc1tHh6qCI4jtng1kSvh0rjx+cyLtD/kfgH4fLFt4GlTxLcowzrsoh
         n8LiEDOEAjs2S194OpvPnXuEvKI8vdvNcBBXYctlfUH7ZL4hITHEMBY6irQosJbOwQX1
         Iuig==
X-Forwarded-Encrypted: i=1; AKwUvBzS96uIWUTatiNXRIEsyjGciusjmVkf4NL+4VyO9TA+XfEmhUbeHZ3LHwJyuvttM7MwQYGy0cV8iKFHI4JNag==@lists.linux.dev
X-Gm-Message-State: AFuF++nMku+klgQigKuRjI1wE6DusR07N0M0Vj860feLZscJJ3ACkAe5
	oITy0lJsEReolnraKFsX9J81TnOFGGP0VxxUL52XT9VecIe+WjYDRhvrfeUJjBbYCW1YDQhfEZ6
	42SoP23+Ys3FNJiqsgFCaHKRXFPyoy5mMFuXTruzgqtQ4b4MWxzEsiw04SnY1DEfs94madw==
X-Gm-Gg: AYBFou0xWNwwJWi+2PvxCw4ORTKxAatQlHctPbSqWBliqyfP53k02mlWZXKMSGbYxMK
	7eertIT/y+c0ndHWn6ekjv/UWWW29FOiN/9IlZi/imBOHZ3N5ShEfJxyeLCFHVppbn5CLzsVJwp
	sIBtOQZY5Ota8NT192Epvk/N3m7Ua+JE10BbhzSZ6tlJhotKAfYkwvowaEt0hLL8pgXFxjZ/noQ
	tVrG/v4Z8sqbZ3vlWPinBKf+5MC4dTsshNYMnLR7RRaBb+tghErd7GLSxoP/gvDhms54p1nO+eD
	nE9Sk2SHRdsl6/w7JO5V6k6r3PkTTjgv8pCHdEw1svSgonZIrX5gxjSZ9p5QVwIzW/f/B+hCva7
	Y4IBnmZpJhPVZM4VYAGN4LTogA3ympfSnc5eOCsygr7RNhGiJ5Mx2GVGiUk/KQDbVofI/D3k=
X-Received: by 2002:a17:90b:2542:b0:398:9beb:5c17 with SMTP id 98e67ed59e1d1-39b2620a2bfmr59984551a91.18.1789057869022;
        Thu, 10 Sep 2026 09:31:09 -0700 (PDT)
X-Received: by 2002:a17:90b:2542:b0:398:9beb:5c17 with SMTP id 98e67ed59e1d1-39b2620a2bfmr59984483a91.18.1789057868409;
        Thu, 10 Sep 2026 09:31:08 -0700 (PDT)
Received: from congzhan02.ap.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39d94bafb3bsm424320a91.1.2026.09.10.09.31.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 09:31:07 -0700 (PDT)
From: Cong Zhang <cong.zhang@oss.qualcomm.com>
Date: Fri, 11 Sep 2026 00:31:01 +0800
Subject: [PATCH] virtio_blk: use synchronous quiesce in
 virtblk_freeze_priv()
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260911-virtblk_sync_quiesce-v1-1-a883f8f31258@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAETbomoC/yXMQQ6CMBBA0auQWdukbbABrkIMsdNRR0mVDhAN4
 e4UXL7F/wsIJSaBplgg0czC75hhTgXg4xrvpDhkg9XW6dpoNXMaff/q5BexG6bcIqnaW6yqUJ5
 L4yCnn0Q3/h7b9vK3TP5JOO4vWNcN0oUde3gAAAA=
X-Change-ID: 20260910-virtblk_sync_quiesce-9b2c88d45416
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>,
        =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Ming Lei <ming.lei@redhat.com>
Cc: linux-arm-msm@vger.kernel.org, virtualization@lists.linux.dev,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Cong Zhang <cong.zhang@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-38bf1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789057863; l=2010;
 i=cong.zhang@oss.qualcomm.com; s=20250926; h=from:subject:message-id;
 bh=kcJgGBv43uV4lQuuDHe4VjFldBPqvQ8pUtSwWNQ1PIE=;
 b=n62tXsCZlwo3B+DeASbqVIAWgz6tguB52thgCTLihVpIEtl7yEH7lwlKoXMLJgcunsnLFSFho
 hgTCaG1bfqqC9qqcQSpc+BLyUiPxSdgV0tmhJCYlBGxIekBRGveLDX0
X-Developer-Key: i=cong.zhang@oss.qualcomm.com; a=ed25519;
 pk=8SBh3ey5igz2nlW+UFC6khFvaNPgG7MmbWtAeO2s6n8=
X-Authority-Analysis: v=2.4 cv=PIaaavqC c=1 sm=1 tr=0 ts=6aa2db4d cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=cmBj7K86vS66_wzKDlEA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-GUID: cQld1c2l2on7PMBFFmVwPLIa22lqM1oL
X-Proofpoint-ORIG-GUID: cQld1c2l2on7PMBFFmVwPLIa22lqM1oL
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEwMDIwMSBTYWx0ZWRfXxJQ3zzT+a+/0
 3qiq/0btrj6mmNe/QyFH8eU3AGPUZojmk0T7uXJbV2tGImV5xYPCaWwhN1Cwug1gMdfaaaCmqBG
 NbkNULqKMsIRunMFWf8D4kMpNZh4/sI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEwMDIwMSBTYWx0ZWRfX3t1Zes/k5UbH
 h/zFD8T97CaBQopwyHtYGDHietaFZi1hIigDB5A5Oee8R5tWc/d9eTgc62Gew5vvG/N5xQ8CnMY
 40dYpZ93MibpzoCurhBHw8rFl3zdJA31JGzExo1sld13vCobbAlTMVGDk+qRbjRgTZm8cNTKV3E
 MGbL6mm+2xUz71TsMb6fkQ4kgLNgQJ1xu0NJizMyyzZq8awGBpqb27d48+tuchwusCiH/IdfHr9
 8aWw1R9Tf34lZGYg4L2lshicTE8f3nGhgUeZmXs3iqiTILI3EhRT8BkAxTCBncojICWg9OyOJq6
 qaZrLcUDKYfqfhDRg4C+UcfDJEdLq1m+CwLjwf+swmJ5OlzkYoou6L8sKJbGGV9K7zN1C1zR6dC
 29gtvXwZn6lqNTVo0BmHVFDCqwbEWDHPlxn4G42zv6qWXZgO7uBF5DnRoktdga+G5Rg4MgSAvrE
 hTrZSO+XWUInTrqpyvQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-10_05,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 phishscore=0 spamscore=0 clxscore=1011
 suspectscore=0 malwarescore=0 adultscore=0 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609100201

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

