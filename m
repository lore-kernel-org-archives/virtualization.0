Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9F75C77B6D
	for <virtualization@archiver.kernel.org>; Wed, 29 Mar 2023 11:03:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 628EE41CFF;
	Wed, 29 Mar 2023 11:03:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 628EE41CFF
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=daynix-com.20210112.gappssmtp.com header.i=@daynix-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=PyXqtCFO
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vza5pa1dqi-I; Wed, 29 Mar 2023 11:03:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 84B7441CFE;
	Wed, 29 Mar 2023 11:03:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 84B7441CFE
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 55169C0037;
	Wed, 29 Mar 2023 11:03:47 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 156C4C002F
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Mar 2023 11:03:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id CD3DA41CFE
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Mar 2023 11:03:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org CD3DA41CFE
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id j-MZLgi-97IL
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Mar 2023 11:03:43 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org AA37D41CF2
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 by smtp2.osuosl.org (Postfix) with ESMTPS id AA37D41CF2
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Mar 2023 11:03:42 +0000 (UTC)
Received: by mail-ed1-x52b.google.com with SMTP id h8so61518533ede.8
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Mar 2023 04:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20210112.gappssmtp.com; s=20210112; t=1680087821;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sgkQXYn3YvfKra4NCcSBXfsEMksh5BTkjMQUOsqzQ+E=;
 b=PyXqtCFO9sUJPCeSPkIEmRh8FWBqXOozOdxoBOtp13ZPwfu2XqgpcQHD9xXGxYH8nF
 FdxSb6DoaLJEo+PNa/u7phzZ1sKHGiYH8RZgZ/BMDdtg6kLf3QJ1N6Bpmtdu+2eyDCU7
 88SI0rm1IFIcqZwPFlYZYgd4dacEUDmopzYRfR4sq7U+oHHBlIMB2uSP4KBctQ0lweF7
 TPhYelCVdkqatgMfUDEik7jwHrbD95WYipLN1rwpRIB0up2diBsHISSMmGS6Po+YueYH
 EWvIuaO9Gmyw+lVTRBvkxRCVSPEMg72Bvl3JTPNxj/JoPQclpSvVYCX3fv9Ia7EBcYuH
 auYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1680087821;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sgkQXYn3YvfKra4NCcSBXfsEMksh5BTkjMQUOsqzQ+E=;
 b=cL6Xd5zNcb1yFjcc265gsAxlR3laPIVqSjQjLyjiHoiFNbAKTkJHW51TToISNNWggt
 hJftAlh4vJ0s5ydIbEcVahevKfDknc8Fkvc6HA7mEHfK/4XixAEcAtFImjIAWd8daDNw
 jplYzoOfcZKBtj3Z+AiU5P0TSSUXEqDcGa494KqdpkPPXH38rvJlJ2svy7xu5Je1D/tE
 ggAAim6Tw1yt88pG+1TgW4QCicj/ZCme1JXv+FEVTFacgY7+r2JbRQPpm8GTBQa/tROb
 3AtbHVL7YikFHyuj9nIHIdktpZQkEVBC8qZ7JMy2kssEvLRsekLQh8ZqxxJITfct7FTA
 UH1A==
X-Gm-Message-State: AAQBX9dkNkXmJ+bqHXLFhJVc9oTw+hVH6+Ux9CcX//bWUuHLNimjZFbS
 dda1WavrM8bt1y/QM3ggr2yO0Q==
X-Google-Smtp-Source: AKy350YVv7Jjg2cwb1XC3RAht9uck1L9ofHTnZ3fV4u3BfIkFVj0v5m/3Zogk8uZKU5pxcu4H7XDZQ==
X-Received: by 2002:a17:906:e0c5:b0:931:4f2c:4e83 with SMTP id
 gl5-20020a170906e0c500b009314f2c4e83mr19049817ejb.63.1680087820834; 
 Wed, 29 Mar 2023 04:03:40 -0700 (PDT)
Received: from localhost.localdomain (178-133-100-41.mobile.vf-ua.net.
 [178.133.100.41]) by smtp.gmail.com with ESMTPSA id
 md12-20020a170906ae8c00b008e68d2c11d8sm16406975ejb.218.2023.03.29.04.03.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Mar 2023 04:03:40 -0700 (PDT)
From: Andrew Melnychenko <andrew@daynix.com>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, mst@redhat.com, jasowang@redhat.com,
 yoshfuji@linux-ipv6.org, dsahern@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
Subject: [RFC PATCH 1/5] ebpf: Added eBPF initialization by fds and map update.
Date: Wed, 29 Mar 2023 13:45:42 +0300
Message-Id: <20230329104546.108016-2-andrew@daynix.com>
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

Changed eBPF map updates through mmaped array.
Mmaped arrays provide direct access to map data.
It should omit using bpf_map_update_elem() call,
which may require capabilities that are not present.

