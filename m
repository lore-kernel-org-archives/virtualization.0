Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.100
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794203284;
	b=RrsDrsqiaD1w7/BsqZ4yb2FT6Un+4mUa6/jQAUDSj0PzRlAP+2kjwhS+VMnmZs5BVAT7
	 cTk0BLu3JFm2hqTzz/fvwqBXT3DKrZq5z7ecjMlSUbzotIUvJu4WrYuNSgxDdsiSiOINY
	 kyNi2V7wb6xFD8up38kvJV3JxR8IgsI1Ksvb1KtPZ0sgh153fKhsnsj57kAtW7+dCv1+d
	 iGc9us95g3PcE4R5t50nGvltYoenqgZtKqRCyHg2fIBHPkqd9bBj3HXc6+ugect4I6NqN
	 jxbTseO1DqZAq/h1QG4F9OHJd4s7oz0XMlzfR1DMl2zhjBp/eJOXpYbbn7WtksDli5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794203284;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 X-CFilter-Loop:Received:DKIM-Signature:X-Forwarded-Encrypted:
	 X-Received:X-Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-DetectorID-Processed;
	bh=fCikukdkGrAry2ag7Gz1Hec9v7vR97JxYrqyoEYaoh0=;
	b=WlHKReAQtATHR7YT2FctFAZQa4fTUzlok86D+TxzgpYnSbJZkQpaAQxK22UJDreS/stE
	 +niA2hl3p8nK0NhGtnW2ocyQokfbXTw4erNFQ72LOT5Bl652Vl/SY7EqXuzN9nXi5hSE3
	 icC2D3NKM+JIB3uNHqrDWzojbeqN0k3EcpqCOSt1up+f48Wutz9Pl8WoY2+W0l7fd4kC4
	 LuQ8YxvoKNNaYMcG3L7TbGOQpqcMHxEV0HpXDzgJIdNC2dH1JgUzRXUnAsJVkHu1Olmju
	 9rNqfRwGhBYfdCRWhA0lwfqU/1qvXJdQIMB3GriJfNB5w6oi6iZVbk/BSgLah5XV71g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=PrnPf2qX;
	arc=none smtp.remote-ip=209.85.216.100
Received: from mail-pj1-f100.google.com (mail-pj1-f100.google.com [209.85.216.100])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E4AC606A33A
	for <virtualization@lists.linux.dev>; Mon,  9 Nov 2026 05:48:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2E4AC606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=PrnPf2qX
Received: by mail-pj1-f100.google.com with SMTP id 98e67ed59e1d1-3b155f50c24so33024a91.3
        for <virtualization@lists.linux.dev>; Sun, 08 Nov 2026 21:48:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794203283; x=1794808083;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fCikukdkGrAry2ag7Gz1Hec9v7vR97JxYrqyoEYaoh0=;
        b=I4IaX3A2HV8ROvmP/B4AlBxhIuGo6RCKom3iwG+pvoNpmwJiJrziv9UpB3kf/6a15f
         YSsZwRY85QbWquYHNcvSN9Wdl/8+YJFd+yxV4WqanBtzpL+hARgM0L+6VHV4m+zJp460
         PMqdFPZz3vbHzG59GEnnmfzNa+wsPaPLKMT2k0oQkZVcCetYHFY5/zNi56lq0MA8gWl2
         mw9w7n8Iw70ZN3kjgtwrCnvH9qoxo7hkkaPILf0nFx67F9aU1SBCFMP0ml7LZhwm4tE6
         MpctpacTE514hI2wrliidRJclgxd/J/+XZZwRfijgROzIvqeYc5UuO4GNMjDp/SSRnQr
         pGHg==
