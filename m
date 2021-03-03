Return-Path: <SRS0=2V5C=IB=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 748F6C433DB
	for <virtualization@archiver.kernel.org>; Wed,  3 Mar 2021 12:35:57 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D845964E42
	for <virtualization@archiver.kernel.org>; Wed,  3 Mar 2021 12:35:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D845964E42
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7BDD048CA9;
	Wed,  3 Mar 2021 12:35:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DnAT4_nrno8U; Wed,  3 Mar 2021 12:35:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id F1A85489E0;
	Wed,  3 Mar 2021 12:35:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CC0E0C000B;
	Wed,  3 Mar 2021 12:35:54 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3FA28C0001
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 Mar 2021 12:35:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3A2A66F719
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 Mar 2021 12:35:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id P7WCA9Tleibt
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 Mar 2021 12:35:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 55F446F837
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 Mar 2021 12:35:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1614774951;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=B2/mlaVOc2uXODzqXWHOObyB1QA5PxCqBiUnSj4zWHw=;
 b=Ji2w/6ENPpmS9YPFC7qs7zDNz8y6VtthvxsVPcKnz1idLwONxx3U2dT5BvFOXeNStICnZ4
 zDHc5kbObg/JT0E1M9qgEMMaU+CUNY+cdB5zcxoCq/A9rkM7yHecO2OsPshJcG/V7kbcZI
 m5xdQsC3VqVjcmhE6Q9kTojJxsYHtN4=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-492-G9aSyCJwN-yLbEWqhni8OQ-1; Wed, 03 Mar 2021 07:35:49 -0500
X-MC-Unique: G9aSyCJwN-yLbEWqhni8OQ-1
Received: by mail-ej1-f72.google.com with SMTP id v10so10140212ejh.15
 for <virtualization@lists.linux-foundation.org>;
 Wed, 03 Mar 2021 04:35:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=B2/mlaVOc2uXODzqXWHOObyB1QA5PxCqBiUnSj4zWHw=;
 b=c6tlSY/D/At12Ypbea0VrYymq2ojnheaGao7oZc/W9zLryMsZXKlZZZfjo8/et8wVZ
 nJbM0P5bJ/MYQ/5ntM6Bff/oK5O0zFFUvwagFWoJZP6NsX/TTrZwHG4+l0bqZ7n4inhy
 KDicTrrnRnLprLX5e9RSxJI+/K1oypfkETSnips56iFPS+6H96s0cm+myerutxm6Ju7Q
 nlZAdWK/U7TRG2N7kALD0K4gUOYVk/QGXjvXZ3FOlHvBdNwB5bfSMQ1jRPW3ay3WDVpW
 ubkiul/ut1Sh+5T8aN1/mP2E00ao8c3SouiACqIY4T96iBhi+BhguL8bBrBJNeQDAfCN
 EZKg==
X-Gm-Message-State: AOAM5304juFSMrSd6avQgDaRvArAGb2KhdjcYEczb8mk/uwHu1ilJkco
 NWkQ/GepUeUAzNXDtDCTJpfrM7R7g4mLydM+VqmqEhZjs5gNuURwSKJ6reuJo7Wn9NgkQV9VQcz
 XwyDx4uO0q9harMEzUyjdoN4f+0U/flzv9nxqd+jnnw==
X-Received: by 2002:a17:907:7014:: with SMTP id
 wr20mr25750081ejb.179.1614774948392; 
 Wed, 03 Mar 2021 04:35:48 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwqz7SaBmzUofu3fKgqZP7e5ipUjUVholHQQZM5Mz0adhw0C9xMe8oaCTdhXWVdglpuPhUUzA==
X-Received: by 2002:a17:907:7014:: with SMTP id
 wr20mr25750055ejb.179.1614774948058; 
 Wed, 03 Mar 2021 04:35:48 -0800 (PST)
Received: from steredhat (host-79-34-249-199.business.telecomitalia.it.
 [79.34.249.199])
 by smtp.gmail.com with ESMTPSA id i13sm21164467ejj.2.2021.03.03.04.35.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Mar 2021 04:35:47 -0800 (PST)
Date: Wed, 3 Mar 2021 13:35:45 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [virtio-comment] [RFC PATCH v1 1/1] virtio-vsock: add
 SOCK_SEQPACKET description
