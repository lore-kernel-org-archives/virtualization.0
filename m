Return-Path: <SRS0=XT4h=JK=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5888C433ED
	for <virtualization@archiver.kernel.org>; Tue, 13 Apr 2021 19:56:08 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DDE5613C7
	for <virtualization@archiver.kernel.org>; Tue, 13 Apr 2021 19:56:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DDE5613C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3154C84382;
	Tue, 13 Apr 2021 19:56:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2PB18sCesR2D; Tue, 13 Apr 2021 19:56:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTP id C96328445E;
	Tue, 13 Apr 2021 19:56:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 99556C000B;
	Tue, 13 Apr 2021 19:56:06 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 35F31C000A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Apr 2021 19:56:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1B45740E86
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Apr 2021 19:56:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vnZKFxOcz5C6
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Apr 2021 19:56:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 84B9D40E84
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Apr 2021 19:56:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1618343761;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7plVsyKqjaO7YZKAbqm/G536AtrkO2RYT1AaTGzcBoM=;
 b=i0WfcZx9fwNv5JYm43ROxV3vih2nS2AsqeSzzDKS2pblBOvjTJKdA+GBjcOVO0iLTtuBFS
 gK1zFYcwMMaXHCcez5P3VXWDTCWw9wDmvHcjulVr3pChDEJxxNvC19HNCDqzYx1GscNjbF
 CKfeaTeihoEYCFFVIH2YOmIybN7Apzg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-399-V_9Hn2NRP-KepA6OMK8szw-1; Tue, 13 Apr 2021 15:55:58 -0400
X-MC-Unique: V_9Hn2NRP-KepA6OMK8szw-1
Received: by mail-wm1-f71.google.com with SMTP id
 t83-20020a1cc3560000b029011f8f517694so1562064wmf.3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Apr 2021 12:55:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=7plVsyKqjaO7YZKAbqm/G536AtrkO2RYT1AaTGzcBoM=;
 b=Flo3KJKK+KioFzuVPSGB3i3LBgmTmYjFFrGTF10RQ87JB0I2MmQ5Ek8py6KB21OmDU
 pWszPZuRchWzaCGffAHe2WcfSdCZTe1Qri0Qz/BbFbcAd5C+38uwmWo6KUP0reMZBqcI
 nz3PS1PLV4D/Yba5KHiPOUeNMD3ITVdZwol+aStI6EjGNa8eaVHjQM06SVHPoRLPyRXz
 JwIztwxO2TXhtgh2tFjR0MPAjxthcoukDaSQdaCp9M8LZvgAQsplTSfjlVrY42uhOIUf
 EVnh7EpRt9ogq7ubEg/1/HEZSBqFLobFfT47cfHjgt0OQcQiAkhf82LizdNd1sa7Kr16
 Lp3w==
X-Gm-Message-State: AOAM533F0ZHZzp9LXyXhsA33GjEMwh2b9HmPgE54SENeYfNfwj6bXzmb
 4VIprnDMY2FPf4lHw7VT/L+pTbZOHS2aPCW3yqnUYIl30OkuVuT2bRiGIc3bdi4Bf0AmZNt+7he
 uiiIHdmlFicFSQJsa7xPk4TOBwTEvANQ20YCNYTWQpQ==
X-Received: by 2002:a05:600c:3643:: with SMTP id
 y3mr1499931wmq.159.1618343757095; 
 Tue, 13 Apr 2021 12:55:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwG60qOD/WxsMKOoOKiq+z9cJ4zFmobHpqzcxE1xtyL/fj7c4BQbzY+ywpY0w0NCynesJHC/A==
X-Received: by 2002:a05:600c:3643:: with SMTP id
 y3mr1499913wmq.159.1618343756931; 
 Tue, 13 Apr 2021 12:55:56 -0700 (PDT)
Received: from redhat.com ([2a10:8006:2281:0:1994:c627:9eac:1825])
 by smtp.gmail.com with ESMTPSA id r5sm3399479wmr.15.2021.04.13.12.55.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Apr 2021 12:55:56 -0700 (PDT)
Date: Tue, 13 Apr 2021 15:55:52 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Arseny Krasnov <arseny.krasnov@kaspersky.com>
Subject: Re: [RFC PATCH v5 2/2] virtio-vsock: SOCK_SEQPACKET description
Message-ID: <20210413155316-mutt-send-email-mst@kernel.org>
References: <20210413125217.3416876-1-arseny.krasnov@kaspersky.com>
 <20210413125333.3419315-1-arseny.krasnov@kaspersky.com>
 <20210413090642-mutt-send-email-mst@kernel.org>
 <92a6b268-a36a-5f1b-2d67-02accfde70ce@kaspersky.com>
MIME-Version: 1.0
In-Reply-To: <92a6b268-a36a-5f1b-2d67-02accfde70ce@kaspersky.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Andra Paraschiv <andraprs@amazon.com>, Jeff Vander Stoep <jeffv@google.com>,
 "cohuck@redhat.com" <cohuck@redhat.com>,
 Colin Ian King <colin.king@canonical.com>,
 "oxffffaa@gmail.com" <oxffffaa@gmail.com>,
 Norbert Slusarek <nslusarek@gmx.net>, Stefan Hajnoczi <stefanha@redhat.com>,
 "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
 Jakub Kicinski <kuba@kernel.org>, Alexander Popov <alex.popov@linux.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
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

