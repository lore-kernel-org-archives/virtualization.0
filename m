Return-Path: <SRS0=XmMV=HA=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 380B6C433DB
	for <virtualization@archiver.kernel.org>; Fri, 29 Jan 2021 09:26:23 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F38464E10
	for <virtualization@archiver.kernel.org>; Fri, 29 Jan 2021 09:26:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F38464E10
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 142F286EDE;
	Fri, 29 Jan 2021 09:26:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XNG0M7M1O-BQ; Fri, 29 Jan 2021 09:26:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 190DA86EA4;
	Fri, 29 Jan 2021 09:26:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 07C3BC0FA8;
	Fri, 29 Jan 2021 09:26:16 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 37BB0C08A1
 for <virtualization@lists.linux-foundation.org>;
 Fri, 29 Jan 2021 09:26:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 5D45E86F84
 for <virtualization@lists.linux-foundation.org>;
 Fri, 29 Jan 2021 09:26:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id eQMsSMUw5mhX
 for <virtualization@lists.linux-foundation.org>;
 Fri, 29 Jan 2021 09:26:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 8A215853D0
 for <virtualization@lists.linux-foundation.org>;
 Fri, 29 Jan 2021 09:26:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1611912371;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nP4l2G4dODpjaU7YDjg1QGuqXy7wbW7wVhXMNoRQIL8=;
 b=O0i58g2r1mku/5EdwGCeK63TrDsWV4oxY2cnrH0qFa/Zvigbm7G/v2Mm5cg513MS6X/L4F
 Yh9mfJ1H4MapvQM0mkc3huijfm0eiCEUS0ogwvC1axNbimWIRsgub7xb53TJNu0DyykDr+
 dKWAmRmCDFOOWd3mFxqv2yx63dUcnzk=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-198-S52IKvgAMEG4dbwVoPLcrw-1; Fri, 29 Jan 2021 04:26:09 -0500
X-MC-Unique: S52IKvgAMEG4dbwVoPLcrw-1
Received: by mail-ej1-f71.google.com with SMTP id q11so3662820ejd.0
 for <virtualization@lists.linux-foundation.org>;
 Fri, 29 Jan 2021 01:26:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=nP4l2G4dODpjaU7YDjg1QGuqXy7wbW7wVhXMNoRQIL8=;
 b=dA6OokSnYSYAuaWDxF+abQ9aw0D4P3fY+NG4W3+kWs7fl9hR1KcyjgcLcFZtW9aDvr
 QuCBOPcksqwUq1JDk4xXYQXOvj3oSsTj9aemz+H6zAA0OH58Khhr9zMzqF6wMaFn0sUj
 u7CQ0bgwiDLL5x4DmItvZMOTYtJmvC3pmUCO0p92b24u7T9XaL2SqyXsL84BcUD4V1eO
 Kb0dMdfOJw8pxehL+haQ5t7bJoSHunSBuR2O/QKiLZZYOwUgt8Dk5bb5jIM/slbzBiXn
 i99MHcVi+hX4Bcss5vDMlVMtD2yttPzb/6kwI2GEZjNOVuq+uleThTf2U5ZlmzxpKKYe
 e/VQ==
X-Gm-Message-State: AOAM5320YiLRWYpz8/tGaRHgPV5NL6X1K18h/gR7mICgWUcrO1oNaJdW
 nwK9WyS5+31Cm4G4zbtvV2H/VszsUCzztWPa+pJc8nxXhMH1DguWf9Y6CueHo1VSSGlVs5Gj2Jf
 dDDVQnns57l4qalf8hadcY/ZD7QpzfO7MEdGHRnY/rA==
X-Received: by 2002:a05:6402:4242:: with SMTP id
 g2mr4091929edb.103.1611912368195; 
 Fri, 29 Jan 2021 01:26:08 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy2D+e1xoz9VblcO2a9mHDykKQQov6UxFQbNQz9AXlqGu90jfarHaQYZn2TFTNC1vtihyqKwg==
X-Received: by 2002:a05:6402:4242:: with SMTP id
 g2mr4091910edb.103.1611912367935; 
 Fri, 29 Jan 2021 01:26:07 -0800 (PST)
Received: from steredhat (host-79-34-249-199.business.telecomitalia.it.
 [79.34.249.199])
 by smtp.gmail.com with ESMTPSA id r23sm3509763ejd.56.2021.01.29.01.26.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Jan 2021 01:26:07 -0800 (PST)
Date: Fri, 29 Jan 2021 10:26:04 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseny Krasnov <arseny.krasnov@kaspersky.com>
Subject: Re: [RFC PATCH v3 00/13] virtio/vsock: introduce SOCK_SEQPACKET
 support
Message-ID: <20210129092604.mgaw3ipiyv6xra3b@steredhat>
References: <20210125110903.597155-1-arseny.krasnov@kaspersky.com>
 <20210128171923.esyna5ccv5s27jyu@steredhat>
 <63459bb3-da22-b2a4-71ee-e67660fd2e12@kaspersky.com>
MIME-Version: 1.0
In-Reply-To: <63459bb3-da22-b2a4-71ee-e67660fd2e12@kaspersky.com>
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

