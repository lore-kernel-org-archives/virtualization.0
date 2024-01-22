Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B463A1DE
	for <virtualization@lists.linux-foundation.org>; Mon, 22 Jan 2024 10:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705918989; cv=none; b=hFAFWQGJT5lSxXDEirzSgA7gwNOBJuJDfYvWKS9u1b8FWnyMsaEPHCGw57trY8QgwNHvX04zqrd3Xb/g+z0rW4RTYWPElXASISGyRz44RA6XVtclDhz2S7duIJC7SKqMytlrswBu6H83krlzpgSlvZDqFoHka9ZNo4I6x+RJghQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705918989; c=relaxed/simple;
	bh=Ock7B69XdGIXdbkP3Pl3P871KHNB5YiSNiJc9wfXg6A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tIoTqovJu+FCASPUxEibUS4rob6OL8N+BudP3z7BwcG0NV/X2jS/6zgRepPiO88TuRXYtY5rwAy1Z1qcfE45Q5dTOv16AsSCJkGs0nWgHxl+KpxuSTDZcwtH1EwfoIbaLCwJQ6HDWdpUu5QKR/kwhwoh0z99DdEwL0Kzrn81QiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GxWX7smB; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GxWX7smB"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7E5EC8237B
	for <virtualization@lists.linux-foundation.org>; Mon, 22 Jan 2024 10:23:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7E5EC8237B
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=GxWX7smB
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id puPyRe5uNPxy
	for <virtualization@lists.linux-foundation.org>;
	Mon, 22 Jan 2024 10:23:07 +0000 (UTC)
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
	by smtp1.osuosl.org (Postfix) with ESMTPS id E058982369
	for <virtualization@lists.linux-foundation.org>; Mon, 22 Jan 2024 10:23:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E058982369
Received: by mail-pj1-x102f.google.com with SMTP id 98e67ed59e1d1-290b1e19101so263903a91.0
        for <virtualization@lists.linux-foundation.org>; Mon, 22 Jan 2024 02:23:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705918986; x=1706523786; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dcV0b9EAD7cikX7TBR9d3JnFTgh+L0e81zNYPrMvnxA=;
        b=GxWX7smBaZR/538F3poSYMzYf/HnLBxOpV7PCpkcLEUCQFwrStM6SiTyziHvWZOg3l
         HYzlc3V0IQDGjMsMEFWaf/keLJHS8OBWW+rc48KujjFxbTIeEpFsoxATqExocMl12SgJ
         YZw0H6LXrdIC7ZU8x04RdHUBdOtFKiRIr+MnfZQ9uXkXdqtsVLgEYXVFHKbQ5qTJPD4B
         fTNBc6NwZSxbnRZoHDBxxLFe6khgX+w5s22ViVwnyCq86eldG+1TzQgGuizgNSwvUcF3
         wm+E99QwzK+i6F8Ye5FadulFTyYn957ZOdwza7LYj0Fl25WlGnW4eYOb3QNuJ70AZYFL
         kSUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705918986; x=1706523786;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dcV0b9EAD7cikX7TBR9d3JnFTgh+L0e81zNYPrMvnxA=;
        b=Ip3QKolwPSgIyrHkz97qEapj3NcIIpGiIBx4L91bK0m/jOX95h6BHJAJGeuSCu+ns7
         L2Ex8+faXq7CpDpzhSnTStsGk84kkVQNu6r4f9hFNkZZJjYUkM5bi/1ghS0QB+zQ9dOT
         0Z972BjJvqQCpIQ4ATsC6adREKLn/ASXTixaNskNjjKEtHwzu8XenW6za52+M/q1x5H0
         +Cxj/7W3xKA3c2MfSk/AGlPgXaMzcXkT9Vi3xFKtdox15VG1+r5ux+oZmrch4o/2XNPW
         ke68++tkvuZymnERty2+0Mv5Z3jEwlawRkT0Sr9BrbVlGlH2zxrqfy1pQGnpfGAzALVU
         fLMw==
X-Gm-Message-State: AOJu0YxRSvCpBA+3mZzlcDxuJD3J9nrTnguZzIgClXStpbx6BvKZ5dx6
	1G3o/cccOygEhWULE4+XwDFrWy67zCZgWRCQPya4Cn15izRKrdLY
X-Google-Smtp-Source: AGHT+IHVwosNjjzlFduyjv9cVRyks0refrlWsNmXZ/WWUafu5XgUkYbq7SH7UpuFcqAkCnZT5Hmizw==
X-Received: by 2002:a17:90a:1041:b0:290:2405:aee7 with SMTP id y1-20020a17090a104100b002902405aee7mr6720307pjd.11.1705918986114;
        Mon, 22 Jan 2024 02:23:06 -0800 (PST)
