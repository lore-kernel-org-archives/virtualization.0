Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E03F71C32;
	Mon,  3 Mar 2025 00:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740960534; cv=none; b=NL0QfP/kDIWhLnzPpjpjedTKxz+1Zn7AiZBLI5t6KhXBuW/jGRZXDYQBB7aKrPQLFH8fAX7dtdn+N50A/EzpPtrN8cu+7aPJSRg15buM0mAJ9xhtJXLaJ+4om74/hSXEi+AVV/BLj/ZRVzyICKqDPGpKAjQQ14m2MRRM6w72Lbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740960534; c=relaxed/simple;
	bh=uuvUNqM5Cs+dashDQaZlaLaO01pRwEYZGIyxvFgIyHI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d5YEoRH40Ka+djF4LoRVTYXkDs6EL7FKcKLLLrz5IUDJg27sAOy3XcmlDs1nKDpLRqNSL1YZuEHJbnIncOaeS82D2s9Gud7ZvS7xgOcnda8y+KVBk66AHZ2l6GyuMl6HLV5cSqqFeA9NNaYhgfbj/hQQdiqBjo559TN1efD1BT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=ISIaClB3; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="ISIaClB3"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=19FcswLP9f8A6SKLTW+dZ9z8SiMZQxr1tsfsOt9chpc=; b=ISIaClB3dioW5nb9
	RAYjnLh5/jfBEetUyDaOezuzEr99NwscL8Nu0U5sqw2fdUNxP5bkXWnNVlhX0TUyKFhzVPwAImaxD
	nbFKnPu8eOaFPQS2HIrsndjJRN1XsBpyOG67d30dqmWGocHCBWJC1ThdeFtDIi59QUa2FWcT37jFg
	Tt6V6IAHejjfxe2U5Otne4LV55t0KVq0D44zkFftsFNZFFy6YpUm0JrFKD8de/aOQFQ29YypaCSvl
	3JS3dI6NYBTZ9jssjSE891qAC5uOP370CqTLWN5I8cPAYnWOJO+lswCeTE4NqtfzPKoeYURiWz7D2
	b9bVMsNj2Li3R2EUsg==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1totMF-001zOp-1O;
	Mon, 03 Mar 2025 00:08:31 +0000
From: linux@treblig.org
To: jgross@suse.com,
	ajay.kaher@broadcom.com,
	alexey.amakhalov@broadcom.com,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	hpa@zytor.com
Cc: x86@kernel.org,
	virtualization@lists.linux.dev,
	bcm-kernel-feedback-list@broadcom.com,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH] x86/paravirt: Remove unused paravirt_disable_iospace
Date: Mon,  3 Mar 2025 00:08:30 +0000
Message-ID: <20250303000830.82968-1-linux@treblig.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

The last use of paravirt_disable_iospace() was removed in 2015 by
commit d1c29465b8a5 ("lguest: don't disable iospace.")

Remove it.

Note the comment above it about 'entry.S' is unrelated to this
but stayed when intervening code got deleted.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 arch/x86/kernel/paravirt.c | 20 --------------------
 1 file changed, 20 deletions(-)

diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
index 1ccaa3397a67..debe92854774 100644
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -90,26 +90,6 @@ void paravirt_set_sched_clock(u64 (*func)(void))
 	static_call_update(pv_sched_clock, func);
 }
 
-/* These are in entry.S */
-static struct resource reserve_ioports = {
-	.start = 0,
-	.end = IO_SPACE_LIMIT,
-	.name = "paravirt-ioport",
-	.flags = IORESOURCE_IO | IORESOURCE_BUSY,
-};
-
-/*
- * Reserve the whole legacy IO space to prevent any legacy drivers
- * from wasting time probing for their hardware.  This is a fairly
- * brute-force approach to disabling all non-virtual drivers.
- *
- * Note that this must be called very early to have any effect.
- */
-int paravirt_disable_iospace(void)
-{
-	return request_resource(&ioport_resource, &reserve_ioports);
-}
-
 #ifdef CONFIG_PARAVIRT_XXL
 static noinstr void pv_native_write_cr2(unsigned long val)
 {
-- 
2.48.1

