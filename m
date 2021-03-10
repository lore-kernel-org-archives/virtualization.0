Return-Path: <SRS0=SHSW=II=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68054C433E0
	for <virtualization@archiver.kernel.org>; Wed, 10 Mar 2021 10:06:17 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC20D64FDD
	for <virtualization@archiver.kernel.org>; Wed, 10 Mar 2021 10:06:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC20D64FDD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4271684362;
	Wed, 10 Mar 2021 10:06:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ed1WFHTIpytL; Wed, 10 Mar 2021 10:06:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8B56284328;
	Wed, 10 Mar 2021 10:06:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 622A1C000B;
	Wed, 10 Mar 2021 10:06:14 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B7BCBC0001
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Mar 2021 10:06:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id AE1C84EC61
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Mar 2021 10:06:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Vyy5VY5Xruq2
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Mar 2021 10:06:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id F213D4834C
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Mar 2021 10:06:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1615370769;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7CRQ300l9ojIfUbCmT+C5ubXUEMhIVQ36tvLGt6fXYw=;
 b=C5jZV8UJhZohPRVKyTTCOdViy71zfkxoKoYUQBgBRAfbKx5IShBam6jyCiwT2TX+d0kmn4
 vDnKuGkugzAv8j0nxd0CbEw+zESoHKnaGQ4rYybz8dH9YqpObWJqwBArtiZ1+IL0M/24T2
 gqEC+pM7GSWTlVSK3pxjMqFKM4hMdac=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-408-JzaBeEbGN3GLyJc94iGpPQ-1; Wed, 10 Mar 2021 05:06:07 -0500
X-MC-Unique: JzaBeEbGN3GLyJc94iGpPQ-1
Received: by mail-wr1-f69.google.com with SMTP id v13so7754324wrs.21
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Mar 2021 02:06:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=7CRQ300l9ojIfUbCmT+C5ubXUEMhIVQ36tvLGt6fXYw=;
 b=KIFn1scKUSdZbr/Dgi+6KFBWyph8Jw/X21HCqFeHyKY7oY4jeVVHD/hivMR38Qo9hA
 d7/I/2TDLekgbbC34VLo9tWb26+ONelflR73HhlifKTrNSszTR7EY30TJxWn8MP407Lh
 IcG1uAklUzgrhS+6TjhuDE5tRF4kfytjJrcYFIgjwtM+YabewhoLt8Z1ubB6/fuNpW/2
 4EytvnF82KFSqmvptgMNpBBXVC4HHLUtI3tXYqfo+ie3c7emQSERvdxiAOwJvfnUPADk
 Ai3egd9+wBzO5ONc2yb/eTMQ+b/sc/4OGyJh0H30ERYKVx4s+ZcQmNI+3/Yn+WJUI94B
 s6ig==
X-Gm-Message-State: AOAM532ZOCb24y04ZgbU6eEOKjDE9+U7gaLKRDNcECZNljXpPnK0nmNd
 5j14AqWhBYjeODnbqK5Yl3Js0FkUrQWZwlp9WgKeKaONNX0nZbiHIhzonkvG7nH7gTVfBij0tpU
 FxWeEkdJuFbYPABcPb6SFeFJcXAu4Jwd4laotJQ203w==
X-Received: by 2002:a5d:42ca:: with SMTP id t10mr2638806wrr.274.1615370766254; 
 Wed, 10 Mar 2021 02:06:06 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxukHZJqVBikEoxvoszKeSjN05neMT7KJmv/Z9q2En3QSA5YMz/ssw5amFoPjs73pTibvqdNQ==
X-Received: by 2002:a5d:42ca:: with SMTP id t10mr2638770wrr.274.1615370765973; 
 Wed, 10 Mar 2021 02:06:05 -0800 (PST)
Received: from steredhat (host-79-34-249-199.business.telecomitalia.it.
 [79.34.249.199])
 by smtp.gmail.com with ESMTPSA id b17sm27828299wrt.17.2021.03.10.02.06.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Mar 2021 02:06:05 -0800 (PST)
Date: Wed, 10 Mar 2021 11:06:03 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseny Krasnov <arseny.krasnov@kaspersky.com>
Subject: Re: [RFC PATCH v6 00/22] virtio/vsock: introduce SOCK_SEQPACKET
 support
Message-ID: <20210310100603.rfhpy4uglkb6oxez@steredhat>
References: <20210307175722.3464068-1-arseny.krasnov@kaspersky.com>
MIME-Version: 1.0
In-Reply-To: <20210307175722.3464068-1-arseny.krasnov@kaspersky.com>
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

