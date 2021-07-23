Return-Path: <SRS0=XE2Y=MP=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11899C4338F
	for <virtualization@archiver.kernel.org>; Fri, 23 Jul 2021 12:53:32 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B147760E95
	for <virtualization@archiver.kernel.org>; Fri, 23 Jul 2021 12:53:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B147760E95
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6A62083A8B;
	Fri, 23 Jul 2021 12:53:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3Hn4q0stnXWz; Fri, 23 Jul 2021 12:53:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 106C483A7D;
	Fri, 23 Jul 2021 12:53:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D2D30C001A;
	Fri, 23 Jul 2021 12:53:29 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 54D45C000E
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Jul 2021 12:53:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 36660405FE
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Jul 2021 12:53:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xMDXX21oInr6
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Jul 2021 12:53:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4592D405EA
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Jul 2021 12:53:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1627044806;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4BNdBLLGlA2PZ1Ey+ERvbMpf7L4Iuikq21FXsWIbZe4=;
 b=ZQVpXs9BqJ7tOzMGCgu1bgSQ9pXGldOjNTufABQUhmnTMoQKsVa0giiPdxY9Yxo0GMFbdP
 6fXRiWOIHJ/0XUIrz0ngWbcM3lpk16uFCvyxg1dF/cTjuqcL1Lyb+Tq31uFrcpzEQney+0
 0+sLdqvK/OTW4BgtpUcwXqlBsms5AJo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-101-1jvXxHdAOqmTb9x-yvVd_g-1; Fri, 23 Jul 2021 08:53:24 -0400
X-MC-Unique: 1jvXxHdAOqmTb9x-yvVd_g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 269611B18BC3;
 Fri, 23 Jul 2021 12:53:22 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-112-253.ams2.redhat.com [10.36.112.253])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5CCB83AC1;
 Fri, 23 Jul 2021 12:53:06 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/9] ACPI: memhotplug: use a single static memory group for
 a single memory device
Date: Fri, 23 Jul 2021 14:52:06 +0200
Message-Id: <20210723125210.29987-6-david@redhat.com>
In-Reply-To: <20210723125210.29987-1-david@redhat.com>
References: <20210723125210.29987-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Cc: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
 Wei Yang <richard.weiyang@linux.alibaba.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
 linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>,
 Pavel Tatashin <pasha.tatashin@soleen.com>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 Dan Williams <dan.j.williams@intel.com>, Michal Hocko <mhocko@kernel.org>,
 Vlastimil Babka <vbabka@suse.cz>, Oscar Salvador <osalvador@suse.de>,
 Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>, Hui Zhu <teawater@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Marek Kedzierski <mkedzier@redhat.com>, Mike Rapoport <rppt@kernel.org>
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

Let's group all memory we add for a single memory device - we want a
single node for that (which also seems to be the sane thing to do).

We won't care for now about memory that was already added to the system
(e.g., via e820) -- usually *all* memory of a memory device was already
added and we'll fail acpi_memory_enable_device().

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/acpi/acpi_memhotplug.c | 35 +++++++++++++++++++++++++++++-----
 1 file changed, 30 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/acpi_memhotplug.c b/drivers/acpi/acpi_memhotplug.c
index eb4faf7c5cad..0ffa3db142a1 100644
--- a/drivers/acpi/acpi_memhotplug.c
+++ b/drivers/acpi/acpi_memhotplug.c
@@ -54,6 +54,7 @@ struct acpi_memory_info {
 struct acpi_memory_device {
 	struct acpi_device *device;
 	struct list_head res_list;
+	int mgid;
 };
 
 static acpi_status
@@ -169,12 +170,33 @@ static void acpi_unbind_memory_blocks(struct acpi_memory_info *info)
 static int acpi_memory_enable_device(struct acpi_memory_device *mem_device)
 {
 	acpi_handle handle = mem_device->device->handle;
+	mhp_t mhp_flags = MHP_NID_IS_MGID;
 	int result, num_enabled = 0;
 	struct acpi_memory_info *info;
-	mhp_t mhp_flags = MHP_NONE;
-	int node;
+	u64 total_length = 0;
+	int node, mgid;
 
 	node = acpi_get_node(handle);
+
+	list_for_each_entry(info, &mem_device->res_list, list) {
+		if (!info->length)
+			continue;
+		/* We want a single node for the whole memory group */
+		if (node < 0)
+			node = memory_add_physaddr_to_nid(info->start_addr);
+		total_length += info->length;
+	}
+
+	if (!total_length) {
+		dev_err(&mem_device->device->dev, "device is empty\n");
+		return -EINVAL;
+	}
+
+	mgid = register_static_memory_group(node, PFN_UP(total_length));
+	if (mgid < 0)
+		return mgid;
+	mem_device->mgid = mgid;
+
 	/*
 	 * Tell the VM there is more memory here...
 	 * Note: Assume that this function returns zero on success
@@ -188,12 +210,10 @@ static int acpi_memory_enable_device(struct acpi_memory_device *mem_device)
 		 */
 		if (!info->length)
 			continue;
-		if (node < 0)
-			node = memory_add_physaddr_to_nid(info->start_addr);
 
 		if (mhp_supports_memmap_on_memory(info->length))
 			mhp_flags |= MHP_MEMMAP_ON_MEMORY;
-		result = __add_memory(node, info->start_addr, info->length,
+		result = __add_memory(mgid, info->start_addr, info->length,
 				      mhp_flags);
 
 		/*
@@ -253,6 +273,10 @@ static void acpi_memory_device_free(struct acpi_memory_device *mem_device)
 	if (!mem_device)
 		return;
 
+	/* In case we succeeded adding *some* memory, unregistering fails. */
+	if (mem_device->mgid >= 0)
+		unregister_memory_group(mem_device->mgid);
+
 	acpi_memory_free_device_resources(mem_device);
 	mem_device->device->driver_data = NULL;
 	kfree(mem_device);
@@ -273,6 +297,7 @@ static int acpi_memory_device_add(struct acpi_device *device,
 
 	INIT_LIST_HEAD(&mem_device->res_list);
 	mem_device->device = device;
+	mem_device->mgid = -1;
 	sprintf(acpi_device_name(device), "%s", ACPI_MEMORY_DEVICE_NAME);
 	sprintf(acpi_device_class(device), "%s", ACPI_MEMORY_DEVICE_CLASS);
 	device->driver_data = mem_device;
-- 
2.31.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
