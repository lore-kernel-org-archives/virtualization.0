Return-Path: <SRS0=SKE2=N3=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 883D9C433EF
	for <virtualization@archiver.kernel.org>; Sun,  5 Sep 2021 15:55:40 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2DCA960F56
	for <virtualization@archiver.kernel.org>; Sun,  5 Sep 2021 15:55:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2DCA960F56
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id EC0CA600BA;
	Sun,  5 Sep 2021 15:55:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iNdoIuLvg7F6; Sun,  5 Sep 2021 15:55:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 8237D6062B;
	Sun,  5 Sep 2021 15:55:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5A9D8C0010;
	Sun,  5 Sep 2021 15:55:38 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 87F4EC000E
 for <virtualization@lists.linux-foundation.org>;
 Sun,  5 Sep 2021 15:55:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6A6BE6062B
 for <virtualization@lists.linux-foundation.org>;
 Sun,  5 Sep 2021 15:55:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Gq5oZvqZmUSJ
 for <virtualization@lists.linux-foundation.org>;
 Sun,  5 Sep 2021 15:55:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8EB00600BA
 for <virtualization@lists.linux-foundation.org>;
 Sun,  5 Sep 2021 15:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1630857335;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FkqlDLwxY15uPA5cvtZn8WB/ij23mnSGY7u9OAsR1+Q=;
 b=ZreeJDtQFQ97sWJ8IqJ6oMeaMyTIBtayt106+IY4k/ManPFj37gxcF3cLasG97DVNhYeDD
 AUMIPizhGDl/GiI4kQluc6khIvv7DoPVcabJSfHxyjganJX1JIvBCvEO/inKNSJCHnzgQ9
 he3h6fdujWc/SJvZMwrITxu4UdWnMRk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-393-VNn3YeEpPhesTahkD5na9Q-1; Sun, 05 Sep 2021 11:55:32 -0400
X-MC-Unique: VNn3YeEpPhesTahkD5na9Q-1
Received: by mail-wm1-f70.google.com with SMTP id
 r4-20020a1c4404000000b002e728beb9fbso2704961wma.9
 for <virtualization@lists.linux-foundation.org>;
 Sun, 05 Sep 2021 08:55:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=FkqlDLwxY15uPA5cvtZn8WB/ij23mnSGY7u9OAsR1+Q=;
 b=N8G619zV+cbkINZ6dLk1XyI6/2PXUhfcSscDodDx1bMBr4R8pbr6FXLnydQUtonUOZ
 XSByFHLypoBcMJl7UdicSeFvbWQMboH5Z9ezAzdi4QaozXb6oewo/KzYKdL2du3fE9Dh
 GcDOc0FzHxB6qz3IPc7tyYpnGbqYv5A3oavmCMx3sdG9iUP2He3wju4EEQ5HT1o6VgA1
 nS0f41Dn7aChinNMCLQZy1R4J0BS+si+ea1mmwvfYhyI1hwDgZvQljFleZ85vM++ozEG
 2eigU6gt9VA1KPg/JY9wFmOFWE8kMqpLKw9cDMFIWgUl/AsJcybiN65+YMa9C0OGoimG
 o8Jg==
X-Gm-Message-State: AOAM533HmCpnyMd5Fp2NjdCbHy1DkBPTOvc1FqoCaqovmivdJEEMNEOb
 q/E0WzBpr0/T4D1RyozDalFnCYLI0Xmjp3T7GEtErt49wYSJyLywtxxlcAqiPklB0owMzPKlvgD
 X7ncLUuEbbPCW3Ybgl7LMpYwgKTdj2DzDM/l+IgEh5A==
X-Received: by 2002:adf:e901:: with SMTP id f1mr9157521wrm.13.1630857331138;
 Sun, 05 Sep 2021 08:55:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzoTItRtnLZijeuCdThieRPiWw2ARQXOEWH6eQ4SZ+adLnfig/pueE4P6suOA4XEsTs9sRHXg==
X-Received: by 2002:adf:e901:: with SMTP id f1mr9157499wrm.13.1630857330868;
 Sun, 05 Sep 2021 08:55:30 -0700 (PDT)
Received: from redhat.com ([2.55.131.183])
 by smtp.gmail.com with ESMTPSA id a10sm5294954wrd.51.2021.09.05.08.55.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Sep 2021 08:55:30 -0700 (PDT)
Date: Sun, 5 Sep 2021 11:55:26 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Arseny Krasnov <arseny.krasnov@kaspersky.com>
Subject: Re: [PATCH net-next v5 0/6] virtio/vsock: introduce MSG_EOR flag for
 SEQPACKET