On Tue, Apr 13, 2021 at 05:22:44PM +0300, Arseny Krasnov wrote:
> 
> On 13.04.2021 16:10, Michael S. Tsirkin wrote:
> > On Tue, Apr 13, 2021 at 03:53:29PM +0300, Arseny Krasnov wrote:
> >> This adds description of SOCK_SEQPACKET socket type
> >> support for virtio-vsock.
> >>
> >> Signed-off-by: Arseny Krasnov <arseny.krasnov@kaspersky.com>
> >> ---
> >>  virtio-vsock.tex | 26 +++++++++++++++++++++-----
> >>  1 file changed, 21 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/virtio-vsock.tex b/virtio-vsock.tex
> >> index ad57f9d..00e59cc 100644
> >> --- a/virtio-vsock.tex
> >> +++ b/virtio-vsock.tex
> >> @@ -16,7 +16,10 @@ \subsection{Virtqueues}\label{sec:Device Types / Socket Device / Virtqueues}
> >>  
> >>  \subsection{Feature bits}\label{sec:Device Types / Socket Device / Feature bits}
> >>  
> >> -There are currently no feature bits defined for this device.
> >> +\begin{description}
> >> +\item VIRTIO_VSOCK_F_SEQPACKET (0) SOCK_SEQPACKET socket type is
> >> +    supported.
> > Does it make sense to only support seqpacket and not stream?
> > I am guessing not since seqpacket is more or less
> > a superset ...
> 
> You mean, this sentence must be "Both SOCK_SEQPACKET and SOCK_STREAM types
> 
> are supported"?


No. I am asking whether we want a feature bit for SOCK_STREAM too?


> >
> >> +\end{description}
> >>  
> >>  \subsection{Device configuration layout}\label{sec:Device Types / Socket Device / Device configuration layout}
> >>  
> >> @@ -135,15 +138,17 @@ \subsubsection{Addressing}\label{sec:Device Types / Socket Device / Device Opera
> >>  consists of a (cid, port number) tuple. The header fields used for this are
> >>  \field{src_cid}, \field{src_port}, \field{dst_cid}, and \field{dst_port}.
> >>  
> >> -Currently only stream sockets are supported. \field{type} is 1 (VIRTIO_VSOCK_TYPE_STREAM)
> >> -for stream socket types.
> >> +Currently stream and seqpacket sockets are supported. \field{type} is 1 (VIRTIO_VSOCK_TYPE_STREAM)
> >> +for stream socket types, and 2 (VIRTIO_VSOCK_TYPE_SEQPACKET) for seqpacket socket types.
> >>  
> >>  \begin{lstlisting}
> >> -#define VIRTIO_VSOCK_TYPE_STREAM 1
> >> +#define VIRTIO_VSOCK_TYPE_STREAM    1
> >> +#define VIRTIO_VSOCK_TYPE_SEQPACKET 2
> >>  \end{lstlisting}
> >>  
> >>  Stream sockets provide in-order, guaranteed, connection-oriented delivery
> >> -without message boundaries.
> >> +without message boundaries. Seqpacket sockets provide in-order, guaranteed,
> >> +connection-oriented delivery with message boundaries.
> >>  
> >>  \subsubsection{Buffer Space Management}\label{sec:Device Types / Socket Device / Device Operation / Buffer Space Management}
> >>  \field{buf_alloc} and \field{fwd_cnt} are used for buffer space management of
> >> @@ -244,6 +249,17 @@ \subsubsection{Stream Sockets}\label{sec:Device Types / Socket Device / Device O
> >>  destination) address tuple for a new connection while the other peer is still
> >>  processing the old connection.
> >>  
> >> +\subsubsection{Seqpacket Sockets}\label{sec:Device Types / Socket Device / Device Operation / Seqpacket Sockets}
> >> +
> >> +\paragraph{Message boundaries}\label{sec:Device Types / Socket Device / Device Operation / Seqpacket Sockets / Message boundaries}
> >> +
> >> +To provide message boundaries, last RW packet of each message has VIRTIO_VSOCK_SEQ_EOR
> >> +bit set in the \field{flags} of packet's header.
> >> +
> >> +\begin{lstlisting}
> >> +#define VIRTIO_VSOCK_SEQ_EOR 1
> >> +\end{lstlisting}
> >
> > Problem is, where is device going to hold this boundary?
> > Currently device discards the header just keeping the payload
> > around.
> > I suspect we need to have some kind of header per message
> > maintained by the device and
> > accounted for as part of the the credit accounting.
> 
> IIUC, in Linux, header's are copied by vhost between buffer
> 
> in virtqueue and buffer in virtio vsock driver(host to guest transmission and
> 
> guest to host transmission). E.g. values of header's field are visible by driver.

The question is about credit accounting.  With stream we can add as
little as a single byte with no overhead. No so with seqpacket each
boundary adds memory overhead.  This memory needs to be accounted for.
How much I'm not sure. Maybe it needs to be negotiated during
connection?



> >
> >
> >> +
> >>  \subsubsection{Device Events}\label{sec:Device Types / Socket Device / Device Operation / Device Events}
> >>  
> >>  Certain events are communicated by the device to the driver using the event
> >> -- 
> >> 2.25.1
> >

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
