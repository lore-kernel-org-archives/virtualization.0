Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B193B3F7868
	for <virtualization@lists.linux.dev>; Wed,  6 May 2026 10:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778061896; cv=none; b=g6j4TSmTiHAnYXL0OFsXpVjMC3ygsdBjc1evN3vtdV2UHJ03w+D616t+rlVTx7iWpK/EaMatmzrXtrjCZ7DMjHcq9Y+O/zeo4tdSOraINJ+S6sJJpygEMJ3qxIECB0jw3kL5A5ux/R3MHsesx65ku3qkcLW1H9CNFGGKGCdiCrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778061896; c=relaxed/simple;
	bh=qM0QHSS2lOwtZwClWM3tEyZnrTRS8RnRUKoF5Opy19A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=S1GNEZs/kj0Iz3ExYEo5XC1zBCsvk+isyBUOIBM1Z6dkKdgkzDsTLM2QXchzialWifzxfteg2cw4x6gh2udBkYmxnvk1t9uyG7DO8oh7rOpiEY6+l6duIynVd8Zfv5MDL+HGatMz82nNu1atS8kp243zVjsHuk+Wduvd39HmYGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SXI+QDsq; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hlDz76n+; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SXI+QDsq";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hlDz76n+"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 646A4kPX3524270
	for <virtualization@lists.linux.dev>; Wed, 6 May 2026 10:04:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=e7RuSzzgTNaS5/Anxoznyk
	MakHr9Zb06kIRc/K3tw04=; b=SXI+QDsqwGAgghBr5gz0E1ekxkxwkEjUHAM8lU
	1R5RyVGvlJ+YGn4tDOU8msIljreR6l2JKB0P3dEb6xx3w8l5XXAfjqgZm+U1h4+b
	063U8XKQmcLoWrpPCMdy2Z+6ovVH5qzSb9LMH7K+eGkqFtolnDOlkhCwGMaBlXHb
	AdNyMClB31HAf45eJ+wEFMvje6uZyBJ6jLEJQUEa+uQ+vYyuZ1u8J6+mF/77mTx7
	bm8ThpSDN5my8UaP6c6Yr66IrKgDZoUbW+8RfAv+XpyqsaiGiEHtuRBNYnOb4xID
	nmCalS6OAn8jKg6FRQTGyAW4xm0UeBkrQ5Ue4gXYYWUbZyNQ==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e03jwr00h-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <virtualization@lists.linux.dev>; Wed, 06 May 2026 10:04:46 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-2ee5b73c5f2so14625620eec.0
        for <virtualization@lists.linux.dev>; Wed, 06 May 2026 03:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778061886; x=1778666686; darn=lists.linux.dev;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=e7RuSzzgTNaS5/AnxoznykMakHr9Zb06kIRc/K3tw04=;
        b=hlDz76n+uFhqJE+QLu6TYKq3vVpym6LPFPINAWMy781vzL906q6NQThOwsoqsjhoNH
         l6Xa2p/idM0tW6LfQMdSAPAVsho3VbAgNWH5oOPHrVn1xSy+vgexb9WelV7Bq2w8d7g1
         6g/ckGcq+TJbx8iVEpbHmZaouUP5rFuNgsapE69hpdrzLpr+3GUwY4z/hVsofg2soxKy
         9QXREj8J4BWaUub/31xGEJY1aXn2cxVVTATxHFVj63zJi2VTQ5pfJcXZLGHn2djkKLOd
         mWF3j9p9CtDCvaqohWUaHNKL806KjRwZG/nsoGsXy8qBEcc5mDO61yGuFTaGGx/thAOP
         PeSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778061886; x=1778666686;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e7RuSzzgTNaS5/AnxoznykMakHr9Zb06kIRc/K3tw04=;
        b=VAz1bmZUCvazvifkVJn9KiB6lsB9iiLCYsAFtvGQv1B5fhTbUWwYNJwfFV1APGKG4E
         8X9aJLjnP+DWcQLKL3fNtAqiIp7uvezJWZ77Oe2D9srYoCHF3runkLi5Mn0ibNZusi+N
         gtD8ECnxVpqwRSkFjIZW9AoEHGNXBX8kE4Y3cxcK7n+v/V6J9Orrwp+df8ldVapER06O
         Gl9RY6W1YhcKRsMkRAIEKa32ttE7JaaUHIcr7Iypu6z2Yn2f74ZKYiM7DoicCEd3mURX
         gsrgB0u8rPZq7L7MNPPnNAURTWeJ+7WUI7rXguicKKx6NI/8aCXpnXTBCB8zL43l5INd
         vYdg==
