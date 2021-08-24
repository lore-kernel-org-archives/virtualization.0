Return-Path: <SRS0=e+fm=NP=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB749C4338F
	for <virtualization@archiver.kernel.org>; Tue, 24 Aug 2021 10:01:12 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DF636023E
	for <virtualization@archiver.kernel.org>; Tue, 24 Aug 2021 10:01:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6DF636023E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3A003404FC;
	Tue, 24 Aug 2021 10:01:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gzT_uhgLThSl; Tue, 24 Aug 2021 10:01:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id E20E0404D8;
	Tue, 24 Aug 2021 10:01:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C6986C0010;
	Tue, 24 Aug 2021 10:01:07 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9E4E6C000E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Aug 2021 10:01:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8DA5A6089F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Aug 2021 10:01:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FNGaqUq4h_rT
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Aug 2021 10:01:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id BF9C1608B5
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Aug 2021 10:01:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1629799260;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AsfgonFEhHbtRW9+iWzj2iDpJcwnghT7FgzSm7rVr3I=;
 b=ElPHU+BOROQrIpOG542Y6K7nH7uJnu6grKvGDUc3T5q0zMO8vJHwrZg57O9oQYeAm3mWwB
 3Q97LjSZvpDP3Mvr7xD1zGey7T8yP1txhENf542AlineW/Y92xexCRL4ioMIsAaVVhP+Wd
 X7e/wsp6RJs9bXVqIcq8bUfzaEMqJr8=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-231-xCLGzgGOMq-A5pEYUXTeDQ-1; Tue, 24 Aug 2021 06:00:58 -0400
X-MC-Unique: xCLGzgGOMq-A5pEYUXTeDQ-1
Received: by mail-ej1-f72.google.com with SMTP id
 gg1-20020a170906e281b029053d0856c4cdso6820719ejb.15
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Aug 2021 03:00:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=AsfgonFEhHbtRW9+iWzj2iDpJcwnghT7FgzSm7rVr3I=;
 b=aUeABEXZna0JHg+RKpHm8kwRLntdogo3uQz0AVB/IapbypArQ/lFM7PcaR1FqUl2JR
 CGGRplflATpRro1m/f7zCKnPMtTFW6zqCcJ3vwlLrhiS87LAJawM03zM5I3mGaJKj/OY
 /p7dsEtRRMaj+RODevEOL6s2c0zUm0i6/j3iwWrlsMqHjVP7UF8JItADAPC/XoIS5DUj
 gCKMiu1svwSVtMQy0kWXU/1T+LxTw8Wp7fYOHBEjz8sXB0/R6gcLIGRhxMpb/eGnilvS
 B/LzBOiLnWIif/zo0HI23LQgu8VTM+ar+i8zV9HuLm5346LOQ4xptDz1+rUxOZx/EdOP
 9onA==
X-Gm-Message-State: AOAM532utz+xRlVMJoE1Ud8HxjF9mOJJ7vMlvC/7YljcmDJoakn11T7p
 WbJ2ZbD9821NBY1m+RCtFUpdD1QhUpcIHKNtTR2SBent4ScZ+AzToL1vGBrlZp6l4+aD0b9d9Uc
 680XtaEs28K3FuXpEEjPeidBlHs7V1pZ/5UyBDK3ZVw==
X-Received: by 2002:a17:906:a0ce:: with SMTP id
 bh14mr38811938ejb.434.1629799257232; 
 Tue, 24 Aug 2021 03:00:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz1OFEVEhnIhV9jwM2SN934WwXV2gbD7ZeMHy2q4u+7FfCSG2W+EV79uua+jleY+7NYrWEmuQ==
X-Received: by 2002:a17:906:a0ce:: with SMTP id
 bh14mr38811918ejb.434.1629799257043; 
 Tue, 24 Aug 2021 03:00:57 -0700 (PDT)
Received: from steredhat (host-79-45-8-152.retail.telecomitalia.it.
 [79.45.8.152])
 by smtp.gmail.com with ESMTPSA id f30sm3469843ejl.78.2021.08.24.03.00.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Aug 2021 03:00:56 -0700 (PDT)
Date: Tue, 24 Aug 2021 12:00:53 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseny Krasnov <arseny.krasnov@kaspersky.com>
Subject: Re: [RFC PATCH v3 3/6] vhost/vsock: support MSG_EOR bit processing
Message-ID: <20210824100053.jc2pgttgwq5sujvu@steredhat>
References: <20210816085036.4173627-1-arseny.krasnov@kaspersky.com>
 <20210816085143.4174099-1-arseny.krasnov@kaspersky.com>
MIME-Version: 1.0
In-Reply-To: <20210816085143.4174099-1-arseny.krasnov@kaspersky.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Andra Paraschiv <andraprs@amazon.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org, stsp2@yandex.ru,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 oxffffaa@gmail.co, Norbert Slusarek <nslusarek@gmx.net>,
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

On Mon, Aug 16, 2021 at 11:51:40AM +0300, Arseny Krasnov wrote:
>'MSG_EOR' handling has same logic as 'MSG_EOM' - if bit present

s/same/similar

>in packet's header, reset it to 0. Then restore it back if packet
>processing wasn't completed. Instead of bool variable for each
>flag, bit mask variable was added: it has logical OR of 'MSG_EOR'
>and 'MSG_EOM' if needed, to restore flags, this variable is ORed
>with flags field of packet.
>
>Signed-off-by: Arseny Krasnov <arseny.krasnov@kaspersky.com>
>---
> drivers/vhost/vsock.c | 12 ++++++++----
> 1 file changed, 8 insertions(+), 4 deletions(-)
>
>diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
>index feaf650affbe..d217955bbcd4 100644
>--- a/drivers/vhost/vsock.c
>+++ b/drivers/vhost/vsock.c
>@@ -114,7 +114,7 @@ vhost_transport_do_send_pkt(struct vhost_vsock *vsock,
> 		size_t nbytes;
> 		size_t iov_len, payload_len;
> 		int head;
>-		bool restore_flag = false;
>+		uint32_t flags_to_restore = 0;

checkpatch.pl suggest the following:
CHECK: Prefer kernel type 'u32' over 'uint32_t'

Sorry, I suggested that, I forgot that u32 is preferable :-)

>
> 		spin_lock_bh(&vsock->send_pkt_list_lock);
> 		if (list_empty(&vsock->send_pkt_list)) {
>@@ -187,7 +187,12 @@ vhost_transport_do_send_pkt(struct vhost_vsock 
>*vsock,
> 			 */

Please also update the comment above with the new flag handled.

> 			if (le32_to_cpu(pkt->hdr.flags) & VIRTIO_VSOCK_SEQ_EOM) {
> 				pkt->hdr.flags &= ~cpu_to_le32(VIRTIO_VSOCK_SEQ_EOM);
>-				restore_flag = true;
>+				flags_to_restore |= VIRTIO_VSOCK_SEQ_EOM;
>+
>+				if (le32_to_cpu(pkt->hdr.flags) & VIRTIO_VSOCK_SEQ_EOR) {
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

The rest LGTM.

Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
