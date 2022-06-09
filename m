Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13F2DC433EF
	for <virtualization@archiver.kernel.org>; Thu,  9 Jun 2022 08:37:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 9222240BF1;
	Thu,  9 Jun 2022 08:37:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id p2yX0qg-qz2M; Thu,  9 Jun 2022 08:37:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 12BC440BED;
	Thu,  9 Jun 2022 08:37:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E37B7C0039;
	Thu,  9 Jun 2022 08:37:55 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B77DDC002D
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Jun 2022 08:37:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9525C41C44
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Jun 2022 08:37:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7RwOIaNLdJci
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Jun 2022 08:37:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7C01E41C3E
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Jun 2022 08:37:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1654763871;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=694gobC9lwyLqW5J3peoYMEWnd+AT+IRtqYjzog1lRg=;
 b=PcLHF1oftXOyIZ/cRVnIReAJEKI784DkRIbZDe97ZfB8cGcK20kYPpKa6BFAU+QMg5tRxo
 5q/a2H6SZh/JnflcwYBnyTvpTvbl1gUmr0F0UTLNheYXwWEk9YhgEr+fse705Hcm7Oj90Y
 wtRKtgz7+HNy6QSegmkB+5AShLVRYBk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-474-JhBkqtR-P4qJ50-SbwpFcw-1; Thu, 09 Jun 2022 04:37:50 -0400
X-MC-Unique: JhBkqtR-P4qJ50-SbwpFcw-1
Received: by mail-wm1-f69.google.com with SMTP id
 ay28-20020a05600c1e1c00b0039c5cbe76c1so3285447wmb.1
 for <virtualization@lists.linux-foundation.org>;
 Thu, 09 Jun 2022 01:37:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=694gobC9lwyLqW5J3peoYMEWnd+AT+IRtqYjzog1lRg=;
 b=tOKuz2AuU2hwIERt4to1aDFRIDfq6pVUalG6T9zDT31QJCdkQQNQl+SYx2DVsruyAG
 u5hvz9mip95hLmNkkxnBkwHHqBFkKTj7DeWmXvwZNgzUIC4qZiubtF9Wc5+qeBtg+MUe
 sH4e6Csc63XUXsrqRVGKqElEpLvJY0fuuz6jjQ4CqT/df8GJSvU+b+Z0QIlJMcXGjtXI
 RHYj5388QQg8es/5rb3esBQDLAGgt2qB728Wn7bHaL5CAiJ44I8lKMpk946HfaVDKiUM
 o0j9/kDxbfqQwRCOd3NRjyHv7RONrE/uBBddeu4t1lzIWmRb0Inugp45ojqfKJbPMv2Q
 zOMQ==
X-Gm-Message-State: AOAM5303oPSMP1janC/igC4AFXBSoRCvJ8ylj5F8HMoJsHY6Voz3L0Ld
 znVQwWcRVl+Y+2hJQwNTs3FYK0eDFKYmQr0HAVmFDZJUiY5+CV4xgkwTTjcG/kxMQsYMzw8Nq9d
 YWy2JkhaDXseOtxFyklByJg0awWVAr6/TqRqjx6vtLg==
X-Received: by 2002:a5d:4b90:0:b0:210:2b99:3862 with SMTP id
 b16-20020a5d4b90000000b002102b993862mr35493374wrt.586.1654763869333; 
 Thu, 09 Jun 2022 01:37:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzwiqT3Yvpq9pYGfhjPxNPxWZqR6y14eJJY0ZyXFqShFrcIt83mK03m0/3Oo0tgjuYoxDJ5vA==
X-Received: by 2002:a5d:4b90:0:b0:210:2b99:3862 with SMTP id
 b16-20020a5d4b90000000b002102b993862mr35493350wrt.586.1654763869063; 
 Thu, 09 Jun 2022 01:37:49 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-40.retail.telecomitalia.it.
 [79.46.200.40]) by smtp.gmail.com with ESMTPSA id
 h1-20020a5d4fc1000000b0020fc4cd81f6sm23434686wrw.60.2022.06.09.01.37.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jun 2022 01:37:48 -0700 (PDT)