X-Forwarded-Encrypted: i=1; AFNElJ+p4fV72t0BOLxBsHRl8/iI2cam7hvi5n0lR3GGihEl0r/WMGisfENYWbPO8HDEAOVoXunKn8JAlq1H3zjIag==@lists.linux.dev
X-Gm-Message-State: AOJu0YxnpGiBG9CtQ4LsnN0FMdYYBksi0jXpkkeD1ykQv6+D0l7SOIkt
	9lX2PqV027n6sMNtWGFufCvJbXmUKZHUGlYY6P/J/pDlQgaWDEADHlIKqb0uMERBaUHlvOdhH9U
	nadu/bcEr1jzyHD0625fYIOKm6BJks8DEdHtgG+eDKGBn0VuHHLnM/viJ0fgff+I35i2IEA==
X-Gm-Gg: AeBDiesErQxkrvk02aFmbTT9fipeV3aJIREle2EXCw2JJEu6HNOvS/k6Tg491cndtQI
	ktvF6Sa+gpS4rtg0hgBjTjGxvnpipi3boOnkL54E14QH/j+EGrlHBIEfMk0HeIq2BsE26DrFV3Z
	vu7J7GltoQmrjqGFI2ovlfgrqKkxygvcq0dW+GJVSrQetmLpZVxGEoLjJZ0RIoWtil+MCCL9vfN
	Qs0N+b0tDEBHGJqxKvM4V6e0z2ir4Kuz+vo+2yKsjHXHm0nYCQiNAdfrPsF+9KIDblgiX5oRYwg
	ONqsz/jLlEJ+kk3oY/UEQ5syo9GEPfb75PC4k8c8sYjJObYh6NTPnQ0aOhSTaMy4B6HarfwF2Jg
	1YPA6VC7e6/rW6Gz/9f7XP3JuiLd6i4aGez0u+opA19SAXl/ePc4kb7RilX0RDhJhTKFTVcA57f
	0ml/9b
X-Received: by 2002:a05:7300:bc1a:b0:2f1:496c:94d1 with SMTP id 5a478bee46e88-2f54ac74aabmr1189483eec.21.1778061885475;
        Wed, 06 May 2026 03:04:45 -0700 (PDT)
X-Received: by 2002:a05:7300:bc1a:b0:2f1:496c:94d1 with SMTP id 5a478bee46e88-2f54ac74aabmr1189468eec.21.1778061884749;
        Wed, 06 May 2026 03:04:44 -0700 (PDT)
Received: from hu-penyan-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f56f891a56sm2928834eec.14.2026.05.06.03.04.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 03:04:44 -0700 (PDT)
From: Peng Yang <peng.yang@oss.qualcomm.com>
Date: Wed, 06 May 2026 03:04:41 -0700
Subject: [PATCH v4] virtio_console: bound __send_to_port() spin loop to
 prevent watchdog bite
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260506-add_timeout_to___send_to_port-v4-1-8f3c7549b72a@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIADgS+2kC/43OwU4DIRAG4FdpOEsDMxTXnnwPY8guDBbjLhXYj
 abZdy+0h3rQ1Mtk/uTPN3NimVKgzPabE0u0hBziVIN62DB76Kc34sHVzECAFgoE750zJYwU52J
 KNMZkmlzbjjEVLoWy9DhYD0qyahwT+fB18V9erznPwzvZ0tDWOIRcYvq+PLDI1vvvrUVyybVFc
 IiDVx6eY87bz7n/sHEct3WwdnKBn+jTPRQqig6QvNOEXfcHijd0J/Q9FCva9U4o7S06i7+g67q
 eASQWEz2NAQAA
X-Change-ID: 20260420-add_timeout_to___send_to_port-104ce7bcf241
To: Amit Shah <amit@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: kernel@quicinc.com, virtualization@lists.linux.dev,
        linux-kernel@vger.kernel.org, kernel@oss.qualcomm.com,
        Peng Yang <peng.yang@oss.qualcomm.com>
X-Mailer: b4 0.16-dev-3bfbc
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778061883; l=6757;
 i=peng.yang@oss.qualcomm.com; s=20260420; h=from:subject:message-id;
 bh=qM0QHSS2lOwtZwClWM3tEyZnrTRS8RnRUKoF5Opy19A=;
 b=6SoRarHSQJzYKN5cjt0OJqNZ33hWoBK7QuCOau3jtI/vbo4tZ+v2Rd0fWyOV4JvgUWIU3txAR
 HwTvUbCq+74CJPduHGsQYHoCiO1zrl/13JZ9TOHwxn1GdYQ1uWv2fi3
X-Developer-Key: i=peng.yang@oss.qualcomm.com; a=ed25519;
 pk=fY34c9+z3TbzFLgw2yql3bT/tbmxDEuxiVPTYAbRSTY=
