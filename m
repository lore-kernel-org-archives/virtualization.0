Return-Path: <SRS0=8NGF=HJ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83819C433DB
	for <virtualization@archiver.kernel.org>; Sun,  7 Feb 2021 16:20:40 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0CBD964E3E
	for <virtualization@archiver.kernel.org>; Sun,  7 Feb 2021 16:20:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CBD964E3E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id C8DAA8522E;
	Sun,  7 Feb 2021 16:20:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YPvnUvbEsURJ; Sun,  7 Feb 2021 16:20:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id BEB808502A;
	Sun,  7 Feb 2021 16:20:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AA368C0174;
	Sun,  7 Feb 2021 16:20:38 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1EDC7C013A
 for <virtualization@lists.linux-foundation.org>;
 Sun,  7 Feb 2021 16:20:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 0D0C886FF1
 for <virtualization@lists.linux-foundation.org>;
 Sun,  7 Feb 2021 16:20:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hL9S1uQjNdlU
 for <virtualization@lists.linux-foundation.org>;
 Sun,  7 Feb 2021 16:20:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by hemlock.osuosl.org (Postfix) with ESMTPS id A175686FEC
 for <virtualization@lists.linux-foundation.org>;
 Sun,  7 Feb 2021 16:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1612714835;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FZqyDugOGOW0JQq4JTJQ1tDgFP/xH2dXqvp4jbAWnlA=;
 b=UE+L+sBZCeVj+sisreBR7owLyYbjK54nwEpVKGFG3tESiDOZeRFlIpS6TnoZw9Xtxhetm1
 PwzNUJ2VCmytVTxMAJw8IQOQirKkO132hwEBYItAm6JmWABebkBwMYuurzcdD+RtPyt5s/
 lYTm+cO3+ugeLfT8vZwTgPw63UYu5eY=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-154-ZjQgnMPKNs-J_kvpSk6fCg-1; Sun, 07 Feb 2021 11:20:31 -0500
X-MC-Unique: ZjQgnMPKNs-J_kvpSk6fCg-1
Received: by mail-ed1-f71.google.com with SMTP id b1so11890095edt.22
 for <virtualization@lists.linux-foundation.org>;
 Sun, 07 Feb 2021 08:20:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=FZqyDugOGOW0JQq4JTJQ1tDgFP/xH2dXqvp4jbAWnlA=;
 b=gtssAww8SRoAKaZGRNEsmszU9ersimRg2tE7+J8qoR7EoO/YZuXJrEFCa+n1zsw0XV
 xB2H+7zw9fKczmu8JOQ+CUZlTk2RjgEAolYsXLwo7s/qf826F05+WB4gV3IszGKrxpSk
 SrGQDjvRTe/9RtfR0ypUah6xaduR8INPC5JC8iLvkXizEXEGZl2BTj7YV3Dvj038Kggm
 LywPjgnxwnMLJuIzt+zyvp33k/4iAumsJOw+xOVYnloCclITvzGyhDuSmiGcn9uRNDpH
 LdBpZc3M/jch+aOF5TJ4TDMAlGwvbaVBzrL8geobiQNB3NPdRtsOD+S2sYyCQk0XGRtj
 6EiA==
X-Gm-Message-State: AOAM530zmaLJLqxN+mWfSIQtmVprBI8PH4hctyi19YkKl5B8QfrTxsJI
 s+/wJwJmsNxOYlssbZBcDPhAg77hqo3So3R9pRPK4k2t2lZ+Iuc+S28FDpeMdKW5s270x/Tp492
 8sf7X3oo0cEx6Br5S1O4OdNVSSXb0qhuqnC0CDW8b8w==
X-Received: by 2002:aa7:cb0d:: with SMTP id s13mr13143844edt.221.1612714830318; 
 Sun, 07 Feb 2021 08:20:30 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxSdcDNfe71ti67oDmkvTssos1+0OxTMKiTicFwRsqODDXrK/rf1JmpCvBGtLbnaWdb2ccmlQ==
X-Received: by 2002:aa7:cb0d:: with SMTP id s13mr13143828edt.221.1612714830149; 
 Sun, 07 Feb 2021 08:20:30 -0800 (PST)
