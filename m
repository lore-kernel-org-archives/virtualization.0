Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9907AC74A5B
	for <virtualization@archiver.kernel.org>; Wed, 29 Mar 2023 11:03:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 097E3818A2;
	Wed, 29 Mar 2023 11:03:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 097E3818A2
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=daynix-com.20210112.gappssmtp.com header.i=@daynix-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=hp9Oqw5d
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZMFm3oMvcgCs; Wed, 29 Mar 2023 11:03:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 6F92681E2D;
	Wed, 29 Mar 2023 11:03:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6F92681E2D
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 92B1BC002F;
	Wed, 29 Mar 2023 11:03:47 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1EA85C0037
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Mar 2023 11:03:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id CD2CA61460
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Mar 2023 11:03:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org CD2CA61460
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=daynix-com.20210112.gappssmtp.com
 header.i=@daynix-com.20210112.gappssmtp.com header.a=rsa-sha256
 header.s=20210112 header.b=hp9Oqw5d
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RYa7DAKyQgPc
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Mar 2023 11:03:44 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7EEEA61464
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7EEEA61464
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Mar 2023 11:03:44 +0000 (UTC)
Received: by mail-ed1-x52f.google.com with SMTP id y4so61600346edo.2
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Mar 2023 04:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20210112.gappssmtp.com; s=20210112; t=1680087824;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gTcU5HqVU1XgtuJ2Y8sd/OBjaB0pp67CpHcRkiVabVQ=;
 b=hp9Oqw5dPokqfYz22NTNm5CHcmPFA2qdpKFsieBHsz4KO70+K4slt8EpuWfc6ep4lp
 TYCGSsvwp0m6/9lSJ9u4U+XtDTleePGuvm92TS3wFIPH0sKpaOR+VOuBOWyaBcxhIprl
 FARrFe2ntTy9ipfwq7TB8Aks2TMPoxAFMbsBI3niPkMH2onKdvwgO+mN4vfgYTP4Sk5s
 560shzhQjKaKxTtm8+F4rijxkDlnGHGpR99TmIHlQ3334L8qfu1uZOGyBadXQSvoPu6v
 BsxD4OBg21M3czeMY3tXp5tf1EPM98Ho0kDC8lZY6x5niT/b/zLxAS7keWu0ZZTA+kz6
 8moQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1680087824;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gTcU5HqVU1XgtuJ2Y8sd/OBjaB0pp67CpHcRkiVabVQ=;
 b=MdCFVV03IY7C1bJrf5HHeOBJ1u6WqEqmZAG1XexQX30GlkN3rSGwG69ncDlMUr6zz/
 tvQQVAxHynVCwVjMBVo4KZDaRbybPIOkWKTk93ioVmsb1/fJ/Ce4s7uj2ngqwsFaFTGM
 zrOjf/+ququ7ut5w4t4J5Fz7nbwPXwBQM5r0ah5PSeIgjb+F/FVlfmknwmq9o75cMNOc
 yF3Oitkf5kUMcICEhy6dnZqLjToEJrLp5F8k4pCY6QrCYaaeZEaVtWwMOSWfWr27V1vJ
 Vid4j+Sfat01b8IOe71BRkmJ9cjClrRYVhVJlCGxDJCSxYPc9RVkhP0hIx9zdAQrsrbf
 H3eg==
X-Gm-Message-State: AAQBX9eKmFV8526wnzcPnELJ7GZL3H2mO2DbL6iaXAXpFZcxz1HZl9ss
 UwJPsXLGQRgXun7YpOX1jaNxCQ==
X-Google-Smtp-Source: AKy350Z+lk0YVQodaLqvLOoFXIYHXTVciDftd4mzJAORAhetfY/MF8nRkPvYHqDZI2pPUaUQRSSdsA==
X-Received: by 2002:a17:906:4d8b:b0:92f:7c42:8631 with SMTP id
 s11-20020a1709064d8b00b0092f7c428631mr18787825eju.16.1680087824034; 
 Wed, 29 Mar 2023 04:03:44 -0700 (PDT)
Received: from localhost.localdomain (178-133-100-41.mobile.vf-ua.net.
 [178.133.100.41]) by smtp.gmail.com with ESMTPSA id
 md12-20020a170906ae8c00b008e68d2c11d8sm16406975ejb.218.2023.03.29.04.03.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Mar 2023 04:03:43 -0700 (PDT)
From: Andrew Melnychenko <andrew@daynix.com>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, mst@redhat.com, jasowang@redhat.com,
 yoshfuji@linux-ipv6.org, dsahern@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