X-Forwarded-Encrypted: i=1; AL+hErFUzKhJHIZUqDi5cUCWt+JUC+8dNOfc0fp3P6xIlCXWe6bJw/TI+UpX0I8EBNA0IcRkHt1DwX4jlnIgqhYIaw==@lists.linux.dev
X-Gm-Message-State: APuU4Z8IXMx+FHEFXtB4KjLBjy+BJ9X7GLjbDi7Hu4A+IPphQ+ml39rb
	uLVXHIIiunFOf2uJ5gpPPwtUhku/efUkzLIX41aBXvvXY4VuGsmJf0RH3RzK7p2yLIK0g9aCM4S
	aK939rI/hKFdgda1sGoBDt0sE1xt49qOIh64WYVlprxn+iBx8DecFosmFocxrj80IpOxQ6viJQ8
	wj2q91wEZoV0ryI1lEEHsTiC0jXS3EmxpVH5DZnoMrDV5U31R5ZxsiXBLuGkeRtHjoWtQZmZMj0
	4cD+OXPhO2h9FNahDc=
X-Gm-Gg: AYBFou2rdXOsKyA1+JeoI/ERd/2+3Kmaud9sFtGHjK3zWGkTmIw4EOzRJkxQARHgJyM
	ZiHI/UGn9E1yWzbYrvu2ZNKStVaM348xVwchk8FDaFfEViJt3Y+ZOkhY0FPsABSHpust+pW1kBQ
	w/nTRrgdaU2FXNzKUPcEOkEP3L+2irTAvW21UsMztX1srLWCqn6E9JiUv0D4Y5Zq9G6irzbr0CS
	C6OHsIrLAVmVzNfhVS76O3fSPaZPep1i72hQzqDQbfflAXqEm/HI/N0hFAHNpiEXw5WEPoHS7yd
	ZNr2LAdwSkAJNdp1x4QnMC/XVojITpQNYxgCkGpNI+D3wuVm0hyc0m7kyG7HhT2RHI4bl3y5t5s
	PSJkRh98f7nautUyu2rstO54WyaG5hf3IxYmWFeRCGg+7j+QZqx5tiCibzriBKVXpHcRDTgURoQ
	jcUpJEsGhj1vwJnJf9sBKM7hry5GahtRl0
X-Received: by 2002:a17:90b:1c8f:b0:3b0:9ebf:3ef9 with SMTP id 98e67ed59e1d1-3b12cb4e07amr3004483a91.0.1794203283453;
        Sun, 08 Nov 2026 21:48:03 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-13.dlp.protect.broadcom.com. [144.49.247.13])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3b1057b2d31sm4848536a91.1.2026.11.08.21.48.02
        for <virtualization@lists.linux.dev>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 Nov 2026 21:48:03 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dl1-f70.google.com with SMTP id a92af1059eb24-154e9d2d94fso413860c88.0
        for <virtualization@lists.linux.dev>; Sun, 08 Nov 2026 21:48:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1794203281; x=1794808081; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fCikukdkGrAry2ag7Gz1Hec9v7vR97JxYrqyoEYaoh0=;
        b=PrnPf2qXQ5mwBhhqdOM7OQ7NytQWZNR+ynR8YVe++h+LhnTDVfYxvMoH1dyAumXDlQ
         gq8SprQxyZKnw7I9OaOg3vZwEARH2Z2KpcBJTl7k/8ng+4WpUEY1D3QN3UOjSs4H/92g
         VE1j/eUjxw2qMDbxXGiZIV1734Yh8Xtzln8to=
X-Forwarded-Encrypted: i=1; AL+hErHRvKJclT12c5rVu9Np/0GW0ssP5Ur6es9txWlz/u3qkpPee42KNlEnxCTzS0lzOERcfVyasHdNwOeq285rNA==@lists.linux.dev
X-Received: by 2002:a05:7022:b052:20b0:1ae:abd0:e2b6 with SMTP id a92af1059eb24-1b39ff033c5mr5293298c88.38.1794203281075;
        Sun, 08 Nov 2026 21:48:01 -0800 (PST)
X-Received: by 2002:a05:7022:b052:20b0:1ae:abd0:e2b6 with SMTP id a92af1059eb24-1b39ff033c5mr5293257c88.38.1794203280452;
        Sun, 08 Nov 2026 21:48:00 -0800 (PST)
Received: from vertex.localdomain (pool-173-49-113-140.phlapa.fios.verizon.net. [173.49.113.140])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b37314626dsm13745136c88.1.2026.11.08.21.47.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 21:47:59 -0800 (PST)
From: Zack Rusin <zack.rusin@broadcom.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Petr Mladek <pmladek@suse.com>,
	Baoquan He <baoquan.he@linux.dev>,
	Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Dave Young <ruirui.yang@linux.dev>
