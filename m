Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CECF13D1CA7
	for <virtualization@lists.linux.dev>; Tue, 24 Mar 2026 15:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774365363; cv=none; b=js4paKBsx27oLBmMkQ+LBeZX+ow5zahbIpC0d6ty3+8WyVlIodISqDJh1lN5EfGu7w3AN53J91SbBVS4ZHxsf8uFWp0/5/B4LSUPeIYutr7OI6deeYKdasJbvJxWIg7QFKaIBV7Wg9HLMjkXpbAEyc1pKjMPWZA9eIa1bWU+mxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774365363; c=relaxed/simple;
	bh=0DAQT5hcnfFP7UoqaO6an4vhVS498McC5K6b/zfmBDc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=FTJ05KJYg1IpCheZyPowz2FY1+yUpqiD7kYoon5w1l+SF6hFgjT713LK5GCw/P1FtpGDJwnRSxn3pNS7oxcJCndkKyIKB7xDeV5TGSJBJPlB94on2kFpAuXy3/cWhFsU+R9Ipbz29SylmanM0gmj52Vjx+SlOTMM0kW8sF4IsOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E5jqo7Ps; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E5jqo7Ps"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774365360;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=zZaZ+weNFt/DeQ+y853Qd9D2vVvyy8X2coFZA5Jbyn4=;
	b=E5jqo7PsAcxpFcO+ac7Z/QtF+S0Pim9g+/Hut12J8KPBttI+hO/iuV7UTFJuP39n1fgTlM
	zWwNskvpCx1lp+mrW9iyg6+qW45y/XYJDt6wfrrozeI8erjUHwF9SnofdXGfyphRtBaDOr
	WrlFSG44GBds72YbzT2boEDI7F3N0+Q=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-83-CTiSd0rdOzKcEQEc8yZROQ-1; Tue, 24 Mar 2026 11:15:59 -0400
X-MC-Unique: CTiSd0rdOzKcEQEc8yZROQ-1
X-Mimecast-MFC-AGG-ID: CTiSd0rdOzKcEQEc8yZROQ_1774365358
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-485c45885e6so59102045e9.0
        for <virtualization@lists.linux.dev>; Tue, 24 Mar 2026 08:15:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774365358; x=1774970158;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zZaZ+weNFt/DeQ+y853Qd9D2vVvyy8X2coFZA5Jbyn4=;
        b=m9ZlIGnn7xhf92Ggzsx5JcBhZ3eJN2worem8yuQ8+WtBch4U59N2HHNEaNgTabri08
         GvC2eBYwAQeFFzwjk6wu7SfilX8nwZ/HDiiaWp5+jtXXtrgf5Ys508iEyEdP0bLeZ4NZ
         5WoSkk5Dapw40LsGgLrc7U7M1T9KScQPkmOtr2suaamw+aiUQ46RfPuqMJBrB+29VBOl
         ZhwaBDdsTarGNFbjzZFZYA+0mkg+TyEcSe7TBys8hpqXxJUERekFYrdG8HDmZWkI/zap
         4ru4h86vtITSzyIbsuHOiQgT+IvMKb4HTxY8G1YrFcQ+J/i7QykwBQBZscOzdnIRM9oU
         gKUQ==
X-Forwarded-Encrypted: i=1; AJvYcCUt+hivpeaBCU9+f8tHdMtC8EOJUVlgLWsggABOkx+08fOvJ++kkQJPsWIm8nfALtxchLiYnyZsV9V3vlMC+Q==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw36gKfwmm+B6et6VqVyAd7XRTDAqiKSVPfKHCcjZWiNJBZ3W2H
	kgLSo/tA6N/UtSlAoOXSKVH+UTQPZYWb7IqEocPwOnfjvI4KKP08tRVUstjVLWtN0f5Iqg/QsHW
	zm0oLi7U2u0DWj1EQtJzwXQCFOCdsoQdNf36mtKgZCEJ1JAWjpacSX2CV3DiN0zzQhJHs
X-Gm-Gg: ATEYQzx0UvXsjDdNwpPehu/4zAHPrECcF8UjlY4/5Rt4r3b1l8MjMppGA9bXJ7v+kLp
	rsMKwt0ycgjjKGv2CdW70YKHYchBf5IsNWLpMsvlXXGwHosTrYl6ng+hZuhzl0Gqdu5bPqjY9hr
	MW6X22rrueh2vat+fSFSVgdBWeLrOavEY2xXSEaBZp+Kn62fYFtqQBIOeQjtRFftn7saShL5Ns+
	iSoevSzCKaKO+bNOTPtH5NJ3uRJ0WrJV9ZhY6FA72hqxhlD9K8jcFgaZ8hfQajX6U44E4TfzZRY
	E5p2i8Fj9tKqWGTZDKeyQTiKs6kIQx3B92vUoZY+KiRlOf+mozzmtoqbUqLA/jKzDIjnTJDm8yj
	/qzDmeV+VDMMP+VuI