Message-ID: <20210303123545.hbkda6vuam36y6kv@steredhat>
References: <20210218060715.1075547-1-arseny.krasnov@kaspersky.com>
 <20210218060827.1075863-1-arseny.krasnov@kaspersky.com>
 <20210224093200.tpflaqgoap4fe5ax@steredhat>
 <20210303130843.6b457503.cohuck@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20210303130843.6b457503.cohuck@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Andra Paraschiv <andraprs@amazon.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Colin Ian King <colin.king@canonical.com>, oxffffaa@gmail.com,
 Norbert Slusarek <nslusarek@gmx.net>, Stefan Hajnoczi <stefanha@redhat.com>,
 virtio-comment@lists.oasis-open.org, Jakub Kicinski <kuba@kernel.org>,
 Arseny Krasnov <arseny.krasnov@kaspersky.com>,
 virtualization@lists.linux-foundation.org,
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

On Wed, Mar 03, 2021 at 01:08:43PM +0100, Cornelia Huck wrote:
>On Wed, 24 Feb 2021 10:32:00 +0100
>Stefano Garzarella <sgarzare@redhat.com> wrote:
>
>> On Thu, Feb 18, 2021 at 09:08:23AM +0300, Arseny Krasnov wrote:
>> >Signed-off-by: Arseny Krasnov <arseny.krasnov@kaspersky.com>
>> >---
>> > virtio-vsock.tex | 40 +++++++++++++++++++++++++++++++++++++---
>> > 1 file changed, 37 insertions(+), 3 deletions(-)
>> >
>> >diff --git a/virtio-vsock.tex b/virtio-vsock.tex
>> >index da7e641..1ee8f99 100644
>> >--- a/virtio-vsock.tex
>> >+++ b/virtio-vsock.tex
>> >@@ -102,6 +102,11 @@ \subsection{Device Operation}\label{sec:Device Types / Socket Device / Device Op
>> > 	VIRTIO_VSOCK_OP_CREDIT_UPDATE = 6,
>> > 	/* Request the peer to send the credit info to us */
>> > 	VIRTIO_VSOCK_OP_CREDIT_REQUEST = 7,
>> >+
>> >+	/* Message begin for SOCK_SEQPACKET */
>> >+	VIRTIO_VSOCK_OP_SEQ_BEGIN = 8,
>> >+	/* Message end for SOCK_SEQPACKET */
>> >+	VIRTIO_VSOCK_OP_SEQ_END = 9,
>> > };
>> > \end{lstlisting}
>> >
>> >@@ -140,11 +145,11 @@ \subsubsection{Addressing}\label{sec:Device Types / Socket Device / Device Opera
>> > consists of a (cid, port number) tuple. The header fields used for this are
>> > \field{src_cid}, \field{src_port}, \field{dst_cid}, and \field{dst_port}.
>> >
>> >-Currently only stream sockets are supported. \field{type} is 1 for stream
>> >-socket types.
>> >+Currently stream and seqpacket sockets are supported. \field{type} is 1 for
>> >+stream socket types. \field{type} is 2 for seqpacket socket types.
>> >
>> > Stream sockets provide in-order, guaranteed, connection-oriented delivery
>> >-without message boundaries.
>> >+without message boundaries. Seqpacket sockets also provide message boundaries.
>> >
>> > \subsubsection{Buffer Space Management}\label{sec:Device Types / Socket Device / Device Operation / Buffer Space Management}
>> > \field{buf_alloc} and \field{fwd_cnt} are used for buffer space management of
>> >@@ -240,6 +245,35 @@ \subsubsection{Stream Sockets}\label{sec:Device Types / Socket Device / Device O
>> > destination) address tuple for a new connection while the other peer is still
>> > processing the old connection.
>> >
>> >+\subsubsection{Seqpacket Sockets}\label{sec:Device Types / Socket Device / Device Operation / Seqpacket Sockets}
>> >+
>> >+Seqpacket sockets differ from stream sockets only in data transmission way: in
>> >+stream sockets all data is sent using only VIRTIO_VSOCK_OP_RW packets. In
>> >+seqpacket sockets, to provide message boundaries, every sequence of
>> >+VIRTIO_VSOCK_OP_RW packets of each message is headed with
>>                                               ^
>> Since this is a spec, I think we should use MUST when something must be
>> respected by the peer, for example here we can say "MUST be headed"
>>
>> >+VIRTIO_VSOCK_OP_SEQ_BEGIN and tailed with VIRTIO_VSOCK_OP_SEQ_END packets.
>> >+Both VIRTIO_VSOCK_OP_SEQ_BEGIN and VIRTIO_VSOCK_OP_SEQ_END packets carry
>>                                                                       ^
>> Same here "MUST carry" and in the rest of the patch.
>
>Actually, MUST and friends are really for normative sections; I'd
>advise to have a description of how this feature works and then some
>device/driver normative clauses with MUST statements (like "the device
>MUST reject <malformed packets>" or so).
>

Okay, got it.

Thanks for the clarification,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
