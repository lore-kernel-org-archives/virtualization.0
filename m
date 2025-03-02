Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 348D81E4A9
	for <virtualization@lists.linux-foundation.org>; Sun,  2 Mar 2025 14:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740926088; cv=none; b=g2JMhqBM5K5jPjYijeXx4AISfAhdF3Ms1cirLPWFXVJySTPw0a9XNJPcn9nxNNZNcHnXLb0RGezSH7wL+PttBGwLGmmDq4Ftr4xrQcBciRPMOwnx+FaA2tFHfDi/HuHkYDrNHEh1Au7Wm/YUSP7bD20BRDfmZMdR/jmeqWZ5CAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740926088; c=relaxed/simple;
	bh=3d1vy7K3Ewc6kBuoFdLtOj9nxEdW0vN1tk9jlWajiE4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qUqv8EqwdALFkYV+lAmSS5IvrkDccABr4HtatwQPOANqAZCZNl34cycdRKlt5VmfZcaHutii2Q8G8srrbhO6jfGVlq2k6XVczC2PzPGwbMX8gePCai8xPo3dlrGB+zdhmQlctmiFWzI8U/KAY9pEUmxM62E8O3y+U7AQB7crp4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A5b5sBLd; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A5b5sBLd"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id B5914400E4
	for <virtualization@lists.linux-foundation.org>; Sun,  2 Mar 2025 14:34:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.793
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Gx3XlSFJrC2I for <virtualization@lists.linux-foundation.org>;
 Sun,  2 Mar 2025 14:34:45 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=lulu@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 974C040274
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 974C040274
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=A5b5sBLd
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 974C040274
	for <virtualization@lists.linux-foundation.org>; Sun,  2 Mar 2025 14:34:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740926083;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UZogOKk63vf4EDKHQk5Lj385qY5SA+Ws34nKuNOin7A=;
	b=A5b5sBLdpF2HAJWCsfclZWnqRrqGWcdN4QUoFSLCsiW41PD5O0HbBf8P+XjlchYZ6Nc7St
	H7x1T54bo97rCOamW5ChlOK9iw/5sjLPZr+MNU+lgVsHCuTt3MmzFoOaoo4PDFsECTRpii
	Iiau7UdwqjaY9NtFSRSUgP/sJQ9Zk6o=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-86-dEq8IECyNwWicdQhcmOKLg-1; Sun,
 02 Mar 2025 09:34:42 -0500
X-MC-Unique: dEq8IECyNwWicdQhcmOKLg-1
X-Mimecast-MFC-AGG-ID: dEq8IECyNwWicdQhcmOKLg_1740926081
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 599311800877;
	Sun,  2 Mar 2025 14:34:41 +0000 (UTC)
Received: from server.redhat.com (unknown [10.72.112.49])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B62191956048;
	Sun,  2 Mar 2025 14:34:36 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com,
	jasowang@redhat.com,
	mst@redhat.com,
	michael.christie@oracle.com,
	sgarzare@redhat.com,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org
Subject: [PATCH v7 8/8] vhost: Add a KConfig knob to enable IOCTL VHOST_FORK_FROM_OWNER
Date: Sun,  2 Mar 2025 22:32:10 +0800
Message-ID: <20250302143259.1221569-9-lulu@redhat.com>
In-Reply-To: <20250302143259.1221569-1-lulu@redhat.com>
References: <20250302143259.1221569-1-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Introduce a new config knob `CONFIG_VHOST_ENABLE_FORK_OWNER_IOCTL`,
to control the availability of the `VHOST_FORK_FROM_OWNER` ioctl.
When CONFIG_VHOST_ENABLE_FORK_OWNER_IOCTL is set to n, the ioctl
is disabled, and any attempt to use it will result in failure.

Signed-off-by: Cindy Lu <lulu@redhat.com>
---
 drivers/vhost/Kconfig | 15 +++++++++++++++
 drivers/vhost/vhost.c | 11 +++++++++++
 2 files changed, 26 insertions(+)

diff --git a/drivers/vhost/Kconfig b/drivers/vhost/Kconfig
index b455d9ab6f3d..e5b9dcbf31b6 100644
--- a/drivers/vhost/Kconfig
+++ b/drivers/vhost/Kconfig
@@ -95,3 +95,18 @@ config VHOST_CROSS_ENDIAN_LEGACY
 	  If unsure, say "N".
 
 endif
+
+config VHOST_ENABLE_FORK_OWNER_IOCTL
+	bool "Enable IOCTL VHOST_FORK_FROM_OWNER"
+	default n
+	help
+	  This option enables the IOCTL VHOST_FORK_FROM_OWNER, which allows
+	  userspace applications to modify the thread mode for vhost devices.
+
+          By default, `CONFIG_VHOST_ENABLE_FORK_OWNER_IOCTL` is set to `n`,
+          meaning the ioctl is disabled and any operation using this ioctl
+          will fail.
+          When the configuration is enabled (y), the ioctl becomes
+          available, allowing users to set the mode if needed.
+
+	  If unsure, say "N".
diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index fb0c7fb43f78..09e5e44dc516 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -2294,6 +2294,8 @@ long vhost_dev_ioctl(struct vhost_dev *d, unsigned int ioctl, void __user *argp)
 		r = vhost_dev_set_owner(d);
 		goto done;
 	}
+
+#ifdef CONFIG_VHOST_ENABLE_FORK_OWNER_IOCTL
 	if (ioctl == VHOST_FORK_FROM_OWNER) {
 		u8 inherit_owner;
 		/*inherit_owner can only be modified before owner is set*/
@@ -2313,6 +2315,15 @@ long vhost_dev_ioctl(struct vhost_dev *d, unsigned int ioctl, void __user *argp)
 		r = 0;
 		goto done;
 	}
+
+#else
+	if (ioctl == VHOST_FORK_FROM_OWNER) {
+		/* When CONFIG_VHOST_ENABLE_FORK_OWNER_IOCTL is 'n', return error */
+		r = -ENOTTY;
+		goto done;
+	}
+#endif
+
 	/* You must be the owner to do anything else */
 	r = vhost_dev_check_owner(d);
 	if (r)
-- 
2.45.0

