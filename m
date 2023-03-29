Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BD8CC761A6
	for <virtualization@archiver.kernel.org>; Wed, 29 Mar 2023 11:03:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 219096146A;
	Wed, 29 Mar 2023 11:03:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 219096146A
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=daynix-com.20210112.gappssmtp.com header.i=@daynix-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=1dcJ+wPm
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OdoWRZ_wowPD; Wed, 29 Mar 2023 11:03:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 9EB7760E90;
	Wed, 29 Mar 2023 11:03:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9EB7760E90
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7565AC008A;
	Wed, 29 Mar 2023 11:03:54 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E796DC002F
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Mar 2023 11:03:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 291ED6146D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Mar 2023 11:03:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 291ED6146D
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BFbKfLIo1et2
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Mar 2023 11:03:47 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 592B761464
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 592B761464
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Mar 2023 11:03:47 +0000 (UTC)
Received: by mail-ed1-x52e.google.com with SMTP id eh3so61447651edb.11
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Mar 2023 04:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20210112.gappssmtp.com; s=20210112; t=1680087825;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wrfwKePkllnALnkJ2zV/3yw/+BvIeTv0XWFEcNBw8YA=;
 b=1dcJ+wPmxC9snk2hmBPEKQoXzNuJWkkqm3ON1LX6qgcNx0LODC4FnhV8ZDgh9qxxHz
 7bHUxRbbIvcjerza/iEoLvHl/lR3VWp5km9cVI831ypXHNgO0EkUg+sUCcVYo0zNUIf2
 CjJFDKin+n+wlWQiU4Ggips5+i45qU30QX6d10hw3dKuiBqoNWtEJ+FMk0F3ewl9x3cc
 RCIG2QP0Djcave7xpgQw7q08JJEQ/ItGsBLMEDkxNn000ZCZ3KQowjl0Yf/4+4/osAFQ
 rvj/Nc5iwAAUJxjYpbKb6v6nG5yq6R19STcdmxfA1jsF2WqiJFIemuvit3TIY6a1HiGN
 MGYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1680087825;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wrfwKePkllnALnkJ2zV/3yw/+BvIeTv0XWFEcNBw8YA=;
 b=7rvgEp/Wcsdo6eFs3nDMoxrBxJ5vE80hjT0fGD+WW63YJKkDLHDMcd9802gaR4VlLV
 aZS4BpukatPoWbu9bbIOGEkh1N+viAx4i2JUY4wylllLvdnfMge+cqXEKBOWlwykj7E+
 ykjGExpyV0g+0tZUms8pIccAgtIuU+21ftZeAF8tlT1yuTWY1lyGxLfG9SqtyD0I8GYJ
 zrxSahUDZHffshKZaI+dfj+8dn/gkSYU7nNd+TLJxFwD0pffff6qYHfXGOCu5sTbbBlc
 cnh5bW2H7+RMkMCNocF4dyJShrDYVyeacpGvZx0SWxNMoVWTemvW7l13TH05FfyOfpr5
 2Oug==
X-Gm-Message-State: AAQBX9cZM8CeMou4O1H79nyVBYR3J754S1hO6X+MzTxPppgd0NoOyi3W
 y6owG9B601Af627mY2ox6T4uvw==
X-Google-Smtp-Source: AKy350Z16UKXumN3KnQDzRbKZJX9u64esHjbx9gtBr5Z8d0SvvEDLi9zU2vbK4QEzPWAONlYBMhi9A==
X-Received: by 2002:a17:906:71d7:b0:8a6:5720:9101 with SMTP id
 i23-20020a17090671d700b008a657209101mr20733205ejk.4.1680087825633; 
 Wed, 29 Mar 2023 04:03:45 -0700 (PDT)
Received: from localhost.localdomain (178-133-100-41.mobile.vf-ua.net.
 [178.133.100.41]) by smtp.gmail.com with ESMTPSA id
 md12-20020a170906ae8c00b008e68d2c11d8sm16406975ejb.218.2023.03.29.04.03.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Mar 2023 04:03:45 -0700 (PDT)
From: Andrew Melnychenko <andrew@daynix.com>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, mst@redhat.com, jasowang@redhat.com,
 yoshfuji@linux-ipv6.org, dsahern@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
Subject: [RFC PATCH 4/5] qmp: Added new command to retrieve eBPF blob.
Date: Wed, 29 Mar 2023 13:45:45 +0300
Message-Id: <20230329104546.108016-5-andrew@daynix.com>
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

Added command "request-ebpf". This command returns
eBPF program encoded base64. The program taken from the
skeleton and essentially is an ELF object that can be
loaded in the future with libbpf.

Signed-off-by: Andrew Melnychenko <andrew@daynix.com>
---
 monitor/qmp-cmds.c | 17 +++++++++++++++++
 qapi/misc.json     | 25 +++++++++++++++++++++++++
 2 files changed, 42 insertions(+)

diff --git a/monitor/qmp-cmds.c b/monitor/qmp-cmds.c
index b0f948d337..8f2fc3e7ec 100644
--- a/monitor/qmp-cmds.c
+++ b/monitor/qmp-cmds.c
@@ -32,6 +32,7 @@
 #include "hw/mem/memory-device.h"
 #include "hw/intc/intc.h"
 #include "hw/rdma/rdma.h"
+#include "ebpf/ebpf.h"
 
 NameInfo *qmp_query_name(Error **errp)
 {
@@ -209,3 +210,19 @@ static void __attribute__((__constructor__)) monitor_init_qmp_commands(void)
                          qmp_marshal_qmp_capabilities,
                          QCO_ALLOW_PRECONFIG, 0);
 }
+
+EbpfObject *qmp_request_ebpf(const char *id, Error **errp)
+{
+    EbpfObject *ret = NULL;
+    size_t size = 0;
+    const guchar *data = ebpf_find_binary_by_id(id, &size);
+
+    if (data) {
+        ret = g_new0(EbpfObject, 1);
+        ret->object = g_base64_encode(data, size);
+    } else {
+        error_setg(errp, "can't find eBPF object with id: %s", id);
+    }
+
+    return ret;
+}
diff --git a/qapi/misc.json b/qapi/misc.json
index 6ddd16ea28..4689802460 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -618,3 +618,28 @@
 { 'event': 'VFU_CLIENT_HANGUP',
   'data': { 'vfu-id': 'str', 'vfu-qom-path': 'str',
             'dev-id': 'str', 'dev-qom-path': 'str' } }
+
+##
+# @EbpfObject:
+#
+# Structure that holds eBPF ELF object encoded in base64.
+##
+{ 'struct': 'EbpfObject',
+  'data': {'object': 'str'} }
+
+##
+# @request-ebpf:
+#
+# Function returns eBPF object that can be loaded with libbpf.
+# Management applications (g.e. libvirt) may load it and pass file
+# descriptors to QEMU. Which allows running QEMU without BPF capabilities.
+#
+# Returns: RSS eBPF object encoded in base64.
+#
+# Since: 7.3
+#
+##
+{ 'command': 'request-ebpf',
+  'data': { 'id': 'str' },
+  'returns': 'EbpfObject' }
+
-- 
2.39.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
