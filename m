Return-Path: <SRS0=p2bm=JS=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E580C433B4
	for <virtualization@archiver.kernel.org>; Wed, 21 Apr 2021 09:52:34 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 821C261440
	for <virtualization@archiver.kernel.org>; Wed, 21 Apr 2021 09:52:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 821C261440
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 246224068D;
	Wed, 21 Apr 2021 09:52:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uBWYG5pw-XGc; Wed, 21 Apr 2021 09:52:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 367C640691;
	Wed, 21 Apr 2021 09:52:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0622CC000F;
	Wed, 21 Apr 2021 09:52:31 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E7529C000B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Apr 2021 09:52:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D10EB60874
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Apr 2021 09:52:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sXBVKujaMblj
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Apr 2021 09:52:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B58D46089A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Apr 2021 09:52:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1618998745;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NwxZLRTcXC5OvGvzLAau5wtnxa0kL69bqUW5LXiDYks=;
 b=fWOwSFFXj8tl0kRnNrjWhqnvL/t88pnD7+TrgKlWBrbYLzPjfb+4ilkDbw2wTaNBO694JL
 OmL4ucdds0+skNCED1mByGvQm+wq8pyRur5VGcUPkCY7uxzQS4WLgtJp27N94iUwQCpQiP
 e+pUFipmoTGK1OIivSKKjHD0jMvBiMQ=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-547-SKL1QEP1PL-uziJtF-cY9g-1; Wed, 21 Apr 2021 05:52:17 -0400
X-MC-Unique: SKL1QEP1PL-uziJtF-cY9g-1
Received: by mail-ej1-f71.google.com with SMTP id
 bx15-20020a170906a1cfb029037415131f28so5728017ejb.18
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Apr 2021 02:52:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=NwxZLRTcXC5OvGvzLAau5wtnxa0kL69bqUW5LXiDYks=;
 b=WJC1gsHwFLTANzvl7K6Wr6pb7MUoXhwQm0lREXS/bmni1zPND2IaCDeoC2JN26hM3o
 fCj2gFcRvYMh4ge6fFek7jZoSWQPu8s9ds79Lp3jzVuZLYPMCfDa6OaSVte3c0BViIf6
 zgQ0iSC7gfIG6H15e8ASaRJdUswo1ooxon8Gm3mJDx0zpoGNmn86hEO3BysLonU2n3+i
 h2W6qicsxWr6aFLcg+C5FLduN+GuIyGY3f0K2+Ws0+87C1sQq9YByZ4XoPCvWfUrM4BW
 Kd/ePugwtKY4st91IueNyhMgMvTrL4I9Po7DSsyakcjOfuYmlGj2fDIX54jSRrAGp0K0
 /UXw==
X-Gm-Message-State: AOAM530kHNECF0oYNQC8cTMDQ2j46FOMz4ODRPMw3oaVX/hB29DO+4Cq
 E4bv86CPTvaDqhvHvFIAwjLRk4fUVbQ0jafa4ewcjGPLjNhA/p/WzEB15TBw143PHVk+9BnEoHE
 78aPzh6b+3e5fvZCJmQccu68oyDf9F9nzcpjVM1Tcuw==
X-Received: by 2002:a17:906:ff52:: with SMTP id
 zo18mr30698337ejb.298.1618998736472; 
 Wed, 21 Apr 2021 02:52:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzB2TWs/IaLV9bRBCA0/SpDD3KlzXRPfhylvrcMnGywNW0K6wQOPNcsHmJxw78RjLZB+u5T0A==
X-Received: by 2002:a17:906:ff52:: with SMTP id
 zo18mr30698307ejb.298.1618998736227; 
 Wed, 21 Apr 2021 02:52:16 -0700 (PDT)
Received: from steredhat (host-79-34-249-199.business.telecomitalia.it.
 [79.34.249.199])
 by smtp.gmail.com with ESMTPSA id h9sm1836039ejf.10.2021.04.21.02.52.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Apr 2021 02:52:15 -0700 (PDT)
Date: Wed, 21 Apr 2021 11:52:13 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseny Krasnov <arseny.krasnov@kaspersky.com>
Subject: Re: [RFC PATCH v8 00/19] virtio/vsock: introduce SOCK_SEQPACKET
 support
Message-ID: <20210421095213.25hnfi2th7gzyzt2@steredhat>
References: <20210413123954.3396314-1-arseny.krasnov@kaspersky.com>
MIME-Version: 1.0
In-Reply-To: <20210413123954.3396314-1-arseny.krasnov@kaspersky.com>
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
 "David S. Miller" <davem@davemloft.net>, Jorgen Hansen <jhansen@vmware.com>,
 Alexander Popov <alex.popov@linux.com>
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

