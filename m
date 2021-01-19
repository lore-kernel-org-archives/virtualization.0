Return-Path: <SRS0=ogTN=GW=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_RED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03411C433DB
	for <virtualization@archiver.kernel.org>; Tue, 19 Jan 2021 08:39:22 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73B1B22241
	for <virtualization@archiver.kernel.org>; Tue, 19 Jan 2021 08:39:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73B1B22241
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 0AFF185D45;
	Tue, 19 Jan 2021 08:39:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gBG4Y6gsOy-1; Tue, 19 Jan 2021 08:39:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 7AD278480D;
	Tue, 19 Jan 2021 08:39:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 65DB2C08A1;
	Tue, 19 Jan 2021 08:39:20 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 317A5C013A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Jan 2021 08:39:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 213D185D41
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Jan 2021 08:39:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uJx_B9JOT07b
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Jan 2021 08:39:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id A9C2A85CFF
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Jan 2021 08:39:18 +0000 (UTC)
IronPort-SDR: 7e3IxPJ6VlV1jFiM5rDkrNlxHTqn34F3UqvGejyQy3X8g+JUZDlO7iLUwxl34lRPlxk9ZXyJ1d
 lhNmFqm7x+AQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9868"; a="166562895"
X-IronPort-AV: E=Sophos;i="5.79,358,1602572400"; d="scan'208";a="166562895"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Jan 2021 00:39:15 -0800
IronPort-SDR: YXqSBKkIBPl+HrthUSCLHLhXBm5Oht5765S9L9/TLcwnRwLXIVkgE4xFZsg55Y7HRXyz31LdqL
 XfXsUYygSL8g==
X-IronPort-AV: E=Sophos;i="5.79,358,1602572400"; d="scan'208";a="402291672"
Received: from vkasired-desk2.fm.intel.com ([10.105.128.127])
 by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Jan 2021 00:39:15 -0800
From: Vivek Kasireddy <vivek.kasireddy@intel.com>
To: virtualization@lists.linux-foundation.org
Subject: [RFC 3/3] vfio: Share the KVM instance with Vdmabuf
Date: Tue, 19 Jan 2021 00:28:12 -0800
Message-Id: <20210119082812.822291-4-vivek.kasireddy@intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210119082812.822291-1-vivek.kasireddy@intel.com>
References: <20210119082812.822291-1-vivek.kasireddy@intel.com>
MIME-Version: 1.0
Cc: dongwon.kim@intel.com
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

Getting a copy of the KVM instance is necessary for mapping Guest
pages in the Host.

TODO: Instead of invoking the symbol directly, there needs to be a
better way of getting a copy of the KVM instance probably by using
other notifiers. However, currently, KVM shares its instance only
with VFIO and therefore we are compelled to bind the passthrough'd
device to vfio-pci.

Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
---
 drivers/vfio/vfio.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/vfio/vfio.c b/drivers/vfio/vfio.c
index 4ad8a35667a7..9fb11b1ad3cd 100644
--- a/drivers/vfio/vfio.c
+++ b/drivers/vfio/vfio.c
@@ -2213,11 +2213,20 @@ static int vfio_unregister_iommu_notifier(struct vfio_group *group,
 	return ret;
 }
 
+extern void vhost_vdmabuf_get_kvm(unsigned long action, void *data);
 void vfio_group_set_kvm(struct vfio_group *group, struct kvm *kvm)
 {
+	void (*fn)(unsigned long, void *);
+
 	group->kvm = kvm;
 	blocking_notifier_call_chain(&group->notifier,
 				VFIO_GROUP_NOTIFY_SET_KVM, kvm);
+
+	fn = symbol_get(vhost_vdmabuf_get_kvm);
+	if (fn) {
+		fn(VFIO_GROUP_NOTIFY_SET_KVM, kvm);
+		symbol_put(vhost_vdmabuf_get_kvm);
+	}
 }
 EXPORT_SYMBOL_GPL(vfio_group_set_kvm);
 
-- 
2.26.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
