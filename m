Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F37CB17107A
	for <virtualization@lists.linux.dev>; Fri, 12 Jul 2024 13:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720791724; cv=none; b=hR9/gfPa2E529EKjoJyp7oZSpOFGWGirnbwl4nlv+7+p0LjWTTowCwHE09J0QsD6FeO4+ou6lEcnjU/WCqsWcY3NXMBKOUFEQdekDyN8U5/OG4LtMa6fCiCwmhStBi3U3ODq/I0SJ75NkhjM3U3CA9SlZOfxGch7dgSiIxYdsW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720791724; c=relaxed/simple;
	bh=VlSHi9RK0cz8oHSgiEYUsmDxeuGYyWFs8bFgo7jHaYc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=ZkeyJHGnDWVW0Y7GGMzx7LTX9MfTQ4y876AiRvsrhxbkPNb5mIEaJi6lH6df+MXOWQUkPSWSaCVFkgeXpQroR7a+vDkT58wmsJ6wVsStWk34JixqrGXXp7BmcRxHhp4NNxfZkYQdZ2h9ZYJ9uRlDtk8oVZy2TwLP4wEwMqT4vQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I2f1EYCi; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I2f1EYCi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720791722;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Mk+WM1arm/64ZpMrIxPRFx219R8+aXz4jqZ8C+xP4gc=;
	b=I2f1EYCiuS3yEPvFIdGFdRXy3rvo4hCWZWoBXCyygoEGvTKkW2M9UKmHyaK25FfzQWtVZg
	B0lZznOseth4OKlhY99BXFeMT4QV0kkvdcIam5t65yeinXWlb/neyj+53OD4G7PfWDFPah
	GBvBc2EyH0QNGfIRxwg7YKAy31vWfh8=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-49-tHBtb57POoe4d4JefWADCQ-1; Fri, 12 Jul 2024 09:41:58 -0400
X-MC-Unique: tHBtb57POoe4d4JefWADCQ-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-52e9cc6a99eso2134576e87.3
        for <virtualization@lists.linux.dev>; Fri, 12 Jul 2024 06:41:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720791716; x=1721396516;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mk+WM1arm/64ZpMrIxPRFx219R8+aXz4jqZ8C+xP4gc=;
        b=CVGRoRLCT8FK4lKg2SsJX2hBkTtOS/0TrGsDkwBKZte7mN1Ob7rwVVEhe4xiA3xfia
         A1t0P1VvbRZSTkmP9d5Bq1p7KYb3hRP0oX/X6DPTFlpK+0Z+FrWvGoPDT/F7N6ThXh+i
         X5Xy5BAufmIecj2dyrTFratroKjBWM3elXQyNpZhZWob+EYCq9ntF8wrvM4JoKfii03H
         6TqyW9SenQLVxw0e0vE+vXcAXbm2yR9vFjePiUWeGen+GxVhBJ3wPvNr57kHGz3ru9/Q
         YQlOQ7U7ygAfc437VbQTqozVSg5qn+QJPxvXFMkdkFD2SJHACGLGQ0vd0IiuLvkajJ7w
         0lGg==
X-Forwarded-Encrypted: i=1; AJvYcCXPg5wEdGI6/jEmo0dhJY6chOQOyndQN8FRzcH0/csI4kfNKOaJyPfpj5T5rJ+YAGcG+P0OdmSIWoUc0zYUwmpmdBwgrJN3fSLKTs253lQ=
X-Gm-Message-State: AOJu0Yx9fR5qtgJCMOa2KAewkmbGw+PSQdGpiCAQ403WWrpEPoG1eHtN
	7QhT8K+UhpF+Xp2fWLQJWPTsBbr0KuMusJyQmZEn2TlrUWUwQFOqwO0Ocw+nbtXboGFiAz6mDBq
	Wsax8vgGTF0XZv1r+7YE6C4sGJ8h+S0ILbNjZ+wumOig1xsib7Vt8X4UMh7csTNXq
