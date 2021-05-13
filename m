Return-Path: <SRS0=J7l7=KI=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93151C433B4
	for <virtualization@archiver.kernel.org>; Thu, 13 May 2021 13:44:52 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D78C613BF
	for <virtualization@archiver.kernel.org>; Thu, 13 May 2021 13:44:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D78C613BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id A99DA4020F;
	Thu, 13 May 2021 13:44:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2_aASvGkJ05p; Thu, 13 May 2021 13:44:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 541C9400D0;
	Thu, 13 May 2021 13:44:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2676DC000E;
	Thu, 13 May 2021 13:44:50 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7115BC0001
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 May 2021 13:44:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5F9A183D56
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 May 2021 13:44:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1bIQ0O9S7hLm
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 May 2021 13:44:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 02ACB83B44
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 May 2021 13:44:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1620913485;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oWoRXdPQG5Lp8dZ+UX0wcCkUvkRtLC4RqeaSswn2gS0=;
 b=eOtx/F5hOGLP5V9Wb9qcsAXs+5AEB0bpcAojhZkIwP8jeBbk54qsdU74PyGcS40bNt1gKh
 KRfBSodaLlg7j+EUlS1MjsUpdAqDIf+/LIKyFr3PU8kr1iEaHeoIW/p7FTRqEiojjLl6Oz
 n/bsUX2GbhjkB1lPC/5y9koVXPm0vpk=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-157-w2dKvJCcMGy8_Y1svX1IHw-1; Thu, 13 May 2021 09:44:41 -0400
X-MC-Unique: w2dKvJCcMGy8_Y1svX1IHw-1
Received: by mail-ed1-f72.google.com with SMTP id
 p8-20020aa7c8880000b029038ce714c8d6so321453eds.10
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 May 2021 06:44:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=oWoRXdPQG5Lp8dZ+UX0wcCkUvkRtLC4RqeaSswn2gS0=;
 b=Q5xfkB1yJo+EzqjjnIqr2Iql0PIDsEmmYy6PREjvcWlkLzViHdS2y1US9fH13dWTcf
 ecw6zOeR4cWpsVB0KpQFAclYQLNuHSclodJUdxql3hZZ5j1XmEId9Ui9jyAADF7bnc1P
 uuDbn4Y6fSpZw4O5TmB5EDATJzy/XcrMStWX3KcxX0MFj1V16lu6SVxzt0FU0qH/mCQU
 UDCKJ0ohV4bPjaEld/HbA+Asw6uyKfsM5OWKY3KIjk3LXFdZD7T4eTDSPZHOh2L7EmPa
 Wis2PwfH2K1mLul8QQYnZSCFyBGkpcNNSE4bCKIugiJ1biapzvuxGPKsK9XEBDBA7KPj
 68Bg==
X-Gm-Message-State: AOAM532xJax2lKSGq5CpiQt5MxmJUNXUeOloQdp55Wk0XMsBXIL5blIi
 dkLgCxq7b7nRDVTzJytU5szYNRKTFH1GMrbz4/pvEoQ4THSmV1lHbDjcEbQ+qjxHfSZXwgq/yUH
 qBVD6ZzT7oJoITdIPzsZ0P/HrHESd2zsk4lqbJ58XuQ==
X-Received: by 2002:a17:906:f28a:: with SMTP id
 gu10mr9366307ejb.135.1620913480731; 
 Thu, 13 May 2021 06:44:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyRgeZlJQmydhRmOxSudfdDEFokEqUOqWxM5HwrKX/tQlm/Hr03jIduTjjqf7mT/0OjHrCwUQ==
X-Received: by 2002:a17:906:f28a:: with SMTP id
 gu10mr9366276ejb.135.1620913480499; 
 Thu, 13 May 2021 06:44:40 -0700 (PDT)
Received: from steredhat (host-79-18-148-79.retail.telecomitalia.it.
 [79.18.148.79])
 by smtp.gmail.com with ESMTPSA id q25sm1863114ejd.9.2021.05.13.06.44.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 May 2021 06:44:40 -0700 (PDT)
