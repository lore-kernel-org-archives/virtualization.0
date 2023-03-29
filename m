Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 882BDC77B6E
	for <virtualization@archiver.kernel.org>; Wed, 29 Mar 2023 11:03:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 6F87241D00;
	Wed, 29 Mar 2023 11:03:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6F87241D00
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=daynix-com.20210112.gappssmtp.com header.i=@daynix-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=Yy5k9qZE
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AruldR1meuOZ; Wed, 29 Mar 2023 11:03:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id E49F441D05;
	Wed, 29 Mar 2023 11:03:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E49F441D05
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C0CE9C0091;
	Wed, 29 Mar 2023 11:03:47 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3AB81C008E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Mar 2023 11:03:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4C9B481760
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Mar 2023 11:03:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4C9B481760
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=daynix-com.20210112.gappssmtp.com
 header.i=@daynix-com.20210112.gappssmtp.com header.a=rsa-sha256
 header.s=20210112 header.b=Yy5k9qZE
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 98nv92hTFw1J
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Mar 2023 11:03:44 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 58B958194C
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 58B958194C
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Mar 2023 11:03:44 +0000 (UTC)
Received: by mail-ed1-x52c.google.com with SMTP id r11so61542072edd.5
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Mar 2023 04:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20210112.gappssmtp.com; s=20210112; t=1680087822;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DslxHK6KBlhiVdu3Lr2KxbgUyV3iiwJejUtCbzhCHrg=;
 b=Yy5k9qZEJOVBgeYN+QLmeqRbC7KZuQGj8fxV1P1wv2QR/sUQHJaSjxK/EfY8bu2quQ
 E7/aHYMvw+AlJHkzNq+d6wkXAaiw4NSeudky28BWk3pWDBboxyqwYTCNAyKMhpCecREJ
 2WnWEb0e14cv8l4h9uUxiiQIeeWmiWQzGDIKOS5HnLSzsVCLeXP59swtQDl8VkjAg0uA
 OLMC69ugF//IudDWJBTDrw5QJfDhYWywaz8PjGTJONmnpsEPp9lSFFyqOWgal0tW/Rfh
 JEFAXEa6dP40HO61CT6wc4MpRKTECR1yZQf/R0RsgezvfrZ6wG4RXjucNsIp0QCpWH4U
 rktA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1680087822;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DslxHK6KBlhiVdu3Lr2KxbgUyV3iiwJejUtCbzhCHrg=;
 b=jwBddS7dQo645l/HA+8d+mzKCHYnBW1rBGGEVL/Hi69eAHlPUkaOxCAfAcepT11jwx
 vdOVtaFxiaUI16BCWS/NuTqzFbbce1mCdgfCYTY8g48wQK6TW0ZH0GQdoB2rM8ux/QNy
 ZZdSqlzX/l89jcAhn+fMUkt7dyenYKEb+T1mzJ9D/BYYtxP/gHiTXKXVI1yoc/hvfHkf
 Vx0LAF/cqskXp/KSRyY8E4R6vHX/teQ31fkLf/RdnUa6+EXFAj46uQoKlhYmgCHw8PlE
 ynSUcuU2T2jEgKND7tt/5252pYvbrzjUqKf5mGVqhnrEvCCxwlJPSuYKIQLmBabL0vhG
 l+xQ==
X-Gm-Message-State: AAQBX9f08AVdjZSuHnhVhLyR9Lru8Vt/ixQWVx66yNnjzQ9QBDTyP4Ef
 zQdd56LP2MGulSt/SeHDsE1Oxg==
X-Google-Smtp-Source: AKy350bAeJm/lTdNut+XFjwpE5mB8COw9m59DKjlI8EOn4LXgTEkUyvLPcmriazqkZ4ieGvpm+xugw==
X-Received: by 2002:a17:906:612:b0:933:4d47:55b7 with SMTP id
 s18-20020a170906061200b009334d4755b7mr1840523ejb.2.1680087822487; 
 Wed, 29 Mar 2023 04:03:42 -0700 (PDT)
Received: from localhost.localdomain (178-133-100-41.mobile.vf-ua.net.
 [178.133.100.41]) by smtp.gmail.com with ESMTPSA id
 md12-20020a170906ae8c00b008e68d2c11d8sm16406975ejb.218.2023.03.29.04.03.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Mar 2023 04:03:42 -0700 (PDT)
From: Andrew Melnychenko <andrew@daynix.com>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, mst@redhat.com, jasowang@redhat.com,
 yoshfuji@linux-ipv6.org, dsahern@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
Subject: [RFC PATCH 2/5] virtio-net: Added property to load eBPF RSS with fds.
Date: Wed, 29 Mar 2023 13:45:43 +0300
Message-Id: <20230329104546.108016-3-andrew@daynix.com>
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

