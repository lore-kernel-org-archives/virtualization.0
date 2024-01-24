Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A66318B1A
	for <virtualization@lists.linux-foundation.org>; Wed, 24 Jan 2024 08:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706086728; cv=none; b=qYDOR/InUs9tMf/EC1TUucxF1WNDoL9n064sDeW9/JeBEKR9h/XZV7jmgvPRLF1oGWNzobfELBkF3cf5GQCrmOvresOS7oMgCmpT1ziDWD/hYFAHj7SKpeHvgq+mLmkvfp0jK+/8tLfB1RCfloLFTOAAvTKTp+gluKdlLQT2tpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706086728; c=relaxed/simple;
	bh=e83VYaOS+ohDX9NqoEmbl86kN06hJQqQLEN1Cb5MMwE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fFtxzGuxSrU8Q0WbAt2np7Ot/pC7u7HmTB1jJsPLg61zPZMy9KFw6zfpKgBU1LeKKnFpFDM71ajxes9yl8rk1Xge4T978pWcqGSONwwATq73rrZBR9ehSPqKtI1AEcBQdMcRJLiTGZ+G5i6cgW0j5vAgZKCvgkkBlWI3xE28/KQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dL8AdHBI; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dL8AdHBI"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D1ED46143F
	for <virtualization@lists.linux-foundation.org>; Wed, 24 Jan 2024 08:58:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D1ED46143F
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=dL8AdHBI
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nZV9x6btx-3X
	for <virtualization@lists.linux-foundation.org>;
	Wed, 24 Jan 2024 08:58:46 +0000 (UTC)
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 061B961430
	for <virtualization@lists.linux-foundation.org>; Wed, 24 Jan 2024 08:58:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 061B961430
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-2906773c7e9so1876200a91.1
        for <virtualization@lists.linux-foundation.org>; Wed, 24 Jan 2024 00:58:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706086725; x=1706691525; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YCaG2FhLI+ULzJLYRzk2AkDEJ54d7JQsIyeO5H61ju8=;
        b=dL8AdHBIrmhS9HkcK3FhC5DXwtGcmZhNXvyDuVukSlMUXZAIb31TK5LkPdyKavrUGf
         wWZhEcBQQjY/SAWUkuJK0nJdgTDn5ll5CyBlpad9E6tG/6Lp/YXo10vRRGOggnJP4t1S
         Gc1Jl5cMiJwYvYbF/asrQyvvZuC2mKXUxb+rec820dtWOO5hmVgvDUfvhA4wHlFm3cJ7
         eJmj4DY1Ioe2tpmgsRI5shle9B4GIKdp+WTM54a+4YYZWResmOSEqxVSGvQ6Kie9hw4O
         2Pv+itMY61qavMDVlipFWlsFxYtYwAjs5jtCA4d9EmpcYJW41LpXNZNYuhqbEQY7Oj2l
         LqIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706086725; x=1706691525;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YCaG2FhLI+ULzJLYRzk2AkDEJ54d7JQsIyeO5H61ju8=;
        b=ucn2zPhgU8mlKIzMo36ZjcaJwW/6GtWdefY8+SBWGVXwBmAv4HeYeHXCe4YeXM5eTY
         ccfcBoeFaBrrUbT2hidJtQ8C/ewFlPLTjiOW+/HH8vby8CD4VDXC4WWa6sG1nkpMRckS
         mXCKqQNuWwFxbinEc0DydAm5l6ociozuC33VRtE9y6a2eFGdt5vsbCP9LVvzeLATs4nS
         hw9NLlyKJvjHpU753fsPG+9bmr9OkGDT2eiUOh7UQsu76VwZMoDR0mpgqb4nUK/DlJfw
         GKzgCSMcrMoyqPOBArmUBPMHvXXFpmGWrM8veFpRT9BS0D6SN/8hOuyCSSyUSfk0ost4
         VIyA==
X-Gm-Message-State: AOJu0YzxzRSyZsZB4ppBia9JU66E0oVAPLjievcefZ3+lPKySbmEPp53
	qeyvBaxs5chLoahpWRewbduzW6WWsqhZnZ3vPzaXuswyYmTjbVye