Date: Thu, 9 Jun 2022 10:37:45 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
Subject: Re: [RFC PATCH v2 1/8] virtio/vsock: rework packet allocation logic
Message-ID: <20220609083745.hgqzaq6i7s4u2cgx@sgarzare-redhat>
References: <e37fdf9b-be80-35e1-ae7b-c9dfeae3e3db@sberdevices.ru>
 <78157286-3663-202f-da94-1a17e4ffe819@sberdevices.ru>
MIME-Version: 1.0
In-Reply-To: <78157286-3663-202f-da94-1a17e4ffe819@sberdevices.ru>
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

On Fri, Jun 03, 2022 at 05:31:00AM +0000, Arseniy Krasnov wrote:
>To support zerocopy receive, packet's buffer allocation
>is changed: for buffers which could be mapped to user's
>vma we can't use 'kmalloc()'(as kernel restricts to map
>slab pages to user's vma) and raw buddy allocator now
>called. But, for tx packets(such packets won't be mapped
>to user), previous 'kmalloc()' way is used, but with special
>flag in packet's structure which allows to distinguish
>between 'kmalloc()' and raw pages buffers.
>
>Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>---
> include/linux/virtio_vsock.h            | 1 +
> net/vmw_vsock/virtio_transport.c        | 8 ++++++--
> net/vmw_vsock/virtio_transport_common.c | 9 ++++++++-
> 3 files changed, 15 insertions(+), 3 deletions(-)

Each patch should as much as possible work to not break the 
bisectability, and here we are not touching vhost_vsock_alloc_pkt() that 
uses kmalloc to allocate the buffer.

I see you updated it in the next patch, that should be fine, but here 
you should set slab_buf in vhost_vsock_alloc_pkt(), or you can merge the 
two patches.

>
>diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
>index 35d7eedb5e8e..d02cb7aa922f 100644
>--- a/include/linux/virtio_vsock.h
>+++ b/include/linux/virtio_vsock.h
>@@ -50,6 +50,7 @@ struct virtio_vsock_pkt {
> 	u32 off;
> 	bool reply;
> 	bool tap_delivered;
>+	bool slab_buf;
> };
>
> struct virtio_vsock_pkt_info {
>diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
>index ad64f403536a..19909c1e9ba3 100644
>--- a/net/vmw_vsock/virtio_transport.c
>+++ b/net/vmw_vsock/virtio_transport.c
>@@ -255,16 +255,20 @@ static void virtio_vsock_rx_fill(struct virtio_vsock *vsock)
> 	vq = vsock->vqs[VSOCK_VQ_RX];
>
> 	do {
>+		struct page *buf_page;
>+
> 		pkt = kzalloc(sizeof(*pkt), GFP_KERNEL);
> 		if (!pkt)
> 			break;
>
>-		pkt->buf = kmalloc(buf_len, GFP_KERNEL);
>-		if (!pkt->buf) {
>+		buf_page = alloc_page(GFP_KERNEL);
>+
>+		if (!buf_page) {
> 			virtio_transport_free_pkt(pkt);
> 			break;
> 		}
>
>+		pkt->buf = page_to_virt(buf_page);
> 		pkt->buf_len = buf_len;
> 		pkt->len = buf_len;
>
>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>index ec2c2afbf0d0..278567f748f2 100644
>--- a/net/vmw_vsock/virtio_transport_common.c
>+++ b/net/vmw_vsock/virtio_transport_common.c
>@@ -69,6 +69,7 @@ virtio_transport_alloc_pkt(struct virtio_vsock_pkt_info *info,
> 		if (!pkt->buf)
> 			goto out_pkt;
>
>+		pkt->slab_buf = true;
> 		pkt->buf_len = len;
>
> 		err = memcpy_from_msg(pkt->buf, info->msg, len);
>@@ -1342,7 +1343,13 @@ EXPORT_SYMBOL_GPL(virtio_transport_recv_pkt);
>
> void virtio_transport_free_pkt(struct virtio_vsock_pkt *pkt)
> {
>-	kfree(pkt->buf);
>+	if (pkt->buf_len) {
>+		if (pkt->slab_buf)
>+			kfree(pkt->buf);
>+		else
>+			free_pages(buf, get_order(pkt->buf_len));
>+	}
>+
> 	kfree(pkt);
> }
> EXPORT_SYMBOL_GPL(virtio_transport_free_pkt);
>-- 
>2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
