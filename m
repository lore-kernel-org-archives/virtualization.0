Return-Path: <SRS0=cXtE=IO=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95CB7C433DB
	for <virtualization@archiver.kernel.org>; Tue, 16 Mar 2021 13:49:27 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BBCE6502B
	for <virtualization@archiver.kernel.org>; Tue, 16 Mar 2021 13:49:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BBCE6502B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id ABB4D6F556;
	Tue, 16 Mar 2021 13:49:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xeLjm8aoSUzR; Tue, 16 Mar 2021 13:49:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4605F605A7;
	Tue, 16 Mar 2021 13:49:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 16850C000C;
	Tue, 16 Mar 2021 13:49:25 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 39ECDC000A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Mar 2021 13:49:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 13EA84301C
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Mar 2021 13:49:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2ZSAV-tqLqOG
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Mar 2021 13:49:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D0E5C4300F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Mar 2021 13:49:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1615902560;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=blPG0+VCfXdX5RSzYgzgdHqYWBnqGYY0L+Uj8Bl/Bcc=;
 b=O1ejXwOOuoeeAhh7tho8IpviuLJrWEWxamJ10a/TFXYF8SKFCCB1+2CpyBX3wyjNfAXCfW
 SSrjn2QliOO3lfVUBuQb47I0J3eEVo9DRhIH+bT0c5NvkjkOM197knWAOdwpRgxLHx18HK
 ox6veO1Yqo4Jp18VUZHulW6n+sVr7jg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-379-QUFiIIxaNIiKPijSalEf3g-1; Tue, 16 Mar 2021 09:49:16 -0400
X-MC-Unique: QUFiIIxaNIiKPijSalEf3g-1
Received: by mail-wr1-f69.google.com with SMTP id r12so16720225wro.15
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Mar 2021 06:49:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=blPG0+VCfXdX5RSzYgzgdHqYWBnqGYY0L+Uj8Bl/Bcc=;
 b=Tt6GFD4edl0hAUtd7GESFrcaiIAKHmtdrt1LTK/bhCH5ltjdaGiJDuNEt3ABitKL/B
 ti7MWgDlVI4qvaKK3BSE4Hnhb33I7skNSm8WLiVJQ3sFKR/qY5/nDxCW2XSlA/cufyBX
 kdCl2ra/gCZH5xtL8Di0GtNcGyav/sy6rGIGoDQ5/EeoNa7eM/gkzJZFZYNjt/IMwHPE
 v4oPIMI+tPm/qEtne2QQ+eNjaRuG4BeDquqaEtcOAFt8Xi+l1z6PFTTmkqVjyFWjQOUu
 4TU0fqhCFo9IUlBQturHt5XybFlAtpkJowfGuHqe40GuwA324Wj952Bi8UGadaFLV2u6
 dfWw==
X-Gm-Message-State: AOAM533ZW4823m1wbmiw6ziWtRs+ziQrNQgKgPEr7UYR5apzzVm62Wv3
 aIA1f8ExMzY9rdv/aqDSzlvglOVqit8YDOwQPYrlQD89QCmqVkLq8Tv2hvorSr/jh8sQnIwwV3I
 d+U+GzG7Q1kD7YoY+rVmlQiZyfejtDzcaMUMRXExIew==
X-Received: by 2002:a05:600c:608:: with SMTP id
 o8mr4983501wmm.42.1615902555634; 
 Tue, 16 Mar 2021 06:49:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyPPnG1dOImEVttND+DtgyOTztDw6/4C6UquSS0Ghcp/nnKVsWzm/sGNHiBKu9wj4DzaRSdVQ==
X-Received: by 2002:a05:600c:608:: with SMTP id
 o8mr4983486wmm.42.1615902555444; 
 Tue, 16 Mar 2021 06:49:15 -0700 (PDT)
Received: from redhat.com (bzq-79-180-2-31.red.bezeqint.net. [79.180.2.31])
 by smtp.gmail.com with ESMTPSA id y18sm22201150wrq.61.2021.03.16.06.49.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Mar 2021 06:49:14 -0700 (PDT)
Date: Tue, 16 Mar 2021 09:49:11 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Arseny Krasnov <arseny.krasnov@kaspersky.com>
Subject: Re: [virtio-comment] [RFC PATCH v1 1/1] virtio-vsock: add
 SOCK_SEQPACKET description
Message-ID: <20210316093325-mutt-send-email-mst@kernel.org>
References: <20210218060715.1075547-1-arseny.krasnov@kaspersky.com>
 <20210218060827.1075863-1-arseny.krasnov@kaspersky.com>
