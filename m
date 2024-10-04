Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A54A2D512
	for <virtualization@lists.linux-foundation.org>; Fri,  4 Oct 2024 01:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728007192; cv=none; b=iR3knHjQ+PvR/k68tU91OlDXFykiFR1BgxbccLbiY1lldZL+b9wM52Etc2rF2hOVyu+X+zkLbnggB9wdyNczn9OvYyigal/xFeZR9r4IDc/i7onwpEZKVM/7Qz6qM5x/iiW/PRQl+csJWeYP+nHAFfAQNewt4kSi27+uDJFGpFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728007192; c=relaxed/simple;
	bh=rS4a91Q4WGcJDtZNS4lLQkNz0uQdxBrAqGCqqsa9wZc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=rnND/BO6/C9rNZ72tDo3ghS0J0iWtZJ8OSb9O4sQoidt2hNspLQsAZ4lDuUsO87ic/dN706XudZloWiiROI+2Dh76Li8F507ehe6oj4blsChzX9fTbjBY5WtxrWz6FLFAe2ea8sF8Kux3RZx1phTuJEQO7GwkVj1tv8ixOBhmxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RlPgX61h; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RlPgX61h"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 49E5140B77
	for <virtualization@lists.linux-foundation.org>; Fri,  4 Oct 2024 01:59:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.79
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 229u0GAyXQ6y for <virtualization@lists.linux-foundation.org>;
 Fri,  4 Oct 2024 01:59:50 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=lulu@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 4D50740B4F
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4D50740B4F
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=RlPgX61h
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 4D50740B4F
	for <virtualization@lists.linux-foundation.org>; Fri,  4 Oct 2024 01:59:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728007187;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=07ns/HQsSQxwM5XUp3N+Tdfw86coSdJ+Lntrqhv9Sis=;
	b=RlPgX61hUoNZ7Ij08Xy3gEBnRzQhWV314yNBvLXWKkZTSOAF+PZbVs9yOIm4Rzh6ksxnOV
	tMXCjD/iV10egYo89PLau7skevNL00bwMnoicT9m9WRsPGQBKWIgWlLdosT+lWZCn1nDT1
	Xy1wiF3tprnvJK0MD7hsdnLwxoLu/a8=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-264-iPlKMwnQObSZlhQ7Mxt96w-1; Thu,
 03 Oct 2024 21:59:46 -0400
X-MC-Unique: iPlKMwnQObSZlhQ7Mxt96w-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 831E81955D47;
	Fri,  4 Oct 2024 01:59:45 +0000 (UTC)
Received: from server.redhat.com (unknown [10.72.112.45])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 409FE19560A3;
	Fri,  4 Oct 2024 01:59:40 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com,
	jasowang@redhat.com,
	mst@redhat.com,
	michael.christie@oracle.com,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org
Subject: [PATCH v2 0/7] vhost: Add support of kthread API
Date: Fri,  4 Oct 2024 09:58:14 +0800
Message-ID: <20241004015937.2286459-1-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

In commit 6e890c5d5021 ("vhost: use vhost_tasks for worker threads"),
vhost is now a child of the owner thread. but some old userspace is confused, In these patch we will let userspace to select the mode 

In this PATCH, the support of kthread is added back.
a module_param is added to select which mode we are using, and
a new UAPI is introduced to allow the userspace app to set which
mode they want to use.

Changelog v2: 
 1. Change the module_param's name to enforce_inherit_owner, and the default value is true.
 2. Change the UAPI's name to VHOST_SET_INHERIT_FROM_OWNER.
 
Tested with QEMU.

Cindy Lu (7):
  vhost: Add a new modparam to allow userspace select vhost_task
  vhost: Add kthread support in function vhost_worker_queue()
  vhost: Add kthread support in function vhost_workers_free()
  vhost: Add the vhost_worker to support kthread
  vhost: Add the cgroup related function
  vhost: Add kthread support in function vhost_worker_create
  vhost: Add new UAPI to support change to task mode

 drivers/vhost/vhost.c      | 249 +++++++++++++++++++++++++++++++++++--
 drivers/vhost/vhost.h      |   1 +
 include/uapi/linux/vhost.h |   2 +
 3 files changed, 243 insertions(+), 9 deletions(-)

-- 
2.45.0

