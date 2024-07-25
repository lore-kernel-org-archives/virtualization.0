Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 341FAC8E1
	for <virtualization@lists.linux-foundation.org>; Thu, 25 Jul 2024 01:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721871156; cv=none; b=kH7TfhYrayk1ekmXRNVrZa6t2q2YxCgUb++1Aj2FEsNvb+t2lOfg5CDiIklPT9Bd9cYIjvSCsuhPSnzrILWjJbCZD9emigvXRpcDYrsjRUn3sgoKnQ+e+VSnFCBjtBtNsr47cgZwNXyh+zbr4Zjal2F/PXZWsfJvB8WTeqSW5Bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721871156; c=relaxed/simple;
	bh=f5IcGXYse95pgYaA+PA4U920JSA5b88X1Xog3re2538=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=iLg16wfBg1x2PKkbpD3Dz55k5Uf+IMQutJL8szDEf1rK9xnwWQjQQZOK8Dvr0ovE5SLbOJTs78s3r98NM2nso4IkAkqGkFVlP28yT6dh4IFs5T+U1ArxXkJ4I2U5IBo2JNRSxcEUuRQcXi00Z0tvaPGt61rT3QGQrGouJxnmJNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CFoPzT6i; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CFoPzT6i"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id BD86F40E5D
	for <virtualization@lists.linux-foundation.org>; Thu, 25 Jul 2024 01:32:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id os-zEkmXVwIn for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Jul 2024 01:32:34 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=lulu@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org B162340175
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B162340175
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=CFoPzT6i
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp2.osuosl.org (Postfix) with ESMTPS id B162340175
	for <virtualization@lists.linux-foundation.org>; Thu, 25 Jul 2024 01:32:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721871151;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=3AFvrky8PX7geVy4VOlD+26UP7h3zv3ayB+/222jDiQ=;
	b=CFoPzT6ie1ORLjelAHNH+BGSUbbpkl2SvSIblBH86/Zd9xO4xS4sJe5kd4x5LI6QOWRsSu
	bLslHd2x6j81o4wC2JK5tgEPQNtPU5I3OQY4LZ1ezXTbZ7EGVS7cZEK2HPGXK+xODRYKLW
	TrYQt0xVaS/FFuEcwMz+xakRLFL5mYs=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-445-Cxb1LMW5NW-3XnmWQtYOiA-1; Wed,
 24 Jul 2024 21:32:27 -0400
X-MC-Unique: Cxb1LMW5NW-3XnmWQtYOiA-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2C7701955D45;
	Thu, 25 Jul 2024 01:32:26 +0000 (UTC)
Received: from server.redhat.com (unknown [10.72.112.141])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E54031955D42;
	Thu, 25 Jul 2024 01:32:20 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com,
	dtatulea@nvidia.com,
	mst@redhat.com,
	jasowang@redhat.com,
	parav@nvidia.com,
	sgarzare@redhat.com,
	netdev@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org
Subject: [PATH v6 0/3] vdpa: support set mac address from vdpa tool
Date: Thu, 25 Jul 2024 09:31:01 +0800
Message-ID: <20240725013217.1124704-1-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

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
Changelog v4
 - Address the comments
 - Add a lock for the vdap_sim?_net device's dev_set_attr operation
Changelog v5
 - Address the comments
Changelog v6 
- Replace all the memcpy of mac address with ether_addr_copy()
- Remove the check for VIRTIO_NET_F_MAC in vdpa_dev_net_device_attr_set
- Remove unnecessary check
- Enhance the error log

Cindy Lu (3):
  vdpa: support set mac address from vdpa tool
  vdpa_sim_net: Add the support of set mac address
  vdpa/mlx5: Add the support of set mac address

 drivers/vdpa/mlx5/net/mlx5_vnet.c    | 28 ++++++++++
 drivers/vdpa/vdpa.c                  | 80 ++++++++++++++++++++++++++++
 drivers/vdpa/vdpa_sim/vdpa_sim_net.c | 22 +++++++-
 include/linux/vdpa.h                 |  9 ++++
 include/uapi/linux/vdpa.h            |  1 +
 5 files changed, 139 insertions(+), 1 deletion(-)

-- 
2.45.0