X-Received: by 2002:a05:600c:5296:b0:486:ffa3:593 with SMTP id 5b1f17b1804b1-4871606730amr1910515e9.28.1774365358073;
        Tue, 24 Mar 2026 08:15:58 -0700 (PDT)
X-Received: by 2002:a05:600c:5296:b0:486:ffa3:593 with SMTP id 5b1f17b1804b1-4871606730amr1909895e9.28.1774365357596;
        Tue, 24 Mar 2026 08:15:57 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1525:da00:3ac2:1a22:72ff:4256])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-487116d82f1sm55500765e9.11.2026.03.24.08.15.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 08:15:57 -0700 (PDT)
Date: Tue, 24 Mar 2026 11:15:54 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Omar Elghoul <oelghoul@linux.ibm.com>,
	Srikanth Aithal <sraithal@amd.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Vishwanath Seshagiri <vishs@meta.com>, netdev@vger.kernel.org,
	virtualization@lists.linux.dev, bpf@vger.kernel.org
Subject: [PATCH net-next] virtio_net: sync RX buffer before reading the header
Message-ID: <f4caa9be9e5addae7851c012cab0a733be7f0974.1774365273.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: fdJb-G23OeZTp5LbkwrmeujXypODY1h3UK6Ysw5Bf-w_1774365358
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

receive_buf() reads the virtio header through buf before
page_pool_dma_sync_for_cpu() runs in receive_small() or
receive_mergeable(). The header buffer is thus unsynchronized at the
point where flags and, for mergeable buffers, num_buffers are consumed.

Omar Elghoul reported that on s390x Secure Execution this showed up as
greatly reduced virtio-net performance together with "bad gso" and
"bad csum" messages in dmesg. This is because with SE sync actually
copies data, so the header is uninitialized.

Move the sync into receive_buf() so the
header is synchronized before any access through buf.

Tool use: Cursor with GPT-5.4 drafted the initial code move from prompt:
"in drivers/net/virtio_net.c, move page_pool_dma_sync_for_cpu on receive
path to before memory is accessed through buf".
The result and the commit log were reviewed and edited manually.

Fixes: 168b61da6871 ("virtio_net: add page_pool support for buffer allocation")
Reported-by: Omar Elghoul <oelghoul@linux.ibm.com>
Tested-by: Srikanth Aithal <sraithal@amd.com>
Tested-by: Omar Elghoul <oelghoul@linux.ibm.com>
Link: https://lore.kernel.org/r/20260323150136.14452-1-oelghoul@linux.ibm.com
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/net/virtio_net.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 97035b49bae7..2f57245c682d 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -1956,13 +1956,6 @@ static struct sk_buff *receive_small(struct net_device *dev,
 	 */
 	buf -= VIRTNET_RX_PAD + xdp_headroom;
 
-	if (rq->use_page_pool_dma) {
-		int offset = buf - page_address(page) +
-			     VIRTNET_RX_PAD + xdp_headroom;
-
-		page_pool_dma_sync_for_cpu(rq->page_pool, page, offset, len);
-	}
-
 	len -= vi->hdr_len;
 	u64_stats_add(&stats->bytes, len);
 
@@ -2398,9 +2391,6 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
 
 	head_skb = NULL;
 
-	if (rq->use_page_pool_dma)
-		page_pool_dma_sync_for_cpu(rq->page_pool, page, offset, len);
-
 	u64_stats_add(&stats->bytes, len - vi->hdr_len);
 
 	if (check_mergeable_len(dev, ctx, len))
@@ -2563,6 +2553,16 @@ static void receive_buf(struct virtnet_info *vi, struct receive_queue *rq,
 		return;
 	}
 
+	/* Sync the memory before touching anything through buf,
+	 * unless virtio core did it already.
+	 */
+	if (rq->use_page_pool_dma) {
+		struct page *page = virt_to_head_page(buf);
+		int offset = buf - page_address(page);
+
+		page_pool_dma_sync_for_cpu(rq->page_pool, page, offset, len);
+	}
+
 	/* About the flags below:
 	 * 1. Save the flags early, as the XDP program might overwrite them.
 	 * These flags ensure packets marked as VIRTIO_NET_HDR_F_DATA_VALID
-- 
MST

