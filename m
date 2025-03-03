Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C61B27462;
	Mon,  3 Mar 2025 00:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740962702; cv=none; b=Wj2QW6xJosx9aopln3hO9KVBIyYMxxtp15myKjFdpuuc0UspWn9cfUbyzF+y3Shq7uUj7BbSmYzmaosLLgJtPxakgabOI8qy5AuWJBeyQMXjV4unuxKc+eGtwemQXLOXsZ9lcd5iUvwkMNhcq3ZFO0SIRj9vNYlIwj35Gza/f1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740962702; c=relaxed/simple;
	bh=9WY/hzSH4v14e9UoCLK2v1IoOtJBktAuWSMTCZOu0sA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=L7lz/8ahGMqoeQx3HVV+JNOsRjY8e7+4M19rMdHnOGoOfCIzxpB2PMXPHG4IInuKENRNs7SAk+F7gybrCY/NXQLsIl2MnEzsCuiQoJaOqNwxTD7o84C/GsFkpp3aDkYtQhU574Hw0ik8kn5itKKb5043ZsYztTONA6lspVh+NgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=LVN1QoDz; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="LVN1QoDz"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=J9CZvuUehL5MwrosRBDizgtQSpCUzvOD5nGdOU5im9Y=; b=LVN1QoDzKPBgLJrE
	r72TaAVorxjZV701wseKpp2x1JTvAguwxZuNf3+QryD+WhslREcyQ2/DX2Ld6A2Zx0gHRgnZ4sR98
	3NoaEAlideQ/6VsW6Gy4OBtxa34XSXUrs5Xf/RhnP9qvCynSOiwWGkTpl4OL7BzVmYE5OtD7DNTJI
	mlSV8R17fzwhZ1Ea8JplVpklkKn+HmRD/+Lk+qJiIizM3CDrTf/8CymbLOdUfbhiV3TePOhzMebPk
	f8fCndVVCT4q0kFWduTKar5dewKjD9qx9bprxYcrRLSdQixnSTweqiMZihQWWk8RdKXSrAgFqQp48
	bjGaaznIAne5WgXgSQ==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1totvH-001zYn-2h;
	Mon, 03 Mar 2025 00:44:43 +0000
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
Subject: [PATCH v2] x86/paravirt: Remove unused paravirt_disable_iospace
Date: Mon,  3 Mar 2025 00:44:41 +0000
Message-ID: <20250303004441.250451-1-linux@treblig.org>
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
v2
  Cleaned up the header

 arch/x86/include/asm/paravirt_types.h |  2 --
 arch/x86/kernel/paravirt.c            | 20 --------------------
 2 files changed, 22 deletions(-)

diff --git a/arch/x86/include/asm/paravirt_types.h b/arch/x86/include/asm/paravirt_types.h
index fea56b04f436..3c54ac5a9af4 100644
--- a/arch/x86/include/asm/paravirt_types.h
+++ b/arch/x86/include/asm/paravirt_types.h
@@ -242,8 +242,6 @@ extern struct paravirt_patch_template pv_ops;
 
 #define paravirt_ptr(op)	[paravirt_opptr] "m" (pv_ops.op)
 
-int paravirt_disable_iospace(void);
-
 /* This generates an indirect call based on the operation type number. */
 #define PARAVIRT_CALL					\
 	ANNOTATE_RETPOLINE_SAFE				\
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

