Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D21419D092
	for <virtualization@lists.linux.dev>; Thu, 30 Apr 2026 05:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777528284; cv=none; b=NNiqu/GUN4hoD58XVeVCf47KYJ+E52m1ZXIGmonaWvkfshp2fvYr17d4po0GfvaljZxJ85kngD6nbm7KKuQhHnwWY3AA74xs3BQCbe+m4VPoH2F/UOeTkAZSr3NKJotX0tpH+/3uKA/GUrvfUOzRVfltqMz3J09ZJFB7o+echno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777528284; c=relaxed/simple;
	bh=flSnmYA+mpG4UVn/jSifljKmn6iSbTwtHEGbLQRpxsM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=dkqnMJHjxssXyJtg7nm8cvNkD2yzu6Qh0huMoue5GdM7RZ/RQG/nZVhwSn3SwWTbVO5QV4EhfxMsbDz1we48bNfT1sTFRAtx81JL2cuEtP2w5FcV85BNt8oC97BG8w4JDAfvAz8NVrc1iTGhsqNPdpLf/v3Ah2q14WfOKTgjvbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KGgZZjeb; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jRr8OPJE; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KGgZZjeb";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jRr8OPJE"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63TNuHom3636516
	for <virtualization@lists.linux.dev>; Thu, 30 Apr 2026 05:51:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=wumkGnIhMZcxfEHd+dZcN7
	qJAx/cnvK7hbnMvFoWiAM=; b=KGgZZjebjiGNSkPX5V6KP6H1it92LCh4+yzHdK
	YfNeQ4mMiFCDERwJ4Qk3o7Mfl+X8+p5ncP0wofJU6BZhy9KmAotHXcIGemeLVjHa
	P/l/fNz3HLeC7M2bINnPzh0Ri72IXlzvZj1FpooAEBo/GKA+iqDBr8CDJMcBi5oq
	mjWd4OqV/hXkWM7TB412pQMiGYUyobXHhauOipRKzvgXuSHD8adKgiOLi4m06eoH
	YH4dbH8/eo4R30ncGtjNJ2rByu54TZfsdujF1g3ukr29SrKgh846wG/3x6nFTjb9
	pJoGqBnRIKkxmqvc6vSEH8G2dOF/R0tpmG6vGYz8c012zwWg==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4duv3q117r-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <virtualization@lists.linux.dev>; Thu, 30 Apr 2026 05:51:20 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-2de07c12745so3106956eec.1
        for <virtualization@lists.linux.dev>; Wed, 29 Apr 2026 22:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777528280; x=1778133080; darn=lists.linux.dev;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wumkGnIhMZcxfEHd+dZcN7qJAx/cnvK7hbnMvFoWiAM=;
        b=jRr8OPJEiN878d72t8Ue24/R0QE/aStHQ0R1lQTLL7iAxns+osvQgEMwXx/hU/nCMj
         BDk0FFh0lC5B/KXBZgZzk6bQd4c5NAoYftpTWgFN1JZB+KUP+1rROWc57Y2uJmApy4ql
         /QMsekl/fA7XJPNMQkWEOr3o2dbIBwq7uWLr5AXoX0fs1IaY+Ce6Man+cpggharE4AWB
         IUf1BiioQ4fnVEQPZbottobRQqLBA5p/9/ARFNgPz/I2FvqKsgLWKry0vv6+DPH23c+q
         2aw+avCN6rYkoTTAgfyZvsmhhucZdgHr12iScmhc2Tm1Lj+YEToA3wY5ZQK9J7eS/+wZ
         xm5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777528280; x=1778133080;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wumkGnIhMZcxfEHd+dZcN7qJAx/cnvK7hbnMvFoWiAM=;
        b=dWptq3BVwaqhsg99q/YjUa5yhXA2d6M5nwj6hqwq0VNXbifRfu5iV8uggN0NwEs1z7
         hMijQDX/KKuOxUBYYxeUG2btkY5iU00CCUUfktry+Q1QRoe+hV+5SAn/dgeTZvxxU1V4
         XDkezxFrfMrP1Mm7vR26mc/Hjs3zN/J73VhTbz1df/Xc2RBmU119cQPcp1/hk6b4pF0e
         RXVH39LAm0LXRWzATIIYLLfH6+hA2OvHv3sm3OlkvW9bXP2P16Mc694FqjfQM6LVBwWQ
         3Vb/z2ZI/6DEiURPRKZXSY3SpLGHLcCDlA7LLybA2zrTln1mNtKh1e3mGhgamjWLSoL5
         8kfg==