Cc: Borislav Petkov <bp@alien8.de>,
	Ajay Kaher <ajay.kaher@broadcom.com>,
	Alexey Makhalov <alexey.makhalov@broadcom.com>,
	x86@kernel.org,
	Joel Granados <joel.granados@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	virtualization@lists.linux.dev,
	bcm-kernel-feedback-list@broadcom.com,
	linux-kernel@vger.kernel.org,
	John Ogness <john.ogness@linutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Kees Cook <kees@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Bo Gan <bo.gan@broadcom.com>,
	Brennan Lamoreaux <brennan.lamoreaux@broadcom.com>,
	kexec@lists.infradead.org,
	linux-doc@vger.kernel.org,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	Maaz Mombasawala <maaz.mombasawala@broadcom.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Stephen Brennan <stephen.s.brennan@oracle.com>,
	Michael Kelley <mhklinux@outlook.com>,
	Ian Forbes <ian.forbes@broadcom.com>,
	Bradley Morgan <brads@mainlining.org>
Subject: [PATCH v3 2/4] x86/vmware: Add a bounded panic log sender
Date: Mon,  9 Nov 2026 00:47:38 -0500
Message-ID: <b4befd89cc0b5844f499606b7d42f13cdb37046a.1794201807.git.zack.rusin@broadcom.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1794201807.git.zack.rusin@broadcom.com>
References: <cover.1794201807.git.zack.rusin@broadcom.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

A VMware guest may be unable to save its own logs after a crash. Copy
the newest kernel log records to the host's vmware.log before kdump,
so they remain available if the capture kernel fails.

Register the sender on the platform panic notifier list and send the
log through the low-bandwidth register interface. Allocate a fixed
8 KiB buffer during early init; 4 KiB can lose useful stack-trace
context. The callback allocates no memory and emits no printk
messages. Limit the transfer to the buffer size and make at most three
attempts, retrying only if a VM checkpoint interrupts the transfer.

Enable logging by default only in guests without memory encryption;
encrypted guests should send their log to the host only when an
administrator opts in. The copy is best-effort diagnostics; kdump does
not depend on it succeeding.

Suggested-by: Michael Kelley <mhklinux@outlook.com>
Link: https://lore.kernel.org/r/SN6PR02MB41574A11D309A0530C63E0FED4842@SN6PR02MB4157.namprd02.prod.outlook.com
Link: https://lore.kernel.org/r/20260309235250.2611115-3-alexey.makhalov@broadcom.com
Co-developed-by: Bo Gan <bo.gan@broadcom.com>
Signed-off-by: Bo Gan <bo.gan@broadcom.com>
Co-developed-by: Alexey Makhalov <alexey.makhalov@broadcom.com>
Signed-off-by: Alexey Makhalov <alexey.makhalov@broadcom.com>
Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
---
v3: Register on the platform list instead of the pre-kdump list. The
VMware code is otherwise unchanged from v2.

 arch/x86/include/asm/vmware.h |   1 +
 arch/x86/kernel/cpu/vmware.c  | 173 ++++++++++++++++++++++++++++++++++
 2 files changed, 174 insertions(+)

diff --git a/arch/x86/include/asm/vmware.h b/arch/x86/include/asm/vmware.h
index 4220dae14a2d..598d4cd448ec 100644
--- a/arch/x86/include/asm/vmware.h
+++ b/arch/x86/include/asm/vmware.h
@@ -57,6 +57,7 @@
 #define VMWARE_HYPERVISOR_MAGIC		0x564d5868U
 
 #define VMWARE_CMD_GETVERSION		10
+#define VMWARE_CMD_MESSAGE		30
 #define VMWARE_CMD_GETHZ		45
 #define VMWARE_CMD_GETVCPU_INFO		68
 #define VMWARE_CMD_STEALCLOCK		91