On Tue, Apr 13, 2021 at 03:39:51PM +0300, Arseny Krasnov wrote:
>	This patchset implements support of SOCK_SEQPACKET for virtio
>transport.
>	As SOCK_SEQPACKET guarantees to save record boundaries, so to
>do it, new bit for field 'flags' was added: SEQ_EOR. This bit is
>set to 1 in last RW packet of message.
>	Now as  packets of one socket are not reordered neither on vsock
>nor on vhost transport layers, such bit allows to restore original
>message on receiver's side. If user's buffer is smaller than message
>length, when all out of size data is dropped.
>	Maximum length of datagram is not limited as in stream socket,
>because same credit logic is used. Difference with stream socket is
>that user is not woken up until whole record is received or error
>occurred. Implementation also supports 'MSG_TRUNC' flags.
>	Tests also implemented.
>
>	Thanks to stsp2@yandex.ru for encouragements and initial design
>recommendations.
>
> Arseny Krasnov (19):
>  af_vsock: update functions for connectible socket
>  af_vsock: separate wait data loop
>  af_vsock: separate receive data loop
>  af_vsock: implement SEQPACKET receive loop
>  af_vsock: implement send logic for SEQPACKET
>  af_vsock: rest of SEQPACKET support
>  af_vsock: update comments for stream sockets
>  virtio/vsock: set packet's type in virtio_transport_send_pkt_info()
>  virtio/vsock: simplify credit update function API
>  virtio/vsock: defines and constants for SEQPACKET
>  virtio/vsock: dequeue callback for SOCK_SEQPACKET
>  virtio/vsock: add SEQPACKET receive logic
>  virtio/vsock: rest of SOCK_SEQPACKET support
>  virtio/vsock: enable SEQPACKET for transport
>  vhost/vsock: enable SEQPACKET for transport
>  vsock/loopback: enable SEQPACKET for transport
>  vsock_test: add SOCK_SEQPACKET tests
>  virtio/vsock: update trace event for SEQPACKET
>  af_vsock: serialize writes to shared socket
>
> drivers/vhost/vsock.c                        |  31 +-
> include/linux/virtio_vsock.h                 |  11 +
> include/net/af_vsock.h                       |   8 +
> .../events/vsock_virtio_transport_common.h   |   5 +-
> include/uapi/linux/virtio_vsock.h            |   9 +
> net/vmw_vsock/af_vsock.c                     | 470 +++++++++++------
> net/vmw_vsock/virtio_transport.c             |  17 +
> net/vmw_vsock/virtio_transport_common.c      | 167 ++++--
> net/vmw_vsock/vsock_loopback.c               |  12 +
> tools/testing/vsock/util.c                   |  32 +-
> tools/testing/vsock/util.h                   |   3 +
> tools/testing/vsock/vsock_test.c             |  63 +++
> 12 files changed, 625 insertions(+), 203 deletions(-)
>
> v7 -> v8:
> General changelog:
> - whole idea is simplified: channel now considered reliable,
>   so SEQ_BEGIN, SEQ_END, 'msg_len' and 'msg_id' were removed.
>   Only thing that is used to mark end of message is bit in
>   'flags' field of packet header: VIRTIO_VSOCK_SEQ_EOR. Packet
>   with such bit set to 1 means, that this is last packet of
>   message.
>
> - POSIX MSG_EOR support is removed, as there is no exact
>   description how it works.

It would be nice to support it, I'll try to see if I can find anything.

I just reviewed the series. I think the most important things to fix are 
the `seqpacket_allow` stored in the struct virtio_transport that is 
wrong IMHO, and use cpu_to_le32()/le32_to_cpu() to access the flags.

I also left some other comments around.

Thanks,
Stefano