X-Forwarded-Encrypted: i=1; AFNElJ/YSRCEOAWuR3Nvl+kJEJMzbOewmuelL6q3gdo1Ynmh1DFMcuuCBOajj7t/V2etYIesaMODVRSo5pFevmQ8Gw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzPUkqvjfi7qkjxGHfePa+a417H4Hi5akah9qXgoUrzhm/oDmZR
	MLj8dY4nMWvS0ZcS8Bb/Ngz8TpZBPWZv8ukbUTtaTkOAIk6A89HsXNj4Hi6DT82pI7yZg6rR2oY
	YftL03dc0LoHhenYklYFCZEykC1cJwGi8ZNEOoS6cSHUX9e6yW5iY7Qdpd51yZFZUYu0JIA==
X-Gm-Gg: AeBDieu90ioB7lh0ZMKuHktKfOwiBo2TeoMml5vfByy40xeh9FNvcFo2eYuzQT5Cpnh
	cuJQPSaaO4ZcZR44dShb8hFrBpHpOSsPYJQ6OY3ZhRksMVLsQ7jRf4CMhbzEp7xKa8nR8TVYlYe
	Rn29xB1vxo+3wjIslk10nroyvu1GQT+7UUNi2w8SkxMM4laelVU6lTd5lgrLtnR4m49ZZpzlx2h
	kkd0Aqp01UQY8AEl2B4KE+wbn5UGiVU9QZcv8gV4A5KwILfL6JGUv8xMEB+x111/rJJQApNz2h5
	HekP6vi1MryBsaAcd1D0QAestt635TWVh1u8HgrhSrIdZzHyCpznQ5l2G1Twnr4+mBoUoxdFs6Y
	0b5i1oP3lA1Y2uVrjhrr5TgZ8Dtw5imjEmqLPh0c3Mk+tX0w73J8eh6x1ve5EWBT02SWWIJL3tX
	u04Xgi
X-Received: by 2002:a05:7300:2149:b0:2ed:e17:d50e with SMTP id 5a478bee46e88-2ed3eb68caemr646471eec.33.1777528279740;
        Wed, 29 Apr 2026 22:51:19 -0700 (PDT)
X-Received: by 2002:a05:7300:2149:b0:2ed:e17:d50e with SMTP id 5a478bee46e88-2ed3eb68caemr646452eec.33.1777528279069;
        Wed, 29 Apr 2026 22:51:19 -0700 (PDT)
Received: from hu-penyan-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ed1c09c6e3sm5099249eec.25.2026.04.29.22.51.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 22:51:18 -0700 (PDT)
From: Peng Yang <peng.yang@oss.qualcomm.com>
Date: Wed, 29 Apr 2026 22:51:03 -0700
Subject: [PATCH v2] virtio_console: add timeout to __send_to_port() spin
 loop
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260429-add_timeout_to___send_to_port-v2-1-3d23efd6e388@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAMbt8mkC/42OQQrDIBBFrxJc16BGUuiq9yhBjI6NpYmpY0JLy
 N2r6QW6Gf6Dz/uzEYToAcml2kiE1aMPUwZxqogZ9HQH6m1mIphomRSMamtV8iOEJakUlFIIky1
 pDjFRzqSBc2+ckJxkxxzB+ffhv3U/xqV/gElFWhqDxxTi53hg5aX379bKKaetaYRtmt5JJ64Bs
 X4t+mnCONb5kG7f9y8p8q2i4wAAAA==
X-Change-ID: 20260420-add_timeout_to___send_to_port-104ce7bcf241
To: Amit Shah <amit@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: kernel@quicinc.com, virtualization@lists.linux.dev,
        linux-kernel@vger.kernel.org, kernel@oss.qualcomm.com,
        Peng Yang <peng.yang@oss.qualcomm.com>
