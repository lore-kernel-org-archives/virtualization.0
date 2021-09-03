Return-Path: <SRS0=H6i0=NZ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A45CFC433F5
	for <virtualization@archiver.kernel.org>; Fri,  3 Sep 2021 06:55:50 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 462F06102A
	for <virtualization@archiver.kernel.org>; Fri,  3 Sep 2021 06:55:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 462F06102A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 122BE83046;
	Fri,  3 Sep 2021 06:55:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zSOguXfwY-ro; Fri,  3 Sep 2021 06:55:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 8D05983027;
	Fri,  3 Sep 2021 06:55:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4CA40C0010;
	Fri,  3 Sep 2021 06:55:48 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0E0EAC000E
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Sep 2021 06:55:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id EB191425D8
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Sep 2021 06:55:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id u0G01lsI1UAx
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Sep 2021 06:55:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B99B54254B
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Sep 2021 06:55:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1630652144;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EeO/1ruPx/J3HagGwQQq0jPFzGgymZG7mS2oDGjCub4=;
 b=AEC5tqOyojbpH3X8GZVtqdsU1HIfKgKTL+SdhIdqmKQQpW8bOc/WVsYi5OOVTFmUXQMifq
 L4wAJRULZix6bDKBOuNlyLM9v7/xMf6R6xJ7vM0nfZ7RJrVtw5IXr7MdfRqoQ13vFNcatK
 Rl+W8rixVIZpx6Ve3/WN8PQuCI0o/BA=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-557-EY6nSuYtNtqsIP0qX-bk4A-1; Fri, 03 Sep 2021 02:55:43 -0400
X-MC-Unique: EY6nSuYtNtqsIP0qX-bk4A-1
Received: by mail-ed1-f72.google.com with SMTP id
 a23-20020aa7cf17000000b003caffcef4beso2273152edy.5
 for <virtualization@lists.linux-foundation.org>;
 Thu, 02 Sep 2021 23:55:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=EeO/1ruPx/J3HagGwQQq0jPFzGgymZG7mS2oDGjCub4=;
 b=KT00R7HwOvrBp2e1yncB5iDzbJ/jX1g7mlxs7OqX9ZYrEQZgwasNnAdPTe7+sLGlbu
 lJr+JhLf7sScuVtfuYxcsIbPDETyV+yiYOD+07vJJ9GthTCeXNrJlHyrID7b9eLuEySz
 kD+R/08CoPxWWeO+5igivYABd6HMcAb+PgRRxTzs4SkbzrvCtJ6kl1BRI4U7g+dp7K4a
 cf1ivbocOmAOYP2nA80kFTgGsWOAGX7awbCXx75QJm8suWPNQH8sexgQm+moKzZRt6Py
 kCQvcujo7YISxvbYPnAkIKFqE7l+oifRYgWczHNQaLW8+EFN+sIxTD/lL2Mc4qBuDM1E
 pC2g==
X-Gm-Message-State: AOAM533143rXcVkAIVZSFryIAeslwx6XUrjb9FBBUEbzy+kQRa8luG3I
 tVbslWYUS97M2VLwCBE2gh549zrj2HuclO2UmZl0TdrQRv6dbwnRUoYYN9I65cxf8j3YpRRo/IV
 ZCZA33iHRajZmC78eFCW/3sKwkqUlfMEv16+hZ81TDg==
X-Received: by 2002:a05:6402:2909:: with SMTP id
 ee9mr2379473edb.377.1630652142359; 
 Thu, 02 Sep 2021 23:55:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzqmSk8HBLIJKh7TPV1i1K1+xzAXzo7Ae30A7P6UZPUjSR75Ct+E874fXO8233Bd4c/cP2SjA==
X-Received: by 2002:a05:6402:2909:: with SMTP id
 ee9mr2379457edb.377.1630652142126; 
 Thu, 02 Sep 2021 23:55:42 -0700 (PDT)
Received: from steredhat (host-79-51-2-59.retail.telecomitalia.it.
 [79.51.2.59])
 by smtp.gmail.com with ESMTPSA id k12sm2391179edq.59.2021.09.02.23.55.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Sep 2021 23:55:41 -0700 (PDT)
Date: Fri, 3 Sep 2021 08:55:39 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseny Krasnov <arseny.krasnov@kaspersky.com>
Subject: Re: [PATCH net-next v4 3/6] vhost/vsock: support MSG_EOR bit
 processing
