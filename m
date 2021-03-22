Return-Path: <SRS0=byTZ=IU=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80E48C433DB
	for <virtualization@archiver.kernel.org>; Mon, 22 Mar 2021 13:35:13 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1EC16192A
	for <virtualization@archiver.kernel.org>; Mon, 22 Mar 2021 13:35:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1EC16192A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A96FE826A8;
	Mon, 22 Mar 2021 13:35:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id itm6XA-Umj3n; Mon, 22 Mar 2021 13:35:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 23CB0825CA;
	Mon, 22 Mar 2021 13:35:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DF233C000B;
	Mon, 22 Mar 2021 13:35:10 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2A97DC0001
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Mar 2021 13:35:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0B04F6067B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Mar 2021 13:35:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DvT88kCOcYU1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Mar 2021 13:35:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id DA408605C6
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Mar 2021 13:35:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1616420106;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=m6vBZO0DKXrA4OQnZDzWm54edL7Fp7UpF0mmq021WwY=;
 b=R9kQiHoPOIaegqZAQRZMiI1SdLfH1uvgVWJCnseZwh6ErgGQt0Z64Y+dTXsT+KzudFBqHd
 wUrXPiGLYs1SxiCRPnkhB5OaRdp5o24MUHHtb9HoiYvBSxy9EincvbrgorpyChpiiAi2UU
 qdMvxlGvd/lQWmSQvV/FbmlXIFDcOWE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-232-IZN0cvgVN3acAZQ9NBTpow-1; Mon, 22 Mar 2021 09:35:04 -0400
X-MC-Unique: IZN0cvgVN3acAZQ9NBTpow-1
Received: by mail-wr1-f69.google.com with SMTP id h21so25814605wrc.19
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Mar 2021 06:35:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=m6vBZO0DKXrA4OQnZDzWm54edL7Fp7UpF0mmq021WwY=;
 b=KPmEuFRXMGuszvz0409cCdXPYsSmrJ+FCFlM4lZzsknRPIDFDMQnnlAUINwsjtQreS
 IWHfH5x6X9N1voAVErJKeDnFssDU7k5R/PoH5pxcuFwK9D0mMH51Dbh2HTMRM9nU2x3S
 qYY2RnORPsZ5RuN+0w5Fw5QgdfZkGcY0G9C+V8tqwQSDatraIpYczRSLssnsuNiOjUCj
 b2DGhtbQXZkT6PBtqyjxAf5J5CXySTneNchKiK0oM2R/Dk/SRmNWFcOQUwxm9aoZrIzT
 Xet5kIk/40x/68fUX+j59sfjUB0yZtV3ZSHUIWFvtfqvv/ChNrZfdZISkzmdVSZ5xdjW
 5egg==
X-Gm-Message-State: AOAM531plsgNE4MhXADw7agpaDknPl7EFa51TWJUcJvMg8nc4CxsqqwG
 tBbTg4FNwfQtYys0dVpUiDVbfYiMqctejfCgKZeEb/UCMBdNBz8MQjyc2FTdkIYCA6m4tkQjq6p
 S0soaCcsHy9ax5bV00UWfcDmajoYV+CaQ33FN6aQDDA==
X-Received: by 2002:a5d:4fca:: with SMTP id h10mr19119611wrw.70.1616420103550; 
 Mon, 22 Mar 2021 06:35:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxy5/WVbx6zb6OHgabRQLiOCn5wYG74I9J89FOPDakq3TEAbOhRQGpRUo65HNrjW4N0J7Zsmw==
X-Received: by 2002:a5d:4fca:: with SMTP id h10mr19119580wrw.70.1616420103283; 
 Mon, 22 Mar 2021 06:35:03 -0700 (PDT)
Received: from redhat.com ([2a10:800e:f0d3:0:b69b:9fb8:3947:5636])
 by smtp.gmail.com with ESMTPSA id q19sm20962785wrg.80.2021.03.22.06.35.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Mar 2021 06:35:02 -0700 (PDT)
Date: Mon, 22 Mar 2021 09:34:58 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [RFC PATCH v1] virtio-vsock: use C style defines for constants
Message-ID: <20210322092547-mutt-send-email-mst@kernel.org>
References: <20210322063804.641923-1-arseny.krasnov@kaspersky.com>
 <YFiE9opnZ976hwbP@stefanha-x1.localdomain>
MIME-Version: 1.0
In-Reply-To: <YFiE9opnZ976hwbP@stefanha-x1.localdomain>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Andra Paraschiv <andraprs@amazon.com>, cohuck@redhat.com,
 Colin Ian King <colin.king@canonical.com>,
 Norbert Slusarek <nslusarek@gmx.net>, oxffffaa@gmail.com,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Mon, Mar 22, 2021 at 11:52:22AM +0000, Stefan Hajnoczi wrote:
> On Mon, Mar 22, 2021 at 09:37:59AM +0300, Arseny Krasnov wrote:
> > This:
> > 1) Replaces enums with C style defines.
> 
> Why?

