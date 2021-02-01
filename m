Return-Path: <SRS0=ow7J=HD=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66843C433E0
	for <virtualization@archiver.kernel.org>; Mon,  1 Feb 2021 11:04:28 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F07F064E9A
	for <virtualization@archiver.kernel.org>; Mon,  1 Feb 2021 11:04:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F07F064E9A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 913C620439;
	Mon,  1 Feb 2021 11:04:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2qHHBbiVH98O; Mon,  1 Feb 2021 11:04:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id D44BE20420;
	Mon,  1 Feb 2021 11:04:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B124BC0174;
	Mon,  1 Feb 2021 11:04:25 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7776DC013A
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Feb 2021 11:04:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 6460D8538A
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Feb 2021 11:04:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1VvGV37O-YW0
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Feb 2021 11:04:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 9DEA98545F
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Feb 2021 11:04:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1612177462;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GResI48hDY26XzmbVp+6z1SLZhVjnr0cyMwLNeDGS6w=;
 b=a4RELzFbicZBqYodIBByieVb0NdVvOip+wGavHP0k7Q0OmP/HRBjcRn5nl3+yQaljqSoCH
 UtY7o0+sj1DlAitrmwGtFpOHc7vIM7GhWACoHgjSBqYEQtr3T452yxyY0yRr0SHVKKxrgH
 1fQYl8fiH6KRc1hq1hWFFj48VR4XRpI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-330-CyhtzO6_Ogqd-DNyf0IQlg-1; Mon, 01 Feb 2021 06:04:18 -0500
X-MC-Unique: CyhtzO6_Ogqd-DNyf0IQlg-1
Received: by mail-wm1-f72.google.com with SMTP id u1so4661740wml.2
 for <virtualization@lists.linux-foundation.org>;
 Mon, 01 Feb 2021 03:04:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=GResI48hDY26XzmbVp+6z1SLZhVjnr0cyMwLNeDGS6w=;
 b=NcIHk2ztUGxk1LjOw9soj1B8GWE0TRmB1WSLHxILZmxickF2e/NkLjn/D35wI2ukJQ
 lK5HFSxYiJSDOIyJeJyLS6nLz399cCf55x82mbhnjROTG03gzlYG/7l+gaFXc1tcwPwt
 BNuY/gh5QaZZTQU/Ie27kAY6ItUI5IkiL1jqAeqCDZkoqD096hsLl0uybfGNLfimYHmM
 9D5qox/1tItMZHrRPgOBf3z1V/FNdRqWkIz0kJjc+Kcu1KBfpOZDZ+ziDk5T7C9Q7Ls+
 plL2DCpcBB6Lt+IalLcHJ0wsSfJ5pl2jvHJG6fXZsrX5AUYWCQNhiC0+4K0dcafhzn1q
 R0Bw==
X-Gm-Message-State: AOAM530qbLeIxeTAPn3qtPYA7/hb27tIeN5EnvIrbIZkT4knv5L0/E5C
 H5ZtJHeRW4DF2guwLCbH/PrQOnD5D9DH7Hb2hT4lPGFxxuMoBd3GuDr2riociGdSPv3u5WGe2CN
 eFseZNtWplM0YbJCn7z2dDIT0qB49KfyvXsW815r/0w==
X-Received: by 2002:a1c:2c89:: with SMTP id
 s131mr14401985wms.176.1612177457131; 
 Mon, 01 Feb 2021 03:04:17 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyNhnD4X6xfgK4CDHcyftCnfHwb6wW61+fr1Lvod9SkVBfuQu/PNKXCAly6eJ6Qqevyykx9aA==
X-Received: by 2002:a1c:2c89:: with SMTP id
 s131mr14401948wms.176.1612177456881; 
 Mon, 01 Feb 2021 03:04:16 -0800 (PST)
Received: from steredhat (host-79-34-249-199.business.telecomitalia.it.
 [79.34.249.199])
 by smtp.gmail.com with ESMTPSA id d3sm29682647wrp.79.2021.02.01.03.04.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Feb 2021 03:04:16 -0800 (PST)
Date: Mon, 1 Feb 2021 12:04:13 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseny Krasnov <arseny.krasnov@kaspersky.com>
Subject: Re: [RFC PATCH v3 10/13] virtio/vsock: rest of SOCK_SEQPACKET support
Message-ID: <20210201110413.rhraxue2df4vhmpv@steredhat>
References: <20210125110903.597155-1-arseny.krasnov@kaspersky.com>
 <20210125111529.599448-1-arseny.krasnov@kaspersky.com>
 <20210129110350.p5h2wtb2xj42rbm4@steredhat>
 <83775d60-29c0-2da0-a87f-11c1f0a3102b@kaspersky.com>
