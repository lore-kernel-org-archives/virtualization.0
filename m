Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34EDEC433EF
	for <virtualization@archiver.kernel.org>; Thu,  9 Jun 2022 08:38:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DB83883EBA;
	Thu,  9 Jun 2022 08:38:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SQSq5o_2pfhp; Thu,  9 Jun 2022 08:38:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 7797482C3B;
	Thu,  9 Jun 2022 08:38:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3A7A1C0039;
	Thu,  9 Jun 2022 08:38:21 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4CA47C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Jun 2022 08:38:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2E25083EBA
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Jun 2022 08:38:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zXEJxpcO6JFg
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Jun 2022 08:38:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 69A4D82C3B
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Jun 2022 08:38:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1654763898;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HgVXSci/QOseQPVoykiPl1OOcwRCzNz17MjAcM9uq8w=;
 b=MVDdO0/XvBuOf5LNQzbevhlryw2thU4FF7YFO6m/UNNt7dlGOydoYOEIGc4McWU0K7evfw
 fpmgPp83nbIR1Zradoyk/FC2RQqRHwzp88vazTQnY0WaHLAaM5RPUyC/CVi2YWTBe/csBb
 bdbuVqafejpIEpY9KZ7ph/p/qeYno+U=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-284-OJwBuk3OOHaAhXwZCNBfag-1; Thu, 09 Jun 2022 04:38:17 -0400
X-MC-Unique: OJwBuk3OOHaAhXwZCNBfag-1
Received: by mail-wm1-f69.google.com with SMTP id
 m19-20020a05600c4f5300b003974eba88c0so11056186wmq.9
 for <virtualization@lists.linux-foundation.org>;
 Thu, 09 Jun 2022 01:38:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=HgVXSci/QOseQPVoykiPl1OOcwRCzNz17MjAcM9uq8w=;
 b=svNoGscP5qhTmphaCEkmJXtyiN/HFB7G0NKeyNrK+b/ZXEHaJrTSpJnEbJHlmeWCFO
 tqGPRT/8/J2o7Td74uIVDcz0IJaep6mfwgExkDMiySg1bPqVsqS07tDWCwYr33XGT+Yj
 nxCtbIkA/Q2LV6ysSBREppstUCD6Ta15Z0JTcXmRF/MHWNmyHIx7ip+an7TW4AQF7mSU
 NbF97EOIYT57pKuYeQu0qpa2PsBKPAUva+ESPyMPwkbxMPBp7GpZkmJEH+5dFl8SzKbv
 LkhI/6aNhZqjt+irSKVCUx3kooSeJV19OU9IFDy+gFKYt8LalrYQK/5Z3AJL8K+lP9C9
 KTkg==
X-Gm-Message-State: AOAM531/zbkijrDHEusYh5SldUWEiOM3Bn90RnavUt0eUDf/Crb5UDw+
 ZrraambaKApEqwte3ykAzx9nwUt5Z7uF7jpWDNy1rZjy2UtnpeM0Q1wWZe+DCa7uapvzOljJ78i
 KWEcbTrjwmuIYX7itOJXZiGdu9g57vdi5yTnst6iLjQ==
X-Received: by 2002:a5d:5046:0:b0:210:20ba:843b with SMTP id
 h6-20020a5d5046000000b0021020ba843bmr36990359wrt.447.1654763896052; 
 Thu, 09 Jun 2022 01:38:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz2I/pxTFn4lag98n3atuyy6yg43sEFm9gDOXjfWj6fo6AxS/nQEcBo9Zu5aQvJUCNQyNASrw==
X-Received: by 2002:a5d:5046:0:b0:210:20ba:843b with SMTP id
 h6-20020a5d5046000000b0021020ba843bmr36990340wrt.447.1654763895841; 
 Thu, 09 Jun 2022 01:38:15 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-40.retail.telecomitalia.it.
 [79.46.200.40]) by smtp.gmail.com with ESMTPSA id
 h7-20020a05600c350700b0039c3b05540fsm25002292wmq.27.2022.06.09.01.38.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jun 2022 01:38:15 -0700 (PDT)
Date: Thu, 9 Jun 2022 10:38:12 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
Subject: Re: [RFC PATCH v2 2/8] vhost/vsock: rework packet allocation logic
Message-ID: <20220609083812.kfsmteh6cm5v3ag2@sgarzare-redhat>
References: <e37fdf9b-be80-35e1-ae7b-c9dfeae3e3db@sberdevices.ru>
 <72ae7f76-ffee-3e64-d445-7a0f4261d891@sberdevices.ru>
