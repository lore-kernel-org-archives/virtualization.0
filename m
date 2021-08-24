Return-Path: <SRS0=e+fm=NP=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BB42C4338F
	for <virtualization@archiver.kernel.org>; Tue, 24 Aug 2021 09:35:23 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2774613E8
	for <virtualization@archiver.kernel.org>; Tue, 24 Aug 2021 09:35:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D2774613E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9A9AA607F6;
	Tue, 24 Aug 2021 09:35:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TzazXGNRzsMj; Tue, 24 Aug 2021 09:35:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 2EC8460665;
	Tue, 24 Aug 2021 09:35:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0F4FAC0010;
	Tue, 24 Aug 2021 09:35:18 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E900AC000E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Aug 2021 09:35:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C3A4440123
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Aug 2021 09:35:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id w9zHmSxtBEUb
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Aug 2021 09:35:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6EBCF400BA
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Aug 2021 09:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1629797714;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=b7E3pZkD3MubnrwjhggwPy3LUOFiUjatyo0wJnLA0Bs=;
 b=bXFt8JbVHyH9SGGYzqpBaZ8OBtntQwdBzwFXcp3YLb+WQVegQNPj5RFKCRfQQSfKuEDsTq
 uQ9Z/cs0cjGHArgirk8UAWFMEfHFSKNotigMnOT0S6XiSLZi16+sPRTriPoxDxBlb59JQk
 +GfTKGgCLD8Ndwn/oYkEUUFrcgt/9T4=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-184-ivhQRe3sPNW4caGTAn5l8Q-1; Tue, 24 Aug 2021 05:35:12 -0400
X-MC-Unique: ivhQRe3sPNW4caGTAn5l8Q-1
Received: by mail-ed1-f70.google.com with SMTP id
 eg56-20020a05640228b8b02903be79801f9aso10176025edb.21
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Aug 2021 02:35:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=b7E3pZkD3MubnrwjhggwPy3LUOFiUjatyo0wJnLA0Bs=;
 b=UErrHzYh5ly01gWbp3DmAnVUzLiD3pawbn9XloQDLY6L1P4Mj4RtSJAP1rmtipC4gI
 6PflsRTnFQdQtK6B55pWedMH6RjPAyZJ8cuzACZmNjvfX2Yu/oKHNIdGxLFcVvvfvBJt
 b7Di9dr0+rFK2Xj8vhQZUfRyJvBJLmqPZkwlqjndK0BVfaF+mxzN9La6XAlJ17LOtvuy
 H1l2hK1O4GC0dYgp1aLFLJtu/6zAu62U4aTnjWtwt2KQWk99l7veTwyWQH4ea/Xkziyh
 4w9KCOKCxGbaQtfNRqgkNEj/fu3ZPWTMWGe4hHwt+YZZmuM4AF3iwaUVY/wAgP/+WN7t
 n4uQ==
X-Gm-Message-State: AOAM530+fOfDgqnQduRXRQGbcJoSPu56/QX1nXit9CPNJy/dZXUZ+9CO
 4Ap/hyh0pq82dYuUNhvDH+PF3/uL8jjaX/5AKlkQ4yYHTV4frw5cjH/5xWdwFcvKvdrfsq0ckV5
 waUWu0VP4Z4OX0SZgIkr+/33NCRREGRd7wrKrbCPBZw==
X-Received: by 2002:a17:906:af9a:: with SMTP id
 mj26mr6395828ejb.96.1629797711405; 
 Tue, 24 Aug 2021 02:35:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyE/dfr1jMMNgjFi0bSbz10F0JkP0qaSvvgTRRC3w7irR7nsl5Lsw6h2kwBO9ydSz9NMnlstQ==
X-Received: by 2002:a17:906:af9a:: with SMTP id
 mj26mr6395807ejb.96.1629797711224; 
 Tue, 24 Aug 2021 02:35:11 -0700 (PDT)
Received: from steredhat (host-79-45-8-152.retail.telecomitalia.it.
 [79.45.8.152])
 by smtp.gmail.com with ESMTPSA id ay20sm3865686ejb.48.2021.08.24.02.35.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Aug 2021 02:35:10 -0700 (PDT)
Date: Tue, 24 Aug 2021 11:35:08 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseny Krasnov <arseny.krasnov@kaspersky.com>
Subject: Re: [RFC PATCH v8 2/2] virtio-vsock: SOCK_SEQPACKET description
Message-ID: <20210824093508.6q5bq7necic6ovwf@steredhat>
References: <20210816085528.4175303-1-arseny.krasnov@kaspersky.com>
 <20210816085617.4175597-1-arseny.krasnov@kaspersky.com>
MIME-Version: 1.0
In-Reply-To: <20210816085617.4175597-1-arseny.krasnov@kaspersky.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Andra Paraschiv <andraprs@amazon.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, cohuck@redhat.com,
 Colin Ian King <colin.king@canonical.com>, oxffffaa@gmail.com,
 Norbert Slusarek <nslusarek@gmx.net>, Stefan Hajnoczi <stefanha@redhat.com>,
 virtio-comment@lists.oasis-open.org, Jakub Kicinski <kuba@kernel.org>,
 virtualization@lists.linux-foundation.org,
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

