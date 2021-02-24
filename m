Return-Path: <SRS0=cI1G=H2=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A35BC433DB
	for <virtualization@archiver.kernel.org>; Wed, 24 Feb 2021 09:32:16 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6E7D64EC3
	for <virtualization@archiver.kernel.org>; Wed, 24 Feb 2021 09:32:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6E7D64EC3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0C1EE4EC0A;
	Wed, 24 Feb 2021 09:32:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vcNaOMfIhag8; Wed, 24 Feb 2021 09:32:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 31D404EBC0;
	Wed, 24 Feb 2021 09:32:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0E4A4C000B;
	Wed, 24 Feb 2021 09:32:13 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A7352C0001
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Feb 2021 09:32:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 879044309B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Feb 2021 09:32:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dLgcqqGQ_W4B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Feb 2021 09:32:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7683643098
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Feb 2021 09:32:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1614159129;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Fp7HKldksWxCbBsbtvhuovI90KQ4rhigv7kdlzxKUSk=;
 b=cjiX4fKiYl2Fu9KFpRc2i9vSwWjIs1kPp+lbKoBHJ8oyIR05BIUn42B0RkGnLX0OwPx4hD
 e1TBqEMXGm9bO/yEJ1m+0MEDVJJgdm2VgJg/GcmvQ8ExTZepPi7Uj+2+MzVnbyljf5tg7O
 kFKoetuMG/aaCVWxv/904iwpQwsR+K0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-56-FAup5duvNOOCPxEdcdGMgg-1; Wed, 24 Feb 2021 04:32:05 -0500
X-MC-Unique: FAup5duvNOOCPxEdcdGMgg-1
Received: by mail-wm1-f72.google.com with SMTP id h16so309149wmq.8
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Feb 2021 01:32:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Fp7HKldksWxCbBsbtvhuovI90KQ4rhigv7kdlzxKUSk=;
 b=avqcFJe6e/hoCKxjh5cAZBCcG+cTRyzfZDD1crYvBnQdmfK0z/baCDUOXrTQuoiuEZ
 HN9coA6KgxoFAt4DH6NgCL6PvScjuswGduMHK6pT5i4egx+s+NPYUy5hsA3Q1WH0st3j
 HFvYU9uLliq3s2lxxx1faggbUKQTc2lUVqvxXJajzmj9IuqOW0Mq1LTye5NaMOxM19F0
 bUzrBtb6k5VznfiUQszBHH0l878xwDtWcZRn4DsZLVw1tDjDokZ2AG2innRqccuMzvYF
 YUDUCqCEiO+i8PdRcGkiZOhXSuCCOgUBcHR/fzdu3qJBhgHEPn7B7GBFbeglMUHOk861
 JfOg==
X-Gm-Message-State: AOAM530i+O29/TvuXyG70xA26384em95G1X907UL7+glxiFeTywzQDSQ
 lCzt348WIU+iodrg+Yg+ZbXaEbeWi6qezVTYq6ImTKT5gbI4aeTSs9o+bYj7Fj1fvjzmt00fdB0
 +0P8HQGOXjfL9hvCxRBOMg62toR3X3fhQSmNmsT1hwg==
X-Received: by 2002:a5d:4cd0:: with SMTP id c16mr30619687wrt.84.1614159124187; 
 Wed, 24 Feb 2021 01:32:04 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx9KN9slLLc3LFrXZZBkQaNMJatN6pkdELn1CGWvZT65cgDi4vFQBb4xx6CPPjooo9B3mLZsA==
X-Received: by 2002:a5d:4cd0:: with SMTP id c16mr30619661wrt.84.1614159123973; 
 Wed, 24 Feb 2021 01:32:03 -0800 (PST)
Received: from steredhat (host-79-34-249-199.business.telecomitalia.it.
 [79.34.249.199])
 by smtp.gmail.com with ESMTPSA id j11sm1543048wrm.13.2021.02.24.01.32.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Feb 2021 01:32:03 -0800 (PST)
Date: Wed, 24 Feb 2021 10:32:00 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseny Krasnov <arseny.krasnov@kaspersky.com>
Subject: Re: [virtio-comment] [RFC PATCH v1 1/1] virtio-vsock: add
 SOCK_SEQPACKET description
Message-ID: <20210224093200.tpflaqgoap4fe5ax@steredhat>
References: <20210218060715.1075547-1-arseny.krasnov@kaspersky.com>
 <20210218060827.1075863-1-arseny.krasnov@kaspersky.com>
MIME-Version: 1.0
In-Reply-To: <20210218060827.1075863-1-arseny.krasnov@kaspersky.com>
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