Hi Arseny,
thanks for this new version.

It's a busy week for me, but I hope to review this series by the end of 
this week :-)

Thanks,
Stefano

On Sun, Mar 07, 2021 at 08:57:19PM +0300, Arseny Krasnov wrote:
>	This patchset implements support of SOCK_SEQPACKET for virtio
>transport.
>	As SOCK_SEQPACKET guarantees to save record boundaries, so to
>do it, two new packet operations were added: first for start of record
> and second to mark end of record(SEQ_BEGIN and SEQ_END later). Also,
>both operations carries metadata - to maintain boundaries and payload
>integrity. Metadata is introduced by adding special header with two
>fields - message id and message length:
>
>	struct virtio_vsock_seq_hdr {
>		__le32  msg_id;
>		__le32  msg_len;
>	} __attribute__((packed));
>
>	This header is transmitted as payload of SEQ_BEGIN and SEQ_END
>packets(buffer of second virtio descriptor in chain) in the same way as
>data transmitted in RW packets. Payload was chosen as buffer for this
>header to avoid touching first virtio buffer which carries header of
>packet, because someone could check that size of this buffer is equal
>to size of packet header. To send record, packet with start marker is
>sent first(it's header carries length of record and id),then all data
>is sent as usual 'RW' packets and finally SEQ_END is sent(it carries
>id of message, which is equal to id of SEQ_BEGIN), also after sending
>SEQ_END id is incremented. On receiver's side,size of record is known
>from packet with start record marker. To check that no packets were
>dropped by transport, 'msg_id's of two sequential SEQ_BEGIN and SEQ_END
>are checked to be equal and length of data between two markers is
>compared to then length in SEQ_BEGIN header.
>	Now as  packets of one socket are not reordered neither on
>vsock nor on vhost transport layers, such markers allows to restore
>original record on receiver's side. If user's buffer is smaller that
>record length, when all out of size data is dropped.
>	Maximum length of datagram is not limited as in stream socket,
>because same credit logic is used. Difference with stream socket is
>that user is not woken up until whole record is received or error
>occurred. Implementation also supports 'MSG_EOR' and 'MSG_TRUNC' flags.
>	Tests also implemented.
>
>	Thanks to stsp2@yandex.ru for encouragements and initial design
>recommendations.
>
> Arseny Krasnov (22):
>  af_vsock: update functions for connectible socket
>  af_vsock: separate wait data loop
>  af_vsock: separate receive data loop
>  af_vsock: implement SEQPACKET receive loop
>  af_vsock: separate wait space loop
>  af_vsock: implement send logic for SEQPACKET
>  af_vsock: rest of SEQPACKET support
>  af_vsock: update comments for stream sockets
>  virtio/vsock: set packet's type in virtio_transport_send_pkt_info()
>  virtio/vsock: simplify credit update function API
>  virtio/vsock: dequeue callback for SOCK_SEQPACKET
>  virtio/vsock: fetch length for SEQPACKET record
>  virtio/vsock: add SEQPACKET receive logic
>  virtio/vsock: rest of SOCK_SEQPACKET support
>  virtio/vsock: SEQPACKET feature bit
>  vhost/vsock: SEQPACKET feature bit support
>  virtio/vsock: SEQPACKET feature bit support
>  virtio/vsock: setup SEQPACKET ops for transport
>  vhost/vsock: setup SEQPACKET ops for transport
>  vsock/loopback: setup SEQPACKET ops for transport
>  vsock_test: add SOCK_SEQPACKET tests
>  virtio/vsock: update trace event for SEQPACKET
>
> drivers/vhost/vsock.c                        |  22 +-
> include/linux/virtio_vsock.h                 |  22 +
> include/net/af_vsock.h                       |  10 +
> .../events/vsock_virtio_transport_common.h   |  48 +-
> include/uapi/linux/virtio_vsock.h            |  19 +
> net/vmw_vsock/af_vsock.c                     | 589 +++++++++++------
> net/vmw_vsock/virtio_transport.c             |  18 +
> net/vmw_vsock/virtio_transport_common.c      | 364 ++++++++--
> net/vmw_vsock/vsock_loopback.c               |  13 +
> tools/testing/vsock/util.c                   |  32 +-
> tools/testing/vsock/util.h                   |   3 +
> tools/testing/vsock/vsock_test.c             | 126 ++++
> 12 files changed, 1013 insertions(+), 253 deletions(-)
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
