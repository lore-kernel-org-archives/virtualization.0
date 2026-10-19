Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB2744EB84F
	for <virtualization@lists.linux.dev>; Mon, 19 Oct 2026 12:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792411403; cv=none; b=eWo3wy+B3M8RNOvV4oB26txDSbvd9FMmsB+oU2puraopYPgKIxDsIcH/6BHPrvbmbs8lFBnBLkZwJ16xy6ZLtgJarm0/gi1rFT5vWDb61ZNYPEY82UBQU00PAYMBDJgmFPyRmiI9TGQRPjVc5VHiZlbUMkdwY7ndMTnamov9b0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792411403; c=relaxed/simple;
	bh=IwhLYmjLCPlF0e5s5GUMXm2Cd+FkpD1UwImr2LvvCHU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Hu0anKrvWMcb+Fi+klEo5nhYzCQdcZXY+46ECgw+H4WFWHljDRyOJxnJLaxUBDJ4PaWdLqzA9CJWajTIDwKn+Hm5c1u7j/HDWZ8pcGh+BOkqQdtz8zr6P3hAqHfXYluXpbh0VWvGhvA/eFOnJy+0tssLuOmm2NJod2hBKr8tgpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Wow8XLmp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wow8XLmp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792411400;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/qcGh/+2dqUoiHJpUXvQbolm141eVal40N7yCBeiObo=;
	b=Wow8XLmpYtaYXdjbIFtcAuW5J+NNPGU3GARRQ7nw9SfEYaK3TrWdhWqOqpnckYsu3S4g1q
	nu05wsPaWqz1AvrS8jR8pcTnCI+HVqQULIoRsVhrU2wEKP10aaSHwncuxO+ku00LeFlj7F
	cizLyJ9nT0fMu29LOkloqkUgLq66PmY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-680-YJ_g4vFaNk64bZIJHYPCUg-1; Mon, 19 Oct 2026 12:03:17 +0000
X-MC-Unique: YJ_g4vFaNk64bZIJHYPCUg-1
X-Mimecast-MFC-AGG-ID: YJ_g4vFaNk64bZIJHYPCUg_1792411397
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-48e00f3929bso1544186f8f.0
        for <virtualization@lists.linux.dev>; Mon, 19 Oct 2026 05:03:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792411396; x=1793016196;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/qcGh/+2dqUoiHJpUXvQbolm141eVal40N7yCBeiObo=;
        b=TnRxGkrIQesN1n6y7x+2MHc6fKVasSMKUnd+fx/vcjcZtjzABCjhi9jyXyiC6dZyMp
         cCwQaLd7Qnbh5YhxkIqAq98PFlX0c02dPLXH/msHw9/r+H7Xl5DTG02KoeUbSpU8Hxry
         XSeuHyE+3avp9IQ4PwbBfyLXiVM4jMYX2o87bmrW6jnvzED7kGc0QUuntKP/rb7mQWCx
         qRMCtLcaWeDVvWq3q0H6hK4ZEk2tA5tQ168KNh39izCGh6TCnvpyKxYJRLNa2iLDXHj0
         umhOuZXY2saTrWVqrLoffXcoI8Lq13365OYN83TIhlfceSQudllNdCL9fsUL2TbgUMWt
         46NQ==
X-Forwarded-Encrypted: i=1; AKwUvBxEUrKQBAZufw9Fo7dz7uOLAunTjEo6wdV8GKRKM+5GNzMge/JoCYuS+CByohjSfH1GpGoCBnaLlDnn8akKzw==@lists.linux.dev
X-Gm-Message-State: AFq9FYKS3dXVfLtgG/gKaWflcMI1DNhMdZhLaXKQ5CeV2gUY97VSkukc
	PXf8/o/rScNUgwSgAzksJWZK71izDfwZh1vSmhwTlL/FFgHPxW/xkoLZy4yBuAo6f02kY3FQNhD
	NtqlbPJGiuErVzhGK97GRUWiNPstpvtCN57AwIfSIKlogCTt/R3DC9IaOuH8ZU1nL07fe