Date: Thu, 13 May 2021 15:44:37 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseny Krasnov <arseny.krasnov@kaspersky.com>
Subject: Re: [RFC PATCH v9 15/19] vhost/vsock: enable SEQPACKET for transport
Message-ID: <20210513134437.xwz5gaulse4jqcmm@steredhat>
References: <20210508163027.3430238-1-arseny.krasnov@kaspersky.com>
 <20210508163634.3432505-1-arseny.krasnov@kaspersky.com>
MIME-Version: 1.0
In-Reply-To: <20210508163634.3432505-1-arseny.krasnov@kaspersky.com>
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

On Sat, May 08, 2021 at 07:36:31PM +0300, Arseny Krasnov wrote:
>This removes:
>1) Ignore of non-stream type of packets.
>This adds:
>1) Handling of SEQPACKET bit: if guest sets features with this bit cleared,
>   then SOCK_SEQPACKET support will be disabled.
>2) 'seqpacket_allow()' callback.
>3) Handling of SEQ_EOR bit: when vhost places data in buffers of guest's
>   rx queue, keep this bit set only when last piece of data is copied.
>
>Signed-off-by: Arseny Krasnov <arseny.krasnov@kaspersky.com>
>---
> v8 -> v9:
> 1) Move 'seqpacket_allow' to 'struct vhost_vsock'.
> 2) Use cpu_to_le32()/le32_to_cpu() to work with 'flags' of packet.
>
> drivers/vhost/vsock.c | 42 +++++++++++++++++++++++++++++++++++++++---
> 1 file changed, 39 insertions(+), 3 deletions(-)
>
>diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
>index 5e78fb719602..3395b25d4a35 100644
>--- a/drivers/vhost/vsock.c
>+++ b/drivers/vhost/vsock.c
>@@ -31,7 +31,8 @@
>
> enum {
> 	VHOST_VSOCK_FEATURES = VHOST_FEATURES |
>-			       (1ULL << VIRTIO_F_ACCESS_PLATFORM)
>+			       (1ULL << VIRTIO_F_ACCESS_PLATFORM) |
>+			       (1ULL << VIRTIO_VSOCK_F_SEQPACKET)
> };
>
> enum {
>@@ -56,6 +57,7 @@ struct vhost_vsock {
> 	atomic_t queued_replies;
>
> 	u32 guest_cid;
>+	bool seqpacket_allow;
> };
>
> static u32 vhost_transport_get_local_cid(void)
>@@ -112,6 +114,7 @@ vhost_transport_do_send_pkt(struct vhost_vsock *vsock,
> 		size_t nbytes;
> 		size_t iov_len, payload_len;
> 		int head;
>+		bool restore_flag = false;
>
> 		spin_lock_bh(&vsock->send_pkt_list_lock);
> 		if (list_empty(&vsock->send_pkt_list)) {
>@@ -174,6 +177,12 @@ vhost_transport_do_send_pkt(struct vhost_vsock *vsock,
> 		/* Set the correct length in the header */
> 		pkt->hdr.len = cpu_to_le32(payload_len);
>
>+		if (pkt->off + payload_len < pkt->len &&
>+		    le32_to_cpu(pkt->hdr.flags) & VIRTIO_VSOCK_SEQ_EOR) {
>+			pkt->hdr.flags &= ~cpu_to_le32(VIRTIO_VSOCK_SEQ_EOR);
>+			restore_flag = true;
>+		}

I think is better to move this code in the same block when we limit
payload_len, something like this (not tested):

		/* If the packet is greater than the space available in the
		 * buffer, we split it using multiple buffers.
		 */
		if (payload_len > iov_len - sizeof(pkt->hdr)) {
			payload_len = iov_len - sizeof(pkt->hdr);

			if (le32_to_cpu(pkt->hdr.flags) & VIRTIO_VSOCK_SEQ_EOR) {
				pkt->hdr.flags &= ~cpu_to_le32(VIRTIO_VSOCK_SEQ_EOR);
				restore_flag = true;
			}
		}

The rest LGTM.

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