MIME-Version: 1.0
In-Reply-To: <20210218060827.1075863-1-arseny.krasnov@kaspersky.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Andra Paraschiv <andraprs@amazon.com>, cohuck@redhat.com,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Thu, Feb 18, 2021 at 09:08:23AM +0300, Arseny Krasnov wrote:
> Signed-off-by: Arseny Krasnov <arseny.krasnov@kaspersky.com>
> ---
>  virtio-vsock.tex | 40 +++++++++++++++++++++++++++++++++++++---
>  1 file changed, 37 insertions(+), 3 deletions(-)
> 
> diff --git a/virtio-vsock.tex b/virtio-vsock.tex
> index da7e641..1ee8f99 100644
> --- a/virtio-vsock.tex
> +++ b/virtio-vsock.tex
> @@ -102,6 +102,11 @@ \subsection{Device Operation}\label{sec:Device Types / Socket Device / Device Op
>  	VIRTIO_VSOCK_OP_CREDIT_UPDATE = 6,
>  	/* Request the peer to send the credit info to us */
>  	VIRTIO_VSOCK_OP_CREDIT_REQUEST = 7,
> +
> +	/* Message begin for SOCK_SEQPACKET */
> +	VIRTIO_VSOCK_OP_SEQ_BEGIN = 8,
> +	/* Message end for SOCK_SEQPACKET */
> +	VIRTIO_VSOCK_OP_SEQ_END = 9,
>  };
>  \end{lstlisting}
>  
> @@ -140,11 +145,11 @@ \subsubsection{Addressing}\label{sec:Device Types / Socket Device / Device Opera
>  consists of a (cid, port number) tuple. The header fields used for this are
>  \field{src_cid}, \field{src_port}, \field{dst_cid}, and \field{dst_port}.
>  
> -Currently only stream sockets are supported. \field{type} is 1 for stream
> -socket types.
> +Currently stream and seqpacket sockets are supported. \field{type} is 1 for
> +stream socket types. \field{type} is 2 for seqpacket socket types.
>  
>  Stream sockets provide in-order, guaranteed, connection-oriented delivery
> -without message boundaries.
> +without message boundaries. Seqpacket sockets also provide message boundaries.
>  
>  \subsubsection{Buffer Space Management}\label{sec:Device Types / Socket Device / Device Operation / Buffer Space Management}
>  \field{buf_alloc} and \field{fwd_cnt} are used for buffer space management of
> @@ -240,6 +245,35 @@ \subsubsection{Stream Sockets}\label{sec:Device Types / Socket Device / Device O
>  destination) address tuple for a new connection while the other peer is still
>  processing the old connection.
>  
> +\subsubsection{Seqpacket Sockets}\label{sec:Device Types / Socket Device / Device Operation / Seqpacket Sockets}
> +
> +Seqpacket sockets differ from stream sockets only in data transmission way: in
> +stream sockets all data is sent using only VIRTIO_VSOCK_OP_RW packets. In
> +seqpacket sockets, to provide message boundaries, every sequence of
> +VIRTIO_VSOCK_OP_RW packets of each message is headed with
> +VIRTIO_VSOCK_OP_SEQ_BEGIN and tailed with VIRTIO_VSOCK_OP_SEQ_END packets.
> +Both VIRTIO_VSOCK_OP_SEQ_BEGIN and VIRTIO_VSOCK_OP_SEQ_END packets carry
> +special header in payload:
> +
> +\begin{lstlisting}
> +struct virtio_vsock_seq_hdr {
> +	__le32  msg_cnt;
> +	__le32  msg_len;
> +};
> +\end{lstlisting}

header in what sense? is there more payload beyond that? is header
part of the payload or not? does this replace virtio_vsock_hdr?

> +
> +\field{msg_cnt} is per socket and incremented by 1 on every send of
> +VIRTIO_VSOCK_OP_SEQ_BEGIN or VIRTIO_VSOCK_OP_SEQ_END. \field{msg_len} contains
> +message length. This header is used to check integrity of each message: message
> +is valid if length of data in VIRTIO_VSOCK_OP_RW packets is equal to
> +\field{msg_len} of prepending VIRTIO_VSOCK_OP_SEQ_BEGIN and \field{msg_cnt} of
> +VIRTIO_VSOCK_OP_SEQ_END differs from \field{msg_cnt} of
> +VIRTIO_VSOCK_OP_SEQ_BEGIN by 1.
> +
> +POSIX MSG_EOR flag is supported by special value of \field{flags} in packet's
> +header. If this flag is set for message, then all VIRTIO_VSOCK_OP_RW packets
> +of this message have bit 0 is set to 1 in \field{flags}.
> +
>  \subsubsection{Device Events}\label{sec:Device Types / Socket Device / Device Operation / Device Events}
>  
>  Certain events are communicated by the device to the driver using the event

So if I understand it correctly, receiver must maintain
VIRTIO_VSOCK_OP_SEQ_BEGIN/VIRTIO_VSOCK_OP_SEQ_END in its buffer,
correct? If so these need to be accounted for as part of
the flow control math. This calls for more changes in the spec,
e.g.

VIRTIO_VSOCK_OP_RW data packets MUST only be transmitted when the peer has
sufficient free buffer space for the payload.

would be

VIRTIO_VSOCK_OP_RW data packets as well as VIRTIO_VSOCK_OP_SEQ_BEGIN and
VIRTIO_VSOCK_OP_SEQ_END message boundary packets MUST only be
transmitted when the peer has sufficient free buffer space for the
payload.

If not then how do we limit host memory use?


Also, what is considered payload here size? the header? are we
worried about wasting buffer space?

the definition of payload and header is important for this:

\field{buf_alloc} and \field{fwd_cnt} are used for buffer space management of
stream sockets. The guest and the device publish how much buffer space is
available per socket. Only payload bytes are counted and header bytes are not
included. This facilitates flow control so data is never dropped.





> -- 
> 2.25.1
> 
> 
> This publicly archived list offers a means to provide input to the
> OASIS Virtual I/O Device (VIRTIO) TC.
> 
> In order to verify user consent to the Feedback License terms and
> to minimize spam in the list archive, subscription is required
> before posting.
> 
> Subscribe: virtio-comment-subscribe@lists.oasis-open.org
> Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org
> List help: virtio-comment-help@lists.oasis-open.org
> List archive: https://lists.oasis-open.org/archives/virtio-comment/
> Feedback License: https://www.oasis-open.org/who/ipr/feedback_license.pdf
> List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing-lists
> Committee: https://www.oasis-open.org/committees/virtio/
> Join OASIS: https://www.oasis-open.org/join/

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
