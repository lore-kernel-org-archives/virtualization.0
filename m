Return-Path: <SRS0=+Z4V=G5=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43A3EC433DB
	for <virtualization@archiver.kernel.org>; Tue, 26 Jan 2021 11:23:47 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C035B23104
	for <virtualization@archiver.kernel.org>; Tue, 26 Jan 2021 11:23:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C035B23104
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 110F52043B;
	Tue, 26 Jan 2021 11:23:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fG26Vimt7-fw; Tue, 26 Jan 2021 11:23:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 4A387203F1;
	Tue, 26 Jan 2021 11:23:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3CF40C08A1;
	Tue, 26 Jan 2021 11:23:44 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 805A8C013A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Jan 2021 11:23:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 67494844BA
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Jan 2021 11:23:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id X6BX8-HROOaw
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Jan 2021 11:23:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 37B1F84481
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Jan 2021 11:23:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1611660218;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JTt2fKtk93GppUvATa0pV3yHgt515EpEGR8mjlKiGYA=;
 b=VSnJZTk5M1/GEEnUBMNtfaCYhFXJ4wRStZIsEm0Jthn90ArDzupO1CnaQdg2F/SYD90Yrx
 SukZiLA93awC0TzL8/vWB0j8LqDOZl8YWx3fGyuj36WGuoK7TsGoNJNMjtTjP9Rr2EmIG5
 oqd/OECL/zS11RNXsriwRKDHITg7nBk=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-417-Z_G5npKIMuuuDZb0f9X0YA-1; Tue, 26 Jan 2021 06:23:37 -0500
X-MC-Unique: Z_G5npKIMuuuDZb0f9X0YA-1
Received: by mail-ed1-f69.google.com with SMTP id x13so9249601edi.7
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Jan 2021 03:23:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=JTt2fKtk93GppUvATa0pV3yHgt515EpEGR8mjlKiGYA=;
 b=KHm1/mrUSluTByDuZ3ef9NLlWHL6wBNTqajg8VILsxQhpUB3isfwKzUcZWCgy950eq
 Rm3Jnur0ghIbi0OolGQTnN/Kv1rz2Lb/h33tHM77j2rHf4/62P+jU0H6Rn8qQSnK0wx6
 QJJKjbUB78r6wwOz4zPqodsM1SBOroNPb3VqGkvJ6QGxNQNAGTccjDsV2f4Lq5RZOIMN
 +MGrjcosl4BZkEdedbkWwhzzX2/SgRWXFPhqLkOM7be2iJJRbfKRA0YRL8YPlgUHXArW
 Az7BqSAzVmAjIO2NPtVMj5r9y1WYln9oeAKbVfDPTEGz8YG9LxlDQPHsDaHxR1c2xzVP
 7Y4g==
X-Gm-Message-State: AOAM531OV5o1IYIr9lyu62204jpqpy5ItnYFEpTLjPn7j7fkUdPrHzqw
 cfw/JUZOO87SOfJWIJrbBNkI+2hL6TC7nWJhwg6ymWCrQRtneMLVKd/XFSHMqLYNjXCHgVCiXKE
 v9KosuD8xTYlpHKLF+vn+ZziwnfbzVCoBMwT9VKxApQ==
X-Received: by 2002:a17:906:ae42:: with SMTP id
 lf2mr2986693ejb.487.1611660215814; 
 Tue, 26 Jan 2021 03:23:35 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxaADKffvaOLAwo/NSoh7H/haFhO7LTo/Xzq1n4nH+wZ/VXL/AKBofvf7/ECClCE+fB2NwxOg==
X-Received: by 2002:a17:906:ae42:: with SMTP id
 lf2mr2986681ejb.487.1611660215554; 
 Tue, 26 Jan 2021 03:23:35 -0800 (PST)
Received: from steredhat (host-79-34-249-199.business.telecomitalia.it.
 [79.34.249.199])
 by smtp.gmail.com with ESMTPSA id da26sm12273587edb.36.2021.01.26.03.23.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Jan 2021 03:23:34 -0800 (PST)
Date: Tue, 26 Jan 2021 12:23:32 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseny Krasnov <arseny.krasnov@kaspersky.com>
Subject: Re: [RFC PATCH v3 00/13] virtio/vsock: introduce SOCK_SEQPACKET
 support
Message-ID: <20210126112332.bykmpexzcri7xi2j@steredhat>
References: <20210125110903.597155-1-arseny.krasnov@kaspersky.com>
MIME-Version: 1.0
In-Reply-To: <20210125110903.597155-1-arseny.krasnov@kaspersky.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Andra Paraschiv <andraprs@amazon.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Jeff Vander Stoep <jeffv@google.com>,
 stsp2@yandex.ru, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, oxffffaa@gmail.com,
 netdev@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>, Colin Ian King <colin.king@canonical.com>,
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

Hi Arseny,
thanks for this new series!
I'm a bit busy but I hope to review it tomorrow or on Thursday.

Stefano

