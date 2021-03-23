Return-Path: <SRS0=L1Zq=IV=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_RED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77CA5C433E1
	for <virtualization@archiver.kernel.org>; Tue, 23 Mar 2021 14:12:02 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF37F60295
	for <virtualization@archiver.kernel.org>; Tue, 23 Mar 2021 14:12:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF37F60295
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9C7B96080C;
	Tue, 23 Mar 2021 14:12:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LB73Df76q5rI; Tue, 23 Mar 2021 14:12:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 216F560839;
	Tue, 23 Mar 2021 14:12:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E6C95C000B;
	Tue, 23 Mar 2021 14:11:59 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F039CC0001
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Mar 2021 14:11:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id DF50C40389
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Mar 2021 14:11:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kmBHTeVrX5Uh
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Mar 2021 14:11:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1C24A40386
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Mar 2021 14:11:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1616508715;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lJTBfJRk9Y3V1iqke8oGdw6PxQd3xX91gFjAa/An4eY=;
 b=BoAMdLJXO5kGGK+H/r5qAbmlOo6ZjQ5HMlVdRf6NaggWF55xuZZ6i3ho1OO3+zvAZ34fPj
 vJbRvmdO5KGX4kcHXPjfIJQh/HAVtbhPpUeybaXUxE8wRDp46H8FBAGPXu5IRezv0XEdUl
 9F9/cWzzR4IXYHJBIk2LwCHWtOgRjx0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-413-OaUrE0CoOWmxsS3B-fKx7A-1; Tue, 23 Mar 2021 10:11:54 -0400
X-MC-Unique: OaUrE0CoOWmxsS3B-fKx7A-1
Received: by mail-wr1-f69.google.com with SMTP id x9so1154121wro.9
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Mar 2021 07:11:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=lJTBfJRk9Y3V1iqke8oGdw6PxQd3xX91gFjAa/An4eY=;
 b=JbKZ4OMf+aUcQm/OAk0KO/4jbf8hhmNgZzif8dBhZ5pJ5QRlXGOX6CGWc54dASg+ZT
 jMr2x63Vcp3h6wzB1CdQPwmll9swpMnlxHLQyWxMfeRrxPSwVt5qaT4Bi0SVCwy3gc6V
 K/0pXrcTHZ04Ca0wLow6jXyfOXb4K2/pWsSu9Eh1ug762YrsPrzVn4uAYU56m27nZowZ
 /9hZm2gConOJmWEQM/Ze9CrYRsu3yOA3kZW1SrYIABuz+eKMYO3V65hCfYxlcvMxWdkB
 G5wS3Kh5D+Dg26OtT/fUv4H419W/8UHcbvmLxbS9ugc/rTs+bofiL4ENV18+VnYiWOEB
 iQ6Q==
X-Gm-Message-State: AOAM530o1rc8a6fAMTpYfil1NVTJbBHZ0f/vuBBwsh7DY5sBHdvr6XII
 mOMEvGkPkrKRzMalCRCV+gHWrlcYIzC1fQRLbFsXwh1lJtL05mhXDQegxjelCqr7/b0oijYSbbJ
 2WlHX23r5cpzQZsLx0VbsSxvPQ5CNEVyE+mYa3S+mdw==
X-Received: by 2002:adf:ba94:: with SMTP id p20mr4292835wrg.300.1616508713212; 
 Tue, 23 Mar 2021 07:11:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyyNogCCJBQaZqHy3KEjAxSWpD2f0tdvsD8yRROd7rey3mPT+EbSm1rN/rN7NK9EfFC0xnfxQ==
X-Received: by 2002:adf:ba94:: with SMTP id p20mr4292807wrg.300.1616508712996; 
 Tue, 23 Mar 2021 07:11:52 -0700 (PDT)
Received: from redhat.com ([2a10:800e:f0d3:0:b69b:9fb8:3947:5636])
 by smtp.gmail.com with ESMTPSA id c16sm28442595wrs.81.2021.03.23.07.11.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Mar 2021 07:11:51 -0700 (PDT)
Date: Tue, 23 Mar 2021 10:11:47 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Arseny Krasnov <arseny.krasnov@kaspersky.com>
Subject: Re: [RFC PATCH v3] virtio-vsock: use C style defines for constants
Message-ID: <20210323100626-mutt-send-email-mst@kernel.org>
References: <20210323131941.2464550-1-arseny.krasnov@kaspersky.com>
MIME-Version: 1.0
In-Reply-To: <20210323131941.2464550-1-arseny.krasnov@kaspersky.com>
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