Signed-off-by: Andrew Melnychenko <andrew@daynix.com>
---
 ebpf/ebpf_rss-stub.c |   6 +++
 ebpf/ebpf_rss.c      | 120 ++++++++++++++++++++++++++++++++++---------
 ebpf/ebpf_rss.h      |  10 ++++
 3 files changed, 113 insertions(+), 23 deletions(-)

diff --git a/ebpf/ebpf_rss-stub.c b/ebpf/ebpf_rss-stub.c
index e71e229190..8d7fae2ad9 100644
--- a/ebpf/ebpf_rss-stub.c
+++ b/ebpf/ebpf_rss-stub.c
@@ -28,6 +28,12 @@ bool ebpf_rss_load(struct EBPFRSSContext *ctx)
     return false;
 }
 
+bool ebpf_rss_load_fds(struct EBPFRSSContext *ctx, int program_fd,
+                       int config_fd, int toeplitz_fd, int table_fd)
+{
+    return false;
+}
+
 bool ebpf_rss_set_all(struct EBPFRSSContext *ctx, struct EBPFRSSConfig *config,
                       uint16_t *indirections_table, uint8_t *toeplitz_key)
 {
diff --git a/ebpf/ebpf_rss.c b/ebpf/ebpf_rss.c
index cee658c158..08015fecb1 100644
--- a/ebpf/ebpf_rss.c
+++ b/ebpf/ebpf_rss.c
@@ -27,19 +27,68 @@ void ebpf_rss_init(struct EBPFRSSContext *ctx)
 {
     if (ctx != NULL) {
         ctx->obj = NULL;
+        ctx->program_fd = -1;
     }
 }
 
 bool ebpf_rss_is_loaded(struct EBPFRSSContext *ctx)
 {
-    return ctx != NULL && ctx->obj != NULL;
+    return ctx != NULL && (ctx->obj != NULL || ctx->program_fd != -1);
+}
+
+static bool ebpf_rss_mmap(struct EBPFRSSContext *ctx)
+{
+    if (!ebpf_rss_is_loaded(ctx)) {
+        return false;
+    }
+
+    ctx->mmap_configuration = mmap(NULL, qemu_real_host_page_size(),
+                                   PROT_READ | PROT_WRITE, MAP_SHARED,
+                                   ctx->map_configuration, 0);
+    if (ctx->mmap_configuration == MAP_FAILED) {
+        trace_ebpf_error("eBPF RSS", "can not mmap eBPF configuration array");
+        return false;
+    }
+    ctx->mmap_toeplitz_key = mmap(NULL, qemu_real_host_page_size(),
+                                   PROT_READ | PROT_WRITE, MAP_SHARED,
+                                   ctx->map_toeplitz_key, 0);
+    if (ctx->mmap_toeplitz_key == MAP_FAILED) {
+        trace_ebpf_error("eBPF RSS", "can not mmap eBPF toeplitz key");
+        goto toeplitz_fail;
+    }
+    ctx->mmap_indirections_table = mmap(NULL, qemu_real_host_page_size(),
+                                   PROT_READ | PROT_WRITE, MAP_SHARED,
+                                   ctx->map_indirections_table, 0);
+    if (ctx->mmap_indirections_table == MAP_FAILED) {
+        trace_ebpf_error("eBPF RSS", "can not mmap eBPF indirection table");
+        goto indirection_fail;
+    }
+
+    return true;
+
+indirection_fail:
+    munmap(ctx->mmap_toeplitz_key, qemu_real_host_page_size());
+toeplitz_fail:
+    munmap(ctx->mmap_configuration, qemu_real_host_page_size());
+    return false;
+}
+
+static void ebpf_rss_munmap(struct EBPFRSSContext *ctx)
+{
+    if (!ebpf_rss_is_loaded(ctx)) {
+        return;
+    }
+
+    munmap(ctx->mmap_indirections_table, qemu_real_host_page_size());
+    munmap(ctx->mmap_toeplitz_key, qemu_real_host_page_size());
+    munmap(ctx->mmap_configuration, qemu_real_host_page_size());
 }
 
 bool ebpf_rss_load(struct EBPFRSSContext *ctx)
 {
     struct rss_bpf *rss_bpf_ctx;
 
-    if (ctx == NULL) {
+    if (ctx == NULL || ebpf_rss_is_loaded(ctx)) {
         return false;
     }
 
@@ -66,26 +115,51 @@ bool ebpf_rss_load(struct EBPFRSSContext *ctx)
     ctx->map_toeplitz_key = bpf_map__fd(
             rss_bpf_ctx->maps.tap_rss_map_toeplitz_key);
 
+    if (!ebpf_rss_mmap(ctx)) {
+        goto error;
+    }
+
     return true;
 error:
     rss_bpf__destroy(rss_bpf_ctx);
     ctx->obj = NULL;
+    ctx->program_fd = -1;
 
     return false;
 }
 
-static bool ebpf_rss_set_config(struct EBPFRSSContext *ctx,
-                                struct EBPFRSSConfig *config)
+bool ebpf_rss_load_fds(struct EBPFRSSContext *ctx, int program_fd,
+                       int config_fd, int toeplitz_fd, int table_fd)
 {
-    uint32_t map_key = 0;
+    if (ctx == NULL || ebpf_rss_is_loaded(ctx)) {
+        return false;
+    }
 
-    if (!ebpf_rss_is_loaded(ctx)) {
+    if (program_fd < 0 || config_fd < 0 || toeplitz_fd < 0 || table_fd < 0) {
         return false;
     }
-    if (bpf_map_update_elem(ctx->map_configuration,
-                            &map_key, config, 0) < 0) {
+
+    ctx->program_fd = program_fd;
+    ctx->map_configuration = config_fd;
+    ctx->map_toeplitz_key = toeplitz_fd;
+    ctx->map_indirections_table = table_fd;
+
+    if (!ebpf_rss_mmap(ctx)) {
+        ctx->program_fd = -1;
         return false;
     }
+
+    return true;
+}
+
+static bool ebpf_rss_set_config(struct EBPFRSSContext *ctx,
+                                struct EBPFRSSConfig *config)
+{
+    if (!ebpf_rss_is_loaded(ctx)) {
+        return false;
+    }
+
+    memcpy(ctx->mmap_configuration, config, sizeof(*config));
     return true;
 }
 
@@ -93,27 +167,19 @@ static bool ebpf_rss_set_indirections_table(struct EBPFRSSContext *ctx,
                                             uint16_t *indirections_table,
                                             size_t len)
 {
-    uint32_t i = 0;
-
     if (!ebpf_rss_is_loaded(ctx) || indirections_table == NULL ||
        len > VIRTIO_NET_RSS_MAX_TABLE_LEN) {
         return false;
     }
 
-    for (; i < len; ++i) {
-        if (bpf_map_update_elem(ctx->map_indirections_table, &i,
-                                indirections_table + i, 0) < 0) {
-            return false;
-        }
-    }
+    memcpy(ctx->mmap_indirections_table, indirections_table,
+            sizeof(*indirections_table) * len);
     return true;
 }
 
 static bool ebpf_rss_set_toepliz_key(struct EBPFRSSContext *ctx,
                                      uint8_t *toeplitz_key)
 {
-    uint32_t map_key = 0;
-
     /* prepare toeplitz key */
     uint8_t toe[VIRTIO_NET_RSS_MAX_KEY_SIZE] = {};
 
@@ -123,10 +189,7 @@ static bool ebpf_rss_set_toepliz_key(struct EBPFRSSContext *ctx,
     memcpy(toe, toeplitz_key, VIRTIO_NET_RSS_MAX_KEY_SIZE);
     *(uint32_t *)toe = ntohl(*(uint32_t *)toe);
 
-    if (bpf_map_update_elem(ctx->map_toeplitz_key, &map_key, toe,
-                            0) < 0) {
-        return false;
-    }
+    memcpy(ctx->mmap_toeplitz_key, toe, VIRTIO_NET_RSS_MAX_KEY_SIZE);
     return true;
 }
 
@@ -160,6 +223,17 @@ void ebpf_rss_unload(struct EBPFRSSContext *ctx)
         return;
     }
 
-    rss_bpf__destroy(ctx->obj);
+    ebpf_rss_munmap(ctx);
+
+    if (ctx->obj) {
+        rss_bpf__destroy(ctx->obj);
+    } else {
+        close(ctx->program_fd);
+        close(ctx->map_configuration);
+        close(ctx->map_toeplitz_key);
+        close(ctx->map_indirections_table);
+    }
+
     ctx->obj = NULL;
+    ctx->program_fd = -1;
 }
diff --git a/ebpf/ebpf_rss.h b/ebpf/ebpf_rss.h
index bf3f2572c7..239242b0d2 100644
--- a/ebpf/ebpf_rss.h
+++ b/ebpf/ebpf_rss.h
@@ -14,12 +14,19 @@
 #ifndef QEMU_EBPF_RSS_H
 #define QEMU_EBPF_RSS_H
 
+#define EBPF_RSS_MAX_FDS 4
+
 struct EBPFRSSContext {
     void *obj;
     int program_fd;
     int map_configuration;
     int map_toeplitz_key;
     int map_indirections_table;
+
+    /* mapped eBPF maps for direct access to omit bpf_map_update_elem() */
+    void *mmap_configuration;
+    void *mmap_toeplitz_key;
+    void *mmap_indirections_table;
 };
 
 struct EBPFRSSConfig {
@@ -36,6 +43,9 @@ bool ebpf_rss_is_loaded(struct EBPFRSSContext *ctx);
 
 bool ebpf_rss_load(struct EBPFRSSContext *ctx);
 
+bool ebpf_rss_load_fds(struct EBPFRSSContext *ctx, int program_fd,
+                       int config_fd, int toeplitz_fd, int table_fd);
+
 bool ebpf_rss_set_all(struct EBPFRSSContext *ctx, struct EBPFRSSConfig *config,
                       uint16_t *indirections_table, uint8_t *toeplitz_key);
 
-- 
2.39.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
