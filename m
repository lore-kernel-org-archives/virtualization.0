Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 288FA249E0
	for <virtualization@lists.linux-foundation.org>; Thu,  4 Jan 2024 15:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fFVnyXDo"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A7069838E0
	for <virtualization@lists.linux-foundation.org>; Thu,  4 Jan 2024 15:38:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A7069838E0
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=fFVnyXDo
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cbGzxJBWE0wY
	for <virtualization@lists.linux-foundation.org>;
	Thu,  4 Jan 2024 15:38:06 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp1.osuosl.org (Postfix) with ESMTPS id E699A82171
	for <virtualization@lists.linux-foundation.org>; Thu,  4 Jan 2024 15:38:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E699A82171
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704382684;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=9/vnf7ini+dqsZp2EUqBmVye1hh0Tl8Sv9ZPYE+NvYA=;
	b=fFVnyXDoNGYLpom6Cl8lMAnY7pwiaaJBepHWeVRg4Gaelt8kID94ll3dejAxw+I6uhqNli
	XXZ67wlRLN9SKOPpgglWxZNb0eda13oocFE74EvLOEDNL+NdSBEMdOzKhMH4fY2n5FsDLN
	Q9Ihbv/VJC19dhS/cnbSMAOic/mJ46U=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-478-Mf5m6bnRMtSU1UawQ0qGpA-1; Thu,
 04 Jan 2024 10:37:58 -0500
X-MC-Unique: Mf5m6bnRMtSU1UawQ0qGpA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2DE7028EC10F;
	Thu,  4 Jan 2024 15:37:58 +0000 (UTC)
Received: from max-p1.redhat.com (unknown [10.39.208.29])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 335CFC15968;
	Thu,  4 Jan 2024 15:37:56 +0000 (UTC)
From: Maxime Coquelin <maxime.coquelin@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	xieyongji@bytedance.com,
	virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org,
	david.marchand@redhat.com,
	lulu@redhat.com
Cc: Maxime Coquelin <maxime.coquelin@redhat.com>
Subject: [PATCH v6 0/3] vduse: add support for networking devices
Date: Thu,  4 Jan 2024 16:37:50 +0100
Message-ID: <20240104153753.2931026-1-maxime.coquelin@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

This small series enables virtio-net device type in VDUSE.
With it, basic operation have been tested, both with
virtio-vdpa and vhost-vdpa using DPDK Vhost library series
adding VDUSE support using split rings layout (merged in
DPDK v23.07-rc1).

Control queue support (and so multiqueue) has also been
tested, but requires a Kernel series from Jason Wang
relaxing control queue polling [1] to function reliably,
so while Jason rework is done, a patch is added to disable
CVQ and features that depend on it (tested also with DPDK
v23.07-rc1).

In this v5, LSM hooks introduced in previous revision are
unified into a single hook that covers below operations:
- VDUSE_CREATE_DEV ioctl on VDUSE control file,
- VDUSE_DESTROY_DEV ioctl on VDUSE control file,
- open() on VDUSE device file.

In combination with the operations permission, a device type
permission has to be associated:
- block: Virtio block device type,
- net: Virtio networking device type.

changes in v6!
==============
- Remove SELinux support from the series, will be handled
  in a dedicated one.
- Require CAP_NET_ADMIN for Net devices creation (Jason).
- Fail init if control queue features are requested for
  Net device type (Jason).
- Rebased on latest master.

Changes in v5:
==============
- Move control queue disablement patch before Net
  devices enablement (Jason).
- Unify operations LSM hooks into a single hook.
- Rebase on latest master.

Maxime Coquelin (3):
  vduse: validate block features only with block devices
  vduse: Temporarily fail if control queue features requested
  vduse: enable Virtio-net device type

 drivers/vdpa/vdpa_user/vduse_dev.c | 32 ++++++++++++++++++++++++++----
 1 file changed, 28 insertions(+), 4 deletions(-)

-- 
2.43.0

