Return-Path: <SRS0=epgR=M5=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D4E8C4338F
	for <virtualization@archiver.kernel.org>; Fri,  6 Aug 2021 07:29:00 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8A45611CC
	for <virtualization@archiver.kernel.org>; Fri,  6 Aug 2021 07:28:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E8A45611CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id A797D40260;
	Fri,  6 Aug 2021 07:28:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rn9yXAzQutaz; Fri,  6 Aug 2021 07:28:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id D95AF400C9;
	Fri,  6 Aug 2021 07:28:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AD8ACC001A;
	Fri,  6 Aug 2021 07:28:57 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B1EE8C000E
 for <virtualization@lists.linux-foundation.org>;
 Fri,  6 Aug 2021 07:28:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A069240455
 for <virtualization@lists.linux-foundation.org>;
 Fri,  6 Aug 2021 07:28:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JfLVA7Avdk66
 for <virtualization@lists.linux-foundation.org>;
 Fri,  6 Aug 2021 07:28:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E3B0E40453
 for <virtualization@lists.linux-foundation.org>;
 Fri,  6 Aug 2021 07:28:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1628234934;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YI2lpjNjLO4bbJ7dq0evOTMBQAQSvAtnohvXHPYKA6U=;
 b=Pi65d7bLQW4iZhslq9LdcUVYHkvCNIo9uMv61fSFFrchNPKsiFy0zAFoJbaD1BhT4AkD8c
 chmqzMdphc8bTNZTqEVcNijtFACFINRB+yvD93rtm96k8s98GpUrgFMHu8Lx5VewdcSs9F
 cbpdVW9B6AJWajkb1IZ4wFp28e4wFlA=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-45-Z76Qcw3GPBizipK4dITFsg-1; Fri, 06 Aug 2021 03:28:53 -0400
X-MC-Unique: Z76Qcw3GPBizipK4dITFsg-1
Received: by mail-ed1-f72.google.com with SMTP id
 a23-20020a50ff170000b02903b85a16b672so4472902edu.1
 for <virtualization@lists.linux-foundation.org>;
 Fri, 06 Aug 2021 00:28:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=YI2lpjNjLO4bbJ7dq0evOTMBQAQSvAtnohvXHPYKA6U=;
 b=Pcp1iawytGm5KtSitBoqxezv0M6ssyxFksjKlgZlEmZK2ylnFckD0D5kCH1q2L4LHl
 pu64zaVXVk/PmYCOD8qqFpktvJOlvzwnJFoFCN+LzUgMRkkxwynMQa8E24sEsabELIEz
 O7B01sMvZGwtiE31ie3LMCcmlGwBixB1AIBWr4MSA7hVKeGL0VC/7W70v2D87V0Ld4b7
 i3dABKvyy4OHEMOtvKZdVikp8QmI/CnIefyTd7e4Bv6PUAZHIUIiEKgn6abnLqxn0cdE
 0SV+bTfnmqoCoI+yel+jLeRLpXBC4pPiF/ZyPhmfakxgv8o8+xifOz7URC0+n5BPLfAY
 lQcA==
X-Gm-Message-State: AOAM532GgCFS4uqBrzeE32sTES3wzUVnHs2rd8MowWHNuxeh8F8Ox8KR
 8ecPp0Pdzmi+ucF/eX6kQS6x5jmsCGbCqYaOzlqlhaH2I6vTS4P44LfgkJKhZH4OaFdd17PACgv
 GsOTi6pBpmIeZ/W5KaB7gA7TgmCyMOMjVZQ6jxzuDyg==
X-Received: by 2002:aa7:c794:: with SMTP id n20mr546487eds.244.1628234932576; 
 Fri, 06 Aug 2021 00:28:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyKisyk358bceGT2heyJE0PRcG1aZN0zSV/ZG+Jy0+uAynRlV6ioYSXV4qTARzSycSTWVsKSA==