eBPF RSS program and maps may now be passed during initialization.
Initially was implemented for libvirt to launch qemu without permissions,
and initialized eBPF program through the helper.

Signed-off-by: Andrew Melnychenko <andrew@daynix.com>
---
 hw/net/virtio-net.c            | 77 ++++++++++++++++++++++++++++++++--
 include/hw/virtio/virtio-net.h |  1 +
 2 files changed, 74 insertions(+), 4 deletions(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 53e1c32643..45d448a83d 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -42,6 +42,7 @@
 #include "sysemu/sysemu.h"
 #include "trace.h"
 #include "monitor/qdev.h"
+#include "monitor/monitor.h"
 #include "hw/pci/pci_device.h"
 #include "net_rx_pkt.h"
 #include "hw/virtio/vhost.h"
@@ -1305,14 +1306,81 @@ static void virtio_net_detach_epbf_rss(VirtIONet *n)
     virtio_net_attach_ebpf_to_backend(n->nic, -1);
 }
 
-static bool virtio_net_load_ebpf(VirtIONet *n)
+static int virtio_net_get_ebpf_rss_fds(char *str, char *fds[], int nfds)
+{
+    char *ptr = str;
+    char *cur = NULL;
+    size_t len = strlen(str);
+    int i = 0;
+
+    for (; i < nfds && ptr < str + len;) {
+        cur = strchr(ptr, ':');
+
+        if (cur == NULL) {
+            fds[i] = g_strdup(ptr);
+        } else {
+            fds[i] = g_strndup(ptr, cur - ptr);
+        }
+
+        i++;
+        if (cur == NULL) {
+            break;
+        } else {
+            ptr = cur + 1;
+        }
+    }
+
+    return i;
+}
+
+static bool virtio_net_load_ebpf_fds(VirtIONet *n)
 {
-    if (!virtio_net_attach_ebpf_to_backend(n->nic, -1)) {
-        /* backend does't support steering ebpf */
+    char *fds_strs[EBPF_RSS_MAX_FDS];
+    int fds[EBPF_RSS_MAX_FDS];
+    int nfds;
+    int ret = false;
+    Error *errp;
+    int i = 0;
+
+    if (n == NULL || !n->ebpf_rss_fds) {
         return false;
     }
 
-    return ebpf_rss_load(&n->ebpf_rss);
+    nfds = virtio_net_get_ebpf_rss_fds(n->ebpf_rss_fds,
+                                       fds_strs, EBPF_RSS_MAX_FDS);
+    for (i = 0; i < nfds; i++) {
+        fds[i] = monitor_fd_param(monitor_cur(), fds_strs[i], &errp);
+    }
+
+    if (nfds == EBPF_RSS_MAX_FDS) {
+        ret = ebpf_rss_load_fds(&n->ebpf_rss, fds[0], fds[1], fds[2], fds[3]);
+    }
+
+    if (!ret) {
+        for (i = 0; i < nfds; i++) {
+            close(fds[i]);
+        }
+    }
+
+    for (i = 0; i < nfds; i++) {
+        g_free(fds_strs[i]);
+    }
+
+    return ret;
+}
+
+static bool virtio_net_load_ebpf(VirtIONet *n)
+{
+    bool ret = true;
+
+    if (virtio_net_attach_ebpf_to_backend(n->nic, -1)) {
+        if (!(n->ebpf_rss_fds
+                && virtio_net_load_ebpf_fds(n))) {
+            ret = ebpf_rss_load(&n->ebpf_rss);
+        }
+    }
+
+    return ret;
 }
 
 static void virtio_net_unload_ebpf(VirtIONet *n)
@@ -3900,6 +3968,7 @@ static Property virtio_net_properties[] = {
                     VIRTIO_NET_F_RSS, false),
     DEFINE_PROP_BIT64("hash", VirtIONet, host_features,
                     VIRTIO_NET_F_HASH_REPORT, false),
+    DEFINE_PROP_STRING("ebpf_rss_fds", VirtIONet, ebpf_rss_fds),
     DEFINE_PROP_BIT64("guest_rsc_ext", VirtIONet, host_features,
                     VIRTIO_NET_F_RSC_EXT, false),
     DEFINE_PROP_UINT32("rsc_interval", VirtIONet, rsc_timeout,
diff --git a/include/hw/virtio/virtio-net.h b/include/hw/virtio/virtio-net.h
index ef234ffe7e..e10ce88f91 100644
--- a/include/hw/virtio/virtio-net.h
+++ b/include/hw/virtio/virtio-net.h
@@ -219,6 +219,7 @@ struct VirtIONet {
     VirtioNetRssData rss_data;
     struct NetRxPkt *rx_pkt;
     struct EBPFRSSContext ebpf_rss;
+    char *ebpf_rss_fds;
 };
 
 size_t virtio_net_handle_ctrl_iov(VirtIODevice *vdev,
-- 
2.39.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