I am guessing this is referencing
[PATCH] introduction: document #define syntax


> > 2) Adds defines for some constants.
> 
> Definitions need to be referenced somewhere to explain their use. It's
> not enough to add a constant, some text in the spec should mention that
> constant. (The exception to this might be a group of constants where
> individual constants don't need to be mentioned explicitly.)
> 
> > Signed-off-by: Arseny Krasnov <arseny.krasnov@kaspersky.com>
> > ---
> >  virtio-vsock.tex | 42 ++++++++++++++++++++++--------------------
> >  1 file changed, 22 insertions(+), 20 deletions(-)
> > 
> > diff --git a/virtio-vsock.tex b/virtio-vsock.tex
> > index da7e641..62ab6b3 100644
> > --- a/virtio-vsock.tex
> > +++ b/virtio-vsock.tex
> > @@ -86,23 +86,18 @@ \subsection{Device Operation}\label{sec:Device Types / Socket Device / Device Op
> >  operation constants:
> >  
> >  \begin{lstlisting}
> > -enum {
> > -	VIRTIO_VSOCK_OP_INVALID = 0,
> > -
> > -	/* Connect operations */
> > -	VIRTIO_VSOCK_OP_REQUEST = 1,
> > -	VIRTIO_VSOCK_OP_RESPONSE = 2,
> > -	VIRTIO_VSOCK_OP_RST = 3,
> > -	VIRTIO_VSOCK_OP_SHUTDOWN = 4,
> > -
> > -	/* To send payload */
> > -	VIRTIO_VSOCK_OP_RW = 5,
> > -
> > -	/* Tell the peer our credit info */
> > -	VIRTIO_VSOCK_OP_CREDIT_UPDATE = 6,
> > -	/* Request the peer to send the credit info to us */
> > -	VIRTIO_VSOCK_OP_CREDIT_REQUEST = 7,
> > -};
> > +#define VIRTIO_VSOCK_OP_INVALID        0
> > +/* Connect operations */
> > +#define VIRTIO_VSOCK_OP_REQUEST        1
> > +#define VIRTIO_VSOCK_OP_RESPONSE       2
> > +#define VIRTIO_VSOCK_OP_RST            3
> > +#define VIRTIO_VSOCK_OP_SHUTDOWN       4
> > +/* To send payload */
> > +#define VIRTIO_VSOCK_OP_RW             5
> > +/* Tell the peer our credit info */
> > +#define VIRTIO_VSOCK_OP_CREDIT_UPDATE  6
> > +/* Request the peer to send the credit info to us */
> > +#define VIRTIO_VSOCK_OP_CREDIT_REQUEST 7
> >  \end{lstlisting}
> >  
> >  \subsubsection{Virtqueue Flow Control}\label{sec:Device Types / Socket Device / Device Operation / Virtqueue Flow Control}
> > @@ -143,6 +138,10 @@ \subsubsection{Addressing}\label{sec:Device Types / Socket Device / Device Opera
> >  Currently only stream sockets are supported. \field{type} is 1 for stream

So e.g.

Currently only stream sockets are supported. \field{type} is 1 (VIRTIO_VSOCK_TYPE_STREAM) for stream


> >  socket types.
> >  
> > +\begin{lstlisting}
> > +#define VIRTIO_VSOCK_TYPE_STREAM 1
> > +\end{lstlisting}
> > +
> >  Stream sockets provide in-order, guaranteed, connection-oriented delivery
> >  without message boundaries.
> >  
> > @@ -227,6 +226,11 @@ \subsubsection{Stream Sockets}\label{sec:Device Types / Socket Device / Device O
> >  hints are permanent once sent and successive packets with bits clear do not
> >  reset them.
> >  
> > +\begin{lstlisting}
> > +#define VIRTIO_VSOCK_SHUTDOWN_RECEIVE_BIT 0
> > +#define VIRTIO_VSOCK_SHUTDOWN_SEND_BIT    1
> > +\end{lstlisting}
> 
> The spec has no other _BIT constants.

True. Sometimes there's an _F_ somewhere there instead.

Also, it is possible to put the defines near the flags
field. Compare, for example:

\begin{lstlisting}
struct virtq_desc {
        /* Address (guest-physical). */
        le64 addr;
        /* Length. */
        le32 len;

/* This marks a buffer as continuing via the next field. */
#define VIRTQ_DESC_F_NEXT   1
/* This marks a buffer as device write-only (otherwise device read-only). */
#define VIRTQ_DESC_F_WRITE     2
/* This means the buffer contains a list of buffer descriptors. */
#define VIRTQ_DESC_F_INDIRECT   4
        /* The flags as indicated above. */
        le16 flags;
        /* Next field if flags & NEXT */
        le16 next;
};
\end{lstlisting}


> It uses bitmasks instead.

Not universally.

> I
> suggest following that for consistency:
> 
>   #define VIRTIO_VSOCK_SHUTDOWN_RECEIVE (1 << 0)
>   #define VIRTIO_VSOCK_SHUTDOWN_SEND    (1 << 1)


_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
