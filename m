Return-Path: <SRS0=cXtE=IO=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75E97C433DB
	for <virtualization@archiver.kernel.org>; Tue, 16 Mar 2021 08:08:19 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 162A864F67
	for <virtualization@archiver.kernel.org>; Tue, 16 Mar 2021 08:08:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 162A864F67
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C650483834;
	Tue, 16 Mar 2021 08:08:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id A2A56FGqG_sb; Tue, 16 Mar 2021 08:08:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTP id 48ED983848;
	Tue, 16 Mar 2021 08:08:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2F0A1C000C;
	Tue, 16 Mar 2021 08:08:17 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A6679C000A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Mar 2021 08:08:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A056B83848
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Mar 2021 08:08:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YMfUnKVuEJYY
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Mar 2021 08:08:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9076283834
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Mar 2021 08:08:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1615882094;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Q7WT3htOwE1z4myGhMGZMlNXxItKTPOFSR21S/hG2o0=;
 b=bKj1Bsay57dSVaPJ+/iMR/BN842+PvAhJR6N9l25s+2oOzLJKqWZmABDEVwskiiwHErYkG
 f7olj0hwVlCgWvnkl0dUfPFtkRfOnjCM173d4RuH4OiDwi/16pTfzNxbex05QfxR42fLnk
 BU+1FDZB9CuZ5gGescwkUfjy7i5Go0M=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-59-jNUhg0vRN0SF9geaqXgngw-1; Tue, 16 Mar 2021 04:08:12 -0400
X-MC-Unique: jNUhg0vRN0SF9geaqXgngw-1
Received: by mail-wr1-f71.google.com with SMTP id p12so13707238wrn.18
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Mar 2021 01:08:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Q7WT3htOwE1z4myGhMGZMlNXxItKTPOFSR21S/hG2o0=;
 b=mD0U1reFQY0Cn/dyFCnBBzlwyuHdW+1C497qciny662yH4HSV6Au0fdlBkcCjSZjPd
 n3CtPvyobzo/L0SlotEZuh52FyWtxmfscYHCdmI4SpwIfc62Rr5+94tjbVeHPSvMlAbn
 RhtaTXzQPqCxBrSx+w1VydMWrwWKSMVSInhCRDoDoRrc7yzuyEhxEqxEV7EXnI3UZNC7
 ddbJT7WpVcmuASpT3XL2mg8KNit/9mPrkSOnkT39y1zi01z7A7mS+41Gd36Gn4aU8bn8
 dc+QDFBz5t7uudxie0Jx+6NPKhEnqOPy2mJdRJHWjdjRR/NYIj8a3m5U79N1+5wO93WT
 AfHw==
X-Gm-Message-State: AOAM530hudmzYy3c1NX10C1wU4o6lwMrKZlSahk6Z/oB+JYK4eOlAjZp
 6K1R71nIaPrNzabB3WO2+kolHgbpwmg25E3vQwm6K7XjM2zyW2DkO3VsgXpWqzMj8RPeB3uZYNk
 lsZCDc+1R/1Y/+2l2B8ai46vM5q0PN9QTPFUJSn820A==
X-Received: by 2002:adf:cf11:: with SMTP id o17mr3461893wrj.391.1615882091458; 
 Tue, 16 Mar 2021 01:08:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzagh7g25cmp5cvg1Iv5CGE+bnWtmACvvzBIjLZlogl2jZS3AUMEeYvFKcntaYOr6iJBmtZYw==
X-Received: by 2002:adf:cf11:: with SMTP id o17mr3461854wrj.391.1615882091197; 
 Tue, 16 Mar 2021 01:08:11 -0700 (PDT)
Received: from steredhat (host-79-34-249-199.business.telecomitalia.it.
 [79.34.249.199])
 by smtp.gmail.com with ESMTPSA id e13sm540177wrg.72.2021.03.16.01.08.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Mar 2021 01:08:10 -0700 (PDT)
Date: Tue, 16 Mar 2021 09:08:08 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseny Krasnov <arseny.krasnov@kaspersky.com>
Subject: Re: [RFC PATCH v6 00/22] virtio/vsock: introduce SOCK_SEQPACKET
 support
