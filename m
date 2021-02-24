Return-Path: <SRS0=cI1G=H2=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E8AAC433DB
	for <virtualization@archiver.kernel.org>; Wed, 24 Feb 2021 06:42:11 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85D4B64DCF
	for <virtualization@archiver.kernel.org>; Wed, 24 Feb 2021 06:42:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85D4B64DCF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 0E2994307B;
	Wed, 24 Feb 2021 06:42:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EvyoWxqNy7BM; Wed, 24 Feb 2021 06:42:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 9CD7943077;
	Wed, 24 Feb 2021 06:42:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 721B2C000A;
	Wed, 24 Feb 2021 06:42:08 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3EBA6C0001
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Feb 2021 06:42:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 185234307B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Feb 2021 06:42:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 45MiaII9julJ
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Feb 2021 06:42:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id CDCC5414ED
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Feb 2021 06:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1614148924;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=s55ilkit8AyvB8H+EC0E/iht8b+fHdOebNn3zsK85Zo=;
 b=OrSR0MvT01Po2p14zuxWNYX6xxZAUYUamAgS7q02BQhOakV0ONjXAN2Ia6AU8Rh59tdybA
 yP2eltlaNrteeq8mOdajiBrgN+LMujGySOtaje3sIig69g+NhNp1awx1hnj63oGTWrZmdS
 pKCc2jEogE/bzz+/MHmmBHnooHw84wk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-522-1O0gF87JMhmX_9dzFt0sxg-1; Wed, 24 Feb 2021 01:42:02 -0500
X-MC-Unique: 1O0gF87JMhmX_9dzFt0sxg-1
Received: by mail-wm1-f71.google.com with SMTP id v130so157283wma.0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Feb 2021 22:42:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=s55ilkit8AyvB8H+EC0E/iht8b+fHdOebNn3zsK85Zo=;
 b=kIY7XW1T4A28elU1bY2H09UuuXyfkAoizGPIeq+8Vh4n+PjZDkYSv1+JKRGplfb56D
 Zt8LbE9EoM5Tn7fqrYpBf0B9SsDo6jLFZn5jSk5pNQWMw0re/WrLFkKDbE0m6fitzsnY
 bWxiM3c7JyfNuEr7igL8XdR4PllMKr7AVDg5poNkPrLqE28po4Sj7dxCnO/vVKJlcYLB
 cKgWsNYNQP6QUXwjwceCxohQge3l8RYYeJKGiIDyiv54XGUPtvAtbFDK2UTfcMkyQ14J
 hUR5BU5nO4GaiuzIXvKUznDPHUI91W2EILRbIU8UOM2KYxbIWoes+7WSV2dwW95FmtBf
 oO8w==
X-Gm-Message-State: AOAM533GBo7qSdPb40fA0p7fzUJbF0pvPC8XXttLo4/6x55IQu6UhJEK
 Z0JtdYT6RJXDD9uztyfEWdM/9y+aPKv/cmurMCu9Gg4vQuWo5rW/hSG5NJVJsnUJssowvHq3Gkd
 HApxQiWiDr/1TXqZ5/njcc77PeOIydw8j1hJJdLH4cg==
X-Received: by 2002:a05:6000:1542:: with SMTP id
 2mr30358424wry.356.1614148921288; 
 Tue, 23 Feb 2021 22:42:01 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwEyzdsr3Ow3I/chOE2lEJ38C0hLHhjGkBn0ZJ3D6ow25zrmvo6OLG2W707+P84HiKWMouE/g==
X-Received: by 2002:a05:6000:1542:: with SMTP id
 2mr30358406wry.356.1614148921120; 
 Tue, 23 Feb 2021 22:42:01 -0800 (PST)
Received: from redhat.com (bzq-79-180-2-31.red.bezeqint.net. [79.180.2.31])
 by smtp.gmail.com with ESMTPSA id n5sm1172955wmq.7.2021.02.23.22.41.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Feb 2021 22:42:00 -0800 (PST)
Date: Wed, 24 Feb 2021 01:41:56 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Arseny Krasnov <arseny.krasnov@kaspersky.com>
Subject: Re: [RFC PATCH v5 11/19] virtio/vsock: dequeue callback for
 SOCK_SEQPACKET
Message-ID: <20210224002315-mutt-send-email-mst@kernel.org>
References: <20210218053347.1066159-1-arseny.krasnov@kaspersky.com>
 <20210218053940.1068164-1-arseny.krasnov@kaspersky.com>
 <20210223091536-mutt-send-email-mst@kernel.org>
 <661fd81f-daf5-a3eb-6946-8f4e83d1ee54@kaspersky.com>
MIME-Version: 1.0
In-Reply-To: <661fd81f-daf5-a3eb-6946-8f4e83d1ee54@kaspersky.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Andra Paraschiv <andraprs@amazon.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "stsp2@yandex.ru" <stsp2@yandex.ru>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "oxffffaa@gmail.com" <oxffffaa@gmail.com>,
 Norbert Slusarek <nslusarek@gmx.net>, Stefan Hajnoczi <stefanha@redhat.com>,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Wed, Feb 24, 2021 at 08:07:48AM +0300, Arseny Krasnov wrote:
