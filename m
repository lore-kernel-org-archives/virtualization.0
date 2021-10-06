Return-Path: <SRS0=ulPH=O2=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78FAFC433EF
	for <virtualization@archiver.kernel.org>; Wed,  6 Oct 2021 20:29:14 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13D9C6113E
	for <virtualization@archiver.kernel.org>; Wed,  6 Oct 2021 20:29:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 13D9C6113E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D410D60F3F;
	Wed,  6 Oct 2021 20:29:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id M6f9-cHDMpEf; Wed,  6 Oct 2021 20:29:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 786CA60F18;
	Wed,  6 Oct 2021 20:29:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5AC18C000F;
	Wed,  6 Oct 2021 20:29:12 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5D839C000D
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Oct 2021 20:29:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3FA8C4058D
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Oct 2021 20:29:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=infradead.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Y9Oj_B9TsSNk
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Oct 2021 20:29:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 503E4404F9
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Oct 2021 20:29:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:In-Reply-To:References;
 bh=f+7pNJVIdJVibgfPLSCv/f+yDUP48wbFM1/ma1uhFjg=; b=Ogm6pNPXdME5gAs0wNEr+Wj30b
 fPTa/NAwwNJQa00AQL9dWyvTpT6FHp2bP2CR8cCdAZp5zsTJarPeZnQae0GxfZaQThA+r4JGZivlF
 u2az0ImavUx2gGxcv/ny8iialIURoUnmnJqc1EilxOjebsvhwGuu9A8m5VashhfR1j2QHpuDjaNPu
 pUBjbu9FqrmbQeGsy2zgme6Q2pXc8b1AoaTSOv3jeee6Wcc7luOkpOD7hiKyzWg3DFlILM8vTyHqv
 gn8mM/QYmX+iIUu9N0Main2nWJU7v/biu1fYPxT83VRiGejnpNQU3mNQ1jUYRa8Zn4QKrhZfbFRw9
 Qg+77kNA==;
Received: from [2601:1c0:6280:3f0::aa0b] (helo=bombadil.infradead.org)
 by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mYDXF-00FV0W-Ef; Wed, 06 Oct 2021 20:29:05 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] VDUSE: fix documentation underline warning
Date: Wed,  6 Oct 2021 13:29:04 -0700
Message-Id: <20211006202904.30241-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Cc: Jonathan Corbet <corbet@lwn.net>, Randy Dunlap <rdunlap@infradead.org>,
 linux-doc@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Xie Yongji <xieyongji@bytedance.com>, "Michael S . Tsirkin" <mst@redhat.com>
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

Fix a VDUSE documentation build warning:

Documentation/userspace-api/vduse.rst:21: WARNING: Title underline too short.

Fixes: 7bc7f61897b6 ("Documentation: Add documentation for VDUSE")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Xie Yongji <xieyongji@bytedance.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: virtualization@lists.linux-foundation.org
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
---
 Documentation/userspace-api/vduse.rst |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- lnx-515-rc4.orig/Documentation/userspace-api/vduse.rst
+++ lnx-515-rc4/Documentation/userspace-api/vduse.rst
@@ -18,7 +18,7 @@ types can be added after the security is
 is clarified or fixed in the future.
 
 Create/Destroy VDUSE devices
-------------------------
+----------------------------
 
 VDUSE devices are created as follows:
 
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