Received: from redhat.com (bzq-79-180-2-31.red.bezeqint.net. [79.180.2.31])
 by smtp.gmail.com with ESMTPSA id w3sm7043867eja.52.2021.02.07.08.20.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 07 Feb 2021 08:20:29 -0800 (PST)
Date: Sun, 7 Feb 2021 11:20:25 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Arseny Krasnov <arseny.krasnov@kaspersky.com>
Subject: Re: [RFC PATCH v4 00/17] virtio/vsock: introduce SOCK_SEQPACKET
 support
Message-ID: <20210207111954-mutt-send-email-mst@kernel.org>
References: <20210207151259.803917-1-arseny.krasnov@kaspersky.com>
MIME-Version: 1.0
In-Reply-To: <20210207151259.803917-1-arseny.krasnov@kaspersky.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Andra Paraschiv <andraprs@amazon.com>, kvm@vger.kernel.org,
 netdev@vger.kernel.org, stsp2@yandex.ru, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, oxffffaa@gmail.com,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Colin Ian King <colin.king@canonical.com>, Jakub Kicinski <kuba@kernel.org>,
 Alexander Popov <alex.popov@linux.com>,
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

On Sun, Feb 07, 2021 at 06:12:56PM +0300, Arseny Krasnov wrote:
> 	This patchset impelements support of SOCK_SEQPACKET for virtio
> transport.
> 	As SOCK_SEQPACKET guarantees to save record boundaries, so to
> do it, two new packet operations were added: first for start of record
>  and second to mark end of record(SEQ_BEGIN and SEQ_END later). Also,
> both operations carries metadata - to maintain boundaries and payload
> integrity. Metadata is introduced by adding special header with two
> fields - message count and message length:
> 
> 	struct virtio_vsock_seq_hdr {
> 		__le32  msg_cnt;
> 		__le32  msg_len;
> 	} __attribute__((packed));
> 
> 	This header is transmitted as payload of SEQ_BEGIN and SEQ_END
> packets(buffer of second virtio descriptor in chain) in the same way as
> data transmitted in RW packets. Payload was chosen as buffer for this
> header to avoid touching first virtio buffer which carries header of
> packet, because someone could check that size of this buffer is equal
> to size of packet header. To send record, packet with start marker is
> sent first(it's header contains length of record and counter), then
> counter is incremented and all data is sent as usual 'RW' packets and
> finally SEQ_END is sent(it also carries counter of message, which is
> counter of SEQ_BEGIN + 1), also after sedning SEQ_END counter is
> incremented again. On receiver's side, length of record is known from
> packet with start record marker. To check that no packets were dropped
> by transport, counters of two sequential SEQ_BEGIN and SEQ_END are
> checked(counter of SEQ_END must be bigger that counter of SEQ_BEGIN by
> 1) and length of data between two markers is compared to length in
> SEQ_BEGIN header.
> 	Now as  packets of one socket are not reordered neither on
> vsock nor on vhost transport layers, such markers allows to restore
> original record on receiver's side. If user's buffer is smaller that
> record length, when all out of size data is dropped.
> 	Maximum length of datagram is not limited as in stream socket,
> because same credit logic is used. Difference with stream socket is
> that user is not woken up until whole record is received or error
> occurred. Implementation also supports 'MSG_EOR' and 'MSG_TRUNC' flags.
> 	Tests also implemented.
> 
>  Arseny Krasnov (17):
>   af_vsock: update functions for connectible socket
>   af_vsock: separate wait data loop
>   af_vsock: separate receive data loop
>   af_vsock: implement SEQPACKET receive loop
>   af_vsock: separate wait space loop
>   af_vsock: implement send logic for SEQPACKET
>   af_vsock: rest of SEQPACKET support
>   af_vsock: update comments for stream sockets
>   virtio/vsock: dequeue callback for SOCK_SEQPACKET
>   virtio/vsock: fetch length for SEQPACKET record
>   virtio/vsock: add SEQPACKET receive logic
>   virtio/vsock: rest of SOCK_SEQPACKET support
>   virtio/vsock: setup SEQPACKET ops for transport
>   vhost/vsock: setup SEQPACKET ops for transport
>   vsock_test: add SOCK_SEQPACKET tests
>   loopback/vsock: setup SEQPACKET ops for transport
>   virtio/vsock: simplify credit update function API
> 
>  drivers/vhost/vsock.c                   |   8 +-
>  include/linux/virtio_vsock.h            |  15 +
>  include/net/af_vsock.h                  |   9 +
>  include/uapi/linux/virtio_vsock.h       |  16 +
>  net/vmw_vsock/af_vsock.c                | 588 +++++++++++++++-------
>  net/vmw_vsock/virtio_transport.c        |   5 +
>  net/vmw_vsock/virtio_transport_common.c | 316 ++++++++++--
>  net/vmw_vsock/vsock_loopback.c          |   5 +
>  tools/testing/vsock/util.c              |  32 +-
>  tools/testing/vsock/util.h              |   3 +
>  tools/testing/vsock/vsock_test.c        | 126 +++++
>  11 files changed, 895 insertions(+), 228 deletions(-)
> 
>  TODO:
>  - What to do, when server doesn't support SOCK_SEQPACKET. In current
>    implementation RST is replied in the same way when listening port
>    is not found. I think that current RST is enough,because case when
>    server doesn't support SEQ_PACKET is same when listener missed(e.g.
>    no listener in both cases).

   - virtio spec patch

