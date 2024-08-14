Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95F1013C9CD
	for <virtualization@lists.linux.dev>; Wed, 14 Aug 2024 06:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723618778; cv=none; b=H68s4J9uqvKhOFkkRhUQtepcY0+t8LzLEFNtvHNhfEQskGzUAaIaZplId2HiDUYpemScOWemT1sfDBP9ycsFXCYLfOU6uWGgCWbHEEg6TrdOKpd5y/FWmkfN57v4nbLYRplxeipkpgM1AyFuvYEnHYekTih0TgsFzCBcBeTrvJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723618778; c=relaxed/simple;
	bh=wAxdMfby2D0SF7vG2bXiTceu6vtAkYDeWydXCxbOGjI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=RVArulqNUscqU2msEmsayQo8Mp8Ob/q26Ua1pc8aznYm3iqX77A8PX8mqsr3AoBEnyoJaPpl/sezOkjigcUiz86B1t1DaBrVQvlDxkJUvhkPHCzty+QEu0OOcsKcfuCAI1UTCxNwkavyHd91IiL15Gr+zJLUNoZKuqbTQ4qTj1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EiKQP6Pd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EiKQP6Pd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723618775;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZjtZOVWMEdjuvEgST87XVo9JV/srJgiwPjlW1KSOBo8=;
	b=EiKQP6Pd5y8sAHwUfn6KMJ19KbpqphfYnIuQe17JlSTlYHF8o7BjReU6tyOM609CPizu5o
	7WiHivsl4nwkIOlQQNgLM+KZfuFo1LMBUFunjOQb1QhcM2BY/5Qrzyn9PiGrdzgue/Q7yH
	5Ngdq2eDuGrtBZdBGjl6q8O/vnMy5Bw=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-551-gmm3hkIkPwqKSXoXE8-XWQ-1; Wed, 14 Aug 2024 02:59:33 -0400
X-MC-Unique: gmm3hkIkPwqKSXoXE8-XWQ-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-5a49935bda6so4584040a12.1
        for <virtualization@lists.linux.dev>; Tue, 13 Aug 2024 23:59:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723618772; x=1724223572;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZjtZOVWMEdjuvEgST87XVo9JV/srJgiwPjlW1KSOBo8=;
        b=UNnKbHcOLRiXGWDojufvllYHdmycm3gkiGj1ejv2dIm3q6JwyYMWCoNl18dE3Xuxd/
         +4/vismwFbBTHLl3jkyRoALKHRTNt4NMfq/ugZ1SBJldXTBhehR3SeR+cRE0X+1p+scj
         tYUQDQG6ZTeFwzcdiFEY2OYgTsIUB+Dq9Su/rEl/1Q21JO8yiUg5DE1e4mgd/KQz6mQR
         HmGU7v8nHcs5KtSC9nSxb7wbp3sFn7arK7iK3VHWsQdGrr4zyzx8exxJ3VgFJ8KwHl5g
         tJqufKHFimF6M8AyJZC4nh/hSUZ7WTWMmtUAp6SQJ+YMAG9scWUqz1J8Xy2CK6YRUYJg
         p7YQ==
X-Forwarded-Encrypted: i=1; AJvYcCUkkXPRZngLUwEYDjyZoTlZpu0UkOWGvA035/Oh7/hNOVzyLWJ77H6kj5Ot8vC/PPDyO5Tw3YoCRuvFsuPiuXVBA87hadc1JeJK33kupEE=
X-Gm-Message-State: AOJu0YzSAhis9CZG8Lw+ns0rrkfFQ0301vKLmj2WOWfIsgenYfj9Gdm1
	ApKoPcnIN+wtjhIlS/0tB1mZierKTQz5vdEi5a54xNLzuqadXbX1vLOGpj2eS6dsckYxZnvX23f
	NkpNuVAxmiDY+5G/xOj7/et6FcSw0uFKaP5chtfROhwPis4+lHv39jmzapBtdvLLB
X-Received: by 2002:a05:6402:50d0:b0:5a2:1693:1a2f with SMTP id 4fb4d7f45d1cf-5bea1c73b19mr1085387a12.12.1723618772398;
        Tue, 13 Aug 2024 23:59:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGS5NxWULN01540o+nnvytUndXUAOiwrbEfd3SI9/UCLbqsnAOKNseZbBkApLr7BKpp8webpQ==
X-Received: by 2002:a05:6402:50d0:b0:5a2:1693:1a2f with SMTP id 4fb4d7f45d1cf-5bea1c73b19mr1085366a12.12.1723618771588;
        Tue, 13 Aug 2024 23:59:31 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:346:dcde:9c09:aa95:551d:d374])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bd1a5dfdddsm3576796a12.59.2024.08.13.23.59.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 23:59:30 -0700 (PDT)
Date: Wed, 14 Aug 2024 02:59:26 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Jason Wang <jasowang@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	virtualization@lists.linux.dev,
	Darren Kenny <darren.kenny@oracle.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Si-Wei Liu <si-wei.liu@oracle.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>
Subject: [PATCH RFC 2/3] Revert "virtio_net: big mode skip the unmap check"
Message-ID: <dde48b251db8b192ee026798e1180476b2183537.1723617902.git.mst@redhat.com>
References: <cover.1723617902.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <cover.1723617902.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

This reverts commit a377ae542d8d0a20a3173da3bbba72e045bea7a9.

leads to crashes with no ACCESS_PLATFORM when
sysctl net.core.high_order_alloc_disable=1

Reported-by: Si-Wei Liu <si-wei.liu@oracle.com>
Message-ID: <8b20cc28-45a9-4643-8e87-ba164a540c0a@oracle.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/net/virtio_net.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 4f7e686b8bf9..88a57a3fdeff 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -964,7 +964,7 @@ static void virtnet_rq_unmap_free_buf(struct virtqueue *vq, void *buf)
 
 	rq = &vi->rq[i];
 
-	if (!vi->big_packets || vi->mergeable_rx_bufs)
+	if (rq->do_dma)
 		virtnet_rq_unmap(rq, buf, 0);
 
 	virtnet_rq_free_buf(vi, rq, buf);
@@ -2296,7 +2296,7 @@ static int virtnet_receive(struct receive_queue *rq, int budget,
 		}
 	} else {
 		while (packets < budget &&
-		       (buf = virtqueue_get_buf(rq->vq, &len)) != NULL) {
+		       (buf = virtnet_rq_get_buf(rq, &len, NULL)) != NULL) {
 			receive_buf(vi, rq, buf, len, NULL, xdp_xmit, &stats);
 			packets++;
 		}
-- 
MST