>
> - all changes to 'include/uapi/linux/virtio_vsock.h' moved
>   to dedicated patch, as these changes linked with patch to
>   spec.
>
> - patch 'virtio/vsock: SEQPACKET feature bit support' now merged
>   to 'virtio/vsock: setup SEQPACKET ops for transport'.
>
> - patch 'vhost/vsock: SEQPACKET feature bit support' now merged
>   to 'vhost/vsock: setup SEQPACKET ops for transport'.
>
> Per patch changelog:
>  see every patch after '---' line.
>
> v6 -> v7:
> General changelog:
> - virtio transport callback for message length now removed
>   from transport. Length of record is returned by dequeue
>   callback.
>
> - function which tries to get message length now returns 0
>   when rx queue is empty. Also length of current message in
>   progress is set to 0, when message processed or error
>   happens.
>
> - patches for virtio feature bit moved after patches with
>   transport ops.
>
> Per patch changelog:
>  see every patch after '---' line.
>
> v5 -> v6:
> General changelog:
> - virtio transport specific callbacks which send SEQ_BEGIN or
>   SEQ_END now hidden inside virtio transport. Only enqueue,
>   dequeue and record length callbacks are provided by transport.
>
> - virtio feature bit for SEQPACKET socket support introduced:
>   VIRTIO_VSOCK_F_SEQPACKET.
>
> - 'msg_cnt' field in 'struct virtio_vsock_seq_hdr' renamed to
>   'msg_id' and used as id.
>
> Per patch changelog:
> - 'af_vsock: separate wait data loop':
>    1) Commit message updated.
>    2) 'prepare_to_wait()' moved inside while loop(thanks to
>      Jorgen Hansen).
>    Marked 'Reviewed-by' with 1), but as 2) I removed R-b.
>
> - 'af_vsock: separate receive data loop': commit message
>    updated.
>    Marked 'Reviewed-by' with that fix.
>
> - 'af_vsock: implement SEQPACKET receive loop': style fixes.
>
> - 'af_vsock: rest of SEQPACKET support':
>    1) 'module_put()' added when transport callback check failed.
>    2) Now only 'seqpacket_allow()' callback called to check
>       support of SEQPACKET by transport.
>
> - 'af_vsock: update comments for stream sockets': commit message
>    updated.
>    Marked 'Reviewed-by' with that fix.
>
> - 'virtio/vsock: set packet's type in send':
>    1) Commit message updated.
>    2) Parameter 'type' from 'virtio_transport_send_credit_update()'
>       also removed in this patch instead of in next.
>
> - 'virtio/vsock: dequeue callback for SOCK_SEQPACKET': SEQPACKET
>    related state wrapped to special struct.
>
> - 'virtio/vsock: update trace event for SEQPACKET': format strings
>    now not broken by new lines.
>
> v4 -> v5:
> - patches reorganized:
>   1) Setting of packet's type in 'virtio_transport_send_pkt_info()'
>      is moved to separate patch.
>   2) Simplifying of 'virtio_transport_send_credit_update()' is
>      moved to separate patch and before main virtio/vsock patches.
> - style problem fixed
> - in 'af_vsock: separate receive data loop' extra 'release_sock()'
>   removed
> - added trace event fields for SEQPACKET
> - in 'af_vsock: separate wait data loop':
>   1) 'vsock_wait_data()' removed 'goto out;'
>   2) Comment for invalid data amount is changed.
> - in 'af_vsock: rest of SEQPACKET support', 'new_transport' pointer
>   check is moved after 'try_module_get()'
> - in 'af_vsock: update comments for stream sockets', 'connect-oriented'
>   replaced with 'connection-oriented'
> - in 'loopback/vsock: setup SEQPACKET ops for transport',
>   'loopback/vsock' replaced with 'vsock/loopback'
>
> v3 -> v4:
> - SEQPACKET specific metadata moved from packet header to payload
>   and called 'virtio_vsock_seq_hdr'
> - record integrity check:
>   1) SEQ_END operation was added, which marks end of record.
>   2) Both SEQ_BEGIN and SEQ_END carries counter which is incremented
>      on every marker send.
> - af_vsock.c: socket operations for STREAM and SEQPACKET call same
>   functions instead of having own "gates" differs only by names:
>   'vsock_seqpacket/stream_getsockopt()' now replaced with
>   'vsock_connectible_getsockopt()'.
> - af_vsock.c: 'seqpacket_dequeue' callback returns error and flag that
>   record ready. There is no need to return number of copied bytes,
>   because case when record received successfully is checked at virtio
>   transport layer, when SEQ_END is processed. Also user doesn't need
>   number of copied bytes, because 'recv()' from SEQPACKET could return
>   error, length of users's buffer or length of whole record(both are
>   known in af_vsock.c).
> - af_vsock.c: both wait loops in af_vsock.c(for data and space) moved
>   to separate functions because now both called from several places.
> - af_vsock.c: 'vsock_assign_transport()' checks that 'new_transport'
>   pointer is not NULL and returns 'ESOCKTNOSUPPORT' instead of 'ENODEV'
>   if failed to use transport.
> - tools/testing/vsock/vsock_test.c: rename tests
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
