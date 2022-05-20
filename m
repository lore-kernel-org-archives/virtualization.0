Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 177E8C433EF
	for <virtualization@archiver.kernel.org>; Fri, 20 May 2022 07:11:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B4F4242551;
	Fri, 20 May 2022 07:11:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CoL8U8UYliNO; Fri, 20 May 2022 07:11:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id F27AA4254F;
	Fri, 20 May 2022 07:11:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C8D7CC0032;
	Fri, 20 May 2022 07:11:09 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B0059C002D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 20 May 2022 07:11:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 917F042550
 for <virtualization@lists.linux-foundation.org>;
 Fri, 20 May 2022 07:11:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4Z-8guA8mwZZ
 for <virtualization@lists.linux-foundation.org>;
 Fri, 20 May 2022 07:11:07 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com
 [IPv6:2607:f8b0:4864:20::533])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C4C004254F
 for <virtualization@lists.linux-foundation.org>;
 Fri, 20 May 2022 07:11:07 +0000 (UTC)
Received: by mail-pg1-x533.google.com with SMTP id a19so7015104pgw.6
 for <virtualization@lists.linux-foundation.org>;
 Fri, 20 May 2022 00:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20210112.gappssmtp.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=0KUgn4q69DG5zIlC1bOLKat5AESimquHJFEcH7Mymww=;
 b=RnsS8rlcaqrcj3RhK36pn8NouGunnnwM0GWKWK3X1PoabzQ9x/1iAvkQLVXobtqqiM
 ckZSnIumZQpT0Pn4mHGXaQGJs831i9051mt2zMMjIB2XhqpiqHY8bdQK0fBaG0UzRLoL
 naPm0yF6A6L94p3Q2Soc1gjNiohCOmp8PNK2xsJ1qIt96FT3yDkxJr3YdN+/AofbvEvv
 viiJ12IC5jdwnOJpCr2ZYAjcUz0d5cNGgjyvZNDDRv2FFmf08kbSdTBBLUn+EpnaRT41
 YrATyb3OhG5XZvVh8xQe3R/6NeJ9DaM/oG6826oJKua/ka22lR8KaQ90kEd3mlS4ekaU
 2VZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=0KUgn4q69DG5zIlC1bOLKat5AESimquHJFEcH7Mymww=;
 b=ZuUCfCJUAEsJNBDbWY7WudPkGoeAi0oTdsBy8aK51/vO6OdsGKQqRUiKJHlyN+fmiT
 rHMt+yG8x87oyUFzsb6iL5B3QY4oeWeM7N7IwOTYFUnBUpe3l6qbZz6oTdriziGjFcsf
 EbqQOoJMU1iXJSNrh47Oyg+Te1dQ58R7F4HRpF0r3/q1osEGgkHAHlSh9gogyUI8HbCH
 Bk5fdMoag/gk11Q/atGVnTe7lbUm53f87JE1L3PTcuPF7NgnFXVqiLNwzLUzpI4U3S8W
 G6QPoJnIRDBFnWQKqKbTvkJ/2VbqETWEr9qQErHvcwa8yWyLmG9b+ALs6glq0vFZ8aeU
 adxQ==
X-Gm-Message-State: AOAM533ZFEg8RKrKwiGwYonkMkgQWAygC+8vKGAtIdLG+bREIp1ahW23
 VRCRcc90pQ5AeyUsDkAvQP3Cyg==
X-Google-Smtp-Source: ABdhPJy2CdwQr543isCK/keOAsVtpqVPpZ286CuyvQTXDJe5qsQURjhpmTDYka3gLq4fZ2UvZmCJZg==
X-Received: by 2002:a63:5a09:0:b0:3c2:5dfa:285c with SMTP id
 o9-20020a635a09000000b003c25dfa285cmr7271718pgb.381.1653030667026; 
 Fri, 20 May 2022 00:11:07 -0700 (PDT)