On Mon, Aug 16, 2021 at 11:56:13AM +0300, Arseny Krasnov wrote:
>This adds description of SOCK_SEQPACKET socket type
>support for virtio-vsock.
>
>Signed-off-by: Arseny Krasnov <arseny.krasnov@kaspersky.com>
>---
> virtio-vsock.tex | 43 ++++++++++++++++++++++++++++++++++++++-----
> 1 file changed, 38 insertions(+), 5 deletions(-)
>
>diff --git a/virtio-vsock.tex b/virtio-vsock.tex
>index ad57f9d..51d785a 100644
>--- a/virtio-vsock.tex
>+++ b/virtio-vsock.tex
>@@ -16,7 +16,10 @@ \subsection{Virtqueues}\label{sec:Device Types / Socket Device / Virtqueues}
>
> \subsection{Feature bits}\label{sec:Device Types / Socket Device / Feature bits}
>
>-There are currently no feature bits defined for this device.
>+\begin{description}
>+\item VIRTIO_VSOCK_F_SEQPACKET (1) SOCK_SEQPACKET socket type is
>+    supported.
>+\end{description}
>
> \subsection{Device configuration layout}\label{sec:Device Types / Socket Device / Device configuration layout}
>
>@@ -135,15 +138,17 @@ \subsubsection{Addressing}\label{sec:Device Types / Socket Device / Device Opera
> consists of a (cid, port number) tuple. The header fields used for this are
> \field{src_cid}, \field{src_port}, \field{dst_cid}, and \field{dst_port}.
>
>-Currently only stream sockets are supported. \field{type} is 1 (VIRTIO_VSOCK_TYPE_STREAM)
>-for stream socket types.
>+Currently stream and seqpacket sockets are supported. \field{type} is 1 (VIRTIO_VSOCK_TYPE_STREAM)
>+for stream socket types, and 2 (VIRTIO_VSOCK_TYPE_SEQPACKET) for seqpacket socket types.
>
> \begin{lstlisting}
>-#define VIRTIO_VSOCK_TYPE_STREAM 1
>+#define VIRTIO_VSOCK_TYPE_STREAM    1
>+#define VIRTIO_VSOCK_TYPE_SEQPACKET 2
> \end{lstlisting}
>
> Stream sockets provide in-order, guaranteed, connection-oriented delivery
>-without message boundaries.
>+without message boundaries. Seqpacket sockets provide in-order, 
>guaranteed,
>+connection-oriented delivery with message and record boundaries.
>
> \subsubsection{Buffer Space Management}\label{sec:Device Types / Socket Device / Device Operation / Buffer Space Management}
> \field{buf_alloc} and \field{fwd_cnt} are used for buffer space management of
>@@ -244,6 +249,34 @@ \subsubsection{Stream Sockets}\label{sec:Device Types / Socket Device / Device O
> destination) address tuple for a new connection while the other peer is still
> processing the old connection.
>
>+\subsubsection{Seqpacket Sockets}\label{sec:Device Types / Socket Device / Device Operation / Seqpacket Sockets}
>+
>+\paragraph{Message and record boundaries}\label{sec:Device Types / Socket Device / Device Operation / Seqpacket Sockets / Boundaries}
>+Two types of boundaries supported: message and record boundaries.
>+
>+Message is data, sent by single system call. Message boundary means
   ^
Could be "A message contains data sent by a single system call"

>+that data of single send system call is guaranteed to be read wholly by single
>+receive system call. If receive buffer is not enough, then out of size data
>+will be dropped.
>+
>+Record is any number of subsequent messages, where last message is sent with POSIX
>+MSG_EOR flag set. Record boundary means that receiver gets MSG_EOR flag set
>+in the corresponding message where sender set it.
>+
>+To provide message boundaries, last RW packet of each message has VIRTIO_VSOCK_SEQ_EOM
>+bit (bit 0) set in the \field{flags} of packet's header.
>+
>+\begin{lstlisting}
>+#define VIRTIO_VSOCK_SEQ_EOM 1
>+\end{lstlisting}
>+
>+To provide record boundaries, last RW packet of each record has VIRTIO_VSOCK_SEQ_EOR
>+bit (bit 1) set in the \field{flags} of packet's header.
>+
>+\begin{lstlisting}
>+#define VIRTIO_VSOCK_SEQ_EOR 2
>+\end{lstlisting}
>+

For other flags in the specs we use the shift operator, which is 
actually clearer to understand which bit is set, so I guess we could use 
it here too:

#define VIRTIO_VSOCK_SEQ_EOM (1 << 0)
#define VIRTIO_VSOCK_SEQ_EOR (1 << 1)

The rest LGTM.

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