Received: from dell.. ([111.192.196.252])
        by smtp.googlemail.com with ESMTPSA id su7-20020a17090b534700b0028d29d837c7sm9099697pjb.36.2024.01.22.02.23.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 02:23:05 -0800 (PST)
From: Liang Chen <liangchen.linux@gmail.com>
To: mst@redhat.com,
	jasowang@redhat.com
Cc: virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org,
	liangchen.linux@gmail.com
Subject: [PATCH] virtio_net: Support RX hash XDP hint
Date: Mon, 22 Jan 2024 18:22:56 +0800
Message-Id: <20240122102256.261374-1-liangchen.linux@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The RSS hash report is a feature that's part of the virtio specification.
Currently, virtio backends like qemu, vdpa (mlx5), and potentially vhost
(still a work in progress as per [1]) support this feature. While the
capability to obtain the RSS hash has been enabled in the normal path,
it's currently missing in the XDP path. Therefore, we are introducing XDP
hints through kfuncs to allow XDP programs to access the RSS hash.

Signed-off-by: Liang Chen <liangchen.linux@gmail.com>
---
 drivers/net/virtio_net.c | 56 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index d7ce4a1011ea..1463a4709e3c 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -4579,6 +4579,60 @@ static void virtnet_set_big_packets(struct virtnet_info *vi, const int mtu)
 	}
 }
 
+static int virtnet_xdp_rx_hash(const struct xdp_md *_ctx, u32 *hash,
+			   enum xdp_rss_hash_type *rss_type)
+{
+	const struct xdp_buff *xdp = (void *)_ctx;
+	struct virtio_net_hdr_v1_hash *hdr_hash;
+	struct virtnet_info *vi;
+
+	if (!(xdp->rxq->dev->features & NETIF_F_RXHASH))
+		return -ENODATA;
+
+	vi = netdev_priv(xdp->rxq->dev);
+	hdr_hash = (struct virtio_net_hdr_v1_hash *)(xdp->data - vi->hdr_len);
+
+	switch (__le16_to_cpu(hdr_hash->hash_report)) {
+		case VIRTIO_NET_HASH_REPORT_TCPv4:
+			*rss_type = XDP_RSS_TYPE_L4_IPV4_TCP;
+			break;
+		case VIRTIO_NET_HASH_REPORT_UDPv4:
+			*rss_type = XDP_RSS_TYPE_L4_IPV4_UDP;
+			break;
+		case VIRTIO_NET_HASH_REPORT_TCPv6:
+			*rss_type = XDP_RSS_TYPE_L4_IPV6_TCP;
+			break;
+		case VIRTIO_NET_HASH_REPORT_UDPv6:
+			*rss_type = XDP_RSS_TYPE_L4_IPV6_UDP;
+			break;
+		case VIRTIO_NET_HASH_REPORT_TCPv6_EX:
+			*rss_type = XDP_RSS_TYPE_L4_IPV6_TCP_EX;
+			break;
+		case VIRTIO_NET_HASH_REPORT_UDPv6_EX:
+			*rss_type = XDP_RSS_TYPE_L4_IPV6_UDP_EX;
+			break;
+		case VIRTIO_NET_HASH_REPORT_IPv4:
+			*rss_type = XDP_RSS_TYPE_L3_IPV4;
+			break;
+		case VIRTIO_NET_HASH_REPORT_IPv6:
+			*rss_type = XDP_RSS_TYPE_L3_IPV6;
+			break;
+		case VIRTIO_NET_HASH_REPORT_IPv6_EX:
+			*rss_type = XDP_RSS_TYPE_L3_IPV6_EX;
+			break;
+		case VIRTIO_NET_HASH_REPORT_NONE:
+		default:
+			*rss_type = XDP_RSS_TYPE_NONE;
+	}
+
+	*hash = __le32_to_cpu(hdr_hash->hash_value);
+	return 0;
+}
+
+static const struct xdp_metadata_ops virtnet_xdp_metadata_ops = {
+	.xmo_rx_hash			= virtnet_xdp_rx_hash,
+};
+
 static int virtnet_probe(struct virtio_device *vdev)
 {
 	int i, err = -ENOMEM;
@@ -4613,6 +4667,8 @@ static int virtnet_probe(struct virtio_device *vdev)
 	dev->ethtool_ops = &virtnet_ethtool_ops;
 	SET_NETDEV_DEV(dev, &vdev->dev);
 
+	dev->xdp_metadata_ops = &virtnet_xdp_metadata_ops;
+
 	/* Do we support "hardware" checksums? */
 	if (virtio_has_feature(vdev, VIRTIO_NET_F_CSUM)) {
 		/* This opens up the world of extra features. */
-- 
2.40.1