diff --git a/arch/x86/kernel/cpu/vmware.c b/arch/x86/kernel/cpu/vmware.c
index f7ab9e7902cf..0c6f7248a665 100644
--- a/arch/x86/kernel/cpu/vmware.c
+++ b/arch/x86/kernel/cpu/vmware.c
@@ -24,11 +24,16 @@
 #include <linux/dmi.h>
 #include <linux/init.h>
 #include <linux/export.h>
+#include <linux/kmsg_dump.h>
+#include <linux/mm.h>
+#include <linux/panic_notifier.h>
 #include <linux/clocksource.h>
 #include <linux/cpu.h>
 #include <linux/efi.h>
 #include <linux/reboot.h>
+#include <linux/sizes.h>
 #include <linux/static_call.h>
+#include <linux/wordpart.h>
 #include <linux/sched/cputime.h>
 #include <asm/div64.h>
 #include <asm/x86_init.h>
@@ -52,6 +57,23 @@
 #define STEALCLOCK_DISABLED        0
 #define STEALCLOCK_ENABLED         1
 
+#define VMWARE_MSG_STATUS_SUCCESS	BIT(16)
+#define VMWARE_MSG_STATUS_CPT		BIT(20)
+
+#define VMWARE_RPCI_PROTOCOL		0x49435052
+#define VMWARE_GUESTMSG_COOKIE		BIT(31)
+
+#define VMWARE_MSG_TYPE(n)		((n) << 16)
+#define VMWARE_MSG_OPEN			VMWARE_MSG_TYPE(0U)
+#define VMWARE_MSG_SENDSIZE		VMWARE_MSG_TYPE(1U)
+#define VMWARE_MSG_SENDPAYLOAD		VMWARE_MSG_TYPE(2U)
+#define VMWARE_MSG_CLOSE		VMWARE_MSG_TYPE(6U)
+
+#define VMWARE_LOG_BUF_SIZE		SZ_8K
+#define VMWARE_LOG_ATTEMPTS		3
+#define VMWARE_LOG_PREFIX		"log "
+#define VMWARE_LOG_PREFIX_LEN		(sizeof(VMWARE_LOG_PREFIX) - 1)
+
 struct vmware_steal_time {
 	union {
 		u64 clock;	/* stolen time counter in units of vtsc */
@@ -64,6 +86,12 @@ struct vmware_steal_time {
 	u64 reserved[7];
 };
 
+struct vmware_rpc_channel {
+	u16 id;
+	u32 cookie_high;
+	u32 cookie_low;
+};
+
 static unsigned long vmware_tsc_khz __ro_after_init;
 static u8 vmware_hypercall_mode     __ro_after_init;
 
@@ -142,6 +170,151 @@ static unsigned long vmware_get_tsc_khz(void)
 	return vmware_tsc_khz;
 }
 
+static int vmware_log_open(struct vmware_rpc_channel *channel)
+{
+	u32 info, id;
+
+	vmware_hypercall6(VMWARE_CMD_MESSAGE | VMWARE_MSG_OPEN,
+			  VMWARE_RPCI_PROTOCOL | VMWARE_GUESTMSG_COOKIE, 0,
+			  &info, &id, &channel->cookie_high,
+			  &channel->cookie_low);
+	if (!(info & VMWARE_MSG_STATUS_SUCCESS))
+		return -EIO;
+
+	channel->id = upper_16_bits(id);
+	return 0;
+}
+
+static int vmware_log_close(const struct vmware_rpc_channel *channel)
+{
+	u32 info;
+
+	vmware_hypercall5(VMWARE_CMD_MESSAGE | VMWARE_MSG_CLOSE, 0,
+			  (u32)channel->id << 16, channel->cookie_high,
+			  channel->cookie_low, &info);
+
+	return info & VMWARE_MSG_STATUS_SUCCESS ? 0 : -EIO;
+}
+
+static int vmware_log_send_once(const struct vmware_rpc_channel *channel,
+				const char *buffer, size_t length)
+{
+	u32 info;
+
+	vmware_hypercall5(VMWARE_CMD_MESSAGE | VMWARE_MSG_SENDSIZE, length,
+			  (u32)channel->id << 16, channel->cookie_high,
+			  channel->cookie_low, &info);
+	if (!(info & VMWARE_MSG_STATUS_SUCCESS))
+		return info & VMWARE_MSG_STATUS_CPT ? -EAGAIN : -EIO;
+
+	while (length) {
+		size_t bytes = min_t(size_t, length, sizeof(u32));
+		u32 word = 0;
+
+		memcpy(&word, buffer, bytes);
+		vmware_hypercall5(VMWARE_CMD_MESSAGE | VMWARE_MSG_SENDPAYLOAD,
+				  word, (u32)channel->id << 16,
+				  channel->cookie_high, channel->cookie_low,
+				  &info);
+		if (!(info & VMWARE_MSG_STATUS_SUCCESS))
+			return info & VMWARE_MSG_STATUS_CPT ? -EAGAIN : -EIO;
+
+		buffer += bytes;
+		length -= bytes;
+	}
+
+	return 0;
+}
+
+static int vmware_log_send(const struct vmware_rpc_channel *channel,
+			   const char *buffer, size_t length)
+{
+	int attempt, ret;
+
+	for (attempt = 0; attempt < VMWARE_LOG_ATTEMPTS; attempt++) {
+		ret = vmware_log_send_once(channel, buffer, length);
+		if (ret != -EAGAIN)
+			return ret;
+	}
+
+	return -EAGAIN;
+}
+
+static int vmware_log_rpc(const char *buffer, size_t length)
+{
+	struct vmware_rpc_channel channel;
+	int close_ret, ret;
+
+	ret = vmware_log_open(&channel);
+	if (ret)
+		return ret;
+
+	ret = vmware_log_send(&channel, buffer, length);
+	close_ret = vmware_log_close(&channel);
+	if (!ret && close_ret)
+		ret = close_ret;
+
+	return ret;
+}
+
+static struct page *vmware_panic_page;
+static bool vmware_record_panic_msg;
+
+static int vmware_panic_log_notify(struct notifier_block *nb,
+				   unsigned long action, void *data)
+{
+	struct kmsg_dump_iter iter;
+	char *buffer = page_address(vmware_panic_page);
+	size_t length = 0;
+
+	if (!READ_ONCE(vmware_record_panic_msg))
+		return NOTIFY_DONE;
+
+	memcpy(buffer, VMWARE_LOG_PREFIX, VMWARE_LOG_PREFIX_LEN);
+	kmsg_dump_rewind(&iter);
+	(void)kmsg_dump_get_buffer(&iter, true,
+				   buffer + VMWARE_LOG_PREFIX_LEN,
+				   VMWARE_LOG_BUF_SIZE - VMWARE_LOG_PREFIX_LEN,
+				   &length);
+	(void)vmware_log_rpc(buffer, length + VMWARE_LOG_PREFIX_LEN);
+
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block vmware_panic_log_nb = {
+	.notifier_call = vmware_panic_log_notify,
+};
+
+static int __init vmware_panic_log_init(void)
+{
+	int ret;
+
+	if (!IS_ENABLED(CONFIG_PRINTK) ||
+	    !hypervisor_is_type(X86_HYPER_VMWARE))
+		return 0;
+
+	vmware_record_panic_msg =
+		!cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT);
+
+	vmware_panic_page = alloc_pages(GFP_KERNEL,
+					get_order(VMWARE_LOG_BUF_SIZE));
+	if (!vmware_panic_page) {
+		pr_err("failed to allocate panic log buffer\n");
+		return 0;
+	}
+
+	ret = atomic_notifier_chain_register(&panic_notifiers_platform_list,
+					     &vmware_panic_log_nb);
+	if (ret) {
+		pr_err("failed to register panic log notifier: %d\n", ret);
+		__free_pages(vmware_panic_page, get_order(VMWARE_LOG_BUF_SIZE));
+		vmware_panic_page = NULL;
+	}
+
+	return 0;
+}
+early_initcall(vmware_panic_log_init);
+
 #ifdef CONFIG_PARAVIRT
 static struct cyc2ns_data vmware_cyc2ns __ro_after_init;
 static bool vmw_sched_clock __initdata = true;