X-Mailer: b4 0.16-dev-3bfbc
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777528278; l=7053;
 i=peng.yang@oss.qualcomm.com; s=20260420; h=from:subject:message-id;
 bh=flSnmYA+mpG4UVn/jSifljKmn6iSbTwtHEGbLQRpxsM=;
 b=HqYCJRHRfscOzRvNxGvp88tmrd5DubWetzqlBs0rKGfLxPKjaZQ8ZI4bZHY69rHCn5iXm2OYC
 Ebraq5BhV8ZDPShhWART+gV8jBMolL9vLtXfPE6w8DXJX6xT7NmXnN5
X-Developer-Key: i=peng.yang@oss.qualcomm.com; a=ed25519;
 pk=fY34c9+z3TbzFLgw2yql3bT/tbmxDEuxiVPTYAbRSTY=
X-Proofpoint-GUID: wYpRcXEuUlqu6bMkEVlNJ2fQZ_xDMuYP
X-Authority-Analysis: v=2.4 cv=dOyWXuZb c=1 sm=1 tr=0 ts=69f2edd8 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8
 a=8FXxk6N7uHa2evdMFNMA:9 a=QEXdDO2ut3YA:10 a=bBxd6f-gb0O0v-kibOvt:22
 a=FO4_E8m0qiDe52t0p3_H:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDMwMDA1NSBTYWx0ZWRfX574tVcuY+9FW
 yW0d3KFYqp0UICvD9suyOWl/5ASX2K3TrISQnF/OP7qWeZACa8xROYrq4pJevcjbruhI/ouMqV2
 pkFfLbkegv5zv/rH97yO98ipOcSFpVTAKIs8HECQD/91q8W7NJOhwuhTjXBlT/i3+/q+7Ka9G7g
 v5huRmqqZqXSVWo0RuHKo8EsYGxz2E6KBosWCyoOf49UXLJd54aRcvAerdvLcIE+bNqqphgeX9a
 fhhuMoOoTKTy/MPqNvZnRXF6L1itd+sqPcKDPQiryaMSMOKUO5W7V9S70tYTk74ubuJUDGbOF1a
 AMYnArO5QXKP/QGV8HGQ7j2Es/9tszOOhEOrDdKPvr4rKg/GPpndUBO0DbWc+m+i59ybjxM0eGn
 Gez5GtJkNJLM/52g0pVdJA+/YVsaeAqx+SfWrKXYT9AJ4qNooE1iJLYKfO2apqxHXGCbigzVUA1
 tTmIcfYH6d3I2j15tHw==
X-Proofpoint-ORIG-GUID: wYpRcXEuUlqu6bMkEVlNJ2fQZ_xDMuYP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-30_01,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 adultscore=0 spamscore=0 lowpriorityscore=0
 bulkscore=0 suspectscore=0 priorityscore=1501 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604300055

__send_to_port() busy-waits on virtqueue_get_buf() while holding
outvq_lock with IRQs disabled.  If the host stops draining the TX
virtqueue, this loop never terminates.

This was observed during secondary VM boot: virtio_mem plugged memory
in multiple iterations, each emitting dev_info() messages through the
hvc console.  A writev() on the hvc TTY entered __send_to_port() and
stalled in the spin loop.  When the watchdog bark ISR fired on another
CPU, it attempted printk(), which tried to acquire outvq_lock through
the same path and spun indefinitely.  With all CPUs stuck, the watchdog
could not be serviced and triggered a bite.

Add a 200 ms deadline using ktime_get_mono_fast_ns() to bound the spin
loop.  ktime_get_mono_fast_ns() reads the hardware counter directly and
is safe to call with IRQs disabled and spinlocks held.

The 200 ms value is chosen to be well above normal host response latency
(microseconds) to avoid spurious exits, yet well below the watchdog
bark-to-bite window (typically 3 s) so that CPUs can escape the loop
and complete the bark handler before a bite occurs.

To handle the timeout case safely, put_chars() is reworked to allocate
a full struct port_buffer (GFP_ATOMIC) instead of a plain kmalloc'd
data buffer.  This allows reclaim_consumed_buffers() to call free_buf()
on the token returned by virtqueue_get_buf() regardless of whether
__send_to_port() timed out before observing the used-ring update.
Ownership of the buffer is transferred to the virtqueue on success and
reclaimed by reclaim_consumed_buffers(); on virtqueue_add_outbuf()
failure the buffer is freed immediately via free_buf().

