Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F343248F68
	for <virtualization@lists.linux.dev>; Mon, 15 Sep 2025 16:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757952213; cv=none; b=eeEeXQzF1bHw6+c7gdLBzaZWjRx3VWoc7HmczpXzlMC7MDGYddlzZaAuW9A0V5Pi5ZnpMePrNNzjhiB7mqEANLfEKGYyq0cwwsJMSd28d66VsW+7IBZzHdjc0OVhJYhTwvzRZpU4Zjz9zxGIfXwii6k87EKIZraHkzb7qnjN/rY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757952213; c=relaxed/simple;
	bh=Td5X+XiMVh4U7xnk374qdTWdLYQJomqL2LvZMLkRmGs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=UuVmFpThtopwyPbUQEjXF3TACKFJW1lzvY4Pc2uCqq3rnEI4XwryvWXHtavnt6UDtnyzyzQ+qA4AK4MC+gxU8WkvIJ291eh9Ha3EwpE8kZs7pCc8MAv2+qEE0KE/9hSpeZBTXcuTmQfre3ibPZAVgsUtfNtwdT7iDCa1JVqEzU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MlZlogdL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MlZlogdL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757952210;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SwVQfN4OpfJrsdY2VoqmkkTVqEBYDZduzuqg8McG+qs=;
	b=MlZlogdLnDsle4QwgopMYv7FZVTy1FMme9RoxJsSeyQdLXXlIyE2bZ8odej87BIhUheKH+
	KNUIiBXhI31Oy0PvUfHwbuKuFrhQF7WevgcmDIhXVo1HxtQgbHxV630v5AFQSHPFSNS56+
	ZmjJsILTrRjBJfK/1yzdgS4vB60b+Ho=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-681-s0gnygZ_PHCNqeZEYIK-Og-1; Mon, 15 Sep 2025 12:03:29 -0400
X-MC-Unique: s0gnygZ_PHCNqeZEYIK-Og-1
X-Mimecast-MFC-AGG-ID: s0gnygZ_PHCNqeZEYIK-Og_1757952208
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-b04271cfc88so328556966b.1
        for <virtualization@lists.linux.dev>; Mon, 15 Sep 2025 09:03:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757952208; x=1758557008;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SwVQfN4OpfJrsdY2VoqmkkTVqEBYDZduzuqg8McG+qs=;
        b=A3IbM/GDoPNuHFE1KtDnXDfm2yQMlgiOhRhlysRorIeCVFcPXVsvXyoGZCcsXSRBek
         uGyW2ecSxTNcimLivNx1RIt7Moxek4CpOyC0apydLME4c53lMp88dyi19VzkvprzGn7y
         wNDObhqW8UTMH0jorgx86xv02w50D4cJ2I9KkXEOyDyEdREdGuHCd3k0ch7+APBCdLCf
         dfFBQIOT1EPTcfWkPpXvL163jn2TqOFd13GHza7OGePcjWskis7hiuY8OXciQ3mR2lpS
         YTHtnhpRNpt9+AvfVDaye+vn4OMB0WYfdhWRKJukSS59Ts+eECoDxf4jZmtB+A7pKpAg
         hM6w==
X-Forwarded-Encrypted: i=1; AJvYcCWN9K19GU4JIA/dlY4wiJyM7PRY3EtHl+kS3kiAUr8J+hqYmcqD02pYtMp0iv5Dl6RFNbJLd3KKGO/j3yabPQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy8mjKmmSjezb6n42Jjg4pa913qbbbNrWm1ZDNBMv5cCDBH4cbb
	fVtdDFzcKHlU+DOqyEVskaffBSU7R3gOdsacCdpSzVS1q5JqcsSRSYzmIK63rKTQIijb+kPAGsY
	AL8plYEUzq6AGp7NdV/yNVTdk8XLN0U7mWpjSc86/dQWEFtS2uwJrmSKWi++PU0N5GksX
X-Gm-Gg: ASbGnct/6RAPlmOGALVyyQy63cSX/DIx/w5XfucfwdZoJq+fJf6p2pcluBP1mK4NHUB
	ieYyaeSbRni1c5RLJniKibnh4iXffeNe2ZNErkn2M6smrHe2pyHzOqwuTzP5x7TxA3LW14O65Og
	H+1YNRYZZOOW7EH+aerIpbzpUjq+OJ7zth90ISrisQL8aLybVxRkYGZwGPPSH4Mpoz5mky76dVT
	gOBtbIrfhsI9uPWFg/Rp+CNeBShAPgkNoXyATNjQeeHxSQv2s9fLQpWtg0DGR1tdQAzL+2Ltype
	a5M1LLsmdeHgJi3w9SfqBAqkgcPu
X-Received: by 2002:a17:907:2d91:b0:b04:2252:7cb1 with SMTP id a640c23a62f3a-b07c353f091mr1403697266b.12.1757952207950;
        Mon, 15 Sep 2025 09:03:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHflQiZxxzDRLnw+SKuDwn0eon4gL/iAAz/hcWcH2BNBputbB1OvgE3pkj1W+m1ugIR7po3zQ==