On Tue, Mar 23, 2021 at 04:19:37PM +0300, Arseny Krasnov wrote:
> This:
> 1) Replaces enums with C style defines.
> 2) Adds defines for some constants.
> 
> Signed-off-by: Arseny Krasnov <arseny.krasnov@kaspersky.com>
> ---
>  virtio-vsock.tex | 54 +++++++++++++++++++++++++-----------------------
>  1 file changed, 28 insertions(+), 26 deletions(-)
> 
> diff --git a/virtio-vsock.tex b/virtio-vsock.tex
> index da7e641..5a22051 100644
> --- a/virtio-vsock.tex
> +++ b/virtio-vsock.tex
> @@ -86,23 +86,18 @@ \subsection{Device Operation}\label{sec:Device Types / Socket Device / Device Op
>  operation constants:
>  
>  \begin{lstlisting}
> -enum {
> -	VIRTIO_VSOCK_OP_INVALID = 0,
> -
> -	/* Connect operations */
> -	VIRTIO_VSOCK_OP_REQUEST = 1,
> -	VIRTIO_VSOCK_OP_RESPONSE = 2,
> -	VIRTIO_VSOCK_OP_RST = 3,
> -	VIRTIO_VSOCK_OP_SHUTDOWN = 4,
> -
> -	/* To send payload */
> -	VIRTIO_VSOCK_OP_RW = 5,
> -
> -	/* Tell the peer our credit info */
> -	VIRTIO_VSOCK_OP_CREDIT_UPDATE = 6,
> -	/* Request the peer to send the credit info to us */
> -	VIRTIO_VSOCK_OP_CREDIT_REQUEST = 7,
> -};
> +#define VIRTIO_VSOCK_OP_INVALID        0
> +/* Connect operations */
> +#define VIRTIO_VSOCK_OP_REQUEST        1
> +#define VIRTIO_VSOCK_OP_RESPONSE       2
> +#define VIRTIO_VSOCK_OP_RST            3
> +#define VIRTIO_VSOCK_OP_SHUTDOWN       4
> +/* To send payload */
> +#define VIRTIO_VSOCK_OP_RW             5
> +/* Tell the peer our credit info */
> +#define VIRTIO_VSOCK_OP_CREDIT_UPDATE  6
> +/* Request the peer to send the credit info to us */
> +#define VIRTIO_VSOCK_OP_CREDIT_REQUEST 7
>  \end{lstlisting}
>  
>  \subsubsection{Virtqueue Flow Control}\label{sec:Device Types / Socket Device / Device Operation / Virtqueue Flow Control}
> @@ -140,8 +135,12 @@ \subsubsection{Addressing}\label{sec:Device Types / Socket Device / Device Opera
>  consists of a (cid, port number) tuple. The header fields used for this are
>  \field{src_cid}, \field{src_port}, \field{dst_cid}, and \field{dst_port}.
>  
> -Currently only stream sockets are supported. \field{type} is 1 for stream
> -socket types.
> +Currently only stream sockets are supported. \field{type} is 1 (VIRTIO_VSOCK_TYPE_STREAM)
> +for stream socket types.
> +
> +\begin{lstlisting}
> +#define VIRTIO_VSOCK_TYPE_STREAM 1
> +\end{lstlisting}
>  
>  Stream sockets provide in-order, guaranteed, connection-oriented delivery
>  without message boundaries.
> @@ -222,10 +221,15 @@ \subsubsection{Stream Sockets}\label{sec:Device Types / Socket Device / Device O
>  insufficient resources to establish the connection.
>  
>  When a connected socket receives VIRTIO_VSOCK_OP_SHUTDOWN the header
> -\field{flags} field bit 0 indicates that the peer will not receive any more
> -data and bit 1 indicates that the peer will not send any more data.  These
> -hints are permanent once sent and successive packets with bits clear do not
> -reset them.
> +\field{flags} field

> bit VIRTIO_VSOCK_SHUTDOWN_RECEIVE_BIT

some repetition can make things clearer here. E.g.:
VIRTIO_VSOCK_SHUTDOWN_RECEIVE_BIT (bit 0)

also add the word "set".

> indicates that the
> +peer will not receive any more data and bit VIRTIO_VSOCK_SHUTDOWN_SEND_BIT
> +indicates that the peer will not send any more data.  These hints
> are permanent
> +once sent and successive packets with bits clear do not reset them.
> +
> +\begin{lstlisting}
> +#define VIRTIO_VSOCK_SHUTDOWN_RECEIVE_BIT 0
> +#define VIRTIO_VSOCK_SHUTDOWN_SEND_BIT    1

I would call them

#define VIRTIO_VSOCK_SHUTDOWN_F_RECEIVE 0
#define VIRTIO_VSOCK_SHUTDOWN_F_SEND    1

> +\end{lstlisting}
>  
>  The VIRTIO_VSOCK_OP_RST packet aborts the connection process or forcibly
>  disconnects a connected socket.
> @@ -248,9 +252,7 @@ \subsubsection{Device Events}\label{sec:Device Types / Socket Device / Device Op
>  The event buffer is as follows:
>  
>  \begin{lstlisting}
> -enum virtio_vsock_event_id {
> -        VIRTIO_VSOCK_EVENT_TRANSPORT_RESET = 0,
> -};
> +#define VIRTIO_VSOCK_EVENT_TRANSPORT_RESET 0
>  
>  struct virtio_vsock_event {
>          le32 id;
> -- 
> 2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
