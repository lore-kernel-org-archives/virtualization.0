Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7898232E151
	for <virtualization@lists.linux.dev>; Tue, 21 Apr 2026 06:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776754688; cv=none; b=T9Te0RStvLYHTgC0P4xGz96Pvjiyx8HHBMZo5CqQdtjXSKi+NfmFwBgORdPWZncME8j73jBgTeZNIYF8h3pyGSU+d2TuPtggKT3shr/oK/ggwiUV9DgGWEZ3eYjos4JAsQuvZPPYGPFVVtSqlJnEMd+1hU+aZ3mtYuKwYNsWLQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776754688; c=relaxed/simple;
	bh=rC3yWuhULcb0nTQeL8PDzenvx7AdZe62dkAzJqC3BIk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Vec9PNpKx2TLC8YeusvsbjV8oUWjuk1I8k4BgQFLnkoehz6v1i5zPlGDwcBQGp6OkPJQRT1t8nmjV9IfdG2LPzvi0zOACAAQlomUf5bZdc1TZGhtGSQ7oyBH4tdt0+4SgF5QwXcMX9k+zcMJi8J9XjFo6WHegC7cZkYjJdAjGKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lNYgMKEI; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=A9Fcqqdm; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lNYgMKEI";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="A9Fcqqdm"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63L5pKKw3455879
	for <virtualization@lists.linux.dev>; Tue, 21 Apr 2026 06:58:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=ruZ3V50v3wet1iIOwkEIeY
	oBmZIAlSyQansR1f8dvJY=; b=lNYgMKEIDCO+r3Iei2kFWmiMosVMFYyF15QZuW
	yWW2RxtPAlwEbJV3i1rmfkRpz0GUlgmDpF+OP2vNZiEFKELfVTEH8uGTcZC6XkRj
	NZsUuziTy+zpCZCLJFmIs8phCK5wfoFNJbCu1f0O+J77O8v3jaCRNPHdkhkehZlj
	qwsFcYf5/2P/h4kCM7JN+BAnd1Q5+sbDuQi3LnfOOUthRyNQTeoQw+udggTfuY2r
	0hTUDue8c0Mf9x4y9zgK0aMEc8T4ALJWQDPNE6KLKwGQ+cYuMUCkubiRKAvHYWfo
	tXVXVKNmGnOHhBbOSNqBXQq4QndXctOvtBXZyCvjWSSLIawQ==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dnfvjvscv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <virtualization@lists.linux.dev>; Tue, 21 Apr 2026 06:58:05 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-2e60238adb1so1268540eec.0
        for <virtualization@lists.linux.dev>; Mon, 20 Apr 2026 23:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776754684; x=1777359484; darn=lists.linux.dev;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ruZ3V50v3wet1iIOwkEIeYoBmZIAlSyQansR1f8dvJY=;
        b=A9FcqqdmZYwdeYxIus3FQzXJpbirUBnDLkyg56sY1kmd8+Ww5jJaGbN0UmHhYHiF/T
         rTBRL9BUasaGmQQxBbYWSjup4j56fsBjLtjcwpUAmE5UAfdLnOer8141Bge4joyGHqbP
         GG+nvvpoADGULs7uuelIftkf2QZ4aaTsq5GfA3Lz9DCAzXB3vEw5tbENn2B8IrYFvpns
         PdIiDbYioX57kzrXLqwZgFiS+syly1iqWOOIfOWse8XvDVzKomycnaveCFXKMO/tVA8N
         fuBHifGRO6syAeB7om296SGPYFi8VcjDAseb4COXhzG3qrKJVuWBNi4SSbjHCgdibdU9
         3tnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776754684; x=1777359484;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ruZ3V50v3wet1iIOwkEIeYoBmZIAlSyQansR1f8dvJY=;
        b=IyixiXLR9s3CmvsbJRUpZTDVNfGrCGgTjnTY9wAUXI5TuGK/faDDih4sH/rwwmkP6y
         D5qVVePLHmFXgKMSrF6zGb4Z34HgvMNFbGQURxbzd/F9VeUIC1EbMq1q0X/VvcTuCkB0
         P+/YVMh6hKYZPY5bd3S2jvZZHVOwIc0jfUa5onjhXigxkA585p+/Dsxj86mm0Q4jU4Lj
         /F50o4eFgfw9Whk+NnSpr6MIR1TgOYXNt+qtYV7UIGo8KTr0cNt4nK8PllwNqwb4s3Qr
         fBTzaMnY1LNAZ1X4ITxa+hfQCrDuCSHR6Aj7M8HWnPZumctelVKuoiwNJqz4li5j4Z5g
         p0EA==