X-Received: by 2002:a05:6512:3a8a:b0:52c:e402:4dc1 with SMTP id 2adb3069b0e04-52eb99cc600mr7617112e87.55.1720791716571;
        Fri, 12 Jul 2024 06:41:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEUaf4mxN3q9ATPhlcpzBYwPRxW6N5KDcX6uHj3/W1daAmMkIG36ncQyE+RQl/Wv+1PaDvSBA==
X-Received: by 2002:a05:6512:3a8a:b0:52c:e402:4dc1 with SMTP id 2adb3069b0e04-52eb99cc600mr7617095e87.55.1720791715892;
        Fri, 12 Jul 2024 06:41:55 -0700 (PDT)
Received: from sgarzare-redhat (host-82-57-51-153.retail.telecomitalia.it. [82.57.51.153])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a780a85431fsm343736466b.153.2024.07.12.06.41.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jul 2024 06:41:55 -0700 (PDT)
Date: Fri, 12 Jul 2024 15:41:51 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: luigi.leonardi@outlook.com
Cc: Stefan Hajnoczi <stefanha@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Marco Pinna <marco.pinn95@gmail.com>
Subject: Re: [PATCH net-next v3 1/2] vsock/virtio: refactor
 virtio_transport_send_pkt_work
Message-ID: <5myg3te4nmgrddh3dvh6t4guvmr4i73uwksyf2g4h4n3gjqk74@mf43vrv5gym2>
References: <20240711-pinna-v3-0-697d4164fe80@outlook.com>
 <20240711-pinna-v3-1-697d4164fe80@outlook.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20240711-pinna-v3-1-697d4164fe80@outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Thu, Jul 11, 2024 at 04:58:46PM GMT, Luigi Leonardi via B4 Relay wrote:
>From: Marco Pinna <marco.pinn95@gmail.com>
>
>Preliminary patch to introduce an optimization to the
>enqueue system.
>
>All the code used to enqueue a packet into the virtqueue
>is removed from virtio_transport_send_pkt_work()
>and moved to the new virtio_transport_send_skb() function.
>
>Co-developed-by: Luigi Leonardi <luigi.leonardi@outlook.com>
>Signed-off-by: Luigi Leonardi <luigi.leonardi@outlook.com>
>Signed-off-by: Marco Pinna <marco.pinn95@gmail.com>
>---
> net/vmw_vsock/virtio_transport.c | 105 ++++++++++++++++++++++-----------------
> 1 file changed, 59 insertions(+), 46 deletions(-)

