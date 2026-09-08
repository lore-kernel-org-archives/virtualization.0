Received: from mail-pg1-f226.google.com (mail-pg1-f226.google.com [209.85.215.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15D4D313E31
	for <virtualization@lists.linux.dev>; Tue,  8 Sep 2026 18:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788891343; cv=none; b=Vr7aLNMmww8DFSK3Ib1IrHGXjVu20+pHro0seQrS8fdW1HePZpXPdFNf685+UOobbVNElz/BAMq35U+BfSyhFAy/kmMS8PFBeymjsI6FCTJ1bc7rDMIRERzcT28Dwp5NAG+wAUqSXnQ38h3DXlJ4j+dqAWp74KTrpnYmYLHY8Hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788891343; c=relaxed/simple;
	bh=Mvcs9Lt0sPQOGP5yNJDCK3xofsCRtXPW55QU80iioj4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ApGx67z74wx3/kelfUXQcPEVk6La1SMGZcxQQ68ID1YDG1+ruc1A7TWLF1tjzrBOEFc5Piud8/06vgM/kNmqWXLMn3kM4Bb4C2fmDQxyygx9dTiY6SNj6Pfp8D0WR4zki0hpuMKZ9Enh7R9GJK6nmDCobAwFONi6AnlylL149Yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=XKhYgpxR; arc=none smtp.client-ip=209.85.215.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="XKhYgpxR"
Received: by mail-pg1-f226.google.com with SMTP id 41be03b00d2f7-cc147d86bebso4016730a12.0
        for <virtualization@lists.linux.dev>; Tue, 08 Sep 2026 11:15:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788891340; x=1789496140;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aIZhE29+oVPTSBZvjxk3RWug8DvHvEXFsH8XGpUQx0Y=;
        b=BcH46wU3o8rm/lK1YuN/MJfxh1NvAsAEfNvXDC6msqmUciHykcyGFNe0GGAlB7vgtH
         XS6wCen941L0v7HwlJ16R+KALRAN4JDnrcTekfw7y02KL2NhG96uAW0+A8GYM6I9qUOy
         J1JdZp8BERtFTVGoCEWrMP5CtZbRfv8DTqC+B7vkqpwiRdFiXY5IRD5CKYM1m0I1oWT6
         oIMC8M7jBfTlQ/CpUTe1N6x74XNOEzuajMAtDmCYtY513Yfy7qN+QYBEGVqahAgMyQcf
         3OfXJo6dQ63vWvaBtPfSFXLEiTnWftnaSuhgF0uEoPoT8e97TmtyjjuGOjmywy19ynrT
         fDsw==
X-Forwarded-Encrypted: i=1; AKwUvBzTRGX/rtciPL+0rKXrB5towjkwghL6oYOKHrMDSbkq9dz44G+tzdwHyHfPSawICRKAFU/Kbo+1BDIT2xNAnQ==@lists.linux.dev
X-Gm-Message-State: AFuF++nuQpYF1/aDHrqFfH1Z7S1JNzeh+nwtOj5hW7jVekl/ov7d7EE6
	jhha4fZ9hlow9HUsbWkCqbrNgoA83oHSENoeu6z3Grl0WDVVjeoaRBa/oe3KqQl6pl+ISO76IT2
	xxilHsiKtxxKOLzgOSVxR0ZAvaq8b/cngvyS1w4TSm86dIlo0sVhfiYfMlxQ0yoNwiHJYb4ber7
	OmTtna2a0jRJIrKeA2EzASXCgGcsGq/Bj4iMVHVfjIQA78lnZYFK6fzesTN4FBINzQvWtxh8BIa
	zd9sD0NBqXTDwq2WjQ=
X-Gm-Gg: AYBFou0h+i8/e4pUUEm56IuOq5ilBSLoMkC8/xSxK17VkqD+zBAV39YtuJ58CxKK6xl
	cUOMyzxrGzJ5uLf9HaKU7xLtXDmYpP/NNBhaJLXyEm/tuXzIB7/STudB3bzg3yzLi6cE2JFH178
	vMMKCeP95DhMIwKJFWwpr9Ee9XN9UQID88Pe3EpvMyBIl86VPaacVKg7q5jW5EdW3M9rONZLMdi
	pRSX9McWuiwCtvST9VI/9j1b1AsBbG9XkvHvABkea2yj1m3iw6tz/QnpPxz2zKFxiKfBUJbubyq
	Al+ax2PUkRI5XrYPFjdAjhVkYAAHR85wuAbwbD9LogiDbwhh9meEjW1ykUehlAy9dQmTORHQldb
	F4+QALKYYInKw28alBDhZFgqfl+nL3Pvh1NC9z5lXTFJZwBbPiVAVefmtTuMY+LmzBUQYgDB1Mc
	McfzaKeJLEgWMHLjpKNrU8mQA/9VXyPcLv
X-Received: by 2002:a17:90b:4ad1:b0:38f:657:6823 with SMTP id 98e67ed59e1d1-39b8bd997f7mr6261025a91.8.1788891339944;
        Tue, 08 Sep 2026 11:15:39 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-25.dlp.protect.broadcom.com. [144.49.247.25])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-39ae9071bd5sm2138629a91.4.2026.09.08.11.15.39
        for <virtualization@lists.linux.dev>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Sep 2026 11:15:39 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-91054f537f9so46222916d6.0
        for <virtualization@lists.linux.dev>; Tue, 08 Sep 2026 11:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1788891336; x=1789496136; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aIZhE29+oVPTSBZvjxk3RWug8DvHvEXFsH8XGpUQx0Y=;
        b=XKhYgpxRPH1uYXoh93vZE+ELxV5J0kTbpvDC/3RcSyh7GSQeKIzInPO4sssuQdrTo2
         4Bkjz3e/v7Tjm71YB48eIUkqTYFp1utChfJetRYVQKlhoCwz0Ugbae4w8gd1YJgXoHs+
         dawT11en1FLtTx3SoylKHE0IGObXUEBEAErg8=
X-Forwarded-Encrypted: i=1; AKwUvBxoBPz+1xnMVLZ5ktEd35J8rKIt0YX0wRbt8AVNX7Uzr6KCiCNGMmo948naV3q6nMY2CBFXLCkavChU1ohGAA==@lists.linux.dev
X-Received: by 2002:a0c:e003:0:b0:910:69e3:2983 with SMTP id 6a1803df08f44-91069e33187mr23819446d6.5.1788890849425;
        Tue, 08 Sep 2026 11:07:29 -0700 (PDT)
X-Received: by 2002:a0c:e003:0:b0:910:69e3:2983 with SMTP id 6a1803df08f44-91069e33187mr23818676d6.5.1788890848717;
        Tue, 08 Sep 2026 11:07:28 -0700 (PDT)
Received: from vertex.localdomain (pool-173-49-113-140.phlapa.fios.verizon.net. [173.49.113.140])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9106412e038sm27114866d6.20.2026.09.08.11.07.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 11:07:27 -0700 (PDT)
From: Zack Rusin <zack.rusin@broadcom.com>
To: Borislav Petkov <bp@alien8.de>,
	Ajay Kaher <ajay.kaher@broadcom.com>,
	Alexey Makhalov <alexey.makhalov@broadcom.com>,
	x86@kernel.org,
	Petr Mladek <pmladek@suse.com>,
	Joel Granados <joel.granados@kernel.org>,
	Baoquan He <baoquan.he@linux.dev>
Cc: Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	virtualization@lists.linux.dev,
	bcm-kernel-feedback-list@broadcom.com,
	linux-kernel@vger.kernel.org,
	John Ogness <john.ogness@linutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Kees Cook <kees@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Dave Young <ruirui.yang@linux.dev>,
	Jonathan Corbet <corbet@lwn.net>,
	Bo Gan <bo.gan@broadcom.com>,
	Brennan Lamoreaux <brennan.lamoreaux@broadcom.com>,
	kexec@lists.infradead.org,
	linux-doc@vger.kernel.org,
	Zack Rusin <zack.rusin@broadcom.com>
Subject: [PATCH v1 1/4] x86/vmware: Add a bounded panic log sender
Date: Tue,  8 Sep 2026 14:07:13 -0400
Message-ID: <18115e519d85b753c147b45470120721eaf14505.1788414671.git.zack.rusin@broadcom.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1788414671.git.zack.rusin@broadcom.com>
References: <cover.1788414671.git.zack.rusin@broadcom.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

A virtual machine may have no guest-local persistent storage or working
userspace after a panic. Preserve the newest kernel log tail in the host
vmware.log, which remains available after the VM terminates.

Allocate one page during early init and register a panic-only kmsg dumper.
Copy the newest records once, prefix them with "log ", and send one
explicit-length RPC message over the low-bandwidth register path. The page
limit bounds panic-time work and avoids sharing guest memory with the host.

Keep the source immutable for up to three attempts. Retry only checkpoint
responses, zero-fill a short final word, and close the single RPC channel
on every exit after open. The panic callback allocates nothing, does not
sleep, and emits no printk messages.

Free the page and leave panic logging disabled if dumper registration
fails, including when CONFIG_PRINTK=n.

Link: https://lore.kernel.org/r/20260309235250.2611115-3-alexey.makhalov@broadcom.com
Co-developed-by: Bo Gan <bo.gan@broadcom.com>
Signed-off-by: Bo Gan <bo.gan@broadcom.com>
Co-developed-by: Alexey Makhalov <alexey.makhalov@broadcom.com>
Signed-off-by: Alexey Makhalov <alexey.makhalov@broadcom.com>
Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
---
 arch/x86/include/asm/vmware.h |   1 +
 arch/x86/kernel/cpu/vmware.c  | 158 ++++++++++++++++++++++++++++++++++
 2 files changed, 159 insertions(+)

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
index 34b73573b108..bf59653d6e07 100644
--- a/arch/x86/kernel/cpu/vmware.c
+++ b/arch/x86/kernel/cpu/vmware.c
@@ -24,11 +24,14 @@
 #include <linux/dmi.h>
 #include <linux/init.h>
 #include <linux/export.h>
+#include <linux/kmsg_dump.h>
+#include <linux/mm.h>
 #include <linux/clocksource.h>
 #include <linux/cpu.h>
 #include <linux/efi.h>
 #include <linux/reboot.h>
 #include <linux/static_call.h>
+#include <linux/wordpart.h>
 #include <linux/sched/cputime.h>
 #include <asm/div64.h>
 #include <asm/x86_init.h>
@@ -52,6 +55,22 @@
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
+#define VMWARE_LOG_ATTEMPTS		3
+#define VMWARE_LOG_PREFIX		"log "
+#define VMWARE_LOG_PREFIX_LEN		(sizeof(VMWARE_LOG_PREFIX) - 1)
+
 struct vmware_steal_time {
 	union {
 		u64 clock;	/* stolen time counter in units of vtsc */
@@ -64,6 +83,12 @@ struct vmware_steal_time {
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
 
@@ -142,6 +167,139 @@ static unsigned long vmware_get_tsc_khz(void)
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
+
+static void vmware_panic_log_dump(struct kmsg_dumper *dumper,
+				  struct kmsg_dump_detail *detail)
+{
+	struct kmsg_dump_iter iter;
+	char *buffer = page_address(vmware_panic_page);
+	size_t length = 0;
+
+	memcpy(buffer, VMWARE_LOG_PREFIX, VMWARE_LOG_PREFIX_LEN);
+	kmsg_dump_rewind(&iter);
+	(void)kmsg_dump_get_buffer(&iter, true,
+				   buffer + VMWARE_LOG_PREFIX_LEN,
+				   PAGE_SIZE - VMWARE_LOG_PREFIX_LEN, &length);
+	(void)vmware_log_rpc(buffer, length + VMWARE_LOG_PREFIX_LEN);
+}
+
+static struct kmsg_dumper vmware_panic_log_dumper = {
+	.dump = vmware_panic_log_dump,
+	.max_reason = KMSG_DUMP_PANIC,
+};
+
+static int __init vmware_panic_log_init(void)
+{
+	int ret;
+
+	if (!hypervisor_is_type(X86_HYPER_VMWARE))
+		return 0;
+
+	vmware_panic_page = alloc_page(GFP_KERNEL);
+	if (!vmware_panic_page) {
+		pr_err("failed to allocate panic log buffer\n");
+		return 0;
+	}
+
+	ret = kmsg_dump_register(&vmware_panic_log_dumper);
+	if (ret) {
+		pr_err("failed to register panic log dumper: %d\n", ret);
+		__free_page(vmware_panic_page);
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
-- 
2.53.0

