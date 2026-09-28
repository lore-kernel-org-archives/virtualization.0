Received: from mail-qt1-f225.google.com (mail-qt1-f225.google.com [209.85.160.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ACAE4E237D
	for <virtualization@lists.linux.dev>; Mon, 28 Sep 2026 17:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790618211; cv=none; b=h4CNmOxJc5ev4F9pOfAKdK54MXPNGGtK8LEkWrWOzhvlzjVloG+3z7YGzoLjtxXgW5n7+19gR7+5sjl4GjVVoXIcgs4SnOADpzY0hR4sFCA5etwaBd1abCoh8gTpNEmGInDAQYw5tuyskc/IyhpgpSsGcmBRLUTNieVs8qct5TA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790618211; c=relaxed/simple;
	bh=d9cBTkOw0aK3AElv5ozuCCDHyzBzm/RESBhM7b8UGbE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CxdL6vGle0ri1p0D+d/JoIJdEVrbTlK4963ACAss1CKZVTaoi4Uni76RSnAuD00edpJg6exOCO8G2Z/DqADJCuv6EKhFji0sg96fxy5oTgL6icGVVTwUEZfxJnZLXmhY00JK4RfWJmLrWGf0pAIU31LfZxXENQ/x5ZcsOnJiyXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Byo6wmPO; arc=none smtp.client-ip=209.85.160.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Byo6wmPO"
Received: by mail-qt1-f225.google.com with SMTP id d75a77b69052e-53328262f7aso673521cf.1
        for <virtualization@lists.linux.dev>; Mon, 28 Sep 2026 10:56:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790618208; x=1791223008;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TVGlTnr9IEkHnZ4PdpN3QONqUPUFWJ903eZT9nZGA+U=;
        b=0fqOHVlOXDqbbhUT8hX4RzsprwgDXhsBeC+yWdbKjBWRcuFMaU4W43hbhH4TOUKmFp
         KPvZzoF9tKBAamsnq3DciQw7kVosJwVCShMy1+PL4uN6BsvhHaW8Zq+cQ6wPokTPMBfb
         dX+k9T1oB8iXCWwxkGHBtBjBkwB0rAliQptPXEkbZchUaKy+0dG717iVE0XlOMXUSU23
         4KBNWBWseV7OvIEwhlNlgXgfugW6Bg1DSAESdmV8XMmoYbuIZPiLT8yeWpg2UNlUIAzf
         ptVx6aShGf6cLkkCiYxu6ACkXoLl2tzw/7s5xnvT6MRJZLQ2qJ/FixNrhN32WySVgjuc
         8vxQ==
X-Forwarded-Encrypted: i=1; AKwUvBxeWnG2CIttLPNfdhlZ2qmrObfJSzfuRHH2pJH7Dmhfp8hfLY+aLKTgsz1pSy7jhmxYsxTVkfDFYNcFUxfRQg==@lists.linux.dev
X-Gm-Message-State: AFuF++lWyA2T8NWoCx3DjUUXR23ads6NQH/fxY1YJK+8PW663b1Q5gwI
	6iK3egx0mYPCA3jQHTbD7jul5ujQSZAeVESrkIG5l5sl6ZxyxdYy4dgx9WSciF1z9ZChqsqfrGm
	4pPgjvEcrauKI2P/X6MxGbizjHeTqLMhAoZusQBRYNy8Qy8j9SNpHbmwZyO56QnQeUPWsZF+XWa
	wohiFnWnTCVi8imIyE/jgE7TOF/qY550ynOUAz5FKxRTO6bTGMZT8h8lRc6SLjkyFWFZFrs8MFx
	IlMDbNa9qXTZIGGKjc=
X-Gm-Gg: AYBFou1AID0Lqt19+ZE/ddGYKIBsLWUu/BRJIfqmVaAVpZ1p6wx8td7zzr+fPhJQhG6
	6h0sD8q+3HmkGUsAVmrruWmVBq/sP86QoO732f9kdN49SU/4YX1qM5jdzO8WVRgcHD8ziLcFc8x
	n1tXWW0ClXHLVX8bXKtLcZOsENOV76XrJ8kNbQO1gZiZ/DLmcu+2Ek9+DKOwPe3L3xZpoQPKIvq
	mcD/p1PnFMoBSQJfuTVY/4ZsMH2ww9rStzAC4NxuC5MU/kcgMVN36kSo2VpXMYEaAWwhuGtA46l
	fYjw7Jis9P+8cR8AtTwHJ8yZtGH4aYyaywyX8NIPu9vGlcxO2lc/yzh8UBpyzyoID23PdFwwHeu
	vG10CjMZ8b1HtSlDJsKPZ26+3O5xryYOF+6N+73zG1MRJE+4loF9m2/2SXTaYtgd+csunnps82O
	KDC1oIPZmyOj3YCLZ+03jTX34bM3nbfnuc1eY=
X-Received: by 2002:a05:620a:439d:b0:93c:5ff3:2248 with SMTP id af79cd13be357-93c8bd3db89mr33195985a.14.1790618194156;
        Mon, 28 Sep 2026 10:56:34 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-120.dlp.protect.broadcom.com. [144.49.247.120])
        by smtp-relay.gmail.com with ESMTPS id af79cd13be357-93c8138bd78sm73825985a.3.2026.09.28.10.56.33
        for <virtualization@lists.linux.dev>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Sep 2026 10:56:34 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-3282d5302ffso158094eec.1
        for <virtualization@lists.linux.dev>; Mon, 28 Sep 2026 10:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1790618192; x=1791222992; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TVGlTnr9IEkHnZ4PdpN3QONqUPUFWJ903eZT9nZGA+U=;
        b=Byo6wmPOYvIZfa84OCHGCkhlPPkKa47y0PFrGqTPwEiUJfRdHOI+6Q1aK1rXH9jVa3
         WxnYRvL+/WRwgiWaleV2sluOQn38EKSfZl8RFydVWihlkjt0ZsfmlS4pNRZbJouadb6i
         m2rWC1uSoVI2zykzL5pML777sysFTWDrQJZaQ=
X-Forwarded-Encrypted: i=1; AKwUvByUCohH1DMuNhuyUhlTT5hplJKz+hCXTtrrgjDxt0gSeZ8KkQS+uLSWLO9Yh1bnCM6E3LHP+pP+Y29hBc69jw==@lists.linux.dev
X-Received: by 2002:a05:7300:6705:b0:33e:aa3d:ebe9 with SMTP id 5a478bee46e88-34af62b1643mr148607eec.12.1790618192321;
        Mon, 28 Sep 2026 10:56:32 -0700 (PDT)
X-Received: by 2002:a05:7300:6705:b0:33e:aa3d:ebe9 with SMTP id 5a478bee46e88-34af62b1643mr148550eec.12.1790618191428;
        Mon, 28 Sep 2026 10:56:31 -0700 (PDT)
Received: from vertex.localdomain ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3421dbb2971sm26076069eec.10.2026.09.28.10.56.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 10:56:26 -0700 (PDT)
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
	Ian Forbes <ian.forbes@broadcom.com>
Subject: [PATCH v2 4/6] x86/vmware: Add a bounded pre-kdump log sender
Date: Mon, 28 Sep 2026 13:55:38 -0400
Message-ID: <c1313dbfd632d2d4f2c5a14577df24a6c1b3c34a.1790014793.git.zack.rusin@broadcom.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1790014793.git.zack.rusin@broadcom.com>
References: <cover.1790014793.git.zack.rusin@broadcom.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

Preserve the newest kernel log tail in the host's vmware.log, which can
outlive a guest with no working userspace or persistent storage.

Allocate an 8 KiB buffer during early init and register on
panic_pre_kdump_list. A 4 KiB buffer can omit useful stack-trace
context. Use a fixed byte budget so transfer work does not scale
with PAGE_SIZE.

Copy the newest records, prefix them with "log ", and send one RPC over
the low-bandwidth register interface. Bound the transfer to 8 KiB and
at most three checkpoint attempts; zero-fill a partial payload word and
close the channel after every successful open.

The callback allocates nothing and emits no printk messages. Enable it
for ordinary guests, leaving encrypted guests disabled until explicitly
enabled by the sysctl. Skip initialization without printk support, and
leave logging disabled after allocation or registration failure.

Suggested-by: Michael Kelley <mhklinux@outlook.com>
Link: https://lore.kernel.org/r/SN6PR02MB41574A11D309A0530C63E0FED4842@SN6PR02MB4157.namprd02.prod.outlook.com
Link: https://lore.kernel.org/r/20260309235250.2611115-3-alexey.makhalov@broadcom.com
Co-developed-by: Bo Gan <bo.gan@broadcom.com>
Signed-off-by: Bo Gan <bo.gan@broadcom.com>
Co-developed-by: Alexey Makhalov <alexey.makhalov@broadcom.com>
Signed-off-by: Alexey Makhalov <alexey.makhalov@broadcom.com>
Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
---
v2: use the pre-kdump notifier, establish safe guest defaults, and
increase the fixed buffer to 8 KiB as Michael suggested.
Maaz's v1 Reviewed-by is omitted for renewed review of the new callback.

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
index 34b73573b108..ccf8dc84b30e 100644
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
+	ret = atomic_notifier_chain_register(&panic_pre_kdump_list,
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
