Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FB2F36AEE
	for <virtualization@lists.linux-foundation.org>; Tue,  9 Jan 2024 11:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X19r0DSd"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id ED09A823E2
	for <virtualization@lists.linux-foundation.org>; Tue,  9 Jan 2024 11:10:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org ED09A823E2
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=X19r0DSd
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fohEbUBYTkhV
	for <virtualization@lists.linux-foundation.org>;
	Tue,  9 Jan 2024 11:10:34 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 9ED16823E0
	for <virtualization@lists.linux-foundation.org>; Tue,  9 Jan 2024 11:10:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9ED16823E0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704798632;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=CwAPOPDXtJGot4Xweu+SW6rgO4qJDtpBoQj6gViyR30=;
	b=X19r0DSdoJdWqBGXjCR7GM2xo3g/N2vvxBsAbg1n76cQSdT64ZBDtErKMErXE+q5s+UHmi
	rSIEW4oNRvbRaFGtuIyZB6h6HrrYGj2kFgrG987+Wo9s0tAxjFmrJx+3Bb6IWIo12c+gL2
	yW0XvnEmBBLLeS0GvU2a/PZpqZ9nAX4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-21-jBduOfQAN_CyAQcEDmBdyw-1; Tue, 09 Jan 2024 06:10:31 -0500
X-MC-Unique: jBduOfQAN_CyAQcEDmBdyw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BF16385A588;
	Tue,  9 Jan 2024 11:10:30 +0000 (UTC)
Received: from max-p1.redhat.com (unknown [10.39.208.21])
	by smtp.corp.redhat.com (Postfix) with ESMTP id ED2AE492BE6;
	Tue,  9 Jan 2024 11:10:28 +0000 (UTC)
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
Subject: [PATCH v7 0/3] vduse: add support for networking devices
Date: Tue,  9 Jan 2024 12:10:22 +0100
Message-ID: <20240109111025.1320976-1-maxime.coquelin@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

This small series enables virtio-net device type in VDUSE.
With it, basic operation have been tested, both with
virtio-vdpa and vhost-vdpa using DPDK Vhost library series
adding VDUSE support using split rings layout (merged in
DPDK v23.07-rc1).

Control queue support (and so multiqueue) has also been
tested, but requires a Kernel series from Jason Wang
relaxing control queue polling [1] to function reliably,
so while Jason rework is done, a patch is added to fail init
if control queue feature is requested.(tested also with DPDK
v23.11).


Changes in v7:
==============
- Fail init only if VIRTIO_NET_F_CTRL_VQ is requested.
- Convert to use BIT_ULL() macro
- Rebased

Changes in v6:
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
  vduse: Temporarily fail if control queue feature requested
  vduse: enable Virtio-net device type

 drivers/vdpa/vdpa_user/vduse_dev.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

-- 
2.43.0