Message-ID: <20210903065539.nb2hk4sszdtlqfmb@steredhat>
References: <20210903061353.3187150-1-arseny.krasnov@kaspersky.com>
 <20210903061541.3187840-1-arseny.krasnov@kaspersky.com>
MIME-Version: 1.0
In-Reply-To: <20210903061541.3187840-1-arseny.krasnov@kaspersky.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Andra Paraschiv <andraprs@amazon.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org, stsp2@yandex.ru,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 oxffffaa@gmail.com, Norbert Slusarek <nslusarek@gmx.net>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Colin Ian King <colin.king@canonical.com>, Jakub Kicinski <kuba@kernel.org>,
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

On Fri, Sep 03, 2021 at 09:15:38AM +0300, Arseny Krasnov wrote:
>'MSG_EOR' handling has similar logic as 'MSG_EOM' - if bit present
>in packet's header, reset it to 0. Then restore it back if packet
>processing wasn't completed. Instead of bool variable for each
>flag, bit mask variable was added: it has logical OR of 'MSG_EOR'
>and 'MSG_EOM' if needed, to restore flags, this variable is ORed
>with flags field of packet.
>
>Signed-off-by: Arseny Krasnov <arseny.krasnov@kaspersky.com>
>---
> drivers/vhost/vsock.c | 22 +++++++++++++---------
> 1 file changed, 13 insertions(+), 9 deletions(-)
>
>diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
>index feaf650affbe..93e8d635e18f 100644
>--- a/drivers/vhost/vsock.c
>+++ b/drivers/vhost/vsock.c
>@@ -114,7 +114,7 @@ vhost_transport_do_send_pkt(struct vhost_vsock *vsock,
> 		size_t nbytes;
> 		size_t iov_len, payload_len;
> 		int head;
>-		bool restore_flag = false;
>+		u32 flags_to_restore = 0;
>
> 		spin_lock_bh(&vsock->send_pkt_list_lock);
> 		if (list_empty(&vsock->send_pkt_list)) {
>@@ -179,15 +179,20 @@ vhost_transport_do_send_pkt(struct vhost_vsock *vsock,
> 			 * created dynamically and are initialized with header
> 			 * of current packet(except length). But in case of
> 			 * SOCK_SEQPACKET, we also must clear message delimeter
>-			 * bit(VIRTIO_VSOCK_SEQ_EOM). Otherwise, instead of one
>-			 * packet with delimeter(which marks end of message),
>-			 * there will be sequence of packets with delimeter
>-			 * bit set. After initialized header will be copied to
>-			 * rx buffer, this bit will be restored.
>+			 * bit (VIRTIO_VSOCK_SEQ_EOM) and MSG_EOR bit
>+			 * (VIRTIO_VSOCK_SEQ_EOR) if set. Otherwise,
>+			 * there will be sequence of packets with these
>+			 * bits set. After initialized header will be copied to
>+			 * rx buffer, these required bits will be restored.
> 			 */
> 			if (le32_to_cpu(pkt->hdr.flags) & VIRTIO_VSOCK_SEQ_EOM) {
> 				pkt->hdr.flags &= ~cpu_to_le32(VIRTIO_VSOCK_SEQ_EOM);
>-				restore_flag = true;
>+				flags_to_restore |= VIRTIO_VSOCK_SEQ_EOM;
>+
>+				if (le32_to_cpu(pkt->hdr.flags & VIRTIO_VSOCK_SEQ_EOR)) {
>+					pkt->hdr.flags &= ~cpu_to_le32(VIRTIO_VSOCK_SEQ_EOR);
>+					flags_to_restore |= VIRTIO_VSOCK_SEQ_EOR;
>+				}
> 			}
> 		}
>
>@@ -224,8 +229,7 @@ vhost_transport_do_send_pkt(struct vhost_vsock *vsock,
> 		 * to send it with the next available buffer.
> 		 */
> 		if (pkt->off < pkt->len) {
>-			if (restore_flag)
>-				pkt->hdr.flags |= cpu_to_le32(VIRTIO_VSOCK_SEQ_EOM);
>+			pkt->hdr.flags |= cpu_to_le32(flags_to_restore);
>
> 			/* We are queueing the same virtio_vsock_pkt to handle
> 			 * the remaining bytes, and we want to deliver it
>-- 
>2.25.1
>

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