Message-ID: <20210316080808.lwdcztky4vjthh3t@steredhat>
References: <20210307175722.3464068-1-arseny.krasnov@kaspersky.com>
 <20210315114027.neacovpmw3nzz77z@steredhat>
 <c4be25c6-8a53-7947-735b-2afacd989120@kaspersky.com>
 <e2c50a79-0063-71ee-b573-b267ee87e7c5@kaspersky.com>
MIME-Version: 1.0
In-Reply-To: <e2c50a79-0063-71ee-b573-b267ee87e7c5@kaspersky.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Andra Paraschiv <andraprs@amazon.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Tue, Mar 16, 2021 at 06:37:31AM +0300, Arseny Krasnov wrote:
>
>On 15.03.2021 18:22, Arseny Krasnov wrote:
>> On 15.03.2021 14:40, Stefano Garzarella wrote:
>>> Hi Arseny,
>>>
>>> On Sun, Mar 07, 2021 at 08:57:19PM +0300, Arseny Krasnov wrote:
>>>> 	This patchset implements support of SOCK_SEQPACKET for virtio
>>>> transport.
>>>> 	As SOCK_SEQPACKET guarantees to save record boundaries, so to
>>>> do it, two new packet operations were added: first for start of record
>>>> and second to mark end of record(SEQ_BEGIN and SEQ_END later). Also,
>>>> both operations carries metadata - to maintain boundaries and payload
>>>> integrity. Metadata is introduced by adding special header with two
>>>> fields - message id and message length:
>>>>
>>>> 	struct virtio_vsock_seq_hdr {
>>>> 		__le32  msg_id;
>>>> 		__le32  msg_len;
>>>> 	} __attribute__((packed));
>>>>
>>>> 	This header is transmitted as payload of SEQ_BEGIN and SEQ_END
>>>> packets(buffer of second virtio descriptor in chain) in the same way as
>>>> data transmitted in RW packets. Payload was chosen as buffer for this
>>>> header to avoid touching first virtio buffer which carries header of
>>>> packet, because someone could check that size of this buffer is equal
>>>> to size of packet header. To send record, packet with start marker is
>>>> sent first(it's header carries length of record and id),then all data
>>>> is sent as usual 'RW' packets and finally SEQ_END is sent(it carries
>>>> id of message, which is equal to id of SEQ_BEGIN), also after sending
>>>> SEQ_END id is incremented. On receiver's side,size of record is known
>>> >from packet with start record marker. To check that no packets were
>>>> dropped by transport, 'msg_id's of two sequential SEQ_BEGIN and SEQ_END
>>>> are checked to be equal and length of data between two markers is
>>>> compared to then length in SEQ_BEGIN header.
>>>> 	Now as  packets of one socket are not reordered neither on
>>>> vsock nor on vhost transport layers, such markers allows to restore
>>>> original record on receiver's side. If user's buffer is smaller that
>>>> record length, when all out of size data is dropped.
>>>> 	Maximum length of datagram is not limited as in stream socket,
>>>> because same credit logic is used. Difference with stream socket is
>>>> that user is not woken up until whole record is received or error
>>>> occurred. Implementation also supports 'MSG_EOR' and 'MSG_TRUNC' flags.
>>>> 	Tests also implemented.
>>>>
>>>> 	Thanks to stsp2@yandex.ru for encouragements and initial design
>>>> recommendations.
>>>>
>>>> Arseny Krasnov (22):
>>>>  af_vsock: update functions for connectible socket
>>>>  af_vsock: separate wait data loop
>>>>  af_vsock: separate receive data loop
>>>>  af_vsock: implement SEQPACKET receive loop
>>>>  af_vsock: separate wait space loop
>>>>  af_vsock: implement send logic for SEQPACKET
>>>>  af_vsock: rest of SEQPACKET support
>>>>  af_vsock: update comments for stream sockets
>>>>  virtio/vsock: set packet's type in virtio_transport_send_pkt_info()
>>>>  virtio/vsock: simplify credit update function API
>>>>  virtio/vsock: dequeue callback for SOCK_SEQPACKET
>>>>  virtio/vsock: fetch length for SEQPACKET record
>>>>  virtio/vsock: add SEQPACKET receive logic
>>>>  virtio/vsock: rest of SOCK_SEQPACKET support
>>>>  virtio/vsock: SEQPACKET feature bit
>>>>  vhost/vsock: SEQPACKET feature bit support
>>>>  virtio/vsock: SEQPACKET feature bit support
>>>>  virtio/vsock: setup SEQPACKET ops for transport
>>>>  vhost/vsock: setup SEQPACKET ops for transport
>>>>  vsock/loopback: setup SEQPACKET ops for transport
>>>>  vsock_test: add SOCK_SEQPACKET tests
>>>>  virtio/vsock: update trace event for SEQPACKET
>>>>
>>>> drivers/vhost/vsock.c                        |  22 +-
>>>> include/linux/virtio_vsock.h                 |  22 +
>>>> include/net/af_vsock.h                       |  10 +
>>>> .../events/vsock_virtio_transport_common.h   |  48 +-
>>>> include/uapi/linux/virtio_vsock.h            |  19 +
>>>> net/vmw_vsock/af_vsock.c                     | 589 +++++++++++------
>>>> net/vmw_vsock/virtio_transport.c             |  18 +
>>>> net/vmw_vsock/virtio_transport_common.c      | 364 ++++++++--
>>>> net/vmw_vsock/vsock_loopback.c               |  13 +
>>>> tools/testing/vsock/util.c                   |  32 +-
>>>> tools/testing/vsock/util.h                   |   3 +
>>>> tools/testing/vsock/vsock_test.c             | 126 ++++
>>>> 12 files changed, 1013 insertions(+), 253 deletions(-)
>>>>
>>>> v5 -> v6:
>>>> General changelog:
>>>> - virtio transport specific callbacks which send SEQ_BEGIN or
>>>>   SEQ_END now hidden inside virtio transport. Only enqueue,
>>>>   dequeue and record length callbacks are provided by transport.
>>>>
>>>> - virtio feature bit for SEQPACKET socket support introduced:
>>>>   VIRTIO_VSOCK_F_SEQPACKET.
>>>>
>>>> - 'msg_cnt' field in 'struct virtio_vsock_seq_hdr' renamed to
>>>>   'msg_id' and used as id.
>>>>
>>>> Per patch changelog:
>>>> - 'af_vsock: separate wait data loop':
>>>>    1) Commit message updated.
>>>>    2) 'prepare_to_wait()' moved inside while loop(thanks to
>>>>      Jorgen Hansen).
>>>>    Marked 'Reviewed-by' with 1), but as 2) I removed R-b.
>>>>
>>>> - 'af_vsock: separate receive data loop': commit message
>>>>    updated.
>>>>    Marked 'Reviewed-by' with that fix.
>>>>
>>>> - 'af_vsock: implement SEQPACKET receive loop': style fixes.
>>>>
>>>> - 'af_vsock: rest of SEQPACKET support':
>>>>    1) 'module_put()' added when transport callback check failed.
>>>>    2) Now only 'seqpacket_allow()' callback called to check
>>>>       support of SEQPACKET by transport.
>>>>
>>>> - 'af_vsock: update comments for stream sockets': commit message
>>>>    updated.
>>>>    Marked 'Reviewed-by' with that fix.
>>>>
>>>> - 'virtio/vsock: set packet's type in send':
>>>>    1) Commit message updated.
>>>>    2) Parameter 'type' from 'virtio_transport_send_credit_update()'
>>>>       also removed in this patch instead of in next.
>>>>
>>>> - 'virtio/vsock: dequeue callback for SOCK_SEQPACKET': SEQPACKET
>>>>    related state wrapped to special struct.
>>>>
>>>> - 'virtio/vsock: update trace event for SEQPACKET': format strings
>>>>    now not broken by new lines.
>>> I left a bunch of comments in the patches, I hope they are easy to fix
>>> :-)
>> Thank you, yes, there are still small fixes.
>
>So one more question, this is final review for this version of patchset and can
>
>prepare next version with fixes? All other patches will reviewed in next version?
>

For me yes, the other patches seem okay, but I would like to see them 
later, with the right order and the last things fixed.

Maybe to merge all this we should wait for the agreement from the specs 
patch.

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
