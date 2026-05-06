Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBCDC3DC4BD
	for <virtualization@lists.linux.dev>; Wed,  6 May 2026 09:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778058213; cv=none; b=pdoyc4WMiH/os/6ARisJQknHQ0yx2dJY6S5A833l04IClqAIclU/9B5iD3bVZHzpqBI+QFFhoFQpHn4K6i5w8VRaAiTZX0doQlrb0RV2oICowj7Iha0Wdwr3n3d2JZymfn7VanMjXJnlDAvhyL3/D6NFSn8L6F4DEnaiXs/4OLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778058213; c=relaxed/simple;
	bh=iyACEZr9tNu0J6Ll/OsHtjOciu11vmKknt4AOlYRNOk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Le47wy0RtbP1163w/5VhriHCevokYWUzppGMuT1ATe4pBh7HKUJBvaUF78c0wz/d+tHzh2keqxofzbHYCNC4pXlYx5RdwlKZYtA9211sqc2asYt7oqVLoo/kVGZnrJzgkglL9nj3ACC5NsF8fe4XrQQjhHgYFc01wBcQdRxegQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=a9Brw7sn; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=d4HOMx14; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="a9Brw7sn";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="d4HOMx14"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6467trI32427920
	for <virtualization@lists.linux.dev>; Wed, 6 May 2026 09:03:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=xNHOgmPVFPAixApqaWJUYe
	8lvxM9jzb7c9bkv+MyW04=; b=a9Brw7sny3EKlU+BlcL6QlOdaYkkkJ59TefCao
	y/lOnxFlpD7SpbiQ0IhUB5qJdBqFnO+LgVZJzbN4qes8Os15tAmlD4rAAjI+8cVJ
	QQ+gNIOytFA8hLxZLkNPPcdktWyRf8nUspTpY9i++pUQLEq1liaU3OLpNMkvEr26
	w/LJCEK2hPtA/LaspBOkMfHqBsQOUxqLAstflDKOdz2u4I4JcOL5qwfJ1ER3t9Q8
	BJU0V2SWrmhd3d6FlTdS/Mum93Oui0cxPuQPSpoEKVA+ebXMx0AC5By+1qzvgYIo
	iupVOm/J8Sl+cKPT39NT4VQTz7XLLBJBSxQvVgYjwdd9KWyw==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e01ph0b6v-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <virtualization@lists.linux.dev>; Wed, 06 May 2026 09:03:30 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id a92af1059eb24-12dc3d81736so3876453c88.1
        for <virtualization@lists.linux.dev>; Wed, 06 May 2026 02:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778058209; x=1778663009; darn=lists.linux.dev;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xNHOgmPVFPAixApqaWJUYe8lvxM9jzb7c9bkv+MyW04=;
        b=d4HOMx146PzYzTLBsRyumz8ZjsFEh8a0Yq1t+T9Ehx99gqHq/xnaFq5sbJoIZvPSmC
         qe3O2R79MXuGwCDOc3D9jn9nQqxEJXwTRFllGZk/ibzC7mhyheMFj+sXkr5bY5doPeDa
         q7yUKKcF8eoqjLI8BEuSri6gzwu+rMXiZsnlBedUtc1ztrDMWbX5gqRFPgTrcWAEbxY9
         SxL5oBmf6wdeLBO9/21f7KVni6clKLYe3nJ7MIcOLYx9lJwDMSXuLSv936engcxzC9jX
         MQBSln4hwMrbfOB76da0ge9v20x7TGzChc9o8IRwxNOqF2IbWW3/GQbU9iGObb3HW3JB
         +zcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778058209; x=1778663009;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xNHOgmPVFPAixApqaWJUYe8lvxM9jzb7c9bkv+MyW04=;
        b=soYd6xM9YZmqWtmd+3ospveBBAUfOMz2kDAYW+xR6HqSYeoO01jn8kWNhA6jRhQ0zA
         /UCLvphI+a4SmdepI5zafftW8CgJasJY4oPPYgH+SdImsad/mIzliONIgYJrYNxpN7xM
         UyGCS3NfAUknYZmwQXeXVahWobYy34XWyP3yeC7Jl4hkxlJ9f3Th3NqapadMz1hQ1tEY
         9EX1qI0Mey4UsSW0hQw5SKQNjyZ/qyUCLWDo3YxV29zmJ4xL00pXKFWdkPJ+rtEJqJhn
         iKEo6mcvOkKcSc2uW/vvPxx7pYLDjzh7TIKoEZgjbXcq6neHEyivta2KsQLHHlLAExIw
         mnFw==
X-Forwarded-Encrypted: i=1; AFNElJ9wDStQjda4BXAOpygZOEM9kZLZ+x/eNedWm5mnkhBXnGeyMjKWrbLxKhXfacfScoUiu5NZmjaTfgNfePyj9g==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw1KUlYey3BdV1R9k6mTUwfRXa+u8rCZ/uFf9Fa7MLGbQyXePO5
	pzMrCFG7lRl8U4d9HXarbJcTXkb1+dtP2nd7vzk2Cax2daoMBDlMHtvPLN3AV+WGy+f0D2rgNY9
	H4WDnq3SZtipYDE77REpfiKj4YjH9oEtLoIiv2RbNmKWmVsooYOA/Y/l3rKCF/GEgtztL0A==