Received: from always-x1.www.tendawifi.com ([139.177.225.255])
 by smtp.gmail.com with ESMTPSA id
 t18-20020a170902d21200b00161b3d5e3e4sm4965168ply.304.2022.05.20.00.11.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 May 2022 00:11:05 -0700 (PDT)
From: zhenwei pi <pizhenwei@bytedance.com>
To: akpm@linux-foundation.org, naoya.horiguchi@nec.com, mst@redhat.com,
 david@redhat.com
Subject: [PATCH 1/3] memory-failure: Introduce memory failure notifier
Date: Fri, 20 May 2022 15:06:46 +0800
Message-Id: <20220520070648.1794132-2-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220520070648.1794132-1-pizhenwei@bytedance.com>
References: <20220520070648.1794132-1-pizhenwei@bytedance.com>
MIME-Version: 1.0
Cc: qemu-devel@nongnu.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
 zhenwei pi <pizhenwei@bytedance.com>, pbonzini@redhat.com
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

Introduce memory failure notifier, once hardware memory failure
occurs, after the kernel handles the corrupted page successfully,
someone who registered this chain gets noticed of the corrupted PFN.

Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
---
 include/linux/mm.h  |  2 ++
 mm/memory-failure.c | 33 +++++++++++++++++++++++++++++++++
 2 files changed, 35 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 9f44254af8ce..665873c2788c 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3197,6 +3197,8 @@ extern int sysctl_memory_failure_recovery;
 extern void shake_page(struct page *p);
 extern atomic_long_t num_poisoned_pages __read_mostly;
 extern int soft_offline_page(unsigned long pfn, int flags);
+extern int register_memory_failure_notifier(struct notifier_block *nb);
+extern int unregister_memory_failure_notifier(struct notifier_block *nb);
 #ifdef CONFIG_MEMORY_FAILURE
 extern int __get_huge_page_for_hwpoison(unsigned long pfn, int flags);
 #else
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 2d590cba412c..95c218bb0a37 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -68,6 +68,35 @@ int sysctl_memory_failure_recovery __read_mostly = 1;
 
 atomic_long_t num_poisoned_pages __read_mostly = ATOMIC_LONG_INIT(0);
 
+static BLOCKING_NOTIFIER_HEAD(mf_notifier_list);
+
+/**
+ * register_memory_failure_notifier - Register function to be called if a
+ *                                    corrupted page gets handled successfully
+ * @nb: Info about notifier function to be called
+ *
+ * Currently always returns zero, as blocking_notifier_chain_register()
+ * always returns zero.
+ */
+int register_memory_failure_notifier(struct notifier_block *nb)
+{
+	return blocking_notifier_chain_register(&mf_notifier_list, nb);
+}
+EXPORT_SYMBOL_GPL(register_memory_failure_notifier);
+
+/**
+ * unregister_memory_failure_notifier - Unregister previously registered
+ *                                      memory failure notifier
+ * @nb: Hook to be unregistered
+ *
+ * Returns zero on success, or %-ENOENT on failure.
+ */
+int unregister_memory_failure_notifier(struct notifier_block *nb)
+{
+	return blocking_notifier_chain_unregister(&mf_notifier_list, nb);
+}
+EXPORT_SYMBOL_GPL(unregister_memory_failure_notifier);
+
 static bool __page_handle_poison(struct page *page)
 {
 	int ret;
@@ -1136,6 +1165,10 @@ static void action_result(unsigned long pfn, enum mf_action_page_type type,
 	num_poisoned_pages_inc();
 	pr_err("Memory failure: %#lx: recovery action for %s: %s\n",
 		pfn, action_page_types[type], action_name[result]);
+
+	/* notify the chain if we handle successfully only */
+	if (result == MF_RECOVERED)
+		blocking_notifier_call_chain(&mf_notifier_list, pfn, NULL);
 }
 
 static int page_action(struct page_state *ps, struct page *p,
-- 
2.20.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
