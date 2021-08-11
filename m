Return-Path: <SRS0=15I4=NC=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59F82C4320A
	for <virtualization@archiver.kernel.org>; Wed, 11 Aug 2021 09:00:47 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2F3660FC3
	for <virtualization@archiver.kernel.org>; Wed, 11 Aug 2021 09:00:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org F2F3660FC3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B576E82425;
	Wed, 11 Aug 2021 09:00:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7BvdEBY3D5I7; Wed, 11 Aug 2021 09:00:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 58B60837B6;
	Wed, 11 Aug 2021 09:00:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 36046C001A;
	Wed, 11 Aug 2021 09:00:42 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7A6DCC000E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Aug 2021 09:00:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 69EF560869
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Aug 2021 09:00:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JNB0c9o-I9Pz
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Aug 2021 09:00:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7881A60889
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Aug 2021 09:00:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1628672437;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xVYk6O6UbKVQlEk4hpiQ+ioYAfkIhHzccxHN1Fx+454=;
 b=hePHulxC8UlcraAHRT2aUEJTodurv0JfJB9iGv/keICH5v5gAk1a4MswaPA2PaGeGq6jQO
 e99154TPgPsnoOaGSIYAW6iAJjQy74HNu5CREQhux9Ps7/Kze5KZNfk+7obpIdZMDC+uox
 yjQKBYEESEuCGB7QEYKXU/3iLbs/0kc=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-272-PjX0ftHdP0mLvw9wXRS_NA-1; Wed, 11 Aug 2021 05:00:36 -0400
X-MC-Unique: PjX0ftHdP0mLvw9wXRS_NA-1
Received: by mail-ej1-f71.google.com with SMTP id
 ci25-20020a1709072679b029058e79f6c38aso414229ejc.13
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Aug 2021 02:00:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=xVYk6O6UbKVQlEk4hpiQ+ioYAfkIhHzccxHN1Fx+454=;
 b=WTyhRTrwLIuYiEtuRCSp3UNjStPItixeP1qJcMwjgycrziGIdyYgrV7X2C+h1Ohcx3
 UrovMJVFnlKRzmjtY+zU24aJyejazEJgLVl9I49Xmfomk890VbalQ+hK8iDtuBBOnzf3
 iZJHNzwR5wDFkzlIgBAPiFqGHzGEl8JnoUJ2K0g0rDqJwThPc6HLr0aP9KfcZKAOAEU/
 hgzXntUYVbIbucwAKK/LBvIaNSyYnlTKP7t19DGX2zCM/1AX8hxwNWmd0yvL+Y7fai1w
 1qHAiXXcbvESyJWWRNuFCS5IOKB/MGjr5A8186EGIgwimMIip5yPdhkMLd2RZSwtjApd
 ORPQ==
X-Gm-Message-State: AOAM5305shFxzF+/f0xLPzZYUzTQyJIaJHV+I0sKTZRDyEDld0LqRMFI
 rk+YBbr3A2aoh+3ToMV8XXYCfLqr/vHcklg/dAuxS4CleR4pI0ERvubPF6NdxXGD8InYUkHiE5d
 DnGfwzPbgAdw/QO6a0ZKRbG8gwgFPRA8n85B2TWSw5Q==
X-Received: by 2002:a17:906:a08a:: with SMTP id
 q10mr2593177ejy.100.1628672433810; 
 Wed, 11 Aug 2021 02:00:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx+Wh3oVEmn3QZnNAXMGsVm3JaAoH4eSr1ZKRKUam8aqa4jKG8XOA/RBO+z8M1b/2H29w2Viw==
X-Received: by 2002:a17:906:a08a:: with SMTP id
 q10mr2593146ejy.100.1628672433523; 
 Wed, 11 Aug 2021 02:00:33 -0700 (PDT)
Received: from steredhat (a-nu5-14.tin.it. [212.216.181.13])
 by smtp.gmail.com with ESMTPSA id l19sm4147213edb.86.2021.08.11.02.00.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Aug 2021 02:00:33 -0700 (PDT)
