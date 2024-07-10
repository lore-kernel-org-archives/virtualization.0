Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F6915E5BA
	for <virtualization@lists.linux-foundation.org>; Wed, 10 Jul 2024 21:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720646767; cv=none; b=E8ueK1c7cggE43Ce1flcCmViMR44o0PcQ+3slnN8Gtio4dTJzfz63ePvoYMbEzKL+GQdQsaQ1QpGqtP4Q7k1a9ocVPljYBz4cPev6MBKZ487gsoI/si+KiU0tPJVAg/3vmKL+KNyleWEod7qS+Ukso1AIQFIuw+glbF207JO4bY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720646767; c=relaxed/simple;
	bh=UfwlPBtk149XzS/tcMuqUXOpP079VnWFi28qU26z4ck=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=levIYRL36SUHePxMVd0c9ZeAcZg95AljdJ+Nz/9/a+5g+0mifSHfwrxqfTHcErgG7mN/+0MGLip4chPJAxg/rNnVipkZ7xhIaBxLrzP5VpX4n3sNxEGfnECyYn29lDnz18whNq1ZSz2thf+q/J8CZjqH2TYFOdGHyibcXTikhic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dQ3dPu5h; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dQ3dPu5h"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id ADD83608A9
	for <virtualization@lists.linux-foundation.org>; Wed, 10 Jul 2024 21:26:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: 1.236
X-Spam-Level: *
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0rFZVvWPoNft for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Jul 2024 21:26:02 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::729; helo=mail-qk1-x729.google.com; envelope-from=ameryhung@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 14D0260EDF
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none) header.from=gmail.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 14D0260EDF
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=dQ3dPu5h
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 14D0260EDF
	for <virtualization@lists.linux-foundation.org>; Wed, 10 Jul 2024 21:26:01 +0000 (UTC)
Received: by mail-qk1-x729.google.com with SMTP id af79cd13be357-79f1be45ca8so14205285a.3
        for <virtualization@lists.linux-foundation.org>; Wed, 10 Jul 2024 14:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720646761; x=1721251561; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BJWi8Leq2jo3M3Yc8XcwnzkcrKsxdOFNGRCXzkErj3E=;
        b=dQ3dPu5hO+SZwjT8QJSfeWM/UKpUYGK6oiLlg5FX3hfMh3jO0kx38PgZLtYrVy9iT3
         kGw0ifmjDpQqIuwWCUcEYIYnUnk/a8Q8iX8btsUgysc/OsfRVJLcMlxPJtVsi/N9gH78
         T+YGiNDNT5Pe0PF+Jm7Eenwj1J1Rv6ALJpJ/e8zQviNd7SU0bhK48S9g86WoQ33kKO/g
         T0T+vxXYi+5GlIJcikotp6taBRDzzhh/+0PaxxNrA8G25eHS82mY2F+oI72OCAtZIYSs
         SKmTFDQ2ID698pXCC9wKHD8YHaU/mCPFCeWS30Gh2+tgU3km7jZo0JK8N6VUiMvvH8QT
         XenA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720646761; x=1721251561;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BJWi8Leq2jo3M3Yc8XcwnzkcrKsxdOFNGRCXzkErj3E=;
        b=m2nCzinCvxbfzEMcl1TUKAoViUwWoN/YhGw7cNS0e5z+uGvKmuDhr1Dw1avV3/ET2i
         jd8AaBv6W0KUivq49Tk+0Jj0kNVMwDPLCOR+Jg4i+Un6zIGi/GvUPoTuDH2YOTyN+QjS
         Kw2baMXSyZk+vF7lrzjuf1wbrVEuIqpFf4rz3gtSxWrds4phgkED8kAJYrW85N1Xakfo
         Tao8tHbe9L2C7vx4QNzER1w7NI+z6RSdrLNu2rBlKIBi3i/QmX/dNhEU/fmcLZd7cyfL
         VWi8wz7e1/uDN0ZeoOI9TeXWivrAOMgPRhLIF8iBYiHQ9vzjEkqLLAuqGkYzFNOx+giq
         OEYw==
X-Forwarded-Encrypted: i=1; AJvYcCUOfs3v9OzXzAUPNsJ3gxpKNRy1YVIo4XMklwspeMpRKsNObCcgip4RZc9gFUGFyJP8YT/jNFkdWhY/RuvGQi9pXmJIHUVmwoMv9MOtz147QqHLYJ20J2bKRw==
X-Gm-Message-State: AOJu0Yxvl3JXlclxDUGqb6ToTOUGyGqfD8JvWKAZdph8ESYVBKzRc6ee
	X6Qrz+wz44OntTXmw8Piu3SWfQGK/RDdJyYaSR8hepxOJUMDfCn+d0DEAA==
X-Google-Smtp-Source: AGHT+IEeRGnHtiCEw+KM2q98xiDSRuWiiJOOgf2jpC5OHvHQB6LFE7ca10rhiE0Y5d3kMoOxfyhvtw==
X-Received: by 2002:a05:620a:2186:b0:79c:119e:2b44 with SMTP id af79cd13be357-79f19a51d7fmr733112885a.3.1720646760834;
        Wed, 10 Jul 2024 14:26:00 -0700 (PDT)
Received: from n36-183-057.byted.org ([130.44.215.118])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79f190b0af1sm228791885a.122.2024.07.10.14.26.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 14:26:00 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
X-Google-Original-From: Amery Hung <amery.hung@bytedance.com>
To: stefanha@redhat.com,
	sgarzare@redhat.com,
	mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	bryantan@vmware.com,
	vdasa@vmware.com,
	pv-drivers@vmware.com
Cc: dan.carpenter@linaro.org,
	simon.horman@corigine.com,
	oxffffaa@gmail.com,
	kvm@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	bpf@vger.kernel.org,
	bobby.eshleman@bytedance.com,
	jiang.wang@bytedance.com,
	amery.hung@bytedance.com,
	ameryhung@gmail.com,
	xiyou.wangcong@gmail.com
Subject: [RFC PATCH net-next v6 06/14] virtio/vsock: add VIRTIO_VSOCK_TYPE_DGRAM
Date: Wed, 10 Jul 2024 21:25:47 +0000
Message-Id: <20240710212555.1617795-7-amery.hung@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240710212555.1617795-1-amery.hung@bytedance.com>
References: <20240710212555.1617795-1-amery.hung@bytedance.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bobby Eshleman <bobby.eshleman@bytedance.com>

This commit adds the datagram packet type for inclusion in virtio vsock
packet headers. It is included here as a standalone commit because
multiple future but distinct commits depend on it.

Signed-off-by: Bobby Eshleman <bobby.eshleman@bytedance.com>
---
 include/uapi/linux/virtio_vsock.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/uapi/linux/virtio_vsock.h b/include/uapi/linux/virtio_vsock.h
index 64738838bee5..331be28b1d30 100644
--- a/include/uapi/linux/virtio_vsock.h
+++ b/include/uapi/linux/virtio_vsock.h
@@ -69,6 +69,7 @@ struct virtio_vsock_hdr {
 enum virtio_vsock_type {
 	VIRTIO_VSOCK_TYPE_STREAM = 1,
 	VIRTIO_VSOCK_TYPE_SEQPACKET = 2,
+	VIRTIO_VSOCK_TYPE_DGRAM = 3,
 };
 
 enum virtio_vsock_op {
-- 
2.20.1