MIME-Version: 1.0
In-Reply-To: <83775d60-29c0-2da0-a87f-11c1f0a3102b@kaspersky.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Andra Paraschiv <andraprs@amazon.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jeff Vander Stoep <jeffv@google.com>,
 "stsp2@yandex.ru" <stsp2@yandex.ru>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "oxffffaa@gmail.com" <oxffffaa@gmail.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
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

On Fri, Jan 29, 2021 at 07:00:16PM +0300, Arseny Krasnov wrote:
>
>On 29.01.2021 14:03, Stefano Garzarella wrote:
>> On Mon, Jan 25, 2021 at 02:15:26PM +0300, Arseny Krasnov wrote:
>>> This adds rest of logic for SEQPACKET:
>>> 1) Shared functions for packet sending now set valid type of packet
>>>   according socket type.
>>> 2) SEQPACKET specific function like SEQ_BEGIN send and data dequeue.
>>> 3) TAP support for SEQPACKET is not so easy if it is necessary to
>>> send whole record to TAP interface. This could be done by allocating
>>> new packet when whole record is received, data of record must be
>>> copied to TAP packet.
>>>
>>> Signed-off-by: Arseny Krasnov <arseny.krasnov@kaspersky.com>
>>> ---
>>> include/linux/virtio_vsock.h            |  7 ++++
>>> net/vmw_vsock/virtio_transport_common.c | 55 +++++++++++++++++++++----
>>> 2 files changed, 55 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
>>> index af8705ea8b95..ad9783df97c9 100644
>>> --- a/include/linux/virtio_vsock.h
>>> +++ b/include/linux/virtio_vsock.h
>>> @@ -84,7 +84,14 @@ virtio_transport_dgram_dequeue(struct vsock_sock *vsk,
>>> 			       struct msghdr *msg,
>>> 			       size_t len, int flags);
>>>
>>> +bool virtio_transport_seqpacket_seq_send_len(struct vsock_sock *vsk, size_t len);
>>> size_t virtio_transport_seqpacket_seq_get_len(struct vsock_sock *vsk);
>>> +ssize_t
>>> +virtio_transport_seqpacket_dequeue(struct vsock_sock *vsk,
>>> +				   struct msghdr *msg,
>>> +				   size_t len,
>>> +				   int type);
>>> +
>>> s64 virtio_transport_stream_has_data(struct vsock_sock *vsk);
>>> s64 virtio_transport_stream_has_space(struct vsock_sock *vsk);
>>>
>>> diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>>> index 90f9feef9d8f..fab14679ca7b 100644
>>> --- a/net/vmw_vsock/virtio_transport_common.c
>>> +++ b/net/vmw_vsock/virtio_transport_common.c
>>> @@ -139,6 +139,7 @@ static struct sk_buff *virtio_transport_build_skb(void *opaque)
>>> 		break;
>>> 	case VIRTIO_VSOCK_OP_CREDIT_UPDATE:
>>> 	case VIRTIO_VSOCK_OP_CREDIT_REQUEST:
>>> +	case VIRTIO_VSOCK_OP_SEQ_BEGIN:
>>> 		hdr->op = cpu_to_le16(AF_VSOCK_OP_CONTROL);
>>> 		break;
>>> 	default:
>>> @@ -157,6 +158,10 @@ static struct sk_buff *virtio_transport_build_skb(void *opaque)
>>>
>>> void virtio_transport_deliver_tap_pkt(struct virtio_vsock_pkt *pkt)
>>> {
>>> +	/* TODO: implement tap support for SOCK_SEQPACKET. */
>> I think we should do this before merging SOCK_SEQPACKET support because
>> it can be very useful to use tcpdump to figure out what's going on, do
>> you think it's complicated?
>
>It is not complicated if for TAP interface we will consider seqpacket
>
>same as stream, e.g. TAP reader won't see whole record as one
>
>packet,it will see fragments of record as in stream socket. Implement

Maybe as initial support we can have this limitation and complete it 
later.

>
>normal interpretation of seqpacket is not complicated, but requires
>
>some extra work. Ok, i'll check it

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