MIME-Version: 1.0
In-Reply-To: <72ae7f76-ffee-3e64-d445-7a0f4261d891@sberdevices.ru>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Krasnov Arseniy <oxffffaa@gmail.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, kernel <kernel@sberdevices.ru>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "David S. Miller" <davem@davemloft.net>
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Fri, Jun 03, 2022 at 05:33:04AM +0000, Arseniy Krasnov wrote:
>For packets received from virtio RX queue, use buddy
>allocator instead of 'kmalloc()' to be able to insert
>such pages to user provided vma. Single call to
>'copy_from_iter()' replaced with per-page loop.
>
>Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>---
> drivers/vhost/vsock.c | 81 ++++++++++++++++++++++++++++++++++++-------
> 1 file changed, 69 insertions(+), 12 deletions(-)
>
>diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
>index e6c9d41db1de..0dc2229f18f7 100644
>--- a/drivers/vhost/vsock.c
>+++ b/drivers/vhost/vsock.c
>@@ -58,6 +58,7 @@ struct vhost_vsock {
>
> 	u32 guest_cid;
> 	bool seqpacket_allow;
>+	bool zerocopy_rx_on;

This is per-device, so a single socket can change the behaviour of all 
the sockets of this device.

Can we do something better?

Maybe we can allocate the header, copy it, find the socket and check if 
zero-copy is enabled or not for that socket.

Of course we should change or extend virtio_transport_recv_pkt() to 
avoid to find the socket again.


> };
>
> static u32 vhost_transport_get_local_cid(void)
>@@ -357,6 +358,7 @@ vhost_vsock_alloc_pkt(struct vhost_virtqueue *vq,
> 		      unsigned int out, unsigned int in)
> {
> 	struct virtio_vsock_pkt *pkt;
>+	struct vhost_vsock *vsock;
> 	struct iov_iter iov_iter;
> 	size_t nbytes;
> 	size_t len;
>@@ -393,20 +395,75 @@ vhost_vsock_alloc_pkt(struct vhost_virtqueue *vq,
> 		return NULL;
> 	}
>
>-	pkt->buf = kmalloc(pkt->len, GFP_KERNEL);
>-	if (!pkt->buf) {
>-		kfree(pkt);
>-		return NULL;
>-	}
>-
> 	pkt->buf_len = pkt->len;
>+	vsock = container_of(vq->dev, struct vhost_vsock, dev);
>
>-	nbytes = copy_from_iter(pkt->buf, pkt->len, &iov_iter);
>-	if (nbytes != pkt->len) {
>-		vq_err(vq, "Expected %u byte payload, got %zu bytes\n",
>-		       pkt->len, nbytes);
>-		virtio_transport_free_pkt(pkt);
>-		return NULL;
>+	if (!vsock->zerocopy_rx_on) {
>+		pkt->buf = kmalloc(pkt->len, GFP_KERNEL);
>+
>+		if (!pkt->buf) {
>+			kfree(pkt);
>+			return NULL;
>+		}
>+
>+		pkt->slab_buf = true;
>+		nbytes = copy_from_iter(pkt->buf, pkt->len, &iov_iter);
>+		if (nbytes != pkt->len) {
>+			vq_err(vq, "Expected %u byte payload, got %zu bytes\n",
>+				pkt->len, nbytes);
>+			virtio_transport_free_pkt(pkt);
>+			return NULL;
>+		}
>+	} else {
>+		struct page *buf_page;
>+		ssize_t pkt_len;
>+		int page_idx;
>+
>+		/* This creates memory overrun, as we allocate
>+		 * at least one page for each packet.
>+		 */
>+		buf_page = alloc_pages(GFP_KERNEL, get_order(pkt->len));
>+
>+		if (buf_page == NULL) {
>+			kfree(pkt);
>+			return NULL;
>+		}
>+
>+		pkt->buf = page_to_virt(buf_page);
>+
>+		page_idx = 0;
>+		pkt_len = pkt->len;
>+
>+		/* As allocated pages are not mapped, process
>+		 * pages one by one.
>+		 */
>+		while (pkt_len > 0) {
>+			void *mapped;
>+			size_t to_copy;
>+
>+			mapped = kmap(buf_page + page_idx);
>+
>+			if (mapped == NULL) {
>+				virtio_transport_free_pkt(pkt);
>+				return NULL;
>+			}
>+
>+			to_copy = min(pkt_len, ((ssize_t)PAGE_SIZE));
>+
>+			nbytes = copy_from_iter(mapped, to_copy, &iov_iter);
>+			if (nbytes != to_copy) {
>+				vq_err(vq, "Expected %zu byte payload, got %zu bytes\n",
>+				       to_copy, nbytes);
>+				kunmap(mapped);
>+				virtio_transport_free_pkt(pkt);
>+				return NULL;
>+			}
>+
>+			kunmap(mapped);
>+
>+			pkt_len -= to_copy;
>+			page_idx++;
>+		}
> 	}
>
> 	return pkt;
>-- 
>2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
