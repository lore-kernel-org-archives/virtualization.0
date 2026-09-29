Received: from mail-pf1-f227.google.com (mail-pf1-f227.google.com [209.85.210.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE95919A288
	for <virtualization@lists.linux.dev>; Tue, 29 Sep 2026 04:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790654603; cv=none; b=GShl6v4ixPaD54YJj+9UMtAskxNQ5EDdw7rIcl8i/Y9PWXjyu4wOv1lunfkI6mjGn8PcNKef+jfZlAYbUe/lRLtukJ3agE2zgzqhnEsw47ereS0cU09SGu6J9wptOpWdxuPU2uuoPi//MohBCR9cEiPR68Tf0GydbFeEX3aIpdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790654603; c=relaxed/simple;
	bh=hwzN7aNlJ2wxS9ZWnQFgLPxc8hv3AZhs4ribMUFVqWY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FTzNxc4RxvsVbihRts7ZXnwhrfMHwmpPxM0VS4eZ4cIEdomziMXIym3US1phACGOLPNwaXCyH6C6YFBkVxIAeptFg4y/Ve3YfUcCcwwaapbuqDjntPfOBp6R8zBFbKTuGcNLggOPdi6u5aPQ8wJoWVRoZBxkurJZrzPT4A/rqn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=hb5if42i; arc=none smtp.client-ip=209.85.210.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="hb5if42i"
Received: by mail-pf1-f227.google.com with SMTP id d2e1a72fcca58-869868f45a5so665953b3a.1
        for <virtualization@lists.linux.dev>; Mon, 28 Sep 2026 21:03:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790654601; x=1791259401;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wf4+8fPuDTBmj6DTA0OwZVxSovvEfEo3g6LDTXOjhgc=;
        b=XtYyPtKcQnafAH/u1lKEUte12EBvjOGfpnGir7lGR5xcm2CSur9LJcls85+QT80sqa
         FhUuJuIjNb0z1NDadtHyq6w/g87YffMDqfh4/rzMOOSca4uKWUBIy7Rb651Wn6hOhqF2
         a2VKP3ZciU6ZRoU21LfGucgtMUp+cDHIgCv4POFmvgM6EMgNNZbwQjMGrQGV7BYyUw9e
         3o+1OlpbawU6X7tCmJ7vkZubR9WJX7+644Tq+T3dEAR0Nj6oxPz1V26IM5169idT8isJ
         JVmQDUIFvI1oaMtBVNgQ+Nep5dDigDqsI/yuUz/IOaUT0g7cimMe56agQIKEUYvD3CVh
         U53A==
X-Forwarded-Encrypted: i=1; AKwUvBxaiph/kMsm2ja72nk1DpnzbHZV9XCSck2Cagq9fbpRklc8WrcOYSDfW7qUrUZKcsmHX8Efo0jSOU2LVvheoQ==@lists.linux.dev
X-Gm-Message-State: AFuF++kNidNpoa4L95EEYrK8wUewyy0rJ3srcGEFJORS871akf9Sfo+1
	k2m+iHOtbJ3SjxeKK98yxbfMtKAkf/JZKPvMafmukpC2rMudtimP8q9QJQblZQBEIP0qO5Ha8fZ
	uTfsC1Y6k3/SXCkrQR20ukeVO8acEI46DzsVsbDTM5GwHvAHziNee11TKl5krr7cKDKfHiWXEJn
	8cGpjN0NdWFyBZnAoCwEM+b2NWSA53TYiUDJupZ6JCow+wdSokma5uTaV/rGUH4QIkPJTq8F6b5
	s7how1yj6ROw9vCbMY=
X-Gm-Gg: AYBFou0OrHRz7i5yHRQsdsy6Ymd0XIQubbFzet5u0P9T++SENwCsDutjFlgSbRn/X1G
	neJ7GlQVUuLQ1yxjVKbZEyskiVLXiWWpl62O99S1Nw6Xelm/bIr5z4XaTb3pJ1JSS45J0Op178j
	FftjV3ixrJh/Skbv0nstxLCXw/1fJNLzhNgPO2N18Mj4j85iTNjIvHQ/BuuU/wvE3fawtYVYq3Y
	evzbZdyobuVyFUYwIigmrpXw2zm9LBi+wUOrjC5M8YVKljl/sqjC/fCBVqY9mg8KvmMtx8O9AJL
	fkMkKxTzCPXhK339jUEmyu/jrP1yoDjAOKGs/OLvhKzS0DVktraRZIjSqmNXqdYlbvewwFRgoU/
	PSBpuvEcTS1nQXjLd6cfjWAfCjNu91iRmEv3q73t5psZ1QSxuqj5HftRR0s+qZAYxCiJZBUg4RX
	OF+vQK521/jTMQ3zrkVYlZXyPOARTea0g9
X-Received: by 2002:a05:6a20:c784:b0:3d3:adad:f173 with SMTP id adf61e73a8af0-3de0e739b5amr13774738637.21.1790654600911;
        Mon, 28 Sep 2026 21:03:20 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-25.dlp.protect.broadcom.com. [144.49.247.25])
        by smtp-relay.gmail.com with ESMTPS id 41be03b00d2f7-cc787760a08sm7703637a12.5.2026.09.28.21.03.16
        for <virtualization@lists.linux.dev>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Sep 2026 21:03:20 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-33baaba6371so14196785eec.1
        for <virtualization@lists.linux.dev>; Mon, 28 Sep 2026 21:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1790654595; x=1791259395; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wf4+8fPuDTBmj6DTA0OwZVxSovvEfEo3g6LDTXOjhgc=;
        b=hb5if42iaWOiPcF4FxEtte3eLMPk0UBH+hsierak0oeZ6QEZYKYeMRzkNnVLCxWoOd
         xGT4wMLx7ojckh0ZeKLIZjSPPzhzrGQEPS7J3zxLwKlUuZNEf1IQ8Ws61jQRBUODOIDp
         tMhMIcxFhUVc7AqnVgoKgqU0aVgW9OkntOq7I=
X-Forwarded-Encrypted: i=1; AKwUvByNKZtZnYRXhxwGAI602ikA4/MBbuRrL8fzdO2cq6vsneEyq18zJoFL4dSObH2xm9Oq+ITAIS3hjdbJGKs1Kw==@lists.linux.dev
X-Received: by 2002:a05:7300:c8cc:b0:33b:a4dc:d5e1 with SMTP id 5a478bee46e88-3426fbbe36fmr11863815eec.8.1790654595179;
        Mon, 28 Sep 2026 21:03:15 -0700 (PDT)
X-Received: by 2002:a05:7300:c8cc:b0:33b:a4dc:d5e1 with SMTP id 5a478bee46e88-3426fbbe36fmr11863746eec.8.1790654594365;
        Mon, 28 Sep 2026 21:03:14 -0700 (PDT)
Received: from vertex.localdomain ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-347323f5a7esm10952571eec.15.2026.09.28.21.03.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 21:03:12 -0700 (PDT)
From: Zack Rusin <zack.rusin@broadcom.com>
To: Kiryl Shutsemau <kas@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	x86@kernel.org,
	Dennis Zhou <dennis@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: Ajay Kaher <ajay.kaher@broadcom.com>,
	Alexey Makhalov <alexey.makhalov@broadcom.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	virtualization@lists.linux.dev,
	bcm-kernel-feedback-list@broadcom.com,
	linux-kernel@vger.kernel.org,
	Christoph Lameter <cl@gentwo.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Bo Gan <bo.gan@broadcom.com>,
	linux-mm@kvack.org,
	linux-arch@vger.kernel.org,
	linux-coco@lists.linux.dev,
	kvm@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Long Li <longli@microsoft.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	linux-doc@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	Nathan Chancellor <nathan@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Ashish Kalra <ashish.kalra@amd.com>
Subject: [PATCH v2 2/6] percpu: Bound decrypted storage for all x86 encrypted guests
Date: Tue, 29 Sep 2026 00:02:51 -0400
Message-ID: <20260929040256.543767-3-zack.rusin@broadcom.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260929040256.543767-1-zack.rusin@broadcom.com>
References: <20260929040256.543767-1-zack.rusin@broadcom.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

TDX also needs shared per-CPU buffers. Use X86_MEM_ENCRYPT for their
definition and placement, and provide page-aligned boundaries so the
architecture can convert each CPU's whole section before registration.

Define the boundaries in the SMP template or UP data as appropriate.
Drop the unused DECLARE_PER_CPU_DECRYPTED() macro.

Suggested-by: Kiryl Shutsemau <kas@kernel.org>
Link: https://lore.kernel.org/r/aqqGUAX65s4LdJkr@thinkstation
Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
---
 include/asm-generic/vmlinux.lds.h | 12 ++++++++----
 include/linux/percpu-defs.h       |  7 ++-----
 2 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 64bc2bfdd2ec..145fcdbbe9db 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -368,11 +368,13 @@
 /*
  * .data section
  */
-#if defined(CONFIG_AMD_MEM_ENCRYPT) && !defined(CONFIG_SMP)
+#if defined(CONFIG_X86_MEM_ENCRYPT) && !defined(CONFIG_SMP)
 #define DATA_DECRYPTED							\
 	. = ALIGN(PAGE_SIZE);						\
+	__start_percpu_decrypted = .;					\
 	*(.data..decrypted)						\
-	. = ALIGN(PAGE_SIZE);
+	. = ALIGN(PAGE_SIZE);						\
+	__end_percpu_decrypted = .;
 #else
 #define DATA_DECRYPTED	*(.data..decrypted)
 #endif
@@ -1022,11 +1024,13 @@
  * Note: We use a separate section so that only this section gets
  * decrypted to avoid exposing more than we wish.
  */
-#ifdef CONFIG_AMD_MEM_ENCRYPT
+#if defined(CONFIG_X86_MEM_ENCRYPT) && defined(CONFIG_SMP)
 #define PERCPU_DECRYPTED_SECTION					\
 	. = ALIGN(PAGE_SIZE);						\
+	__start_percpu_decrypted = .;					\
 	*(.data..percpu..decrypted)					\
-	. = ALIGN(PAGE_SIZE);
+	. = ALIGN(PAGE_SIZE);						\
+	__end_percpu_decrypted = .;
 #else
 #define PERCPU_DECRYPTED_SECTION
 #endif
diff --git a/include/linux/percpu-defs.h b/include/linux/percpu-defs.h
index dbe3267a0a13..fdb666a1b4de 100644
--- a/include/linux/percpu-defs.h
+++ b/include/linux/percpu-defs.h
@@ -169,13 +169,10 @@
 	DEFINE_PER_CPU_SECTION(type, name, "..read_mostly")
 
 /*
- * Declaration/definition used for per-CPU variables that should be accessed
+ * Definition used for built-in per-CPU variables that should be accessed
  * as decrypted when memory encryption is enabled in the guest.
  */
-#ifdef CONFIG_AMD_MEM_ENCRYPT
-#define DECLARE_PER_CPU_DECRYPTED(type, name)				\
-	DECLARE_PER_CPU_SECTION(type, name, "..decrypted")
-
+#ifdef CONFIG_X86_MEM_ENCRYPT
 #define DEFINE_PER_CPU_DECRYPTED(type, name)				\
 	DEFINE_PER_CPU_SECTION(type, name, "..decrypted")
 #else
-- 
2.53.0