Message-ID: <20210905115139-mutt-send-email-mst@kernel.org>
References: <20210903123016.3272800-1-arseny.krasnov@kaspersky.com>
MIME-Version: 1.0
In-Reply-To: <20210903123016.3272800-1-arseny.krasnov@kaspersky.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Andra Paraschiv <andraprs@amazon.com>, kvm@vger.kernel.org,
 netdev@vger.kernel.org, stsp2@yandex.ru, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, oxffffaa@gmail.com,
 Norbert Slusarek <nslusarek@gmx.net>, Stefan Hajnoczi <stefanha@redhat.com>,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Fri, Sep 03, 2021 at 03:30:13PM +0300, Arseny Krasnov wrote:
> 	This patchset implements support of MSG_EOR bit for SEQPACKET
> AF_VSOCK sockets over virtio transport.
> 	First we need to define 'messages' and 'records' like this:
> Message is result of sending calls: 'write()', 'send()', 'sendmsg()'
> etc. It has fixed maximum length, and it bounds are visible using
> return from receive calls: 'read()', 'recv()', 'recvmsg()' etc.
> Current implementation based on message definition above.
> 	Record has unlimited length, it consists of multiple message,
> and bounds of record are visible via MSG_EOR flag returned from
> 'recvmsg()' call. Sender passes MSG_EOR to sending system call and
> receiver will see MSG_EOR when corresponding message will be processed.
> 	Idea of patchset comes from POSIX: it says that SEQPACKET
> supports record boundaries which are visible for receiver using
> MSG_EOR bit. So, it looks like MSG_EOR is enough thing for SEQPACKET
> and we don't need to maintain boundaries of corresponding send -
> receive system calls. But, for 'sendXXX()' and 'recXXX()' POSIX says,
> that all these calls operates with messages, e.g. 'sendXXX()' sends
> message, while 'recXXX()' reads messages and for SEQPACKET, 'recXXX()'
> must read one entire message from socket, dropping all out of size
> bytes. Thus, both message boundaries and MSG_EOR bit must be supported
> to follow POSIX rules.
> 	To support MSG_EOR new bit was added along with existing
> 'VIRTIO_VSOCK_SEQ_EOR': 'VIRTIO_VSOCK_SEQ_EOM'(end-of-message) - now it
> works in the same way as 'VIRTIO_VSOCK_SEQ_EOR'. But 'VIRTIO_VSOCK_SEQ_EOR'
> is used to mark 'MSG_EOR' bit passed from userspace.
> 	This patchset includes simple test for MSG_EOR.


I'm prepared to merge this for this window,
but I'm not sure who's supposed to ack the net/vmw_vsock/af_vsock.c
bits. It's a harmless variable renaming so maybe it does not matter.

The rest is virtio stuff so I guess my tree is ok.

Objections, anyone?



>  Arseny Krasnov(6):
>   virtio/vsock: rename 'EOR' to 'EOM' bit.
>   virtio/vsock: add 'VIRTIO_VSOCK_SEQ_EOR' bit.
>   vhost/vsock: support MSG_EOR bit processing
>   virtio/vsock: support MSG_EOR bit processing
>   af_vsock: rename variables in receive loop
>   vsock_test: update message bounds test for MSG_EOR
> 
>  drivers/vhost/vsock.c                   | 28 +++++++++++++----------
>  include/uapi/linux/virtio_vsock.h       |  3 ++-
>  net/vmw_vsock/af_vsock.c                | 10 ++++----
>  net/vmw_vsock/virtio_transport_common.c | 23 ++++++++++++-------
>  tools/testing/vsock/vsock_test.c        |  8 ++++++-
>  5 files changed, 45 insertions(+), 27 deletions(-)
> 
>  v4 -> v5:
>  - Move bitwise and out of le32_to_cpu() in 0003.
> 
>  v3 -> v4:
>  - 'sendXXX()' renamed to 'send*()' in 0002- commit msg.
>  - Comment about bit restore updated in 0003-.
>  - 'same' renamed to 'similar' in 0003- commit msg.
>  - u32 used instead of uint32_t in 0003-.
> 
>  v2 -> v3:
>  - 'virtio/vsock: rename 'EOR' to 'EOM' bit.' - commit message updated.
>  - 'VIRTIO_VSOCK_SEQ_EOR' bit add moved to separate patch.
>  - 'vhost/vsock: support MSG_EOR bit processing' - commit message
>    updated.
>  - 'vhost/vsock: support MSG_EOR bit processing' - removed unneeded
>    'le32_to_cpu()', because input argument was already in CPU
>    endianness.
> 
>  v1 -> v2:
>  - 'VIRTIO_VSOCK_SEQ_EOR' is renamed to 'VIRTIO_VSOCK_SEQ_EOM', to
>    support backward compatibility.
>  - use bitmask of flags to restore in vhost.c, instead of separated
>    bool variable for each flag.
>  - test for EAGAIN removed, as logically it is not part of this
>    patchset(will be sent separately).
>  - cover letter updated(added part with POSIX description).
> 
> Signed-off-by: Arseny Krasnov <arseny.krasnov@kaspersky.com>
> -- 
> 2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