On Thu, Feb 18, 2021 at 09:08:23AM +0300, Arseny Krasnov wrote:
>Signed-off-by: Arseny Krasnov <arseny.krasnov@kaspersky.com>
>---
> virtio-vsock.tex | 40 +++++++++++++++++++++++++++++++++++++---
> 1 file changed, 37 insertions(+), 3 deletions(-)
>
>diff --git a/virtio-vsock.tex b/virtio-vsock.tex
>index da7e641..1ee8f99 100644
>--- a/virtio-vsock.tex
>+++ b/virtio-vsock.tex
>@@ -102,6 +102,11 @@ \subsection{Device Operation}\label{sec:Device Types / Socket Device / Device Op
> 	VIRTIO_VSOCK_OP_CREDIT_UPDATE = 6,
> 	/* Request the peer to send the credit info to us */
> 	VIRTIO_VSOCK_OP_CREDIT_REQUEST = 7,
>+
>+	/* Message begin for SOCK_SEQPACKET */
>+	VIRTIO_VSOCK_OP_SEQ_BEGIN = 8,
>+	/* Message end for SOCK_SEQPACKET */
>+	VIRTIO_VSOCK_OP_SEQ_END = 9,
> };
> \end{lstlisting}
>
>@@ -140,11 +145,11 @@ \subsubsection{Addressing}\label{sec:Device Types / Socket Device / Device Opera
> consists of a (cid, port number) tuple. The header fields used for this are
> \field{src_cid}, \field{src_port}, \field{dst_cid}, and \field{dst_port}.
>
>-Currently only stream sockets are supported. \field{type} is 1 for stream
>-socket types.
>+Currently stream and seqpacket sockets are supported. \field{type} is 1 for
>+stream socket types. \field{type} is 2 for seqpacket socket types.
>
> Stream sockets provide in-order, guaranteed, connection-oriented delivery
>-without message boundaries.
>+without message boundaries. Seqpacket sockets also provide message boundaries.
>
> \subsubsection{Buffer Space Management}\label{sec:Device Types / Socket Device / Device Operation / Buffer Space Management}
> \field{buf_alloc} and \field{fwd_cnt} are used for buffer space management of
>@@ -240,6 +245,35 @@ \subsubsection{Stream Sockets}\label{sec:Device Types / Socket Device / Device O
> destination) address tuple for a new connection while the other peer is still
> processing the old connection.
>
>+\subsubsection{Seqpacket Sockets}\label{sec:Device Types / Socket Device / Device Operation / Seqpacket Sockets}
>+
>+Seqpacket sockets differ from stream sockets only in data transmission way: in
>+stream sockets all data is sent using only VIRTIO_VSOCK_OP_RW packets. In
>+seqpacket sockets, to provide message boundaries, every sequence of
>+VIRTIO_VSOCK_OP_RW packets of each message is headed with
                                              ^
Since this is a spec, I think we should use MUST when something must be 
respected by the peer, for example here we can say "MUST be headed"

>+VIRTIO_VSOCK_OP_SEQ_BEGIN and tailed with VIRTIO_VSOCK_OP_SEQ_END packets.
>+Both VIRTIO_VSOCK_OP_SEQ_BEGIN and VIRTIO_VSOCK_OP_SEQ_END packets carry
                                                                      ^
Same here "MUST carry" and in the rest of the patch.

>+special header in payload:
>+
>+\begin{lstlisting}
>+struct virtio_vsock_seq_hdr {
>+	__le32  msg_cnt;
>+	__le32  msg_len;
>+};
>+\end{lstlisting}
>+
>+\field{msg_cnt} is per socket and incremented by 1 on every send of
>+VIRTIO_VSOCK_OP_SEQ_BEGIN or VIRTIO_VSOCK_OP_SEQ_END. \field{msg_len} contains
>+message length. This header is used to check integrity of each message: message
>+is valid if length of data in VIRTIO_VSOCK_OP_RW packets is equal to
>+\field{msg_len} of prepending VIRTIO_VSOCK_OP_SEQ_BEGIN and \field{msg_cnt} of
>+VIRTIO_VSOCK_OP_SEQ_END differs from \field{msg_cnt} of
>+VIRTIO_VSOCK_OP_SEQ_BEGIN by 1.

If we replace msg_cnt with msg_id, I think we should have the same 
'msg_id' for VIRTIO_VSOCK_OP_SEQ_BEGIN or VIRTIO_VSOCK_OP_SEQ_END. If 
you want to use 'msg_cnt' and you increment it between BEGIN and END, we 
should consider the overflow case.

>+
>+POSIX MSG_EOR flag is supported by special value of \field{flags} in packet's
>+header. If this flag is set for message, then all VIRTIO_VSOCK_OP_RW packets
>+of this message have bit 0 is set to 1 in \field{flags}.

Maybe we need to define what MSG_EOR means.

Thanks,
Stefano

>+
> \subsubsection{Device Events}\label{sec:Device Types / Socket Device / Device Operation / Device Events}
>
> Certain events are communicated by the device to the driver using the event
>-- 
>2.25.1
>
>
>This publicly archived list offers a means to provide input to the
>OASIS Virtual I/O Device (VIRTIO) TC.
>
>In order to verify user consent to the Feedback License terms and
>to minimize spam in the list archive, subscription is required
>before posting.
>
>Subscribe: virtio-comment-subscribe@lists.oasis-open.org
>Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org
>List help: virtio-comment-help@lists.oasis-open.org
>List archive: https://lists.oasis-open.org/archives/virtio-comment/
>Feedback License: https://www.oasis-open.org/who/ipr/feedback_license.pdf
>List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing-lists
>Committee: https://www.oasis-open.org/committees/virtio/
>Join OASIS: https://www.oasis-open.org/join/
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
