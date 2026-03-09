Received: from mail-qv1-f99.google.com (mail-qv1-f99.google.com [209.85.219.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D9571F4CB3
	for <virtualization@lists.linux.dev>; Tue, 10 Mar 2026 00:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773101835; cv=none; b=hf8fz/oWlxlXKWA8mmhn+7azgsRXZMQ0FucCiaPzOpbV+eSdg4dSwtgLK6NNiJos290BJbX+0MTYuvOAEnbHEEi/RFmIePpkRm1Ug2QGc/mam06/8YTRbFiwTpsqeriUswGps5VTIYKIQEJ4jabuc21KjM7PXHZwIrw0pS24fu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773101835; c=relaxed/simple;
	bh=IuU7841Kb58NNELaJ1BogWUtCo2ilSrj/nV0cjFquRE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OKfs2A5Hrsa5fnp1lrqRRe5PD3HBH4Zwti+ISDdR48nMKl9H2mX4yDT+KzLAFwCL6QASXWnRw70TkVdeFd9rFebdyMa/kfFDSzOZwOv3+Q7fS3AU0KrNPA/ka78rwdHsELuYjJyOQrO4znB8cmuHEM36mVYSNVOEdb4MmhR/2XI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=T3RmZHH9; arc=none smtp.client-ip=209.85.219.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="T3RmZHH9"
Received: by mail-qv1-f99.google.com with SMTP id 6a1803df08f44-899fb030812so124235886d6.2
        for <virtualization@lists.linux.dev>; Mon, 09 Mar 2026 17:17:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773101832; x=1773706632;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XXx6sN1Xw89vovWYZx/fM1gj3YL15VXYd9/H4L59JUg=;
        b=woxHfTtMtTQ3LG+GSt0iKyYuAMGcNXfAM4HwR1bfNByFzu7jLMoBY93NqSmvZ9u3uK
         0hSzbLA3mLrIynLoi0g8cvxOKrR1SUaAw1ZICruCg24ceg6qvCWl3WmK/X1JwAt3w50d
         rkQzsgUO5MReCPQPyP7vKvysKrvkO2vnWB1Jj0Wum1PxGMWzeZ8+I1fC2JOU6+U0IACA
         ySEcDN9V0MizIhg4kRQZy4TgKdxmXz1wx90tsGCZz7ZdJbCA1kAh4UgMql8bvIbJPICL
         KE3BSFwnXERsDwcT8Op9zQq6nAwqOem6bIYsJQu3IF5R1tVHqYuUzLzGbqS+dyGpFeNU
         3F3Q==
X-Forwarded-Encrypted: i=1; AJvYcCXKhkgSkXgM2IlnYBYsIbnQISOJ02PdsiB+qO/U/X1yTIkTls4bdFtSMji0NIA92ceQ6lpmpEmhv5OmgpR5Yg==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywp5dziTBnYOez/QFnzhYbsItcSe/yVPqsQGrMSqiBialnNyccU
	mFAo2/r/bZ/jLAsbDvd1TGgtmOfXNWuC5gRCZvvC5MTvCTg0TgR3KA6x6T5xWWpvUjDHkvPrl5H
	eFJgrMOlrSMMLZjEXsd/2JK7X5i2uijOkIkGJUoLeRhEpQBpWMuJOHktloomDgbeR1k+kUTLElt
	2/d/UJIAOxhJV/8xV59n/ehXBrplV92yS0ekg40VXu+8PvqRGfoQTfq3JDyVQxzYvmrOH/F3s9H
	fC1mdHo4Z0lKWOn0PKj+K4zxw==
X-Gm-Gg: ATEYQzweLxcJafIFJMAHjVbhwX7uU5X4IpirgQMiCUEvV9MwKquidI2ZkzS11UlF82r
	JLTUePMc9C81S2lYMpcU+hysVprue5zFqlGnjjXFvw5dT8kDxzj4yUpCfrACFp8x61lhVuVtIBq
	+TmNH7WtHVp0BjLwwVMNeh41T8dylIn67YW+KZF8KLlbpODTiaS7TZYuOq1S6tLSr6x6nrxrPV0
	KBh9vGaLR30sUajfTzeihzBwfSJNdkKeKPGZBEkmqif+BoKLu/0CHh8Eoz2VUJfg8ORjlqOt8YS
	qkDqhGT0GSkKpVWsuhzqFdrtDU/ljk2z2gDSZieQlEJjxGn5wFYzlf8jrlT0LWRbJuHdIAtiWTH
	n/Xkg+IXFkNpKKAiLxSW59W6zTAKEKC0DbQg16TVlgaDsHD9j6MjU+k5TyzDK0QiUuYO38uDxAN
	U1yWfGqGKRwJzcvvZcy8vLOIRk8N8eOj3z0IsWCY4TuFlfemfmRkIBJw/MYjOi1bA=
X-Received: by 2002:a05:6214:2604:b0:89a:b9f:f804 with SMTP id 6a1803df08f44-89a30c16003mr188029546d6.66.1773101832423;
        Mon, 09 Mar 2026 17:17:12 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-117.dlp.protect.broadcom.com. [144.49.247.117])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-89a57be623csm1438686d6.30.2026.03.09.17.17.12
        for <virtualization@lists.linux.dev>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Mar 2026 17:17:12 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-2bdf75bc88fso9901138eec.0
        for <virtualization@lists.linux.dev>; Mon, 09 Mar 2026 17:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1773101831; x=1773706631; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XXx6sN1Xw89vovWYZx/fM1gj3YL15VXYd9/H4L59JUg=;
        b=T3RmZHH9smnrVbZFaRSQ2+Q1gzU83nQ5LCwGCV38bnOS0EbsbiHxNVrRRKsP+OrtZb
         l+jsWhFrcQVrwCX3dyRFZFyVGqPD4ch9U2ftKPctUNhqjPupKnm0CSpTXOQrf/4MPTK9
         9/352NMVFbYat8U+qsFKLOywmJs0vGTcgMR6Q=
X-Forwarded-Encrypted: i=1; AJvYcCWuJ4XwQFXvFzRNv7tOa4xgtauAOwjGUnS3rYnGHUruh0yRnZoQfpgbZWy2tU3m7mtFhf/uALjCJEt4h9aCFw==@lists.linux.dev
X-Received: by 2002:a05:7300:a887:b0:2a4:3593:466c with SMTP id 5a478bee46e88-2be4de8e1cdmr5614039eec.8.1773101831119;
        Mon, 09 Mar 2026 17:17:11 -0700 (PDT)
X-Received: by 2002:a05:7300:a887:b0:2a4:3593:466c with SMTP id 5a478bee46e88-2be4de8e1cdmr5614014eec.8.1773101830462;
        Mon, 09 Mar 2026 17:17:10 -0700 (PDT)
Received: from amakhalov-build-vm.. ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2be4f948324sm12678991eec.17.2026.03.09.17.17.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 17:17:10 -0700 (PDT)
From: Alexey Makhalov <alexey.makhalov@broadcom.com>
To: x86@kernel.org,
	virtualization@lists.linux.dev,
	bp@alien8.de,
	hpa@zytor.com,
	dave.hansen@linux.intel.com,
	mingo@redhat.com,
	tglx@linutronix.de
Cc: ajay.kaher@broadcom.com,
	brennan.lamoreaux@broadcom.com,
	bo.gan@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com,
	linux-kernel@vger.kernel.org,
	kas@kernel.org,
	rick.p.edgecombe@intel.com,
	linux-coco@lists.linux.dev,
	Alexey Makhalov <alexey.makhalov@broadcom.com>
Subject: [PATCH v2 2/4] x86/vmware: Log kmsg dump on panic
Date: Mon,  9 Mar 2026 23:52:48 +0000
Message-ID: <20260309235250.2611115-3-alexey.makhalov@broadcom.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260309235250.2611115-1-alexey.makhalov@broadcom.com>
References: <20260307004238.1181299-1-alexey.makhalov@broadcom.com>
 <20260309235250.2611115-1-alexey.makhalov@broadcom.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

Improve debugability of VMware Linux guests by dumping
kernel messages during a panic to VM log file (vmware.log).

Co-developed-by: Bo Gan <bo.gan@broadcom.com>
Signed-off-by: Bo Gan <bo.gan@broadcom.com>
Signed-off-by: Alexey Makhalov <alexey.makhalov@broadcom.com>
---
 arch/x86/include/asm/vmware.h |   1 +
 arch/x86/kernel/cpu/vmware.c  | 132 ++++++++++++++++++++++++++++++++++
 2 files changed, 133 insertions(+)

diff --git a/arch/x86/include/asm/vmware.h b/arch/x86/include/asm/vmware.h
index 6a084e088b30..c23164503e54 100644
--- a/arch/x86/include/asm/vmware.h
+++ b/arch/x86/include/asm/vmware.h
@@ -93,6 +93,7 @@
 #define VMWARE_HYPERVISOR_MAGIC		0x564d5868U
 
 #define VMWARE_CMD_GETVERSION		10
+#define VMWARE_CMD_MESSAGE		30
 #define VMWARE_CMD_GETHZ		45
 #define VMWARE_CMD_GETVCPU_INFO		68
 #define VMWARE_CMD_STEALCLOCK		91
diff --git a/arch/x86/kernel/cpu/vmware.c b/arch/x86/kernel/cpu/vmware.c
index 93acd3414e37..9955f2ea0c84 100644
--- a/arch/x86/kernel/cpu/vmware.c
+++ b/arch/x86/kernel/cpu/vmware.c
@@ -30,6 +30,7 @@
 #include <linux/reboot.h>
 #include <linux/static_call.h>
 #include <linux/sched/cputime.h>
+#include <linux/kmsg_dump.h>
 #include <asm/div64.h>
 #include <asm/x86_init.h>
 #include <asm/hypervisor.h>
@@ -211,6 +212,13 @@ static unsigned long vmware_get_tsc_khz(void)
 	return vmware_tsc_khz;
 }
 
