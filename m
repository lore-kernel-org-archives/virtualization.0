Return-Path: <SRS0=J7l7=KI=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6203CC43461
	for <virtualization@archiver.kernel.org>; Thu, 13 May 2021 11:58:27 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01C926127A
	for <virtualization@archiver.kernel.org>; Thu, 13 May 2021 11:58:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01C926127A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BD85660651;
	Thu, 13 May 2021 11:58:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PTcWg-g5zrIb; Thu, 13 May 2021 11:58:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 516666063E;
	Thu, 13 May 2021 11:58:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 225AFC000E;
	Thu, 13 May 2021 11:58:25 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id ED531C0001
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 May 2021 11:58:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D55F260651
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 May 2021 11:58:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Lppad-3UxqmH
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 May 2021 11:58:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1CAEA6063E
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 May 2021 11:58:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1620907102;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mHdwZTL+pvK8Zg99tTdQKEFKw4APO+UMqyfXLBZ12cw=;
 b=JDwajyxwhQkDURymgCzVvYvM65pd+2EGKxvzOzk+j6nWTNugODBZ0jWx6yvMsw5uid+JOG
 H6CtUl2esK9pg+sLOx3Pjq3gsgg8skf1+LtnJZqQ20hDD4EyJiwdNk2uIgLAaIBnJkwdgE
 ysikD4nknAHyk7WUjvushIT/fwZfxRw=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-522-FO0Be7jDN5yVSLkKWqNV4A-1; Thu, 13 May 2021 07:58:20 -0400
X-MC-Unique: FO0Be7jDN5yVSLkKWqNV4A-1
Received: by mail-ej1-f71.google.com with SMTP id
 o18-20020a17090637d2b02903bf3465db95so4143140ejc.18
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 May 2021 04:58:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=mHdwZTL+pvK8Zg99tTdQKEFKw4APO+UMqyfXLBZ12cw=;
 b=e/3L6cK2ApxUXVoAuDEacwZqE6abKS/3/MkPGI0hl8ScOtXp7pCOlOADW99MT6OKpy
 nokeS5yEfPPHoN5y6embZpGinKUhlGJzvF1U5QdpSfY2ku710+O4HIprhXV+CuF4M49o
 RKgD9QnMIJ+9zzIT/V+V/593WP45LRvl7dAqG8RrUNAulANXqUASkipRmoEbXgWnNHPa
 bcoN3DcxubPPH15z07F1W0GmqhkWYL8NTCB2K9x1vw1O5c7zlK64nKxr+z/TqB1EQ5c+
 aVD29WIEwiYhau61CNMa/k6DL+pPiRy/SScxAKJpf148hWYaMU9CAAQlo10/m8uQXSPX
 Yw6A==
X-Gm-Message-State: AOAM5308S6Aq4KaJoFBrhJ8biSpQglvOVx7kyjKAdZv7BsQvBYGpgjTe
 veueA0lXH/qiY5eIQa5LtirPAIg+HKxNSRNDCbhCPVwrUIuJoqHtm/o1my0gwg+4i6Ia74W9VPA
 cFvnAwQJjLWBmKks4Ex6KGADkOyI6dZtcXvzeC/vYSw==
X-Received: by 2002:a17:906:3952:: with SMTP id
 g18mr8710567eje.138.1620907099239; 
 Thu, 13 May 2021 04:58:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJytzhY86+D4jQaq9WMVx+063wiEyhp56IsRtO0CBtMRCrX7Xse2B2ObmWARquFYRp5Ry0+5mg==
X-Received: by 2002:a17:906:3952:: with SMTP id
 g18mr8710552eje.138.1620907099070; 
 Thu, 13 May 2021 04:58:19 -0700 (PDT)
Received: from steredhat (host-79-18-148-79.retail.telecomitalia.it.
 [79.18.148.79])
 by smtp.gmail.com with ESMTPSA id b25sm2288552edv.9.2021.05.13.04.58.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 May 2021 04:58:18 -0700 (PDT)
Date: Thu, 13 May 2021 13:58:16 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseny Krasnov <arseny.krasnov@kaspersky.com>
Subject: Re: [RFC PATCH v9 11/19] virtio/vsock: dequeue callback for
 SOCK_SEQPACKET