X-Authority-Analysis: v=2.4 cv=J4CaKgnS c=1 sm=1 tr=0 ts=69fb123e cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8
 a=UaD9Rcc6a6UQGHyLLyMA:9 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22
 a=FO4_E8m0qiDe52t0p3_H:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA2MDA5OCBTYWx0ZWRfXwDiKha65UhKa
 2FujsvAm2yaLnDEJdeKlcuAypu7j3HNLhz+6D894STAp1C2zzZ6gTrgvsUjD2qjad0SeGmg52AV
 eXL87IvfNwEBhAaYFsl6OqESy5+BT+3PQiUn2fvA87UV1Y3rW8373S8wMXEmfcak8X9+RvMnGVP
 EebRq0saX6TgQ85J5iDxBktHCTHff6K5GSsthLvXS/krUcfYxrpyntFLGJFUglVYUM/KjVaq1wm
 iKK1VKZR01f7xYHKHsT0qKdjS3QctThVJggXsdOZvfK8isYCGIQUecvWwkD3gve1L77ppTqJjvf
 64G8dKEiVlHXW45QjzKWP7hbMhuAKNoKcZEAZoixtqX7pk2umFLtRTi0n8Rth/TfKU6+2CBk0Ty
 EGllRsaNHOcto+z0+1MLPeFx5I2fXHtbkhJsun4NXNIMPC0hGBjFbedpkFKtorhOR8YbSA7nFsw
 u5Y08/ocsxxCCzw4ooQ==
X-Proofpoint-GUID: f3bD7c0lwXh3LnKiDqeNheP5zYY4tiS6
X-Proofpoint-ORIG-GUID: f3bD7c0lwXh3LnKiDqeNheP5zYY4tiS6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_03,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 malwarescore=0 impostorscore=0 adultscore=0
 phishscore=0 suspectscore=0 spamscore=0 bulkscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605060098

__send_to_port() acquires outvq_lock with IRQs disabled via
spin_lock_irqsave(), then spins in virtqueue_get_buf() waiting for the
host to consume the TX descriptor.  When the host is slow to respond
(e.g. under heavy load from concurrent virtio_mem plug operations
during secondary VM boot), the spin never exits.

The watchdog bark ISR fires on another CPU and tries to printk(), which
calls hvc_console_print() -> put_chars() -> __send_to_port(), attempting
to acquire outvq_lock.  With outvq_lock already held and IRQs disabled,
all CPUs stall and the watchdog cannot be pet, triggering a bite.

Add a 200ms deadline using ktime_get_mono_fast_ns() to break out of the
spin loop as a fallback.  Since __send_to_port() may now return before
the host has consumed the TX descriptor, put_chars() is changed to
allocate a struct port_buffer (GFP_ATOMIC) as the virtqueue token
instead of a raw kmemdup() pointer, so that reclaim_consumed_buffers()
can safely call free_buf() on it regardless of whether a timeout
occurred.  put_chars() frees the buffer only when
virtqueue_add_outbuf() fails and the token was never submitted.

Signed-off-by: Peng Yang <peng.yang@oss.qualcomm.com>
---
Changes in v4:
- Rewrite commit message to be more concise and focused.
- Link to v3: https://patch.msgid.link/20260506-add_timeout_to___send_to_port-v3-1-8ad046fc3dc3@oss.qualcomm.com

Changes in v3:
- Fix token leak in __send_to_port(): capture virtqueue_get_buf() return
  value and call free_buf() after the spin loop exits normally.
- Link to v2: https://patch.msgid.link/20260429-add_timeout_to___send_to_port-v2-1-3d23efd6e388@oss.qualcomm.com

Changes in v2:
- Rework put_chars() to allocate full struct port_buffer (GFP_ATOMIC)
  so free_buf() can safely reclaim the token on timeout.
- Transfer buffer ownership to virtqueue on success; free immediately
  on virtqueue_add_outbuf() failure.
- Link to v1: https://patch.msgid.link/20260420-add_timeout_to___send_to_port-v1-1-6c32d33bf4f2@oss.qualcomm.com

To: Amit Shah <amit@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: kernel@oss.qualcomm.com
Cc: virtualization@lists.linux.dev
Cc: linux-kernel@vger.kernel.org
---
 drivers/char/virtio_console.c | 75 +++++++++++++++++++++++++++++++++++--------
 1 file changed, 61 insertions(+), 14 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index 9a33217c68d9..12674a667fec 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -27,6 +27,7 @@
 #include <linux/module.h>
 #include <linux/dma-mapping.h>
 #include <linux/string_choices.h>
+#include <linux/timekeeping.h>
 #include "../tty/hvc/hvc_console.h"
 
 #define is_rproc_enabled IS_ENABLED(CONFIG_REMOTEPROC)