+static void kmsg_dumper_vmware_log(struct kmsg_dumper *dumper,
+				   struct kmsg_dump_detail *detail);
+
+static struct kmsg_dumper kmsg_dumper = {
+	.dump = kmsg_dumper_vmware_log
+};
+
 #ifdef CONFIG_PARAVIRT
 static struct cyc2ns_data vmware_cyc2ns __ro_after_init;
 static bool vmw_sched_clock __initdata = true;
@@ -535,6 +543,8 @@ static void __init vmware_platform_setup(void)
 #endif
 
 	vmware_set_capabilities();
+
+	kmsg_dump_register(&kmsg_dumper);
 }
 
 static u8 __init get_hypercall_mode(void)
@@ -630,3 +640,125 @@ const __initconst struct hypervisor_x86 x86_hyper_vmware = {
 	.runtime.sev_es_hcall_finish	= vmware_sev_es_hcall_finish,
 #endif
 };
+
+#define VMWARE_HB_CMD_MESSAGE	0
+#define MESSAGE_STATUS_SUCCESS	(0x01 << 16)
+#define MESSAGE_STATUS_CPT	(0x10 << 16)
+#define MESSAGE_STATUS_HB	(0x80 << 16)
+
+#define RPCI_PROTOCOL_NUM	0x49435052 /* 'RPCI' */
+#define GUESTMSG_FLAG_COOKIE	0x80000000
+
+#define MESSAGE_TYPE_OPEN	(0 << 16)
+#define MESSAGE_TYPE_SENDSIZE	(1 << 16)
+#define MESSAGE_TYPE_SEND	(2 << 16)
+#define MESSAGE_TYPE_CLOSE	(6 << 16)
+
+struct vmw_msg {
+	u32 id;
+	u32 cookie_high;
+	u32 cookie_low;
+};
+
+static int
+vmware_log_open(struct vmw_msg *msg)
+{
+	u32 info;
+
+	vmware_hypercall6(VMWARE_CMD_MESSAGE | MESSAGE_TYPE_OPEN,
+			  RPCI_PROTOCOL_NUM | GUESTMSG_FLAG_COOKIE,
+			  0, &info, &msg->id, &msg->cookie_high,
+			  &msg->cookie_low);
+
+	if ((info & MESSAGE_STATUS_SUCCESS) == 0)
+		return 1;
+
+	msg->id &= 0xffff0000UL;
+	return 0;
+}
+
+static int
+vmware_log_close(struct vmw_msg *msg)
+{
+	u32 info;
+
+	vmware_hypercall5(VMWARE_CMD_MESSAGE | MESSAGE_TYPE_CLOSE, 0, msg->id,
+			  msg->cookie_high, msg->cookie_low, &info);
+
+	if ((info & MESSAGE_STATUS_SUCCESS) == 0)
+		return 1;
+	return 0;
+}
+
+static int
+vmware_log_send(struct vmw_msg *msg, const char *string)
+{
+	u32 info;
+	u32 len = strlen(string);
+
+retry:
+	vmware_hypercall5(VMWARE_CMD_MESSAGE | MESSAGE_TYPE_SENDSIZE, len,
+			  msg->id, msg->cookie_high, msg->cookie_low, &info);
+
+	if (!(info & MESSAGE_STATUS_SUCCESS))
+		return 1;
+
+	/* HB port can't access encrypted memory. */
+	if (!cc_platform_has(CC_ATTR_MEM_ENCRYPT) && (info & MESSAGE_STATUS_HB)) {
+		vmware_hypercall_hb_out(
+			VMWARE_HB_CMD_MESSAGE | MESSAGE_STATUS_SUCCESS,
+			len, msg->id, (uintptr_t) string, msg->cookie_low,
+			msg->cookie_high, &info);
+	} else {
+		do {
+			u32 word;
+			size_t s = min_t(u32, len, sizeof(word));
+
+			memcpy(&word, string, s);
+			len -= s;
+			string += s;
+
+			vmware_hypercall5(VMWARE_CMD_MESSAGE | MESSAGE_TYPE_SEND,
+					  word, msg->id, msg->cookie_high,
+					  msg->cookie_low, &info);
+		} while (len && (info & MESSAGE_STATUS_SUCCESS));
+	}
+
+	if ((info & MESSAGE_STATUS_SUCCESS) == 0) {
+		if (info & MESSAGE_STATUS_CPT)
+			/* A checkpoint occurred. Retry. */
+			goto retry;
+		return 1;
+	}
+	return 0;
+}
+STACK_FRAME_NON_STANDARD(vmware_log_send);
+
+/*
+ * kmsg_dumper_vmware_log - dumps kmsg to vmware.log file on the host
+ */
+static void kmsg_dumper_vmware_log(struct kmsg_dumper *dumper,
+				   struct kmsg_dump_detail *detail)
+{
+	struct vmw_msg msg;
+	struct kmsg_dump_iter iter;
+	static char line[1024];
+	size_t len = 0;
+
+	/* Line prefix to send to VM log file. */
+	line[0] = 'l';
+	line[1] = 'o';
+	line[2] = 'g';
+	line[3] = ' ';
+
+	kmsg_dump_rewind(&iter);
+	while (kmsg_dump_get_line(&iter, true, line + 4, sizeof(line) - 4,
+				  &len)) {
+		line[len + 4] = '\0';
+		if (vmware_log_open(&msg))
+			return;
+		if (vmware_log_send(&msg, line))
+			return;
+		vmware_log_close(&msg);
+	}
+}
-- 
2.43.7

