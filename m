Return-Path: <SRS0=2V5C=IB=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CD01C433DB
	for <virtualization@archiver.kernel.org>; Wed,  3 Mar 2021 16:52:58 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E4A664ED0
	for <virtualization@archiver.kernel.org>; Wed,  3 Mar 2021 16:52:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E4A664ED0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2BD476F950;
	Wed,  3 Mar 2021 16:52:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9d-0MAXQGH17; Wed,  3 Mar 2021 16:52:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id A53E46F638;
	Wed,  3 Mar 2021 16:52:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 78967C000B;
	Wed,  3 Mar 2021 16:52:55 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CE3F2C0001
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 Mar 2021 16:52:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B514C6F638
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 Mar 2021 16:52:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JUK4Qs15b9rw
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 Mar 2021 16:52:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C4B6A6F486
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 Mar 2021 16:52:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1614790371;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Pepx+pOHIa0xJvV4JAWIdIP44p5G3ZfOhMEhQiKmO2Q=;
 b=afovdD+PyuiD1AZA84PYLLj0y/IqRxzitkW30FS/5A8RgTpVJj8ZOWlt6fpzMs0Vl6eW84
 TAM/AzMp96/Bqg5RTCG4w9DBCHxl5FgNK/J4SWQnAtueuWtxQnVzQrmdUtIstCCziZGuli
 huFeBhsCVT/laQvpeVrjQI9bVvAI2WI=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-467-IKJ-qDK2OdCMw9lUJTNbgg-1; Wed, 03 Mar 2021 11:52:49 -0500
X-MC-Unique: IKJ-qDK2OdCMw9lUJTNbgg-1
Received: by mail-ed1-f71.google.com with SMTP id i19so10295739edy.18
 for <virtualization@lists.linux-foundation.org>;
 Wed, 03 Mar 2021 08:52:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Pepx+pOHIa0xJvV4JAWIdIP44p5G3ZfOhMEhQiKmO2Q=;
 b=Ob6/tksSvLjSPia2g7k5p4iF3//m4f+r8hOE9mTnefR1fk8cMzDWBq0R7UXNehrXaQ
 g71chNFVoR7CyfKUk7Ge+2aN51To/rrFxwTclmWOy3wq89NshlilOejW7qS1hSY/jEP2
 fx+FWhD6w84ls+8TJx2w0cdoPEG9ptfJDADWYoRrzZkOPO92/IVDAPcn+4bGydbx5DZI
 5nwmYnUr63zvKQzpxp3hYdJKZsUSdYgL9ebfvAGYKhbJaov42JYTmYrUmpY6VDwm6upH
 tJmnqE4tflSrqaa1iTC0L5tzN7tL2D9LQoMbAyZ1jlXY6q/f5Oz/pjItDPuLbC8gdVhf
 U9aQ==
X-Gm-Message-State: AOAM530+yPd3NZo7AV/NawhXDTAP56HT/wB1xlcxUtoR7ah4t5UQWLXt
 dhP75/+vz10618SHJSokm1W6wv2eWPyO9UcIFKTXCjxDpKYcDiRHFryvwRwa2chG8T9+VHYd1mQ
 2JENUqcsWn0c0JfK/SBGvGsPavDTfIWmB7zVoL4X4hA==
X-Received: by 2002:a17:907:c05:: with SMTP id
 ga5mr5005272ejc.380.1614790367843; 
 Wed, 03 Mar 2021 08:52:47 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy60bowKrsB+bTY71PoctrvVQsCVMbhq0izu/44MRw8ZYs+l1eoDcxT6Xno9GeDRImoL2ME/Q==
X-Received: by 2002:a17:907:c05:: with SMTP id
 ga5mr5005263ejc.380.1614790367709; 
 Wed, 03 Mar 2021 08:52:47 -0800 (PST)
Received: from redhat.com (bzq-79-180-2-31.red.bezeqint.net. [79.180.2.31])
 by smtp.gmail.com with ESMTPSA id s18sm21405682ejc.79.2021.03.03.08.52.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Mar 2021 08:52:47 -0800 (PST)
Date: Wed, 3 Mar 2021 11:52:43 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [virtio-comment] [RFC PATCH v1 1/1] virtio-vsock: add
 SOCK_SEQPACKET description
Message-ID: <20210303114831-mutt-send-email-mst@kernel.org>
References: <20210218060715.1075547-1-arseny.krasnov@kaspersky.com>
 <20210218060827.1075863-1-arseny.krasnov@kaspersky.com>
 <20210224093200.tpflaqgoap4fe5ax@steredhat>
 <20210303130843.6b457503.cohuck@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20210303130843.6b457503.cohuck@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Andra Paraschiv <andraprs@amazon.com>,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Wed, Mar 03, 2021 at 01:08:43PM +0100, Cornelia Huck wrote:
> On Wed, 24 Feb 2021 10:32:00 +0100
> Stefano Garzarella <sgarzare@redhat.com> wrote:
> 
> > On Thu, Feb 18, 2021 at 09:08:23AM +0300, Arseny Krasnov wrote:
> > >Signed-off-by: Arseny Krasnov <arseny.krasnov@kaspersky.com>
> > >---
> > > virtio-vsock.tex | 40 +++++++++++++++++++++++++++++++++++++---
> > > 1 file changed, 37 insertions(+), 3 deletions(-)
> > >
> > >diff --git a/virtio-vsock.tex b/virtio-vsock.tex
> > >index da7e641..1ee8f99 100644
> > >--- a/virtio-vsock.tex
> > >+++ b/virtio-vsock.tex
> > >@@ -102,6 +102,11 @@ \subsection{Device Operation}\label{sec:Device Types / Socket Device / Device Op
> > > 	VIRTIO_VSOCK_OP_CREDIT_UPDATE = 6,
> > > 	/* Request the peer to send the credit info to us */
> > > 	VIRTIO_VSOCK_OP_CREDIT_REQUEST = 7,
> > >+
> > >+	/* Message begin for SOCK_SEQPACKET */
> > >+	VIRTIO_VSOCK_OP_SEQ_BEGIN = 8,
> > >+	/* Message end for SOCK_SEQPACKET */
> > >+	VIRTIO_VSOCK_OP_SEQ_END = 9,
> > > };
> > > \end{lstlisting}
> > >
> > >@@ -140,11 +145,11 @@ \subsubsection{Addressing}\label{sec:Device Types / Socket Device / Device Opera
> > > consists of a (cid, port number) tuple. The header fields used for this are
> > > \field{src_cid}, \field{src_port}, \field{dst_cid}, and \field{dst_port}.
> > >
> > >-Currently only stream sockets are supported. \field{type} is 1 for stream
> > >-socket types.
> > >+Currently stream and seqpacket sockets are supported. \field{type} is 1 for
> > >+stream socket types. \field{type} is 2 for seqpacket socket types.
> > >
> > > Stream sockets provide in-order, guaranteed, connection-oriented delivery
> > >-without message boundaries.
> > >+without message boundaries. Seqpacket sockets also provide message boundaries.
> > >
> > > \subsubsection{Buffer Space Management}\label{sec:Device Types / Socket Device / Device Operation / Buffer Space Management}
> > > \field{buf_alloc} and \field{fwd_cnt} are used for buffer space management of
> > >@@ -240,6 +245,35 @@ \subsubsection{Stream Sockets}\label{sec:Device Types / Socket Device / Device O
> > > destination) address tuple for a new connection while the other peer is still
> > > processing the old connection.
> > >
> > >+\subsubsection{Seqpacket Sockets}\label{sec:Device Types / Socket Device / Device Operation / Seqpacket Sockets}
> > >+
> > >+Seqpacket sockets differ from stream sockets only in data transmission way: in
> > >+stream sockets all data is sent using only VIRTIO_VSOCK_OP_RW packets. In
> > >+seqpacket sockets, to provide message boundaries, every sequence of
> > >+VIRTIO_VSOCK_OP_RW packets of each message is headed with  
> >                                               ^
> > Since this is a spec, I think we should use MUST when something must be 
> > respected by the peer, for example here we can say "MUST be headed"
> > 
> > >+VIRTIO_VSOCK_OP_SEQ_BEGIN and tailed with VIRTIO_VSOCK_OP_SEQ_END packets.
> > >+Both VIRTIO_VSOCK_OP_SEQ_BEGIN and VIRTIO_VSOCK_OP_SEQ_END packets carry  
> >                                                                       ^
> > Same here "MUST carry" and in the rest of the patch.
> 
> Actually, MUST and friends are really for normative sections; I'd
> advise to have a description of how this feature works and then some
> device/driver normative clauses with MUST statements (like "the device
> MUST reject <malformed packets>" or so).

I agree we do want normative sections but please don't add MUST etc elsewhere.
Also vague text saying "malformed" isn't all that helpful if it's a
MUST. How does driver know for sure it's malformed? easy to miss
some requirement.
Therefore easiest thing it just to do some copy-pasting.

E.g. You start with above and add a normative section saying:
Driver MUST use XYZ in VIRTIO_VSOCK_OP_SEQ_END packets.

We typically don't specify behaviour when out of spec,
if we should here then please make a separate chapter
for this explaining the how and the why.

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
