Return-Path: <SRS0=cXtE=IO=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90C03C433DB
	for <virtualization@archiver.kernel.org>; Tue, 16 Mar 2021 08:12:03 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2120964FC2
	for <virtualization@archiver.kernel.org>; Tue, 16 Mar 2021 08:12:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2120964FC2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B9F0383A71;
	Tue, 16 Mar 2021 08:12:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ehz9ryGNzzi4; Tue, 16 Mar 2021 08:12:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5B34C83A5F;
	Tue, 16 Mar 2021 08:12:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2FF48C000C;
	Tue, 16 Mar 2021 08:12:01 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 62BBEC000A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Mar 2021 08:12:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 434FF83A71
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Mar 2021 08:12:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Ajp48m5lV-Hu
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Mar 2021 08:11:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6282A83A5F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Mar 2021 08:11:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1615882318;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2sj4jANEYRlXgrMKwghvAThwqU7XmZ7cBZSjGtCWkWU=;
 b=azcljs9eDcxQ8dz0/fbllvleQUrWQNTLAisNnn8NnNT6FZ+k+elv6hlAk8OxWnuf+yWaKY
 U6iEVEmOB8Nv1q1A+PLYEfxcty5FKx8isqsU8WVOZnRvFMlD2bVmIe+qbo9rLth5yZvi9L
 QN6TxQm9lHGkurfhhvxlPzz5SGHrQpo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-456-ANsDOOQhORy8Li4dLTfRDg-1; Tue, 16 Mar 2021 04:11:54 -0400
X-MC-Unique: ANsDOOQhORy8Li4dLTfRDg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 86DBE107ACCA;
 Tue, 16 Mar 2021 08:11:52 +0000 (UTC)
Received: from gondolin (ovpn-113-185.ams2.redhat.com [10.36.113.185])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 728235C1A1;
 Tue, 16 Mar 2021 08:11:42 +0000 (UTC)
Date: Tue, 16 Mar 2021 09:11:40 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Arseny Krasnov <arseny.krasnov@kaspersky.com>
Subject: Re: [MASSMAIL KLMS] [virtio-comment] Re: [RFC PATCH v1]
 virtio-vsock: use enums instead of hardcoded constants
Message-ID: <20210316091140.51e26cf5.cohuck@redhat.com>
In-Reply-To: <25dbb0d6-9e3d-515c-0a6f-10686b76a31a@kaspersky.com>
References: <20210315083547.2283420-1-arseny.krasnov@kaspersky.com>
 <20210315165350.7377478e.cohuck@redhat.com>
 <25dbb0d6-9e3d-515c-0a6f-10686b76a31a@kaspersky.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=cohuck@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Andra Paraschiv <andraprs@amazon.com>, "Michael
 S. Tsirkin" <mst@redhat.com>, Colin Ian King <colin.king@canonical.com>,
 "oxffffaa@gmail.com" <oxffffaa@gmail.com>,
 Norbert Slusarek <nslusarek@gmx.net>, Stefan Hajnoczi <stefanha@redhat.com>,
 "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
 Jakub Kicinski <kuba@kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>, "David S.
 Miller" <davem@davemloft.net>, Jorgen Hansen <jhansen@vmware.com>
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

On Tue, 16 Mar 2021 06:35:11 +0300
Arseny Krasnov <arseny.krasnov@kaspersky.com> wrote:

> On 15.03.2021 18:53, Cornelia Huck wrote:
> > On Mon, 15 Mar 2021 11:35:41 +0300
> > Arseny Krasnov <arseny.krasnov@kaspersky.com> wrote:
> >  
> >> This replaces constants defined in "bit X set to Y" manner
> >> with enums from Linux kernel uapi headers.
> >> ---
> >>  virtio-vsock.tex | 29 ++++++++++++++++++++++-------
> >>  1 file changed, 22 insertions(+), 7 deletions(-)
> >>
> >> diff --git a/virtio-vsock.tex b/virtio-vsock.tex
> >> index da7e641..a97a81e 100644
> >> --- a/virtio-vsock.tex
> >> +++ b/virtio-vsock.tex
> >> @@ -140,8 +140,14 @@ \subsubsection{Addressing}\label{sec:Device Types / Socket Device / Device Opera
> >>  consists of a (cid, port number) tuple. The header fields used for this are
> >>  \field{src_cid}, \field{src_port}, \field{dst_cid}, and \field{dst_port}.
> >>  
> >> -Currently only stream sockets are supported. \field{type} is 1 for stream
> >> -socket types.
> >> +Currently only stream sockets are supported. \field{type} is one of the
> >> +following constants:
> >> +
> >> +\begin{lstlisting}
> >> +enum virtio_vsock_type {
> >> +	VIRTIO_VSOCK_TYPE_STREAM = 1,
> >> +};
> >> +\end{lstlisting}
> >>  
> >>  Stream sockets provide in-order, guaranteed, connection-oriented delivery
> >>  without message boundaries.
> >> @@ -221,11 +227,20 @@ \subsubsection{Stream Sockets}\label{sec:Device Types / Socket Device / Device O
> >>  a listening socket does not exist on the destination or the destination has
> >>  insufficient resources to establish the connection.
> >>  
> >> -When a connected socket receives VIRTIO_VSOCK_OP_SHUTDOWN the header
> >> -\field{flags} field bit 0 indicates that the peer will not receive any more
> >> -data and bit 1 indicates that the peer will not send any more data.  These
> >> -hints are permanent once sent and successive packets with bits clear do not
> >> -reset them.
> >> +When a connected socket receives VIRTIO_VSOCK_OP_SHUTDOWN, header \field{flags}
> >> +field is one of the following constants:  
> > I don't think these two are required to be mutually exclusive (i.e.
> > both can be indicated at the same time?)  
> 
> I'm not sure, in Linux driver there are several cases when these constants are used
> 
> independently from each over, but I think, this is question to implementation of virtio
> 
> vsock protocol, while this patch is cosmetic for specification.

Yes, even if Linux doesn't use it like that, we allow it in the spec.
What about:

"When a connected socked receives VIRTIO_VSOCK_OP_SHUTDOWN, the header
\field{flags} contains a combination of one or more of the following
constants:"

?

> 
> >  
> >> +
> >> +\begin{lstlisting}
> >> +enum virtio_vsock_shutdown {
> >> +	VIRTIO_VSOCK_SHUTDOWN_RCV = 1,
> >> +	VIRTIO_VSOCK_SHUTDOWN_SEND = 2,
> >> +};
> >> +\end{lstlisting}
> >> +
> >> +VIRTIO_VSOCK_SHUTDOWN_RCV indicates that the peer will not receive any more
> >> +data and VIRTIO_VSOCK_SHUTDOWN_SEND indicates that the peer will not send
> >> +any more data.  These hints are permanent once sent and successive packets
> >> +with bits clear do not reset them.
> >>  
> >>  The VIRTIO_VSOCK_OP_RST packet aborts the connection process or forcibly
> >>  disconnects a connected socket.  

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