Subject: [RFC PATCH 3/5] ebpf: Added declaration/initialization routines.
Date: Wed, 29 Mar 2023 13:45:44 +0300
Message-Id: <20230329104546.108016-4-andrew@daynix.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230329104546.108016-1-andrew@daynix.com>
References: <20230329104546.108016-1-andrew@daynix.com>
MIME-Version: 1.0
Cc: yan@daynix.com, yuri.benditovich@daynix.com
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

Now, the binary objects may be retrieved by id/name.
It would require for future qmp commands that may require specific
eBPF blob.

Signed-off-by: Andrew Melnychenko <andrew@daynix.com>
---
 ebpf/ebpf.c      | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
 ebpf/ebpf.h      | 25 +++++++++++++++++++++++++
 ebpf/ebpf_rss.c  |  4 ++++
 ebpf/meson.build |  1 +
 4 files changed, 78 insertions(+)
 create mode 100644 ebpf/ebpf.c
 create mode 100644 ebpf/ebpf.h

diff --git a/ebpf/ebpf.c b/ebpf/ebpf.c
new file mode 100644
index 0000000000..86320d72f5
--- /dev/null
+++ b/ebpf/ebpf.c
@@ -0,0 +1,48 @@
+/*
+ * QEMU eBPF binary declaration routine.
+ *
+ * Developed by Daynix Computing LTD (http://www.daynix.com)
+ *
+ * Authors:
+ *  Andrew Melnychenko <andrew@daynix.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or
+ * later.  See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/queue.h"
+#include "ebpf/ebpf.h"
+
+struct ElfBinaryDataEntry {
+    const char *id;
+    const void * (*fn)(size_t *);
+
+    QSLIST_ENTRY(ElfBinaryDataEntry) node;
+};
+
+static QSLIST_HEAD(, ElfBinaryDataEntry) ebpf_elf_obj_list =
+                                            QSLIST_HEAD_INITIALIZER();
+
+void ebpf_register_binary_data(const char *id, const void * (*fn)(size_t *))
+{
+    struct ElfBinaryDataEntry *data = NULL;
+
+    data = g_malloc0(sizeof(*data));
+    data->fn = fn;
+    data->id = id;
+
+    QSLIST_INSERT_HEAD(&ebpf_elf_obj_list, data, node);
+}
+
+const void *ebpf_find_binary_by_id(const char *id, size_t *sz)
+{
+    struct ElfBinaryDataEntry *it = NULL;
+    QSLIST_FOREACH(it, &ebpf_elf_obj_list, node) {
+        if (strcmp(id, it->id) == 0) {
+            return it->fn(sz);
+        }
+    }
+
+    return NULL;
+}
diff --git a/ebpf/ebpf.h b/ebpf/ebpf.h
new file mode 100644
index 0000000000..fd705cb73e
--- /dev/null
+++ b/ebpf/ebpf.h
@@ -0,0 +1,25 @@
+/*
+ * QEMU eBPF binary declaration routine.
+ *
+ * Developed by Daynix Computing LTD (http://www.daynix.com)
+ *
+ * Authors:
+ *  Andrew Melnychenko <andrew@daynix.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or
+ * later.  See the COPYING file in the top-level directory.
+ */
+
+#ifndef EBPF_H
+#define EBPF_H
+
+void ebpf_register_binary_data(const char *id, const void * (*fn)(size_t *));
+const void *ebpf_find_binary_by_id(const char *id, size_t *sz);
+
+#define ebpf_binary_init(id, fn)                                           \
+static void __attribute__((constructor)) ebpf_binary_init_ ## fn(void)     \
+{                                                                          \
+    ebpf_register_binary_data(id, fn);                                     \
+}
+
+#endif /* EBPF_H */
diff --git a/ebpf/ebpf_rss.c b/ebpf/ebpf_rss.c
index 08015fecb1..b4038725f2 100644
--- a/ebpf/ebpf_rss.c
+++ b/ebpf/ebpf_rss.c
@@ -21,6 +21,8 @@
 
 #include "ebpf/ebpf_rss.h"
 #include "ebpf/rss.bpf.skeleton.h"
+#include "ebpf/ebpf.h"
+
 #include "trace.h"
 
 void ebpf_rss_init(struct EBPFRSSContext *ctx)
@@ -237,3 +239,5 @@ void ebpf_rss_unload(struct EBPFRSSContext *ctx)
     ctx->obj = NULL;
     ctx->program_fd = -1;
 }
+
+ebpf_binary_init("rss", rss_bpf__elf_bytes)
diff --git a/ebpf/meson.build b/ebpf/meson.build
index 2dd0fd8948..67c3f53aa9 100644
--- a/ebpf/meson.build
+++ b/ebpf/meson.build
@@ -1 +1,2 @@
+softmmu_ss.add(files('ebpf.c'))
 softmmu_ss.add(when: libbpf, if_true: files('ebpf_rss.c'), if_false: files('ebpf_rss-stub.c'))
-- 
2.39.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
