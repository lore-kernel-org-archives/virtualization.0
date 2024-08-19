Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB04915D5A4
	for <virtualization@lists.linux-foundation.org>; Mon, 19 Aug 2024 09:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724059752; cv=none; b=fSD1aajHqvmelaAJGPFl/aXE7cAgScok8OVqKTVr5KHD5whARw3rNfoyF/Z7LcK7GfG7UwiTX+OYJtptvaPj8Ch4X4A95rUACOxlf/1YMebRo7SMhKDOo3QDKTBO4xwvwhz+jr413BUqlJKkCsqHer4NkLPEHPtrck6JeVNrAUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724059752; c=relaxed/simple;
	bh=oxbJ9jgS2b3BWhr+6VbYkYj8MiliVXAlFphhBQv+NcI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eyIsJi5enLElZKDCMmhLv7UOEYB5yw7bmkrj3DjWOpT8F9wfeNlnyOngYbX0Tptxd8geJQnV3y8Y42TGA3/Uq7d4NmV4FR97JheE07j8o3i2gbXGG5tj9jJJtt68jlG7qSDnsoiCkFGF26ctbdvz5pBZiEBWHLdo7h7x13gugak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FvPRHuOJ; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FvPRHuOJ"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4A666403F4
	for <virtualization@lists.linux-foundation.org>; Mon, 19 Aug 2024 09:29:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.79
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MahHx8_9f6V1 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Aug 2024 09:29:09 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=lulu@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 681F3403EF
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 681F3403EF
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FvPRHuOJ
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 681F3403EF
	for <virtualization@lists.linux-foundation.org>; Mon, 19 Aug 2024 09:29:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724059747;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=U5wQYM12MCFSqwdIiZqRbT7zjsGp18nCTllg/pw0PFI=;
	b=FvPRHuOJvOgevf9FiLj7lqNd8/Uvz4whFCznvMXmDucUvTVM7ULPd/cjluqh0rBDIqsffE
	XP9n88/P7+gB5eayV8t/JoIG6ab8/w5TIatztMGJ0UYyUZ9qzcZomrMTvR6HEb3Ee5YEbD
	DZr1dAvoo4kqkOmKoD7oJdxCxgZPj70=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-222-ITxHquRrO0CXaNpk9lwQGw-1; Mon,
 19 Aug 2024 05:29:03 -0400
X-MC-Unique: ITxHquRrO0CXaNpk9lwQGw-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 830881954B15;
	Mon, 19 Aug 2024 09:29:02 +0000 (UTC)
Received: from server.redhat.com (unknown [10.72.112.11])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 92F4B195605A;
	Mon, 19 Aug 2024 09:28:58 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com,
	jasowang@redhat.com,
	mst@redhat.com,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org
Subject: [RFC 0/7] vhost: Add support of kthread API
Date: Mon, 19 Aug 2024 17:27:26 +0800
Message-ID: <20240819092851.441670-1-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

In commit 6e890c5d5021 ("vhost: use vhost_tasks for worker threads"),
vhost removed the support for the kthread API. However, there are
still situations where there is a request to use kthread.
In this RFC, the support of kthread is added back. Additionally,
a module_param is added to identify which mode we are using, and
a new UAPI is introduced to allow the userspace app to set the
mode they want to use.

Cindy Lu (7):
  vhost: Add a new module_param for enable kthread
  vhost: Add kthread support in function vhost_worker_queue()
  vhost: Add kthread support in function vhost_workers_free()
  vhost: Add the vhost_worker to support kthread
  vhost: Add the cgroup related function
  vhost: Add kthread support in function vhost_worker_create
  vhost: Add new UAPI to support changing Kthread mode

 drivers/vhost/vhost.c      | 241 +++++++++++++++++++++++++++++++++++--
 drivers/vhost/vhost.h      |   1 +
 include/uapi/linux/vhost.h |   2 +
 3 files changed, 235 insertions(+), 9 deletions(-)

-- 
2.45.0

