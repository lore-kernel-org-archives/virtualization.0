Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58F5330ACF4
	for <virtualization@lists.linux.dev>; Sun,  8 Feb 2026 14:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770561307; cv=none; b=UAU1nQe0qH3WK1K/aQ72+Xj7nhUGNp060hJFhSdFcwfChEPqWpLhNXZfjT2GiS0zkosPUTCtKnpQ+rul3NXYDQAvUIhDy8AJatq3byndYV88kXYL6kxWrJC/16uaTtRkZy5vD2zzh3yCsq3FCO5QnazFDe6pdz1GItOGRt3hylw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770561307; c=relaxed/simple;
	bh=jbLiVAKMhESJ8+i8oOV5pM46x7SY1sE0iQGT/xEUVFU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=YiC9k7WiJJQUSkRsPlHQVQrcEaNRiiKMvwHTrQPFM2QC06JZVEbJZVxkDHxj4ts2TGzvAV/62+hnIzBMYnBele5mgcNaGNjwYYBORez5aSwmXJCeQE8baCRt3krfzA4pkoxtKfRnCoBh8pmemJjzHsAod2oRLgahV1Ti/aFeZK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CZBid2tc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CZBid2tc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770561306;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CVev9RGq9dVMgOhnEQZeZI8sYWkDO4xwFAo1DRJbKV4=;
	b=CZBid2tcHEvQSOxcoYORdMc5Dzk1L9ncfq3aJin8UkSFyAQX6fWBjl1I+ek8+pMR2T7jkK
	dMD3F2ovcb9f5Xq5MfzutbYtmlN59iyDsn7FOR06Zv1bZY021Smcap7dZKLMhVCnycz0XF
	HKht067t4z7MOxhQAt2kgcOKT4uJ0gg=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-41-YIOmSm6KMder5mDp-5P10g-1; Sun,
 08 Feb 2026 09:35:03 -0500
X-MC-Unique: YIOmSm6KMder5mDp-5P10g-1
X-Mimecast-MFC-AGG-ID: YIOmSm6KMder5mDp-5P10g_1770561302
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D34AC1956089;
	Sun,  8 Feb 2026 14:35:01 +0000 (UTC)
Received: from S2.redhat.com (unknown [10.72.112.33])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2CC2C18004BB;
	Sun,  8 Feb 2026 14:34:57 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com,
	mst@redhat.com,
	jasowang@redhat.com,
	kvm@vger.kernel.org,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC 1/3] uapi: vhost: add vhost-net netfilter offload API
Date: Sun,  8 Feb 2026 22:32:22 +0800
Message-ID: <20260208143441.2177372-2-lulu@redhat.com>
In-Reply-To: <20260208143441.2177372-1-lulu@redhat.com>
References: <20260208143441.2177372-1-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: f2v27ULO8hR0n2owjAhyGrESFFaEgctQuA5NdWXISaQ_1770561302
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Add VHOST_NET_SET_FILTER ioctl and the filter socket protocol used for
vhost-net filter offload.

Signed-off-by: Cindy Lu <lulu@redhat.com>
---
 include/uapi/linux/vhost.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/include/uapi/linux/vhost.h b/include/uapi/linux/vhost.h
index c57674a6aa0d..d9a0ca7a3df0 100644
--- a/include/uapi/linux/vhost.h
+++ b/include/uapi/linux/vhost.h
@@ -131,6 +131,26 @@
  * device.  This can be used to stop the ring (e.g. for migration). */
 #define VHOST_NET_SET_BACKEND _IOW(VHOST_VIRTIO, 0x30, struct vhost_vring_file)
 
+/* VHOST_NET filter offload (kernel vhost-net dataplane through QEMU netfilter) */
+struct vhost_net_filter {
+	__s32 fd;
+};
+
+enum {
+	VHOST_NET_FILTER_MSG_REQUEST = 1,
+};
+
+#define VHOST_NET_FILTER_DIRECTION_TX 1
+
+struct vhost_net_filter_msg {
+	__u16 type;
+	__u16 direction;
+	__u32 len;
+};
+
+
+#define VHOST_NET_SET_FILTER _IOW(VHOST_VIRTIO, 0x31, struct vhost_net_filter)
+
 /* VHOST_SCSI specific defines */
 
 #define VHOST_SCSI_SET_ENDPOINT _IOW(VHOST_VIRTIO, 0x40, struct vhost_scsi_target)
-- 
2.52.0