@@ -601,6 +602,8 @@ static ssize_t __send_to_port(struct port *port, struct scatterlist *sg,
 	int err;
 	unsigned long flags;
 	unsigned int len;
+	void *token;
+	u64 deadline;
 
 	out_vq = port->out_vq;
 
@@ -632,10 +635,20 @@ static ssize_t __send_to_port(struct port *port, struct scatterlist *sg,
 	 * buffer and relax the spinning requirement.  The downside is
 	 * we need to kmalloc a GFP_ATOMIC buffer each time the
 	 * console driver writes something out.
+	 *
+	 * To avoid spinning forever if the host stops processing the
+	 * TX virtqueue (e.g. during VM shutdown), a 200ms deadline is
+	 * used to break out of the loop as a fallback.
 	 */
-	while (!virtqueue_get_buf(out_vq, &len)
-		&& !virtqueue_is_broken(out_vq))
+	deadline = ktime_get_mono_fast_ns() + 200ULL * NSEC_PER_MSEC;
+	while (!(token = virtqueue_get_buf(out_vq, &len)) &&
+	       !virtqueue_is_broken(out_vq)) {
+		if (ktime_get_mono_fast_ns() >= deadline)
+			break;
 		cpu_relax();
+	}
+	if (token)
+		free_buf(token, false);
 done:
 	spin_unlock_irqrestore(&port->outvq_lock, flags);
 
@@ -1097,31 +1110,65 @@ static const struct file_operations port_fops = {
 };
 
 /*
- * The put_chars() callback is pretty straightforward.
+ * The put_chars() callback writes characters to the virtio console port.
+ *
+ * We allocate a struct port_buffer (with GFP_ATOMIC) to wrap the data so
+ * that reclaim_consumed_buffers() can safely call free_buf() on the token
+ * returned by virtqueue_get_buf(), even if __send_to_port() timed out
+ * before observing the used-ring update.
  *
- * We turn the characters into a scatter-gather list, add it to the
- * output queue and then kick the Host.  Then we sit here waiting for
- * it to finish: inefficient in theory, but in practice
- * implementations will do it immediately.
+ * On success, ownership of the buffer is transferred to the virtqueue as
+ * the descriptor token; it will be reclaimed by reclaim_consumed_buffers().
+ * On failure (virtqueue_add_outbuf() error), the buffer was never submitted
+ * and must be freed explicitly here.
  */
 static ssize_t put_chars(u32 vtermno, const u8 *buf, size_t count)
 {
 	struct port *port;
 	struct scatterlist sg[1];
-	void *data;
-	int ret;
+	struct port_buffer *pbuf;
+	ssize_t ret;
+
+	if (!count)
+		return 0;
 
 	port = find_port_by_vtermno(vtermno);
 	if (!port)
 		return -EPIPE;
 
-	data = kmemdup(buf, count, GFP_ATOMIC);
-	if (!data)
+	pbuf = kmalloc(struct_size(pbuf, sg, 0), GFP_ATOMIC);
+	if (!pbuf)
+		return -ENOMEM;
+
+	pbuf->buf = kmalloc(count, GFP_ATOMIC);
+	if (!pbuf->buf) {
+		kfree(pbuf);
 		return -ENOMEM;
+	}
+	pbuf->dev = NULL;
+	pbuf->sgpages = 0;
+	pbuf->len = count;
+	pbuf->offset = 0;
+	pbuf->size = count;
+	memcpy(pbuf->buf, buf, count);
 
-	sg_init_one(sg, data, count);
-	ret = __send_to_port(port, sg, 1, count, data, false);
-	kfree(data);
+	sg_init_one(sg, pbuf->buf, count);
+	ret = __send_to_port(port, sg, 1, count, pbuf, false);
+
+	/*
+	 * If virtqueue_add_outbuf() failed inside __send_to_port() (ret <= 0),
+	 * the token was never submitted to the virtqueue, so reclaim_consumed_
+	 * buffers() will never see it.  Free pbuf explicitly in that case.
+	 *
+	 * On success (ret > 0), __send_to_port() may have already freed pbuf
+	 * via free_buf() if virtqueue_get_buf() returned the token before the
+	 * deadline.  If the spin loop timed out instead, pbuf is still in the
+	 * virtqueue and will be reclaimed and freed by
+	 * reclaim_consumed_buffers() -> free_buf() on the next call.  Either
+	 * way, do NOT free pbuf here.
+	 */
+	if (ret <= 0)
+		free_buf(pbuf, false);
 	return ret;
 }
 

---
base-commit: 97e797263a5e963da3d1e66e743fd518567dfe37
change-id: 20260420-add_timeout_to___send_to_port-104ce7bcf241

Best regards,
--  
Peng Yang <peng.yang@oss.qualcomm.com>