X-Received: by 2002:aa7:c794:: with SMTP id n20mr546475eds.244.1628234932453; 
 Fri, 06 Aug 2021 00:28:52 -0700 (PDT)
Received: from steredhat (host-79-18-148-79.retail.telecomitalia.it.
 [79.18.148.79])
 by smtp.gmail.com with ESMTPSA id i16sm3423692edr.38.2021.08.06.00.28.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Aug 2021 00:28:52 -0700 (PDT)
Date: Fri, 6 Aug 2021 09:28:49 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseny Krasnov <arseny.krasnov@kaspersky.com>
Subject: Re: [RFC PATCH v1 3/7] vhost/vsock: support MSG_EOR bit processing
Message-ID: <20210806072849.4by3wbdkg2bsierm@steredhat>
References: <20210726163137.2589102-1-arseny.krasnov@kaspersky.com>
 <20210726163341.2589759-1-arseny.krasnov@kaspersky.com>
MIME-Version: 1.0
In-Reply-To: <20210726163341.2589759-1-arseny.krasnov@kaspersky.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Andra Paraschiv <andraprs@amazon.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org,
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

On Mon, Jul 26, 2021 at 07:33:38PM +0300, Arseny Krasnov wrote:
>It works in the same way as 'end-of-message' bit: if packet has
>'EOM' bit, also check for 'EOR' bit.
>
>Signed-off-by: Arseny Krasnov <arseny.krasnov@kaspersky.com>
>---
> drivers/vhost/vsock.c | 12 +++++++++++-
> 1 file changed, 11 insertions(+), 1 deletion(-)
>
>diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
>index 3b55de70ac77..3e2b150f9c6f 100644
>--- a/drivers/vhost/vsock.c
>+++ b/drivers/vhost/vsock.c
>@@ -115,6 +115,7 @@ vhost_transport_do_send_pkt(struct vhost_vsock *vsock,
> 		size_t iov_len, payload_len;
> 		int head;
> 		bool restore_msg_eom_flag = false;
>+		bool restore_msg_eor_flag = false;

Since we now have 2 flags to potentially restore, we could use a single
variable (e.g. uint32_t flags_to_restore), initialized to 0.

We can set all the flags we need to restore and then simply put it
in or with the `pkt->hdr.flags` field.

> 		spin_lock_bh(&vsock->send_pkt_list_lock);
> 		if (list_empty(&vsock->send_pkt_list)) {
>@@ -188,6 +189,11 @@ vhost_transport_do_send_pkt(struct vhost_vsock *vsock,
> 			if (le32_to_cpu(pkt->hdr.flags) & VIRTIO_VSOCK_SEQ_EOM) {
> 				pkt->hdr.flags &= ~cpu_to_le32(VIRTIO_VSOCK_SEQ_EOM);
> 				restore_msg_eom_flag = true;
>+
>+				if (le32_to_cpu(pkt->hdr.flags & VIRTIO_VSOCK_SEQ_EOR)) {
                                                                ^
Here it should be `le32_to_cpu(pkt->hdr.flags) & VIRTIO_VSOCK_SEQ_EOR`

>+					pkt->hdr.flags &= ~cpu_to_le32(VIRTIO_VSOCK_SEQ_EOR);
>+					restore_msg_eor_flag = true;
>+				}
> 			}
> 		}
>
>@@ -224,9 +230,13 @@ vhost_transport_do_send_pkt(struct vhost_vsock *vsock,
> 		 * to send it with the next available buffer.
> 		 */
> 		if (pkt->off < pkt->len) {
>-			if (restore_msg_eom_flag)
>+			if (restore_msg_eom_flag) {
> 				pkt->hdr.flags |= cpu_to_le32(VIRTIO_VSOCK_SEQ_EOM);
>
>+				if (restore_msg_eor_flag)
>+					pkt->hdr.flags |= cpu_to_le32(VIRTIO_VSOCK_SEQ_EOR);
>+			}
>+

If we use a single variable, here we can simply do:

			pkt->hdr.flags |= cpu_to_le32(flags_to_restore);

Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
