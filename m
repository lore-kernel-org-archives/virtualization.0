Return-Path: <SRS0=hbIa=B7=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90911C433E5
	for <virtualization@archiver.kernel.org>; Fri, 21 Aug 2020 10:35:25 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63486204EA
	for <virtualization@archiver.kernel.org>; Fri, 21 Aug 2020 10:35:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f4atkxJj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63486204EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 261B48865C;
	Fri, 21 Aug 2020 10:35:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9d3GUZyowXTK; Fri, 21 Aug 2020 10:35:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 7F4E4885F0;
	Fri, 21 Aug 2020 10:35:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 71759C07FF;
	Fri, 21 Aug 2020 10:35:24 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B2551C0051
 for <virtualization@lists.linux-foundation.org>;
 Fri, 21 Aug 2020 10:35:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id AEE4C88646
 for <virtualization@lists.linux-foundation.org>;
 Fri, 21 Aug 2020 10:35:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6qSOi+poAWsx
 for <virtualization@lists.linux-foundation.org>;
 Fri, 21 Aug 2020 10:35:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-1.mimecast.com
 [207.211.31.81])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 29014884C4
 for <virtualization@lists.linux-foundation.org>;
 Fri, 21 Aug 2020 10:35:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598006121;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AeL7eQMcuzDtJ58y3twR8woldx1f2g3cujVSMwGjGgg=;
 b=f4atkxJjlh77DKACdy22VoaPcQ4vopSeQEfqAo5J39GRHCWAzLROVSfcT8RWbIR7mWwxSV
 XgVcYhG9gGdInbUWja9cYVT545jqAjeR2C7lUpEbK40+SZUdrvt/aV8hMoMTDPbxhsK+n5
 49BUXBFodelVyqVOsqjgwmGd/7TEq/Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-353-Fg8UITSqMl-wo432KovFmA-1; Fri, 21 Aug 2020 06:35:17 -0400
X-MC-Unique: Fg8UITSqMl-wo432KovFmA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2DF0281F02D;
 Fri, 21 Aug 2020 10:35:15 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-114-87.ams2.redhat.com [10.36.114.87])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5684C60BF1;
 Fri, 21 Aug 2020 10:35:10 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v1 5/5] hv_balloon: try to merge system ram resources
Date: Fri, 21 Aug 2020 12:34:31 +0200
Message-Id: <20200821103431.13481-6-david@redhat.com>
In-Reply-To: <20200821103431.13481-1-david@redhat.com>
References: <20200821103431.13481-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>, linux-hyperv@vger.kernel.org,
 Michal Hocko <mhocko@suse.com>, Stephen Hemminger <sthemmin@microsoft.com>,
 Baoquan He <bhe@redhat.com>, Haiyang Zhang <haiyangz@microsoft.com>,
 Wei Liu <wei.liu@kernel.org>, virtualization@lists.linux-foundation.org,
 linux-mm@kvack.org, Wei Yang <richardw.yang@linux.intel.com>,
 xen-devel@lists.xenproject.org, Andrew Morton <akpm@linux-foundation.org>
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

Let's use the new mechanism to merge system ram resources below the
root. We are the only one hotplugging system ram, e.g., DIMMs don't apply,
so this is safe to be used.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>
Cc: Haiyang Zhang <haiyangz@microsoft.com>
Cc: Stephen Hemminger <sthemmin@microsoft.com>
Cc: Wei Liu <wei.liu@kernel.org>
Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Cc: Baoquan He <bhe@redhat.com>
Cc: Wei Yang <richardw.yang@linux.intel.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/hv/hv_balloon.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/hv/hv_balloon.c b/drivers/hv/hv_balloon.c
index 32e3bc0aa665a..49a6305f0fb73 100644
--- a/drivers/hv/hv_balloon.c
+++ b/drivers/hv/hv_balloon.c
@@ -745,6 +745,9 @@ static void hv_mem_hot_add(unsigned long start, unsigned long size,
 			has->covered_end_pfn -=  processed_pfn;
 			spin_unlock_irqrestore(&dm_device.ha_lock, flags);
 			break;
+		} else {
+			/* Try to reduce the number of system ram resources. */
+			merge_system_ram_resources(&iomem_resource);
 		}
 
 		/*
-- 
2.26.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