X-Google-Smtp-Source: AGHT+IFPGrGWhb1Ny8AdbAA6Fc5MnoDmXHW5eNVLBfnh1MQ27z1kg/juqZ0/OXtEEa3QE6CQbT4kXQ==
X-Received: by 2002:a17:90a:e557:b0:28e:3817:5844 with SMTP id ei23-20020a17090ae55700b0028e38175844mr3326022pjb.42.1706086725407;
        Wed, 24 Jan 2024 00:58:45 -0800 (PST)
Received: from localhost.localdomain ([107.167.25.130])
        by smtp.googlemail.com with ESMTPSA id sb3-20020a17090b50c300b0028ffc524085sm13192233pjb.56.2024.01.24.00.58.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 00:58:44 -0800 (PST)
From: Liang Chen <liangchen.linux@gmail.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	hengqi@linux.alibaba.com,
	xuanzhuo@linux.alibaba.com
Cc: virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org,
	liangchen.linux@gmail.com
Subject: [PATCH v2 3/3] virtio_net: Support RX hash XDP hint
Date: Wed, 24 Jan 2024 16:57:21 +0800
Message-Id: <20240124085721.54442-4-liangchen.linux@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240124085721.54442-1-liangchen.linux@gmail.com>
References: <20240124085721.54442-1-liangchen.linux@gmail.com>
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

1.
https://lore.kernel.org/all/20231015141644.260646-1-akihiko.odaki@daynix.com/#r

Signed-off-by: Liang Chen <liangchen.linux@gmail.com>
---
 drivers/net/virtio_net.c | 53 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 2de46eb4c661..ed6a4aa3fe04 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -4604,6 +4604,58 @@ static void virtnet_set_big_packets(struct virtnet_info *vi, const int mtu)
 	}
 }
 
+static int virtnet_xdp_rx_hash(const struct xdp_md *_ctx, u32 *hash,
+			       enum xdp_rss_hash_type *rss_type)
+{
+	const struct virtnet_xdp_buff *virtnet_xdp = (void *)_ctx;
+	struct virtio_net_hdr_v1_hash *hdr_hash;
+
+	if (!(virtnet_xdp->xdp.rxq->dev->features & NETIF_F_RXHASH))
+		return -ENODATA;
+
+	hdr_hash = (struct virtio_net_hdr_v1_hash *)(&virtnet_xdp->hdr);
+
+	switch (__le16_to_cpu(hdr_hash->hash_report)) {
+	case VIRTIO_NET_HASH_REPORT_TCPv4:
+		*rss_type = XDP_RSS_TYPE_L4_IPV4_TCP;
+		break;
+	case VIRTIO_NET_HASH_REPORT_UDPv4:
+		*rss_type = XDP_RSS_TYPE_L4_IPV4_UDP;
+		break;
+	case VIRTIO_NET_HASH_REPORT_TCPv6:
+		*rss_type = XDP_RSS_TYPE_L4_IPV6_TCP;
+		break;
+	case VIRTIO_NET_HASH_REPORT_UDPv6:
+		*rss_type = XDP_RSS_TYPE_L4_IPV6_UDP;
+		break;
+	case VIRTIO_NET_HASH_REPORT_TCPv6_EX:
+		*rss_type = XDP_RSS_TYPE_L4_IPV6_TCP_EX;
+		break;
+	case VIRTIO_NET_HASH_REPORT_UDPv6_EX:
+		*rss_type = XDP_RSS_TYPE_L4_IPV6_UDP_EX;
+		break;
+	case VIRTIO_NET_HASH_REPORT_IPv4:
+		*rss_type = XDP_RSS_TYPE_L3_IPV4;
+		break;
+	case VIRTIO_NET_HASH_REPORT_IPv6:
+		*rss_type = XDP_RSS_TYPE_L3_IPV6;
+		break;
+	case VIRTIO_NET_HASH_REPORT_IPv6_EX:
+		*rss_type = XDP_RSS_TYPE_L3_IPV6_EX;
+		break;
+	case VIRTIO_NET_HASH_REPORT_NONE:
+	default:
+		*rss_type = XDP_RSS_TYPE_NONE;
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
@@ -4729,6 +4781,7 @@ static int virtnet_probe(struct virtio_device *vdev)
 				  VIRTIO_NET_RSS_HASH_TYPE_UDP_EX);
 
 		dev->hw_features |= NETIF_F_RXHASH;
+		dev->xdp_metadata_ops = &virtnet_xdp_metadata_ops;
 	}
 
 	if (vi->has_rss_hash_report)
-- 
2.40.1