On Mon, Jan 25, 2021 at 02:09:00PM +0300, Arseny Krasnov wrote:
>	This patchset impelements support of SOCK_SEQPACKET for virtio
>transport.
>	As SOCK_SEQPACKET guarantees to save record boundaries, so to
>do it, new packet operation was added: it marks start of record (with
>record length in header), such packet doesn't carry any data.  To send
>record, packet with start marker is sent first, then all data is sent
>as usual 'RW' packets. On receiver's side, length of record is known
>from packet with start record marker. Now as  packets of one socket
>are not reordered neither on vsock nor on vhost transport layers, such
>marker allows to restore original record on receiver's side. If user's
>buffer is smaller that record length, when all out of size data is
>dropped.
>	Maximum length of datagram is not limited as in stream socket,
>because same credit logic is used. Difference with stream socket is
>that user is not woken up until whole record is received or error
>occurred. Implementation also supports 'MSG_EOR' and 'MSG_TRUNC' flags.
>	Tests also implemented.
>
> Arseny Krasnov (13):
>  af_vsock: prepare for SOCK_SEQPACKET support
>  af_vsock: prepare 'vsock_connectible_recvmsg()'
>  af_vsock: implement SEQPACKET rx loop
>  af_vsock: implement send logic for SOCK_SEQPACKET
>  af_vsock: rest of SEQPACKET support
>  af_vsock: update comments for stream sockets
>  virtio/vsock: dequeue callback for SOCK_SEQPACKET
>  virtio/vsock: fetch length for SEQPACKET record
>  virtio/vsock: add SEQPACKET receive logic
>  virtio/vsock: rest of SOCK_SEQPACKET support
>  virtio/vsock: setup SEQPACKET ops for transport
>  vhost/vsock: setup SEQPACKET ops for transport
>  vsock_test: add SOCK_SEQPACKET tests
>
> drivers/vhost/vsock.c                   |   7 +-
> include/linux/virtio_vsock.h            |  12 +
> include/net/af_vsock.h                  |   6 +
> include/uapi/linux/virtio_vsock.h       |   9 +
> net/vmw_vsock/af_vsock.c                | 543 ++++++++++++++++------
> net/vmw_vsock/virtio_transport.c        |   4 +
> net/vmw_vsock/virtio_transport_common.c | 295 ++++++++++--
> tools/testing/vsock/util.c              |  32 +-
> tools/testing/vsock/util.h              |   3 +
> tools/testing/vsock/vsock_test.c        | 126 +++++
> 10 files changed, 862 insertions(+), 175 deletions(-)
>
> TODO:
> - Support for record integrity control. As transport could drop some
>   packets, something like "record-id" and record end marker need to
>   be implemented. Idea is that SEQ_BEGIN packet carries both record
>   length and record id, end marker(let it be SEQ_END) carries only
>   record id. To be sure that no one packet was lost, receiver checks
>   length of data between SEQ_BEGIN and SEQ_END(it must be same with
>   value in SEQ_BEGIN) and record ids of SEQ_BEGIN and SEQ_END(this
>   means that both markers were not dropped. I think that easiest way
>   to implement record id for SEQ_BEGIN is to reuse another field of
>   packet header(SEQ_BEGIN already uses 'flags' as record length).For
>   SEQ_END record id could be stored in 'flags'.
>     Another way to implement it, is to move metadata of both SEQ_END
>   and SEQ_BEGIN to payload. But this approach has problem, because
>   if we move something to payload, such payload is accounted by
>   credit logic, which fragments payload, while payload with record
>   length and id couldn't be fragmented. One way to overcome it is to
>   ignore credit update for SEQ_BEGIN/SEQ_END packet.Another solution
>   is to update 'stream_has_space()' function: current implementation
>   return non-zero when at least 1 byte is allowed to use,but updated
>   version will have extra argument, which is needed length. For 'RW'
>   packet this argument is 1, for SEQ_BEGIN it is sizeof(record len +
>   record id) and for SEQ_END it is sizeof(record id).
>
> - What to do, when server doesn't support SOCK_SEQPACKET. In current
>   implementation RST is replied in the same way when listening port
>   is not found. I think that current RST is enough,because case when
>   server doesn't support SEQ_PACKET is same when listener missed(e.g.
>   no listener in both cases).
>
> v2 -> v3:
> - patches reorganized: split for prepare and implementation patches
> - local variables are declared in "Reverse Christmas tree" manner
> - virtio_transport_common.c: valid leXX_to_cpu() for vsock header
>   fields access
> - af_vsock.c: 'vsock_connectible_*sockopt()' added as shared code
>   between stream and seqpacket sockets.
> - af_vsock.c: loops in '__vsock_*_recvmsg()' refactored.
> - af_vsock.c: 'vsock_wait_data()' refactored.
>
> v1 -> v2:
> - patches reordered: af_vsock.c related changes now before virtio vsock
> - patches reorganized: more small patches, where +/- are not mixed
> - tests for SOCK_SEQPACKET added
> - all commit messages updated
> - af_vsock.c: 'vsock_pre_recv_check()' inlined to
>   'vsock_connectible_recvmsg()'
> - af_vsock.c: 'vsock_assign_transport()' returns ENODEV if transport
>   was not found
> - virtio_transport_common.c: transport callback for seqpacket dequeue
> - virtio_transport_common.c: simplified
>   'virtio_transport_recv_connected()'
> - virtio_transport_common.c: send reset on socket and packet type
>			      mismatch.
>
>Signed-off-by: Arseny Krasnov <arseny.krasnov@kaspersky.com>
>
>-- 
>2.25.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
