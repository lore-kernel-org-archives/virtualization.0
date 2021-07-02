Return-Path: <SRS0=Lmm9=L2=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 621F8C11F6B
	for <virtualization@archiver.kernel.org>; Fri,  2 Jul 2021 11:49:00 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26BFA61402
	for <virtualization@archiver.kernel.org>; Fri,  2 Jul 2021 11:49:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26BFA61402
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 6270F40450;
	Fri,  2 Jul 2021 11:48:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id m7CGW0Z78Vdk; Fri,  2 Jul 2021 11:48:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 0A99940282;
	Fri,  2 Jul 2021 11:48:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 82C05C0020;
	Fri,  2 Jul 2021 11:48:57 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BA95CC002C
 for <virtualization@lists.linux-foundation.org>;
 Fri,  2 Jul 2021 11:48:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id ADFA940259
 for <virtualization@lists.linux-foundation.org>;
 Fri,  2 Jul 2021 11:48:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AUe01ds_VFLx
 for <virtualization@lists.linux-foundation.org>;
 Fri,  2 Jul 2021 11:48:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E24804002B
 for <virtualization@lists.linux-foundation.org>;
 Fri,  2 Jul 2021 11:48:50 +0000 (UTC)
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
 (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 375AD20558;
 Fri,  2 Jul 2021 11:48:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1625226529; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=X0PCbfsKKi5Z5ypmtVXwwsJ90tFRD61CKAIuZBznxzQ=;
 b=exOewFtVlDV2ckakHVvdAvM8jyTXGXcGir38/1JM/5MwiN7SegbSlRo4uCQOLCG8wM8HFM
 yIxNBYV8jNyM8uAtw8yhJWkeaKGxMl9EaVC7nG0Xw+MXTYgR4q8ZqKNRzxIjjGJ4iqdUm7
 YGBTAbXpTO2821xRAas3JaT2b2daG80=
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
 by imap.suse.de (Postfix) with ESMTP id CB5A811C84;
 Fri,  2 Jul 2021 11:48:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1625226529; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=X0PCbfsKKi5Z5ypmtVXwwsJ90tFRD61CKAIuZBznxzQ=;
 b=exOewFtVlDV2ckakHVvdAvM8jyTXGXcGir38/1JM/5MwiN7SegbSlRo4uCQOLCG8wM8HFM
 yIxNBYV8jNyM8uAtw8yhJWkeaKGxMl9EaVC7nG0Xw+MXTYgR4q8ZqKNRzxIjjGJ4iqdUm7
 YGBTAbXpTO2821xRAas3JaT2b2daG80=
Received: from director2.suse.de ([192.168.254.72]) by imap3-int with ESMTPSA
 id 8DsIMCD93mDDDAAALh3uQQ
 (envelope-from <varad.gautam@suse.com>); Fri, 02 Jul 2021 11:48:48 +0000
To: kvm@vger.kernel.org,
	virtualization@lists.linux-foundation.org
Subject: [kvm-unit-tests PATCH 3/6] x86: efi_main: Get EFI memory map and exit
 boot services
Date: Fri,  2 Jul 2021 13:48:17 +0200
Message-Id: <20210702114820.16712-4-varad.gautam@suse.com>
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

The largest EFI_CONVENTIONAL_MEMORY chunk is passed over to
alloc_phys for the testcase.

Signed-off-by: Varad Gautam <varad.gautam@suse.com>
---
 x86/efi_main.c | 92 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 92 insertions(+)

diff --git a/x86/efi_main.c b/x86/efi_main.c
index 00e7086..237d4e7 100644
--- a/x86/efi_main.c
+++ b/x86/efi_main.c
@@ -1,11 +1,103 @@
+#include <alloc_phys.h>
 #include <linux/uefi.h>
 
 unsigned long __efiapi efi_main(efi_handle_t handle, efi_system_table_t *sys_tab);
 efi_system_table_t *efi_system_table = NULL;
 
+static void efi_free_pool(void *ptr)
+{
+	efi_bs_call(free_pool, ptr);
+}
+
+static efi_status_t efi_get_memory_map(struct efi_boot_memmap *map)
+{
+	efi_memory_desc_t *m = NULL;
+	efi_status_t status;
+	unsigned long key = 0, map_size = 0, desc_size = 0;
+
+	status = efi_bs_call(get_memory_map, &map_size,
+			     NULL, &key, &desc_size, NULL);
+	if (status != EFI_BUFFER_TOO_SMALL || map_size == 0)
+		goto out;
+
+	/* Pad map_size with additional descriptors so we don't need to
+	 * retry. */
+	map_size += 4 * desc_size;
+	*map->buff_size = map_size;
+	status = efi_bs_call(allocate_pool, EFI_LOADER_DATA,
+			     map_size, (void **)&m);
+	if (status != EFI_SUCCESS)
+		goto out;
+
+	/* Get the map. */
+	status = efi_bs_call(get_memory_map, &map_size,
+			     m, &key, &desc_size, NULL);
+	if (status != EFI_SUCCESS) {
+		efi_free_pool(m);
+		goto out;
+	}
+
+	*map->desc_size = desc_size;
+	*map->map_size = map_size;
+	*map->key_ptr = key;
+out:
+	*map->map = m;
+	return status;
+}
+
+static efi_status_t efi_exit_boot_services(void *handle,
+					   struct efi_boot_memmap *map)
+{
+	return efi_bs_call(exit_boot_services, handle, *map->key_ptr);
+}
+
+static efi_status_t exit_efi(void *handle)
+{
+	unsigned long map_size = 0, key = 0, desc_size = 0, buff_size;
+	efi_memory_desc_t *mem_map, *md, *conventional = NULL;
+	efi_status_t status;
+	unsigned num_ents, i;
+	unsigned long pages = 0;
+	struct efi_boot_memmap map;
+
+	map.map = &mem_map;
+	map.map_size = &map_size;
+	map.desc_size = &desc_size;
+	map.desc_ver = NULL;
+	map.key_ptr = &key;
+	map.buff_size = &buff_size;
+
+	status = efi_get_memory_map(&map);
+	if (status != EFI_SUCCESS)
+		return status;
+
+	status = efi_exit_boot_services(handle, &map);
+	if (status != EFI_SUCCESS) {
+		efi_free_pool(mem_map);
+		return status;
+	}
+
+	/* Use the largest EFI_CONVENTIONAL_MEMORY range for phys_alloc_init. */
+	num_ents = map_size / desc_size;
+	for (i = 0; i < num_ents; i++) {
+		md = (efi_memory_desc_t *) (((u8 *) mem_map) + i * (desc_size));
+
+		if (md->type == EFI_CONVENTIONAL_MEMORY && md->num_pages > pages) {
+			conventional = md;
+			pages = md->num_pages;
+		}
+	}
+	phys_alloc_init(conventional->phys_addr,
+			conventional->num_pages << EFI_PAGE_SHIFT);
+
+	return EFI_SUCCESS;
+}
+
 unsigned long __efiapi efi_main(efi_handle_t handle, efi_system_table_t *sys_tab)
 {
 	efi_system_table = sys_tab;
 
+	exit_efi(handle);
+
 	return 0;
 }
-- 
2.30.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
