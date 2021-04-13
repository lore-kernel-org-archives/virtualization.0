Return-Path: <SRS0=XT4h=JK=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DCB5C433B4
	for <virtualization@archiver.kernel.org>; Tue, 13 Apr 2021 13:10:27 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC2D7613AE
	for <virtualization@archiver.kernel.org>; Tue, 13 Apr 2021 13:10:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC2D7613AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B8E3760BEC;
	Tue, 13 Apr 2021 13:10:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id V5K3sr2wmfq5; Tue, 13 Apr 2021 13:10:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id 58D5D60BEA;
	Tue, 13 Apr 2021 13:10:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 352B0C000B;
	Tue, 13 Apr 2021 13:10:25 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 12151C000A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Apr 2021 13:10:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E7DA284478
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Apr 2021 13:10:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id o-9LABc-zjWz
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Apr 2021 13:10:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id BD91084433
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Apr 2021 13:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1618319421;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=URtrr3SovMbkl6NETTkEv8ByYBIPdxANiOArp9gcsfI=;
 b=OjejFHlUa1A67+EkXHeaP0pSTonzNd6Anh1xx3kdLtjYl+nAtutV2KA9TlkzqqQBmYZjn6
 mZ7S3xu4wlnFphKaVxVs0n6W+wmoMK0V1EUlAtpq0l+0m9cfagvZ84ZYn7pmhgy5FTmOmW
 Noz3n/frPjL7J9+uIWzUL31O022sF0c=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-108-KiwPUVjPMbm97srTZexcnw-1; Tue, 13 Apr 2021 09:10:17 -0400
X-MC-Unique: KiwPUVjPMbm97srTZexcnw-1
Received: by mail-wm1-f69.google.com with SMTP id
 u7-20020a05600c19c7b029010c8bb11793so2753818wmq.0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Apr 2021 06:10:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=URtrr3SovMbkl6NETTkEv8ByYBIPdxANiOArp9gcsfI=;
 b=O4wn9Fp53smMgw5nkH/P/ex9mihBBK4Ch7TFMR6kxURfS09DSDk7TI1/quz7OlNqoK
 t3E43i/5GrpV749YyeqSMBPPBI+v3/fO7wn9bQNrPLnf2z3Z5Z1UGpVXJBzs0PcHeJoA
 gi36LrmJaKol7Yrnh5PRAXumdZst9LOk1bTWViO9dRD9bzYkf1zDXoRYzM30ulfOM+vD
 kDJonmGrw3mYxmBtHgLwhXvlgUe7j0Uybrhz3zANCudpC787mMuaQ+bqDebdiOkeFX1g
 MhZTEgExLHxl9NH/0354DKE2co/wPahtiPBQRT7GYZsa4AI9QdlEqPe35x/NllI1I51m
 BecA==
X-Gm-Message-State: AOAM532AFfqng4x/7sLFXr4uJgKbLGSU7gDp+Rl4MfxXwF4aNu8qheVW
 40JA+eMw6GLmG2EBtnkZsq3lBWMfu7l648KM/+HBd85+R8xqjwgS7cldeP1UULOcC3wSXw4ZtjJ
 zDvN8p4BDshwXl+wVv+GLmTeukreLm4JekZ4MM7vctA==
X-Received: by 2002:a05:600c:4482:: with SMTP id
 e2mr3973908wmo.121.1618319416471; 
 Tue, 13 Apr 2021 06:10:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyySsUesqaIY3KeHLCB6kAOKcSt/cYWsKU5AImoUEuaYlCid7k5mnImZmFhCogSRqgJzxI2Kg==
X-Received: by 2002:a05:600c:4482:: with SMTP id
 e2mr3973880wmo.121.1618319416272; 
 Tue, 13 Apr 2021 06:10:16 -0700 (PDT)
Received: from redhat.com ([2a10:8006:2281:0:1994:c627:9eac:1825])
 by smtp.gmail.com with ESMTPSA id a15sm20057651wrr.53.2021.04.13.06.10.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Apr 2021 06:10:15 -0700 (PDT)
Date: Tue, 13 Apr 2021 09:10:11 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Arseny Krasnov <arseny.krasnov@kaspersky.com>
Subject: Re: [RFC PATCH v5 2/2] virtio-vsock: SOCK_SEQPACKET description
Message-ID: <20210413090642-mutt-send-email-mst@kernel.org>
References: <20210413125217.3416876-1-arseny.krasnov@kaspersky.com>
 <20210413125333.3419315-1-arseny.krasnov@kaspersky.com>
