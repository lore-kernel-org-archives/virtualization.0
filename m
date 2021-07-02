Return-Path: <SRS0=Lmm9=L2=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 398D5C11F6C
	for <virtualization@archiver.kernel.org>; Fri,  2 Jul 2021 11:49:01 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F37F161416
	for <virtualization@archiver.kernel.org>; Fri,  2 Jul 2021 11:49:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F37F161416
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CEF2D83DC2;
	Fri,  2 Jul 2021 11:49:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id o-Fg02OfnHJ6; Fri,  2 Jul 2021 11:48:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id B775D83DC8;
	Fri,  2 Jul 2021 11:48:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B0726C0027;
	Fri,  2 Jul 2021 11:48:57 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 916EDC001D
 for <virtualization@lists.linux-foundation.org>;
 Fri,  2 Jul 2021 11:48:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 93B6740465
 for <virtualization@lists.linux-foundation.org>;
 Fri,  2 Jul 2021 11:48:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=suse.com header.b="o4x9NiSg";
 dkim=pass (1024-bit key) header.d=suse.com header.b="o4x9NiSg"
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RmlQ6fpbQQv4
 for <virtualization@lists.linux-foundation.org>;
 Fri,  2 Jul 2021 11:48:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4CE12404B1
 for <virtualization@lists.linux-foundation.org>;
 Fri,  2 Jul 2021 11:48:52 +0000 (UTC)
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
 (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7BA1822982;
 Fri,  2 Jul 2021 11:48:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1625226530; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oQFJfMtJ7d44u/Eg9demA0543TOxxcunVlC/ArZcDv0=;
 b=o4x9NiSgX+HD1y+cGs/NAtT0HAa569xMwAnQBHAA5HKhlnRdlykHhBczJHNXLbMZ1xG6Uy
 bYECwfUOYzpioSUoN/tgTr5/bYGhP9JbITbGLjRUQ1gvUYUMoRI0P24FtzV09AoG/xW63b
 Q9ixPWR0fbsQJ5pyEpOs3MkaxxUwwE0=
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
 by imap.suse.de (Postfix) with ESMTP id 1C24B11C84;
 Fri,  2 Jul 2021 11:48:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1625226530; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oQFJfMtJ7d44u/Eg9demA0543TOxxcunVlC/ArZcDv0=;
 b=o4x9NiSgX+HD1y+cGs/NAtT0HAa569xMwAnQBHAA5HKhlnRdlykHhBczJHNXLbMZ1xG6Uy
 bYECwfUOYzpioSUoN/tgTr5/bYGhP9JbITbGLjRUQ1gvUYUMoRI0P24FtzV09AoG/xW63b
 Q9ixPWR0fbsQJ5pyEpOs3MkaxxUwwE0=
Received: from director2.suse.de ([192.168.254.72]) by imap3-int with ESMTPSA
 id SOhgBSL93mDDDAAALh3uQQ
 (envelope-from <varad.gautam@suse.com>); Fri, 02 Jul 2021 11:48:50 +0000
To: kvm@vger.kernel.org,
	virtualization@lists.linux-foundation.org
Subject: [kvm-unit-tests PATCH 6/6] x86: Disable some breaking tests for EFI
 and modify vmexit test
Date: Fri,  2 Jul 2021 13:48:20 +0200
Message-Id: <20210702114820.16712-7-varad.gautam@suse.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210702114820.16712-1-varad.gautam@suse.com>
References: <20210702114820.16712-1-varad.gautam@suse.com>
MIME-Version: 1.0
Cc: thomas.lendacky@amd.com, drjones@redhat.com, jroedel@suse.de,
 brijesh.singh@amd.com, pbonzini@redhat.com, bp@suse.de
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
From: Varad Gautam via Virtualization
 <virtualization@lists.linux-foundation.org>
Reply-To: Varad Gautam <varad.gautam@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

Disable some tests from building on EFI. These fail early, and need some
adaptation (eg. inline asm changes / AP initialization / memory
reclamation from EFI).

Eg, asyncpf: runs out of memory since the allocator only uses the largest
  EFI_CONVENTIONAL_MEMORY block.
hyperv_*: untested with EFI.
vmexit: breaks since test arg passing isn't enabled - enable it except for
  pci-* cases since iomem needs more fixups.

Signed-off-by: Varad Gautam <varad.gautam@suse.com>
---
 x86/Makefile.common | 21 +++++++++++----------
 x86/vmexit.c        |  7 +++++++
 2 files changed, 18 insertions(+), 10 deletions(-)

diff --git a/x86/Makefile.common b/x86/Makefile.common
index 98d8de9..b995a67 100644
--- a/x86/Makefile.common
+++ b/x86/Makefile.common
@@ -62,17 +62,18 @@ FLATLIBS = lib/libcflat.a
 	@chmod a-x $@
 
 tests-flatonly = $(TEST_DIR)/realmode.$(out) $(TEST_DIR)/eventinj.$(out)		\
-		$(TEST_DIR)/smap.$(out) $(TEST_DIR)/umip.$(out)
-
-tests-common = $(TEST_DIR)/vmexit.$(out) $(TEST_DIR)/tsc.$(out)				\
-		$(TEST_DIR)/smptest.$(out) $(TEST_DIR)/msr.$(out)			\
-		$(TEST_DIR)/hypercall.$(out) $(TEST_DIR)/sieve.$(out)			\
-		$(TEST_DIR)/kvmclock_test.$(out) $(TEST_DIR)/s3.$(out)			\
+		$(TEST_DIR)/smap.$(out) $(TEST_DIR)/umip.$(out)				\
+		$(TEST_DIR)/kvmclock_test.$(out) $(TEST_DIR)/hypercall.$(out)		\
+		$(TEST_DIR)/init.$(out)							\
+		$(TEST_DIR)/asyncpf.$(out) $(TEST_DIR)/hyperv_synic.$(out)		\
+		$(TEST_DIR)/hyperv_stimer.$(out) $(TEST_DIR)/hyperv_connections.$(out)
+
+tests-common = $(TEST_DIR)/tsc.$(out) $(TEST_DIR)/smptest.$(out)			\
+		$(TEST_DIR)/msr.$(out) $(TEST_DIR)/sieve.$(out)				\
+		$(TEST_DIR)/sieve.$(out) $(TEST_DIR)/s3.$(out)				\
 		$(TEST_DIR)/pmu.$(out) $(TEST_DIR)/setjmp.$(out)			\
-		$(TEST_DIR)/tsc_adjust.$(out) $(TEST_DIR)/asyncpf.$(out)		\
-		$(TEST_DIR)/init.$(out) $(TEST_DIR)/hyperv_synic.$(out)			\
-		$(TEST_DIR)/hyperv_stimer.$(out) $(TEST_DIR)/hyperv_connections.$(out)	\
-		$(TEST_DIR)/tsx-ctrl.$(out)
+		$(TEST_DIR)/tsc_adjust.$(out) $(TEST_DIR)/tsx-ctrl.$(out)		\
+		$(TEST_DIR)/vmexit.$(out)
 
 ifneq ($(CONFIG_EFI),y)
 tests-common += $(tests-flatonly)
diff --git a/x86/vmexit.c b/x86/vmexit.c
index 999babf..4062f7a 100644
--- a/x86/vmexit.c
+++ b/x86/vmexit.c
@@ -560,6 +560,12 @@ static void enable_nx(void *junk)
 
 static bool test_wanted(struct test *test, char *wanted[], int nwanted)
 {
+#ifdef CONFIG_EFI
+	if (strcmp(test->name, "pci-io") == 0 || strcmp(test->name, "pci-mem") == 0 )
+		return false;
+
+	return true;
+#else
 	int i;
 
 	if (!nwanted)
@@ -570,6 +576,7 @@ static bool test_wanted(struct test *test, char *wanted[], int nwanted)
 			return true;
 
 	return false;
+#endif
 }
 
 int main(int ac, char **av)
-- 
2.30.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