> 
> On 23.02.2021 17:17, Michael S. Tsirkin wrote:
> > On Thu, Feb 18, 2021 at 08:39:37AM +0300, Arseny Krasnov wrote:
> >> This adds transport callback and it's logic for SEQPACKET dequeue.
> >> Callback fetches RW packets from rx queue of socket until whole record
> >> is copied(if user's buffer is full, user is not woken up). This is done
> >> to not stall sender, because if we wake up user and it leaves syscall,
> >> nobody will send credit update for rest of record, and sender will wait
> >> for next enter of read syscall at receiver's side. So if user buffer is
> >> full, we just send credit update and drop data. If during copy SEQ_BEGIN
> >> was found(and not all data was copied), copying is restarted by reset
> >> user's iov iterator(previous unfinished data is dropped).
> >>
> >> Signed-off-by: Arseny Krasnov <arseny.krasnov@kaspersky.com>
> >> ---
> >>  include/linux/virtio_vsock.h            |  10 +++
> >>  include/uapi/linux/virtio_vsock.h       |  16 ++++
> >>  net/vmw_vsock/virtio_transport_common.c | 114 ++++++++++++++++++++++++
> >>  3 files changed, 140 insertions(+)
> >>
> >> diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
> >> index dc636b727179..003d06ae4a85 100644
> >> --- a/include/linux/virtio_vsock.h
> >> +++ b/include/linux/virtio_vsock.h
> >> @@ -36,6 +36,11 @@ struct virtio_vsock_sock {
> >>  	u32 rx_bytes;
> >>  	u32 buf_alloc;
> >>  	struct list_head rx_queue;
> >> +
> >> +	/* For SOCK_SEQPACKET */
> >> +	u32 user_read_seq_len;
> >> +	u32 user_read_copied;
> >> +	u32 curr_rx_msg_cnt;
> >
> > wrap these in a struct to make it's clearer they
> > are related?
> Ack
> >
> >>  };
> >>  
> >>  struct virtio_vsock_pkt {
> >> @@ -80,6 +85,11 @@ virtio_transport_dgram_dequeue(struct vsock_sock *vsk,
> >>  			       struct msghdr *msg,
> >>  			       size_t len, int flags);
> >>  
> >> +int
> >> +virtio_transport_seqpacket_dequeue(struct vsock_sock *vsk,
> >> +				   struct msghdr *msg,
> >> +				   int flags,
> >> +				   bool *msg_ready);
> >>  s64 virtio_transport_stream_has_data(struct vsock_sock *vsk);
> >>  s64 virtio_transport_stream_has_space(struct vsock_sock *vsk);
> >>  
> >> diff --git a/include/uapi/linux/virtio_vsock.h b/include/uapi/linux/virtio_vsock.h
> >> index 1d57ed3d84d2..cf9c165e5cca 100644
> >> --- a/include/uapi/linux/virtio_vsock.h
> >> +++ b/include/uapi/linux/virtio_vsock.h
> >> @@ -63,8 +63,14 @@ struct virtio_vsock_hdr {
> >>  	__le32	fwd_cnt;
> >>  } __attribute__((packed));
> >>  
> >> +struct virtio_vsock_seq_hdr {
> >> +	__le32  msg_cnt;
> >> +	__le32  msg_len;
> >> +} __attribute__((packed));
> >> +
> >>  enum virtio_vsock_type {
> >>  	VIRTIO_VSOCK_TYPE_STREAM = 1,
> >> +	VIRTIO_VSOCK_TYPE_SEQPACKET = 2,
> >>  };
> >>  
> >>  enum virtio_vsock_op {
> >> @@ -83,6 +89,11 @@ enum virtio_vsock_op {
> >>  	VIRTIO_VSOCK_OP_CREDIT_UPDATE = 6,
> >>  	/* Request the peer to send the credit info to us */
> >>  	VIRTIO_VSOCK_OP_CREDIT_REQUEST = 7,
> >> +
> >> +	/* Record begin for SOCK_SEQPACKET */
> >> +	VIRTIO_VSOCK_OP_SEQ_BEGIN = 8,
> >> +	/* Record end for SOCK_SEQPACKET */
> >> +	VIRTIO_VSOCK_OP_SEQ_END = 9,
> >>  };
> >>  
> >>  /* VIRTIO_VSOCK_OP_SHUTDOWN flags values */
> >> @@ -91,4 +102,9 @@ enum virtio_vsock_shutdown {
> >>  	VIRTIO_VSOCK_SHUTDOWN_SEND = 2,
> >>  };
> >>  
> >> +/* VIRTIO_VSOCK_OP_RW flags values */
> >> +enum virtio_vsock_rw {
> >> +	VIRTIO_VSOCK_RW_EOR = 1,
> >> +};
> >> +
> >>  #endif /* _UAPI_LINUX_VIRTIO_VSOCK_H */
> > Probably a good idea to also have a feature bit gating
> > this functionality.
> 
> IIUC this also requires some qemu patch, because in current
> 
> implementation of vsock device in qemu, there is no 'set_features'
> 
> callback for such device. This callback will handle guest's write
> 
> to feature register, by calling vhost kernel backend, where this
> 
> bit will be processed by host.

Well patching userspace to make use of a kernel feature
is par for the course, isn't it?

> 
> IMHO I'm not sure that SEQPACKET support needs feature
> 
> bit - it is just two new ops for virtio vsock protocol, and from point
> 
> of view of virtio device it is same as STREAM. May be it is needed
> 
> for cases when client tries to connect to server which doesn't support
> 
> SEQPACKET, so without bit result will be "Connection reset by peer",
> 
> and with such bit client will know that server doesn't support it and
> 
> 'socket(SOCK_SEQPACKET)' will return error?

Yes, a better error handling would be one reason to do it like this.

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