Date: Wed, 11 Aug 2021 11:00:30 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseny Krasnov <arseny.krasnov@kaspersky.com>
Subject: Re: [RFC PATCH v2 1/5] virtio/vsock: add 'VIRTIO_VSOCK_SEQ_EOM' bit
Message-ID: <20210811090030.snu5ckf6bdkzxdg7@steredhat>
References: <20210810113901.1214116-1-arseny.krasnov@kaspersky.com>
 <20210810113956.1214463-1-arseny.krasnov@kaspersky.com>
MIME-Version: 1.0
In-Reply-To: <20210810113956.1214463-1-arseny.krasnov@kaspersky.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Andra Paraschiv <andraprs@amazon.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org, stsp2@yandex.ru,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 oxffffaa@gmail.com, Norbert Slusarek <nslusarek@gmx.net>,
 Stefan Hajnoczi <stefanha@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 Colin Ian King <colin.king@canonical.com>,
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

On Tue, Aug 10, 2021 at 02:39:53PM +0300, Arseny Krasnov wrote:

The title is confusing, we are renaming EOR in EOM.

>This bit is used to mark end of messages('EOM' - end of message), while
>'VIRIO_VSOCK_SEQ_EOR' is used to pass MSG_EOR. Also rename 'record' to
>'message' in implementation as it is different things.
>
>Signed-off-by: Arseny Krasnov <arseny.krasnov@kaspersky.com>
>---
> drivers/vhost/vsock.c                   | 12 ++++++------
> include/uapi/linux/virtio_vsock.h       |  3 ++-
> net/vmw_vsock/virtio_transport_common.c | 14 +++++++-------
> 3 files changed, 15 insertions(+), 14 deletions(-)
>
>diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
>index f249622ef11b..feaf650affbe 100644
>--- a/drivers/vhost/vsock.c
>+++ b/drivers/vhost/vsock.c
>@@ -178,15 +178,15 @@ vhost_transport_do_send_pkt(struct vhost_vsock *vsock,
> 			 * small rx buffers, headers of packets in rx queue are
> 			 * created dynamically and are initialized with 
> 			 header
> 			 * of current packet(except length). But in case of
>-			 * SOCK_SEQPACKET, we also must clear record delimeter
>-			 * bit(VIRTIO_VSOCK_SEQ_EOR). Otherwise, instead of one
>-			 * packet with delimeter(which marks end of record),
>+			 * SOCK_SEQPACKET, we also must clear message delimeter
>+			 * bit(VIRTIO_VSOCK_SEQ_EOM). Otherwise, instead of one
>+			 * packet with delimeter(which marks end of message),
> 			 * there will be sequence of packets with delimeter
> 			 * bit set. After initialized header will be copied to
> 			 * rx buffer, this bit will be restored.
> 			 */
>-			if (le32_to_cpu(pkt->hdr.flags) & VIRTIO_VSOCK_SEQ_EOR) {
>-				pkt->hdr.flags &= ~cpu_to_le32(VIRTIO_VSOCK_SEQ_EOR);
>+			if (le32_to_cpu(pkt->hdr.flags) & VIRTIO_VSOCK_SEQ_EOM) {
>+				pkt->hdr.flags &= ~cpu_to_le32(VIRTIO_VSOCK_SEQ_EOM);
> 				restore_flag = true;
> 			}
> 		}
>@@ -225,7 +225,7 @@ vhost_transport_do_send_pkt(struct vhost_vsock *vsock,
> 		 */
> 		if (pkt->off < pkt->len) {
> 			if (restore_flag)
>-				pkt->hdr.flags |= cpu_to_le32(VIRTIO_VSOCK_SEQ_EOR);
>+				pkt->hdr.flags |= cpu_to_le32(VIRTIO_VSOCK_SEQ_EOM);
>
> 			/* We are queueing the same virtio_vsock_pkt to handle
> 			 * the remaining bytes, and we want to deliver it
>diff --git a/include/uapi/linux/virtio_vsock.h b/include/uapi/linux/virtio_vsock.h
>index 3dd3555b2740..64738838bee5 100644
>--- a/include/uapi/linux/virtio_vsock.h
>+++ b/include/uapi/linux/virtio_vsock.h
>@@ -97,7 +97,8 @@ enum virtio_vsock_shutdown {
>
> /* VIRTIO_VSOCK_OP_RW flags values */
> enum virtio_vsock_rw {
>-	VIRTIO_VSOCK_SEQ_EOR = 1,
>+	VIRTIO_VSOCK_SEQ_EOM = 1,
>+	VIRTIO_VSOCK_SEQ_EOR = 2,
         ^
I think is better to add this new flag in a separate patch.

> };
>
> #endif /* _UAPI_LINUX_VIRTIO_VSOCK_H */
>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>index 081e7ae93cb1..4d5a93beceb0 100644
>--- a/net/vmw_vsock/virtio_transport_common.c
>+++ b/net/vmw_vsock/virtio_transport_common.c
>@@ -77,7 +77,7 @@ virtio_transport_alloc_pkt(struct virtio_vsock_pkt_info *info,
>
> 		if (msg_data_left(info->msg) == 0 &&
> 		    info->type == VIRTIO_VSOCK_TYPE_SEQPACKET)
>-			pkt->hdr.flags |= cpu_to_le32(VIRTIO_VSOCK_SEQ_EOR);
>+			pkt->hdr.flags |= cpu_to_le32(VIRTIO_VSOCK_SEQ_EOM);
> 	}
>
> 	trace_virtio_transport_alloc_pkt(src_cid, src_port,
>@@ -457,7 +457,7 @@ static int virtio_transport_seqpacket_do_dequeue(struct vsock_sock *vsk,
> 				dequeued_len += pkt_len;
> 		}
>
>-		if (le32_to_cpu(pkt->hdr.flags) & VIRTIO_VSOCK_SEQ_EOR) {
>+		if (le32_to_cpu(pkt->hdr.flags) & VIRTIO_VSOCK_SEQ_EOM) {
> 			msg_ready = true;
> 			vvs->msg_count--;
> 		}
>@@ -1029,7 +1029,7 @@ virtio_transport_recv_enqueue(struct vsock_sock *vsk,
> 		goto out;
> 	}
>
>-	if (le32_to_cpu(pkt->hdr.flags) & VIRTIO_VSOCK_SEQ_EOR)
>+	if (le32_to_cpu(pkt->hdr.flags) & VIRTIO_VSOCK_SEQ_EOM)
> 		vvs->msg_count++;
>
> 	/* Try to copy small packets into the buffer of last packet queued,
>@@ -1044,12 +1044,12 @@ virtio_transport_recv_enqueue(struct vsock_sock *vsk,
>
> 		/* If there is space in the last packet queued, we copy the
> 		 * new packet in its buffer. We avoid this if the last packet
>-		 * queued has VIRTIO_VSOCK_SEQ_EOR set, because this is
>-		 * delimiter of SEQPACKET record, so 'pkt' is the first packet
>-		 * of a new record.
>+		 * queued has VIRTIO_VSOCK_SEQ_EOM set, because this is
>+		 * delimiter of SEQPACKET message, so 'pkt' is the first packet
>+		 * of a new message.
> 		 */
> 		if ((pkt->len <= last_pkt->buf_len - last_pkt->len) &&
>-		    !(le32_to_cpu(last_pkt->hdr.flags) & VIRTIO_VSOCK_SEQ_EOR)) {
>+		    !(le32_to_cpu(last_pkt->hdr.flags) & VIRTIO_VSOCK_SEQ_EOM)) {
> 			memcpy(last_pkt->buf + last_pkt->len, pkt->buf,
> 			       pkt->len);
> 			last_pkt->len += pkt->len;
>-- 
>2.25.1
>

The rest LGTM!

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