Message-ID: <20210513115816.332nfej4jyra7vrh@steredhat>
References: <20210508163027.3430238-1-arseny.krasnov@kaspersky.com>
 <20210508163523.3431999-1-arseny.krasnov@kaspersky.com>
MIME-Version: 1.0
In-Reply-To: <20210508163523.3431999-1-arseny.krasnov@kaspersky.com>
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

On Sat, May 08, 2021 at 07:35:20PM +0300, Arseny Krasnov wrote:
>This adds transport callback and it's logic for SEQPACKET dequeue.
>Callback fetches RW packets from rx queue of socket until whole record
>is copied(if user's buffer is full, user is not woken up). This is done
>to not stall sender, because if we wake up user and it leaves syscall,
>nobody will send credit update for rest of record, and sender will wait
>for next enter of read syscall at receiver's side. So if user buffer is
>full, we just send credit update and drop data.
>
>Signed-off-by: Arseny Krasnov <arseny.krasnov@kaspersky.com>
>---
> v8 -> v9:
> 1) Check for RW packet type is removed from loop(all packet now
>    considered RW).
> 2) Locking in loop is fixed.
> 3) cpu_to_le32()/le32_to_cpu() now used.
> 4) MSG_TRUNC handling removed from transport.
>
> include/linux/virtio_vsock.h            |  5 ++
> net/vmw_vsock/virtio_transport_common.c | 64 +++++++++++++++++++++++++
> 2 files changed, 69 insertions(+)
>
>diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
>index dc636b727179..02acf6e9ae04 100644
>--- a/include/linux/virtio_vsock.h
>+++ b/include/linux/virtio_vsock.h
>@@ -80,6 +80,11 @@ virtio_transport_dgram_dequeue(struct vsock_sock *vsk,
> 			       struct msghdr *msg,
> 			       size_t len, int flags);
>
>+ssize_t
>+virtio_transport_seqpacket_dequeue(struct vsock_sock *vsk,
>+				   struct msghdr *msg,
>+				   int flags,
>+				   bool *msg_ready);
> s64 virtio_transport_stream_has_data(struct vsock_sock *vsk);
> s64 virtio_transport_stream_has_space(struct vsock_sock *vsk);
>
>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>index ad0d34d41444..f649a21dd23b 100644
>--- a/net/vmw_vsock/virtio_transport_common.c
>+++ b/net/vmw_vsock/virtio_transport_common.c
>@@ -393,6 +393,58 @@ virtio_transport_stream_do_dequeue(struct vsock_sock *vsk,
> 	return err;
> }
>
>+static int virtio_transport_seqpacket_do_dequeue(struct vsock_sock *vsk,
>+						 struct msghdr *msg,
>+						 int flags,
>+						 bool *msg_ready)
>+{
>+	struct virtio_vsock_sock *vvs = vsk->trans;
>+	struct virtio_vsock_pkt *pkt;
>+	int err = 0;
>+	size_t user_buf_len = msg->msg_iter.count;
>+
>+	*msg_ready = false;
>+	spin_lock_bh(&vvs->rx_lock);
>+
>+	while (!*msg_ready && !list_empty(&vvs->rx_queue) && err >= 0) {
>+		size_t bytes_to_copy;
>+		size_t pkt_len;
>+
>+		pkt = list_first_entry(&vvs->rx_queue, struct virtio_vsock_pkt, list);
>+		pkt_len = (size_t)le32_to_cpu(pkt->hdr.len);
>+		bytes_to_copy = min(user_buf_len, pkt_len);
>+
>+		if (bytes_to_copy) {
>+			/* sk_lock is held by caller so no one else can dequeue.
>+			 * Unlock rx_lock since memcpy_to_msg() may sleep.
>+			 */
>+			spin_unlock_bh(&vvs->rx_lock);
>+
>+			if (memcpy_to_msg(msg, pkt->buf, bytes_to_copy)) 
>{
>+				err = -EINVAL;
>+			} else {
>+				err += pkt_len;

If `bytes_to_copy == 0` we are not increasing the real length.

Anyway is a bit confusing increase a variable called `err`, I think is 
better to have another variable to store this information that we return 
if there aren't errors.

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