X-Gm-Gg: AYBFou3IeqCL9EjXPWjzCH96zm6pvOFgjmeEGqPLdd8nrE14bcwlxPaxn6AvH1mmBUt
	ldALGo6R1CDV75G4/+UTIPEL/i4RHJMENEdWhqmVUm9i59P8XKW19MIWh8HomVvUxExUrU+su6/
	JmUNIEFEt0ZOujmE6VssYNbQ/8iqD99PreKIUQLDwjOX6VSYpC7KSdJiJFvKhX/OtaRFE5GYFfm
	DQdAL/JtqUDMhzu0TdL9ooWLOsoCvoYMO+6gmRu3ScK9iVGAwmDjSPc5UqzYTokz7IFR/TM7FtA
	WVRllfHBAuiVQP8w0O7MWHNTJybpMiJlZ8PH9IbogaaqjdGFLU7UWcc9Wr3hj700v+YzZQ==
X-Received: by 2002:a05:6000:26c1:b0:48b:946:c1f7 with SMTP id ffacd0b85a97d-48dfaea3908mr25611960f8f.31.1792411396002;
        Mon, 19 Oct 2026 05:03:16 -0700 (PDT)
X-Received: by 2002:a05:6000:26c1:b0:48b:946:c1f7 with SMTP id ffacd0b85a97d-48dfaea3908mr25611747f8f.31.1792411394009;
        Mon, 19 Oct 2026 05:03:14 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:3fd7:5300:3d6b:52a4:a23f:9d0b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48dfd4feb6bsm24515964f8f.41.2026.10.19.05.03.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 05:03:13 -0700 (PDT)
Date: Mon, 19 Oct 2026 08:03:10 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Chris Arges <carges@cloudflare.com>,
	=?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
	Phil Sutter <phil@nwl.cc>, Jason Wang <jasowangio@gmail.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, virtualization@lists.linux.dev,
	Max Krasnyansky <maxk@qualcomm.com>,
	Rusty Russell <rusty@rustcorp.com.au>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	linux-um@lists.infradead.org
Subject: [PATCH net v3 3/8] um: vector: trim skbs before verifying the header
Message-ID: <372d22237412a8dee2f848660e76162f05c566cd.1792411304.git.mst@redhat.com>
References: <cover.1792411304.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <cover.1792411304.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 9RQlMA1vN26MZ4UxaF2pS8Gq0B0d-PY2iFKm-uUFqno_1792411397
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The vector receive path over-allocates the skb and only trims it
to the received length after the transport header is verified.

A follow up patch will complete the packet checksum in software within
virtio_net_hdr_to_skb so we need the packet trimmed (otherwise the
checksum would be computed incorrectly over the unreceived tail of the
buffer).

Trim first, so the import sees the packet as it was received.

Assisted-by: LLM
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 arch/um/drivers/vector_kern.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/um/drivers/vector_kern.c b/arch/um/drivers/vector_kern.c
index 8a70b3a62553..1afbef78df72 100644
--- a/arch/um/drivers/vector_kern.c
+++ b/arch/um/drivers/vector_kern.c
@@ -865,6 +865,7 @@ static int vector_legacy_rx(struct vector_private *vp)
 
 	if (skb != NULL) {
 		if (pkt_len > vp->header_size) {
+			pskb_trim(skb, pkt_len - vp->rx_header_size);
 			if (vp->header_size > 0) {
 				header_check = vp->verify_header(
 					vp->header_rxbuffer, skb, vp);
@@ -879,7 +880,6 @@ static int vector_legacy_rx(struct vector_private *vp)
 					skb->ip_summed = CHECKSUM_UNNECESSARY;
 				}
 			}
-			pskb_trim(skb, pkt_len - vp->rx_header_size);
 			skb->protocol = eth_type_trans(skb, skb->dev);
 			vp->dev->stats.rx_bytes += skb->len;
 			vp->dev->stats.rx_packets++;
@@ -981,6 +981,8 @@ static int vector_mmsg_rx(struct vector_private *vp, int budget)
 	for (i = 0; i < packet_count; i++) {
 		skb = (*skbuff_vector);
 		if (mmsg_vector->msg_len > vp->header_size) {
+			pskb_trim(skb,
+				mmsg_vector->msg_len - vp->rx_header_size);
 			if (vp->header_size > 0) {
 				header_check = vp->verify_header(
 					mmsg_vector->msg_hdr.msg_iov->iov_base,
@@ -1005,8 +1007,6 @@ static int vector_mmsg_rx(struct vector_private *vp, int budget)
 					skb->ip_summed = CHECKSUM_UNNECESSARY;
 				}
 			}
-			pskb_trim(skb,
-				mmsg_vector->msg_len - vp->rx_header_size);
 			skb->protocol = eth_type_trans(skb, skb->dev);
 			/*
 			 * We do not need to lock on updating stats here
-- 
MST