X-Forwarded-Encrypted: i=1; AFNElJ9a3ton5r6pbrkJWvq5RrvjVn538ZvQRpQEGrBiNERtwUq2ucUQUvySI0K9/jFTaOEDJeTGUtb7MF6y5exhGw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzyB9nYwQ+EhUC/jJ3CJsAZPcUQRe23Wrn6RhvwQ9/4IhXzlq6X
	b9PafSeUckqMv1kQV6QTR7zUGmaNLQyRBzQsks8nrvZGAYT5TwsBrDv7eZnLxmVsft1NegmUdRk
	b2vzwZJmx75dZ/tRB+msB8ZzHxNJAo0ofy14+OJCirIg2cAZBIsa8qm3ajErNEz/0yh2FZ2Eb3n
	2VkA==
X-Gm-Gg: AeBDiet4NZt/OjEdTNcsvpv8zT5ETQEuOu+h9HmOQ17xiSCzuswjJDjpKCoYufx0ffv
	/3mtzGuyu7Qaxs6Lb2LUAqvEtaTBxm7SMEkEV03spdS7D442U1hMz1HhtqV+HoJpuz+nHgSoj1l
	4biv5c5HMRGzvpoySJ7xKY6c6XFrUklSpcN29CuIvYsVFcx1WDb7f+E+HC2ztDBMRXuXRUZFEeN
	RdXtb97SbbPvHIdv+X23Wugte2Xw6kMbN6OfXbmFm9ymk/nSWQKz0JxWpXXy2hmOujxXqWY0Ch0
	jTe1DaIIdkJaQUbUKPDkCjXlb5GsJRxi8D+xobAsIXdh9DVvdfa3oR2Exz2fx0guu1NF9+zzoIH
	CiX7Uys4bNfwDvNHzcHMG8ZggCJYgUyYfYJ/2ZjWHwhltW4jaoScMu1U4QbssMUWOUAr+tuk2sD
	w0Pua1
X-Received: by 2002:a05:7301:1f17:b0:2ea:3370:6e51 with SMTP id 5a478bee46e88-2ea33706e74mr1292272eec.4.1776754684174;
        Mon, 20 Apr 2026 23:58:04 -0700 (PDT)
X-Received: by 2002:a05:7301:1f17:b0:2ea:3370:6e51 with SMTP id 5a478bee46e88-2ea33706e74mr1292255eec.4.1776754683609;
        Mon, 20 Apr 2026 23:58:03 -0700 (PDT)
Received: from hu-penyan-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2e79c2954f6sm14629588eec.30.2026.04.20.23.58.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 23:58:03 -0700 (PDT)
From: Peng Yang <peng.yang@oss.qualcomm.com>
Date: Mon, 20 Apr 2026 23:57:44 -0700
Subject: [PATCH] virtio_console: add timeout to __send_to_port() spin loop
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260420-add_timeout_to___send_to_port-v1-1-6c32d33bf4f2@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAOcf52kC/yXMQQqDMBBA0avIrBtIQrDQq5QyaDK2U2gimVEK4
 t0b6+6/zd9AqDIJ3LoNKq0sXHKDu3QQX0N+kuHUDN763gZvzZASKn+oLIpaEFEop6PmUtU4GyJ
 dxzj54KA95koTf///++O0LOOboh5T2PcfM2pSzoEAAAA=
X-Change-ID: 20260420-add_timeout_to___send_to_port-104ce7bcf241
To: Amit Shah <amit@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: kernel@quicinc.com, virtualization@lists.linux.dev,
        linux-kernel@vger.kernel.org, Peng Yang <peng.yang@oss.qualcomm.com>