X-Received: by 2002:a17:907:2d91:b0:b04:2252:7cb1 with SMTP id a640c23a62f3a-b07c353f091mr1403693066b.12.1757952207517;
        Mon, 15 Sep 2025 09:03:27 -0700 (PDT)
Received: from redhat.com ([31.187.78.47])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07b32f20dcsm963017266b.90.2025.09.15.09.03.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 09:03:27 -0700 (PDT)
Date: Mon, 15 Sep 2025 12:03:25 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Jon Kohler <jon@nutanix.com>, netdev@vger.kernel.org,
	stable@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>, kvm@vger.kernel.org,
	virtualization@lists.linux.dev
Subject: [PATCH v3 2/3] Revert "vhost/net: Defer TX queue re-enable until
 after sendmsg"
Message-ID: <45c47a7a1c4790275763b2147c220923b9e59aba.1757952021.git.mst@redhat.com>
References: <b93d3101a6c78f17a19bb0f883d72b30f66d1b54.1757952021.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <b93d3101a6c78f17a19bb0f883d72b30f66d1b54.1757952021.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Oujje87EWo27lKp5UcaUQTNGXE-r_sozW6Z_w8sYkfw_1757952208
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Commit 8c2e6b26ffe2 ("vhost/net: Defer TX queue re-enable until after
sendmsg") tries to defer the notification enabling by moving the logic
out of the loop after the vhost_tx_batch() when nothing new is
spotted. This will bring side effects as the new logic would be reused
for several other error conditions.

One example is the IOTLB: when there's an IOTLB miss, get_tx_bufs()
might return -EAGAIN and exit the loop and see there's still available
buffers, so it will queue the tx work again until userspace feed the
IOTLB entry correctly. This will slowdown the tx processing and
trigger the TX watchdog in the guest as reported in
https://lkml.org/lkml/2025/9/10/1596.

To fix, revert the change. A follow up patch will being the performance
back in a safe way.

Link: https://lkml.org/lkml/2025/9/10/1596.
Reported-by: Jon Kohler <jon@nutanix.com>
Cc: stable@vger.kernel.org
Fixes: 8c2e6b26ffe2 ("vhost/net: Defer TX queue re-enable until after sendmsg")
Signed-off-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/vhost/net.c | 30 +++++++++---------------------
 1 file changed, 9 insertions(+), 21 deletions(-)

diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index 16e39f3ab956..57efd5c55f89 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -765,11 +765,11 @@ static void handle_tx_copy(struct vhost_net *net, struct socket *sock)
 	int err;
 	int sent_pkts = 0;
 	bool sock_can_batch = (sock->sk->sk_sndbuf == INT_MAX);
-	bool busyloop_intr;
 	bool in_order = vhost_has_feature(vq, VIRTIO_F_IN_ORDER);
 
 	do {
-		busyloop_intr = false;
+		bool busyloop_intr = false;
+
 		if (nvq->done_idx == VHOST_NET_BATCH)
 			vhost_tx_batch(net, nvq, sock, &msg);
 
@@ -780,10 +780,13 @@ static void handle_tx_copy(struct vhost_net *net, struct socket *sock)
 			break;
 		/* Nothing new?  Wait for eventfd to tell us they refilled. */
 		if (head == vq->num) {
-			/* Kicks are disabled at this point, break loop and
-			 * process any remaining batched packets. Queue will
-			 * be re-enabled afterwards.
-			 */
+			if (unlikely(busyloop_intr)) {
+				vhost_poll_queue(&vq->poll);
+			} else if (unlikely(vhost_enable_notify(&net->dev,
+								vq))) {
+				vhost_disable_notify(&net->dev, vq);
+				continue;
+			}
 			break;
 		}
 
@@ -839,22 +842,7 @@ static void handle_tx_copy(struct vhost_net *net, struct socket *sock)
 		++nvq->done_idx;
 	} while (likely(!vhost_exceeds_weight(vq, ++sent_pkts, total_len)));
 
-	/* Kicks are still disabled, dispatch any remaining batched msgs. */
 	vhost_tx_batch(net, nvq, sock, &msg);
-
-	if (unlikely(busyloop_intr))
-		/* If interrupted while doing busy polling, requeue the
-		 * handler to be fair handle_rx as well as other tasks
-		 * waiting on cpu.
-		 */
-		vhost_poll_queue(&vq->poll);
-	else
-		/* All of our work has been completed; however, before
-		 * leaving the TX handler, do one last check for work,
-		 * and requeue handler if necessary. If there is no work,
-		 * queue will be reenabled.
-		 */
-		vhost_net_busy_poll_try_queue(net, vq);
 }
 
 static void handle_tx_zerocopy(struct vhost_net *net, struct socket *sock)
-- 
MST