LGTM

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/net/vmw_vsock/virtio_transport.c 
>b/net/vmw_vsock/virtio_transport.c
>index 43d405298857..c4205c22f40b 100644
>--- a/net/vmw_vsock/virtio_transport.c
>+++ b/net/vmw_vsock/virtio_transport.c
>@@ -94,6 +94,63 @@ static u32 virtio_transport_get_local_cid(void)
> 	return ret;
> }
>
>+/* Caller need to hold vsock->tx_lock on vq */
>+static int virtio_transport_send_skb(struct sk_buff *skb, struct virtqueue *vq,
>+				     struct virtio_vsock *vsock)
>+{
>+	int ret, in_sg = 0, out_sg = 0;
>+	struct scatterlist **sgs;
>+
>+	sgs = vsock->out_sgs;
>+	sg_init_one(sgs[out_sg], virtio_vsock_hdr(skb),
>+		    sizeof(*virtio_vsock_hdr(skb)));
>+	out_sg++;
>+
>+	if (!skb_is_nonlinear(skb)) {
>+		if (skb->len > 0) {
>+			sg_init_one(sgs[out_sg], skb->data, skb->len);
>+			out_sg++;
>+		}
>+	} else {
>+		struct skb_shared_info *si;
>+		int i;
>+
>+		/* If skb is nonlinear, then its buffer must contain
>+		 * only header and nothing more. Data is stored in
>+		 * the fragged part.
>+		 */
>+		WARN_ON_ONCE(skb_headroom(skb) != sizeof(*virtio_vsock_hdr(skb)));
>+
>+		si = skb_shinfo(skb);
>+
>+		for (i = 0; i < si->nr_frags; i++) {
>+			skb_frag_t *skb_frag = &si->frags[i];
>+			void *va;
>+
>+			/* We will use 'page_to_virt()' for the userspace page
>+			 * here, because virtio or dma-mapping layers will call
>+			 * 'virt_to_phys()' later to fill the buffer descriptor.
>+			 * We don't touch memory at "virtual" address of this page.
>+			 */
>+			va = page_to_virt(skb_frag_page(skb_frag));
>+			sg_init_one(sgs[out_sg],
>+				    va + skb_frag_off(skb_frag),
>+				    skb_frag_size(skb_frag));
>+			out_sg++;
>+		}
>+	}
>+
>+	ret = virtqueue_add_sgs(vq, sgs, out_sg, in_sg, skb, GFP_KERNEL);
>+	/* Usually this means that there is no more space available in
>+	 * the vq
>+	 */
>+	if (ret < 0)
>+		return ret;
>+
>+	virtio_transport_deliver_tap_pkt(skb);
>+	return 0;
>+}
>+
> static void
> virtio_transport_send_pkt_work(struct work_struct *work)
> {
>@@ -111,66 +168,22 @@ virtio_transport_send_pkt_work(struct work_struct *work)
> 	vq = vsock->vqs[VSOCK_VQ_TX];
>
> 	for (;;) {
>-		int ret, in_sg = 0, out_sg = 0;
>-		struct scatterlist **sgs;
> 		struct sk_buff *skb;
> 		bool reply;
>+		int ret;
>
> 		skb = virtio_vsock_skb_dequeue(&vsock->send_pkt_queue);
> 		if (!skb)
> 			break;
>
> 		reply = virtio_vsock_skb_reply(skb);
>-		sgs = vsock->out_sgs;
>-		sg_init_one(sgs[out_sg], virtio_vsock_hdr(skb),
>-			    sizeof(*virtio_vsock_hdr(skb)));
>-		out_sg++;
>-
>-		if (!skb_is_nonlinear(skb)) {
>-			if (skb->len > 0) {
>-				sg_init_one(sgs[out_sg], skb->data, skb->len);
>-				out_sg++;
>-			}
>-		} else {
>-			struct skb_shared_info *si;
>-			int i;
>-
>-			/* If skb is nonlinear, then its buffer must contain
>-			 * only header and nothing more. Data is stored in
>-			 * the fragged part.
>-			 */
>-			WARN_ON_ONCE(skb_headroom(skb) != sizeof(*virtio_vsock_hdr(skb)));
>-
>-			si = skb_shinfo(skb);
>
>-			for (i = 0; i < si->nr_frags; i++) {
>-				skb_frag_t *skb_frag = &si->frags[i];
>-				void *va;
>-
>-				/* We will use 'page_to_virt()' for the userspace page
>-				 * here, because virtio or dma-mapping layers will call
>-				 * 'virt_to_phys()' later to fill the buffer descriptor.
>-				 * We don't touch memory at "virtual" address of this page.
>-				 */
>-				va = page_to_virt(skb_frag_page(skb_frag));
>-				sg_init_one(sgs[out_sg],
>-					    va + skb_frag_off(skb_frag),
>-					    skb_frag_size(skb_frag));
>-				out_sg++;
>-			}
>-		}
>-
>-		ret = virtqueue_add_sgs(vq, sgs, out_sg, in_sg, skb, GFP_KERNEL);
>-		/* Usually this means that there is no more space available in
>-		 * the vq
>-		 */
>+		ret = virtio_transport_send_skb(skb, vq, vsock);
> 		if (ret < 0) {
> 			virtio_vsock_skb_queue_head(&vsock->send_pkt_queue, skb);
> 			break;
> 		}
>
>-		virtio_transport_deliver_tap_pkt(skb);
>-
> 		if (reply) {
> 			struct virtqueue *rx_vq = vsock->vqs[VSOCK_VQ_RX];
> 			int val;
>
>-- 
>2.45.2
>
>

