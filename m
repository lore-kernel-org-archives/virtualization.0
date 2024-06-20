Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DFF24D8B6
	for <virtualization@lists.linux.dev>; Thu, 20 Jun 2024 07:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718869503; cv=none; b=Yedpm5OmMknPbSed3BUu0bnOHILY1mnr6PTMMYXg2bFGqwLXcIydmC7POHvGbjo+RYKT0MSwH7zXLBT7EmVp3BzXlMLmeyF+AOc5Jp6Sx83RHSiCjPUXNIfXCbNpR1fDRjBettRBSBJ97Wl3AdnUeoCj1O93rMxcOHU2UDC9U3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718869503; c=relaxed/simple;
	bh=jriSfG3yE8FF/6EIGZsE4m9KeLD7WIHU7POZs2Y87aM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Xl0DhZ+8NjdQB/h4Dno82PrY8U/FqMFiQLUHqq20ffjmaFyHyvPQThLWvfxONQq5Pj7nUsbMHV1T366a81y0eK2hs2J3d4YMIil/B5H9cRW3/SkBMzY5FZH6xeHKgiyQuuOXgSn5+E+f0tIWjtzYWwVbSs9AuyRMc7WXfP/WFKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=azluMy3i; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="azluMy3i"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718869501;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=FLGfD3eNgl/6ZqS6Hg5LlUxNxxeA+GusPPmU/ACDKiU=;
	b=azluMy3ibVS44ghDQrrEvRlKvKrikLzf/M6soZZb/pxettcmioxqEMFNXnCfxeAdgM9/ZK
	UktWIMAWGUD/WClsGwTbgMiNxly9eab10ILbmDIBzoFq9dHgwz+g5jM1WTpdfGkh8jcaI5
	Cq+/ibL3tuJyBWT1tSZAC+FMJZ3U5UU=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634-574cLhxhPaG1oNRyLKlNDA-1; Thu, 20 Jun 2024 03:44:59 -0400
X-MC-Unique: 574cLhxhPaG1oNRyLKlNDA-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a6f4a6537f7so19980866b.3
        for <virtualization@lists.linux.dev>; Thu, 20 Jun 2024 00:44:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718869498; x=1719474298;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FLGfD3eNgl/6ZqS6Hg5LlUxNxxeA+GusPPmU/ACDKiU=;
        b=iAu7iFO6JjSbd3tTDWx+sKrL9U+V1oeFzXTvbpA559zbXfgYTyCBdDWKeOiPpWiJg3
         X8e9PUbpqIGlPpokZ9W9X3FcZtF4j5RQ00yrec+iqocY4cd4NyCVqvtzMksKTwO23c8z
         M30xOilXMX1XldsMR3+frIVafhmjEG7swq1xxjBFK4oZosRXY4W9QHMGU9MoeeoqooqU
         CWVVPTH1qDfZiXWb5Pg5RSLBsnsvKyCkiz32BQ7X8Bi1ZV7NMR4Y4Q66+Ib1zQW7AVlR
         D0uIJAuITg1kM/eL70emlrSX+P3nSk99nZ95K8yMt6/f/krdUm4k3e6w5UHZ6Bq563w5
         8ARA==
X-Forwarded-Encrypted: i=1; AJvYcCVN0ZaG+u6vFZPR33CQCbAYPzS7QlCIMjIWndFYyqoz7MzHkBkCDeh6x8CAYUqo6J8rIIFKShWCvFADXo/yLTMp9IvS/XGIevgb5gjDHDQ=
X-Gm-Message-State: AOJu0Yzh/ZidG6ZRzTS+nqXlwrtOJgvo0VZr1HAIlu5RgwKdaPSYfc3I
	NfO+DVZbfWdMsCOXrHEhyqL+rk4DaS6/laX1vahuTmSmys1OL4b9zFh/CuqA+6SZHdOA50WmumE
	NymwQBvwhGHTt/ElC42SIlL/pCFyUBXWzOiRnC6Zp2daqEdv6xolT5cGo+HcfwM6J
X-Received: by 2002:a17:906:3944:b0:a6f:4a42:1976 with SMTP id a640c23a62f3a-a6fab648b2amr244125766b.37.1718869498247;
        Thu, 20 Jun 2024 00:44:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG7rXUumkKpuJQU4WxiFQxdfftMFik/0/wxkymNN3g+4BHNw8Xis8UnHK3Oq+VbGL1wV+yXGQ==
X-Received: by 2002:a17:906:3944:b0:a6f:4a42:1976 with SMTP id a640c23a62f3a-a6fab648b2amr244123466b.37.1718869497562;
        Thu, 20 Jun 2024 00:44:57 -0700 (PDT)
Received: from redhat.com ([2.52.146.100])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f9b3feb7esm181368366b.172.2024.06.20.00.44.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 00:44:56 -0700 (PDT)
Date: Thu, 20 Jun 2024 03:44:53 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	Jiri Pirko <jiri@resnulli.us>
Subject: [PATCH net-next] net: virtio: unify code to init stats
Message-ID: <fb91a4ec2224c36adda854314940304d708d59ef.1718869408.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Moving initialization of stats structure into
__free_old_xmit reduces the code size slightly.
It also makes it clearer that this function shouldn't
be called multiple times on the same stats struct.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---

Especially important now that Jiri's patch for BQL has been merged.
Lightly tested.

 drivers/net/virtio_net.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 283b34d50296..c2ce8de340f7 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -383,6 +383,8 @@ static void __free_old_xmit(struct send_queue *sq, bool in_napi,
 	unsigned int len;
 	void *ptr;
 
+	stats->bytes = stats->packets = 0;
+
 	while ((ptr = virtqueue_get_buf(sq->vq, &len)) != NULL) {
 		++stats->packets;
 
@@ -828,7 +830,7 @@ static void virtnet_rq_unmap_free_buf(struct virtqueue *vq, void *buf)
 
 static void free_old_xmit(struct send_queue *sq, bool in_napi)
 {
-	struct virtnet_sq_free_stats stats = {0};
+	struct virtnet_sq_free_stats stats;
 
 	__free_old_xmit(sq, in_napi, &stats);
 
@@ -979,7 +981,7 @@ static int virtnet_xdp_xmit(struct net_device *dev,
 			    int n, struct xdp_frame **frames, u32 flags)
 {
 	struct virtnet_info *vi = netdev_priv(dev);
-	struct virtnet_sq_free_stats stats = {0};
+	struct virtnet_sq_free_stats stats;
 	struct receive_queue *rq = vi->rq;
 	struct bpf_prog *xdp_prog;
 	struct send_queue *sq;
-- 
MST

