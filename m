Return-Path: <SRS0=cI1G=H2=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47177C433E0
	for <virtualization@archiver.kernel.org>; Wed, 24 Feb 2021 08:31:43 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B59FB64DE0
	for <virtualization@archiver.kernel.org>; Wed, 24 Feb 2021 08:31:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B59FB64DE0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4401C83CD8;
	Wed, 24 Feb 2021 08:31:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rVigqLKoteTu; Wed, 24 Feb 2021 08:31:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8756483CD1;
	Wed, 24 Feb 2021 08:31:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 57DA1C000A;
	Wed, 24 Feb 2021 08:31:40 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 72C60C0001
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Feb 2021 08:31:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 605036F5D9
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Feb 2021 08:31:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KAN5y9A-MjTE
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Feb 2021 08:31:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3DA79606E2
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Feb 2021 08:31:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1614155497;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=l0HrWwkL16o0meAWImXIYrDByJmCFS+wi7i0wF+mFwY=;
 b=JPBPEE2RdaAqu2fvTnyU1QyldDvtJeoJa5qsKbdg5QscSCavL7TFoX49tt4Joqse4YvFru
 DbAnvyV/wti3IjSKIPWAx8ua99xVnTYexaQ6f/OlOHbLy8HYPRY+cHk/JScAhQ5Xeo+Rt2
 l4LivE9SUw7hPY6BdY0h37SRgMUBgP4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-324-0BneUeTENXaZs3RGHgAEUQ-1; Wed, 24 Feb 2021 03:31:35 -0500
X-MC-Unique: 0BneUeTENXaZs3RGHgAEUQ-1
Received: by mail-wm1-f72.google.com with SMTP id b62so253070wmc.5
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Feb 2021 00:31:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=l0HrWwkL16o0meAWImXIYrDByJmCFS+wi7i0wF+mFwY=;
 b=Du1dzbQqmtc+6kKyklHZvCnysE2R00gCbxzu487H0n9Y0kEOoJdSyOw4m4SvGivm/K
 wgvkzFhRQZrTb8vaRO9/NiiWbfTndKirEMrx7haxxUSohkP+PPK+h/UfP9Ccs4OmE9PC
 dWLVesrsnNOMc5Xi1JT/peO5JCZrH7hmuS2Pot4szt5kvVg7J9uh33mEQoivJ27dByEy
 lSxC/IpE7TDTgf9J2onrmPVqDWq4Rs+VQHwjytDFOsFw+tOWaBTJyUIdHgUO1S/UzWfQ
 blOCpBej/fZyrX/NfHWgUvAFbZkjpuiB+SWJ8aQleL39LifP15rdHYHCwY/sIlAAN4ad
 KZXA==
X-Gm-Message-State: AOAM530Ku42SZtJWEA8FGBWE8IDHnQWz7FrP3n07TpCxtTTjicf0vNar
 7p6tkQZIRN6/ZU4ernfsn0fJvbhSuPAqxc2bx7OXdsSj+jofFcu7WhUnMgeChuvzaCZigr1aB9Z
 6uL1O0XCfTm4rGo1s0weUP83AmOQxCl8ZgnBvastOvw==
X-Received: by 2002:a1c:6441:: with SMTP id y62mr2585329wmb.97.1614155494007; 
 Wed, 24 Feb 2021 00:31:34 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxsQGoIzVSWP5+5g7spt3MNrQhWmx+1VxmR4CjO/smQx8f4YhGjMFMPDtLZDQYXU0xVPDBNJQ==
X-Received: by 2002:a1c:6441:: with SMTP id y62mr2585305wmb.97.1614155493814; 
 Wed, 24 Feb 2021 00:31:33 -0800 (PST)
Received: from steredhat (host-79-34-249-199.business.telecomitalia.it.
 [79.34.249.199])
 by smtp.gmail.com with ESMTPSA id v6sm2063310wrx.32.2021.02.24.00.31.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Feb 2021 00:31:33 -0800 (PST)
Date: Wed, 24 Feb 2021 09:31:30 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [RFC PATCH v5 11/19] virtio/vsock: dequeue callback for
 SOCK_SEQPACKET
Message-ID: <20210224083130.j5ik4ndk3afmb73y@steredhat>
References: <20210218053347.1066159-1-arseny.krasnov@kaspersky.com>
 <20210218053940.1068164-1-arseny.krasnov@kaspersky.com>
 <20210223091536-mutt-send-email-mst@kernel.org>
 <661fd81f-daf5-a3eb-6946-8f4e83d1ee54@kaspersky.com>
 <20210224002315-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20210224002315-mutt-send-email-mst@kernel.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
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
 Arseny Krasnov <arseny.krasnov@kaspersky.com>,
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

