Return-Path: <SRS0=XT4h=JK=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA816C433ED
	for <virtualization@archiver.kernel.org>; Tue, 13 Apr 2021 19:58:57 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57465613C7
	for <virtualization@archiver.kernel.org>; Tue, 13 Apr 2021 19:58:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57465613C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0D2FC84462;
	Tue, 13 Apr 2021 19:58:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id F-eFCpBGLOyE; Tue, 13 Apr 2021 19:58:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6ECAA8445E;
	Tue, 13 Apr 2021 19:58:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 42327C000B;
	Tue, 13 Apr 2021 19:58:55 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 73561C000A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Apr 2021 19:58:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5896440293
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Apr 2021 19:58:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jNb0j-aOPPKU
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Apr 2021 19:58:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C841E4027E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Apr 2021 19:58:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1618343922;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=a9ZF0wtQKhU/DEAaRoxgXOLCyEOXDh3qc9rdcvBbqUs=;
 b=cu1c3v4pYewbsVoA5pdjXTs7m6kZhaXryq+hrqRYZauZl6J6eUB/DsA/nZeAEOwfLEyC4j
 V+1/n+8wduDCufLvw5g77P5G8CkM99DxB+QRnn2JmqTkK54TLaYaftIGP37zzmAhnRbLpT
 PxvbVpQDx/XHrJTcyybGMlU+BQDPsiw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-409-4TNh4xYoNz2FvTgdfy133A-1; Tue, 13 Apr 2021 15:58:39 -0400
X-MC-Unique: 4TNh4xYoNz2FvTgdfy133A-1
Received: by mail-wr1-f71.google.com with SMTP id h16so1062059wrq.5
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Apr 2021 12:58:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=a9ZF0wtQKhU/DEAaRoxgXOLCyEOXDh3qc9rdcvBbqUs=;
 b=Bhoh7DEkNEsR8yUQl562fW4UxmYZh+Y95WZeFbKMyuSQI9JBHaCOCzhxJIQY1nHd29
 I63vog04B9DjqQQptmGRCWlJ9Nc5J2Z+zQdM5QuMmUC8ZIJH/a64aK2CPa+FoeZXD6Wk
 mgGpMeXQNM5PSYCMrHULKsBZe2sV4W2meCUfOjUeH9/c27MeyFv9v/IXVei5gxXyvHU+
 d6pDO1dlXxy0T90KULNVeq4n6b1asntGgbMZIAqmU1Bwat2Z7i0ORZAHjIUJRmMkTCFs
 nWQGE+wuHCH5ST2E26k+DVYO7Yhklw+6v4GpP+8HI8971hmY5QtOCXpv84wKNZk4WJBN
 Uz3Q==
X-Gm-Message-State: AOAM532aEUr4pTQxQZadNh0dXXiyZnj0sRACM8TS0Es3nniYJQPtVVz5
 ZGXVomSQlMCMthrF8+wIM8brD2aeEcBMnV1+EKiZoxMirjMG9PyyN8fcX2H+Cp6DoYoCAI4n3Jj
 r62i/ajnx0Oscpl1LuFkfQolblfM+BK4NjcliU32rqA==
X-Received: by 2002:adf:fccd:: with SMTP id f13mr31527332wrs.222.1618343918367; 
 Tue, 13 Apr 2021 12:58:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzstwsxcoELBf6vVxd/AU57yu4JSNr2UHTKYcqvPHVUtDSS6m4Cv6Bb5s+YBELDwUf472kIvA==
X-Received: by 2002:adf:fccd:: with SMTP id f13mr31527313wrs.222.1618343918130; 
 Tue, 13 Apr 2021 12:58:38 -0700 (PDT)
Received: from redhat.com ([2a10:8006:2281:0:1994:c627:9eac:1825])
 by smtp.gmail.com with ESMTPSA id r2sm7189765wrt.79.2021.04.13.12.58.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Apr 2021 12:58:37 -0700 (PDT)
Date: Tue, 13 Apr 2021 15:58:34 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [RFC v2] virtio-vsock: add description for datagram type
Message-ID: <20210413155635-mutt-send-email-mst@kernel.org>
References: <20210401043602.3510538-1-jiang.wang@bytedance.com>
 <YHRQGSSnkN8Zipy0@stefanha-x1.localdomain>
 <20210412142133.t44pn5pjy6fdcvk4@steredhat>
 <CAP_N_Z9VPkBKX9QD+cuzSSAn6dL0cpQ=EZs5vk+ByjjDpGgdBA@mail.gmail.com>
 <20210413125853.2dkldmp23vkkc74c@steredhat>
 <20210413091251-mutt-send-email-mst@kernel.org>
 <20210413133852.ebkrlbyetiqu4uje@steredhat>
 <20210413094722-mutt-send-email-mst@kernel.org>
 <20210413140351.6vmffxqnj4azpyzx@steredhat>