X-Mailer: b4 0.16-dev-3bfbc
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776754683; l=2943;
 i=peng.yang@oss.qualcomm.com; s=20260420; h=from:subject:message-id;
 bh=rC3yWuhULcb0nTQeL8PDzenvx7AdZe62dkAzJqC3BIk=;
 b=ib/+kW5gEtjsqPGa7Q8gDEkdyjYoAsogiBS88KCpRAs+2ucGY/5DOuNdIy+hJKybLOmIj/7Wm
 qDA4zYX2AvWDDY4pftvcaqqTWuufT3ey/Z3UmFtktvAcBaQ7wDr59yZ
X-Developer-Key: i=peng.yang@oss.qualcomm.com; a=ed25519;
 pk=fY34c9+z3TbzFLgw2yql3bT/tbmxDEuxiVPTYAbRSTY=
X-Proofpoint-ORIG-GUID: vE0-Vbv0ir4A2jbPiF4EhTbqGOsmbkFI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIxMDA2NiBTYWx0ZWRfX3AUPY5opBetL
 DA3PoTFNXOWDdYiWSVKR8zXa12xmQLJdTdkMB1ajLpqqs6M4A+GCsp//yKb96sqrKFV24QKnL7L
 HbIP1qa2p+iWeHl32SlM+6f+63KaSJ81tirlr7txvLTCr9GffsJk3ClvtlwQaG6vsqVt43lW6Rb
 86fuxdkNTAZ7LVQp3dTZ/C7L5AyZKAYQRjoHvd95SFC0ENgiJ8/vEqDoFry6ayhFQdJu6GHgFI6
 o2fE/QJ/Q8xYBJsIeXr0zqIJEOUh8Jag5Du+jFu+daVXht70j7rd6MZ9fTyi4smUg3U3hAxuW1/
 nOXIhr7inPTSCabHnmmlPR1AHIAXYkGVLui5U1JeuyklofRKVyEhSyWgyuJDyMf+PYwM76BYOVV
 TV920hOy8eKo154BUOOW/Z9O8Bp6VAwpdgT/Ho3xITMcRevGGgaq6tWiQWvNJpbQL+/7oFZ+TNd
 UgCzksc69BhWmakd7xg==
X-Authority-Analysis: v=2.4 cv=XNMAjwhE c=1 sm=1 tr=0 ts=69e71ffd cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=vqeHtFuH3X1APyjPvOwA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-GUID: vE0-Vbv0ir4A2jbPiF4EhTbqGOsmbkFI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-21_01,2026-04-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 impostorscore=0 suspectscore=0 clxscore=1011
 phishscore=0 malwarescore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604210066

__send_to_port() busy-waits in virtqueue_get_buf() while holding
outvq_lock with IRQs disabled. If the host stops draining the TX
virtqueue, this loop never terminates.

This was observed during secondary VM boot: virtio_mem plugged memory
in multiple iterations, each emitting dev_info() messages through the
hvc console. A writev() on the hvc TTY entered __send_to_port() and
stalled in the spin loop. When the watchdog bark ISR fired on another
CPU, it attempted printk(), which tried to acquire outvq_lock through
the same path and spun indefinitely. With all CPUs stuck, the watchdog
could not be serviced and triggered a bite.

Add a 200 ms deadline using ktime_get_mono_fast_ns() to bound the spin
loop. ktime_get_mono_fast_ns() reads the hardware counter directly and
is safe to call with IRQs disabled and spinlocks held.

The 200 ms value is chosen to be far above normal host response latency
(microseconds) to avoid spurious exits, yet well below the watchdog
bark-to-bite window (typically 3 s) so that CPUs can escape the loop
and complete the bark handler before a bite occurs.

Signed-off-by: Peng Yang <peng.yang@oss.qualcomm.com>
---
 drivers/char/virtio_console.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index 9a33217c68d9..b3535681dfe1 100644
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
 

---
base-commit: 97e797263a5e963da3d1e66e743fd518567dfe37
change-id: 20260420-add_timeout_to___send_to_port-104ce7bcf241

Best regards,
--  
Peng Yang <peng.yang@oss.qualcomm.com>