On Wed, Feb 24, 2021 at 01:41:56AM -0500, Michael S. Tsirkin wrote:
>On Wed, Feb 24, 2021 at 08:07:48AM +0300, Arseny Krasnov wrote:
>>
>> On 23.02.2021 17:17, Michael S. Tsirkin wrote:
>> > On Thu, Feb 18, 2021 at 08:39:37AM +0300, Arseny Krasnov wrote:
>> >> This adds transport callback and it's logic for SEQPACKET dequeue.
>> >> Callback fetches RW packets from rx queue of socket until whole record
>> >> is copied(if user's buffer is full, user is not woken up). This is done
>> >> to not stall sender, because if we wake up user and it leaves syscall,
>> >> nobody will send credit update for rest of record, and sender will wait
>> >> for next enter of read syscall at receiver's side. So if user buffer is
>> >> full, we just send credit update and drop data. If during copy SEQ_BEGIN
>> >> was found(and not all data was copied), copying is restarted by reset
>> >> user's iov iterator(previous unfinished data is dropped).
>> >>
>> >> Signed-off-by: Arseny Krasnov <arseny.krasnov@kaspersky.com>
>> >> ---
>> >>  include/linux/virtio_vsock.h            |  10 +++
>> >>  include/uapi/linux/virtio_vsock.h       |  16 ++++
>> >>  net/vmw_vsock/virtio_transport_common.c | 114 ++++++++++++++++++++++++
>> >>  3 files changed, 140 insertions(+)
>> >>
>> >> diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
>> >> index dc636b727179..003d06ae4a85 100644
>> >> --- a/include/linux/virtio_vsock.h
>> >> +++ b/include/linux/virtio_vsock.h
>> >> @@ -36,6 +36,11 @@ struct virtio_vsock_sock {
>> >>  	u32 rx_bytes;
>> >>  	u32 buf_alloc;
>> >>  	struct list_head rx_queue;
>> >> +
>> >> +	/* For SOCK_SEQPACKET */
>> >> +	u32 user_read_seq_len;
>> >> +	u32 user_read_copied;
>> >> +	u32 curr_rx_msg_cnt;
>> >
>> > wrap these in a struct to make it's clearer they
>> > are related?
>> Ack
>> >
>> >>  };
>> >>
>> >>  struct virtio_vsock_pkt {
>> >> @@ -80,6 +85,11 @@ virtio_transport_dgram_dequeue(struct vsock_sock *vsk,
>> >>  			       struct msghdr *msg,
>> >>  			       size_t len, int flags);
>> >>
>> >> +int
>> >> +virtio_transport_seqpacket_dequeue(struct vsock_sock *vsk,
>> >> +				   struct msghdr *msg,
>> >> +				   int flags,
>> >> +				   bool *msg_ready);
>> >>  s64 virtio_transport_stream_has_data(struct vsock_sock *vsk);
>> >>  s64 virtio_transport_stream_has_space(struct vsock_sock *vsk);
>> >>
>> >> diff --git a/include/uapi/linux/virtio_vsock.h b/include/uapi/linux/virtio_vsock.h
>> >> index 1d57ed3d84d2..cf9c165e5cca 100644
>> >> --- a/include/uapi/linux/virtio_vsock.h
>> >> +++ b/include/uapi/linux/virtio_vsock.h
>> >> @@ -63,8 +63,14 @@ struct virtio_vsock_hdr {
>> >>  	__le32	fwd_cnt;
>> >>  } __attribute__((packed));
>> >>
>> >> +struct virtio_vsock_seq_hdr {
>> >> +	__le32  msg_cnt;
>> >> +	__le32  msg_len;
>> >> +} __attribute__((packed));
>> >> +
>> >>  enum virtio_vsock_type {
>> >>  	VIRTIO_VSOCK_TYPE_STREAM = 1,
>> >> +	VIRTIO_VSOCK_TYPE_SEQPACKET = 2,
>> >>  };
>> >>
>> >>  enum virtio_vsock_op {
>> >> @@ -83,6 +89,11 @@ enum virtio_vsock_op {
>> >>  	VIRTIO_VSOCK_OP_CREDIT_UPDATE = 6,
>> >>  	/* Request the peer to send the credit info to us */
>> >>  	VIRTIO_VSOCK_OP_CREDIT_REQUEST = 7,
>> >> +
>> >> +	/* Record begin for SOCK_SEQPACKET */
>> >> +	VIRTIO_VSOCK_OP_SEQ_BEGIN = 8,
>> >> +	/* Record end for SOCK_SEQPACKET */
>> >> +	VIRTIO_VSOCK_OP_SEQ_END = 9,
>> >>  };
>> >>
>> >>  /* VIRTIO_VSOCK_OP_SHUTDOWN flags values */
>> >> @@ -91,4 +102,9 @@ enum virtio_vsock_shutdown {
>> >>  	VIRTIO_VSOCK_SHUTDOWN_SEND = 2,
>> >>  };
>> >>
>> >> +/* VIRTIO_VSOCK_OP_RW flags values */
>> >> +enum virtio_vsock_rw {
>> >> +	VIRTIO_VSOCK_RW_EOR = 1,
>> >> +};
>> >> +
>> >>  #endif /* _UAPI_LINUX_VIRTIO_VSOCK_H */
>> > Probably a good idea to also have a feature bit gating
>> > this functionality.
>>
>> IIUC this also requires some qemu patch, because in current
>>
>> implementation of vsock device in qemu, there is no 'set_features'
>>
>> callback for such device. This callback will handle guest's write
>>
>> to feature register, by calling vhost kernel backend, where this
>>
>> bit will be processed by host.
>
>Well patching userspace to make use of a kernel feature
>is par for the course, isn't it?
>
>>
>> IMHO I'm not sure that SEQPACKET support needs feature
>>
>> bit - it is just two new ops for virtio vsock protocol, and from point
>>
>> of view of virtio device it is same as STREAM. May be it is needed
>>
>> for cases when client tries to connect to server which doesn't support
>>
>> SEQPACKET, so without bit result will be "Connection reset by peer",
>>
>> and with such bit client will know that server doesn't support it and
>>
>> 'socket(SOCK_SEQPACKET)' will return error?
>
>Yes, a better error handling would be one reason to do it like this.

Agree, in this way we could implement a 'seqpacket_allow' callback 
(similar to 'stream_allow'), and we can return 'true' if the feature is 
negotiated.

So instead of checking all the seqpacket callbacks, we can use only this 
callback to understand if the transport support it.
We can implement it also for other transports (vmci, hyperv) and return 
always false for now.

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