On Fri, Jan 29, 2021 at 09:41:50AM +0300, Arseny Krasnov wrote:
>
>On 28.01.2021 20:19, Stefano Garzarella wrote:
>> Hi Arseny,
>> I reviewed a part, tomorrow I hope to finish the other patches.
>>
>> Just a couple of comments in the TODOs below.
>>
>> On Mon, Jan 25, 2021 at 02:09:00PM +0300, Arseny Krasnov wrote:
>>> 	This patchset impelements support of SOCK_SEQPACKET for virtio
>>> transport.
>>> 	As SOCK_SEQPACKET guarantees to save record boundaries, so to
>>> do it, new packet operation was added: it marks start of record (with
>>> record length in header), such packet doesn't carry any data.  To send
>>> record, packet with start marker is sent first, then all data is sent
>>> as usual 'RW' packets. On receiver's side, length of record is known
>> >from packet with start record marker. Now as  packets of one socket
>>> are not reordered neither on vsock nor on vhost transport layers, such
>>> marker allows to restore original record on receiver's side. If user's
>>> buffer is smaller that record length, when all out of size data is
>>> dropped.
>>> 	Maximum length of datagram is not limited as in stream socket,
>>> because same credit logic is used. Difference with stream socket is
>>> that user is not woken up until whole record is received or error
>>> occurred. Implementation also supports 'MSG_EOR' and 'MSG_TRUNC' flags.
>>> 	Tests also implemented.
>>>
>>> Arseny Krasnov (13):
>>>  af_vsock: prepare for SOCK_SEQPACKET support
>>>  af_vsock: prepare 'vsock_connectible_recvmsg()'
>>>  af_vsock: implement SEQPACKET rx loop
>>>  af_vsock: implement send logic for SOCK_SEQPACKET
>>>  af_vsock: rest of SEQPACKET support
>>>  af_vsock: update comments for stream sockets
>>>  virtio/vsock: dequeue callback for SOCK_SEQPACKET
>>>  virtio/vsock: fetch length for SEQPACKET record
>>>  virtio/vsock: add SEQPACKET receive logic
>>>  virtio/vsock: rest of SOCK_SEQPACKET support
>>>  virtio/vsock: setup SEQPACKET ops for transport
>>>  vhost/vsock: setup SEQPACKET ops for transport
>>>  vsock_test: add SOCK_SEQPACKET tests
>>>
>>> drivers/vhost/vsock.c                   |   7 +-
>>> include/linux/virtio_vsock.h            |  12 +
>>> include/net/af_vsock.h                  |   6 +
>>> include/uapi/linux/virtio_vsock.h       |   9 +
>>> net/vmw_vsock/af_vsock.c                | 543 ++++++++++++++++------
>>> net/vmw_vsock/virtio_transport.c        |   4 +
>>> net/vmw_vsock/virtio_transport_common.c | 295 ++++++++++--
>>> tools/testing/vsock/util.c              |  32 +-
>>> tools/testing/vsock/util.h              |   3 +
>>> tools/testing/vsock/vsock_test.c        | 126 +++++
>>> 10 files changed, 862 insertions(+), 175 deletions(-)
>>>
>>> TODO:
>>> - Support for record integrity control. As transport could drop some
>>>   packets, something like "record-id" and record end marker need to
>>>   be implemented. Idea is that SEQ_BEGIN packet carries both record
>>>   length and record id, end marker(let it be SEQ_END) carries only
>>>   record id. To be sure that no one packet was lost, receiver checks
>>>   length of data between SEQ_BEGIN and SEQ_END(it must be same with
>>>   value in SEQ_BEGIN) and record ids of SEQ_BEGIN and SEQ_END(this
>>>   means that both markers were not dropped. I think that easiest way
>>>   to implement record id for SEQ_BEGIN is to reuse another field of
>>>   packet header(SEQ_BEGIN already uses 'flags' as record length).For
>>>   SEQ_END record id could be stored in 'flags'.
>> I don't really like the idea of reusing the 'flags' field for this
>> purpose.
>>
>>>     Another way to implement it, is to move metadata of both SEQ_END
>>>   and SEQ_BEGIN to payload. But this approach has problem, because
>>>   if we move something to payload, such payload is accounted by
>>>   credit logic, which fragments payload, while payload with record
>>>   length and id couldn't be fragmented. One way to overcome it is to
>>>   ignore credit update for SEQ_BEGIN/SEQ_END packet.Another solution
>>>   is to update 'stream_has_space()' function: current implementation
>>>   return non-zero when at least 1 byte is allowed to use,but updated
>>>   version will have extra argument, which is needed length. For 'RW'
>>>   packet this argument is 1, for SEQ_BEGIN it is sizeof(record len +
>>>   record id) and for SEQ_END it is sizeof(record id).
>> Is the payload accounted by credit logic also if hdr.op is not
>> VIRTIO_VSOCK_OP_RW?
>
>Yes, on send any packet with payload could be fragmented if
>
>there is not enough space at receiver. On receive 'fwd_cnt' and
>
>'buf_alloc' are updated with header of every packet. Of course,
>
>to every such case i've described i can add check for 'RW'
>
>packet, to exclude payload from credit accounting, but this is
>
>bunch of dumb checks.
>
>>
>> I think that we can define a specific header to put after the
>> virtio_vsock_hdr when hdr.op is SEQ_BEGIN or SEQ_END, and in this header
>> we can store the id and the length of the message.
>
>I think it is better than use payload and touch credit logic
>

Cool, so let's try this option, hoping there aren't a lot of issues.

Another item for TODO could be to add the SOCK_SEQPACKET support also 
for vsock_loopback. Should be simple since it also uses 
virtio_transport_common APIs and it can be useful for testing and 
debugging.

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