>  v3 -> v4:
>  - callbacks for loopback transport
>  - SEQPACKET specific metadata moved from packet header to payload
>    and called 'virtio_vsock_seq_hdr'
>  - record integrity check:
>    1) SEQ_END operation was added, which marks end of record.
>    2) Both SEQ_BEGIN and SEQ_END carries counter which is incremented
>       on every marker send.
>  - af_vsock.c: socket operations for STREAM and SEQPACKET call same
>    functions instead of having own "gates" differs only by names:
>    'vsock_seqpacket/stream_getsockopt()' now replaced with
>    'vsock_connectible_getsockopt()'.
>  - af_vsock.c: 'seqpacket_dequeue' callback returns error and flag that
>    record ready. There is no need to return number of copied bytes,
>    because case when record received successfully is checked at virtio
>    transport layer, when SEQ_END is processed. Also user doesn't need
>    number of copied bytes, because 'recv()' from SEQPACKET could return
>    error, length of users's buffer or length of whole record(both are
>    known in af_vsock.c).
>  - af_vsock.c: both wait loops in af_vsock.c(for data and space) moved
>    to separate functions because now both called from several places.
>  - af_vsock.c: 'vsock_assign_transport()' checks that 'new_transport'
>    pointer is not NULL and returns 'ESOCKTNOSUPPORT' instead of 'ENODEV'
>    if failed to use transport.
>  - tools/testing/vsock/vsock_test.c: rename tests
> 
>  v2 -> v3:
>  - patches reorganized: split for prepare and implementation patches
>  - local variables are declared in "Reverse Christmas tree" manner
>  - virtio_transport_common.c: valid leXX_to_cpu() for vsock header
>    fields access
>  - af_vsock.c: 'vsock_connectible_*sockopt()' added as shared code
>    between stream and seqpacket sockets.
>  - af_vsock.c: loops in '__vsock_*_recvmsg()' refactored.
>  - af_vsock.c: 'vsock_wait_data()' refactored.
> 
>  v1 -> v2:
>  - patches reordered: af_vsock.c related changes now before virtio vsock
>  - patches reorganized: more small patches, where +/- are not mixed
>  - tests for SOCK_SEQPACKET added
>  - all commit messages updated
>  - af_vsock.c: 'vsock_pre_recv_check()' inlined to
>    'vsock_connectible_recvmsg()'
>  - af_vsock.c: 'vsock_assign_transport()' returns ENODEV if transport
>    was not found
>  - virtio_transport_common.c: transport callback for seqpacket dequeue
>  - virtio_transport_common.c: simplified
>    'virtio_transport_recv_connected()'
>  - virtio_transport_common.c: send reset on socket and packet type
> 			      mismatch.
> 
> -- 
> 2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