X-Gm-Gg: AeBDieuvrwmfL+Yxut2sq6h4XHZDn9C0w8T9dIsduikVejhFfxC4/BBd3aMeEQEV48S
	TnTf48C82W0uiB6Ih9QF2wvl1Sll7I1MsHh97gtz1yXx/OoDpd1NuAmMB1qzXy0qFHQ083OSrFK
	QFafZ7jojZ9MECIzXSOZ8oN2fGaZcRBnLZlaF1CUDbc4kGr1CBUxK7T6o6L+csbp44CJJIsLQrf
	IDmghRP/+ufPX8c6hpNdJpy/YTAJGhiJfDWd+9o3JO7H7wUh7Wj7PdIk2Pj7D3F8i9TlArJcBYd
	T9JOyi1oydMciTJvxUlRFZtd9cWuZUf6MjaF92iwLfq9T+jLUvgppxxBWNu2P6Dq6f3GK1JeXEj
	EioQ3q1mPAoRusEP31aHz4FBePFdZzXEKqiOaYtbgqa+sp5xd3RWlaSx+34O1xOa3wQg9CVZikM
	L4sD9a
X-Received: by 2002:a05:7022:fa8:b0:12d:ccf5:271c with SMTP id a92af1059eb24-1319cf59173mr989113c88.22.1778058209388;
        Wed, 06 May 2026 02:03:29 -0700 (PDT)
X-Received: by 2002:a05:7022:fa8:b0:12d:ccf5:271c with SMTP id a92af1059eb24-1319cf59173mr989093c88.22.1778058208689;
        Wed, 06 May 2026 02:03:28 -0700 (PDT)
Received: from hu-penyan-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-131f9788eb4sm2473753c88.7.2026.05.06.02.03.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 02:03:28 -0700 (PDT)
From: Peng Yang <peng.yang@oss.qualcomm.com>
Date: Wed, 06 May 2026 02:03:12 -0700
Subject: [PATCH v3] virtio_console: bound __send_to_port() spin loop to
 prevent watchdog bite
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260506-add_timeout_to___send_to_port-v3-1-8ad046fc3dc3@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAM8D+2kC/43OQQrCMBAF0KtI1qY0k1KrK+8hEtpkYiO2qUlal
 NK7m9SNC0E3w3z4vJmZeHQGPTlsZuJwMt7YPga+3RDZ1v0FqVExE8ihzAvIaa2UCKZDOwYRrBD
 CY6/SNlgXKMsLibtGaigYicbgUJvH6p/O7+zH5ooyJDQ1WuODdc/1gYml3r+3JkYZLSUHxXmjC
 w1H6312H+ubtF2XxUHSyQk+0f0vFCLKFXDUqkReVV/QZVlexqjXUjgBAAA=
X-Change-ID: 20260420-add_timeout_to___send_to_port-104ce7bcf241
To: Amit Shah <amit@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: kernel@quicinc.com, virtualization@lists.linux.dev,
        linux-kernel@vger.kernel.org, kernel@oss.qualcomm.com,
        Peng Yang <peng.yang@oss.qualcomm.com>
X-Mailer: b4 0.16-dev-3bfbc
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778058207; l=6870;
 i=peng.yang@oss.qualcomm.com; s=20260420; h=from:subject:message-id;
 bh=iyACEZr9tNu0J6Ll/OsHtjOciu11vmKknt4AOlYRNOk=;
 b=aB3Zn2LRG9GMh+WjxfeyAQoQyFSL888qgy6Gj5NmTWiVSDNFPFtFQ7C0aMN8YzAjwIvB1azui
 Y00Ld113fgNCI09RgjsZpWUQ+6ulbedfVIBvfLWZpXpwNFiPew7Qthu
X-Developer-Key: i=peng.yang@oss.qualcomm.com; a=ed25519;
 pk=fY34c9+z3TbzFLgw2yql3bT/tbmxDEuxiVPTYAbRSTY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA2MDA4NyBTYWx0ZWRfX2SXQBKJiqOnW
 l3dEsIhxG+//A8R9BQ4DTz62e5fkgyYNMp/G3wHqWOU+GoBxNnyYw+pU3Erved8AulBDNGI9bUX
 CUfWinL1srwu578+HED6yhmOPvlKPys7donheSkjlh62AOPPlUCj5IbMAMl1kLUyOXbu+gNUhNN
 x/wdhGfxM4f14bIEWJzGqv2RzDUI4P8NAR70TDEx6aFSeWkrPj3V9gAV6/ngHg2lO+UlzUNLMsG
 G+8/7IOgOdlOLZHrS5Xr8OcASWLnK9JH/qLlmjbGgCNn1sNyIyNmnBYwpQZxH81J8zEPqFiu60Y
 8F2pVu6ZYnTEpSd6Ula8IUItPsTJVaBDgsomF0YKjSdLkma+SJcMvBm9fAmllGAZZKm2JcKrlL9
 1cn7HWJvNqDzzernCybf7Q9Hq6W6Ndax1gZ8KihU/TKFvV7T9RFhloG7XazL3h1WUtmABPD6Kf3
 nKlewwR5carIvt8zFOg==
X-Proofpoint-GUID: 21Kurj0LwLk73iLc5yM_djSs8TEEcgIX
X-Proofpoint-ORIG-GUID: 21Kurj0LwLk73iLc5yM_djSs8TEEcgIX
X-Authority-Analysis: v=2.4 cv=MYhcfZ/f c=1 sm=1 tr=0 ts=69fb03e2 cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8
 a=NWbpyqog06wjIlyGQJwA:9 a=QEXdDO2ut3YA:10 a=vBUdepa8ALXHeOFLBtFW:22
 a=FO4_E8m0qiDe52t0p3_H:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_03,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 clxscore=1015 impostorscore=0 adultscore=0
 spamscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605060087

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
 drivers/char/virtio_console.c | 81 +++++++++++++++++++++++++++++++++++--------
 1 file changed, 67 insertions(+), 14 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index 9a33217c68d9..4d6b3e144e7f 100644
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
 
@@ -1097,31 +1110,71 @@ static const struct file_operations port_fops = {
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

