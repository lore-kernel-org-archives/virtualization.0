Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC9E91BF53
	for <virtualization@lists.linux-foundation.org>; Mon,  8 Jul 2024 06:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720421321; cv=none; b=AArrfzXDMFpIrZPtqmSQp4fb1f6MDl+Y2Ql/H3UApY9DuU0tFlRT2/ZFT3xQ68DtSacJ2FGAFPUifHUqjr78LuReMUJZI7hZORq2y0/2EVEuuCTrQYLDjBQiHJGOboOGbdhyDi9QjC3Vj7meg4Rs/NrJA0GUw/aq8iNPHtJHw1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720421321; c=relaxed/simple;
	bh=4ShB6meswCjftVRMVFjKdbXdfBv81ojN5q8D4ctp9ag=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=diCTS0ULhivzGxHanNSssClunXHoktoKr1rBI7jeoGdULXHhepqaRzHj0Y4hRXtj3RTB/Ajy9yeJab9I3JCvFmOtaY2wXD/r6L+rPJmi5q4L4X/WKO/Jg7z5AowIch2udou4GHU3AFFzpgF0A2iZ6Uorqsse+bix3ZtbTXn6++8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EC1jreNh; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EC1jreNh"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 681B96069A
	for <virtualization@lists.linux-foundation.org>; Mon,  8 Jul 2024 06:48:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id J-Udie0q06lh for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Jul 2024 06:48:38 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=lulu@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 868EF60637
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 868EF60637
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=EC1jreNh
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 868EF60637
	for <virtualization@lists.linux-foundation.org>; Mon,  8 Jul 2024 06:48:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720421317;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=czPcvFUg2hkmMF4g7Cr9gKigFvbmolIFBJvqgLDCt4I=;
	b=EC1jreNhZnhRJGuHfTOCkoNOND5WyxYeRK9TRuoMJpzQGfbo75teC6amKIUM/cMtSvdkgq
	PpvsJ3QtN/7mkNCIqN0Fk/6MqjdG/qWf96soI9knemVsG1/QB3G3NQ3CnO7fnDykyCpw1g
	DfstRZ5BcLmxo9hUdHgBjGR/Jnsj27g=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-557-IYfyWGgWNs2Jz9A9w-ucxw-1; Mon,
 08 Jul 2024 02:48:32 -0400
X-MC-Unique: IYfyWGgWNs2Jz9A9w-ucxw-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0323E19560A2;
	Mon,  8 Jul 2024 06:48:31 +0000 (UTC)
Received: from server.redhat.com (unknown [10.72.112.123])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 520FA19560B2;
	Mon,  8 Jul 2024 06:48:24 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com,
	dtatulea@nvidia.com,
	mst@redhat.com,
	jasowang@redhat.com,
	parav@nvidia.com,
	sgarzare@redhat.com,
	netdev@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Subject: [PATCH v3 0/2] vdpa: support set mac address from vdpa tool
Date: Mon,  8 Jul 2024 14:47:01 +0800
Message-ID: <20240708064820.88955-1-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Add support for setting the MAC address using the VDPA tool.
This feature will allow setting the MAC address using the VDPA tool.
For example, in vdpa_sim_net, the implementation sets the MAC address
to the config space. However, for other drivers, they can implement their
own function, not limited to the config space.

Changelog v2
 - Changed the function name to prevent misunderstanding
 - Added check for blk device
 - Addressed the comments
Changelog v3
 - Split the function of the net device from vdpa_nl_cmd_dev_attr_set_doit
 - Add a lock for the network device's dev_set_attr operation
 - Address the comments

Cindy Lu (2):
  vdpa: support set mac address from vdpa tool
  vdpa_sim_net: Add the support of set mac address

 drivers/vdpa/vdpa.c                  | 81 ++++++++++++++++++++++++++++
 drivers/vdpa/vdpa_sim/vdpa_sim_net.c | 19 ++++++-
 include/linux/vdpa.h                 |  9 ++++
 include/uapi/linux/vdpa.h            |  1 +
 4 files changed, 109 insertions(+), 1 deletion(-)

-- 
2.45.0

