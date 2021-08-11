Return-Path: <SRS0=15I4=NC=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24D68C4338F
	for <virtualization@archiver.kernel.org>; Wed, 11 Aug 2021 09:06:23 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBE3D60F11
	for <virtualization@archiver.kernel.org>; Wed, 11 Aug 2021 09:06:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org CBE3D60F11
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8F70D607CE;
	Wed, 11 Aug 2021 09:06:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YVUwseSmSRKb; Wed, 11 Aug 2021 09:06:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 28BED600B8;
	Wed, 11 Aug 2021 09:06:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 46EABC001A;
	Wed, 11 Aug 2021 09:06:16 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 31313C000E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Aug 2021 09:06:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1ED07402E0
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Aug 2021 09:06:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id d0k1MQC8IW-8
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Aug 2021 09:06:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3CD8C402C4
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Aug 2021 09:06:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1628672773;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nY+KsOIvdmq/I8f8sHJvd3e52ylxx2cGgSYbPUMLTyI=;
 b=dfCHBeibix8mWwilFzqiAj8jYXl6P/PrYH4dQ7fdDrkL4VMPxlVbhUAynIFVi4vGbA/hWX
 sb2+ubHQkwvNOPAKKX8Ug+HprAwgin9Lf2BnbczoLlRaCro96pDbUTlCG9EnFiK4ovFHLt
 /0C7iCImodKKdBZcQS+Pm2kWJMacR9c=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-324-Li4NKtqxO6ajnxaKYslb0g-1; Wed, 11 Aug 2021 05:06:11 -0400
X-MC-Unique: Li4NKtqxO6ajnxaKYslb0g-1
Received: by mail-ej1-f71.google.com with SMTP id
 x5-20020a1709064bc5b02905305454f5d1so422309ejv.10
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Aug 2021 02:06:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=nY+KsOIvdmq/I8f8sHJvd3e52ylxx2cGgSYbPUMLTyI=;
 b=bVQpCcODIQRFXJVDBqxWQ85LETB/0KNz983Yq3hph2Ei0ft3sTdXg6CtTHoSs9SAl3
 2QVkssq0pFrxN2PfO+mR29sPlm8oW6ohUjp+xHc8Ve0XWOTnFhRspb/9a0fbigmc08UW
 5iLCo1N6r1h3nRFszeMsXR/DhzfDzAbHP0beBTP0bXUSYKuwOcW4IhptosGHz+9EZhwi
 UXxEkIbIEhCf8D20uKLyrfiLDJ+JBXKQTBc3I6BTmAQreE3UYbfP2LbVNjjjmOmEPEug
 V2chYzuHBeWXxdU/GDRtbACmqPOVtGKfohYSOEt5hcidFL3f4BOPVxi4gUiPHLdpuH1Q
 pqxw==
X-Gm-Message-State: AOAM532UhhZFgABIMIg9OvN/kePt9GG2ToT5Vyop609z6adj/Dgec+vH
 9vfO/8BDn28ToC9VSPWeXJlZio3mNLcYTfQBETCh1Njp1HINMt7CvkS9A4Izq+lUGFyqpNvkc+j
 F8ny4w8URGGmmjvQHCG4G+LsaSY/0HgrLY7ly0gvvrg==
X-Received: by 2002:a17:906:e57:: with SMTP id
 q23mr2580416eji.483.1628672770530; 
 Wed, 11 Aug 2021 02:06:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJydlQt4cUzS593TJoOXM9aBHzAXiW4JJ0JmGJ2tgg4wf8bTFkdPRDcvQCA3d1fcsJESLEh/Sg==
X-Received: by 2002:a17:906:e57:: with SMTP id
 q23mr2580395eji.483.1628672770414; 
 Wed, 11 Aug 2021 02:06:10 -0700 (PDT)
Received: from steredhat (a-nu5-14.tin.it. [212.216.181.13])
 by smtp.gmail.com with ESMTPSA id m12sm7955692ejd.21.2021.08.11.02.06.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Aug 2021 02:06:10 -0700 (PDT)
Date: Wed, 11 Aug 2021 11:06:07 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseny Krasnov <arseny.krasnov@kaspersky.com>
Subject: Re: [RFC PATCH v2 2/5] vhost/vsock: support MSG_EOR bit processing
Message-ID: <20210811090607.bl3cjsjrsg2ss7dp@steredhat>
References: <20210810113901.1214116-1-arseny.krasnov@kaspersky.com>
 <20210810114018.1214619-1-arseny.krasnov@kaspersky.com>
MIME-Version: 1.0
In-Reply-To: <20210810114018.1214619-1-arseny.krasnov@kaspersky.com>
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
 "David S. Miller" <davem@davemloft.net>, Jorgen Hansen <jhansen@vmware.com>
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

On Tue, Aug 10, 2021 at 02:40:15PM +0300, Arseny Krasnov wrote:
>It works in the same way as 'end-of-message' bit: if packet has
>'EOM' bit, also check for 'EOR' bit.

Please describe all changes, e.g. the new variable to accumulate flags 
to restore.

>
>Signed-off-by: Arseny Krasnov <arseny.krasnov@kaspersky.com>
>---
> drivers/vhost/vsock.c | 12 ++++++++----
> 1 file changed, 8 insertions(+), 4 deletions(-)
>
>diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
>index feaf650affbe..06fc132b13c8 100644
>--- a/drivers/vhost/vsock.c
>+++ b/drivers/vhost/vsock.c
>@@ -114,7 +114,7 @@ vhost_transport_do_send_pkt(struct vhost_vsock *vsock,
> 		size_t nbytes;
> 		size_t iov_len, payload_len;
> 		int head;
>-		bool restore_flag = false;
>+		uint32_t flags_to_restore = 0;
>
> 		spin_lock_bh(&vsock->send_pkt_list_lock);
> 		if (list_empty(&vsock->send_pkt_list)) {
>@@ -187,7 +187,12 @@ vhost_transport_do_send_pkt(struct vhost_vsock *vsock,
> 			 */
> 			if (le32_to_cpu(pkt->hdr.flags) & VIRTIO_VSOCK_SEQ_EOM) {
> 				pkt->hdr.flags &= ~cpu_to_le32(VIRTIO_VSOCK_SEQ_EOM);
>-				restore_flag = true;
>+				flags_to_restore |= le32_to_cpu(VIRTIO_VSOCK_SEQ_EOM);
>+
>+				if (le32_to_cpu(pkt->hdr.flags & VIRTIO_VSOCK_SEQ_EOR)) {
>+					pkt->hdr.flags &= ~cpu_to_le32(VIRTIO_VSOCK_SEQ_EOR);
>+					flags_to_restore |= le32_to_cpu(VIRTIO_VSOCK_SEQ_EOR);
                                                             ^
I'm not sure this is needed, VIRTIO_VSOCK_SEQ_EOR is represented in the 
cpu endianess.

I think here you can simpy do `flags_to_restore |= VIRTIO_VSOCK_SEQ_EOR` 
then use `pkt->hdr.flags |= cpu_to_le32(flags_to_restore);` as you 
already do.

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

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