Signed-off-by: Peng Yang <peng.yang@oss.qualcomm.com>
---
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
 drivers/char/virtio_console.c | 78 +++++++++++++++++++++++++++++++++++--------
 1 file changed, 64 insertions(+), 14 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index 9a33217c68d9..91977d458a72 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -27,6 +27,7 @@
 #include <linux/module.h>
 #include <linux/dma-mapping.h>
 #include <linux/string_choices.h>
+#include <linux/timekeeping.h>
 #include "../tty/hvc/hvc_console.h"
 
 #define is_rproc_enabled IS_ENABLED(CONFIG_REMOTEPROC)
@@ -601,6 +602,7 @@ static ssize_t __send_to_port(struct port *port, struct scatterlist *sg,
 	int err;
 	unsigned long flags;
 	unsigned int len;
+	u64 deadline;
 
 	out_vq = port->out_vq;
 
@@ -632,10 +634,18 @@ static ssize_t __send_to_port(struct port *port, struct scatterlist *sg,
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
+	while (!virtqueue_get_buf(out_vq, &len) &&
+	       !virtqueue_is_broken(out_vq)) {
+		if (ktime_get_mono_fast_ns() >= deadline)
+			break;
 		cpu_relax();
+	}
 done:
 	spin_unlock_irqrestore(&port->outvq_lock, flags);
 
@@ -1097,31 +1107,71 @@ static const struct file_operations port_fops = {
 };
 
 /*
- * The put_chars() callback is pretty straightforward.
+ * The put_chars() callback writes characters to the virtio console port.
  *
- * We turn the characters into a scatter-gather list, add it to the
- * output queue and then kick the Host.  Then we sit here waiting for
- * it to finish: inefficient in theory, but in practice
- * implementations will do it immediately.
+ * We allocate a struct port_buffer (with GFP_ATOMIC) to wrap the data so
+ * that reclaim_consumed_buffers() can safely call free_buf() on the token
+ * returned by virtqueue_get_buf(), even if __send_to_port() timed out
+ * before observing the used-ring update.
+ *
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
+	/*
+	 * Allocate a struct port_buffer with GFP_ATOMIC so that
+	 * reclaim_consumed_buffers() can safely call free_buf() on the token
+	 * returned by virtqueue_get_buf(), whether or not __send_to_port()
+	 * timed out.  alloc_buf() uses GFP_KERNEL internally, so we open-code
+	 * the allocation here.
+	 */
+	pbuf = kmalloc(struct_size(pbuf, sg, 0), GFP_ATOMIC);
+	if (!pbuf)
 		return -ENOMEM;
 
-	sg_init_one(sg, data, count);
-	ret = __send_to_port(port, sg, 1, count, data, false);
-	kfree(data);
+	pbuf->buf = kmalloc(count, GFP_ATOMIC);
+	if (!pbuf->buf) {
+		kfree(pbuf);
+		return -ENOMEM;
+	}
+	pbuf->dev = NULL;
+	pbuf->sgpages = 0;
+	pbuf->len = count;
+	pbuf->offset = 0;
+	pbuf->size = count;
+	memcpy(pbuf->buf, buf, count);
+
+	sg_init_one(sg, pbuf->buf, count);
+	ret = __send_to_port(port, sg, 1, count, pbuf, false);
+
+	/*
+	 * If virtqueue_add_outbuf() failed inside __send_to_port() (ret <= 0),
+	 * the token was never submitted to the virtqueue, so reclaim_consumed_
+	 * buffers() will never see it.  Free pbuf explicitly in that case.
+	 *
+	 * On success (ret > 0), ownership of pbuf has been transferred to the
+	 * virtqueue as the descriptor token.  It will be reclaimed and freed
+	 * by reclaim_consumed_buffers() -> free_buf() when the host marks the
+	 * descriptor as used, even if __send_to_port() timed out before
+	 * observing the used-ring update.  Do NOT free pbuf here in that case.
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

