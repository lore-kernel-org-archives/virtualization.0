Received: from mail-pg1-f226.google.com (mail-pg1-f226.google.com [209.85.215.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE4BE4EB84B
	for <virtualization@lists.linux.dev>; Mon, 28 Sep 2026 17:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790618181; cv=none; b=qjJiA68L48H3z9WxPpa8UF2UMAN9t0f/OD1p0G3hHeGm5taFOi64pT3hSS0ipPxWzSdwI3Fyad2fuK58IXDzg6QhVk0zD2MIAEUZllM9Tf/pa0b8rJmrw4pWQ9x6u/I8jWyokV+H0MRArqi9rltp8WRhsBc6yjcOwLfl3vJL8UA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790618181; c=relaxed/simple;
	bh=JxvuznqLzoNHOFITq+5sVj04mlf4U2b0YpG5PaxY7SI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dlHjxprVAi8a0cGi4n53YWkAyTiKC6lAG+EZnNOd2e5OVJEqiBCEkB1UzlwVBR37Ks+2+6EEHR3LOyY9Al1sw6y1OD6PbZRPXzkxsWgEyFB4Jj9FqQb4VWTyFRW5V4n7dP23kZTZBJN3yw/J0D00LqOn1BV+GNr0Cc3NXKQd7Dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=eexXnYzr; arc=none smtp.client-ip=209.85.215.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="eexXnYzr"
Received: by mail-pg1-f226.google.com with SMTP id 41be03b00d2f7-cc52c1b8286so57579a12.1
        for <virtualization@lists.linux.dev>; Mon, 28 Sep 2026 10:56:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790618179; x=1791222979;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=p+oiZYN5anlVv9s+aMa0ZbcmkVGe0RnDqM3OKTw5q4I=;
        b=yxp+cZlpJHhjdvGRLevpehPVGcFMjutlkl0/z9pkhuekT+tdWMgaxUlG2KVqXLZ2Mv
         Im0wWk3XTeCpUV3gqpdUaAOJYOqbAVB1TDwT+kDLV4fcHln8r1ew60CpThr71TMNSwxw
         1rM12hG7/4LLPw/dgM6m3fF76wMFsbJJ6fkgE86OZx/4M/njOl6EGKcNqaVdhdiQmw/I
         Tj4D9K2fOnhcPAdwBS6Z70RhW6x8YlMHRVsjz6m6fFfhISg8667RdWHYGF+oxDblpvlB
         GQjBh8tRVKYy4h0FMtQVChsqs+FhDAKc0RMWXVlx8ExuKaoV1llNbMnvflFZFwnNmtut
         4gWg==
X-Forwarded-Encrypted: i=1; AKwUvBzMXQwmHqRu+fOcbWsmsBHJl2n2dcejB9aC9BCoH7hKZj+uf7YTCMEBJlCJ8Hi4DDW52AsUMc4dNxIuxHwFyg==@lists.linux.dev
X-Gm-Message-State: AFuF++mZeXlsVWRb6nRpxmCMB/4CoNzWuClwjhKAy0bGXP+NrbzNiavC
	5ufFsiYMux08Ftuvjd+3CLfriiPxZws77ga5beP4PmQmiYfQhUQH6rsxsxZbEWRWacMOyBY8o5U
	XtJNyWar0DmNxaOLgcH4/6vEpbQGs9LopTET5b5P63+L7xjDlwdYdX63HhSdV/IlF4akAMYi32Z
	fnQwHbjMcEWyqtE/G4fhZW425biYegHFqDtea4RuDNkQec7Nl6hUGtk0++6h/aUYWHvPp2XoUkZ
	M8WTkr6vEt1PBwNJYk=
X-Gm-Gg: AYBFou2jjWi+4yZydXzor3FuH/yjXNMOipi5UMVJCzhfcmZ2gTV1nz5ug/SlU5+aDiB
	ICYwPGhmBIVnDS61+NHBAKx5e82AmMJFI1mhg4vXcQH0/AIJqWmavOc1BKKrQg3w7FNrS0tZao6
	V5J1wOw2oWZyRF3E7vGHTNecoV4X8crnfd6Z41AaiuB+1OZZQPw08txejXKCFUrkIfXc3COZRMs
	k1BlVWw32auQULKvkwqZNyMHaHwsWEOZRpXdHi/9Ca3/EYdMlPcCpAWvV5pS3ttE61paQ66bzH/
	XS0EmHvQOO6zEQYrsk3douXlwCyZDteUJrWQlMvMbBSPyY4iUOV6kyFt7cq+2ixEoPzq0+G5x7g
	dX/erblw/TLIzHTSMsRw9cUQ8YMz5Qy54r/RzC0BXYor5p0ggwKNYHvx2hsma6FYSqwjRdNNny4
	DX/Hw31Z7WYZdpVp2T6+EhLLfSfzEZuT8vF1g=
X-Received: by 2002:a05:6a20:7f91:b0:3dd:a9a9:396b with SMTP id adf61e73a8af0-3de7cfed065mr65288637.47.1790618178961;
        Mon, 28 Sep 2026 10:56:18 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-125.dlp.protect.broadcom.com. [144.49.247.125])
        by smtp-relay.gmail.com with ESMTPS id 41be03b00d2f7-cc7877ddf15sm6708890a12.11.2026.09.28.10.56.18
        for <virtualization@lists.linux.dev>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Sep 2026 10:56:18 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-3282d5302ffso157646eec.1
        for <virtualization@lists.linux.dev>; Mon, 28 Sep 2026 10:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1790618177; x=1791222977; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=p+oiZYN5anlVv9s+aMa0ZbcmkVGe0RnDqM3OKTw5q4I=;
        b=eexXnYzrLwXMTal4MceqKXWGzncXP4d6ki4hHpAw/vs9CcHO46/vQzI978ryly8Kbu
         Jd5Fg/KemDREtP4ycDKkBNscDAAj40vm5OSYx0DMHOzFIu3/LTCeZi18aAcBsSM4X2t1
         4EBhzLo6T08rrcZm6eKhEUJDx33DSMPj0/xfU=
X-Forwarded-Encrypted: i=1; AKwUvBxpM2/0gv6ZiiqR+Y4J/d3nEGid3Hnk/k4eRQyTpn/j5899bpH1/xKPCo1scUnl7XiQooAE+QCU1+tQwEpmzQ==@lists.linux.dev
X-Received: by 2002:a05:7022:d42:b0:148:ece:8cc3 with SMTP id a92af1059eb24-14b2ea0652fmr138511c88.24.1790618177007;
        Mon, 28 Sep 2026 10:56:17 -0700 (PDT)
X-Received: by 2002:a05:7022:d42:b0:148:ece:8cc3 with SMTP id a92af1059eb24-14b2ea0652fmr138487c88.24.1790618176363;
        Mon, 28 Sep 2026 10:56:16 -0700 (PDT)
Received: from vertex.localdomain ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3421dbb2971sm26076069eec.10.2026.09.28.10.56.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 10:56:10 -0700 (PDT)
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
Subject: [PATCH v2 2/6] crash: Notify pre-kdump callbacks before switching kernels
Date: Mon, 28 Sep 2026 13:55:36 -0400
Message-ID: <9ef573cdbbf5e659eea16fa23afeaf2488049198.1790014793.git.zack.rusin@broadcom.com>
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

Fatal x86 oopses can call crash_kexec() without reaching panic(). Run the
pre-kdump chain from __crash_kexec() as well, after finding a loaded image
under the kexec lock and capturing the original registers.

This covers direct crash entry without moving all panic notifiers ahead
of kdump. A missing image or failed trylock leaves callbacks uncalled;
the shared guard skips callbacks already invoked by panic().

Link: https://lore.kernel.org/r/aquttpMVKX8e6zGB@pathway.suse.cz
Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
---
New in v2: cover direct crash-kexec entry in a separate core patch.

 kernel/crash_core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index 2b36aa9fade0..5d9fe9e00f39 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -23,6 +23,7 @@
 #include <linux/objtool.h>
 #include <linux/delay.h>
 #include <linux/panic.h>
+#include <linux/panic_notifier.h>
 
 #include <asm/page.h>
 #include <asm/sections.h>
@@ -139,6 +140,7 @@ void __noclone __crash_kexec(struct pt_regs *regs)
 			struct pt_regs fixed_regs;
 
 			crash_setup_regs(&fixed_regs, regs);
+			panic_notify_pre_kdump(NULL);
 			crash_save_vmcoreinfo();
 			machine_crash_shutdown(&fixed_regs);
 			crash_cma_clear_pending_dma();