MIME-Version: 1.0
In-Reply-To: <20210413125333.3419315-1-arseny.krasnov@kaspersky.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Andra Paraschiv <andraprs@amazon.com>, Jeff Vander Stoep <jeffv@google.com>,
 cohuck@redhat.com, Colin Ian King <colin.king@canonical.com>,
 oxffffaa@gmail.com, Norbert Slusarek <nslusarek@gmx.net>,
 Stefan Hajnoczi <stefanha@redhat.com>, virtio-comment@lists.oasis-open.org,
 Jakub Kicinski <kuba@kernel.org>, Alexander Popov <alex.popov@linux.com>,
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

On Tue, Apr 13, 2021 at 03:53:29PM +0300, Arseny Krasnov wrote:
> This adds description of SOCK_SEQPACKET socket type
> support for virtio-vsock.
> 
> Signed-off-by: Arseny Krasnov <arseny.krasnov@kaspersky.com>
> ---
>  virtio-vsock.tex | 26 +++++++++++++++++++++-----
>  1 file changed, 21 insertions(+), 5 deletions(-)
> 
> diff --git a/virtio-vsock.tex b/virtio-vsock.tex
> index ad57f9d..00e59cc 100644
> --- a/virtio-vsock.tex
> +++ b/virtio-vsock.tex
> @@ -16,7 +16,10 @@ \subsection{Virtqueues}\label{sec:Device Types / Socket Device / Virtqueues}
>  
>  \subsection{Feature bits}\label{sec:Device Types / Socket Device / Feature bits}
>  
> -There are currently no feature bits defined for this device.
> +\begin{description}
> +\item VIRTIO_VSOCK_F_SEQPACKET (0) SOCK_SEQPACKET socket type is
> +    supported.

Does it make sense to only support seqpacket and not stream?
I am guessing not since seqpacket is more or less
a superset ...

> +\end{description}
>  
>  \subsection{Device configuration layout}\label{sec:Device Types / Socket Device / Device configuration layout}
>  
> @@ -135,15 +138,17 @@ \subsubsection{Addressing}\label{sec:Device Types / Socket Device / Device Opera
>  consists of a (cid, port number) tuple. The header fields used for this are
>  \field{src_cid}, \field{src_port}, \field{dst_cid}, and \field{dst_port}.
>  
> -Currently only stream sockets are supported. \field{type} is 1 (VIRTIO_VSOCK_TYPE_STREAM)
> -for stream socket types.
> +Currently stream and seqpacket sockets are supported. \field{type} is 1 (VIRTIO_VSOCK_TYPE_STREAM)
> +for stream socket types, and 2 (VIRTIO_VSOCK_TYPE_SEQPACKET) for seqpacket socket types.
>  
>  \begin{lstlisting}
> -#define VIRTIO_VSOCK_TYPE_STREAM 1
> +#define VIRTIO_VSOCK_TYPE_STREAM    1
> +#define VIRTIO_VSOCK_TYPE_SEQPACKET 2
>  \end{lstlisting}
>  
>  Stream sockets provide in-order, guaranteed, connection-oriented delivery
> -without message boundaries.
> +without message boundaries. Seqpacket sockets provide in-order, guaranteed,
> +connection-oriented delivery with message boundaries.
>  
>  \subsubsection{Buffer Space Management}\label{sec:Device Types / Socket Device / Device Operation / Buffer Space Management}
>  \field{buf_alloc} and \field{fwd_cnt} are used for buffer space management of
> @@ -244,6 +249,17 @@ \subsubsection{Stream Sockets}\label{sec:Device Types / Socket Device / Device O
>  destination) address tuple for a new connection while the other peer is still
>  processing the old connection.
>  
> +\subsubsection{Seqpacket Sockets}\label{sec:Device Types / Socket Device / Device Operation / Seqpacket Sockets}
> +
> +\paragraph{Message boundaries}\label{sec:Device Types / Socket Device / Device Operation / Seqpacket Sockets / Message boundaries}
> +
> +To provide message boundaries, last RW packet of each message has VIRTIO_VSOCK_SEQ_EOR
> +bit set in the \field{flags} of packet's header.
> +
> +\begin{lstlisting}
> +#define VIRTIO_VSOCK_SEQ_EOR 1
> +\end{lstlisting}


Problem is, where is device going to hold this boundary?
Currently device discards the header just keeping the payload
around.
I suspect we need to have some kind of header per message
maintained by the device and
accounted for as part of the the credit accounting.


> +
>  \subsubsection{Device Events}\label{sec:Device Types / Socket Device / Device Operation / Device Events}
>  
>  Certain events are communicated by the device to the driver using the event
> -- 
> 2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
