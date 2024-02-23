Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6788D11CB2;
	Fri, 23 Feb 2024 06:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708669442; cv=none; b=nxuJ89xJ3tz45ZvSPl11qHaEys+OCDRvW5qnpTDWsvZgCrkoHJrQ0PhuHoskDZ8BoaNTArGI14ioaudhxwFvn5RYWzZuLsvIuxtf/GuplbQq0cGNekzmf67SSHixcJ1QCLV/+qEYKkMerWHJFbI8foy7inD4Hqfl/bENhVMJ4go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708669442; c=relaxed/simple;
	bh=ZzoSpDwEf2KoGKi0ff06NfsnY5eXMZD8bWhHAagYnuc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oG/26DVQ51Y/TZNZw8FZqtSwEzv++L0krfipFAKCeD6ZwrAJBzjAxM5zHNPqgu/DqgxOXqYfTdOuyZu0hY3xiYRiVCLV+FeYfW2mPJsJW/tCdTh6nS6MrQfe1ZX07Tlfddw48yINEyVEQygHP171YF0VOF5c7ikCj33GF3cay2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=JhCA0/FL; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JhCA0/FL"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=dSnVkR0Y/fZ0kyz7eM0G9wa/fFVbVtZ1NrzzwOo4fdE=; b=JhCA0/FLWFYt+nM1Kd6L6kpG0V
	yqFhS37UuvisIj6dEn318RSU67n3TqMUY7tZys/ccGMDDsQYMtaC5eM3fW0Vta3kd1gUlwM5Dqnom
	rwnmq5q3dvKPKyNoclm61ZSTtmor65jX999cLJlwEh4YnVU8d09kFItEJNIi6YVXbvn+4wcvtPPfV
	CD6Qnnr7hfYffCgu3kYO7yY1JR3x0NEL363vVTN8cMtKaLRKxd/sFkPIGB0avIsjXqY6QB/HDoBN6
	sMwbe+TDBofgKRKGlzPtIOK1UoZQjigCz+Lhi34eBvpxPd0tnWGyjBml3r2N8Qlzf5pQ25A94u1bm
	q39LWsIQ==;
Received: from [50.53.50.0] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rdOyD-000000088C4-2kze;
	Fri, 23 Feb 2024 06:23:55 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Cindy Lu <lulu@redhat.com>,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	virtualization@lists.linux.dev,
	Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH -next] VDUSE: fix another doc underline warning
Date: Thu, 22 Feb 2024 22:23:41 -0800
Message-ID: <20240223062341.26914-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extend the underline for a heading to prevent a documentation
build warning. Also spell "reconnection" correctly.

Documentation/userspace-api/vduse.rst:236: WARNING: Title underline too short.
HOW VDUSE devices reconnectoin works
----------------

Fixes: 2b3fd606c662 ("Documentation: Add reconnect process for VDUSE")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Cindy Lu <lulu@redhat.com>
Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: virtualization@lists.linux.dev
Cc: Jonathan Corbet <corbet@lwn.net>
---
 Documentation/userspace-api/vduse.rst |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff -- a/Documentation/userspace-api/vduse.rst b/Documentation/userspace-api/vduse.rst
--- a/Documentation/userspace-api/vduse.rst
+++ b/Documentation/userspace-api/vduse.rst
@@ -232,8 +232,8 @@ able to start the dataplane processing a
 
 For more details on the uAPI, please see include/uapi/linux/vduse.h.
 
-HOW VDUSE devices reconnectoin works
-----------------
+HOW VDUSE devices reconnection works
+------------------------------------
 0. Userspace APP checks if the device /dev/vduse/vduse_name exists.
    If it does not exist, need to create the instance.goto step 1
    If it does exist, it means this is a reconnect and goto step 3.