MIME-Version: 1.0
In-Reply-To: <20210413140351.6vmffxqnj4azpyzx@steredhat>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: cong.wang@bytedance.com, Xiongchun Duan <duanxiongchun@bytedance.com>,
 "Jiang Wang ." <jiang.wang@bytedance.com>, cohuck@redhat.com,
 virtualization@lists.linux-foundation.org, xieyongji@bytedance.com,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Arseny Krasnov <arseny.krasnov@kaspersky.com>, asias@redhat.com
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

On Tue, Apr 13, 2021 at 04:03:51PM +0200, Stefano Garzarella wrote:
> On Tue, Apr 13, 2021 at 09:50:45AM -0400, Michael S. Tsirkin wrote:
> > On Tue, Apr 13, 2021 at 03:38:52PM +0200, Stefano Garzarella wrote:
> > > On Tue, Apr 13, 2021 at 09:16:50AM -0400, Michael S. Tsirkin wrote:
> > > > On Tue, Apr 13, 2021 at 02:58:53PM +0200, Stefano Garzarella wrote:
> > > > > On Mon, Apr 12, 2021 at 03:42:23PM -0700, Jiang Wang . wrote:
> > > > > > On Mon, Apr 12, 2021 at 7:21 AM Stefano Garzarella <sgarzare@redhat.com> wrote:
> > > > > > >
> > > > > > > On Mon, Apr 12, 2021 at 02:50:17PM +0100, Stefan Hajnoczi wrote:
> > > > > > > >On Thu, Apr 01, 2021 at 04:36:02AM +0000, jiang.wang wrote:
> > > > > > > >> Add supports for datagram type for virtio-vsock. Datagram
> > > > > > > >> sockets are connectionless and unreliable. To avoid contention
> > > > > > > >> with stream and other sockets, add two more virtqueues and
> > > > > > > >> a new feature bit to identify if those two new queues exist or not.
> > > > > > > >>
> > > > > > > >> Also add descriptions for resource management of datagram, which
> > > > > > > >> does not use the existing credit update mechanism associated with
> > > > > > > >> stream sockets.
> > > > > > > >>
> > > > > > > >> Signed-off-by: Jiang Wang <jiang.wang@bytedance.com>
> > > > > > > >> ---
> > > > > > > >> V2 addressed the comments for the previous version.
> > > > > > > >>
> > > > > > > >>  virtio-vsock.tex | 62 +++++++++++++++++++++++++++++++++++++++++++++++---------
> > > > > > > >>  1 file changed, 52 insertions(+), 10 deletions(-)
> > > > > > > >>
> > > > > > > >> diff --git a/virtio-vsock.tex b/virtio-vsock.tex
> > > > > > > >> index da7e641..62c12e0 100644
> > > > > > > >> --- a/virtio-vsock.tex
> > > > > > > >> +++ b/virtio-vsock.tex
> > > > > > > >> @@ -11,12 +11,25 @@ \subsection{Virtqueues}\label{sec:Device Types / Socket Device / Virtqueues}
> > > > > > > >>  \begin{description}
> > > > > > > >>  \item[0] rx
> > > > > > > >>  \item[1] tx
> > > > > > > >> +\item[2] datagram rx
> > > > > > > >> +\item[3] datagram tx
> > > > > > > >> +\item[4] event
> > > > > > > >> +\end{description}
> > > > > > > >> +The virtio socket device uses 5 queues if feature bit VIRTIO_VSOCK_F_DRGAM is set. Otherwise, it
> > > > > > > >> +only uses 3 queues, as the following. Rx and tx queues are always used for stream sockets.
> > > > > > > >> +
> > > > > > > >> +\begin{description}
> > > > > > > >> +\item[0] rx
> > > > > > > >> +\item[1] tx
> > > > > > > >>  \item[2] event
> > > > > > > >>  \end{description}
> > > > > > > >>
> > > > > > > >
> > > > > > > >I suggest renaming "rx" and "tx" to "stream rx" and "stream tx"
> > > > > > > >virtqueues and also adding this:
> > > > > > > >
> > > > > > > >  When behavior differs between stream and datagram rx/tx virtqueues
> > > > > > > >  their full names are used. Common behavior is simply described in
> > > > > > > >  terms of rx/tx virtqueues and applies to both stream and datagram
> > > > > > > >  virtqueues.
> > > > > > > >
> > > > > > > >This way you won't need to duplicate portions of the spec that deal with
> > > > > > > >populating the virtqueues, for example.
> > > > > > > >
> > > > > > > >It's also clearer to use a full name for stream rx/tx virtqueues instead
> > > > > > > >of calling them rx/tx virtqueues now that we have datagram rx/tx
> > > > > > > >virtqueues.
> > > > > > > >
> > > > > > > >> +
> > > > > > > >>  \subsection{Feature bits}\label{sec:Device Types / Socket Device / Feature bits}
> > > > > > > >>
> > > > > > > >> -There are currently no feature bits defined for this device.
> > > > > > > >> +\begin{description}
> > > > > > > >> +\item[VIRTIO_VSOCK_F_DGRAM (0)] Device has support for datagram socket type.
> > > > > > > >> +\end{description}
> > > > > > > >>
> > > > > > > >>  \subsection{Device configuration layout}\label{sec:Device Types / Socket Device / Device configuration layout}
> > > > > > > >>
> > > > > > > >> @@ -107,6 +120,9 @@ \subsection{Device Operation}\label{sec:Device Types / Socket Device / Device Op
> > > > > > > >>
> > > > > > > >>  \subsubsection{Virtqueue Flow Control}\label{sec:Device Types / Socket Device / Device Operation / Virtqueue Flow Control}
> > > > > > > >>
> > > > > > > >> +Flow control applies to stream sockets; datagram sockets do not have
> > > > > > > >> +flow control.
> > > > > > > >> +
> > > > > > > >>  The tx virtqueue carries packets initiated by applications and replies to
> > > > > > > >>  received packets.  The rx virtqueue carries packets initiated by the device and
> > > > > > > >>  replies to previously transmitted packets.
> > > > > > > >> @@ -140,12 +156,15 @@ \subsubsection{Addressing}\label{sec:Device Types / Socket Device / Device Opera
> > > > > > > >>  consists of a (cid, port number) tuple. The header fields used for this are
> > > > > > > >>  \field{src_cid}, \field{src_port}, \field{dst_cid}, and \field{dst_port}.
> > > > > > > >>
> > > > > > > >> -Currently only stream sockets are supported. \field{type} is 1 for stream
> > > > > > > >> -socket types.
> > > > > > > >> +Currently stream and datagram (dgram) sockets are supported. \field{type} is 1 for stream
> > > > > > > >> +socket types. \field{type} is 3 for dgram socket types.
> > > > > > > >>
> > > > > > > >>  Stream sockets provide in-order, guaranteed, connection-oriented delivery
> > > > > > > >>  without message boundaries.
> > > > > > > >>
> > > > > > > >> +Datagram sockets provide connectionless unreliable messages of
> > > > > > > >> +a fixed maximum length.
> > > > > > > >
> > > > > > > >Plus unordered (?) and with message boundaries. In other words:
> > > > > > > >
> > > > > > > >  Datagram sockets provide unordered, unreliable, connectionless message
> > > > > > > >  with message boundaries and a fixed maximum length.
> > > > > > > >
> > > > > > > >I didn't think of the fixed maximum length aspect before. I guess the
> > > > > > > >intention is that the rx buffer size is the message size limit? That's
> > > > > > > >different from UDP messages, which can be fragmented into multiple IP
> > > > > > > >packets and can be larger than 64KiB:
> > > > > > > >https://en.wikipedia.org/wiki/User_Datagram_Protocol#UDP_datagram_structure
> > > > > > > >
> > > > > > > >Is it possible to support large datagram messages in vsock? I'm a little
> > > > > > > >concerned that applications that run successfully over UDP will not be
> > > > > > > >portable if vsock has this limitation because it would impose extra
> > > > > > > >message boundaries that the application protocol might not tolerate.
> > > > > > >
> > > > > > > Maybe we can reuse the same approach Arseny is using for SEQPACKET.
> > > > > > > Fragment the packets according to the buffers in the virtqueue and set
> > > > > > > the EOR flag to indicate the last packet in the message.
> > > > > > >
> > > > > > Agree. Another option is to use the ones for skb since we may need to
> > > > > > use skbs for multiple transport support anyway.
> > > > > >
> > > > >
> > > > > The important thing I think is to have a single flag in virtio-vsock that
> > > > > identifies pretty much the same thing: this is the last fragment of a series
> > > > > to rebuild a packet.
> > > > >
> > > > > We should reuse the same flag for DGRAM and SEQPACKET.
> > > > >
> > > > > Thanks,
> > > > > Stefano
> > > >
> > > > Well DGRAM can drop data so I wonder whether it can work ...
> > > >
> > > 
> > > Yep, this is true, but the channel should not be losing packets, so if the
> > > receiver discards packets, it knows that it must then discard all of them
> > > until the EOR.
> > 
> > That is not so easy - they can come mixed up from multiple sources.
> 
> I think we can prevent mixing because virtuqueue is point to point and its
> use is not thread safe, so the access (in the same peer) is already
> serialized.
> In the end the packet would be fragmented only before copying it to the
> virtuqueue.
> 
> But maybe I missed something...

Well I ask what's the point of fragmenting then. I assume it's so we
can pass huge messages around so you can't keep locks ...


> > Sure linux net core does this but with fragmentation added in,
> > I start wondering whether you are beginning to reinvent the net stack
> > ...
> 
> No, I hope not :-), in the end our advantage is that we have a channel that
> doesn't lose packets, so I guess we can make assumptions that the network
> stack can't.
> 
> Thanks,
> Stefano

I still don't know how will credit accounting work for datagram,
but proposals I saw seem to actually lose packets ...

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
